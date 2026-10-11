-- =====================================================================
-- Seller & Products: integrity-constraint tests
--
-- Each test tries to break one business rule and passes only if the
-- DATABASE rejects it. Runs inside a transaction that is rolled back
-- at the end, so it never changes your data. Safe to run on Neon.
--
-- Run:  python db/run_sql.py db/tests/seller_product_constraint_tests.sql
-- Every line should start with PASS. A FAIL stops the script.
-- Blocked deletes: PostgreSQL 18+ (Neon) reports ON DELETE RESTRICT as
-- restrict_violation (23001); older versions as foreign_key_violation
-- (23503). Tests 9 and 10 accept either.
-- =====================================================================

BEGIN;

DO $$
DECLARE
    v_seller   BIGINT;
    v_other    BIGINT;
    v_category BIGINT;
    v_product  BIGINT;
    v_stock    INT;
    v_new      INT;
    v_ts       TIMESTAMP;
BEGIN
    -- test fixtures (rolled back at the end)
    INSERT INTO category (category_name, description)
    VALUES ('__test_category__', 'test') RETURNING category_id INTO v_category;

    INSERT INTO seller (name, email, phone)
    VALUES ('__Test Seller__', '__test_seller__@example.in', '6999999901') RETURNING seller_id INTO v_seller;

    INSERT INTO seller (name, email, phone)
    VALUES ('__Other Seller__', '__other_seller__@example.in', '6999999902') RETURNING seller_id INTO v_other;

    INSERT INTO product (seller_id, category_id, product_name, price, quantity_in_stock, reorder_level)
    VALUES (v_seller, v_category, '__Test Product__', 499.00, 5, 10) RETURNING product_id INTO v_product;

    -- 1. price must be positive
    BEGIN
        INSERT INTO product (seller_id, category_id, product_name, price)
        VALUES (v_seller, v_category, '__Bad Price__', -5);
        RAISE EXCEPTION 'FAIL 1: negative price was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS  1  negative price rejected (CHECK chk_product_price)';
    END;

    -- 2. stock can never go negative (this is what stops overselling)
    BEGIN
        UPDATE product SET quantity_in_stock = quantity_in_stock - 1000 WHERE product_id = v_product;
        RAISE EXCEPTION 'FAIL 2: negative stock was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS  2  stock below 0 rejected (CHECK chk_product_stock)';
    END;

    -- 3. a seller cannot list the same product name twice
    BEGIN
        INSERT INTO product (seller_id, category_id, product_name, price)
        VALUES (v_seller, v_category, '__Test Product__', 100);
        RAISE EXCEPTION 'FAIL 3: duplicate product name was accepted';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'PASS  3  duplicate product name for same seller rejected (UNIQUE)';
    END;

    -- 4. a different seller MAY use the same product name
    INSERT INTO product (seller_id, category_id, product_name, price)
    VALUES (v_other, v_category, '__Test Product__', 100);
    RAISE NOTICE 'PASS  4  another seller can use the same product name';

    -- 5. product must belong to an existing seller
    BEGIN
        INSERT INTO product (seller_id, category_id, product_name, price)
        VALUES (-1, v_category, '__Orphan__', 100);
        RAISE EXCEPTION 'FAIL 5: product with unknown seller was accepted';
    EXCEPTION WHEN foreign_key_violation THEN
        RAISE NOTICE 'PASS  5  product with unknown seller rejected (FK)';
    END;

    -- 6. invalid phone number
    BEGIN
        INSERT INTO seller (name, email, phone) VALUES ('X', '__x__@example.in', '12345');
        RAISE EXCEPTION 'FAIL 6: invalid phone was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS  6  invalid phone (5 digits) rejected (CHECK chk_seller_phone)';
    END;

    -- 7. duplicate seller email
    BEGIN
        INSERT INTO seller (name, email, phone) VALUES ('X', '__test_seller__@example.in', '6999999903');
        RAISE EXCEPTION 'FAIL 7: duplicate email was accepted';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'PASS  7  duplicate seller email rejected (UNIQUE)';
    END;

    -- 8. invalid email format
    BEGIN
        INSERT INTO seller (name, email, phone) VALUES ('X', 'not-an-email', '6999999904');
        RAISE EXCEPTION 'FAIL 8: invalid email was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS  8  invalid email rejected (CHECK chk_seller_email)';
    END;

    -- 9. a seller who still has products cannot be deleted
    BEGIN
        DELETE FROM seller WHERE seller_id = v_seller;
        RAISE EXCEPTION 'FAIL 9: seller with products was deleted';
    EXCEPTION WHEN foreign_key_violation OR restrict_violation THEN
        RAISE NOTICE 'PASS  9  seller with products cannot be deleted (FK RESTRICT)';
    END;

    -- 10. a category that is in use cannot be deleted
    BEGIN
        DELETE FROM category WHERE category_id = v_category;
        RAISE EXCEPTION 'FAIL 10: category in use was deleted';
    EXCEPTION WHEN foreign_key_violation OR restrict_violation THEN
        RAISE NOTICE 'PASS 10  category in use cannot be deleted (FK RESTRICT)';
    END;

    -- 11. trigger sets last_updated on every update
    UPDATE product SET last_updated = TIMESTAMP '2000-01-01' WHERE product_id = v_product;
    SELECT last_updated INTO v_ts FROM product WHERE product_id = v_product;
    IF v_ts < CURRENT_TIMESTAMP - INTERVAL '1 minute' THEN
        RAISE EXCEPTION 'FAIL 11: trigger did not set last_updated';
    END IF;
    RAISE NOTICE 'PASS 11  trigger trg_product_touch sets last_updated';

    -- 12. view lists the product while it is low on stock (5 <= 10)
    IF NOT EXISTS (SELECT 1 FROM v_low_stock_products WHERE product_id = v_product) THEN
        RAISE EXCEPTION 'FAIL 12: low-stock product missing from view';
    END IF;
    RAISE NOTICE 'PASS 12  view v_low_stock_products shows the low-stock product';

    -- 13. restock own product
    SELECT quantity_in_stock INTO v_stock FROM product WHERE product_id = v_product;
    v_new := restock_product(v_seller, v_product, 20);
    IF v_new <> v_stock + 20 THEN
        RAISE EXCEPTION 'FAIL 13: restock returned %, expected %', v_new, v_stock + 20;
    END IF;
    RAISE NOTICE 'PASS 13  restock_product added 20 units (% -> %)', v_stock, v_new;

    -- 14. after restocking it is no longer low on stock
    IF EXISTS (SELECT 1 FROM v_low_stock_products WHERE product_id = v_product) THEN
        RAISE EXCEPTION 'FAIL 14: restocked product still in low-stock view';
    END IF;
    RAISE NOTICE 'PASS 14  restocked product left the low-stock view';

    -- 15. cannot restock another seller's product
    BEGIN
        PERFORM restock_product(v_other, v_product, 5);
        RAISE EXCEPTION 'FAIL 15: restocked another seller''s product';
    EXCEPTION WHEN insufficient_privilege THEN
        RAISE NOTICE 'PASS 15  restock of another seller''s product rejected';
    END;

    -- 16. restock quantity must be positive
    BEGIN
        PERFORM restock_product(v_seller, v_product, 0);
        RAISE EXCEPTION 'FAIL 16: restock of 0 accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS 16  restock quantity 0 rejected';
    END;

    -- 17. delisting hides the product from the low-stock view
    UPDATE product SET quantity_in_stock = 0, is_active = FALSE WHERE product_id = v_product;
    IF EXISTS (SELECT 1 FROM v_low_stock_products WHERE product_id = v_product) THEN
        RAISE EXCEPTION 'FAIL 17: delisted product still in view';
    END IF;
    RAISE NOTICE 'PASS 17  delisted product is hidden from the low-stock view';

    RAISE NOTICE 'ALL 17 TESTS PASSED';
END
$$;

ROLLBACK;   -- undo every test row
