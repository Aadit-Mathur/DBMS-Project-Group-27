--
-- PostgreSQL database dump
--

-- Dumped from database version 18.7 (a21afb5)
-- Dumped by pg_dump version 18.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: advance_shipment(bigint, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.advance_shipment(p_order_id bigint, p_new_status character varying, p_carrier character varying DEFAULT NULL::character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_status text;
    v_ship   bigint;
BEGIN
    SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    SELECT shipment_id INTO v_ship FROM shipment WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % has no shipment yet (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    IF p_new_status = 'Shipped' THEN
        UPDATE shipment
        SET    shipment_status = 'Shipped', shipment_date = LOCALTIMESTAMP,
               carrier = COALESCE(p_carrier, carrier, 'Standard Courier'),
               tracking_number = 'TRK' || lpad(v_ship::text, 9, '0')
        WHERE  shipment_id = v_ship;
        UPDATE orders SET order_status = 'Shipped' WHERE order_id = p_order_id;
    ELSIF p_new_status = 'In Transit' THEN
        UPDATE shipment SET shipment_status = 'In Transit' WHERE shipment_id = v_ship;
    ELSIF p_new_status = 'Delivered' THEN
        UPDATE shipment SET shipment_status = 'Delivered', delivery_date = LOCALTIMESTAMP
        WHERE  shipment_id = v_ship;
        UPDATE orders SET order_status = 'Delivered' WHERE order_id = p_order_id;
    ELSE
        RAISE EXCEPTION 'Shipment status must be Shipped, In Transit or Delivered (got %)', p_new_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN p_new_status;
END $$;


--
-- Name: begin_payment(bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.begin_payment(p_order_id bigint, p_customer_id bigint DEFAULT NULL::bigint, p_method character varying DEFAULT NULL::character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_status   text;
    v_customer bigint;
    v_pstatus  text;
    v_amount   numeric;
BEGIN
    SELECT order_status, customer_id INTO v_status, v_customer
    FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF p_customer_id IS NOT NULL AND v_customer <> p_customer_id THEN
        RAISE EXCEPTION 'Order % does not belong to customer %', p_order_id, p_customer_id
            USING ERRCODE = 'ORD09';
    END IF;
    IF v_status <> 'Pending' THEN
        RAISE EXCEPTION 'Order % cannot be paid (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    SELECT payment_status, amount INTO v_pstatus, v_amount
    FROM payment WHERE order_id = p_order_id FOR UPDATE;
    IF v_pstatus NOT IN ('Pending', 'Failed') THEN
        RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
    END IF;

    IF p_method IS NOT NULL THEN
        IF p_method NOT IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet') THEN
            RAISE EXCEPTION 'Unsupported payment method: %', p_method USING ERRCODE = 'ORD03';
        END IF;
        UPDATE payment SET payment_method = p_method WHERE order_id = p_order_id;
    END IF;
    RETURN v_amount;
END $$;


--
-- Name: cancel_order(bigint, bigint, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cancel_order(p_order_id bigint, p_customer_id bigint DEFAULT NULL::bigint, p_reason text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_status   text;
    v_customer bigint;
    v_pstatus  text;
    v_result   text := 'CANCELLED';
BEGIN
    SELECT order_status, customer_id INTO v_status, v_customer
    FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF p_customer_id IS NOT NULL AND v_customer <> p_customer_id THEN
        RAISE EXCEPTION 'Order % does not belong to customer %', p_order_id, p_customer_id
            USING ERRCODE = 'ORD09';
    END IF;
    IF v_status NOT IN ('Pending', 'Confirmed') THEN
        RAISE EXCEPTION 'Order % cannot be cancelled (status %)', p_order_id, v_status
            USING ERRCODE = 'ORD11';
    END IF;

    PERFORM set_config('app.event_note', COALESCE(left(p_reason, 200), 'Cancelled by customer'), true);

    -- give the stock back; products locked in id order (no deadlock between two cancels)
    PERFORM 1 FROM product
    WHERE  product_id IN (SELECT product_id FROM order_item WHERE order_id = p_order_id)
    ORDER  BY product_id FOR UPDATE;
    UPDATE product p
    SET    quantity_in_stock = p.quantity_in_stock + oi.qty
    FROM  (SELECT product_id, SUM(quantity) AS qty FROM order_item
           WHERE order_id = p_order_id GROUP BY product_id) oi
    WHERE  p.product_id = oi.product_id;

    UPDATE orders SET order_status = 'Cancelled', cancelled_at = LOCALTIMESTAMP,
                      cancel_reason = left(p_reason, 200)
    WHERE  order_id = p_order_id;

    SELECT payment_status INTO v_pstatus FROM payment WHERE order_id = p_order_id FOR UPDATE;
    IF v_pstatus = 'Successful' THEN
        UPDATE payment SET payment_status = 'Refunded', refunded_at = LOCALTIMESTAMP
        WHERE order_id = p_order_id;
        v_result := 'CANCELLED_REFUNDED';
    ELSIF v_pstatus = 'Pending' THEN
        UPDATE payment SET payment_status = 'Failed', failure_reason = 'Order cancelled before payment'
        WHERE order_id = p_order_id;
    END IF;

    UPDATE shipment SET shipment_status = 'Cancelled'
    WHERE  order_id = p_order_id AND shipment_status = 'Pending';

    PERFORM set_config('app.event_note', '', true);      -- the note must not leak into later events
    RETURN v_result;
END $$;


--
-- Name: expire_unpaid_orders(interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.expire_unpaid_orders(p_older_than interval DEFAULT '00:30:00'::interval) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    r record;
    n integer := 0;
BEGIN
    FOR r IN SELECT order_id FROM orders
             WHERE order_status = 'Pending' AND order_date < LOCALTIMESTAMP - p_older_than
             ORDER BY order_id FOR UPDATE SKIP LOCKED
    LOOP
        PERFORM cancel_order(r.order_id, NULL, 'Payment not received in time');
        n := n + 1;
    END LOOP;
    RETURN n;
END $$;


--
-- Name: fn_order_event(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_order_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_note   text := NULLIF(current_setting('app.event_note', true), '');
    v_type   text;
BEGIN
    IF TG_TABLE_NAME = 'orders' THEN
        IF TG_OP = 'INSERT' THEN
            v_type := 'Order Pending'; v_note := COALESCE(v_note, 'Order placed');
        ELSIF NEW.order_status <> OLD.order_status THEN
            v_type := 'Order ' || NEW.order_status;
        END IF;
    ELSIF TG_TABLE_NAME = 'payment' THEN
        IF TG_OP = 'UPDATE' AND (NEW.payment_status <> OLD.payment_status
                                 OR NEW.attempts <> OLD.attempts) THEN
            v_type := 'Payment ' || NEW.payment_status;
            IF NEW.payment_status = 'Failed' THEN v_note := COALESCE(NEW.failure_reason, v_note); END IF;
        END IF;
    ELSE  -- shipment
        IF TG_OP = 'INSERT' THEN
            v_type := 'Shipment ' || NEW.shipment_status;
        ELSIF NEW.shipment_status <> OLD.shipment_status THEN
            v_type := 'Shipment ' || NEW.shipment_status;
        END IF;
    END IF;

    IF v_type IS NOT NULL THEN
        INSERT INTO order_event (order_id, event_time, event_type, detail)
        VALUES (NEW.order_id, clock_timestamp()::timestamp, v_type, left(v_note, 200));
    END IF;
    RETURN NULL;
END $$;


--
-- Name: fn_order_item_frozen(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_order_item_frozen() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE v_status text;
BEGIN
    IF TG_OP = 'INSERT' THEN
        SELECT order_status INTO v_status FROM orders WHERE order_id = NEW.order_id;
        IF v_status IS DISTINCT FROM 'Pending' THEN
            RAISE EXCEPTION 'Cannot add items to order % (status %)', NEW.order_id, v_status
                USING ERRCODE = 'ORD12';
        END IF;
        RETURN NEW;
    END IF;
    RAISE EXCEPTION 'Order lines cannot be changed or removed once placed (order %)', OLD.order_id
        USING ERRCODE = 'ORD12';
END $$;


--
-- Name: fn_order_item_total(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_order_item_total() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE v_order bigint := COALESCE(NEW.order_id, OLD.order_id);
BEGIN
    UPDATE orders
    SET    total_amount = (SELECT COALESCE(SUM(subtotal), 0) FROM order_item WHERE order_id = v_order)
    WHERE  order_id = v_order;
    RETURN NULL;
END $$;


--
-- Name: fn_orders_guard(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_orders_guard() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.customer_id <> OLD.customer_id OR NEW.address_id <> OLD.address_id THEN
        RAISE EXCEPTION 'The customer and delivery address of order % cannot be changed', OLD.order_id
            USING ERRCODE = 'ORD13';
    END IF;
    -- depth 1 = a direct UPDATE; depth 2 = the order_item trigger doing its job
    IF NEW.total_amount <> OLD.total_amount AND pg_trigger_depth() < 2 THEN
        RAISE EXCEPTION 'total_amount is maintained from the order lines and cannot be edited'
            USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.order_status <> OLD.order_status
       AND (OLD.order_status, NEW.order_status) NOT IN
           (('Pending', 'Confirmed'), ('Pending', 'Cancelled'), ('Confirmed', 'Shipped'),
            ('Confirmed', 'Cancelled'), ('Shipped', 'Delivered')) THEN
        RAISE EXCEPTION 'Order % cannot go from % to %', OLD.order_id, OLD.order_status, NEW.order_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;


--
-- Name: fn_payment_flow(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_payment_flow() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.order_id <> OLD.order_id THEN
        RAISE EXCEPTION 'A payment cannot be moved to another order' USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.payment_status <> OLD.payment_status
       AND (OLD.payment_status, NEW.payment_status) NOT IN
           (('Pending', 'Successful'), ('Pending', 'Failed'), ('Failed', 'Successful'),
            ('Successful', 'Refunded')) THEN
        RAISE EXCEPTION 'Payment for order % cannot go from % to %',
                        OLD.order_id, OLD.payment_status, NEW.payment_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;


--
-- Name: fn_product_touch(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_product_touch() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_updated := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


--
-- Name: fn_shipment_flow(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_shipment_flow() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.order_id <> OLD.order_id THEN
        RAISE EXCEPTION 'A shipment cannot be moved to another order' USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.shipment_status <> OLD.shipment_status
       AND (OLD.shipment_status, NEW.shipment_status) NOT IN
           (('Pending', 'Shipped'), ('Pending', 'Cancelled'), ('Shipped', 'In Transit'),
            ('Shipped', 'Delivered'), ('In Transit', 'Delivered')) THEN
        RAISE EXCEPTION 'Shipment for order % cannot go from % to %',
                        OLD.order_id, OLD.shipment_status, NEW.shipment_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;


--
-- Name: place_order(bigint, bigint, jsonb, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.place_order(p_customer_id bigint, p_address_id bigint, p_items jsonb, p_method character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_order_id bigint;
    v_line     record;
    v_price    numeric;
    v_stock    integer;
    v_active   boolean;
    v_total    numeric;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = p_customer_id) THEN
        RAISE EXCEPTION 'Customer % not found', p_customer_id USING ERRCODE = 'ORD01';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM address WHERE address_id = p_address_id AND customer_id = p_customer_id) THEN
        RAISE EXCEPTION 'Address % does not belong to customer %', p_address_id, p_customer_id
            USING ERRCODE = 'ORD02';
    END IF;
    IF p_items IS NULL OR jsonb_typeof(p_items) <> 'array' OR jsonb_array_length(p_items) = 0 THEN
        RAISE EXCEPTION 'An order needs at least one item' USING ERRCODE = 'ORD03';
    END IF;
    IF p_method IS NULL OR p_method NOT IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet') THEN
        RAISE EXCEPTION 'Unsupported payment method: %', COALESCE(p_method, 'NULL') USING ERRCODE = 'ORD03';
    END IF;

    INSERT INTO orders (customer_id, address_id) VALUES (p_customer_id, p_address_id)
    RETURNING order_id INTO v_order_id;

    FOR v_line IN
        SELECT product_id, SUM(quantity)::int AS quantity            -- same product listed twice = one line
        FROM  (SELECT (e->>'product_id')::bigint AS product_id, (e->>'quantity')::int AS quantity
               FROM jsonb_array_elements(p_items) AS e) x
        GROUP BY product_id
        ORDER BY product_id
    LOOP
        IF v_line.product_id IS NULL OR v_line.quantity IS NULL OR v_line.quantity <= 0 THEN
            RAISE EXCEPTION 'Each item needs a product_id and a quantity greater than 0'
                USING ERRCODE = 'ORD03';
        END IF;

        SELECT price, quantity_in_stock, is_active INTO v_price, v_stock, v_active
        FROM   product WHERE product_id = v_line.product_id FOR UPDATE;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Product % not found', v_line.product_id USING ERRCODE = 'ORD04';
        END IF;
        IF NOT v_active THEN
            RAISE EXCEPTION 'Product % is no longer available', v_line.product_id USING ERRCODE = 'ORD05';
        END IF;
        IF v_stock < v_line.quantity THEN
            RAISE EXCEPTION 'Only % unit(s) of product % in stock (requested %)',
                            v_stock, v_line.product_id, v_line.quantity USING ERRCODE = 'ORD06';
        END IF;

        INSERT INTO order_item (order_id, product_id, quantity, unit_price)       -- subtotal is GENERATED
        VALUES (v_order_id, v_line.product_id, v_line.quantity, v_price);
        UPDATE product SET quantity_in_stock = quantity_in_stock - v_line.quantity
        WHERE  product_id = v_line.product_id;
    END LOOP;

    SELECT total_amount INTO v_total FROM orders WHERE order_id = v_order_id;   -- kept by trigger 4a
    INSERT INTO payment (order_id, payment_method, amount) VALUES (v_order_id, p_method, v_total);
    RETURN v_order_id;
END $$;


--
-- Name: record_payment(bigint, boolean, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.record_payment(p_order_id bigint, p_success boolean, p_transaction_ref text, p_failure_reason text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE v_status text;
BEGIN
    SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF v_status <> 'Pending' THEN
        RAISE EXCEPTION 'Order % cannot be paid (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    IF p_success THEN
        UPDATE payment
        SET    payment_status = 'Successful', payment_date = LOCALTIMESTAMP,
               transaction_ref = p_transaction_ref, failure_reason = NULL, attempts = attempts + 1
        WHERE  order_id = p_order_id AND payment_status IN ('Pending', 'Failed');
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
        END IF;
        UPDATE orders SET order_status = 'Confirmed' WHERE order_id = p_order_id;
        INSERT INTO shipment (order_id) VALUES (p_order_id) ON CONFLICT (order_id) DO NOTHING;
        RETURN 'Successful';
    END IF;

    UPDATE payment
    SET    payment_status = 'Failed', failure_reason = left(COALESCE(p_failure_reason, 'Payment declined'), 200),
           attempts = attempts + 1
    WHERE  order_id = p_order_id AND payment_status IN ('Pending', 'Failed');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
    END IF;
    RETURN 'Failed';
END $$;


--
-- Name: restock_product(bigint, bigint, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.restock_product(p_seller_id bigint, p_product_id bigint, p_qty integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_new_stock INT;
BEGIN
    IF p_qty IS NULL OR p_qty <= 0 THEN
        RAISE EXCEPTION 'Restock quantity must be positive (got %)', p_qty
            USING ERRCODE = 'check_violation';
    END IF;

    UPDATE product
    SET    quantity_in_stock = quantity_in_stock + p_qty
    WHERE  product_id = p_product_id
      AND  seller_id  = p_seller_id
    RETURNING quantity_in_stock INTO v_new_stock;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product % does not belong to seller %', p_product_id, p_seller_id
            USING ERRCODE = 'insufficient_privilege';
    END IF;

    RETURN v_new_stock;
END;
$$;


SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.address (
    address_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    address_type character varying(30) NOT NULL,
    house_no character varying(50) NOT NULL,
    street character varying(150) NOT NULL,
    locality character varying(150) NOT NULL,
    city character varying(100) NOT NULL,
    district character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    pin_code character(6) NOT NULL,
    CONSTRAINT chk_address_pin CHECK ((pin_code ~ '^[0-9]{6}$'::text))
);


--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.address_address_id_seq OWNED BY public.address.address_id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    category_id bigint NOT NULL,
    category_name character varying(100) NOT NULL,
    description text
);


--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    customer_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(15) NOT NULL,
    registration_date date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT chk_customer_email CHECK (((email)::text ~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'::text)),
    CONSTRAINT chk_customer_phone CHECK (((phone)::text ~ '^[0-9]{10,15}$'::text))
);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- Name: order_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_event (
    event_id bigint NOT NULL,
    order_id bigint NOT NULL,
    event_time timestamp without time zone DEFAULT LOCALTIMESTAMP NOT NULL,
    event_type character varying(40) NOT NULL,
    detail character varying(200)
);


--
-- Name: order_event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.order_event ALTER COLUMN event_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.order_event_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_fn_backup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_fn_backup (
    backup_id bigint NOT NULL,
    backed_up_at timestamp without time zone DEFAULT LOCALTIMESTAMP NOT NULL,
    function_signature text NOT NULL,
    definition text NOT NULL
);


--
-- Name: order_fn_backup_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.order_fn_backup ALTER COLUMN backup_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.order_fn_backup_backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_item (
    order_item_id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    subtotal numeric(12,2) GENERATED ALWAYS AS (((quantity)::numeric * unit_price)) STORED,
    CONSTRAINT chk_order_item_quantity CHECK ((quantity > 0)),
    CONSTRAINT chk_order_item_unit_price CHECK ((unit_price >= (0)::numeric))
);


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_item_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_item_order_item_id_seq OWNED BY public.order_item.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    order_status character varying(30) DEFAULT 'Pending'::character varying NOT NULL,
    total_amount numeric(12,2) DEFAULT 0 NOT NULL,
    address_id bigint NOT NULL,
    cancelled_at timestamp without time zone,
    cancel_reason character varying(200),
    CONSTRAINT chk_order_cancelled CHECK ((((order_status)::text = 'Cancelled'::text) = (cancelled_at IS NOT NULL))),
    CONSTRAINT chk_order_status CHECK (((order_status)::text = ANY ((ARRAY['Pending'::character varying, 'Confirmed'::character varying, 'Shipped'::character varying, 'Delivered'::character varying, 'Cancelled'::character varying])::text[]))),
    CONSTRAINT chk_order_total CHECK ((total_amount >= (0)::numeric))
);


--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    payment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    payment_date timestamp without time zone,
    payment_method character varying(50) NOT NULL,
    payment_status character varying(30) DEFAULT 'Pending'::character varying NOT NULL,
    amount numeric(12,2) NOT NULL,
    transaction_ref character varying(100),
    refund_ref character varying(100),
    refunded_at timestamp without time zone,
    failure_reason character varying(200),
    attempts integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_payment_amount CHECK ((amount >= (0)::numeric)),
    CONSTRAINT chk_payment_attempts CHECK ((attempts >= 0)),
    CONSTRAINT chk_payment_dates CHECK (((((payment_status)::text = ANY ((ARRAY['Successful'::character varying, 'Refunded'::character varying])::text[])) = (payment_date IS NOT NULL)) AND (((payment_status)::text = 'Refunded'::text) = (refunded_at IS NOT NULL)))),
    CONSTRAINT chk_payment_method CHECK (((payment_method)::text = ANY ((ARRAY['UPI'::character varying, 'Credit Card'::character varying, 'Debit Card'::character varying, 'Net Banking'::character varying, 'Wallet'::character varying])::text[]))),
    CONSTRAINT chk_payment_status CHECK (((payment_status)::text = ANY ((ARRAY['Pending'::character varying, 'Successful'::character varying, 'Failed'::character varying, 'Refunded'::character varying])::text[])))
);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    product_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    category_id bigint NOT NULL,
    product_name character varying(200) NOT NULL,
    description text,
    brand character varying(100),
    price numeric(12,2) NOT NULL,
    quantity_in_stock integer DEFAULT 0 NOT NULL,
    reorder_level integer DEFAULT 10 NOT NULL,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_product_price CHECK ((price >= (0)::numeric)),
    CONSTRAINT chk_product_reorder_level CHECK ((reorder_level >= 0)),
    CONSTRAINT chk_product_stock CHECK ((quantity_in_stock >= 0))
);


--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- Name: seller; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seller (
    seller_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(15) NOT NULL,
    registration_date date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT chk_seller_email CHECK (((email)::text ~~ '%_@_%._%'::text)),
    CONSTRAINT chk_seller_phone CHECK (((phone)::text ~ '^[0-9]{10,15}$'::text))
);


--
-- Name: seller_seller_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seller_seller_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seller_seller_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seller_seller_id_seq OWNED BY public.seller.seller_id;


--
-- Name: shipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipment (
    shipment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    shipment_date timestamp without time zone,
    delivery_date timestamp without time zone,
    shipment_status character varying(30) DEFAULT 'Pending'::character varying NOT NULL,
    carrier character varying(50),
    tracking_number character varying(40),
    CONSTRAINT chk_delivery_date CHECK (((delivery_date IS NULL) OR (shipment_date IS NULL) OR (delivery_date >= shipment_date))),
    CONSTRAINT chk_shipment_delivered CHECK ((((shipment_status)::text = 'Delivered'::text) = (delivery_date IS NOT NULL))),
    CONSTRAINT chk_shipment_dispatched CHECK ((((shipment_status)::text <> ALL ((ARRAY['Shipped'::character varying, 'In Transit'::character varying, 'Delivered'::character varying])::text[])) OR ((shipment_date IS NOT NULL) AND (tracking_number IS NOT NULL)))),
    CONSTRAINT chk_shipment_status CHECK (((shipment_status)::text = ANY ((ARRAY['Pending'::character varying, 'Shipped'::character varying, 'In Transit'::character varying, 'Delivered'::character varying, 'Cancelled'::character varying])::text[])))
);


--
-- Name: shipment_shipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shipment_shipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipment_shipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shipment_shipment_id_seq OWNED BY public.shipment.shipment_id;


--
-- Name: v_low_stock_products; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_low_stock_products AS
 SELECT p.product_id,
    p.product_name,
    s.seller_id,
    s.name AS seller_name,
    c.category_name,
    p.quantity_in_stock,
    p.reorder_level,
    (p.reorder_level - p.quantity_in_stock) AS shortfall
   FROM ((public.product p
     JOIN public.seller s ON ((s.seller_id = p.seller_id)))
     JOIN public.category c ON ((c.category_id = p.category_id)))
  WHERE (p.is_active AND (p.quantity_in_stock <= p.reorder_level));


--
-- Name: v_order_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_order_summary AS
 SELECT o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    ( SELECT (count(*))::integer AS count
           FROM public.order_item oi
          WHERE (oi.order_id = o.order_id)) AS item_count,
    p.payment_status,
    p.payment_method,
    s.shipment_status,
    s.tracking_number
   FROM ((public.orders o
     LEFT JOIN public.payment p ON ((p.order_id = o.order_id)))
     LEFT JOIN public.shipment s ON ((s.order_id = o.order_id)));


--
-- Name: v_paid_orders; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_paid_orders AS
 SELECT o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    p.payment_id,
    p.payment_method,
    p.payment_date,
    p.amount AS paid_amount
   FROM (public.orders o
     JOIN public.payment p ON ((p.order_id = o.order_id)))
  WHERE ((p.payment_status)::text = 'Successful'::text);


--
-- Name: address address_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_address_id_seq'::regclass);


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- Name: order_item order_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_item_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- Name: seller seller_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seller ALTER COLUMN seller_id SET DEFAULT nextval('public.seller_seller_id_seq'::regclass);


--
-- Name: shipment shipment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment ALTER COLUMN shipment_id SET DEFAULT nextval('public.shipment_shipment_id_seq'::regclass);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- Name: category category_category_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_category_name_key UNIQUE (category_name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: customer customer_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_email_key UNIQUE (email);


--
-- Name: customer customer_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_phone_key UNIQUE (phone);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: order_event order_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_event
    ADD CONSTRAINT order_event_pkey PRIMARY KEY (event_id);


--
-- Name: order_fn_backup order_fn_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_fn_backup
    ADD CONSTRAINT order_fn_backup_pkey PRIMARY KEY (backup_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payment payment_order_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_key UNIQUE (order_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: seller seller_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_email_key UNIQUE (email);


--
-- Name: seller seller_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_phone_key UNIQUE (phone);


--
-- Name: seller seller_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_pkey PRIMARY KEY (seller_id);


--
-- Name: shipment shipment_order_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_order_id_key UNIQUE (order_id);


--
-- Name: shipment shipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);


--
-- Name: address uq_address_id_customer; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT uq_address_id_customer UNIQUE (address_id, customer_id);


--
-- Name: product uq_product_seller_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT uq_product_seller_name UNIQUE (seller_id, product_name);


--
-- Name: idx_order_event_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_event_order ON public.order_event USING btree (order_id, event_time, event_id);


--
-- Name: idx_order_item_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_item_order ON public.order_item USING btree (order_id);


--
-- Name: idx_order_item_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_item_product ON public.order_item USING btree (product_id);


--
-- Name: idx_orders_customer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_customer ON public.orders USING btree (customer_id);


--
-- Name: idx_orders_pending; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_pending ON public.orders USING btree (order_date) WHERE ((order_status)::text = 'Pending'::text);


--
-- Name: idx_payment_successful; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payment_successful ON public.payment USING btree (payment_date) WHERE ((payment_status)::text = 'Successful'::text);


--
-- Name: idx_product_category_price; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_product_category_price ON public.product USING btree (category_id, price);


--
-- Name: idx_product_low_stock; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_product_low_stock ON public.product USING btree (seller_id) WHERE (is_active AND (quantity_in_stock <= reorder_level));


--
-- Name: uq_shipment_tracking; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_shipment_tracking ON public.shipment USING btree (tracking_number) WHERE (tracking_number IS NOT NULL);


--
-- Name: order_item trg_order_item_frozen; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_order_item_frozen BEFORE INSERT OR DELETE OR UPDATE ON public.order_item FOR EACH ROW EXECUTE FUNCTION public.fn_order_item_frozen();


--
-- Name: order_item trg_order_item_total; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_order_item_total AFTER INSERT OR DELETE OR UPDATE ON public.order_item FOR EACH ROW EXECUTE FUNCTION public.fn_order_item_total();


--
-- Name: orders trg_orders_event; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_orders_event AFTER INSERT OR UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.fn_order_event();


--
-- Name: orders trg_orders_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_orders_guard BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.fn_orders_guard();


--
-- Name: payment trg_payment_event; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_payment_event AFTER INSERT OR UPDATE ON public.payment FOR EACH ROW EXECUTE FUNCTION public.fn_order_event();


--
-- Name: payment trg_payment_flow; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_payment_flow BEFORE UPDATE ON public.payment FOR EACH ROW EXECUTE FUNCTION public.fn_payment_flow();


--
-- Name: product trg_product_touch; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_product_touch BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.fn_product_touch();


--
-- Name: shipment trg_shipment_event; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_shipment_event AFTER INSERT OR UPDATE ON public.shipment FOR EACH ROW EXECUTE FUNCTION public.fn_order_event();


--
-- Name: shipment trg_shipment_flow; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_shipment_flow BEFORE UPDATE ON public.shipment FOR EACH ROW EXECUTE FUNCTION public.fn_shipment_flow();


--
-- Name: address fk_address_customer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT fk_address_customer FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE RESTRICT;


--
-- Name: orders fk_order_address; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_address FOREIGN KEY (address_id, customer_id) REFERENCES public.address(address_id, customer_id) ON DELETE RESTRICT;


--
-- Name: orders fk_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE RESTRICT;


--
-- Name: order_event fk_order_event_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_event
    ADD CONSTRAINT fk_order_event_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE RESTRICT;


--
-- Name: order_item fk_order_item_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE RESTRICT;


--
-- Name: order_item fk_order_item_product; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE RESTRICT;


--
-- Name: payment fk_payment_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE RESTRICT;


--
-- Name: product fk_product_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON DELETE RESTRICT;


--
-- Name: product fk_product_seller; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_seller FOREIGN KEY (seller_id) REFERENCES public.seller(seller_id) ON DELETE RESTRICT;


--
-- Name: shipment fk_shipment_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT fk_shipment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--


