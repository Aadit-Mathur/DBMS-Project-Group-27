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
SET search_path = public;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer (customer_id, name, email, phone, registration_date) FROM stdin;
1	Kartikeya Jain	customer0001@example.in	7000000000	2025-12-11
2	Megha Pande	customer0002@example.in	7000000001	2024-04-22
3	Subodh Kar	customer0003@example.in	7000000002	2024-01-29
4	Kartikeya Sharma	customer0004@example.in	7000000003	2026-06-07
5	Bala Reddy	customer0005@example.in	7000000004	2026-06-18
6	Nilesh Mohan	customer0006@example.in	7000000005	2024-01-05
7	Jayant Chopra	customer0007@example.in	7000000006	2024-01-19
8	Jeevan Gokhale	customer0008@example.in	7000000007	2024-10-07
9	Maithili Sarkar	customer0009@example.in	7000000008	2024-08-22
10	Gagan Sen	customer0010@example.in	7000000009	2025-11-08
11	Akhil Mehta	customer0011@example.in	7000000010	2026-01-08
12	Karan Pandit	customer0012@example.in	7000000011	2024-06-05
13	Karishma Kumar	customer0013@example.in	7000000012	2026-04-10
14	Karan Hegde	customer0014@example.in	7000000013	2026-09-08
15	Archana Raghavendra	customer0015@example.in	7000000014	2025-05-25
16	Pari Kadam	customer0016@example.in	7000000015	2024-05-12
17	Vinod Saini	customer0017@example.in	7000000016	2025-06-24
18	Vimal Chakraborty	customer0018@example.in	7000000017	2025-05-08
19	Ram Solanki	customer0019@example.in	7000000018	2023-12-31
20	Ramya Ganguly	customer0020@example.in	7000000019	2025-02-22
21	Durga Raghavan	customer0021@example.in	7000000020	2026-05-05
22	Bhavana Nambiar	customer0022@example.in	7000000021	2026-02-15
23	Harleen Purohit	customer0023@example.in	7000000022	2026-02-08
24	Inder Jain	customer0024@example.in	7000000023	2026-06-10
25	Pranita Pande	customer0025@example.in	7000000024	2024-05-24
26	Rashid Kar	customer0026@example.in	7000000025	2023-10-12
27	Dheeraj Sharma	customer0027@example.in	7000000026	2026-08-07
28	Diksha Reddy	customer0028@example.in	7000000027	2025-07-20
29	Kunal Mohan	customer0029@example.in	7000000028	2026-08-22
30	Leena Chopra	customer0030@example.in	7000000029	2025-02-21
31	Darpan Gokhale	customer0031@example.in	7000000030	2024-05-03
32	Niharika Sarkar	customer0032@example.in	7000000031	2025-05-04
33	Dilip Sen	customer0033@example.in	7000000032	2025-10-11
34	Bani Mehta	customer0034@example.in	7000000033	2024-06-16
35	Kailash Chandra	customer0035@example.in	7000000034	2026-06-05
36	Monika Bisht	customer0036@example.in	7000000035	2026-03-09
37	Vibhor Mahajan	customer0037@example.in	7000000036	2025-09-13
38	Vimal Pandey	customer0038@example.in	7000000037	2023-12-01
39	Sonal Mishra	customer0039@example.in	7000000038	2024-10-16
40	Balaji Ahluwalia	customer0040@example.in	7000000039	2024-11-26
41	Balaji Chakraborty	customer0041@example.in	7000000040	2026-03-02
42	Meghna Solanki	customer0042@example.in	7000000041	2024-03-27
43	Ragini Ganguly	customer0043@example.in	7000000042	2025-12-17
44	Jaspreet Raghavan	customer0044@example.in	7000000043	2024-06-19
45	Zubin Nambiar	customer0045@example.in	7000000044	2025-06-25
46	Eklavya Purohit	customer0046@example.in	7000000045	2025-06-29
47	Mukul Jain	customer0047@example.in	7000000046	2025-01-20
48	Sachin Pande	customer0048@example.in	7000000047	2026-04-29
49	Sachin Kar	customer0049@example.in	7000000048	2024-12-12
50	Soumya Sharma	customer0050@example.in	7000000049	2025-11-26
51	Rupal Reddy	customer0051@example.in	7000000050	2026-03-23
52	Arushi Rao	customer0052@example.in	7000000051	2024-08-18
53	Sameera Upadhyay	customer0053@example.in	7000000052	2024-06-04
54	Kailash Desai	customer0054@example.in	7000000053	2025-07-12
55	Mahima Sundaram	customer0055@example.in	7000000054	2025-04-18
56	Rashi Bhowmik	customer0056@example.in	7000000055	2024-07-15
57	Parul Rajan	customer0057@example.in	7000000056	2024-12-01
58	Nikhita Chandra	customer0058@example.in	7000000057	2025-03-20
59	Hari Bisht	customer0059@example.in	7000000058	2024-05-26
60	Manoj Mahajan	customer0060@example.in	7000000059	2026-03-31
61	Harshad Pandey	customer0061@example.in	7000000060	2023-10-29
62	Lisha Mishra	customer0062@example.in	7000000061	2025-06-28
63	Tina Ahluwalia	customer0063@example.in	7000000062	2025-03-07
64	Garima Chakraborty	customer0064@example.in	7000000063	2024-10-01
65	Bela Solanki	customer0065@example.in	7000000064	2024-09-17
66	Kavita Ganguly	customer0066@example.in	7000000065	2024-01-07
67	Yogesh Raghavan	customer0067@example.in	7000000066	2025-09-14
68	Firoz Nambiar	customer0068@example.in	7000000067	2026-03-06
69	Boby Deshmukh	customer0069@example.in	7000000068	2025-08-09
70	Hina Narang	customer0070@example.in	7000000069	2024-04-17
71	Arjun Batra	customer0071@example.in	7000000070	2024-10-09
72	Mahendra Goswami	customer0072@example.in	7000000071	2025-12-05
73	Pavan Mishra	customer0073@example.in	7000000072	2024-06-30
74	Hafiz Mukherjee	customer0074@example.in	7000000073	2024-03-29
75	Ranjana Rao	customer0075@example.in	7000000074	2026-02-17
76	Rohini Upadhyay	customer0076@example.in	7000000075	2024-03-24
77	Arushi Desai	customer0077@example.in	7000000076	2025-07-14
78	Chandni Sundaram	customer0078@example.in	7000000077	2025-07-27
79	Madhav Bhowmik	customer0079@example.in	7000000078	2024-03-19
80	Nidhi Rajan	customer0080@example.in	7000000079	2025-08-14
81	Dhananjay Chandra	customer0081@example.in	7000000080	2024-01-30
82	Archit Bisht	customer0082@example.in	7000000081	2026-02-17
83	Kalpana Mahajan	customer0083@example.in	7000000082	2026-03-20
84	Chaitanya Pandey	customer0084@example.in	7000000083	2026-01-08
85	Tarun Mishra	customer0085@example.in	7000000084	2026-09-17
86	Hari Rana	customer0086@example.in	7000000085	2023-12-23
87	Nimisha Shukla	customer0087@example.in	7000000086	2024-04-06
88	Sunita Varma	customer0088@example.in	7000000087	2024-01-14
89	Niharika Fernandes	customer0089@example.in	7000000088	2024-02-28
90	Beena Qureshi	customer0090@example.in	7000000089	2025-09-15
91	Maya Rathore	customer0091@example.in	7000000090	2025-06-12
92	Padmini Deshmukh	customer0092@example.in	7000000091	2025-03-27
93	Pragya Narang	customer0093@example.in	7000000092	2023-12-16
94	Gopi Batra	customer0094@example.in	7000000093	2026-08-19
95	Boby Goswami	customer0095@example.in	7000000094	2024-02-06
96	Sarita Mishra	customer0096@example.in	7000000095	2026-09-30
97	Manisha Mukherjee	customer0097@example.in	7000000096	2026-06-16
98	Mandar Rao	customer0098@example.in	7000000097	2026-03-29
99	Amol Upadhyay	customer0099@example.in	7000000098	2025-05-21
100	Mahendra Desai	customer0100@example.in	7000000099	2025-02-22
101	Jignesh Sundaram	customer0101@example.in	7000000100	2023-10-13
102	Abeer Bhowmik	customer0102@example.in	7000000101	2025-07-16
103	Pushkar Dutta	customer0103@example.in	7000000102	2024-03-13
104	Darshana Agarwal	customer0104@example.in	7000000103	2023-11-21
105	Bhavani Malhotra	customer0105@example.in	7000000104	2023-11-10
106	Brij Khatri	customer0106@example.in	7000000105	2024-05-29
107	Bhumika Dubey	customer0107@example.in	7000000106	2024-04-10
108	Rachna Rawat	customer0108@example.in	7000000107	2024-05-03
109	Kamini Rana	customer0109@example.in	7000000108	2026-06-04
110	Purva Shukla	customer0110@example.in	7000000109	2024-10-14
111	Malavika Varma	customer0111@example.in	7000000110	2025-07-18
112	Dhananjay Fernandes	customer0112@example.in	7000000111	2026-04-16
113	Chetna Qureshi	customer0113@example.in	7000000112	2025-06-24
114	Yamini Rathore	customer0114@example.in	7000000113	2024-08-06
115	Mandar Deshmukh	customer0115@example.in	7000000114	2025-11-18
116	Ravindra Narang	customer0116@example.in	7000000115	2024-07-13
117	Deepika Batra	customer0117@example.in	7000000116	2024-02-20
118	Bhakti Goswami	customer0118@example.in	7000000117	2024-08-10
119	Samar Mishra	customer0119@example.in	7000000118	2024-09-04
120	Nivedita Jaiswal	customer0120@example.in	7000000119	2026-08-01
121	Siddhant Chatterjee	customer0121@example.in	7000000120	2025-09-22
122	Jignesh Ghosh	customer0122@example.in	7000000121	2026-03-06
123	Subodh Murthy	customer0123@example.in	7000000122	2023-12-24
124	Krupal Sodhi	customer0124@example.in	7000000123	2024-02-13
125	Hrithik D'Souza	customer0125@example.in	7000000124	2024-05-30
126	Ishwar Dutta	customer0126@example.in	7000000125	2026-02-11
127	Chiranjit Agarwal	customer0127@example.in	7000000126	2026-09-26
128	Vaishnavi Malhotra	customer0128@example.in	7000000127	2025-04-28
129	Veer Khatri	customer0129@example.in	7000000128	2026-07-15
130	Ananya Dubey	customer0130@example.in	7000000129	2026-05-16
131	Hemant Rawat	customer0131@example.in	7000000130	2025-02-05
132	Govind Rana	customer0132@example.in	7000000131	2024-06-21
133	Rachit Shukla	customer0133@example.in	7000000132	2024-10-07
134	Devendra Varma	customer0134@example.in	7000000133	2024-10-06
135	Pari Fernandes	customer0135@example.in	7000000134	2025-09-06
136	Vibhor Qureshi	customer0136@example.in	7000000135	2024-12-17
137	Kanishk Patel	customer0137@example.in	7000000136	2025-07-09
138	Raghu Mandal	customer0138@example.in	7000000137	2025-06-19
139	Heena Acharya	customer0139@example.in	7000000138	2024-12-29
140	Tarun Bhat	customer0140@example.in	7000000139	2025-05-31
141	Devendra Singh	customer0141@example.in	7000000140	2024-10-04
142	Padmini Soni	customer0142@example.in	7000000141	2023-10-26
143	Vinod Jaiswal	customer0143@example.in	7000000142	2025-08-24
144	Lokesh Chatterjee	customer0144@example.in	7000000143	2025-08-08
145	Bharat Ghosh	customer0145@example.in	7000000144	2023-12-19
146	Prasad Murthy	customer0146@example.in	7000000145	2025-09-16
147	Archana Sodhi	customer0147@example.in	7000000146	2025-08-02
148	Amar D'Souza	customer0148@example.in	7000000147	2024-01-17
149	Beena Dutta	customer0149@example.in	7000000148	2025-05-17
150	Archit Agarwal	customer0150@example.in	7000000149	2025-05-04
151	Shikha Malhotra	customer0151@example.in	7000000150	2025-01-19
152	Badri Khatri	customer0152@example.in	7000000151	2026-08-16
153	Rachna Dubey	customer0153@example.in	7000000152	2023-11-08
154	Pawan Bedi	customer0154@example.in	7000000153	2023-11-16
155	Narendra Krishnan	customer0155@example.in	7000000154	2025-04-02
156	Darsh Rai	customer0156@example.in	7000000155	2026-08-14
157	Raksha Lal	customer0157@example.in	7000000156	2025-08-26
158	Sanjiv Verma	customer0158@example.in	7000000157	2024-04-17
159	Maithili Rastogi	customer0159@example.in	7000000158	2024-03-14
160	Esha Patel	customer0160@example.in	7000000159	2024-07-07
161	Ronak Mandal	customer0161@example.in	7000000160	2026-03-27
162	Vijaya Acharya	customer0162@example.in	7000000161	2023-12-11
163	Faisal Bhat	customer0163@example.in	7000000162	2024-04-28
164	Saransh Singh	customer0164@example.in	7000000163	2023-11-27
165	Abhishek Soni	customer0165@example.in	7000000164	2026-05-16
166	Kriti Jaiswal	customer0166@example.in	7000000165	2024-10-21
167	Leher Chatterjee	customer0167@example.in	7000000166	2026-07-28
168	Namita Ghosh	customer0168@example.in	7000000167	2024-03-31
169	Vikrant Murthy	customer0169@example.in	7000000168	2026-06-09
170	Athira Sodhi	customer0170@example.in	7000000169	2024-01-09
171	Kartik Trivedi	customer0171@example.in	7000000170	2025-06-02
172	Rajendra Borkar	customer0172@example.in	7000000171	2024-06-27
173	Darsh Nanda	customer0173@example.in	7000000172	2025-01-19
174	Niranjan Tandon	customer0174@example.in	7000000173	2025-04-25
175	Sandeep Gandhi	customer0175@example.in	7000000174	2025-12-03
176	Niranjan Basu	customer0176@example.in	7000000175	2026-02-02
177	Mukul Bedi	customer0177@example.in	7000000176	2025-07-06
178	Nargis Krishnan	customer0178@example.in	7000000177	2025-12-30
179	Harpreet Rai	customer0179@example.in	7000000178	2023-11-06
180	Avinash Lal	customer0180@example.in	7000000179	2026-06-23
181	Bhavani Verma	customer0181@example.in	7000000180	2026-08-05
182	Pragya Rastogi	customer0182@example.in	7000000181	2023-12-24
183	Meghna Patel	customer0183@example.in	7000000182	2023-12-20
184	Kaushal Mandal	customer0184@example.in	7000000183	2023-10-11
185	Rashid Acharya	customer0185@example.in	7000000184	2024-11-16
186	Shankar Bhat	customer0186@example.in	7000000185	2024-02-23
187	Kusum Singh	customer0187@example.in	7000000186	2024-05-22
188	Balram Lohia	customer0188@example.in	7000000187	2025-04-17
189	Nirmal Manna	customer0189@example.in	7000000188	2026-09-03
190	Faisal Shetty	customer0190@example.in	7000000189	2024-02-03
191	Ravindra Joshi	customer0191@example.in	7000000190	2023-10-21
192	Surabhi Tripathi	customer0192@example.in	7000000191	2026-03-19
193	Falguni Pillai	customer0193@example.in	7000000192	2025-08-06
194	Saksham Trivedi	customer0194@example.in	7000000193	2025-06-27
195	Renu Borkar	customer0195@example.in	7000000194	2025-10-18
196	Chiranjit Nanda	customer0196@example.in	7000000195	2024-02-13
197	Hafiz Tandon	customer0197@example.in	7000000196	2024-04-21
198	Gauri Gandhi	customer0198@example.in	7000000197	2024-09-27
199	Pradeep Basu	customer0199@example.in	7000000198	2024-03-11
200	Chandni Bedi	customer0200@example.in	7000000199	2024-05-08
201	Rohini Krishnan	customer0201@example.in	7000000200	2023-12-18
202	Vivek Rai	customer0202@example.in	7000000201	2026-07-31
203	Dipti Lal	customer0203@example.in	7000000202	2025-10-29
204	Mohan Verma	customer0204@example.in	7000000203	2024-07-02
205	Madhuri Naik	customer0205@example.in	7000000204	2026-06-14
206	Lokesh Iyer	customer0206@example.in	7000000205	2023-10-26
207	Bakul Modi	customer0207@example.in	7000000206	2025-10-09
208	Malavika Konduri	customer0208@example.in	7000000207	2025-10-06
209	Aparna Sawant	customer0209@example.in	7000000208	2024-09-09
210	Prerna Venkatesh	customer0210@example.in	7000000209	2025-06-29
211	Chandan Lohia	customer0211@example.in	7000000210	2025-10-22
212	Sudarshan Manna	customer0212@example.in	7000000211	2024-11-08
213	Atul Shetty	customer0213@example.in	7000000212	2024-11-04
214	Eklavya Joshi	customer0214@example.in	7000000213	2024-11-17
215	Varad Tripathi	customer0215@example.in	7000000214	2025-10-22
216	Leela Pillai	customer0216@example.in	7000000215	2026-02-24
217	Srinivas Trivedi	customer0217@example.in	7000000216	2025-07-06
218	Padma Borkar	customer0218@example.in	7000000217	2025-10-28
219	Radhika Nanda	customer0219@example.in	7000000218	2025-03-21
220	Maya Tandon	customer0220@example.in	7000000219	2025-11-30
221	Rajat Gandhi	customer0221@example.in	7000000220	2025-11-07
222	Deepali Goel	customer0222@example.in	7000000221	2024-06-05
223	Fardeen Kashyap	customer0223@example.in	7000000222	2025-02-18
224	Richa Madhavan	customer0224@example.in	7000000223	2025-03-11
225	Yogesh Saxena	customer0225@example.in	7000000224	2024-10-04
226	Vikrant Bhatt	customer0226@example.in	7000000225	2026-02-03
227	Apoorva Bansal	customer0227@example.in	7000000226	2025-10-02
228	Laxman Naik	customer0228@example.in	7000000227	2025-09-17
229	Samarth Iyer	customer0229@example.in	7000000228	2025-08-15
230	Raksha Modi	customer0230@example.in	7000000229	2024-03-14
231	Prakash Konduri	customer0231@example.in	7000000230	2026-01-03
232	Geeta Sawant	customer0232@example.in	7000000231	2023-10-28
233	Amar Venkatesh	customer0233@example.in	7000000232	2023-11-03
234	Fahad Lohia	customer0234@example.in	7000000233	2026-08-02
235	Bipin Manna	customer0235@example.in	7000000234	2025-01-26
236	Dhanvi Shetty	customer0236@example.in	7000000235	2025-08-31
237	Kavitha Joshi	customer0237@example.in	7000000236	2023-11-13
238	Padma Tripathi	customer0238@example.in	7000000237	2025-02-28
239	Chitra Kaur	customer0239@example.in	7000000238	2024-09-28
240	Nayan Talwar	customer0240@example.in	7000000239	2025-04-28
241	Vaishnavi Vasudevan	customer0241@example.in	7000000240	2024-01-19
242	Renu Khanna	customer0242@example.in	7000000241	2025-07-28
243	Manas Vaidya	customer0243@example.in	7000000242	2024-06-04
244	Lalit Khan	customer0244@example.in	7000000243	2024-07-08
245	Kriti Goel	customer0245@example.in	7000000244	2024-05-11
246	Avinash Kashyap	customer0246@example.in	7000000245	2025-12-03
247	Saksham Madhavan	customer0247@example.in	7000000246	2024-01-22
248	Gauri Saxena	customer0248@example.in	7000000247	2026-09-17
249	Dipak Bhatt	customer0249@example.in	7000000248	2024-04-05
250	Ratna Bansal	customer0250@example.in	7000000249	2025-06-03
251	Khyati Naik	customer0251@example.in	7000000250	2026-07-02
252	Raghu Iyer	customer0252@example.in	7000000251	2024-05-13
253	Nirmal Modi	customer0253@example.in	7000000252	2024-03-08
254	Kaushal Konduri	customer0254@example.in	7000000253	2025-08-12
255	Charan Sawant	customer0255@example.in	7000000254	2026-02-19
256	Atharv Nayyar	customer0256@example.in	7000000255	2025-03-08
257	Vandana Sinha	customer0257@example.in	7000000256	2025-08-16
258	Sandhya Kapoor	customer0258@example.in	7000000257	2024-09-14
259	Veer Adhikari	customer0259@example.in	7000000258	2026-05-24
260	Purva Roy	customer0260@example.in	7000000259	2024-03-26
261	Shreyas Parikh	customer0261@example.in	7000000260	2025-11-15
262	Hitesh Kaur	customer0262@example.in	7000000261	2026-06-04
263	Madhuri Talwar	customer0263@example.in	7000000262	2025-05-23
264	Chandrika Vasudevan	customer0264@example.in	7000000263	2026-09-10
265	Rupesh Khanna	customer0265@example.in	7000000264	2024-04-11
266	Bhavana Vaidya	customer0266@example.in	7000000265	2025-03-04
267	Chitra Khan	customer0267@example.in	7000000266	2025-10-25
268	Kiran Goel	customer0268@example.in	7000000267	2023-12-22
269	Prasad Kashyap	customer0269@example.in	7000000268	2025-03-12
270	Bani Madhavan	customer0270@example.in	7000000269	2024-02-13
271	Firoz Saxena	customer0271@example.in	7000000270	2025-06-24
272	Leena Bhatt	customer0272@example.in	7000000271	2023-10-05
273	Gopi Bhatia	customer0273@example.in	7000000272	2025-04-17
274	Saloni Srivastava	customer0274@example.in	7000000273	2026-01-21
275	Ayesha Kohli	customer0275@example.in	7000000274	2025-03-17
276	Karishma Kamat	customer0276@example.in	7000000275	2026-05-13
277	Jyoti Pawar	customer0277@example.in	7000000276	2025-07-31
278	Akshara Shinde	customer0278@example.in	7000000277	2026-05-08
279	Arjun Nayyar	customer0279@example.in	7000000278	2025-08-16
280	Pawan Sinha	customer0280@example.in	7000000279	2025-03-06
281	Lisha Kapoor	customer0281@example.in	7000000280	2023-11-23
282	Rajesh Adhikari	customer0282@example.in	7000000281	2023-11-24
283	Radhika Roy	customer0283@example.in	7000000282	2025-12-25
284	Badri Parikh	customer0284@example.in	7000000283	2026-08-20
285	Vasudha Kaur	customer0285@example.in	7000000284	2024-07-16
286	Sonal Talwar	customer0286@example.in	7000000285	2025-11-26
287	Ankur Vasudevan	customer0287@example.in	7000000286	2024-09-08
288	Kartik Khanna	customer0288@example.in	7000000287	2025-03-06
289	Bhumika Vaidya	customer0289@example.in	7000000288	2024-06-29
290	Manas Bhattacharya	customer0290@example.in	7000000289	2026-01-28
291	Mayank Gupta	customer0291@example.in	7000000290	2023-11-26
292	Himanshu Reddy	customer0292@example.in	7000000291	2024-07-13
293	Soumya Nair	customer0293@example.in	7000000292	2024-06-09
294	Raghav Choudhary	customer0294@example.in	7000000293	2023-10-25
295	Avantika Jadhav	customer0295@example.in	7000000294	2025-01-22
296	Pasha Bhatia	customer0296@example.in	7000000295	2025-12-14
297	Jatin Srivastava	customer0297@example.in	7000000296	2025-10-30
298	Anirban Kohli	customer0298@example.in	7000000297	2026-01-05
299	Deepti Kamat	customer0299@example.in	7000000298	2024-10-19
300	Aditi Pawar	customer0300@example.in	7000000299	2025-04-15
301	Mayank Shinde	customer0301@example.in	7000000300	2025-04-18
302	Farida Nayyar	customer0302@example.in	7000000301	2025-11-21
303	Muskan Sinha	customer0303@example.in	7000000302	2024-12-14
304	Palak Kapoor	customer0304@example.in	7000000303	2024-03-12
305	Renuka Adhikari	customer0305@example.in	7000000304	2026-07-25
306	Anshul Roy	customer0306@example.in	7000000305	2024-03-07
307	Rupesh Thomas	customer0307@example.in	7000000306	2026-03-19
308	Balram Shah	customer0308@example.in	7000000307	2024-12-06
309	Samar Banerjee	customer0309@example.in	7000000308	2026-09-13
310	Bipin Nath	customer0310@example.in	7000000309	2025-08-08
311	Kavisha Wagh	customer0311@example.in	7000000310	2026-07-03
312	Mala Subramanian	customer0312@example.in	7000000311	2026-05-26
313	Neelam Bhattacharya	customer0313@example.in	7000000312	2026-03-23
314	Inder Gupta	customer0314@example.in	7000000313	2026-01-26
315	Lohit Reddy	customer0315@example.in	7000000314	2026-03-04
316	Ashok Nair	customer0316@example.in	7000000315	2026-03-10
317	Pushkar Choudhary	customer0317@example.in	7000000316	2024-03-16
318	Arvind Jadhav	customer0318@example.in	7000000317	2024-10-04
319	Avantika Bhatia	customer0319@example.in	7000000318	2025-03-05
320	Shikha Srivastava	customer0320@example.in	7000000319	2024-05-17
321	Mansi Kohli	customer0321@example.in	7000000320	2024-09-29
322	Prisha Kamat	customer0322@example.in	7000000321	2026-02-21
323	Vijaya Pawar	customer0323@example.in	7000000322	2024-04-06
324	Gagan Barua	customer0324@example.in	7000000323	2024-11-04
325	Dinesh Das	customer0325@example.in	7000000324	2024-07-14
326	Prisha Datta	customer0326@example.in	7000000325	2025-04-06
327	Prachi Saha	customer0327@example.in	7000000326	2024-04-30
328	Anup Naidu	customer0328@example.in	7000000327	2024-10-23
329	Tina Bose	customer0329@example.in	7000000328	2026-02-26
330	Harleen Thomas	customer0330@example.in	7000000329	2023-12-17
331	Chaitanya Shah	customer0331@example.in	7000000330	2025-05-08
332	Ronak Banerjee	customer0332@example.in	7000000331	2024-02-06
333	Asmita Nath	customer0333@example.in	7000000332	2025-03-08
334	Asmita Wagh	customer0334@example.in	7000000333	2025-07-17
335	Anamika Subramanian	customer0335@example.in	7000000334	2026-08-22
336	Gautam Bhattacharya	customer0336@example.in	7000000335	2024-08-20
337	Devesh Gupta	customer0337@example.in	7000000336	2024-09-23
338	Binod Reddy	customer0338@example.in	7000000337	2026-09-18
339	Raghav Nair	customer0339@example.in	7000000338	2026-06-25
340	Shrikant Choudhary	customer0340@example.in	7000000339	2025-10-28
341	Gautam Dey	customer0341@example.in	7000000340	2024-01-30
342	Pradeep Thakur	customer0342@example.in	7000000341	2024-09-18
343	Kamal Chauhan	customer0343@example.in	7000000342	2026-06-21
344	Harpreet Garg	customer0344@example.in	7000000343	2026-04-30
345	Sadhana Yadav	customer0345@example.in	7000000344	2025-08-13
346	Nikhita Prasad	customer0346@example.in	7000000345	2025-07-18
347	Aparna Barua	customer0347@example.in	7000000346	2026-02-27
348	Yamini Das	customer0348@example.in	7000000347	2024-07-27
349	Ashok Datta	customer0349@example.in	7000000348	2024-10-15
350	Parag Saha	customer0350@example.in	7000000349	2025-02-26
351	Aravind Naidu	customer0351@example.in	7000000350	2023-11-11
352	Brijesh Bose	customer0352@example.in	7000000351	2024-04-19
353	Danish Thomas	customer0353@example.in	7000000352	2024-10-07
354	Keerthi Shah	customer0354@example.in	7000000353	2024-08-12
355	Malav Banerjee	customer0355@example.in	7000000354	2025-08-13
356	Roshan Nath	customer0356@example.in	7000000355	2024-10-02
357	Laxman Wagh	customer0357@example.in	7000000356	2026-01-12
358	Neelam Saini	customer0358@example.in	7000000357	2026-03-05
359	Hardeep Kulkarni	customer0359@example.in	7000000358	2024-12-10
360	Sameera Mahato	customer0360@example.in	7000000359	2024-12-12
361	Hitesh Nayak	customer0361@example.in	7000000360	2025-12-03
362	Keerthi Menon	customer0362@example.in	7000000361	2025-10-16
363	Suhas Dixit	customer0363@example.in	7000000362	2026-04-22
364	Himanshu Dey	customer0364@example.in	7000000363	2025-10-26
365	Muskan Thakur	customer0365@example.in	7000000364	2026-03-04
366	Nargis Chauhan	customer0366@example.in	7000000365	2025-11-21
367	Ankur Garg	customer0367@example.in	7000000366	2024-10-03
368	Brijesh Yadav	customer0368@example.in	7000000367	2026-03-22
369	Roshan Prasad	customer0369@example.in	7000000368	2026-09-11
370	Dayanand Barua	customer0370@example.in	7000000369	2024-11-11
371	Dhanvi Das	customer0371@example.in	7000000370	2025-10-22
372	Hiral Datta	customer0372@example.in	7000000371	2024-12-04
373	Anupama Saha	customer0373@example.in	7000000372	2026-06-02
374	Ayesha Naidu	customer0374@example.in	7000000373	2025-11-26
375	Kanishk Mehta	customer0375@example.in	7000000374	2025-01-26
376	Deepika Pandit	customer0376@example.in	7000000375	2025-07-25
377	Palak Kumar	customer0377@example.in	7000000376	2026-05-17
378	Varad Hegde	customer0378@example.in	7000000377	2023-11-21
379	Binal Raghavendra	customer0379@example.in	7000000378	2025-10-23
380	Mansi Kadam	customer0380@example.in	7000000379	2025-09-04
381	Jai Saini	customer0381@example.in	7000000380	2026-03-16
382	Leela Kulkarni	customer0382@example.in	7000000381	2025-08-26
383	Jai Mahato	customer0383@example.in	7000000382	2025-04-28
384	Kunal Nayak	customer0384@example.in	7000000383	2026-01-02
385	Elina Menon	customer0385@example.in	7000000384	2025-08-01
386	Rachit Dixit	customer0386@example.in	7000000385	2023-12-12
387	Janvi Dey	customer0387@example.in	7000000386	2025-04-20
388	Kalpana Thakur	customer0388@example.in	7000000387	2024-08-21
389	Onkar Chauhan	customer0389@example.in	7000000388	2026-08-10
390	Kavitha Garg	customer0390@example.in	7000000389	2025-09-25
391	Gitanjali Yadav	customer0391@example.in	7000000390	2026-07-24
392	Leher Reddy	customer0392@example.in	7000000391	2024-04-16
393	Prerna Mohan	customer0393@example.in	7000000392	2026-01-22
394	Dipti Chopra	customer0394@example.in	7000000393	2026-01-13
395	Janvi Gokhale	customer0395@example.in	7000000394	2024-04-16
396	Devesh Sarkar	customer0396@example.in	7000000395	2025-11-14
397	Dayanand Sen	customer0397@example.in	7000000396	2025-09-17
398	Danish Mehta	customer0398@example.in	7000000397	2025-05-26
399	Kusum Pandit	customer0399@example.in	7000000398	2024-02-17
400	Chandan Kumar	customer0400@example.in	7000000399	2024-01-29
401	Anamika Hegde	customer0401@example.in	7000000400	2026-05-25
402	Nivedita Raghavendra	customer0402@example.in	7000000401	2025-04-01
403	Atul Kadam	customer0403@example.in	7000000402	2025-12-10
404	Nandita Saini	customer0404@example.in	7000000403	2026-05-10
405	Binal Kulkarni	customer0405@example.in	7000000404	2024-10-18
406	Darshana Mahato	customer0406@example.in	7000000405	2025-01-20
407	Gowtham Nayak	customer0407@example.in	7000000406	2025-11-02
408	Girish Menon	customer0408@example.in	7000000407	2024-12-07
409	Surabhi Nambiar	customer0409@example.in	7000000408	2024-01-12
410	Anup Purohit	customer0410@example.in	7000000409	2025-03-21
411	Mohan Jain	customer0411@example.in	7000000410	2026-05-26
412	Apoorva Pande	customer0412@example.in	7000000411	2024-12-04
413	Bhakti Kar	customer0413@example.in	7000000412	2025-09-04
414	Suhas Sharma	customer0414@example.in	7000000413	2025-08-27
415	Onkar Reddy	customer0415@example.in	7000000414	2025-04-06
416	Sandeep Mohan	customer0416@example.in	7000000415	2026-02-28
417	Shilpa Chopra	customer0417@example.in	7000000416	2023-10-07
418	Dinesh Gokhale	customer0418@example.in	7000000417	2025-04-16
419	Namita Sarkar	customer0419@example.in	7000000418	2025-10-07
420	Ranjit Sen	customer0420@example.in	7000000419	2025-08-04
421	Renuka Mehta	customer0421@example.in	7000000420	2026-06-21
422	Chaya Pandit	customer0422@example.in	7000000421	2025-11-24
423	Shrikant Kumar	customer0423@example.in	7000000422	2025-12-08
424	Sagar Hegde	customer0424@example.in	7000000423	2025-06-22
425	Dilip Raghavendra	customer0425@example.in	7000000424	2024-08-17
426	Aditi Mishra	customer0426@example.in	7000000425	2024-06-21
427	Ananya Ahluwalia	customer0427@example.in	7000000426	2025-07-17
428	Durga Chakraborty	customer0428@example.in	7000000427	2025-12-03
429	Kamal Solanki	customer0429@example.in	7000000428	2024-09-15
430	Madhav Ganguly	customer0430@example.in	7000000429	2024-03-24
431	Jatin Raghavan	customer0431@example.in	7000000430	2024-05-09
432	Nilesh Nambiar	customer0432@example.in	7000000431	2023-11-25
433	Deepti Purohit	customer0433@example.in	7000000432	2025-09-14
434	Parul Jain	customer0434@example.in	7000000433	2024-12-25
435	Harshad Pande	customer0435@example.in	7000000434	2025-05-01
436	Pasha Kar	customer0436@example.in	7000000435	2026-04-03
437	Rajendra Sharma	customer0437@example.in	7000000436	2024-01-10
438	Khyati Reddy	customer0438@example.in	7000000437	2025-02-24
439	Pranita Mohan	customer0439@example.in	7000000438	2023-10-29
440	Mala Chopra	customer0440@example.in	7000000439	2025-09-06
441	Diksha Gokhale	customer0441@example.in	7000000440	2024-07-16
442	Jayant Sarkar	customer0442@example.in	7000000441	2024-12-27
443	Nidhi Bhowmik	customer0443@example.in	7000000442	2026-08-14
444	Kanchan Rajan	customer0444@example.in	7000000443	2024-08-18
445	Manoj Chandra	customer0445@example.in	7000000444	2025-09-18
446	Krupal Bisht	customer0446@example.in	7000000445	2024-05-05
447	Ritu Mahajan	customer0447@example.in	7000000446	2024-12-25
448	Alka Pandey	customer0448@example.in	7000000447	2024-04-05
449	Charan Mishra	customer0449@example.in	7000000448	2024-12-22
450	Saloni Ahluwalia	customer0450@example.in	7000000449	2023-12-10
451	Srinivas Chakraborty	customer0451@example.in	7000000450	2024-02-13
452	Saransh Solanki	customer0452@example.in	7000000451	2025-09-23
453	Kanchan Ganguly	customer0453@example.in	7000000452	2024-02-03
454	Sanjana Raghavan	customer0454@example.in	7000000453	2025-05-24
455	Chinmay Nambiar	customer0455@example.in	7000000454	2025-02-13
456	Arvind Purohit	customer0456@example.in	7000000455	2024-04-08
457	Sarita Jain	customer0457@example.in	7000000456	2025-03-12
458	Manisha Pande	customer0458@example.in	7000000457	2025-08-01
459	Sagar Kar	customer0459@example.in	7000000458	2024-08-19
460	Anaya Mishra	customer0460@example.in	7000000459	2024-02-07
461	Shilpa Mukherjee	customer0461@example.in	7000000460	2026-07-08
462	Kedar Rao	customer0462@example.in	7000000461	2025-12-14
463	Jagdish Upadhyay	customer0463@example.in	7000000462	2025-04-04
464	Kavisha Desai	customer0464@example.in	7000000463	2025-04-03
465	Rashi Sundaram	customer0465@example.in	7000000464	2025-12-14
466	Gopal Bhowmik	customer0466@example.in	7000000465	2026-01-20
467	Jaspreet Rajan	customer0467@example.in	7000000466	2024-06-13
468	Brij Chandra	customer0468@example.in	7000000467	2026-08-13
469	Ambika Bisht	customer0469@example.in	7000000468	2026-08-23
470	Fahad Mahajan	customer0470@example.in	7000000469	2025-12-12
471	Menaka Pandey	customer0471@example.in	7000000470	2026-05-27
472	Amol Mishra	customer0472@example.in	7000000471	2024-01-17
473	Zubin Ahluwalia	customer0473@example.in	7000000472	2025-08-23
474	Jeevan Chakraborty	customer0474@example.in	7000000473	2024-08-09
475	Hemal Solanki	customer0475@example.in	7000000474	2026-04-19
476	Payal Ganguly	customer0476@example.in	7000000475	2025-05-24
477	Ramesh Qureshi	customer0477@example.in	7000000476	2024-03-09
478	Ram Rathore	customer0478@example.in	7000000477	2025-11-11
479	Ramya Deshmukh	customer0479@example.in	7000000478	2026-03-18
480	Ranjana Narang	customer0480@example.in	7000000479	2024-02-14
481	Akhil Batra	customer0481@example.in	7000000480	2024-10-22
482	Gitanjali Goswami	customer0482@example.in	7000000481	2026-03-25
483	Vandana Mishra	customer0483@example.in	7000000482	2024-10-02
484	Radha Mukherjee	customer0484@example.in	7000000483	2023-10-06
485	Esha Rao	customer0485@example.in	7000000484	2024-06-10
486	Dheeraj Upadhyay	customer0486@example.in	7000000485	2026-01-30
487	Ritesh Desai	customer0487@example.in	7000000486	2026-09-20
488	Sunita Sundaram	customer0488@example.in	7000000487	2025-06-01
489	Anupama Bhowmik	customer0489@example.in	7000000488	2023-10-10
490	Ragini Rajan	customer0490@example.in	7000000489	2026-07-06
491	Bhaskar Chandra	customer0491@example.in	7000000490	2025-02-22
492	Dipak Bisht	customer0492@example.in	7000000491	2025-03-25
493	Anand Mahajan	customer0493@example.in	7000000492	2026-07-25
494	Ambika Dubey	customer0494@example.in	7000000493	2025-02-24
495	Jagdish Rawat	customer0495@example.in	7000000494	2025-04-10
496	Nayan Rana	customer0496@example.in	7000000495	2025-08-10
497	Deepali Shukla	customer0497@example.in	7000000496	2025-03-18
498	Kamini Varma	customer0498@example.in	7000000497	2026-07-06
499	Monika Fernandes	customer0499@example.in	7000000498	2026-07-18
500	Prakash Qureshi	customer0500@example.in	7000000499	2024-08-08
501	Alka Rathore	customer0501@example.in	7000000500	2025-05-17
502	Atharv Deshmukh	customer0502@example.in	7000000501	2024-03-28
503	Aravind Narang	customer0503@example.in	7000000502	2024-03-18
504	Bharat Batra	customer0504@example.in	7000000503	2025-06-09
505	Sanket Goswami	customer0505@example.in	7000000504	2026-03-11
506	Akshara Mishra	customer0506@example.in	7000000505	2026-08-24
507	Sandhya Mukherjee	customer0507@example.in	7000000506	2026-01-09
508	Kiran Rao	customer0508@example.in	7000000507	2026-03-28
509	Bela Upadhyay	customer0509@example.in	7000000508	2025-07-08
510	Radha Desai	customer0510@example.in	7000000509	2026-08-11
511	Sudarshan Sodhi	customer0511@example.in	7000000510	2025-07-29
512	Chinmay D'Souza	customer0512@example.in	7000000511	2024-09-09
513	Binod Dutta	customer0513@example.in	7000000512	2023-11-03
514	Garima Agarwal	customer0514@example.in	7000000513	2026-04-12
515	Hiral Malhotra	customer0515@example.in	7000000514	2025-08-07
516	Bala Khatri	customer0516@example.in	7000000515	2024-09-27
517	Lalit Dubey	customer0517@example.in	7000000516	2025-10-08
518	Falguni Rawat	customer0518@example.in	7000000517	2024-07-23
519	Astha Rana	customer0519@example.in	7000000518	2024-02-27
520	Narendra Shukla	customer0520@example.in	7000000519	2024-07-17
521	Hina Varma	customer0521@example.in	7000000520	2025-10-26
522	Gowtham Fernandes	customer0522@example.in	7000000521	2024-12-19
523	Asha Qureshi	customer0523@example.in	7000000522	2026-01-20
524	Riddhima Rathore	customer0524@example.in	7000000523	2026-08-07
525	Vasudha Deshmukh	customer0525@example.in	7000000524	2025-04-19
526	Prachi Narang	customer0526@example.in	7000000525	2025-01-19
527	Chaya Batra	customer0527@example.in	7000000526	2025-06-02
528	Astha Singh	customer0528@example.in	7000000527	2025-10-22
529	Naveena Soni	customer0529@example.in	7000000528	2024-07-28
530	Shankar Jaiswal	customer0530@example.in	7000000529	2023-10-31
531	Heena Chatterjee	customer0531@example.in	7000000530	2026-01-08
532	Chetna Ghosh	customer0532@example.in	7000000531	2025-06-21
533	Gopal Murthy	customer0533@example.in	7000000532	2024-12-13
534	Krish Sodhi	customer0534@example.in	7000000533	2025-12-30
535	Ratna D'Souza	customer0535@example.in	7000000534	2026-09-06
536	Krish Dutta	customer0536@example.in	7000000535	2024-11-02
537	Siddhant Agarwal	customer0537@example.in	7000000536	2026-01-13
538	Om Malhotra	customer0538@example.in	7000000537	2026-06-17
539	Chandrika Khatri	customer0539@example.in	7000000538	2026-04-01
540	Lohit Dubey	customer0540@example.in	7000000539	2025-10-01
541	Asif Rawat	customer0541@example.in	7000000540	2025-10-29
542	Geeta Rana	customer0542@example.in	7000000541	2024-08-29
543	Sanket Shukla	customer0543@example.in	7000000542	2025-05-08
544	Bakul Varma	customer0544@example.in	7000000543	2023-10-10
545	Om Verma	customer0545@example.in	7000000544	2024-06-09
546	Malav Rastogi	customer0546@example.in	7000000545	2024-12-13
547	Parag Patel	customer0547@example.in	7000000546	2024-08-16
548	Sadhana Mandal	customer0548@example.in	7000000547	2025-09-12
549	Neeraj Acharya	customer0549@example.in	7000000548	2024-06-23
550	Naveena Bhat	customer0550@example.in	7000000549	2024-04-21
551	Anand Singh	customer0551@example.in	7000000550	2025-09-23
552	Rajesh Soni	customer0552@example.in	7000000551	2024-12-15
553	Kishore Jaiswal	customer0553@example.in	7000000552	2025-06-20
554	Girish Chatterjee	customer0554@example.in	7000000553	2025-04-12
555	Hemal Ghosh	customer0555@example.in	7000000554	2023-12-06
556	Payal Murthy	customer0556@example.in	7000000555	2026-08-29
557	Mahima Sodhi	customer0557@example.in	7000000556	2026-07-27
558	Asha D'Souza	customer0558@example.in	7000000557	2024-08-19
559	Ritu Dutta	customer0559@example.in	7000000558	2025-02-27
560	Menaka Agarwal	customer0560@example.in	7000000559	2023-12-20
561	Ishwar Malhotra	customer0561@example.in	7000000560	2026-06-11
562	Govind Gandhi	customer0562@example.in	7000000561	2026-01-20
563	Jyoti Basu	customer0563@example.in	7000000562	2026-05-08
564	Kishore Bedi	customer0564@example.in	7000000563	2026-05-02
565	Kavita Krishnan	customer0565@example.in	7000000564	2024-08-24
566	Riddhima Rai	customer0566@example.in	7000000565	2024-12-14
567	Megha Lal	customer0567@example.in	7000000566	2024-05-27
568	Nimisha Verma	customer0568@example.in	7000000567	2024-05-20
569	Rupal Rastogi	customer0569@example.in	7000000568	2024-02-01
570	Anaya Patel	customer0570@example.in	7000000569	2026-06-10
571	Shreyas Mandal	customer0571@example.in	7000000570	2025-03-26
572	Ritesh Acharya	customer0572@example.in	7000000571	2024-05-15
573	Darpan Bhat	customer0573@example.in	7000000572	2025-05-14
574	Farida Singh	customer0574@example.in	7000000573	2026-03-27
575	Jasleen Soni	customer0575@example.in	7000000574	2025-12-05
576	Anshul Jaiswal	customer0576@example.in	7000000575	2025-11-05
577	Hardeep Chatterjee	customer0577@example.in	7000000576	2023-11-21
578	Hrithik Ghosh	customer0578@example.in	7000000577	2025-11-08
579	Athira Tripathi	customer0579@example.in	7000000578	2025-07-10
580	Abhishek Pillai	customer0580@example.in	7000000579	2025-08-20
581	Ramesh Trivedi	customer0581@example.in	7000000580	2026-08-22
582	Jasleen Borkar	customer0582@example.in	7000000581	2024-11-13
583	Ranjit Nanda	customer0583@example.in	7000000582	2024-10-22
584	Abeer Tandon	customer0584@example.in	7000000583	2025-02-09
585	Neeraj Gandhi	customer0585@example.in	7000000584	2024-11-07
586	Elina Basu	customer0586@example.in	7000000585	2025-06-30
587	Rajat Bedi	customer0587@example.in	7000000586	2024-07-09
588	Richa Krishnan	customer0588@example.in	7000000587	2026-01-20
589	Sanjiv Rai	customer0589@example.in	7000000588	2024-09-15
590	Kedar Lal	customer0590@example.in	7000000589	2024-04-12
591	Pavan Verma	customer0591@example.in	7000000590	2026-05-23
592	Asif Rastogi	customer0592@example.in	7000000591	2025-05-14
593	Fardeen Patel	customer0593@example.in	7000000592	2024-06-26
594	Anirban Mandal	customer0594@example.in	7000000593	2026-09-08
595	Nandita Acharya	customer0595@example.in	7000000594	2025-10-30
596	Vivek Sawant	customer0596@example.in	7000000595	2024-04-23
597	Hemant Venkatesh	customer0597@example.in	7000000596	2024-03-20
598	Samarth Lohia	customer0598@example.in	7000000597	2025-01-25
599	Sanjana Manna	customer0599@example.in	7000000598	2025-03-13
600	Bhaskar Shetty	customer0600@example.in	7000000599	2025-02-16
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.address (address_id, customer_id, address_type, house_no, street, locality, city, district, state, pin_code) FROM stdin;
1	168	Home	Plot 93	Iskcon Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380058
2	168	Work	Unit 879	Paud Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411007
3	310	Home	26	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560102
4	310	Work	Unit 183	Banerji Road, Trade Centre	Palarivattom	Kochi	Ernakulam	Kerala	682020
5	596	Home	Flat 6-4	Linking Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400076
6	596	Work	Unit 320	Beach Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
7	436	Home	158	Paud Road	Aundh	Pune	Pune	Maharashtra	411007
8	5	Home	Flat 5-5	Road No. 36	Madhapur	Hyderabad	Hyderabad	Telangana	500081
9	6	Home	Plot 74	Velachery Main Road	Adyar	Chennai	Chennai	Tamil Nadu	600020
10	463	Home	190B	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110017
11	234	Home	Flat 7-5	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700029
12	532	Home	213	MI Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302021
13	285	Home	20	Vibhuti Khand Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
14	492	Home	Plot 50	Banerji Road	Edappally	Kochi	Ernakulam	Kerala	682017
15	492	Work	Unit 606	Sahodaran Ayyappan Road, Commercial Complex	Palarivattom	Kochi	Ernakulam	Kerala	682030
16	7	Home	61-1	Hoshangabad Road	Shahpura	Bhopal	Bhopal	Madhya Pradesh	462026
17	7	Work	Unit 225	Beach Road, Market Plaza	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
18	477	Home	2	MR 10 Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452020
19	477	Work	Unit 908	Sinhagad Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411021
20	387	Home	133	Madhya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160017
21	47	Home	Flat 5-2	VIP Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781007
22	102	Home	Plot 33	Boring Road	Danapur	Patna	Patna	Bihar	800004
23	531	Home	Flat 8-8	Amravati Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440010
24	564	Home	197	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
25	388	Home	187	Eluru Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
26	483	Home	Plot 170	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641035
27	324	Home	255	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422007
28	324	Work	Unit 969	Beach Road, Trade Centre	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
29	222	Home	Plot 199	100 Feet Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380061
30	222	Work	Unit 183	FC Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411014
31	565	Home	167A	Hosur Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560038
32	565	Work	Unit 990	MG Road, Business Park	Edappally	Kochi	Ernakulam	Kerala	682016
33	97	Home	Plot 138	Powai Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400053
34	370	Home	89-1	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411038
35	480	Home	Flat 11-8	Jubilee Hills Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
36	309	Home	Flat 11-6	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600028
37	450	Home	Flat 9-2	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110016
38	501	Home	Plot 150	EM Bypass	Kasba	Kolkata	Kolkata	West Bengal	700029
39	15	Home	Plot 118	Tonk Road	Malviya Nagar	Jaipur	Jaipur	Rajasthan	302004
40	61	Home	Flat 9-3	Gomti Nagar Extension Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226016
41	61	Work	Unit 223	Sinhagad Road, Trade Centre	Viman Nagar	Pune	Pune	Maharashtra	411004
42	341	Home	48-2	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682016
43	341	Work	Unit 205	NH 66, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
44	401	Home	Flat 5-8	Link Road No. 1	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462016
45	401	Work	Unit 603	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
46	355	Home	45B	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452020
47	119	Home	Flat 2-3	Himalaya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160009
48	593	Home	1	Beltola Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
49	496	Home	Plot 175	Fraser Road	Kankarbagh	Patna	Patna	Bihar	800004
50	535	Home	281-2	Amravati Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440015
51	407	Home	Plot 85	Dwaraka Nagar Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
52	443	Home	9-1	Bandar Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
53	568	Home	Flat 8-6	Mettupalayam Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
54	568	Work	Unit 593	Sahodaran Ayyappan Road, Commercial Complex	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
55	322	Home	7	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422013
56	322	Work	Unit 626	Seethammadhara Main Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
57	181	Home	Flat 2-5	Iskcon Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
58	181	Work	Unit 400	Sinhagad Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411021
59	471	Home	137B	Sarjapur Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
60	300	Home	237	LBS Marg	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400078
61	458	Home	Plot 61	Paud Road	Viman Nagar	Pune	Pune	Maharashtra	411014
62	339	Home	Flat 3-6	Kukatpally Main Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500033
63	78	Home	Flat 12-2	Arcot Road	Guindy	Chennai	Chennai	Tamil Nadu	600020
64	273	Home	266	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110048
65	513	Home	Plot 171	EM Bypass	Kasba	Kolkata	Kolkata	West Bengal	700019
66	329	Home	271	Ajmer Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302004
67	329	Work	Unit 113	NH 16, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
68	56	Home	Flat 6-4	Gomti Nagar Extension Road	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226021
69	56	Work	Unit 612	Baner Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411004
70	325	Home	47-1	Banerji Road	Kadavanthra	Kochi	Ernakulam	Kerala	682030
71	325	Work	Unit 129	Banerji Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682017
72	200	Home	Flat 2-8	Link Road No. 1	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462039
73	165	Home	Flat 5-2	Khandwa Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452017
74	580	Home	177-1	Madhya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160009
75	369	Home	273A	Zoo Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781007
76	37	Home	171-2	Boring Road	Danapur	Patna	Patna	Bihar	800014
77	533	Home	Flat 4-6	Wardha Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440015
78	374	Home	Plot 121	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
79	230	Home	207-2	NH 16	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520013
80	230	Work	Unit 970	Baner Road, Business Park	Kothrud	Pune	Pune	Maharashtra	411007
81	24	Home	58A	Sathy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641018
82	24	Work	Unit 533	NH 66, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682016
83	242	Home	48B	Mumbai-Agra Highway	Gangapur Road	Nashik	Nashik	Maharashtra	422005
84	242	Work	Unit 931	Dwaraka Nagar Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
85	134	Home	45	100 Feet Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
86	579	Home	Plot 111	100 Feet Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560038
87	38	Home	Flat 4-2	LBS Marg	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400076
88	540	Home	228	FC Road	Shivajinagar	Pune	Pune	Maharashtra	411014
89	201	Home	151	Madhapur Main Road	Madhapur	Hyderabad	Hyderabad	Telangana	500084
90	72	Home	63	L B Road	Adyar	Chennai	Chennai	Tamil Nadu	600041
91	252	Home	99	Press Enclave Road	Lajpat Nagar	Delhi	South Delhi	Delhi	110048
92	54	Home	70	Gariahat Road	Kasba	Kolkata	Kolkata	West Bengal	700029
93	54	Work	Unit 721	Banerji Road, Corporate Tower	Kaloor	Kochi	Ernakulam	Kerala	682030
94	96	Home	Flat 4-8	MI Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302018
95	96	Work	Unit 213	NH 16, Business Park	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
96	578	Home	16-2	Vibhuti Khand Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226018
97	578	Work	Unit 980	Sinhagad Road, Corporate Tower	Hadapsar	Pune	Pune	Maharashtra	411004
98	73	Home	6-1	Seaport-Airport Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
99	30	Home	128	Hoshangabad Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462003
100	511	Home	257	Ring Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452016
101	366	Home	Flat 12-7	Madhya Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160017
102	142	Home	Flat 5-5	Beltola Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781022
103	70	Home	Flat 12-1	Bailey Road	Danapur	Patna	Patna	Bihar	800001
104	10	Home	255A	Central Avenue Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440010
105	529	Home	231	Seethammadhara Main Road	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
106	529	Work	Unit 475	NH 16, Market Plaza	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
107	207	Home	37A	Eluru Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
108	207	Work	Unit 416	Baner Road, Business Park	Kothrud	Pune	Pune	Maharashtra	411007
109	354	Home	242	Thadagam Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641012
110	354	Work	Unit 320	Banerji Road, Business Park	Edappally	Kochi	Ernakulam	Kerala	682017
111	177	Home	96	Nashik Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
112	291	Home	Flat 11-6	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
113	549	Home	144-1	Bannerghatta Road	Rajajinagar	Bengaluru	Bengaluru Urban	Karnataka	560076
114	326	Home	Flat 12-5	S V Road	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400053
115	55	Home	109	Karve Road	Viman Nagar	Pune	Pune	Maharashtra	411021
116	418	Home	145	Jubilee Hills Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500081
117	261	Home	Plot 89	Anna Salai	Guindy	Chennai	Chennai	Tamil Nadu	600020
118	390	Home	Plot 4	Mahatma Gandhi Marg	Saket	Delhi	South Delhi	Delhi	110017
119	390	Work	Unit 688	Baner Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411014
120	111	Home	Plot 194	Park Street	Alipore	Kolkata	Kolkata	West Bengal	700091
121	111	Work	Unit 139	NH 66, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
122	570	Home	Plot 198	Tonk Road	C Scheme	Jaipur	Jaipur	Rajasthan	302017
123	570	Work	Unit 710	Seethammadhara Main Road, Business Park	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
124	590	Home	Plot 166	Faizabad Road	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
125	126	Home	19	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682020
126	174	Home	Plot 10	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462042
127	520	Home	86	MG Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452020
128	343	Home	271	Udyan Path	Sector 17	Chandigarh	Chandigarh	Chandigarh	160009
129	445	Home	119	Beltola Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781007
130	100	Home	161-2	Boring Road	Bailey Road	Patna	Patna	Bihar	800013
131	412	Home	Plot 3	Kamptee Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440010
132	412	Work	Unit 807	NH 66, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682020
133	278	Home	47-2	Seethammadhara Main Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
134	278	Work	Unit 515	MVP Main Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
135	392	Home	Plot 120	MG Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
136	392	Work	Unit 431	Sinhagad Road, Corporate Tower	Wakad	Pune	Pune	Maharashtra	411038
137	81	Home	Plot 121	Sathy Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641012
138	195	Home	74	College Road	Cidco	Nashik	Nashik	Maharashtra	422010
139	233	Home	Plot 198	Iskcon Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
140	21	Home	Flat 9-1	Bannerghatta Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560076
141	400	Home	Plot 172	Andheri Kurla Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400050
142	461	Home	Flat 7-3	Baner Road	Viman Nagar	Pune	Pune	Maharashtra	411007
143	509	Home	66	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
144	167	Home	62B	L B Road	Velachery	Chennai	Chennai	Tamil Nadu	600018
145	167	Work	Unit 770	NH 16, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
146	381	Home	20B	Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110048
147	381	Work	Unit 129	Karve Road, Commercial Complex	Viman Nagar	Pune	Pune	Maharashtra	411014
148	173	Home	260	Rashbehari Avenue	Alipore	Kolkata	Kolkata	West Bengal	700031
149	173	Work	Unit 780	Seaport-Airport Road, Corporate Tower	Kaloor	Kochi	Ernakulam	Kerala	682020
150	288	Home	260	JLN Marg	Vaishali Nagar	Jaipur	Jaipur	Rajasthan	302019
151	146	Home	245	Shaheed Path	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226016
152	598	Home	Plot 154	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682016
153	130	Home	Flat 7-4	Link Road No. 1	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462016
154	469	Home	Plot 26	MR 10 Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452020
155	421	Home	116	Vikas Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
156	112	Home	Flat 4-2	Zoo Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
157	225	Home	Flat 6-3	Boring Road	Kankarbagh	Patna	Patna	Bihar	800004
158	225	Work	Unit 198	Paud Road, Corporate Tower	Aundh	Pune	Pune	Maharashtra	411007
159	264	Home	Flat 7-3	Amravati Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440012
160	264	Work	Unit 758	NH 66, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682020
161	556	Home	Plot 132	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
162	556	Work	Unit 985	Dwaraka Nagar Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
163	138	Home	228-1	NH 16	Governorpet	Vijayawada	NTR	Andhra Pradesh	520015
164	50	Home	Plot 117	Sathy Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641018
165	356	Home	Plot 20	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422005
166	345	Home	Flat 5-1	Judges Bungalow Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380015
167	254	Home	115A	100 Feet Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560076
168	396	Home	Plot 139	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400058
169	376	Home	27-1	Baner Road	Viman Nagar	Pune	Pune	Maharashtra	411007
170	359	Home	43	Kukatpally Main Road	Gachibowli	Hyderabad	Hyderabad	Telangana	500033
171	359	Work	Unit 511	Banerji Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682016
172	466	Home	20	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600018
173	466	Work	Unit 425	Dwaraka Nagar Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
174	153	Home	Flat 6-7	Ring Road	Lajpat Nagar	Delhi	South Delhi	Delhi	110017
175	153	Work	Unit 613	Nagar Road, Commercial Complex	Wakad	Pune	Pune	Maharashtra	411007
176	527	Home	Plot 32	Park Street	Salt Lake	Kolkata	Kolkata	West Bengal	700029
177	64	Home	Flat 11-7	Sawai Ram Singh Road	C Scheme	Jaipur	Jaipur	Rajasthan	302018
178	454	Home	201B	Shaheed Path	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226018
179	65	Home	Flat 3-5	NH 66	Edappally	Kochi	Ernakulam	Kerala	682030
180	158	Home	Flat 3-1	Hoshangabad Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462026
181	571	Home	Flat 9-3	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452020
182	161	Home	Plot 61	Vikas Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
183	457	Home	246	Zoo Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781022
184	457	Work	Unit 985	MVP Main Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
185	521	Home	277B	Fraser Road	Boring Road	Patna	Patna	Bihar	800013
186	521	Work	Unit 992	Nagar Road, Market Plaza	Kothrud	Pune	Pune	Maharashtra	411007
187	595	Home	258A	Amravati Road	Sadar	Nagpur	Nagpur	Maharashtra	440015
188	595	Work	Unit 111	MG Road, Trade Centre	Kaloor	Kochi	Ernakulam	Kerala	682024
189	394	Home	Plot 121	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
190	127	Home	Plot 16	Bandar Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
191	311	Home	95-1	Sathy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
192	20	Home	131	Gangapur Road	College Road	Nashik	Nashik	Maharashtra	422013
193	141	Home	38B	100 Feet Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380061
194	85	Home	15-2	Hosur Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560034
195	129	Home	Flat 3-6	Linking Road	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400058
196	489	Home	210-2	FC Road	Kharadi	Pune	Pune	Maharashtra	411038
197	489	Work	Unit 716	Paud Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411014
198	502	Home	249	Road No. 36	Hitech City	Hyderabad	Hyderabad	Telangana	500033
199	502	Work	Unit 216	Banerji Road, Commercial Complex	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
200	63	Home	52-2	Besant Avenue Road	Velachery	Chennai	Chennai	Tamil Nadu	600018
201	63	Work	Unit 928	Beach Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
202	220	Home	269	Press Enclave Road	South Extension	Delhi	South Delhi	Delhi	110017
203	554	Home	83	EM Bypass	Salt Lake	Kolkata	Kolkata	West Bengal	700091
204	505	Home	Plot 170	Ajmer Road	Raja Park	Jaipur	Jaipur	Rajasthan	302018
205	4	Home	Plot 74	Shaheed Path	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226010
206	577	Home	Plot 106	NH 66	Vyttila	Kochi	Ernakulam	Kerala	682017
207	559	Home	23-1	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462016
208	246	Home	Flat 7-3	MG Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452010
209	523	Home	168	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160022
210	523	Work	Unit 333	Sahodaran Ayyappan Road, Market Plaza	Panampilly Nagar	Kochi	Ernakulam	Kerala	682017
211	517	Home	82	VIP Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781005
212	517	Work	Unit 728	Beach Road, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
213	117	Home	Flat 11-5	Ashiana-Digha Road	Boring Road	Patna	Patna	Bihar	800013
214	117	Work	Unit 709	FC Road, Commercial Complex	Hadapsar	Pune	Pune	Maharashtra	411021
215	452	Home	Flat 10-8	Central Avenue Road	Sadar	Nagpur	Nagpur	Maharashtra	440015
216	346	Home	Flat 12-6	Seethammadhara Main Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
217	216	Home	239	Benz Circle Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
218	486	Home	57	Thadagam Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
219	442	Home	150-2	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422009
220	148	Home	Flat 1-1	100 Feet Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380054
221	22	Home	Plot 136	Bannerghatta Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
222	425	Home	Plot 183	Linking Road	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400050
223	425	Work	Unit 908	MVP Main Road, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
224	147	Home	204	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411021
225	147	Work	Unit 193	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411014
226	108	Home	205-1	Gachibowli Road	Madhapur	Hyderabad	Hyderabad	Telangana	500081
227	108	Work	Unit 461	Seaport-Airport Road, Business Park	Panampilly Nagar	Kochi	Ernakulam	Kerala	682017
228	115	Home	249A	Besant Avenue Road	Velachery	Chennai	Chennai	Tamil Nadu	600034
229	283	Home	Plot 89	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110048
230	25	Home	72	Prince Anwar Shah Road	Kasba	Kolkata	Kolkata	West Bengal	700031
231	467	Home	Flat 9-6	MI Road	Raja Park	Jaipur	Jaipur	Rajasthan	302018
232	313	Home	251	Vibhuti Khand Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226021
233	229	Home	Plot 148	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682017
234	143	Home	Flat 4-8	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462042
235	199	Home	Flat 3-3	Ring Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452016
236	199	Work	Unit 895	Paud Road, Market Plaza	Viman Nagar	Pune	Pune	Maharashtra	411004
237	302	Home	258-1	Jan Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160017
238	302	Work	Unit 499	Seaport-Airport Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682024
239	175	Home	38	RG Baruah Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
240	175	Work	Unit 575	Beach Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
241	544	Home	Flat 7-7	Bailey Road	Bailey Road	Patna	Patna	Bihar	800025
242	244	Home	137	Ring Road	Sadar	Nagpur	Nagpur	Maharashtra	440022
243	586	Home	Plot 33	NH 16	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
244	575	Home	Plot 181	NH 16	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520012
245	348	Home	196	Avinashi Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641035
246	449	Home	44-2	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422009
247	128	Home	87	Ashram Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380015
248	294	Home	126	100 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560034
249	294	Work	Unit 825	MG Road, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682030
250	17	Home	Flat 10-7	Andheri Kurla Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400050
251	17	Work	Unit 243	Dwaraka Nagar Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
252	139	Home	Flat 11-3	Paud Road	Shivajinagar	Pune	Pune	Maharashtra	411004
253	139	Work	Unit 640	Karve Road, Business Park	Hadapsar	Pune	Pune	Maharashtra	411021
254	145	Home	160	Jubilee Hills Road	Hitech City	Hyderabad	Hyderabad	Telangana	500033
255	144	Home	18-2	Anna Salai	Adyar	Chennai	Chennai	Tamil Nadu	600020
256	77	Home	Plot 36	Aurobindo Marg	Defence Colony	Delhi	South Delhi	Delhi	110017
257	256	Home	230	Park Street	Gariahat	Kolkata	Kolkata	West Bengal	700091
258	107	Home	236	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302019
259	237	Home	Plot 7	Vibhuti Khand Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226016
260	323	Home	Flat 5-8	Sahodaran Ayyappan Road	Kadavanthra	Kochi	Ernakulam	Kerala	682016
261	44	Home	249	Airport Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462026
262	44	Work	Unit 489	MVP Main Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
263	488	Home	9	Ring Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452016
264	488	Work	Unit 672	FC Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411007
265	380	Home	Flat 11-3	Himalaya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
266	380	Work	Unit 640	MG Road, Corporate Tower	Kadavanthra	Kochi	Ernakulam	Kerala	682020
267	592	Home	298	Zoo Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781022
268	432	Home	12-2	Fraser Road	Bailey Road	Patna	Patna	Bihar	800025
269	572	Home	31	Central Avenue Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440033
270	136	Home	Flat 12-6	Dwaraka Nagar Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
271	347	Home	Plot 85	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520012
272	383	Home	103	Avinashi Road	Gandhipuram	Coimbatore	Coimbatore	Tamil Nadu	641004
273	573	Home	Plot 2	Nashik Road	Gangapur Road	Nashik	Nashik	Maharashtra	422007
274	594	Home	80	Judges Bungalow Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380009
275	594	Work	Unit 762	Sinhagad Road, Trade Centre	Hadapsar	Pune	Pune	Maharashtra	411014
276	267	Home	198	80 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560038
277	267	Work	Unit 954	Seaport-Airport Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682016
278	547	Home	Plot 118	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400050
279	547	Work	Unit 561	Beach Road, Corporate Tower	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
280	333	Home	197-2	Baner Road	Kothrud	Pune	Pune	Maharashtra	411007
281	279	Home	Flat 12-6	Jubilee Hills Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500084
282	151	Home	89A	Velachery Main Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600018
283	94	Home	Flat 2-1	Press Enclave Road	Vasant Kunj	Delhi	South Delhi	Delhi	110025
284	235	Home	Flat 1-7	EM Bypass	New Town	Kolkata	Kolkata	West Bengal	700020
285	137	Home	Plot 188	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302017
286	26	Home	Flat 5-1	Shaheed Path	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226020
287	162	Home	Plot 79	Seaport-Airport Road	Kakkanad	Kochi	Ernakulam	Kerala	682024
288	162	Work	Unit 906	MG Road, Market Plaza	Kadavanthra	Kochi	Ernakulam	Kerala	682030
289	226	Home	137	Kolar Road	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462016
290	226	Work	Unit 329	MVP Main Road, Commercial Complex	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
291	534	Home	27A	Khandwa Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452017
292	534	Work	Unit 487	Sinhagad Road, Trade Centre	Shivajinagar	Pune	Pune	Maharashtra	411021
293	149	Home	Flat 5-3	Madhya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
294	365	Home	Flat 2-3	GS Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781005
295	223	Home	104	Kankarbagh Main Road	Patliputra Colony	Patna	Patna	Bihar	800025
296	45	Home	Flat 10-2	Kamptee Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440015
297	360	Home	Flat 9-2	Seethammadhara Main Road	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
298	378	Home	50B	Benz Circle Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
299	68	Home	Plot 8	Mettupalayam Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641004
300	282	Home	Plot 21	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422009
301	282	Work	Unit 119	Dwaraka Nagar Road, Corporate Tower	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
302	157	Home	Flat 10-4	Ashram Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380058
303	157	Work	Unit 466	Karve Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411014
304	482	Home	Flat 7-7	Hosur Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560034
305	482	Work	Unit 202	NH 66, Trade Centre	Palarivattom	Kochi	Ernakulam	Kerala	682016
306	16	Home	32	Western Express Highway	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400058
307	154	Home	Plot 175	Nagar Road	Aundh	Pune	Pune	Maharashtra	411007
308	351	Home	Plot 184	Gachibowli Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500081
309	391	Home	193	L B Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600020
310	569	Home	223	Mahatma Gandhi Marg	Defence Colony	Delhi	South Delhi	Delhi	110025
311	156	Home	Plot 177	Gariahat Road	Alipore	Kolkata	Kolkata	West Bengal	700020
312	3	Home	43	MI Road	Malviya Nagar	Jaipur	Jaipur	Rajasthan	302018
313	307	Home	Plot 98	Faizabad Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226016
314	307	Work	Unit 162	Baner Road, Corporate Tower	Shivajinagar	Pune	Pune	Maharashtra	411007
315	379	Home	Plot 169	Banerji Road	Vyttila	Kochi	Ernakulam	Kerala	682024
316	379	Work	Unit 586	Banerji Road, Business Park	Vyttila	Kochi	Ernakulam	Kerala	682017
317	470	Home	251	Bawadia Kalan Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462039
318	470	Work	Unit 545	Beach Road, Market Plaza	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
319	114	Home	233A	Khandwa Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452020
320	289	Home	245A	Himalaya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160019
321	395	Home	53	Beltola Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
322	410	Home	125A	Kankarbagh Main Road	Boring Road	Patna	Patna	Bihar	800013
323	240	Home	65	Amravati Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440015
324	553	Home	40	NH 16	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
325	437	Home	Plot 104	MG Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
326	91	Home	298	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641037
327	91	Work	Unit 549	Banerji Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682020
328	403	Home	Flat 11-1	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422010
329	403	Work	Unit 989	Dwaraka Nagar Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
330	227	Home	197B	Judges Bungalow Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380009
331	227	Work	Unit 800	Sinhagad Road, Commercial Complex	Aundh	Pune	Pune	Maharashtra	411038
332	485	Home	213	80 Feet Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560076
333	124	Home	122-2	LBS Marg	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400078
334	255	Home	Flat 5-7	Paud Road	Aundh	Pune	Pune	Maharashtra	411007
335	446	Home	278	Gachibowli Road	Jubilee Hills	Hyderabad	Hyderabad	Telangana	500034
336	123	Home	Plot 198	Anna Salai	Adyar	Chennai	Chennai	Tamil Nadu	600034
337	430	Home	5	Aurobindo Marg	Malviya Nagar	Delhi	South Delhi	Delhi	110025
338	303	Home	Flat 7-3	Rashbehari Avenue	Ballygunge	Kolkata	Kolkata	West Bengal	700019
339	451	Home	Plot 47	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302019
340	451	Work	Unit 118	Seethammadhara Main Road, Corporate Tower	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
341	166	Home	69	Shaheed Path	Alambagh	Lucknow	Lucknow	Uttar Pradesh	226021
342	166	Work	Unit 210	Sinhagad Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411007
343	9	Home	72	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682024
344	9	Work	Unit 711	Banerji Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682016
345	426	Home	Flat 5-2	Kolar Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462026
346	263	Home	Flat 6-4	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452010
347	481	Home	4A	Himalaya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160036
348	132	Home	Flat 5-5	Beltola Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781003
349	113	Home	Plot 54	Kankarbagh Main Road	Danapur	Patna	Patna	Bihar	800014
350	205	Home	Plot 10	Kamptee Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440022
351	155	Home	Flat 8-3	NH 16	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
352	567	Home	Plot 9	MG Road	Moghalrajpuram	Vijayawada	NTR	Andhra Pradesh	520015
353	567	Work	Unit 806	Baner Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411021
354	159	Home	Flat 9-1	Trichy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641004
355	159	Work	Unit 580	NH 66, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682030
356	183	Home	57B	College Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
357	183	Work	Unit 633	Beach Road, Corporate Tower	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
358	494	Home	262	C G Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380054
359	384	Home	249	80 Feet Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560034
360	92	Home	200B	LBS Marg	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400053
361	353	Home	Flat 11-7	Karve Road	Baner	Pune	Pune	Maharashtra	411004
362	98	Home	Flat 4-6	Road No. 36	Begumpet	Hyderabad	Hyderabad	Telangana	500033
363	428	Home	160	Mount Road	Anna Nagar	Chennai	Chennai	Tamil Nadu	600028
364	206	Home	112	Press Enclave Road	Hauz Khas	Delhi	South Delhi	Delhi	110019
365	332	Home	171-2	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700020
366	332	Work	Unit 635	Seaport-Airport Road, Corporate Tower	Palarivattom	Kochi	Ernakulam	Kerala	682016
367	420	Home	Plot 87	Sawai Ram Singh Road	Raja Park	Jaipur	Jaipur	Rajasthan	302019
368	420	Work	Unit 556	MVP Main Road, Business Park	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
369	368	Home	Plot 179	Vibhuti Khand Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226021
370	368	Work	Unit 624	Paud Road, Corporate Tower	Baner	Pune	Pune	Maharashtra	411038
371	465	Home	Flat 11-5	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682030
372	40	Home	287	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462003
373	74	Home	Flat 4-7	MG Road	Rau	Indore	Indore	Madhya Pradesh	452020
374	105	Home	110	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
375	585	Home	Plot 106	Zoo Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
376	600	Home	173	Kankarbagh Main Road	Boring Road	Patna	Patna	Bihar	800001
377	106	Home	Plot 182	Ring Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440022
378	290	Home	Flat 2-8	MVP Main Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
379	290	Work	Unit 990	Seethammadhara Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
380	58	Home	13	MG Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520010
381	58	Work	Unit 332	Sinhagad Road, Business Park	Wakad	Pune	Pune	Maharashtra	411038
382	308	Home	220	Trichy Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641035
383	308	Work	Unit 285	Seaport-Airport Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682020
384	584	Home	253	Nashik Road	Nashik Road	Nashik	Nashik	Maharashtra	422007
385	340	Home	Flat 2-8	Iskcon Road	Bodakdev	Ahmedabad	Ahmedabad	Gujarat	380054
386	238	Home	Flat 9-8	Outer Ring Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560034
387	265	Home	253	Linking Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400076
388	478	Home	131-1	Nagar Road	Wakad	Pune	Pune	Maharashtra	411004
389	179	Home	238-1	Gachibowli Road	Madhapur	Hyderabad	Hyderabad	Telangana	500081
390	11	Home	211	L B Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600028
391	219	Home	Flat 3-5	Press Enclave Road	Vasant Kunj	Delhi	South Delhi	Delhi	110025
392	219	Work	Unit 813	Nagar Road, Commercial Complex	Hadapsar	Pune	Pune	Maharashtra	411038
393	277	Home	Plot 59	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700091
394	277	Work	Unit 650	NH 66, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682017
395	597	Home	5	MI Road	Vaishali Nagar	Jaipur	Jaipur	Rajasthan	302018
396	597	Work	Unit 616	Seethammadhara Main Road, Business Park	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
397	53	Home	221	Vibhuti Khand Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
398	331	Home	187	Seaport-Airport Road	Kaloor	Kochi	Ernakulam	Kerala	682017
399	164	Home	288-2	Airport Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462026
400	455	Home	Flat 10-3	MG Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452001
401	269	Home	Plot 167	Madhya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160017
402	110	Home	Flat 5-2	VIP Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781007
403	243	Home	Flat 7-2	Bailey Road	Patliputra Colony	Patna	Patna	Bihar	800001
404	357	Home	Plot 161	Kamptee Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440033
405	357	Work	Unit 724	MG Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682017
406	253	Home	Flat 1-3	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
407	253	Work	Unit 422	Beach Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
408	66	Home	87	Eluru Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520010
409	66	Work	Unit 264	Nagar Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411004
410	131	Home	Plot 111	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641004
411	101	Home	297	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422010
412	210	Home	33	Iskcon Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380058
413	530	Home	84B	Hosur Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560102
414	160	Home	Flat 11-1	Andheri Kurla Road	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400058
415	51	Home	Flat 1-8	Sinhagad Road	Kothrud	Pune	Pune	Maharashtra	411014
416	217	Home	Plot 149	Road No. 36	Madhapur	Hyderabad	Hyderabad	Telangana	500081
417	193	Home	Plot 125	Velachery Main Road	Mylapore	Chennai	Chennai	Tamil Nadu	600018
418	193	Work	Unit 525	MVP Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
419	1	Home	Plot 33	Outer Ring Road	Saket	Delhi	South Delhi	Delhi	110025
420	1	Work	Unit 575	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411004
421	176	Home	Flat 2-4	EM Bypass	Salt Lake	Kolkata	Kolkata	West Bengal	700091
422	176	Work	Unit 362	Sahodaran Ayyappan Road, Market Plaza	Kakkanad	Kochi	Ernakulam	Kerala	682017
423	125	Home	Plot 84	Ajmer Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302017
424	163	Home	185	Kanpur Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
425	215	Home	92	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682020
426	438	Home	11-1	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462042
427	563	Home	Plot 141	Khandwa Road	Palasia	Indore	Indore	Madhya Pradesh	452017
428	258	Home	194	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160019
429	468	Home	103A	Zoo Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
430	344	Home	243	Boring Road	Patliputra Colony	Patna	Patna	Bihar	800004
431	344	Work	Unit 628	Paud Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411004
432	118	Home	61	Kamptee Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440012
433	118	Work	Unit 335	Seaport-Airport Road, Commercial Complex	Vyttila	Kochi	Ernakulam	Kerala	682024
434	487	Home	Flat 2-8	MVP Main Road	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
435	487	Work	Unit 849	Beach Road, Commercial Complex	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
436	561	Home	34	Benz Circle Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
437	317	Home	100	Thadagam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641004
438	493	Home	188-1	Mumbai-Agra Highway	Gangapur Road	Nashik	Nashik	Maharashtra	422007
439	375	Home	Plot 84	C G Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380054
440	539	Home	150-2	80 Feet Road	Malleshwaram	Bengaluru	Bengaluru Urban	Karnataka	560038
441	498	Home	62	Western Express Highway	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400050
442	491	Home	Plot 105	Nagar Road	Hadapsar	Pune	Pune	Maharashtra	411007
443	71	Home	136B	Madhapur Main Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500034
444	71	Work	Unit 206	Seaport-Airport Road, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
445	433	Home	Plot 64	L B Road	Adyar	Chennai	Chennai	Tamil Nadu	600028
446	433	Work	Unit 762	Seethammadhara Main Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
447	507	Home	36-2	Ring Road	South Extension	Delhi	South Delhi	Delhi	110017
448	507	Work	Unit 226	Karve Road, Corporate Tower	Hadapsar	Pune	Pune	Maharashtra	411021
449	484	Home	157	Rashbehari Avenue	Park Street	Kolkata	Kolkata	West Bengal	700019
450	320	Home	Plot 171	MI Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302017
451	186	Home	40	Gomti Nagar Extension Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226020
452	439	Home	212-1	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682030
453	399	Home	Plot 7	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462039
454	528	Home	Plot 88	Ring Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452016
455	239	Home	54	Madhya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160017
456	367	Home	Plot 153	VIP Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
457	367	Work	Unit 770	Dwaraka Nagar Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
458	312	Home	123A	Fraser Road	Patliputra Colony	Patna	Patna	Bihar	800004
459	312	Work	Unit 726	Karve Road, Market Plaza	Baner	Pune	Pune	Maharashtra	411007
460	29	Home	49	Kamptee Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440010
461	29	Work	Unit 785	Banerji Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682016
462	245	Home	Flat 5-8	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
463	364	Home	Plot 113	Benz Circle Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520015
464	80	Home	Plot 17	Thadagam Road	Saibaba Colony	Coimbatore	Coimbatore	Tamil Nadu	641035
465	297	Home	Flat 4-1	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422005
466	116	Home	Plot 162	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380015
467	82	Home	265	Bannerghatta Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560102
468	198	Home	Flat 8-8	Western Express Highway	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400078
469	350	Home	Flat 12-1	Baner Road	Baner	Pune	Pune	Maharashtra	411004
470	350	Work	Unit 257	Paud Road, Corporate Tower	Shivajinagar	Pune	Pune	Maharashtra	411038
471	184	Home	Plot 189	Gachibowli Road	Hitech City	Hyderabad	Hyderabad	Telangana	500033
472	184	Work	Unit 765	Seaport-Airport Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682024
473	260	Home	175	Besant Avenue Road	Mylapore	Chennai	Chennai	Tamil Nadu	600020
474	260	Work	Unit 694	MVP Main Road, Business Park	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
475	32	Home	61	Mahatma Gandhi Marg	South Extension	Delhi	South Delhi	Delhi	110019
476	411	Home	Flat 4-3	Gariahat Road	Jadavpur	Kolkata	Kolkata	West Bengal	700020
477	257	Home	191A	Tonk Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302004
478	213	Home	Flat 3-8	Faizabad Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
479	209	Home	Flat 11-4	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682030
480	398	Home	276	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462003
481	464	Home	Flat 4-3	MR 10 Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452010
482	460	Home	Flat 12-1	Jan Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160019
483	460	Work	Unit 646	Sahodaran Ayyappan Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682016
484	104	Home	Plot 166	GS Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
485	104	Work	Unit 336	Dwaraka Nagar Road, Commercial Complex	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
486	231	Home	Plot 185	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800001
487	231	Work	Unit 832	FC Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411014
488	566	Home	158	Wardha Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440022
489	204	Home	Flat 7-3	Beach Road	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
490	83	Home	182	Eluru Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520013
491	435	Home	Flat 9-7	Trichy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
492	192	Home	Flat 6-7	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422009
493	248	Home	179	Judges Bungalow Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380061
494	2	Home	69	80 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
495	247	Home	40	Linking Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400053
496	247	Work	Unit 462	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
497	35	Home	Flat 11-3	Karve Road	Shivajinagar	Pune	Pune	Maharashtra	411007
498	35	Work	Unit 364	Paud Road, Trade Centre	Kharadi	Pune	Pune	Maharashtra	411038
499	337	Home	Plot 144	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500033
500	337	Work	Unit 333	Sahodaran Ayyappan Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682017
501	462	Home	Flat 2-2	L B Road	T Nagar	Chennai	Chennai	Tamil Nadu	600034
502	503	Home	94	Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110017
503	75	Home	87A	Prince Anwar Shah Road	Ballygunge	Kolkata	Kolkata	West Bengal	700031
504	519	Home	Plot 81	JLN Marg	Jagatpura	Jaipur	Jaipur	Rajasthan	302021
505	405	Home	Plot 180	Vibhuti Khand Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226021
506	90	Home	199	NH 66	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
507	274	Home	Plot 114	Bawadia Kalan Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462042
508	218	Home	245A	AB Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452001
509	218	Work	Unit 511	FC Road, Market Plaza	Baner	Pune	Pune	Maharashtra	411004
510	236	Home	Flat 11-5	Udyan Path	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
511	236	Work	Unit 698	MG Road, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682030
512	550	Home	Plot 48	VIP Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781005
513	550	Work	Unit 561	NH 16, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
514	472	Home	Flat 12-8	Bailey Road	Rajendra Nagar	Patna	Patna	Bihar	800004
515	424	Home	226A	Central Avenue Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440015
516	315	Home	Flat 5-2	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
517	314	Home	Plot 33	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
518	299	Home	Flat 10-1	Thadagam Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
519	599	Home	75	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422005
520	232	Home	Flat 5-6	S G Highway	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380061
521	60	Home	Plot 183	80 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560040
522	60	Work	Unit 761	Sahodaran Ayyappan Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682030
523	95	Home	Plot 125	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400053
590	250	Home	Plot 14	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462003
524	95	Work	Unit 431	MVP Main Road, Market Plaza	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
525	122	Home	Flat 9-2	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411038
526	122	Work	Unit 857	Sinhagad Road, Commercial Complex	Viman Nagar	Pune	Pune	Maharashtra	411007
527	415	Home	127-1	Madhapur Main Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500034
528	293	Home	173	Anna Salai	Velachery	Chennai	Chennai	Tamil Nadu	600041
529	319	Home	75-2	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110025
530	377	Home	Flat 8-3	Gariahat Road	Alipore	Kolkata	Kolkata	West Bengal	700019
531	499	Home	Plot 4	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302017
532	327	Home	Flat 10-2	Vibhuti Khand Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226021
533	537	Home	Flat 3-4	NH 66	Kakkanad	Kochi	Ernakulam	Kerala	682030
534	515	Home	226-2	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462003
535	515	Work	Unit 886	Beach Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
536	508	Home	149	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452017
537	508	Work	Unit 135	Sinhagad Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411021
538	121	Home	88	Madhya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160019
539	121	Work	Unit 447	Seaport-Airport Road, Trade Centre	Edappally	Kochi	Ernakulam	Kerala	682016
540	500	Home	Plot 111	Zoo Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781022
541	408	Home	Flat 7-5	Ashiana-Digha Road	Danapur	Patna	Patna	Bihar	800014
542	371	Home	Flat 2-1	Kamptee Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440022
543	417	Home	Flat 8-2	MVP Main Road	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
544	560	Home	130	MG Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520016
545	214	Home	Plot 2	Avinashi Road	Gandhipuram	Coimbatore	Coimbatore	Tamil Nadu	641037
546	406	Home	208-2	Mumbai-Agra Highway	Cidco	Nashik	Nashik	Maharashtra	422010
547	224	Home	214	C G Road	Bodakdev	Ahmedabad	Ahmedabad	Gujarat	380054
548	224	Work	Unit 356	FC Road, Corporate Tower	Viman Nagar	Pune	Pune	Maharashtra	411014
549	476	Home	Plot 181	Bannerghatta Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
550	476	Work	Unit 676	Seaport-Airport Road, Commercial Complex	Kadavanthra	Kochi	Ernakulam	Kerala	682020
551	170	Home	246A	Powai Road	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400053
552	170	Work	Unit 352	MVP Main Road, Business Park	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
553	551	Home	290	FC Road	Kothrud	Pune	Pune	Maharashtra	411021
554	19	Home	Flat 5-6	Madhapur Main Road	Kondapur	Hyderabad	Hyderabad	Telangana	500084
555	287	Home	49A	Besant Avenue Road	Adyar	Chennai	Chennai	Tamil Nadu	600018
556	109	Home	168	Ring Road	Saket	Delhi	South Delhi	Delhi	110016
557	419	Home	Plot 99	Prince Anwar Shah Road	Gariahat	Kolkata	Kolkata	West Bengal	700020
558	574	Home	Plot 103	Sawai Ram Singh Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302004
559	120	Home	Plot 174	Vibhuti Khand Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226020
560	262	Home	Plot 85	Sahodaran Ayyappan Road	Kadavanthra	Kochi	Ernakulam	Kerala	682017
561	262	Work	Unit 218	MG Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682020
562	34	Home	Plot 27	Hoshangabad Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462016
563	34	Work	Unit 665	NH 16, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
564	448	Home	36B	MG Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452017
565	448	Work	Unit 587	Nagar Road, Commercial Complex	Kharadi	Pune	Pune	Maharashtra	411007
566	459	Home	52	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
567	180	Home	Plot 163	Beltola Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
568	516	Home	10B	Bailey Road	Danapur	Patna	Patna	Bihar	800013
569	588	Home	67	Ring Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440022
570	504	Home	Plot 122	Dwaraka Nagar Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
571	84	Home	160	NH 16	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
572	18	Home	Plot 16	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
573	251	Home	231	Gangapur Road	Nashik Road	Nashik	Nashik	Maharashtra	422010
574	251	Work	Unit 770	MVP Main Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
575	43	Home	29	S G Highway	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380061
576	43	Work	Unit 118	Karve Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411021
577	497	Home	Flat 11-8	Hosur Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560040
578	497	Work	Unit 606	MG Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682024
579	422	Home	101B	S V Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400050
580	202	Home	Plot 51	Nagar Road	Baner	Pune	Pune	Maharashtra	411038
581	562	Home	Flat 12-8	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500032
582	31	Home	Plot 29	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600041
583	292	Home	268-2	Aurobindo Marg	Lajpat Nagar	Delhi	South Delhi	Delhi	110016
584	187	Home	196	Park Street	Jadavpur	Kolkata	Kolkata	West Bengal	700020
585	89	Home	Plot 16	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302004
586	444	Home	31-1	Gomti Nagar Extension Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226016
587	444	Work	Unit 411	Paud Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411007
588	334	Home	Flat 8-1	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682030
589	334	Work	Unit 653	Sahodaran Ayyappan Road, Trade Centre	Kadavanthra	Kochi	Ernakulam	Kerala	682020
591	250	Work	Unit 599	Seethammadhara Main Road, Corporate Tower	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
592	212	Home	127	AB Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452020
593	49	Home	120	Madhya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
594	512	Home	113A	VIP Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781005
595	301	Home	7B	Kankarbagh Main Road	Patliputra Colony	Patna	Patna	Bihar	800013
596	335	Home	Plot 141	Central Avenue Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440033
597	393	Home	172-2	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
598	266	Home	214-1	MG Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520015
599	135	Home	Plot 98	Sathy Road	Saibaba Colony	Coimbatore	Coimbatore	Tamil Nadu	641018
600	135	Work	Unit 405	Seaport-Airport Road, Market Plaza	Kaloor	Kochi	Ernakulam	Kerala	682020
601	62	Home	Flat 3-3	College Road	College Road	Nashik	Nashik	Maharashtra	422013
602	62	Work	Unit 750	MVP Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
603	589	Home	299B	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
604	589	Work	Unit 662	Sinhagad Road, Trade Centre	Viman Nagar	Pune	Pune	Maharashtra	411014
605	39	Home	Plot 74	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560038
606	57	Home	135-1	Powai Road	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400053
607	538	Home	Flat 3-2	Sinhagad Road	Baner	Pune	Pune	Maharashtra	411004
608	440	Home	Plot 176	Jubilee Hills Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
609	409	Home	Flat 3-6	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600041
610	389	Home	Flat 1-1	Outer Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110016
611	203	Home	Plot 169	Prince Anwar Shah Road	Alipore	Kolkata	Kolkata	West Bengal	700091
612	99	Home	98	Ajmer Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302021
613	99	Work	Unit 950	Seethammadhara Main Road, Business Park	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
614	270	Home	60-1	Kanpur Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226021
615	270	Work	Unit 314	Karve Road, Corporate Tower	Kothrud	Pune	Pune	Maharashtra	411021
616	318	Home	288-1	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682017
617	318	Work	Unit 523	MG Road, Business Park	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
618	526	Home	262	Bawadia Kalan Road	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462003
619	188	Home	225	Ring Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452001
620	88	Home	28B	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
621	275	Home	117	RG Baruah Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
622	306	Home	29	Bailey Road	Rajendra Nagar	Patna	Patna	Bihar	800013
623	241	Home	227A	Wardha Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440033
624	495	Home	Flat 7-6	NH 16	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
625	453	Home	Plot 32	NH 16	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
626	453	Work	Unit 185	Karve Road, Corporate Tower	Baner	Pune	Pune	Maharashtra	411014
627	33	Home	Flat 7-4	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
628	33	Work	Unit 567	Banerji Road, Market Plaza	Edappally	Kochi	Ernakulam	Kerala	682030
629	133	Home	145	Gangapur Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
630	133	Work	Unit 995	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
631	59	Home	120	Judges Bungalow Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
632	548	Home	Plot 77	80 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
633	12	Home	Plot 104	Linking Road	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400076
634	386	Home	122	Karve Road	Wakad	Pune	Pune	Maharashtra	411004
635	178	Home	219A	Jubilee Hills Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500081
636	190	Home	Flat 4-4	Besant Avenue Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600018
637	431	Home	Flat 2-4	Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110017
638	363	Home	209	Rashbehari Avenue	Alipore	Kolkata	Kolkata	West Bengal	700019
639	363	Work	Unit 842	NH 66, Market Plaza	Vyttila	Kochi	Ernakulam	Kerala	682020
640	189	Home	Plot 159	Sawai Ram Singh Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302019
641	189	Work	Unit 114	MVP Main Road, Commercial Complex	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
642	321	Home	Flat 4-2	Kanpur Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226020
643	321	Work	Unit 177	Karve Road, Corporate Tower	Viman Nagar	Pune	Pune	Maharashtra	411014
644	304	Home	Plot 187	Seaport-Airport Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
645	414	Home	229	Hoshangabad Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462039
646	27	Home	Flat 3-5	AB Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452016
647	361	Home	29	Udyan Path	Sector 15	Chandigarh	Chandigarh	Chandigarh	160009
648	475	Home	11A	RG Baruah Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
649	298	Home	Flat 3-1	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800013
650	524	Home	202	Wardha Road	Sadar	Nagpur	Nagpur	Maharashtra	440012
651	362	Home	Flat 11-3	Seethammadhara Main Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
652	362	Work	Unit 498	MVP Main Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
653	382	Home	Plot 28	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
654	382	Work	Unit 982	FC Road, Commercial Complex	Kharadi	Pune	Pune	Maharashtra	411014
655	342	Home	Plot 25	Mettupalayam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641035
656	342	Work	Unit 244	MG Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682024
657	172	Home	117	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422009
658	152	Home	Flat 2-3	C G Road	Thaltej	Ahmedabad	Ahmedabad	Gujarat	380009
659	434	Home	273	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560040
660	542	Home	Flat 3-3	Western Express Highway	Powai	Mumbai	Mumbai Suburban	Maharashtra	400078
661	211	Home	Plot 42	Baner Road	Kharadi	Pune	Pune	Maharashtra	411007
662	296	Home	Flat 8-8	Madhapur Main Road	Gachibowli	Hyderabad	Hyderabad	Telangana	500084
663	194	Home	147-2	Arcot Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600028
664	197	Home	240B	Press Enclave Road	Saket	Delhi	South Delhi	Delhi	110048
665	197	Work	Unit 174	Nagar Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411004
666	397	Home	13	Park Street	Ballygunge	Kolkata	Kolkata	West Bengal	700020
667	397	Work	Unit 980	Sahodaran Ayyappan Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682024
668	86	Home	86	Sawai Ram Singh Road	C Scheme	Jaipur	Jaipur	Rajasthan	302021
669	86	Work	Unit 736	Seethammadhara Main Road, Business Park	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
670	555	Home	Plot 146	Faizabad Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226018
671	221	Home	135	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682016
672	522	Home	237A	Kolar Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462026
673	14	Home	153	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452001
674	373	Home	Flat 4-3	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160009
675	338	Home	98-2	VIP Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
676	76	Home	117-2	Ashiana-Digha Road	Bailey Road	Patna	Patna	Bihar	800013
677	536	Home	Plot 187	Central Avenue Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440033
678	536	Work	Unit 877	Seaport-Airport Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682020
679	46	Home	237-2	Dwaraka Nagar Road	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
680	46	Work	Unit 212	NH 16, Market Plaza	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
681	557	Home	Flat 9-5	Eluru Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
682	557	Work	Unit 693	Baner Road, Commercial Complex	Wakad	Pune	Pune	Maharashtra	411004
683	423	Home	Flat 9-8	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641004
684	402	Home	225	Trimbak Road	Cidco	Nashik	Nashik	Maharashtra	422009
685	280	Home	279	C G Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380009
686	171	Home	187A	Bannerghatta Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560040
687	295	Home	Flat 3-4	Western Express Highway	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400078
688	587	Home	Flat 3-8	Karve Road	Hadapsar	Pune	Pune	Maharashtra	411014
689	93	Home	85B	Road No. 10	Banjara Hills	Hyderabad	Hyderabad	Telangana	500034
690	268	Home	195	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600028
691	268	Work	Unit 745	NH 16, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
692	305	Home	224	Mahatma Gandhi Marg	Malviya Nagar	Delhi	South Delhi	Delhi	110025
693	305	Work	Unit 322	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411004
694	576	Home	Flat 7-1	Gariahat Road	Ballygunge	Kolkata	Kolkata	West Bengal	700020
695	576	Work	Unit 649	Banerji Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682024
696	490	Home	171A	MI Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302004
697	328	Home	180	Shaheed Path	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
698	281	Home	Plot 45	NH 66	Kadavanthra	Kochi	Ernakulam	Kerala	682024
699	473	Home	29	Airport Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462003
700	447	Home	79	MG Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452010
701	259	Home	94B	Udyan Path	Sector 8	Chandigarh	Chandigarh	Chandigarh	160019
702	372	Home	Plot 7	RG Baruah Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781007
703	140	Home	55-1	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800001
704	140	Work	Unit 164	FC Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411021
705	69	Home	32	Kamptee Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440010
706	69	Work	Unit 549	Seaport-Airport Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682030
707	191	Home	192-1	Beach Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
708	191	Work	Unit 651	Dwaraka Nagar Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
709	349	Home	152-1	MG Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
710	271	Home	Plot 17	Thadagam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641037
711	352	Home	Flat 11-2	Gangapur Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
712	196	Home	165	C G Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380058
713	336	Home	Flat 2-2	100 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
714	543	Home	154	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400076
715	13	Home	Plot 121	FC Road	Viman Nagar	Pune	Pune	Maharashtra	411021
716	552	Home	Flat 10-4	Madhapur Main Road	Madhapur	Hyderabad	Hyderabad	Telangana	500033
717	552	Work	Unit 382	Banerji Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682024
718	272	Home	42	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600034
719	272	Work	Unit 803	Beach Road, Market Plaza	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
720	583	Home	Plot 127	Outer Ring Road	Saket	Delhi	South Delhi	Delhi	110016
721	583	Work	Unit 690	Karve Road, Trade Centre	Baner	Pune	Pune	Maharashtra	411014
722	506	Home	Plot 164	EM Bypass	Jadavpur	Kolkata	Kolkata	West Bengal	700019
723	42	Home	Plot 50	JLN Marg	Raja Park	Jaipur	Jaipur	Rajasthan	302018
724	404	Home	Plot 136	Kanpur Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226021
725	36	Home	Plot 72	Sahodaran Ayyappan Road	Vyttila	Kochi	Ernakulam	Kerala	682024
726	185	Home	Flat 4-8	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462016
727	150	Home	136	AB Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452016
728	591	Home	Flat 2-1	Madhya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160009
729	541	Home	192	Zoo Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781003
730	541	Work	Unit 616	NH 16, Corporate Tower	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
731	427	Home	192-1	Ashiana-Digha Road	Bailey Road	Patna	Patna	Bihar	800013
732	427	Work	Unit 707	Nagar Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411021
733	582	Home	Plot 13	Amravati Road	Sadar	Nagpur	Nagpur	Maharashtra	440010
734	582	Work	Unit 523	NH 66, Business Park	Kakkanad	Kochi	Ernakulam	Kerala	682016
735	276	Home	27-1	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
736	169	Home	172	NH 16	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
737	545	Home	249-2	Mettupalayam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641037
738	208	Home	Flat 9-5	Trimbak Road	Indira Nagar	Nashik	Nashik	Maharashtra	422005
739	103	Home	Plot 142	Iskcon Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380009
740	558	Home	Flat 8-5	100 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
741	525	Home	Plot 5	Linking Road	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400058
742	456	Home	131	Karve Road	Shivajinagar	Pune	Pune	Maharashtra	411007
743	456	Work	Unit 144	Nagar Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411007
744	286	Home	155B	Road No. 10	Madhapur	Hyderabad	Hyderabad	Telangana	500084
745	286	Work	Unit 979	MG Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682017
746	518	Home	38B	Velachery Main Road	T Nagar	Chennai	Chennai	Tamil Nadu	600028
747	518	Work	Unit 859	Dwaraka Nagar Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
748	8	Home	Plot 69	Mahatma Gandhi Marg	Greater Kailash	Delhi	South Delhi	Delhi	110019
749	249	Home	Flat 9-3	Gariahat Road	Salt Lake	Kolkata	Kolkata	West Bengal	700019
750	48	Home	Plot 158	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302018
751	413	Home	Plot 163	Gomti Nagar Extension Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226018
752	67	Home	297	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682020
753	330	Home	Plot 17	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462016
754	385	Home	Plot 117	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452001
755	79	Home	Flat 8-5	Vikas Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160022
756	79	Work	Unit 897	Seaport-Airport Road, Corporate Tower	Palarivattom	Kochi	Ernakulam	Kerala	682024
757	358	Home	79	Zoo Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781003
758	358	Work	Unit 954	Seethammadhara Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
759	546	Home	165	Kankarbagh Main Road	Bailey Road	Patna	Patna	Bihar	800001
760	546	Work	Unit 131	Nagar Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411014
761	182	Home	2	Wardha Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440010
762	87	Home	Plot 70	Beach Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
763	510	Home	195	Bandar Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520015
764	41	Home	84	Trichy Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641004
765	28	Home	112-2	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422005
766	441	Home	15A	C G Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
767	479	Home	222-2	100 Feet Road	Rajajinagar	Bengaluru	Bengaluru Urban	Karnataka	560038
768	284	Home	211-2	Powai Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400050
769	284	Work	Unit 144	MVP Main Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
770	581	Home	Plot 173	Karve Road	Aundh	Pune	Pune	Maharashtra	411004
771	581	Work	Unit 206	Baner Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411038
772	52	Home	Plot 33	Road No. 10	Begumpet	Hyderabad	Hyderabad	Telangana	500033
773	52	Work	Unit 382	Banerji Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682024
774	23	Home	133B	Anna Salai	Mylapore	Chennai	Chennai	Tamil Nadu	600028
775	429	Home	Flat 4-3	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110019
776	514	Home	16-2	Park Street	Salt Lake	Kolkata	Kolkata	West Bengal	700031
777	316	Home	Flat 6-1	JLN Marg	Tonk Road	Jaipur	Jaipur	Rajasthan	302019
778	228	Home	Plot 76	Vibhuti Khand Road	Alambagh	Lucknow	Lucknow	Uttar Pradesh	226010
779	416	Home	Plot 130	Sahodaran Ayyappan Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
780	474	Home	289-2	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462042
813	168	Home	Plot 93	Iskcon Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380058
814	168	Work	Unit 879	Paud Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411007
815	310	Home	26	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560102
816	310	Work	Unit 183	Banerji Road, Trade Centre	Palarivattom	Kochi	Ernakulam	Kerala	682020
817	596	Home	Flat 6-4	Linking Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400076
818	596	Work	Unit 320	Beach Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
819	436	Home	158	Paud Road	Aundh	Pune	Pune	Maharashtra	411007
820	5	Home	Flat 5-5	Road No. 36	Madhapur	Hyderabad	Hyderabad	Telangana	500081
821	6	Home	Plot 74	Velachery Main Road	Adyar	Chennai	Chennai	Tamil Nadu	600020
822	463	Home	190B	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110017
823	234	Home	Flat 7-5	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700029
824	532	Home	213	MI Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302021
825	285	Home	20	Vibhuti Khand Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
826	492	Home	Plot 50	Banerji Road	Edappally	Kochi	Ernakulam	Kerala	682017
827	492	Work	Unit 606	Sahodaran Ayyappan Road, Commercial Complex	Palarivattom	Kochi	Ernakulam	Kerala	682030
828	7	Home	61-1	Hoshangabad Road	Shahpura	Bhopal	Bhopal	Madhya Pradesh	462026
829	7	Work	Unit 225	Beach Road, Market Plaza	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
830	477	Home	2	MR 10 Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452020
831	477	Work	Unit 908	Sinhagad Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411021
832	387	Home	133	Madhya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160017
833	47	Home	Flat 5-2	VIP Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781007
834	102	Home	Plot 33	Boring Road	Danapur	Patna	Patna	Bihar	800004
835	531	Home	Flat 8-8	Amravati Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440010
836	564	Home	197	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
837	388	Home	187	Eluru Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
838	483	Home	Plot 170	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641035
839	324	Home	255	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422007
840	324	Work	Unit 969	Beach Road, Trade Centre	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
841	222	Home	Plot 199	100 Feet Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380061
842	222	Work	Unit 183	FC Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411014
843	565	Home	167A	Hosur Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560038
844	565	Work	Unit 990	MG Road, Business Park	Edappally	Kochi	Ernakulam	Kerala	682016
845	97	Home	Plot 138	Powai Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400053
846	370	Home	89-1	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411038
847	480	Home	Flat 11-8	Jubilee Hills Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
848	309	Home	Flat 11-6	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600028
849	450	Home	Flat 9-2	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110016
850	501	Home	Plot 150	EM Bypass	Kasba	Kolkata	Kolkata	West Bengal	700029
851	15	Home	Plot 118	Tonk Road	Malviya Nagar	Jaipur	Jaipur	Rajasthan	302004
852	61	Home	Flat 9-3	Gomti Nagar Extension Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226016
853	61	Work	Unit 223	Sinhagad Road, Trade Centre	Viman Nagar	Pune	Pune	Maharashtra	411004
854	341	Home	48-2	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682016
855	341	Work	Unit 205	NH 66, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
856	401	Home	Flat 5-8	Link Road No. 1	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462016
857	401	Work	Unit 603	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
858	355	Home	45B	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452020
859	119	Home	Flat 2-3	Himalaya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160009
860	593	Home	1	Beltola Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
861	496	Home	Plot 175	Fraser Road	Kankarbagh	Patna	Patna	Bihar	800004
862	535	Home	281-2	Amravati Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440015
863	407	Home	Plot 85	Dwaraka Nagar Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
864	443	Home	9-1	Bandar Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
865	568	Home	Flat 8-6	Mettupalayam Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
866	568	Work	Unit 593	Sahodaran Ayyappan Road, Commercial Complex	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
867	322	Home	7	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422013
868	322	Work	Unit 626	Seethammadhara Main Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
869	181	Home	Flat 2-5	Iskcon Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
870	181	Work	Unit 400	Sinhagad Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411021
871	471	Home	137B	Sarjapur Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
872	300	Home	237	LBS Marg	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400078
873	458	Home	Plot 61	Paud Road	Viman Nagar	Pune	Pune	Maharashtra	411014
874	339	Home	Flat 3-6	Kukatpally Main Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500033
875	78	Home	Flat 12-2	Arcot Road	Guindy	Chennai	Chennai	Tamil Nadu	600020
876	273	Home	266	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110048
877	513	Home	Plot 171	EM Bypass	Kasba	Kolkata	Kolkata	West Bengal	700019
878	329	Home	271	Ajmer Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302004
879	329	Work	Unit 113	NH 16, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
880	56	Home	Flat 6-4	Gomti Nagar Extension Road	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226021
881	56	Work	Unit 612	Baner Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411004
882	325	Home	47-1	Banerji Road	Kadavanthra	Kochi	Ernakulam	Kerala	682030
883	325	Work	Unit 129	Banerji Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682017
884	200	Home	Flat 2-8	Link Road No. 1	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462039
885	165	Home	Flat 5-2	Khandwa Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452017
886	580	Home	177-1	Madhya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160009
887	369	Home	273A	Zoo Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781007
888	37	Home	171-2	Boring Road	Danapur	Patna	Patna	Bihar	800014
889	533	Home	Flat 4-6	Wardha Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440015
890	374	Home	Plot 121	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
891	230	Home	207-2	NH 16	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520013
892	230	Work	Unit 970	Baner Road, Business Park	Kothrud	Pune	Pune	Maharashtra	411007
893	24	Home	58A	Sathy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641018
894	24	Work	Unit 533	NH 66, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682016
895	242	Home	48B	Mumbai-Agra Highway	Gangapur Road	Nashik	Nashik	Maharashtra	422005
896	242	Work	Unit 931	Dwaraka Nagar Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
897	134	Home	45	100 Feet Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
898	579	Home	Plot 111	100 Feet Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560038
899	38	Home	Flat 4-2	LBS Marg	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400076
900	540	Home	228	FC Road	Shivajinagar	Pune	Pune	Maharashtra	411014
901	201	Home	151	Madhapur Main Road	Madhapur	Hyderabad	Hyderabad	Telangana	500084
902	72	Home	63	L B Road	Adyar	Chennai	Chennai	Tamil Nadu	600041
903	252	Home	99	Press Enclave Road	Lajpat Nagar	Delhi	South Delhi	Delhi	110048
904	54	Home	70	Gariahat Road	Kasba	Kolkata	Kolkata	West Bengal	700029
905	54	Work	Unit 721	Banerji Road, Corporate Tower	Kaloor	Kochi	Ernakulam	Kerala	682030
906	96	Home	Flat 4-8	MI Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302018
907	96	Work	Unit 213	NH 16, Business Park	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
908	578	Home	16-2	Vibhuti Khand Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226018
909	578	Work	Unit 980	Sinhagad Road, Corporate Tower	Hadapsar	Pune	Pune	Maharashtra	411004
910	73	Home	6-1	Seaport-Airport Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
911	30	Home	128	Hoshangabad Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462003
912	511	Home	257	Ring Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452016
913	366	Home	Flat 12-7	Madhya Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160017
914	142	Home	Flat 5-5	Beltola Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781022
915	70	Home	Flat 12-1	Bailey Road	Danapur	Patna	Patna	Bihar	800001
916	10	Home	255A	Central Avenue Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440010
917	529	Home	231	Seethammadhara Main Road	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
918	529	Work	Unit 475	NH 16, Market Plaza	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
919	207	Home	37A	Eluru Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
920	207	Work	Unit 416	Baner Road, Business Park	Kothrud	Pune	Pune	Maharashtra	411007
921	354	Home	242	Thadagam Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641012
922	354	Work	Unit 320	Banerji Road, Business Park	Edappally	Kochi	Ernakulam	Kerala	682017
923	177	Home	96	Nashik Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
924	291	Home	Flat 11-6	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
925	549	Home	144-1	Bannerghatta Road	Rajajinagar	Bengaluru	Bengaluru Urban	Karnataka	560076
926	326	Home	Flat 12-5	S V Road	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400053
927	55	Home	109	Karve Road	Viman Nagar	Pune	Pune	Maharashtra	411021
928	418	Home	145	Jubilee Hills Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500081
929	261	Home	Plot 89	Anna Salai	Guindy	Chennai	Chennai	Tamil Nadu	600020
930	390	Home	Plot 4	Mahatma Gandhi Marg	Saket	Delhi	South Delhi	Delhi	110017
931	390	Work	Unit 688	Baner Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411014
932	111	Home	Plot 194	Park Street	Alipore	Kolkata	Kolkata	West Bengal	700091
933	111	Work	Unit 139	NH 66, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682020
934	570	Home	Plot 198	Tonk Road	C Scheme	Jaipur	Jaipur	Rajasthan	302017
935	570	Work	Unit 710	Seethammadhara Main Road, Business Park	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
936	590	Home	Plot 166	Faizabad Road	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
937	126	Home	19	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682020
938	174	Home	Plot 10	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462042
939	520	Home	86	MG Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452020
940	343	Home	271	Udyan Path	Sector 17	Chandigarh	Chandigarh	Chandigarh	160009
941	445	Home	119	Beltola Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781007
942	100	Home	161-2	Boring Road	Bailey Road	Patna	Patna	Bihar	800013
943	412	Home	Plot 3	Kamptee Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440010
944	412	Work	Unit 807	NH 66, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682020
945	278	Home	47-2	Seethammadhara Main Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
946	278	Work	Unit 515	MVP Main Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
947	392	Home	Plot 120	MG Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
948	392	Work	Unit 431	Sinhagad Road, Corporate Tower	Wakad	Pune	Pune	Maharashtra	411038
949	81	Home	Plot 121	Sathy Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641012
950	195	Home	74	College Road	Cidco	Nashik	Nashik	Maharashtra	422010
951	233	Home	Plot 198	Iskcon Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
952	21	Home	Flat 9-1	Bannerghatta Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560076
953	400	Home	Plot 172	Andheri Kurla Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400050
954	461	Home	Flat 7-3	Baner Road	Viman Nagar	Pune	Pune	Maharashtra	411007
955	509	Home	66	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
956	167	Home	62B	L B Road	Velachery	Chennai	Chennai	Tamil Nadu	600018
957	167	Work	Unit 770	NH 16, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
958	381	Home	20B	Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110048
959	381	Work	Unit 129	Karve Road, Commercial Complex	Viman Nagar	Pune	Pune	Maharashtra	411014
960	173	Home	260	Rashbehari Avenue	Alipore	Kolkata	Kolkata	West Bengal	700031
961	173	Work	Unit 780	Seaport-Airport Road, Corporate Tower	Kaloor	Kochi	Ernakulam	Kerala	682020
962	288	Home	260	JLN Marg	Vaishali Nagar	Jaipur	Jaipur	Rajasthan	302019
963	146	Home	245	Shaheed Path	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226016
964	598	Home	Plot 154	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682016
965	130	Home	Flat 7-4	Link Road No. 1	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462016
966	469	Home	Plot 26	MR 10 Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452020
967	421	Home	116	Vikas Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
968	112	Home	Flat 4-2	Zoo Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
969	225	Home	Flat 6-3	Boring Road	Kankarbagh	Patna	Patna	Bihar	800004
970	225	Work	Unit 198	Paud Road, Corporate Tower	Aundh	Pune	Pune	Maharashtra	411007
971	264	Home	Flat 7-3	Amravati Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440012
972	264	Work	Unit 758	NH 66, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682020
973	556	Home	Plot 132	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
974	556	Work	Unit 985	Dwaraka Nagar Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
975	138	Home	228-1	NH 16	Governorpet	Vijayawada	NTR	Andhra Pradesh	520015
976	50	Home	Plot 117	Sathy Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641018
977	356	Home	Plot 20	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422005
978	345	Home	Flat 5-1	Judges Bungalow Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380015
979	254	Home	115A	100 Feet Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560076
980	396	Home	Plot 139	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400058
981	376	Home	27-1	Baner Road	Viman Nagar	Pune	Pune	Maharashtra	411007
982	359	Home	43	Kukatpally Main Road	Gachibowli	Hyderabad	Hyderabad	Telangana	500033
983	359	Work	Unit 511	Banerji Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682016
984	466	Home	20	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600018
985	466	Work	Unit 425	Dwaraka Nagar Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
986	153	Home	Flat 6-7	Ring Road	Lajpat Nagar	Delhi	South Delhi	Delhi	110017
987	153	Work	Unit 613	Nagar Road, Commercial Complex	Wakad	Pune	Pune	Maharashtra	411007
988	527	Home	Plot 32	Park Street	Salt Lake	Kolkata	Kolkata	West Bengal	700029
989	64	Home	Flat 11-7	Sawai Ram Singh Road	C Scheme	Jaipur	Jaipur	Rajasthan	302018
990	454	Home	201B	Shaheed Path	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226018
991	65	Home	Flat 3-5	NH 66	Edappally	Kochi	Ernakulam	Kerala	682030
992	158	Home	Flat 3-1	Hoshangabad Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462026
993	571	Home	Flat 9-3	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452020
994	161	Home	Plot 61	Vikas Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
995	457	Home	246	Zoo Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781022
996	457	Work	Unit 985	MVP Main Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
997	521	Home	277B	Fraser Road	Boring Road	Patna	Patna	Bihar	800013
998	521	Work	Unit 992	Nagar Road, Market Plaza	Kothrud	Pune	Pune	Maharashtra	411007
999	595	Home	258A	Amravati Road	Sadar	Nagpur	Nagpur	Maharashtra	440015
1000	595	Work	Unit 111	MG Road, Trade Centre	Kaloor	Kochi	Ernakulam	Kerala	682024
1001	394	Home	Plot 121	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
1002	127	Home	Plot 16	Bandar Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
1003	311	Home	95-1	Sathy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
1004	20	Home	131	Gangapur Road	College Road	Nashik	Nashik	Maharashtra	422013
1005	141	Home	38B	100 Feet Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380061
1006	85	Home	15-2	Hosur Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560034
1007	129	Home	Flat 3-6	Linking Road	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400058
1008	489	Home	210-2	FC Road	Kharadi	Pune	Pune	Maharashtra	411038
1009	489	Work	Unit 716	Paud Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411014
1010	502	Home	249	Road No. 36	Hitech City	Hyderabad	Hyderabad	Telangana	500033
1011	502	Work	Unit 216	Banerji Road, Commercial Complex	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
1012	63	Home	52-2	Besant Avenue Road	Velachery	Chennai	Chennai	Tamil Nadu	600018
1013	63	Work	Unit 928	Beach Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1014	220	Home	269	Press Enclave Road	South Extension	Delhi	South Delhi	Delhi	110017
1015	554	Home	83	EM Bypass	Salt Lake	Kolkata	Kolkata	West Bengal	700091
1016	505	Home	Plot 170	Ajmer Road	Raja Park	Jaipur	Jaipur	Rajasthan	302018
1017	4	Home	Plot 74	Shaheed Path	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226010
1018	577	Home	Plot 106	NH 66	Vyttila	Kochi	Ernakulam	Kerala	682017
1019	559	Home	23-1	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462016
1020	246	Home	Flat 7-3	MG Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452010
1021	523	Home	168	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160022
1022	523	Work	Unit 333	Sahodaran Ayyappan Road, Market Plaza	Panampilly Nagar	Kochi	Ernakulam	Kerala	682017
1023	517	Home	82	VIP Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781005
1024	517	Work	Unit 728	Beach Road, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1025	117	Home	Flat 11-5	Ashiana-Digha Road	Boring Road	Patna	Patna	Bihar	800013
1026	117	Work	Unit 709	FC Road, Commercial Complex	Hadapsar	Pune	Pune	Maharashtra	411021
1027	452	Home	Flat 10-8	Central Avenue Road	Sadar	Nagpur	Nagpur	Maharashtra	440015
1028	346	Home	Flat 12-6	Seethammadhara Main Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
1029	216	Home	239	Benz Circle Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520010
1030	486	Home	57	Thadagam Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
1031	442	Home	150-2	Nashik Road	Panchavati	Nashik	Nashik	Maharashtra	422009
1032	148	Home	Flat 1-1	100 Feet Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380054
1033	22	Home	Plot 136	Bannerghatta Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
1034	425	Home	Plot 183	Linking Road	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400050
1035	425	Work	Unit 908	MVP Main Road, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1036	147	Home	204	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411021
1037	147	Work	Unit 193	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411014
1038	108	Home	205-1	Gachibowli Road	Madhapur	Hyderabad	Hyderabad	Telangana	500081
1039	108	Work	Unit 461	Seaport-Airport Road, Business Park	Panampilly Nagar	Kochi	Ernakulam	Kerala	682017
1040	115	Home	249A	Besant Avenue Road	Velachery	Chennai	Chennai	Tamil Nadu	600034
1041	283	Home	Plot 89	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110048
1042	25	Home	72	Prince Anwar Shah Road	Kasba	Kolkata	Kolkata	West Bengal	700031
1043	467	Home	Flat 9-6	MI Road	Raja Park	Jaipur	Jaipur	Rajasthan	302018
1044	313	Home	251	Vibhuti Khand Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226021
1045	229	Home	Plot 148	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682017
1046	143	Home	Flat 4-8	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462042
1047	199	Home	Flat 3-3	Ring Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452016
1048	199	Work	Unit 895	Paud Road, Market Plaza	Viman Nagar	Pune	Pune	Maharashtra	411004
1049	302	Home	258-1	Jan Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160017
1050	302	Work	Unit 499	Seaport-Airport Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682024
1051	175	Home	38	RG Baruah Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
1052	175	Work	Unit 575	Beach Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1053	544	Home	Flat 7-7	Bailey Road	Bailey Road	Patna	Patna	Bihar	800025
1054	244	Home	137	Ring Road	Sadar	Nagpur	Nagpur	Maharashtra	440022
1055	586	Home	Plot 33	NH 16	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1056	575	Home	Plot 181	NH 16	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520012
1057	348	Home	196	Avinashi Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641035
1058	449	Home	44-2	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422009
1059	128	Home	87	Ashram Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380015
1060	294	Home	126	100 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560034
1061	294	Work	Unit 825	MG Road, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682030
1062	17	Home	Flat 10-7	Andheri Kurla Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400050
1063	17	Work	Unit 243	Dwaraka Nagar Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1064	139	Home	Flat 11-3	Paud Road	Shivajinagar	Pune	Pune	Maharashtra	411004
1065	139	Work	Unit 640	Karve Road, Business Park	Hadapsar	Pune	Pune	Maharashtra	411021
1066	145	Home	160	Jubilee Hills Road	Hitech City	Hyderabad	Hyderabad	Telangana	500033
1067	144	Home	18-2	Anna Salai	Adyar	Chennai	Chennai	Tamil Nadu	600020
1068	77	Home	Plot 36	Aurobindo Marg	Defence Colony	Delhi	South Delhi	Delhi	110017
1069	256	Home	230	Park Street	Gariahat	Kolkata	Kolkata	West Bengal	700091
1070	107	Home	236	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302019
1071	237	Home	Plot 7	Vibhuti Khand Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226016
1072	323	Home	Flat 5-8	Sahodaran Ayyappan Road	Kadavanthra	Kochi	Ernakulam	Kerala	682016
1073	44	Home	249	Airport Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462026
1074	44	Work	Unit 489	MVP Main Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1075	488	Home	9	Ring Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452016
1076	488	Work	Unit 672	FC Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411007
1077	380	Home	Flat 11-3	Himalaya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
1078	380	Work	Unit 640	MG Road, Corporate Tower	Kadavanthra	Kochi	Ernakulam	Kerala	682020
1079	592	Home	298	Zoo Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781022
1080	432	Home	12-2	Fraser Road	Bailey Road	Patna	Patna	Bihar	800025
1081	572	Home	31	Central Avenue Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440033
1082	136	Home	Flat 12-6	Dwaraka Nagar Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1083	347	Home	Plot 85	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520012
1084	383	Home	103	Avinashi Road	Gandhipuram	Coimbatore	Coimbatore	Tamil Nadu	641004
1085	573	Home	Plot 2	Nashik Road	Gangapur Road	Nashik	Nashik	Maharashtra	422007
1086	594	Home	80	Judges Bungalow Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380009
1087	594	Work	Unit 762	Sinhagad Road, Trade Centre	Hadapsar	Pune	Pune	Maharashtra	411014
1088	267	Home	198	80 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560038
1089	267	Work	Unit 954	Seaport-Airport Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682016
1090	547	Home	Plot 118	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400050
1091	547	Work	Unit 561	Beach Road, Corporate Tower	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1092	333	Home	197-2	Baner Road	Kothrud	Pune	Pune	Maharashtra	411007
1093	279	Home	Flat 12-6	Jubilee Hills Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500084
1094	151	Home	89A	Velachery Main Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600018
1095	94	Home	Flat 2-1	Press Enclave Road	Vasant Kunj	Delhi	South Delhi	Delhi	110025
1096	235	Home	Flat 1-7	EM Bypass	New Town	Kolkata	Kolkata	West Bengal	700020
1097	137	Home	Plot 188	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302017
1098	26	Home	Flat 5-1	Shaheed Path	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226020
1099	162	Home	Plot 79	Seaport-Airport Road	Kakkanad	Kochi	Ernakulam	Kerala	682024
1100	162	Work	Unit 906	MG Road, Market Plaza	Kadavanthra	Kochi	Ernakulam	Kerala	682030
1101	226	Home	137	Kolar Road	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462016
1102	226	Work	Unit 329	MVP Main Road, Commercial Complex	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
1103	534	Home	27A	Khandwa Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452017
1104	534	Work	Unit 487	Sinhagad Road, Trade Centre	Shivajinagar	Pune	Pune	Maharashtra	411021
1105	149	Home	Flat 5-3	Madhya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
1106	365	Home	Flat 2-3	GS Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781005
1107	223	Home	104	Kankarbagh Main Road	Patliputra Colony	Patna	Patna	Bihar	800025
1108	45	Home	Flat 10-2	Kamptee Road	Pratap Nagar	Nagpur	Nagpur	Maharashtra	440015
1109	360	Home	Flat 9-2	Seethammadhara Main Road	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1110	378	Home	50B	Benz Circle Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
1111	68	Home	Plot 8	Mettupalayam Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641004
1112	282	Home	Plot 21	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422009
1113	282	Work	Unit 119	Dwaraka Nagar Road, Corporate Tower	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1114	157	Home	Flat 10-4	Ashram Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380058
1115	157	Work	Unit 466	Karve Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411014
1116	482	Home	Flat 7-7	Hosur Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560034
1117	482	Work	Unit 202	NH 66, Trade Centre	Palarivattom	Kochi	Ernakulam	Kerala	682016
1118	16	Home	32	Western Express Highway	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400058
1119	154	Home	Plot 175	Nagar Road	Aundh	Pune	Pune	Maharashtra	411007
1120	351	Home	Plot 184	Gachibowli Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500081
1121	391	Home	193	L B Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600020
1122	569	Home	223	Mahatma Gandhi Marg	Defence Colony	Delhi	South Delhi	Delhi	110025
1123	156	Home	Plot 177	Gariahat Road	Alipore	Kolkata	Kolkata	West Bengal	700020
1124	3	Home	43	MI Road	Malviya Nagar	Jaipur	Jaipur	Rajasthan	302018
1125	307	Home	Plot 98	Faizabad Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226016
1126	307	Work	Unit 162	Baner Road, Corporate Tower	Shivajinagar	Pune	Pune	Maharashtra	411007
1127	379	Home	Plot 169	Banerji Road	Vyttila	Kochi	Ernakulam	Kerala	682024
1128	379	Work	Unit 586	Banerji Road, Business Park	Vyttila	Kochi	Ernakulam	Kerala	682017
1129	470	Home	251	Bawadia Kalan Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462039
1130	470	Work	Unit 545	Beach Road, Market Plaza	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1131	114	Home	233A	Khandwa Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452020
1132	289	Home	245A	Himalaya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160019
1133	395	Home	53	Beltola Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
1134	410	Home	125A	Kankarbagh Main Road	Boring Road	Patna	Patna	Bihar	800013
1135	240	Home	65	Amravati Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440015
1136	553	Home	40	NH 16	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1137	437	Home	Plot 104	MG Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
1138	91	Home	298	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641037
1139	91	Work	Unit 549	Banerji Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682020
1140	403	Home	Flat 11-1	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422010
1141	403	Work	Unit 989	Dwaraka Nagar Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1142	227	Home	197B	Judges Bungalow Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380009
1143	227	Work	Unit 800	Sinhagad Road, Commercial Complex	Aundh	Pune	Pune	Maharashtra	411038
1144	485	Home	213	80 Feet Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560076
1145	124	Home	122-2	LBS Marg	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400078
1146	255	Home	Flat 5-7	Paud Road	Aundh	Pune	Pune	Maharashtra	411007
1147	446	Home	278	Gachibowli Road	Jubilee Hills	Hyderabad	Hyderabad	Telangana	500034
1148	123	Home	Plot 198	Anna Salai	Adyar	Chennai	Chennai	Tamil Nadu	600034
1149	430	Home	5	Aurobindo Marg	Malviya Nagar	Delhi	South Delhi	Delhi	110025
1150	303	Home	Flat 7-3	Rashbehari Avenue	Ballygunge	Kolkata	Kolkata	West Bengal	700019
1151	451	Home	Plot 47	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302019
1152	451	Work	Unit 118	Seethammadhara Main Road, Corporate Tower	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1153	166	Home	69	Shaheed Path	Alambagh	Lucknow	Lucknow	Uttar Pradesh	226021
1154	166	Work	Unit 210	Sinhagad Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411007
1155	9	Home	72	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682024
1156	9	Work	Unit 711	Banerji Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682016
1157	426	Home	Flat 5-2	Kolar Road	Arera Colony	Bhopal	Bhopal	Madhya Pradesh	462026
1158	263	Home	Flat 6-4	MR 10 Road	Rau	Indore	Indore	Madhya Pradesh	452010
1159	481	Home	4A	Himalaya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160036
1160	132	Home	Flat 5-5	Beltola Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781003
1161	113	Home	Plot 54	Kankarbagh Main Road	Danapur	Patna	Patna	Bihar	800014
1162	205	Home	Plot 10	Kamptee Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440022
1163	155	Home	Flat 8-3	NH 16	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1164	567	Home	Plot 9	MG Road	Moghalrajpuram	Vijayawada	NTR	Andhra Pradesh	520015
1165	567	Work	Unit 806	Baner Road, Market Plaza	Aundh	Pune	Pune	Maharashtra	411021
1166	159	Home	Flat 9-1	Trichy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641004
1167	159	Work	Unit 580	NH 66, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682030
1168	183	Home	57B	College Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
1169	183	Work	Unit 633	Beach Road, Corporate Tower	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1170	494	Home	262	C G Road	Satellite	Ahmedabad	Ahmedabad	Gujarat	380054
1171	384	Home	249	80 Feet Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560034
1172	92	Home	200B	LBS Marg	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400053
1173	353	Home	Flat 11-7	Karve Road	Baner	Pune	Pune	Maharashtra	411004
1174	98	Home	Flat 4-6	Road No. 36	Begumpet	Hyderabad	Hyderabad	Telangana	500033
1175	428	Home	160	Mount Road	Anna Nagar	Chennai	Chennai	Tamil Nadu	600028
1176	206	Home	112	Press Enclave Road	Hauz Khas	Delhi	South Delhi	Delhi	110019
1177	332	Home	171-2	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700020
1178	332	Work	Unit 635	Seaport-Airport Road, Corporate Tower	Palarivattom	Kochi	Ernakulam	Kerala	682016
1179	420	Home	Plot 87	Sawai Ram Singh Road	Raja Park	Jaipur	Jaipur	Rajasthan	302019
1180	420	Work	Unit 556	MVP Main Road, Business Park	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1181	368	Home	Plot 179	Vibhuti Khand Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226021
1182	368	Work	Unit 624	Paud Road, Corporate Tower	Baner	Pune	Pune	Maharashtra	411038
1183	465	Home	Flat 11-5	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682030
1184	40	Home	287	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462003
1185	74	Home	Flat 4-7	MG Road	Rau	Indore	Indore	Madhya Pradesh	452020
1186	105	Home	110	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
1187	585	Home	Plot 106	Zoo Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
1188	600	Home	173	Kankarbagh Main Road	Boring Road	Patna	Patna	Bihar	800001
1189	106	Home	Plot 182	Ring Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440022
1190	290	Home	Flat 2-8	MVP Main Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1191	290	Work	Unit 990	Seethammadhara Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1192	58	Home	13	MG Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520010
1193	58	Work	Unit 332	Sinhagad Road, Business Park	Wakad	Pune	Pune	Maharashtra	411038
1194	308	Home	220	Trichy Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641035
1195	308	Work	Unit 285	Seaport-Airport Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682020
1196	584	Home	253	Nashik Road	Nashik Road	Nashik	Nashik	Maharashtra	422007
1197	340	Home	Flat 2-8	Iskcon Road	Bodakdev	Ahmedabad	Ahmedabad	Gujarat	380054
1198	238	Home	Flat 9-8	Outer Ring Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560034
1199	265	Home	253	Linking Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400076
1200	478	Home	131-1	Nagar Road	Wakad	Pune	Pune	Maharashtra	411004
1201	179	Home	238-1	Gachibowli Road	Madhapur	Hyderabad	Hyderabad	Telangana	500081
1202	11	Home	211	L B Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600028
1203	219	Home	Flat 3-5	Press Enclave Road	Vasant Kunj	Delhi	South Delhi	Delhi	110025
1204	219	Work	Unit 813	Nagar Road, Commercial Complex	Hadapsar	Pune	Pune	Maharashtra	411038
1205	277	Home	Plot 59	EM Bypass	Park Street	Kolkata	Kolkata	West Bengal	700091
1206	277	Work	Unit 650	NH 66, Commercial Complex	Kakkanad	Kochi	Ernakulam	Kerala	682017
1207	597	Home	5	MI Road	Vaishali Nagar	Jaipur	Jaipur	Rajasthan	302018
1208	597	Work	Unit 616	Seethammadhara Main Road, Business Park	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1209	53	Home	221	Vibhuti Khand Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
1210	331	Home	187	Seaport-Airport Road	Kaloor	Kochi	Ernakulam	Kerala	682017
1211	164	Home	288-2	Airport Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462026
1212	455	Home	Flat 10-3	MG Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452001
1213	269	Home	Plot 167	Madhya Marg	Sector 22	Chandigarh	Chandigarh	Chandigarh	160017
1214	110	Home	Flat 5-2	VIP Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781007
1215	243	Home	Flat 7-2	Bailey Road	Patliputra Colony	Patna	Patna	Bihar	800001
1216	357	Home	Plot 161	Kamptee Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440033
1217	357	Work	Unit 724	MG Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682017
1218	253	Home	Flat 1-3	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1219	253	Work	Unit 422	Beach Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1220	66	Home	87	Eluru Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520010
1221	66	Work	Unit 264	Nagar Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411004
1222	131	Home	Plot 111	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641004
1223	101	Home	297	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422010
1224	210	Home	33	Iskcon Road	Chandkheda	Ahmedabad	Ahmedabad	Gujarat	380058
1225	530	Home	84B	Hosur Road	HSR Layout	Bengaluru	Bengaluru Urban	Karnataka	560102
1226	160	Home	Flat 11-1	Andheri Kurla Road	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400058
1227	51	Home	Flat 1-8	Sinhagad Road	Kothrud	Pune	Pune	Maharashtra	411014
1228	217	Home	Plot 149	Road No. 36	Madhapur	Hyderabad	Hyderabad	Telangana	500081
1229	193	Home	Plot 125	Velachery Main Road	Mylapore	Chennai	Chennai	Tamil Nadu	600018
1230	193	Work	Unit 525	MVP Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1231	1	Home	Plot 33	Outer Ring Road	Saket	Delhi	South Delhi	Delhi	110025
1232	1	Work	Unit 575	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411004
1233	176	Home	Flat 2-4	EM Bypass	Salt Lake	Kolkata	Kolkata	West Bengal	700091
1234	176	Work	Unit 362	Sahodaran Ayyappan Road, Market Plaza	Kakkanad	Kochi	Ernakulam	Kerala	682017
1235	125	Home	Plot 84	Ajmer Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302017
1236	163	Home	185	Kanpur Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
1237	215	Home	92	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682020
1238	438	Home	11-1	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462042
1239	563	Home	Plot 141	Khandwa Road	Palasia	Indore	Indore	Madhya Pradesh	452017
1240	258	Home	194	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160019
1241	468	Home	103A	Zoo Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
1242	344	Home	243	Boring Road	Patliputra Colony	Patna	Patna	Bihar	800004
1243	344	Work	Unit 628	Paud Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411004
1244	118	Home	61	Kamptee Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440012
1245	118	Work	Unit 335	Seaport-Airport Road, Commercial Complex	Vyttila	Kochi	Ernakulam	Kerala	682024
1246	487	Home	Flat 2-8	MVP Main Road	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1247	487	Work	Unit 849	Beach Road, Commercial Complex	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1248	561	Home	34	Benz Circle Road	Governorpet	Vijayawada	NTR	Andhra Pradesh	520016
1249	317	Home	100	Thadagam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641004
1250	493	Home	188-1	Mumbai-Agra Highway	Gangapur Road	Nashik	Nashik	Maharashtra	422007
1251	375	Home	Plot 84	C G Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380054
1252	539	Home	150-2	80 Feet Road	Malleshwaram	Bengaluru	Bengaluru Urban	Karnataka	560038
1253	498	Home	62	Western Express Highway	Andheri East	Mumbai	Mumbai Suburban	Maharashtra	400050
1254	491	Home	Plot 105	Nagar Road	Hadapsar	Pune	Pune	Maharashtra	411007
1255	71	Home	136B	Madhapur Main Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500034
1256	71	Work	Unit 206	Seaport-Airport Road, Trade Centre	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
1257	433	Home	Plot 64	L B Road	Adyar	Chennai	Chennai	Tamil Nadu	600028
1258	433	Work	Unit 762	Seethammadhara Main Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1259	507	Home	36-2	Ring Road	South Extension	Delhi	South Delhi	Delhi	110017
1260	507	Work	Unit 226	Karve Road, Corporate Tower	Hadapsar	Pune	Pune	Maharashtra	411021
1261	484	Home	157	Rashbehari Avenue	Park Street	Kolkata	Kolkata	West Bengal	700019
1262	320	Home	Plot 171	MI Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302017
1263	186	Home	40	Gomti Nagar Extension Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226020
1264	439	Home	212-1	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682030
1265	399	Home	Plot 7	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462039
1266	528	Home	Plot 88	Ring Road	Sudama Nagar	Indore	Indore	Madhya Pradesh	452016
1267	239	Home	54	Madhya Marg	Sector 34	Chandigarh	Chandigarh	Chandigarh	160017
1268	367	Home	Plot 153	VIP Road	Zoo Road	Guwahati	Kamrup Metropolitan	Assam	781006
1269	367	Work	Unit 770	Dwaraka Nagar Road, Market Plaza	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1270	312	Home	123A	Fraser Road	Patliputra Colony	Patna	Patna	Bihar	800004
1271	312	Work	Unit 726	Karve Road, Market Plaza	Baner	Pune	Pune	Maharashtra	411007
1272	29	Home	49	Kamptee Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440010
1273	29	Work	Unit 785	Banerji Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682016
1274	245	Home	Flat 5-8	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1275	364	Home	Plot 113	Benz Circle Road	Labbipet	Vijayawada	NTR	Andhra Pradesh	520015
1276	80	Home	Plot 17	Thadagam Road	Saibaba Colony	Coimbatore	Coimbatore	Tamil Nadu	641035
1277	297	Home	Flat 4-1	Mumbai-Agra Highway	Indira Nagar	Nashik	Nashik	Maharashtra	422005
1278	116	Home	Plot 162	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380015
1279	82	Home	265	Bannerghatta Road	Indiranagar	Bengaluru	Bengaluru Urban	Karnataka	560102
1280	198	Home	Flat 8-8	Western Express Highway	Goregaon West	Mumbai	Mumbai Suburban	Maharashtra	400078
1281	350	Home	Flat 12-1	Baner Road	Baner	Pune	Pune	Maharashtra	411004
1282	350	Work	Unit 257	Paud Road, Corporate Tower	Shivajinagar	Pune	Pune	Maharashtra	411038
1283	184	Home	Plot 189	Gachibowli Road	Hitech City	Hyderabad	Hyderabad	Telangana	500033
1284	184	Work	Unit 765	Seaport-Airport Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682024
1285	260	Home	175	Besant Avenue Road	Mylapore	Chennai	Chennai	Tamil Nadu	600020
1286	260	Work	Unit 694	MVP Main Road, Business Park	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1287	32	Home	61	Mahatma Gandhi Marg	South Extension	Delhi	South Delhi	Delhi	110019
1288	411	Home	Flat 4-3	Gariahat Road	Jadavpur	Kolkata	Kolkata	West Bengal	700020
1289	257	Home	191A	Tonk Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302004
1290	213	Home	Flat 3-8	Faizabad Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226010
1291	209	Home	Flat 11-4	Sahodaran Ayyappan Road	Kakkanad	Kochi	Ernakulam	Kerala	682030
1292	398	Home	276	Kolar Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462003
1293	464	Home	Flat 4-3	MR 10 Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452010
1294	460	Home	Flat 12-1	Jan Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160019
1295	460	Work	Unit 646	Sahodaran Ayyappan Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682016
1296	104	Home	Plot 166	GS Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
1297	104	Work	Unit 336	Dwaraka Nagar Road, Commercial Complex	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1298	231	Home	Plot 185	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800001
1299	231	Work	Unit 832	FC Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411014
1300	566	Home	158	Wardha Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440022
1301	204	Home	Flat 7-3	Beach Road	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1302	83	Home	182	Eluru Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520013
1303	435	Home	Flat 9-7	Trichy Road	RS Puram	Coimbatore	Coimbatore	Tamil Nadu	641037
1304	192	Home	Flat 6-7	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422009
1305	248	Home	179	Judges Bungalow Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380061
1306	2	Home	69	80 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
1307	247	Home	40	Linking Road	Chembur	Mumbai	Mumbai Suburban	Maharashtra	400053
1308	247	Work	Unit 462	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1309	35	Home	Flat 11-3	Karve Road	Shivajinagar	Pune	Pune	Maharashtra	411007
1310	35	Work	Unit 364	Paud Road, Trade Centre	Kharadi	Pune	Pune	Maharashtra	411038
1311	337	Home	Plot 144	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500033
1312	337	Work	Unit 333	Sahodaran Ayyappan Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682017
1313	462	Home	Flat 2-2	L B Road	T Nagar	Chennai	Chennai	Tamil Nadu	600034
1314	503	Home	94	Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110017
1315	75	Home	87A	Prince Anwar Shah Road	Ballygunge	Kolkata	Kolkata	West Bengal	700031
1316	519	Home	Plot 81	JLN Marg	Jagatpura	Jaipur	Jaipur	Rajasthan	302021
1317	405	Home	Plot 180	Vibhuti Khand Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226021
1318	90	Home	199	NH 66	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
1319	274	Home	Plot 114	Bawadia Kalan Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462042
1320	218	Home	245A	AB Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452001
1321	218	Work	Unit 511	FC Road, Market Plaza	Baner	Pune	Pune	Maharashtra	411004
1322	236	Home	Flat 11-5	Udyan Path	Sector 22	Chandigarh	Chandigarh	Chandigarh	160019
1323	236	Work	Unit 698	MG Road, Business Park	Kaloor	Kochi	Ernakulam	Kerala	682030
1324	550	Home	Plot 48	VIP Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781005
1325	550	Work	Unit 561	NH 16, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1326	472	Home	Flat 12-8	Bailey Road	Rajendra Nagar	Patna	Patna	Bihar	800004
1327	424	Home	226A	Central Avenue Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440015
1328	315	Home	Flat 5-2	NH 16	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1329	314	Home	Plot 33	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
1330	299	Home	Flat 10-1	Thadagam Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
1331	599	Home	75	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422005
1332	232	Home	Flat 5-6	S G Highway	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380061
1333	60	Home	Plot 183	80 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560040
1334	60	Work	Unit 761	Sahodaran Ayyappan Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682030
1335	95	Home	Plot 125	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400053
1336	95	Work	Unit 431	MVP Main Road, Market Plaza	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1337	122	Home	Flat 9-2	Baner Road	Shivajinagar	Pune	Pune	Maharashtra	411038
1338	122	Work	Unit 857	Sinhagad Road, Commercial Complex	Viman Nagar	Pune	Pune	Maharashtra	411007
1339	415	Home	127-1	Madhapur Main Road	Kukatpally	Hyderabad	Hyderabad	Telangana	500034
1340	293	Home	173	Anna Salai	Velachery	Chennai	Chennai	Tamil Nadu	600041
1341	319	Home	75-2	Ring Road	Defence Colony	Delhi	South Delhi	Delhi	110025
1342	377	Home	Flat 8-3	Gariahat Road	Alipore	Kolkata	Kolkata	West Bengal	700019
1343	499	Home	Plot 4	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302017
1344	327	Home	Flat 10-2	Vibhuti Khand Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226021
1345	537	Home	Flat 3-4	NH 66	Kakkanad	Kochi	Ernakulam	Kerala	682030
1346	515	Home	226-2	Bawadia Kalan Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462003
1347	515	Work	Unit 886	Beach Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1348	508	Home	149	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452017
1349	508	Work	Unit 135	Sinhagad Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411021
1350	121	Home	88	Madhya Marg	Sector 15	Chandigarh	Chandigarh	Chandigarh	160019
1351	121	Work	Unit 447	Seaport-Airport Road, Trade Centre	Edappally	Kochi	Ernakulam	Kerala	682016
1352	500	Home	Plot 111	Zoo Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781022
1353	408	Home	Flat 7-5	Ashiana-Digha Road	Danapur	Patna	Patna	Bihar	800014
1354	371	Home	Flat 2-1	Kamptee Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440022
1355	417	Home	Flat 8-2	MVP Main Road	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1356	560	Home	130	MG Road	Patamata	Vijayawada	NTR	Andhra Pradesh	520016
1357	214	Home	Plot 2	Avinashi Road	Gandhipuram	Coimbatore	Coimbatore	Tamil Nadu	641037
1358	406	Home	208-2	Mumbai-Agra Highway	Cidco	Nashik	Nashik	Maharashtra	422010
1359	224	Home	214	C G Road	Bodakdev	Ahmedabad	Ahmedabad	Gujarat	380054
1360	224	Work	Unit 356	FC Road, Corporate Tower	Viman Nagar	Pune	Pune	Maharashtra	411014
1361	476	Home	Plot 181	Bannerghatta Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
1362	476	Work	Unit 676	Seaport-Airport Road, Commercial Complex	Kadavanthra	Kochi	Ernakulam	Kerala	682020
1363	170	Home	246A	Powai Road	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400053
1364	170	Work	Unit 352	MVP Main Road, Business Park	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1365	551	Home	290	FC Road	Kothrud	Pune	Pune	Maharashtra	411021
1366	19	Home	Flat 5-6	Madhapur Main Road	Kondapur	Hyderabad	Hyderabad	Telangana	500084
1367	287	Home	49A	Besant Avenue Road	Adyar	Chennai	Chennai	Tamil Nadu	600018
1368	109	Home	168	Ring Road	Saket	Delhi	South Delhi	Delhi	110016
1369	419	Home	Plot 99	Prince Anwar Shah Road	Gariahat	Kolkata	Kolkata	West Bengal	700020
1370	574	Home	Plot 103	Sawai Ram Singh Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302004
1371	120	Home	Plot 174	Vibhuti Khand Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226020
1372	262	Home	Plot 85	Sahodaran Ayyappan Road	Kadavanthra	Kochi	Ernakulam	Kerala	682017
1373	262	Work	Unit 218	MG Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682020
1374	34	Home	Plot 27	Hoshangabad Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462016
1375	34	Work	Unit 665	NH 16, Corporate Tower	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1376	448	Home	36B	MG Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452017
1377	448	Work	Unit 587	Nagar Road, Commercial Complex	Kharadi	Pune	Pune	Maharashtra	411007
1378	459	Home	52	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
1379	180	Home	Plot 163	Beltola Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781007
1380	516	Home	10B	Bailey Road	Danapur	Patna	Patna	Bihar	800013
1381	588	Home	67	Ring Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440022
1382	504	Home	Plot 122	Dwaraka Nagar Road	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1383	84	Home	160	NH 16	Patamata	Vijayawada	NTR	Andhra Pradesh	520012
1384	18	Home	Plot 16	Avinashi Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
1385	251	Home	231	Gangapur Road	Nashik Road	Nashik	Nashik	Maharashtra	422010
1386	251	Work	Unit 770	MVP Main Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530017
1387	43	Home	29	S G Highway	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380061
1388	43	Work	Unit 118	Karve Road, Market Plaza	Wakad	Pune	Pune	Maharashtra	411021
1389	497	Home	Flat 11-8	Hosur Road	JP Nagar	Bengaluru	Bengaluru Urban	Karnataka	560040
1390	497	Work	Unit 606	MG Road, Trade Centre	Vyttila	Kochi	Ernakulam	Kerala	682024
1391	422	Home	101B	S V Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400050
1392	202	Home	Plot 51	Nagar Road	Baner	Pune	Pune	Maharashtra	411038
1393	562	Home	Flat 12-8	Gachibowli Road	Kondapur	Hyderabad	Hyderabad	Telangana	500032
1394	31	Home	Plot 29	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600041
1395	292	Home	268-2	Aurobindo Marg	Lajpat Nagar	Delhi	South Delhi	Delhi	110016
1396	187	Home	196	Park Street	Jadavpur	Kolkata	Kolkata	West Bengal	700020
1397	89	Home	Plot 16	Sawai Ram Singh Road	Mansarovar	Jaipur	Jaipur	Rajasthan	302004
1398	444	Home	31-1	Gomti Nagar Extension Road	Mahanagar	Lucknow	Lucknow	Uttar Pradesh	226016
1399	444	Work	Unit 411	Paud Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411007
1400	334	Home	Flat 8-1	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682030
1401	334	Work	Unit 653	Sahodaran Ayyappan Road, Trade Centre	Kadavanthra	Kochi	Ernakulam	Kerala	682020
1402	250	Home	Plot 14	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462003
1403	250	Work	Unit 599	Seethammadhara Main Road, Corporate Tower	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1404	212	Home	127	AB Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452020
1405	49	Home	120	Madhya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160022
1406	512	Home	113A	VIP Road	Dispur	Guwahati	Kamrup Metropolitan	Assam	781005
1407	301	Home	7B	Kankarbagh Main Road	Patliputra Colony	Patna	Patna	Bihar	800013
1408	335	Home	Plot 141	Central Avenue Road	Wardha Road	Nagpur	Nagpur	Maharashtra	440033
1409	393	Home	172-2	Beach Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1410	266	Home	214-1	MG Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520015
1411	135	Home	Plot 98	Sathy Road	Saibaba Colony	Coimbatore	Coimbatore	Tamil Nadu	641018
1412	135	Work	Unit 405	Seaport-Airport Road, Market Plaza	Kaloor	Kochi	Ernakulam	Kerala	682020
1413	62	Home	Flat 3-3	College Road	College Road	Nashik	Nashik	Maharashtra	422013
1414	62	Work	Unit 750	MVP Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1415	589	Home	299B	100 Feet Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
1416	589	Work	Unit 662	Sinhagad Road, Trade Centre	Viman Nagar	Pune	Pune	Maharashtra	411014
1417	39	Home	Plot 74	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560038
1418	57	Home	135-1	Powai Road	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400053
1419	538	Home	Flat 3-2	Sinhagad Road	Baner	Pune	Pune	Maharashtra	411004
1420	440	Home	Plot 176	Jubilee Hills Road	Kondapur	Hyderabad	Hyderabad	Telangana	500034
1421	409	Home	Flat 3-6	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600041
1422	389	Home	Flat 1-1	Outer Ring Road	Malviya Nagar	Delhi	South Delhi	Delhi	110016
1423	203	Home	Plot 169	Prince Anwar Shah Road	Alipore	Kolkata	Kolkata	West Bengal	700091
1424	99	Home	98	Ajmer Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302021
1425	99	Work	Unit 950	Seethammadhara Main Road, Business Park	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1426	270	Home	60-1	Kanpur Road	Aliganj	Lucknow	Lucknow	Uttar Pradesh	226021
1427	270	Work	Unit 314	Karve Road, Corporate Tower	Kothrud	Pune	Pune	Maharashtra	411021
1428	318	Home	288-1	MG Road	Vyttila	Kochi	Ernakulam	Kerala	682017
1429	318	Work	Unit 523	MG Road, Business Park	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
1430	526	Home	262	Bawadia Kalan Road	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462003
1431	188	Home	225	Ring Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452001
1432	88	Home	28B	Jan Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160017
1433	275	Home	117	RG Baruah Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
1434	306	Home	29	Bailey Road	Rajendra Nagar	Patna	Patna	Bihar	800013
1435	241	Home	227A	Wardha Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440033
1436	495	Home	Flat 7-6	NH 16	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1437	453	Home	Plot 32	NH 16	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
1438	453	Work	Unit 185	Karve Road, Corporate Tower	Baner	Pune	Pune	Maharashtra	411014
1439	33	Home	Flat 7-4	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641018
1440	33	Work	Unit 567	Banerji Road, Market Plaza	Edappally	Kochi	Ernakulam	Kerala	682030
1441	133	Home	145	Gangapur Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
1442	133	Work	Unit 995	Beach Road, Corporate Tower	Seethammadhara	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1443	59	Home	120	Judges Bungalow Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380054
1444	548	Home	Plot 77	80 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
1445	12	Home	Plot 104	Linking Road	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400076
1446	386	Home	122	Karve Road	Wakad	Pune	Pune	Maharashtra	411004
1447	178	Home	219A	Jubilee Hills Road	Banjara Hills	Hyderabad	Hyderabad	Telangana	500081
1448	190	Home	Flat 4-4	Besant Avenue Road	Nungambakkam	Chennai	Chennai	Tamil Nadu	600018
1449	431	Home	Flat 2-4	Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110017
1450	363	Home	209	Rashbehari Avenue	Alipore	Kolkata	Kolkata	West Bengal	700019
1451	363	Work	Unit 842	NH 66, Market Plaza	Vyttila	Kochi	Ernakulam	Kerala	682020
1452	189	Home	Plot 159	Sawai Ram Singh Road	Tonk Road	Jaipur	Jaipur	Rajasthan	302019
1453	189	Work	Unit 114	MVP Main Road, Commercial Complex	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1454	321	Home	Flat 4-2	Kanpur Road	Gomti Nagar	Lucknow	Lucknow	Uttar Pradesh	226020
1455	321	Work	Unit 177	Karve Road, Corporate Tower	Viman Nagar	Pune	Pune	Maharashtra	411014
1456	304	Home	Plot 187	Seaport-Airport Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682024
1457	414	Home	229	Hoshangabad Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462039
1458	27	Home	Flat 3-5	AB Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452016
1459	361	Home	29	Udyan Path	Sector 15	Chandigarh	Chandigarh	Chandigarh	160009
1460	475	Home	11A	RG Baruah Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781003
1461	298	Home	Flat 3-1	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800013
1462	524	Home	202	Wardha Road	Sadar	Nagpur	Nagpur	Maharashtra	440012
1463	362	Home	Flat 11-3	Seethammadhara Main Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1464	362	Work	Unit 498	MVP Main Road, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1465	382	Home	Plot 28	Benz Circle Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
1466	382	Work	Unit 982	FC Road, Commercial Complex	Kharadi	Pune	Pune	Maharashtra	411014
1467	342	Home	Plot 25	Mettupalayam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641035
1468	342	Work	Unit 244	MG Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682024
1469	172	Home	117	Mumbai-Agra Highway	College Road	Nashik	Nashik	Maharashtra	422009
1470	152	Home	Flat 2-3	C G Road	Thaltej	Ahmedabad	Ahmedabad	Gujarat	380009
1471	434	Home	273	Outer Ring Road	Whitefield	Bengaluru	Bengaluru Urban	Karnataka	560040
1472	542	Home	Flat 3-3	Western Express Highway	Powai	Mumbai	Mumbai Suburban	Maharashtra	400078
1473	211	Home	Plot 42	Baner Road	Kharadi	Pune	Pune	Maharashtra	411007
1474	296	Home	Flat 8-8	Madhapur Main Road	Gachibowli	Hyderabad	Hyderabad	Telangana	500084
1475	194	Home	147-2	Arcot Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600028
1476	197	Home	240B	Press Enclave Road	Saket	Delhi	South Delhi	Delhi	110048
1477	197	Work	Unit 174	Nagar Road, Market Plaza	Shivajinagar	Pune	Pune	Maharashtra	411004
1478	397	Home	13	Park Street	Ballygunge	Kolkata	Kolkata	West Bengal	700020
1479	397	Work	Unit 980	Sahodaran Ayyappan Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682024
1480	86	Home	86	Sawai Ram Singh Road	C Scheme	Jaipur	Jaipur	Rajasthan	302021
1481	86	Work	Unit 736	Seethammadhara Main Road, Business Park	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1482	555	Home	Plot 146	Faizabad Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226018
1483	221	Home	135	Seaport-Airport Road	Kadavanthra	Kochi	Ernakulam	Kerala	682016
1484	522	Home	237A	Kolar Road	Kolar Road	Bhopal	Bhopal	Madhya Pradesh	462026
1485	14	Home	153	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452001
1486	373	Home	Flat 4-3	Jan Marg	Sector 35	Chandigarh	Chandigarh	Chandigarh	160009
1487	338	Home	98-2	VIP Road	Paltan Bazaar	Guwahati	Kamrup Metropolitan	Assam	781007
1488	76	Home	117-2	Ashiana-Digha Road	Bailey Road	Patna	Patna	Bihar	800013
1489	536	Home	Plot 187	Central Avenue Road	Dharampeth	Nagpur	Nagpur	Maharashtra	440033
1490	536	Work	Unit 877	Seaport-Airport Road, Commercial Complex	Edappally	Kochi	Ernakulam	Kerala	682020
1491	46	Home	237-2	Dwaraka Nagar Road	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1492	46	Work	Unit 212	NH 16, Market Plaza	Dwaraka Nagar	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1493	557	Home	Flat 9-5	Eluru Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520015
1494	557	Work	Unit 693	Baner Road, Commercial Complex	Wakad	Pune	Pune	Maharashtra	411004
1495	423	Home	Flat 9-8	Trichy Road	Peelamedu	Coimbatore	Coimbatore	Tamil Nadu	641004
1496	402	Home	225	Trimbak Road	Cidco	Nashik	Nashik	Maharashtra	422009
1497	280	Home	279	C G Road	Maninagar	Ahmedabad	Ahmedabad	Gujarat	380009
1498	171	Home	187A	Bannerghatta Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560040
1499	295	Home	Flat 3-4	Western Express Highway	Bandra West	Mumbai	Mumbai Suburban	Maharashtra	400078
1500	587	Home	Flat 3-8	Karve Road	Hadapsar	Pune	Pune	Maharashtra	411014
1501	93	Home	85B	Road No. 10	Banjara Hills	Hyderabad	Hyderabad	Telangana	500034
1502	268	Home	195	Anna Salai	T Nagar	Chennai	Chennai	Tamil Nadu	600028
1503	268	Work	Unit 745	NH 16, Market Plaza	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1504	305	Home	224	Mahatma Gandhi Marg	Malviya Nagar	Delhi	South Delhi	Delhi	110025
1505	305	Work	Unit 322	Paud Road, Trade Centre	Wakad	Pune	Pune	Maharashtra	411004
1506	576	Home	Flat 7-1	Gariahat Road	Ballygunge	Kolkata	Kolkata	West Bengal	700020
1507	576	Work	Unit 649	Banerji Road, Commercial Complex	Kaloor	Kochi	Ernakulam	Kerala	682024
1508	490	Home	171A	MI Road	Jagatpura	Jaipur	Jaipur	Rajasthan	302004
1509	328	Home	180	Shaheed Path	Indira Nagar	Lucknow	Lucknow	Uttar Pradesh	226018
1510	281	Home	Plot 45	NH 66	Kadavanthra	Kochi	Ernakulam	Kerala	682024
1511	473	Home	29	Airport Road	MP Nagar	Bhopal	Bhopal	Madhya Pradesh	462003
1512	447	Home	79	MG Road	Scheme No. 54	Indore	Indore	Madhya Pradesh	452010
1513	259	Home	94B	Udyan Path	Sector 8	Chandigarh	Chandigarh	Chandigarh	160019
1514	372	Home	Plot 7	RG Baruah Road	Chandmari	Guwahati	Kamrup Metropolitan	Assam	781007
1515	140	Home	55-1	Kankarbagh Main Road	Rajendra Nagar	Patna	Patna	Bihar	800001
1516	140	Work	Unit 164	FC Road, Corporate Tower	Kharadi	Pune	Pune	Maharashtra	411021
1517	69	Home	32	Kamptee Road	Civil Lines	Nagpur	Nagpur	Maharashtra	440010
1518	69	Work	Unit 549	Seaport-Airport Road, Business Park	Kadavanthra	Kochi	Ernakulam	Kerala	682030
1519	191	Home	192-1	Beach Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1520	191	Work	Unit 651	Dwaraka Nagar Road, Trade Centre	MVP Colony	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1521	349	Home	152-1	MG Road	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
1522	271	Home	Plot 17	Thadagam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641037
1523	352	Home	Flat 11-2	Gangapur Road	Gangapur Road	Nashik	Nashik	Maharashtra	422013
1524	196	Home	165	C G Road	Prahlad Nagar	Ahmedabad	Ahmedabad	Gujarat	380058
1525	336	Home	Flat 2-2	100 Feet Road	Koramangala	Bengaluru	Bengaluru Urban	Karnataka	560102
1526	543	Home	154	Western Express Highway	Borivali West	Mumbai	Mumbai Suburban	Maharashtra	400076
1527	13	Home	Plot 121	FC Road	Viman Nagar	Pune	Pune	Maharashtra	411021
1528	552	Home	Flat 10-4	Madhapur Main Road	Madhapur	Hyderabad	Hyderabad	Telangana	500033
1529	552	Work	Unit 382	Banerji Road, Trade Centre	Kakkanad	Kochi	Ernakulam	Kerala	682024
1530	272	Home	42	L B Road	Besant Nagar	Chennai	Chennai	Tamil Nadu	600034
1531	272	Work	Unit 803	Beach Road, Market Plaza	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530022
1532	583	Home	Plot 127	Outer Ring Road	Saket	Delhi	South Delhi	Delhi	110016
1533	583	Work	Unit 690	Karve Road, Trade Centre	Baner	Pune	Pune	Maharashtra	411014
1534	506	Home	Plot 164	EM Bypass	Jadavpur	Kolkata	Kolkata	West Bengal	700019
1535	42	Home	Plot 50	JLN Marg	Raja Park	Jaipur	Jaipur	Rajasthan	302018
1536	404	Home	Plot 136	Kanpur Road	Hazratganj	Lucknow	Lucknow	Uttar Pradesh	226021
1537	36	Home	Plot 72	Sahodaran Ayyappan Road	Vyttila	Kochi	Ernakulam	Kerala	682024
1538	185	Home	Flat 4-8	Kolar Road	Bawadia Kalan	Bhopal	Bhopal	Madhya Pradesh	462016
1539	150	Home	136	AB Road	Bhawarkuan	Indore	Indore	Madhya Pradesh	452016
1540	591	Home	Flat 2-1	Madhya Marg	Sector 8	Chandigarh	Chandigarh	Chandigarh	160009
1541	541	Home	192	Zoo Road	Six Mile	Guwahati	Kamrup Metropolitan	Assam	781003
1542	541	Work	Unit 616	NH 16, Corporate Tower	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1543	427	Home	192-1	Ashiana-Digha Road	Bailey Road	Patna	Patna	Bihar	800013
1544	427	Work	Unit 707	Nagar Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411021
1545	582	Home	Plot 13	Amravati Road	Sadar	Nagpur	Nagpur	Maharashtra	440010
1546	582	Work	Unit 523	NH 66, Business Park	Kakkanad	Kochi	Ernakulam	Kerala	682016
1547	276	Home	27-1	Dwaraka Nagar Road	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1548	169	Home	172	NH 16	Poranki	Vijayawada	NTR	Andhra Pradesh	520016
1549	545	Home	249-2	Mettupalayam Road	Saravanampatti	Coimbatore	Coimbatore	Tamil Nadu	641037
1550	208	Home	Flat 9-5	Trimbak Road	Indira Nagar	Nashik	Nashik	Maharashtra	422005
1551	103	Home	Plot 142	Iskcon Road	Vastrapur	Ahmedabad	Ahmedabad	Gujarat	380009
1552	558	Home	Flat 8-5	100 Feet Road	Jayanagar	Bengaluru	Bengaluru Urban	Karnataka	560038
1553	525	Home	Plot 5	Linking Road	Vile Parle	Mumbai	Mumbai Suburban	Maharashtra	400058
1554	456	Home	131	Karve Road	Shivajinagar	Pune	Pune	Maharashtra	411007
1555	456	Work	Unit 144	Nagar Road, Business Park	Kharadi	Pune	Pune	Maharashtra	411007
1556	286	Home	155B	Road No. 10	Madhapur	Hyderabad	Hyderabad	Telangana	500084
1557	286	Work	Unit 979	MG Road, Business Park	Palarivattom	Kochi	Ernakulam	Kerala	682017
1558	518	Home	38B	Velachery Main Road	T Nagar	Chennai	Chennai	Tamil Nadu	600028
1559	518	Work	Unit 859	Dwaraka Nagar Road, Trade Centre	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530016
1560	8	Home	Plot 69	Mahatma Gandhi Marg	Greater Kailash	Delhi	South Delhi	Delhi	110019
1561	249	Home	Flat 9-3	Gariahat Road	Salt Lake	Kolkata	Kolkata	West Bengal	700019
1562	48	Home	Plot 158	MI Road	C Scheme	Jaipur	Jaipur	Rajasthan	302018
1563	413	Home	Plot 163	Gomti Nagar Extension Road	Vibhuti Khand	Lucknow	Lucknow	Uttar Pradesh	226018
1564	67	Home	297	MG Road	Kakkanad	Kochi	Ernakulam	Kerala	682020
1565	330	Home	Plot 17	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462016
1566	385	Home	Plot 117	Khandwa Road	Vijay Nagar	Indore	Indore	Madhya Pradesh	452001
1567	79	Home	Flat 8-5	Vikas Marg	Sector 17	Chandigarh	Chandigarh	Chandigarh	160022
1568	79	Work	Unit 897	Seaport-Airport Road, Corporate Tower	Palarivattom	Kochi	Ernakulam	Kerala	682024
1569	358	Home	79	Zoo Road	Beltola	Guwahati	Kamrup Metropolitan	Assam	781003
1570	358	Work	Unit 954	Seethammadhara Main Road, Trade Centre	Gajuwaka	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1571	546	Home	165	Kankarbagh Main Road	Bailey Road	Patna	Patna	Bihar	800001
1572	546	Work	Unit 131	Nagar Road, Trade Centre	Aundh	Pune	Pune	Maharashtra	411014
1573	182	Home	2	Wardha Road	Manish Nagar	Nagpur	Nagpur	Maharashtra	440010
1574	87	Home	Plot 70	Beach Road	Siripuram	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530003
1575	510	Home	195	Bandar Road	Benz Circle	Vijayawada	NTR	Andhra Pradesh	520015
1576	41	Home	84	Trichy Road	Singanallur	Coimbatore	Coimbatore	Tamil Nadu	641004
1577	28	Home	112-2	Gangapur Road	Cidco	Nashik	Nashik	Maharashtra	422005
1578	441	Home	15A	C G Road	Navrangpura	Ahmedabad	Ahmedabad	Gujarat	380009
1579	479	Home	222-2	100 Feet Road	Rajajinagar	Bengaluru	Bengaluru Urban	Karnataka	560038
1580	284	Home	211-2	Powai Road	Powai	Mumbai	Mumbai Suburban	Maharashtra	400050
1581	284	Work	Unit 144	MVP Main Road, Trade Centre	Madhurawada	Visakhapatnam	Visakhapatnam	Andhra Pradesh	530013
1582	581	Home	Plot 173	Karve Road	Aundh	Pune	Pune	Maharashtra	411004
1583	581	Work	Unit 206	Baner Road, Commercial Complex	Kothrud	Pune	Pune	Maharashtra	411038
1584	52	Home	Plot 33	Road No. 10	Begumpet	Hyderabad	Hyderabad	Telangana	500033
1585	52	Work	Unit 382	Banerji Road, Corporate Tower	Edappally	Kochi	Ernakulam	Kerala	682024
1586	23	Home	133B	Anna Salai	Mylapore	Chennai	Chennai	Tamil Nadu	600028
1587	429	Home	Flat 4-3	Outer Ring Road	Vasant Kunj	Delhi	South Delhi	Delhi	110019
1588	514	Home	16-2	Park Street	Salt Lake	Kolkata	Kolkata	West Bengal	700031
1589	316	Home	Flat 6-1	JLN Marg	Tonk Road	Jaipur	Jaipur	Rajasthan	302019
1590	228	Home	Plot 76	Vibhuti Khand Road	Alambagh	Lucknow	Lucknow	Uttar Pradesh	226010
1591	416	Home	Plot 130	Sahodaran Ayyappan Road	Panampilly Nagar	Kochi	Ernakulam	Kerala	682016
1592	474	Home	289-2	Link Road No. 1	Gulmohar Colony	Bhopal	Bhopal	Madhya Pradesh	462042
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (category_id, category_name, description) FROM stdin;
1	Electronics	Consumer electronics including televisions, cameras, audio devices and electronic accessories
2	Mobiles & Accessories	Mobile phones, chargers, cases, cables, power banks and related accessories
3	Computers & Laptops	Laptops, desktops, monitors, keyboards, mice, storage devices and computer accessories
4	Home Appliances	Refrigerators, washing machines, air conditioners, fans and other household appliances
5	Kitchen Appliances	Mixers, grinders, microwave ovens, air fryers and other kitchen appliances
6	Furniture	Tables, chairs, beds, storage units, desks and other household furniture
7	Clothing	Men's, women's and children's clothing and apparel
8	Footwear	Shoes, sandals, slippers, sports footwear and other footwear
9	Beauty & Personal Care	Skincare, haircare, grooming products and personal care items
10	Grocery & Food	Packaged foods, beverages, snacks, staples and household groceries
11	Books	Fiction, non-fiction, academic books and educational material
12	Stationery & Office Supplies	Notebooks, pens, paper products, office supplies and school supplies
13	Sports & Fitness	Sports equipment, fitness accessories and exercise equipment
14	Toys & Games	Toys, board games, puzzles and educational games
15	Automotive	Automobile accessories, maintenance products, tools and vehicle-related products
16	Home & Kitchen	Home decor, cookware, dining products and household furnishings
17	Travel & Luggage	Suitcases, backpacks, travel accessories and luggage products
18	Pet Supplies	Pet food, grooming products, toys and accessories
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (order_id, customer_id, order_date, order_status, total_amount, address_id, cancelled_at, cancel_reason) FROM stdin;
340	1	2026-11-13 16:43:56.283816	Pending	80.00	419	\N	\N
341	1	2026-11-13 16:43:59.964014	Confirmed	80.00	419	\N	\N
27	217	2026-10-02 16:47:52.331634	Delivered	1749.00	416	\N	\N
28	118	2026-09-01 06:47:52.331634	Shipped	2060.00	433	\N	\N
13	493	2026-10-07 15:47:52.331634	Delivered	5200.00	438	\N	\N
14	448	2026-11-09 22:27:52.331634	Pending	16188.00	564	\N	\N
15	437	2026-10-31 02:47:52.331634	Confirmed	3897.00	325	\N	\N
16	108	2026-09-07 00:47:52.331634	Shipped	3297.00	227	\N	\N
17	80	2026-10-29 07:47:52.331634	Delivered	16395.00	464	\N	\N
18	537	2026-10-16 12:47:52.331634	Confirmed	9298.00	533	\N	\N
19	521	2026-10-11 17:47:52.331634	Shipped	1418.00	186	\N	\N
20	440	2026-08-12 19:47:52.331634	Delivered	1578.00	608	\N	\N
21	248	2026-09-26 03:47:52.331634	Shipped	11694.00	493	\N	\N
23	221	2026-11-10 00:38:52.331634	Pending	13897.00	671	\N	\N
24	29	2026-11-02 14:47:52.331634	Shipped	1560.00	460	\N	\N
25	205	2026-08-18 00:47:52.331634	Delivered	210.00	350	\N	\N
26	34	2026-09-14 12:47:52.331634	Delivered	85814.00	563	\N	\N
29	389	2026-08-16 14:47:52.331634	Delivered	3399.00	610	\N	\N
30	576	2026-09-23 12:47:52.331634	Shipped	3600.00	695	\N	\N
31	89	2026-09-17 16:47:52.331634	Shipped	9107.00	585	\N	\N
32	69	2026-09-06 04:47:52.331634	Shipped	7329.00	706	\N	\N
33	213	2026-11-10 00:02:52.331634	Pending	62408.00	478	\N	\N
34	312	2026-11-04 01:47:52.331634	Delivered	6204.00	459	\N	\N
36	189	2026-11-10 01:23:52.331634	Pending	233067.00	640	\N	\N
37	387	2026-10-07 13:47:52.331634	Confirmed	18047.00	20	\N	\N
38	253	2026-11-03 15:47:52.331634	Shipped	2370.00	407	\N	\N
39	172	2026-08-25 04:47:52.331634	Shipped	2599.00	657	\N	\N
40	44	2026-10-30 23:47:52.331634	Shipped	2800.00	261	\N	\N
41	450	2026-10-08 00:47:52.331634	Confirmed	6817.00	37	\N	\N
42	23	2026-10-29 21:47:52.331634	Delivered	5449.00	774	\N	\N
43	416	2026-08-18 11:47:52.331634	Delivered	16696.00	779	\N	\N
44	122	2026-09-21 07:47:52.331634	Delivered	7364.00	525	\N	\N
45	121	2026-10-26 07:47:52.331634	Shipped	10617.00	539	\N	\N
47	563	2026-11-05 01:47:52.331634	Shipped	6357.00	427	\N	\N
48	476	2026-08-16 12:47:52.331634	Delivered	2660.00	549	\N	\N
49	520	2026-09-19 06:47:52.331634	Delivered	2698.00	127	\N	\N
50	192	2026-09-05 02:47:52.331634	Confirmed	2699.00	492	\N	\N
51	541	2026-09-26 09:47:52.331634	Confirmed	3126.00	730	\N	\N
52	470	2026-08-26 20:47:52.331634	Shipped	8547.00	318	\N	\N
53	322	2026-10-07 04:47:52.331634	Confirmed	61998.00	56	\N	\N
54	546	2026-09-09 05:47:52.331634	Shipped	2927.00	760	\N	\N
55	236	2026-09-03 16:47:52.331634	Shipped	1080.00	510	\N	\N
56	463	2026-09-18 11:47:52.331634	Confirmed	26747.00	10	\N	\N
57	523	2026-10-10 08:47:52.331634	Delivered	3658.00	209	\N	\N
58	319	2026-10-06 20:47:52.331634	Shipped	1038.00	529	\N	\N
59	122	2026-09-26 00:47:52.331634	Confirmed	77600.00	526	\N	\N
60	389	2026-08-31 08:47:52.331634	Shipped	13223.00	610	\N	\N
63	328	2026-09-16 04:47:52.331634	Confirmed	438.00	697	\N	\N
64	51	2026-11-05 03:47:52.331634	Shipped	3000.00	415	\N	\N
65	112	2026-08-26 13:47:52.331634	Confirmed	10130.00	156	\N	\N
66	356	2026-11-10 00:54:52.331634	Pending	14715.00	165	\N	\N
67	597	2026-11-10 00:14:52.331634	Pending	7485.00	396	\N	\N
68	112	2026-08-20 06:47:52.331634	Shipped	12240.00	156	\N	\N
69	285	2026-11-03 07:47:52.331634	Shipped	216598.00	13	\N	\N
70	31	2026-08-24 20:47:52.331634	Delivered	5968.00	582	\N	\N
71	52	2026-08-20 18:47:52.331634	Shipped	105270.00	772	\N	\N
72	444	2026-10-14 13:47:52.331634	Delivered	1977.00	586	\N	\N
73	290	2026-09-24 11:47:52.331634	Delivered	1540.00	378	\N	\N
74	429	2026-10-12 03:47:52.331634	Confirmed	19305.00	775	\N	\N
75	173	2026-08-15 08:47:52.331634	Shipped	2239.00	148	\N	\N
76	41	2026-11-10 04:35:52.331634	Pending	2487.00	764	\N	\N
77	280	2026-09-18 19:47:52.331634	Shipped	6979.00	685	\N	\N
78	291	2026-09-04 18:47:52.331634	Shipped	11308.00	112	\N	\N
79	460	2026-08-28 17:47:52.331634	Confirmed	11077.00	482	\N	\N
80	9	2026-09-10 07:47:52.331634	Delivered	1640.00	344	\N	\N
81	231	2026-08-19 08:47:52.331634	Delivered	5038.00	486	\N	\N
82	474	2026-09-02 14:47:52.331634	Shipped	4887.00	780	\N	\N
83	294	2026-08-21 22:47:52.331634	Shipped	2400.00	248	\N	\N
85	185	2026-10-12 19:47:52.331634	Confirmed	1399.00	726	\N	\N
86	242	2026-08-23 04:47:52.331634	Delivered	15024.00	83	\N	\N
88	553	2026-10-15 22:47:52.331634	Shipped	17498.00	324	\N	\N
89	571	2026-10-16 10:47:52.331634	Delivered	9265.00	181	\N	\N
91	579	2026-09-24 17:47:52.331634	Shipped	17815.00	86	\N	\N
93	269	2026-09-24 03:47:52.331634	Delivered	4060.00	401	\N	\N
94	354	2026-10-12 12:47:52.331634	Delivered	24146.00	109	\N	\N
95	561	2026-09-21 22:47:52.331634	Delivered	7396.00	436	\N	\N
96	84	2026-10-22 00:47:52.331634	Shipped	176595.00	571	\N	\N
97	103	2026-11-03 07:47:52.331634	Delivered	8200.00	739	\N	\N
98	287	2026-09-19 08:47:52.331634	Confirmed	5538.00	555	\N	\N
99	597	2026-08-30 20:47:52.331634	Shipped	299.00	396	\N	\N
100	314	2026-08-25 20:47:52.331634	Shipped	42198.00	517	\N	\N
101	360	2026-09-13 08:47:52.331634	Confirmed	19896.00	297	\N	\N
102	266	2026-09-08 00:47:52.331634	Confirmed	15127.00	598	\N	\N
103	599	2026-08-15 09:47:52.331634	Delivered	168000.00	519	\N	\N
104	63	2026-08-20 21:47:52.331634	Delivered	9798.00	200	\N	\N
105	417	2026-11-09 22:03:52.331634	Pending	2198.00	543	\N	\N
106	141	2026-09-19 17:47:52.331634	Shipped	4125.00	193	\N	\N
107	69	2026-08-30 15:47:52.331634	Shipped	4966.00	705	\N	\N
108	84	2026-11-10 05:55:52.331634	Pending	179.00	571	\N	\N
109	436	2026-10-17 22:47:52.331634	Shipped	2887.00	7	\N	\N
110	349	2026-09-04 19:47:52.331634	Shipped	91249.00	709	\N	\N
111	44	2026-10-29 13:47:52.331634	Confirmed	54798.00	262	\N	\N
112	365	2026-09-05 22:47:52.331634	Confirmed	6335.00	294	\N	\N
113	576	2026-10-11 08:47:52.331634	Delivered	15417.00	695	\N	\N
114	335	2026-09-20 18:47:52.331634	Shipped	6125.00	596	\N	\N
116	178	2026-10-21 06:47:52.331634	Delivered	389.00	635	\N	\N
117	43	2026-11-10 06:27:52.331634	Pending	580.00	575	\N	\N
118	80	2026-08-19 03:47:52.331634	Confirmed	205826.00	464	\N	\N
119	259	2026-10-06 16:47:52.331634	Shipped	717.00	701	\N	\N
120	588	2026-09-16 15:47:52.331634	Delivered	380.00	569	\N	\N
121	528	2026-10-29 08:47:52.331634	Delivered	8600.00	454	\N	\N
123	252	2026-11-10 05:08:52.331634	Pending	7968.00	91	\N	\N
124	499	2026-11-10 02:48:52.331634	Pending	7649.00	531	\N	\N
125	156	2026-09-19 18:47:52.331634	Delivered	4276.00	311	\N	\N
126	536	2026-10-30 00:47:52.331634	Shipped	22819.00	677	\N	\N
127	276	2026-11-10 05:42:52.331634	Pending	58897.00	735	\N	\N
128	138	2026-09-17 03:47:52.331634	Shipped	300.00	163	\N	\N
129	561	2026-11-10 04:48:52.331634	Pending	2217.00	436	\N	\N
130	492	2026-10-28 21:47:52.331634	Delivered	4098.00	15	\N	\N
131	433	2026-10-08 13:47:52.331634	Delivered	1349.00	445	\N	\N
132	190	2026-09-27 17:47:52.331634	Delivered	10249.00	636	\N	\N
134	20	2026-08-12 21:47:52.331634	Delivered	11737.00	192	\N	\N
135	556	2026-10-29 11:47:52.331634	Shipped	409.00	161	\N	\N
136	492	2026-09-09 05:47:52.331634	Shipped	3986.00	15	\N	\N
137	286	2026-10-10 21:47:52.331634	Delivered	739.00	744	\N	\N
138	205	2026-09-29 22:47:52.331634	Shipped	1077.00	350	\N	\N
139	406	2026-09-18 21:47:52.331634	Delivered	30036.00	546	\N	\N
140	392	2026-11-09 21:23:52.331634	Pending	889.00	135	\N	\N
142	165	2026-10-08 15:47:52.331634	Delivered	107936.00	73	\N	\N
143	357	2026-11-10 00:27:52.331634	Pending	1829.00	404	\N	\N
145	211	2026-10-01 05:47:52.331634	Confirmed	3648.00	661	\N	\N
147	236	2026-10-07 18:47:52.331634	Delivered	9949.00	510	\N	\N
148	203	2026-09-13 15:47:52.331634	Delivered	12146.00	611	\N	\N
149	565	2026-08-29 12:47:52.331634	Confirmed	16295.00	31	\N	\N
150	13	2026-09-10 07:47:52.331634	Confirmed	5247.00	715	\N	\N
151	200	2026-10-06 22:47:52.331634	Shipped	5095.00	72	\N	\N
152	491	2026-09-16 09:47:52.331634	Delivered	7944.00	442	\N	\N
153	84	2026-10-29 22:47:52.331634	Shipped	23247.00	571	\N	\N
154	455	2026-11-10 04:37:52.331634	Pending	4209.00	400	\N	\N
155	10	2026-10-24 03:47:52.331634	Shipped	5617.00	104	\N	\N
156	375	2026-10-28 15:47:52.331634	Confirmed	1638.00	439	\N	\N
159	151	2026-11-09 21:53:52.331634	Pending	759.00	282	\N	\N
160	534	2026-09-19 08:47:52.331634	Delivered	190447.00	292	\N	\N
161	529	2026-10-13 21:47:52.331634	Delivered	940.00	105	\N	\N
162	594	2026-09-29 15:47:52.331634	Confirmed	48697.00	275	\N	\N
163	597	2026-09-22 07:47:52.331634	Delivered	15597.00	396	\N	\N
165	576	2026-09-23 01:47:52.331634	Shipped	1258.00	695	\N	\N
166	571	2026-10-24 09:47:52.331634	Shipped	3370.00	181	\N	\N
167	220	2026-10-06 07:47:52.331634	Shipped	24645.00	202	\N	\N
168	8	2026-08-15 13:47:52.331634	Shipped	26716.00	748	\N	\N
169	424	2026-11-04 11:47:52.331634	Delivered	2280.00	515	\N	\N
170	451	2026-09-10 07:47:52.331634	Delivered	197450.00	340	\N	\N
171	200	2026-10-25 18:47:52.331634	Shipped	4247.00	72	\N	\N
172	486	2026-09-20 18:47:52.331634	Delivered	12245.00	218	\N	\N
174	347	2026-11-01 15:47:52.331634	Delivered	3768.00	271	\N	\N
175	572	2026-08-24 09:47:52.331634	Shipped	7060.00	269	\N	\N
176	390	2026-08-29 07:47:52.331634	Confirmed	3518.00	118	\N	\N
177	419	2026-09-16 10:47:52.331634	Delivered	2317.00	557	\N	\N
178	312	2026-10-14 01:47:52.331634	Shipped	6200.00	459	\N	\N
179	360	2026-08-27 16:47:52.331634	Shipped	7049.00	297	\N	\N
180	494	2026-10-05 23:47:52.331634	Shipped	2208.00	358	\N	\N
181	117	2026-10-24 14:47:52.331634	Delivered	4630.00	213	\N	\N
182	428	2026-08-26 14:47:52.331634	Delivered	2200.00	363	\N	\N
183	183	2026-10-27 00:47:52.331634	Delivered	2200.00	356	\N	\N
184	433	2026-10-23 11:47:52.331634	Delivered	2917.00	446	\N	\N
185	176	2026-08-18 09:47:52.331634	Confirmed	6348.00	421	\N	\N
187	536	2026-11-10 03:20:52.331634	Pending	2000.00	677	\N	\N
189	145	2026-09-25 03:47:52.331634	Shipped	1069.00	254	\N	\N
190	113	2026-10-06 20:47:52.331634	Confirmed	76497.00	349	\N	\N
191	43	2026-08-19 13:47:52.331634	Delivered	9414.00	576	\N	\N
192	19	2026-11-09 21:01:52.331634	Pending	12894.00	554	\N	\N
193	86	2026-11-03 23:47:52.331634	Confirmed	1557.00	669	\N	\N
194	218	2026-10-17 08:47:52.331634	Delivered	15897.00	509	\N	\N
195	354	2026-11-04 01:47:52.331634	Shipped	37577.00	110	\N	\N
196	227	2026-08-15 09:47:52.331634	Delivered	3298.00	330	\N	\N
197	453	2026-09-14 16:47:52.331634	Confirmed	8547.00	626	\N	\N
198	317	2026-11-10 02:13:52.331634	Pending	3147.00	437	\N	\N
200	436	2026-08-29 06:47:52.331634	Shipped	4798.00	7	\N	\N
201	413	2026-08-17 20:47:52.331634	Shipped	5649.00	751	\N	\N
202	341	2026-10-12 08:47:52.331634	Delivered	3459.00	42	\N	\N
203	172	2026-10-27 15:47:52.331634	Shipped	105000.00	657	\N	\N
204	66	2026-08-31 05:47:52.331634	Shipped	2319.00	408	\N	\N
205	310	2026-08-18 10:47:52.331634	Delivered	13497.00	3	\N	\N
206	390	2026-09-09 11:47:52.331634	Delivered	2800.00	119	\N	\N
207	297	2026-11-10 02:21:52.331634	Pending	5548.00	465	\N	\N
208	445	2026-10-14 05:47:52.331634	Shipped	145797.00	129	\N	\N
209	171	2026-08-19 08:47:52.331634	Confirmed	47849.00	686	\N	\N
211	221	2026-09-02 16:47:52.331634	Delivered	66449.00	671	\N	\N
212	328	2026-11-10 01:25:52.331634	Pending	6935.00	697	\N	\N
243	139	2026-10-20 11:47:52.331634	Shipped	4929.00	252	\N	\N
215	265	2026-10-01 03:47:52.331634	Delivered	165098.00	387	\N	\N
216	262	2026-10-19 22:47:52.331634	Shipped	7337.00	561	\N	\N
218	402	2026-10-15 04:47:52.331634	Shipped	7636.00	684	\N	\N
219	525	2026-08-23 21:47:52.331634	Shipped	2600.00	741	\N	\N
220	260	2026-08-28 13:47:52.331634	Delivered	2799.00	473	\N	\N
221	471	2026-10-20 08:47:52.331634	Delivered	3747.00	59	\N	\N
222	144	2026-09-21 10:47:52.331634	Shipped	20915.00	255	\N	\N
223	595	2026-09-06 20:47:52.331634	Shipped	4628.00	187	\N	\N
224	329	2026-09-16 12:47:52.331634	Confirmed	1380.00	67	\N	\N
226	318	2026-09-10 15:47:52.331634	Delivered	310.00	616	\N	\N
228	234	2026-09-05 02:47:52.331634	Shipped	3589.00	11	\N	\N
229	53	2026-09-18 18:47:52.331634	Delivered	4899.00	397	\N	\N
230	103	2026-09-07 06:47:52.331634	Delivered	45237.00	739	\N	\N
231	46	2026-08-23 06:47:52.331634	Confirmed	27266.00	679	\N	\N
232	293	2026-10-11 00:47:52.331634	Shipped	1689.00	528	\N	\N
233	519	2026-11-04 19:47:52.331634	Shipped	6238.00	504	\N	\N
234	274	2026-09-15 03:47:52.331634	Shipped	440.00	507	\N	\N
235	197	2026-10-15 11:47:52.331634	Confirmed	1878.00	664	\N	\N
236	322	2026-11-05 06:47:52.331634	Shipped	7300.00	56	\N	\N
237	279	2026-10-21 07:47:52.331634	Shipped	168747.00	281	\N	\N
238	488	2026-10-27 15:47:52.331634	Confirmed	2240.00	264	\N	\N
239	324	2026-10-13 21:47:52.331634	Delivered	187517.00	27	\N	\N
240	505	2026-10-27 18:47:52.331634	Delivered	680.00	204	\N	\N
241	550	2026-11-10 03:55:52.331634	Pending	960.00	512	\N	\N
242	541	2026-09-01 04:47:52.331634	Delivered	39898.00	730	\N	\N
244	95	2026-08-21 13:47:52.331634	Shipped	2277.00	523	\N	\N
245	569	2026-09-04 23:47:52.331634	Confirmed	450.00	310	\N	\N
246	457	2026-10-05 14:47:52.331634	Shipped	1590.00	184	\N	\N
247	46	2026-10-12 05:47:52.331634	Delivered	3447.00	679	\N	\N
248	260	2026-10-13 14:47:52.331634	Delivered	108398.00	474	\N	\N
249	449	2026-09-21 20:47:52.331634	Shipped	11498.00	246	\N	\N
250	35	2026-10-14 22:47:52.331634	Shipped	3260.00	498	\N	\N
251	65	2026-09-19 18:47:52.331634	Confirmed	5320.00	179	\N	\N
252	54	2026-10-03 03:47:52.331634	Delivered	217498.00	93	\N	\N
253	35	2026-08-29 22:47:52.331634	Delivered	7497.00	498	\N	\N
254	36	2026-08-18 05:47:52.331634	Shipped	3447.00	725	\N	\N
255	594	2026-09-25 05:47:52.331634	Shipped	8998.00	274	\N	\N
258	573	2026-09-18 03:47:52.331634	Shipped	10545.00	273	\N	\N
261	441	2026-10-08 19:47:52.331634	Confirmed	6200.00	766	\N	\N
262	530	2026-10-03 15:47:52.331634	Confirmed	4089.00	413	\N	\N
263	186	2026-10-30 16:47:52.331634	Shipped	17433.00	451	\N	\N
264	62	2026-08-13 01:47:52.331634	Shipped	6258.00	602	\N	\N
265	576	2026-10-04 23:47:52.331634	Shipped	7800.00	695	\N	\N
267	503	2026-10-13 21:47:52.331634	Shipped	2320.00	502	\N	\N
268	70	2026-09-23 13:47:52.331634	Delivered	19194.00	103	\N	\N
269	545	2026-10-30 22:47:52.331634	Shipped	3309.00	737	\N	\N
270	359	2026-10-08 18:47:52.331634	Shipped	2440.00	170	\N	\N
271	136	2026-09-16 03:47:52.331634	Delivered	9846.00	270	\N	\N
272	515	2026-09-20 08:47:52.331634	Shipped	13488.00	534	\N	\N
273	139	2026-10-18 12:47:52.331634	Delivered	154645.00	252	\N	\N
274	270	2026-09-21 11:47:52.331634	Shipped	11507.00	614	\N	\N
275	517	2026-08-15 18:47:52.331634	Delivered	12497.00	212	\N	\N
276	253	2026-09-27 05:47:52.331634	Shipped	3000.00	406	\N	\N
277	62	2026-08-12 10:47:52.331634	Delivered	22095.00	601	\N	\N
278	471	2026-08-28 17:47:52.331634	Shipped	8876.00	59	\N	\N
279	70	2026-09-17 18:47:52.331634	Shipped	6885.00	103	\N	\N
280	529	2026-09-01 03:47:52.331634	Delivered	215599.00	106	\N	\N
281	451	2026-10-06 02:47:52.331634	Shipped	3147.00	339	\N	\N
284	480	2026-09-10 22:47:52.331634	Shipped	13200.00	35	\N	\N
285	44	2026-10-19 20:47:52.331634	Delivered	3398.00	262	\N	\N
286	408	2026-08-30 23:47:52.331634	Confirmed	3416.00	541	\N	\N
287	540	2026-11-10 03:30:52.331634	Pending	209.00	88	\N	\N
288	181	2026-09-13 16:47:52.331634	Shipped	1300.00	57	\N	\N
289	4	2026-10-31 05:47:52.331634	Delivered	1349.00	205	\N	\N
290	397	2026-10-21 17:47:52.331634	Shipped	4185.00	667	\N	\N
291	207	2026-10-04 22:47:52.331634	Shipped	28824.00	108	\N	\N
292	194	2026-09-05 22:47:52.331634	Delivered	8827.00	663	\N	\N
293	517	2026-11-09 22:46:52.331634	Pending	13285.00	211	\N	\N
294	556	2026-10-18 12:47:52.331634	Delivered	18498.00	162	\N	\N
295	256	2026-08-12 21:47:52.331634	Delivered	71749.00	257	\N	\N
297	553	2026-10-30 12:47:52.331634	Shipped	2257.00	324	\N	\N
298	244	2026-09-19 14:47:52.331634	Shipped	177297.00	242	\N	\N
299	582	2026-10-10 08:47:52.331634	Confirmed	330.00	734	\N	\N
300	501	2026-10-16 10:47:52.331634	Shipped	17000.00	38	\N	\N
301	380	2026-08-25 20:47:52.331634	Shipped	21000.00	266	\N	\N
302	533	2026-09-02 16:47:52.331634	Confirmed	4899.00	77	\N	\N
303	46	2026-11-10 01:29:52.331634	Pending	12298.00	679	\N	\N
304	582	2026-08-27 06:47:52.331634	Shipped	18000.00	734	\N	\N
305	278	2026-08-22 23:47:52.331634	Confirmed	9900.00	134	\N	\N
306	1	2026-09-15 03:47:52.331634	Delivered	11345.00	420	\N	\N
307	468	2026-09-23 06:47:52.331634	Confirmed	769.00	429	\N	\N
308	271	2026-09-03 22:47:52.331634	Confirmed	29127.00	710	\N	\N
309	33	2026-08-31 04:47:52.331634	Shipped	14745.00	627	\N	\N
310	476	2026-10-04 22:47:52.331634	Delivered	1557.00	549	\N	\N
311	390	2026-10-07 09:47:52.331634	Shipped	569.00	118	\N	\N
312	221	2026-09-18 22:47:52.331634	Delivered	99.00	671	\N	\N
22	233	2026-10-23 02:47:52.331634	Cancelled	458.00	139	2026-10-23 03:47:52.331634	Cancelled by customer
35	341	2026-10-30 09:47:52.331634	Cancelled	9475.00	42	2026-10-30 10:47:52.331634	Cancelled by customer
46	518	2026-10-07 21:47:52.331634	Cancelled	7699.00	746	2026-10-07 22:47:52.331634	Ordered by mistake
61	443	2026-11-01 06:47:52.331634	Cancelled	2458.00	52	2026-11-01 07:47:52.331634	Ordered by mistake
62	64	2026-11-04 20:47:52.331634	Cancelled	32154.00	177	2026-11-04 21:47:52.331634	Ordered by mistake
84	188	2026-08-28 05:47:52.331634	Cancelled	4587.00	619	2026-08-28 06:47:52.331634	Cancelled by customer
87	409	2026-11-04 07:47:52.331634	Cancelled	9900.00	609	2026-11-04 08:47:52.331634	Cancelled by customer
90	327	2026-09-19 00:47:52.331634	Cancelled	9833.00	532	2026-09-19 01:47:52.331634	Cancelled by customer
92	66	2026-10-23 12:47:52.331634	Cancelled	1099.00	409	2026-10-23 13:47:52.331634	Cancelled by customer
115	262	2026-08-29 13:47:52.331634	Cancelled	1407.00	561	2026-08-29 14:47:52.331634	Cancelled by customer
122	563	2026-09-25 07:47:52.331634	Cancelled	4786.00	427	2026-09-25 08:47:52.331634	Cancelled by customer
133	545	2026-10-13 08:47:52.331634	Cancelled	1590.00	737	2026-10-13 09:47:52.331634	Ordered by mistake
141	117	2026-09-24 04:47:52.331634	Cancelled	1999.00	213	2026-09-24 05:47:52.331634	Ordered by mistake
144	482	2026-10-28 08:47:52.331634	Cancelled	1358.00	304	2026-10-28 09:47:52.331634	Ordered by mistake
146	93	2026-08-23 08:47:52.331634	Cancelled	5625.00	689	2026-08-23 09:47:52.331634	Ordered by mistake
157	578	2026-11-01 09:47:52.331634	Cancelled	10984.00	97	2026-11-01 10:47:52.331634	Cancelled by customer
158	272	2026-09-14 19:47:52.331634	Cancelled	3609.00	719	2026-09-14 20:47:52.331634	Cancelled by customer
164	163	2026-10-22 07:47:52.331634	Cancelled	2876.00	424	2026-10-22 08:47:52.331634	Ordered by mistake
173	57	2026-08-17 06:47:52.331634	Cancelled	959.00	606	2026-08-17 07:47:52.331634	Cancelled by customer
186	19	2026-09-28 03:47:52.331634	Cancelled	4649.00	554	2026-09-28 04:47:52.331634	Cancelled by customer
188	338	2026-10-09 20:47:52.331634	Cancelled	2277.00	675	2026-10-09 21:47:52.331634	Ordered by mistake
199	554	2026-08-13 15:47:52.331634	Cancelled	1599.00	203	2026-08-13 16:47:52.331634	Cancelled by customer
210	497	2026-11-04 17:47:52.331634	Cancelled	3897.00	577	2026-11-04 18:47:52.331634	Cancelled by customer
213	380	2026-11-01 22:47:52.331634	Cancelled	11473.00	265	2026-11-01 23:47:52.331634	Cancelled by customer
214	451	2026-09-13 19:47:52.331634	Cancelled	90147.00	340	2026-09-13 20:47:52.331634	Ordered by mistake
217	419	2026-08-21 16:47:52.331634	Cancelled	177163.00	557	2026-08-21 17:47:52.331634	Ordered by mistake
225	130	2026-08-29 00:47:52.331634	Cancelled	5736.00	153	2026-08-29 01:47:52.331634	Cancelled by customer
227	70	2026-09-30 17:47:52.331634	Cancelled	12300.00	103	2026-09-30 18:47:52.331634	Ordered by mistake
256	267	2026-10-25 09:47:52.331634	Cancelled	77047.00	276	2026-10-25 10:47:52.331634	Cancelled by customer
257	97	2026-09-12 21:47:52.331634	Cancelled	71103.00	33	2026-09-12 22:47:52.331634	Cancelled by customer
259	149	2026-09-02 00:47:52.331634	Cancelled	718.00	293	2026-09-02 01:47:52.331634	Cancelled by customer
260	25	2026-08-13 04:47:52.331634	Cancelled	24698.00	230	2026-08-13 05:47:52.331634	Cancelled by customer
266	567	2026-09-18 21:47:52.331634	Cancelled	4679.00	352	2026-09-18 22:47:52.331634	Ordered by mistake
282	565	2026-09-08 05:47:52.331634	Cancelled	2898.00	31	2026-09-08 06:47:52.331634	Cancelled by customer
283	58	2026-09-29 09:47:52.331634	Cancelled	230.00	381	2026-09-29 10:47:52.331634	Cancelled by customer
296	278	2026-10-14 07:47:52.331634	Cancelled	3954.00	133	2026-10-14 08:47:52.331634	Cancelled by customer
\.


--
-- Data for Name: order_event; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_event (event_id, order_id, event_time, event_type, detail) FROM stdin;
2115	340	2026-11-13 16:43:56.547784	Order Pending	Order placed
2117	341	2026-11-13 17:44:43.581618	Payment Successful	\N
2118	341	2026-11-13 17:44:43.588916	Order Confirmed	\N
2119	341	2026-11-13 17:44:43.595961	Shipment Pending	\N
2120	243	2026-11-14 08:21:37.162082	Shipment Shipped	\N
2121	243	2026-11-14 08:21:37.171538	Order Shipped	\N
2116	341	2026-11-13 16:44:00.295491	Order Pending	Order placed
432	75	2026-08-16 08:47:52.331634	Order Shipped	\N
858	144	2026-10-28 08:57:52.331634	Order Confirmed	\N
1278	211	2026-09-02 16:57:52.331634	Order Confirmed	\N
31	13	2026-10-07 15:47:52.331634	Order Pending	Order placed
32	13	2026-10-07 15:52:52.331634	Payment Failed	Insufficient funds
33	13	2026-10-07 15:57:52.331634	Payment Successful	\N
34	13	2026-10-07 15:57:52.331634	Order Confirmed	\N
35	13	2026-10-07 15:57:52.331634	Shipment Pending	\N
36	13	2026-10-08 15:47:52.331634	Shipment Shipped	\N
37	13	2026-10-08 15:47:52.331634	Order Shipped	\N
38	13	2026-10-09 15:47:52.331634	Shipment In Transit	\N
39	13	2026-10-11 15:47:52.331634	Shipment Delivered	\N
40	13	2026-10-11 15:47:52.331634	Order Delivered	\N
41	14	2026-11-09 22:27:52.331634	Order Pending	Order placed
42	14	2026-11-09 22:32:52.331634	Payment Failed	Card declined by bank
43	15	2026-10-31 02:47:52.331634	Order Pending	Order placed
44	15	2026-10-31 02:57:52.331634	Payment Successful	\N
45	15	2026-10-31 02:57:52.331634	Order Confirmed	\N
46	15	2026-10-31 02:57:52.331634	Shipment Pending	\N
47	16	2026-09-07 00:47:52.331634	Order Pending	Order placed
48	16	2026-09-07 00:52:52.331634	Payment Failed	Insufficient funds
49	16	2026-09-07 00:57:52.331634	Payment Successful	\N
50	16	2026-09-07 00:57:52.331634	Order Confirmed	\N
51	16	2026-09-07 00:57:52.331634	Shipment Pending	\N
52	16	2026-09-08 00:47:52.331634	Shipment Shipped	\N
53	16	2026-09-08 00:47:52.331634	Order Shipped	\N
54	16	2026-09-09 00:47:52.331634	Shipment In Transit	\N
55	17	2026-10-29 07:47:52.331634	Order Pending	Order placed
56	17	2026-10-29 07:57:52.331634	Payment Successful	\N
57	17	2026-10-29 07:57:52.331634	Order Confirmed	\N
58	17	2026-10-29 07:57:52.331634	Shipment Pending	\N
59	17	2026-10-30 07:47:52.331634	Shipment Shipped	\N
60	17	2026-10-30 07:47:52.331634	Order Shipped	\N
61	17	2026-10-31 07:47:52.331634	Shipment In Transit	\N
62	17	2026-11-02 07:47:52.331634	Shipment Delivered	\N
63	17	2026-11-02 07:47:52.331634	Order Delivered	\N
64	18	2026-10-16 12:47:52.331634	Order Pending	Order placed
65	18	2026-10-16 12:57:52.331634	Payment Successful	\N
66	18	2026-10-16 12:57:52.331634	Order Confirmed	\N
67	18	2026-10-16 12:57:52.331634	Shipment Pending	\N
68	19	2026-10-11 17:47:52.331634	Order Pending	Order placed
69	19	2026-10-11 17:57:52.331634	Payment Successful	\N
70	19	2026-10-11 17:57:52.331634	Order Confirmed	\N
71	19	2026-10-11 17:57:52.331634	Shipment Pending	\N
72	19	2026-10-12 17:47:52.331634	Shipment Shipped	\N
73	19	2026-10-12 17:47:52.331634	Order Shipped	\N
74	20	2026-08-12 19:47:52.331634	Order Pending	Order placed
75	20	2026-08-12 19:57:52.331634	Payment Successful	\N
76	20	2026-08-12 19:57:52.331634	Order Confirmed	\N
77	20	2026-08-12 19:57:52.331634	Shipment Pending	\N
78	20	2026-08-13 19:47:52.331634	Shipment Shipped	\N
79	20	2026-08-13 19:47:52.331634	Order Shipped	\N
80	20	2026-08-14 19:47:52.331634	Shipment In Transit	\N
81	20	2026-08-16 19:47:52.331634	Shipment Delivered	\N
82	20	2026-08-16 19:47:52.331634	Order Delivered	\N
83	21	2026-09-26 03:47:52.331634	Order Pending	Order placed
84	21	2026-09-26 03:57:52.331634	Payment Successful	\N
85	21	2026-09-26 03:57:52.331634	Order Confirmed	\N
86	21	2026-09-26 03:57:52.331634	Shipment Pending	\N
87	21	2026-09-27 03:47:52.331634	Shipment Shipped	\N
88	21	2026-09-27 03:47:52.331634	Order Shipped	\N
89	21	2026-09-28 03:47:52.331634	Shipment In Transit	\N
90	22	2026-10-23 02:47:52.331634	Order Pending	Order placed
91	22	2026-10-23 03:47:52.331634	Order Cancelled	Cancelled by customer
92	22	2026-10-23 03:47:52.331634	Payment Failed	Order cancelled before payment
93	23	2026-11-10 00:38:52.331634	Order Pending	Order placed
94	23	2026-11-10 00:43:52.331634	Payment Failed	Card declined by bank
95	24	2026-11-02 14:47:52.331634	Order Pending	Order placed
96	24	2026-11-02 14:57:52.331634	Payment Successful	\N
97	24	2026-11-02 14:57:52.331634	Order Confirmed	\N
98	24	2026-11-02 14:57:52.331634	Shipment Pending	\N
99	24	2026-11-03 14:47:52.331634	Shipment Shipped	\N
100	24	2026-11-03 14:47:52.331634	Order Shipped	\N
101	25	2026-08-18 00:47:52.331634	Order Pending	Order placed
102	25	2026-08-18 00:52:52.331634	Payment Failed	Insufficient funds
103	25	2026-08-18 00:57:52.331634	Payment Successful	\N
104	25	2026-08-18 00:57:52.331634	Order Confirmed	\N
105	25	2026-08-18 00:57:52.331634	Shipment Pending	\N
106	25	2026-08-19 00:47:52.331634	Shipment Shipped	\N
107	25	2026-08-19 00:47:52.331634	Order Shipped	\N
108	25	2026-08-20 00:47:52.331634	Shipment In Transit	\N
109	25	2026-08-22 00:47:52.331634	Shipment Delivered	\N
110	25	2026-08-22 00:47:52.331634	Order Delivered	\N
111	26	2026-09-14 12:47:52.331634	Order Pending	Order placed
112	26	2026-09-14 12:52:52.331634	Payment Failed	Insufficient funds
113	26	2026-09-14 12:57:52.331634	Payment Successful	\N
114	26	2026-09-14 12:57:52.331634	Order Confirmed	\N
115	26	2026-09-14 12:57:52.331634	Shipment Pending	\N
116	26	2026-09-15 12:47:52.331634	Shipment Shipped	\N
117	26	2026-09-15 12:47:52.331634	Order Shipped	\N
118	26	2026-09-16 12:47:52.331634	Shipment In Transit	\N
119	26	2026-09-18 12:47:52.331634	Shipment Delivered	\N
120	26	2026-09-18 12:47:52.331634	Order Delivered	\N
121	27	2026-10-02 16:47:52.331634	Order Pending	Order placed
122	27	2026-10-02 16:57:52.331634	Payment Successful	\N
123	27	2026-10-02 16:57:52.331634	Order Confirmed	\N
124	27	2026-10-02 16:57:52.331634	Shipment Pending	\N
125	27	2026-10-03 16:47:52.331634	Shipment Shipped	\N
126	27	2026-10-03 16:47:52.331634	Order Shipped	\N
127	27	2026-10-04 16:47:52.331634	Shipment In Transit	\N
128	27	2026-10-06 16:47:52.331634	Shipment Delivered	\N
129	27	2026-10-06 16:47:52.331634	Order Delivered	\N
130	28	2026-09-01 06:47:52.331634	Order Pending	Order placed
131	28	2026-09-01 06:57:52.331634	Payment Successful	\N
132	28	2026-09-01 06:57:52.331634	Order Confirmed	\N
133	28	2026-09-01 06:57:52.331634	Shipment Pending	\N
134	28	2026-09-02 06:47:52.331634	Shipment Shipped	\N
135	28	2026-09-02 06:47:52.331634	Order Shipped	\N
136	29	2026-08-16 14:47:52.331634	Order Pending	Order placed
137	29	2026-08-16 14:57:52.331634	Payment Successful	\N
138	29	2026-08-16 14:57:52.331634	Order Confirmed	\N
139	29	2026-08-16 14:57:52.331634	Shipment Pending	\N
140	29	2026-08-17 14:47:52.331634	Shipment Shipped	\N
141	29	2026-08-17 14:47:52.331634	Order Shipped	\N
142	29	2026-08-18 14:47:52.331634	Shipment In Transit	\N
143	29	2026-08-20 14:47:52.331634	Shipment Delivered	\N
144	29	2026-08-20 14:47:52.331634	Order Delivered	\N
145	30	2026-09-23 12:47:52.331634	Order Pending	Order placed
146	30	2026-09-23 12:52:52.331634	Payment Failed	Insufficient funds
147	30	2026-09-23 12:57:52.331634	Payment Successful	\N
148	30	2026-09-23 12:57:52.331634	Order Confirmed	\N
149	30	2026-09-23 12:57:52.331634	Shipment Pending	\N
150	30	2026-09-24 12:47:52.331634	Shipment Shipped	\N
151	30	2026-09-24 12:47:52.331634	Order Shipped	\N
152	31	2026-09-17 16:47:52.331634	Order Pending	Order placed
153	31	2026-09-17 16:57:52.331634	Payment Successful	\N
154	31	2026-09-17 16:57:52.331634	Order Confirmed	\N
155	31	2026-09-17 16:57:52.331634	Shipment Pending	\N
156	31	2026-09-18 16:47:52.331634	Shipment Shipped	\N
157	31	2026-09-18 16:47:52.331634	Order Shipped	\N
158	31	2026-09-19 16:47:52.331634	Shipment In Transit	\N
159	32	2026-09-06 04:47:52.331634	Order Pending	Order placed
160	32	2026-09-06 04:52:52.331634	Payment Failed	Insufficient funds
161	32	2026-09-06 04:57:52.331634	Payment Successful	\N
162	32	2026-09-06 04:57:52.331634	Order Confirmed	\N
163	32	2026-09-06 04:57:52.331634	Shipment Pending	\N
164	32	2026-09-07 04:47:52.331634	Shipment Shipped	\N
165	32	2026-09-07 04:47:52.331634	Order Shipped	\N
166	32	2026-09-08 04:47:52.331634	Shipment In Transit	\N
167	33	2026-11-10 00:02:52.331634	Order Pending	Order placed
168	34	2026-11-04 01:47:52.331634	Order Pending	Order placed
169	34	2026-11-04 01:52:52.331634	Payment Failed	Insufficient funds
170	34	2026-11-04 01:57:52.331634	Payment Successful	\N
171	34	2026-11-04 01:57:52.331634	Order Confirmed	\N
172	34	2026-11-04 01:57:52.331634	Shipment Pending	\N
173	34	2026-11-05 01:47:52.331634	Shipment Shipped	\N
174	34	2026-11-05 01:47:52.331634	Order Shipped	\N
175	34	2026-11-06 01:47:52.331634	Shipment In Transit	\N
176	34	2026-11-08 01:47:52.331634	Shipment Delivered	\N
177	34	2026-11-08 01:47:52.331634	Order Delivered	\N
178	35	2026-10-30 09:47:52.331634	Order Pending	Order placed
179	35	2026-10-30 10:47:52.331634	Order Cancelled	Cancelled by customer
180	35	2026-10-30 10:47:52.331634	Payment Failed	Order cancelled before payment
181	36	2026-11-10 01:23:52.331634	Order Pending	Order placed
182	37	2026-10-07 13:47:52.331634	Order Pending	Order placed
183	37	2026-10-07 13:52:52.331634	Payment Failed	Insufficient funds
184	37	2026-10-07 13:57:52.331634	Payment Successful	\N
185	37	2026-10-07 13:57:52.331634	Order Confirmed	\N
186	37	2026-10-07 13:57:52.331634	Shipment Pending	\N
187	38	2026-11-03 15:47:52.331634	Order Pending	Order placed
188	38	2026-11-03 15:57:52.331634	Payment Successful	\N
189	38	2026-11-03 15:57:52.331634	Order Confirmed	\N
190	38	2026-11-03 15:57:52.331634	Shipment Pending	\N
191	38	2026-11-04 15:47:52.331634	Shipment Shipped	\N
192	38	2026-11-04 15:47:52.331634	Order Shipped	\N
193	38	2026-11-05 15:47:52.331634	Shipment In Transit	\N
194	39	2026-08-25 04:47:52.331634	Order Pending	Order placed
195	39	2026-08-25 04:57:52.331634	Payment Successful	\N
196	39	2026-08-25 04:57:52.331634	Order Confirmed	\N
197	39	2026-08-25 04:57:52.331634	Shipment Pending	\N
198	39	2026-08-26 04:47:52.331634	Shipment Shipped	\N
199	39	2026-08-26 04:47:52.331634	Order Shipped	\N
200	39	2026-08-27 04:47:52.331634	Shipment In Transit	\N
201	40	2026-10-30 23:47:52.331634	Order Pending	Order placed
202	40	2026-10-30 23:57:52.331634	Payment Successful	\N
203	40	2026-10-30 23:57:52.331634	Order Confirmed	\N
204	40	2026-10-30 23:57:52.331634	Shipment Pending	\N
205	40	2026-10-31 23:47:52.331634	Shipment Shipped	\N
206	40	2026-10-31 23:47:52.331634	Order Shipped	\N
207	40	2026-11-01 23:47:52.331634	Shipment In Transit	\N
208	41	2026-10-08 00:47:52.331634	Order Pending	Order placed
209	41	2026-10-08 00:57:52.331634	Payment Successful	\N
210	41	2026-10-08 00:57:52.331634	Order Confirmed	\N
211	41	2026-10-08 00:57:52.331634	Shipment Pending	\N
212	42	2026-10-29 21:47:52.331634	Order Pending	Order placed
213	42	2026-10-29 21:57:52.331634	Payment Successful	\N
214	42	2026-10-29 21:57:52.331634	Order Confirmed	\N
215	42	2026-10-29 21:57:52.331634	Shipment Pending	\N
216	42	2026-10-30 21:47:52.331634	Shipment Shipped	\N
217	42	2026-10-30 21:47:52.331634	Order Shipped	\N
218	42	2026-10-31 21:47:52.331634	Shipment In Transit	\N
219	42	2026-11-02 21:47:52.331634	Shipment Delivered	\N
220	42	2026-11-02 21:47:52.331634	Order Delivered	\N
221	43	2026-08-18 11:47:52.331634	Order Pending	Order placed
222	43	2026-08-18 11:57:52.331634	Payment Successful	\N
223	43	2026-08-18 11:57:52.331634	Order Confirmed	\N
224	43	2026-08-18 11:57:52.331634	Shipment Pending	\N
225	43	2026-08-19 11:47:52.331634	Shipment Shipped	\N
226	43	2026-08-19 11:47:52.331634	Order Shipped	\N
227	43	2026-08-20 11:47:52.331634	Shipment In Transit	\N
228	43	2026-08-22 11:47:52.331634	Shipment Delivered	\N
229	43	2026-08-22 11:47:52.331634	Order Delivered	\N
230	44	2026-09-21 07:47:52.331634	Order Pending	Order placed
231	44	2026-09-21 07:57:52.331634	Payment Successful	\N
232	44	2026-09-21 07:57:52.331634	Order Confirmed	\N
233	44	2026-09-21 07:57:52.331634	Shipment Pending	\N
234	44	2026-09-22 07:47:52.331634	Shipment Shipped	\N
235	44	2026-09-22 07:47:52.331634	Order Shipped	\N
236	44	2026-09-23 07:47:52.331634	Shipment In Transit	\N
237	44	2026-09-25 07:47:52.331634	Shipment Delivered	\N
238	44	2026-09-25 07:47:52.331634	Order Delivered	\N
239	45	2026-10-26 07:47:52.331634	Order Pending	Order placed
240	45	2026-10-26 07:57:52.331634	Payment Successful	\N
241	45	2026-10-26 07:57:52.331634	Order Confirmed	\N
242	45	2026-10-26 07:57:52.331634	Shipment Pending	\N
243	45	2026-10-27 07:47:52.331634	Shipment Shipped	\N
244	45	2026-10-27 07:47:52.331634	Order Shipped	\N
245	46	2026-10-07 21:47:52.331634	Order Pending	Order placed
246	46	2026-10-07 21:57:52.331634	Payment Successful	\N
247	46	2026-10-07 21:57:52.331634	Order Confirmed	\N
248	46	2026-10-07 21:57:52.331634	Shipment Pending	\N
249	46	2026-10-07 22:47:52.331634	Order Cancelled	Ordered by mistake
250	46	2026-10-07 22:47:52.331634	Payment Refunded	Ordered by mistake
251	46	2026-10-07 22:47:52.331634	Shipment Cancelled	Ordered by mistake
252	47	2026-11-05 01:47:52.331634	Order Pending	Order placed
253	47	2026-11-05 01:57:52.331634	Payment Successful	\N
254	47	2026-11-05 01:57:52.331634	Order Confirmed	\N
255	47	2026-11-05 01:57:52.331634	Shipment Pending	\N
256	47	2026-11-06 01:47:52.331634	Shipment Shipped	\N
257	47	2026-11-06 01:47:52.331634	Order Shipped	\N
258	48	2026-08-16 12:47:52.331634	Order Pending	Order placed
259	48	2026-08-16 12:57:52.331634	Payment Successful	\N
260	48	2026-08-16 12:57:52.331634	Order Confirmed	\N
261	48	2026-08-16 12:57:52.331634	Shipment Pending	\N
262	48	2026-08-17 12:47:52.331634	Shipment Shipped	\N
263	48	2026-08-17 12:47:52.331634	Order Shipped	\N
264	48	2026-08-18 12:47:52.331634	Shipment In Transit	\N
265	48	2026-08-20 12:47:52.331634	Shipment Delivered	\N
266	48	2026-08-20 12:47:52.331634	Order Delivered	\N
267	49	2026-09-19 06:47:52.331634	Order Pending	Order placed
268	49	2026-09-19 06:57:52.331634	Payment Successful	\N
269	49	2026-09-19 06:57:52.331634	Order Confirmed	\N
270	49	2026-09-19 06:57:52.331634	Shipment Pending	\N
271	49	2026-09-20 06:47:52.331634	Shipment Shipped	\N
272	49	2026-09-20 06:47:52.331634	Order Shipped	\N
273	49	2026-09-21 06:47:52.331634	Shipment In Transit	\N
274	49	2026-09-23 06:47:52.331634	Shipment Delivered	\N
275	49	2026-09-23 06:47:52.331634	Order Delivered	\N
276	50	2026-09-05 02:47:52.331634	Order Pending	Order placed
277	50	2026-09-05 02:52:52.331634	Payment Failed	Insufficient funds
278	50	2026-09-05 02:57:52.331634	Payment Successful	\N
279	50	2026-09-05 02:57:52.331634	Order Confirmed	\N
280	50	2026-09-05 02:57:52.331634	Shipment Pending	\N
281	51	2026-09-26 09:47:52.331634	Order Pending	Order placed
282	51	2026-09-26 09:57:52.331634	Payment Successful	\N
283	51	2026-09-26 09:57:52.331634	Order Confirmed	\N
284	51	2026-09-26 09:57:52.331634	Shipment Pending	\N
285	52	2026-08-26 20:47:52.331634	Order Pending	Order placed
286	52	2026-08-26 20:52:52.331634	Payment Failed	Insufficient funds
287	52	2026-08-26 20:57:52.331634	Payment Successful	\N
288	52	2026-08-26 20:57:52.331634	Order Confirmed	\N
289	52	2026-08-26 20:57:52.331634	Shipment Pending	\N
290	52	2026-08-27 20:47:52.331634	Shipment Shipped	\N
291	52	2026-08-27 20:47:52.331634	Order Shipped	\N
292	52	2026-08-28 20:47:52.331634	Shipment In Transit	\N
293	53	2026-10-07 04:47:52.331634	Order Pending	Order placed
294	53	2026-10-07 04:57:52.331634	Payment Successful	\N
295	53	2026-10-07 04:57:52.331634	Order Confirmed	\N
296	53	2026-10-07 04:57:52.331634	Shipment Pending	\N
297	54	2026-09-09 05:47:52.331634	Order Pending	Order placed
298	54	2026-09-09 05:52:52.331634	Payment Failed	Insufficient funds
299	54	2026-09-09 05:57:52.331634	Payment Successful	\N
300	54	2026-09-09 05:57:52.331634	Order Confirmed	\N
301	54	2026-09-09 05:57:52.331634	Shipment Pending	\N
302	54	2026-09-10 05:47:52.331634	Shipment Shipped	\N
303	54	2026-09-10 05:47:52.331634	Order Shipped	\N
304	54	2026-09-11 05:47:52.331634	Shipment In Transit	\N
305	55	2026-09-03 16:47:52.331634	Order Pending	Order placed
306	55	2026-09-03 16:57:52.331634	Payment Successful	\N
307	55	2026-09-03 16:57:52.331634	Order Confirmed	\N
308	55	2026-09-03 16:57:52.331634	Shipment Pending	\N
309	55	2026-09-04 16:47:52.331634	Shipment Shipped	\N
310	55	2026-09-04 16:47:52.331634	Order Shipped	\N
311	55	2026-09-05 16:47:52.331634	Shipment In Transit	\N
312	56	2026-09-18 11:47:52.331634	Order Pending	Order placed
313	56	2026-09-18 11:52:52.331634	Payment Failed	Insufficient funds
314	56	2026-09-18 11:57:52.331634	Payment Successful	\N
315	56	2026-09-18 11:57:52.331634	Order Confirmed	\N
316	56	2026-09-18 11:57:52.331634	Shipment Pending	\N
317	57	2026-10-10 08:47:52.331634	Order Pending	Order placed
318	57	2026-10-10 08:57:52.331634	Payment Successful	\N
319	57	2026-10-10 08:57:52.331634	Order Confirmed	\N
320	57	2026-10-10 08:57:52.331634	Shipment Pending	\N
321	57	2026-10-11 08:47:52.331634	Shipment Shipped	\N
322	57	2026-10-11 08:47:52.331634	Order Shipped	\N
323	57	2026-10-12 08:47:52.331634	Shipment In Transit	\N
324	57	2026-10-14 08:47:52.331634	Shipment Delivered	\N
325	57	2026-10-14 08:47:52.331634	Order Delivered	\N
326	58	2026-10-06 20:47:52.331634	Order Pending	Order placed
327	58	2026-10-06 20:57:52.331634	Payment Successful	\N
328	58	2026-10-06 20:57:52.331634	Order Confirmed	\N
329	58	2026-10-06 20:57:52.331634	Shipment Pending	\N
330	58	2026-10-07 20:47:52.331634	Shipment Shipped	\N
331	58	2026-10-07 20:47:52.331634	Order Shipped	\N
332	59	2026-09-26 00:47:52.331634	Order Pending	Order placed
333	59	2026-09-26 00:57:52.331634	Payment Successful	\N
334	59	2026-09-26 00:57:52.331634	Order Confirmed	\N
335	59	2026-09-26 00:57:52.331634	Shipment Pending	\N
336	60	2026-08-31 08:47:52.331634	Order Pending	Order placed
337	60	2026-08-31 08:57:52.331634	Payment Successful	\N
338	60	2026-08-31 08:57:52.331634	Order Confirmed	\N
339	60	2026-08-31 08:57:52.331634	Shipment Pending	\N
340	60	2026-09-01 08:47:52.331634	Shipment Shipped	\N
341	60	2026-09-01 08:47:52.331634	Order Shipped	\N
342	60	2026-09-02 08:47:52.331634	Shipment In Transit	\N
343	61	2026-11-01 06:47:52.331634	Order Pending	Order placed
344	61	2026-11-01 06:57:52.331634	Payment Successful	\N
345	61	2026-11-01 06:57:52.331634	Order Confirmed	\N
346	61	2026-11-01 06:57:52.331634	Shipment Pending	\N
347	61	2026-11-01 07:47:52.331634	Order Cancelled	Ordered by mistake
348	61	2026-11-01 07:47:52.331634	Payment Refunded	Ordered by mistake
349	61	2026-11-01 07:47:52.331634	Shipment Cancelled	Ordered by mistake
350	62	2026-11-04 20:47:52.331634	Order Pending	Order placed
351	62	2026-11-04 20:52:52.331634	Payment Failed	Insufficient funds
352	62	2026-11-04 20:57:52.331634	Payment Successful	\N
353	62	2026-11-04 20:57:52.331634	Order Confirmed	\N
354	62	2026-11-04 20:57:52.331634	Shipment Pending	\N
355	62	2026-11-04 21:47:52.331634	Order Cancelled	Ordered by mistake
356	62	2026-11-04 21:47:52.331634	Payment Refunded	Ordered by mistake
357	62	2026-11-04 21:47:52.331634	Shipment Cancelled	Ordered by mistake
358	63	2026-09-16 04:47:52.331634	Order Pending	Order placed
359	63	2026-09-16 04:57:52.331634	Payment Successful	\N
360	63	2026-09-16 04:57:52.331634	Order Confirmed	\N
361	63	2026-09-16 04:57:52.331634	Shipment Pending	\N
362	64	2026-11-05 03:47:52.331634	Order Pending	Order placed
363	64	2026-11-05 03:52:52.331634	Payment Failed	Insufficient funds
364	64	2026-11-05 03:57:52.331634	Payment Successful	\N
365	64	2026-11-05 03:57:52.331634	Order Confirmed	\N
366	64	2026-11-05 03:57:52.331634	Shipment Pending	\N
367	64	2026-11-06 03:47:52.331634	Shipment Shipped	\N
368	64	2026-11-06 03:47:52.331634	Order Shipped	\N
369	64	2026-11-07 03:47:52.331634	Shipment In Transit	\N
370	65	2026-08-26 13:47:52.331634	Order Pending	Order placed
371	65	2026-08-26 13:57:52.331634	Payment Successful	\N
372	65	2026-08-26 13:57:52.331634	Order Confirmed	\N
373	65	2026-08-26 13:57:52.331634	Shipment Pending	\N
374	66	2026-11-10 00:54:52.331634	Order Pending	Order placed
375	67	2026-11-10 00:14:52.331634	Order Pending	Order placed
376	68	2026-08-20 06:47:52.331634	Order Pending	Order placed
377	68	2026-08-20 06:52:52.331634	Payment Failed	Insufficient funds
378	68	2026-08-20 06:57:52.331634	Payment Successful	\N
379	68	2026-08-20 06:57:52.331634	Order Confirmed	\N
380	68	2026-08-20 06:57:52.331634	Shipment Pending	\N
381	68	2026-08-21 06:47:52.331634	Shipment Shipped	\N
382	68	2026-08-21 06:47:52.331634	Order Shipped	\N
383	68	2026-08-22 06:47:52.331634	Shipment In Transit	\N
384	69	2026-11-03 07:47:52.331634	Order Pending	Order placed
385	69	2026-11-03 07:57:52.331634	Payment Successful	\N
386	69	2026-11-03 07:57:52.331634	Order Confirmed	\N
387	69	2026-11-03 07:57:52.331634	Shipment Pending	\N
388	69	2026-11-04 07:47:52.331634	Shipment Shipped	\N
389	69	2026-11-04 07:47:52.331634	Order Shipped	\N
390	70	2026-08-24 20:47:52.331634	Order Pending	Order placed
391	70	2026-08-24 20:57:52.331634	Payment Successful	\N
392	70	2026-08-24 20:57:52.331634	Order Confirmed	\N
393	70	2026-08-24 20:57:52.331634	Shipment Pending	\N
394	70	2026-08-25 20:47:52.331634	Shipment Shipped	\N
395	70	2026-08-25 20:47:52.331634	Order Shipped	\N
396	70	2026-08-26 20:47:52.331634	Shipment In Transit	\N
397	70	2026-08-28 20:47:52.331634	Shipment Delivered	\N
398	70	2026-08-28 20:47:52.331634	Order Delivered	\N
399	71	2026-08-20 18:47:52.331634	Order Pending	Order placed
400	71	2026-08-20 18:57:52.331634	Payment Successful	\N
401	71	2026-08-20 18:57:52.331634	Order Confirmed	\N
402	71	2026-08-20 18:57:52.331634	Shipment Pending	\N
403	71	2026-08-21 18:47:52.331634	Shipment Shipped	\N
404	71	2026-08-21 18:47:52.331634	Order Shipped	\N
405	72	2026-10-14 13:47:52.331634	Order Pending	Order placed
406	72	2026-10-14 13:57:52.331634	Payment Successful	\N
407	72	2026-10-14 13:57:52.331634	Order Confirmed	\N
408	72	2026-10-14 13:57:52.331634	Shipment Pending	\N
409	72	2026-10-15 13:47:52.331634	Shipment Shipped	\N
410	72	2026-10-15 13:47:52.331634	Order Shipped	\N
411	72	2026-10-16 13:47:52.331634	Shipment In Transit	\N
412	72	2026-10-18 13:47:52.331634	Shipment Delivered	\N
413	72	2026-10-18 13:47:52.331634	Order Delivered	\N
414	73	2026-09-24 11:47:52.331634	Order Pending	Order placed
415	73	2026-09-24 11:57:52.331634	Payment Successful	\N
416	73	2026-09-24 11:57:52.331634	Order Confirmed	\N
417	73	2026-09-24 11:57:52.331634	Shipment Pending	\N
418	73	2026-09-25 11:47:52.331634	Shipment Shipped	\N
419	73	2026-09-25 11:47:52.331634	Order Shipped	\N
420	73	2026-09-26 11:47:52.331634	Shipment In Transit	\N
421	73	2026-09-28 11:47:52.331634	Shipment Delivered	\N
422	73	2026-09-28 11:47:52.331634	Order Delivered	\N
423	74	2026-10-12 03:47:52.331634	Order Pending	Order placed
424	74	2026-10-12 03:57:52.331634	Payment Successful	\N
425	74	2026-10-12 03:57:52.331634	Order Confirmed	\N
426	74	2026-10-12 03:57:52.331634	Shipment Pending	\N
427	75	2026-08-15 08:47:52.331634	Order Pending	Order placed
428	75	2026-08-15 08:57:52.331634	Payment Successful	\N
429	75	2026-08-15 08:57:52.331634	Order Confirmed	\N
430	75	2026-08-15 08:57:52.331634	Shipment Pending	\N
431	75	2026-08-16 08:47:52.331634	Shipment Shipped	\N
433	75	2026-08-17 08:47:52.331634	Shipment In Transit	\N
434	76	2026-11-10 04:35:52.331634	Order Pending	Order placed
435	76	2026-11-10 04:40:52.331634	Payment Failed	Card declined by bank
436	77	2026-09-18 19:47:52.331634	Order Pending	Order placed
437	77	2026-09-18 19:52:52.331634	Payment Failed	Insufficient funds
438	77	2026-09-18 19:57:52.331634	Payment Successful	\N
439	77	2026-09-18 19:57:52.331634	Order Confirmed	\N
440	77	2026-09-18 19:57:52.331634	Shipment Pending	\N
441	77	2026-09-19 19:47:52.331634	Shipment Shipped	\N
442	77	2026-09-19 19:47:52.331634	Order Shipped	\N
443	77	2026-09-20 19:47:52.331634	Shipment In Transit	\N
444	78	2026-09-04 18:47:52.331634	Order Pending	Order placed
445	78	2026-09-04 18:57:52.331634	Payment Successful	\N
446	78	2026-09-04 18:57:52.331634	Order Confirmed	\N
447	78	2026-09-04 18:57:52.331634	Shipment Pending	\N
448	78	2026-09-05 18:47:52.331634	Shipment Shipped	\N
449	78	2026-09-05 18:47:52.331634	Order Shipped	\N
450	78	2026-09-06 18:47:52.331634	Shipment In Transit	\N
451	79	2026-08-28 17:47:52.331634	Order Pending	Order placed
452	79	2026-08-28 17:57:52.331634	Payment Successful	\N
453	79	2026-08-28 17:57:52.331634	Order Confirmed	\N
454	79	2026-08-28 17:57:52.331634	Shipment Pending	\N
455	80	2026-09-10 07:47:52.331634	Order Pending	Order placed
456	80	2026-09-10 07:52:52.331634	Payment Failed	Insufficient funds
457	80	2026-09-10 07:57:52.331634	Payment Successful	\N
458	80	2026-09-10 07:57:52.331634	Order Confirmed	\N
459	80	2026-09-10 07:57:52.331634	Shipment Pending	\N
460	80	2026-09-11 07:47:52.331634	Shipment Shipped	\N
461	80	2026-09-11 07:47:52.331634	Order Shipped	\N
462	80	2026-09-12 07:47:52.331634	Shipment In Transit	\N
463	80	2026-09-14 07:47:52.331634	Shipment Delivered	\N
464	80	2026-09-14 07:47:52.331634	Order Delivered	\N
465	81	2026-08-19 08:47:52.331634	Order Pending	Order placed
466	81	2026-08-19 08:52:52.331634	Payment Failed	Insufficient funds
467	81	2026-08-19 08:57:52.331634	Payment Successful	\N
468	81	2026-08-19 08:57:52.331634	Order Confirmed	\N
469	81	2026-08-19 08:57:52.331634	Shipment Pending	\N
470	81	2026-08-20 08:47:52.331634	Shipment Shipped	\N
471	81	2026-08-20 08:47:52.331634	Order Shipped	\N
472	81	2026-08-21 08:47:52.331634	Shipment In Transit	\N
473	81	2026-08-23 08:47:52.331634	Shipment Delivered	\N
474	81	2026-08-23 08:47:52.331634	Order Delivered	\N
475	82	2026-09-02 14:47:52.331634	Order Pending	Order placed
476	82	2026-09-02 14:52:52.331634	Payment Failed	Insufficient funds
477	82	2026-09-02 14:57:52.331634	Payment Successful	\N
478	82	2026-09-02 14:57:52.331634	Order Confirmed	\N
479	82	2026-09-02 14:57:52.331634	Shipment Pending	\N
480	82	2026-09-03 14:47:52.331634	Shipment Shipped	\N
481	82	2026-09-03 14:47:52.331634	Order Shipped	\N
482	83	2026-08-21 22:47:52.331634	Order Pending	Order placed
483	83	2026-08-21 22:57:52.331634	Payment Successful	\N
484	83	2026-08-21 22:57:52.331634	Order Confirmed	\N
485	83	2026-08-21 22:57:52.331634	Shipment Pending	\N
486	83	2026-08-22 22:47:52.331634	Shipment Shipped	\N
487	83	2026-08-22 22:47:52.331634	Order Shipped	\N
488	84	2026-08-28 05:47:52.331634	Order Pending	Order placed
489	84	2026-08-28 06:47:52.331634	Order Cancelled	Cancelled by customer
490	84	2026-08-28 06:47:52.331634	Payment Failed	Order cancelled before payment
491	85	2026-10-12 19:47:52.331634	Order Pending	Order placed
492	85	2026-10-12 19:57:52.331634	Payment Successful	\N
493	85	2026-10-12 19:57:52.331634	Order Confirmed	\N
494	85	2026-10-12 19:57:52.331634	Shipment Pending	\N
495	86	2026-08-23 04:47:52.331634	Order Pending	Order placed
496	86	2026-08-23 04:57:52.331634	Payment Successful	\N
497	86	2026-08-23 04:57:52.331634	Order Confirmed	\N
498	86	2026-08-23 04:57:52.331634	Shipment Pending	\N
499	86	2026-08-24 04:47:52.331634	Shipment Shipped	\N
500	86	2026-08-24 04:47:52.331634	Order Shipped	\N
501	86	2026-08-25 04:47:52.331634	Shipment In Transit	\N
502	86	2026-08-27 04:47:52.331634	Shipment Delivered	\N
503	86	2026-08-27 04:47:52.331634	Order Delivered	\N
504	87	2026-11-04 07:47:52.331634	Order Pending	Order placed
505	87	2026-11-04 08:47:52.331634	Order Cancelled	Cancelled by customer
506	87	2026-11-04 08:47:52.331634	Payment Failed	Order cancelled before payment
507	88	2026-10-15 22:47:52.331634	Order Pending	Order placed
508	88	2026-10-15 22:57:52.331634	Payment Successful	\N
509	88	2026-10-15 22:57:52.331634	Order Confirmed	\N
510	88	2026-10-15 22:57:52.331634	Shipment Pending	\N
511	88	2026-10-16 22:47:52.331634	Shipment Shipped	\N
512	88	2026-10-16 22:47:52.331634	Order Shipped	\N
513	89	2026-10-16 10:47:52.331634	Order Pending	Order placed
514	89	2026-10-16 10:57:52.331634	Payment Successful	\N
515	89	2026-10-16 10:57:52.331634	Order Confirmed	\N
516	89	2026-10-16 10:57:52.331634	Shipment Pending	\N
517	89	2026-10-17 10:47:52.331634	Shipment Shipped	\N
518	89	2026-10-17 10:47:52.331634	Order Shipped	\N
519	89	2026-10-18 10:47:52.331634	Shipment In Transit	\N
520	89	2026-10-20 10:47:52.331634	Shipment Delivered	\N
521	89	2026-10-20 10:47:52.331634	Order Delivered	\N
522	90	2026-09-19 00:47:52.331634	Order Pending	Order placed
523	90	2026-09-19 01:47:52.331634	Order Cancelled	Cancelled by customer
524	90	2026-09-19 01:47:52.331634	Payment Failed	Order cancelled before payment
525	91	2026-09-24 17:47:52.331634	Order Pending	Order placed
526	91	2026-09-24 17:57:52.331634	Payment Successful	\N
527	91	2026-09-24 17:57:52.331634	Order Confirmed	\N
528	91	2026-09-24 17:57:52.331634	Shipment Pending	\N
529	91	2026-09-25 17:47:52.331634	Shipment Shipped	\N
530	91	2026-09-25 17:47:52.331634	Order Shipped	\N
531	92	2026-10-23 12:47:52.331634	Order Pending	Order placed
532	92	2026-10-23 13:47:52.331634	Order Cancelled	Cancelled by customer
533	92	2026-10-23 13:47:52.331634	Payment Failed	Order cancelled before payment
534	93	2026-09-24 03:47:52.331634	Order Pending	Order placed
535	93	2026-09-24 03:52:52.331634	Payment Failed	Insufficient funds
536	93	2026-09-24 03:57:52.331634	Payment Successful	\N
537	93	2026-09-24 03:57:52.331634	Order Confirmed	\N
538	93	2026-09-24 03:57:52.331634	Shipment Pending	\N
539	93	2026-09-25 03:47:52.331634	Shipment Shipped	\N
540	93	2026-09-25 03:47:52.331634	Order Shipped	\N
541	93	2026-09-26 03:47:52.331634	Shipment In Transit	\N
542	93	2026-09-28 03:47:52.331634	Shipment Delivered	\N
543	93	2026-09-28 03:47:52.331634	Order Delivered	\N
544	94	2026-10-12 12:47:52.331634	Order Pending	Order placed
545	94	2026-10-12 12:57:52.331634	Payment Successful	\N
546	94	2026-10-12 12:57:52.331634	Order Confirmed	\N
547	94	2026-10-12 12:57:52.331634	Shipment Pending	\N
548	94	2026-10-13 12:47:52.331634	Shipment Shipped	\N
549	94	2026-10-13 12:47:52.331634	Order Shipped	\N
550	94	2026-10-14 12:47:52.331634	Shipment In Transit	\N
551	94	2026-10-16 12:47:52.331634	Shipment Delivered	\N
552	94	2026-10-16 12:47:52.331634	Order Delivered	\N
553	95	2026-09-21 22:47:52.331634	Order Pending	Order placed
554	95	2026-09-21 22:57:52.331634	Payment Successful	\N
555	95	2026-09-21 22:57:52.331634	Order Confirmed	\N
556	95	2026-09-21 22:57:52.331634	Shipment Pending	\N
557	95	2026-09-22 22:47:52.331634	Shipment Shipped	\N
558	95	2026-09-22 22:47:52.331634	Order Shipped	\N
559	95	2026-09-23 22:47:52.331634	Shipment In Transit	\N
560	95	2026-09-25 22:47:52.331634	Shipment Delivered	\N
561	95	2026-09-25 22:47:52.331634	Order Delivered	\N
562	96	2026-10-22 00:47:52.331634	Order Pending	Order placed
563	96	2026-10-22 00:57:52.331634	Payment Successful	\N
564	96	2026-10-22 00:57:52.331634	Order Confirmed	\N
565	96	2026-10-22 00:57:52.331634	Shipment Pending	\N
566	96	2026-10-23 00:47:52.331634	Shipment Shipped	\N
567	96	2026-10-23 00:47:52.331634	Order Shipped	\N
568	96	2026-10-24 00:47:52.331634	Shipment In Transit	\N
569	97	2026-11-03 07:47:52.331634	Order Pending	Order placed
570	97	2026-11-03 07:52:52.331634	Payment Failed	Insufficient funds
571	97	2026-11-03 07:57:52.331634	Payment Successful	\N
572	97	2026-11-03 07:57:52.331634	Order Confirmed	\N
573	97	2026-11-03 07:57:52.331634	Shipment Pending	\N
574	97	2026-11-04 07:47:52.331634	Shipment Shipped	\N
575	97	2026-11-04 07:47:52.331634	Order Shipped	\N
576	97	2026-11-05 07:47:52.331634	Shipment In Transit	\N
577	97	2026-11-07 07:47:52.331634	Shipment Delivered	\N
578	97	2026-11-07 07:47:52.331634	Order Delivered	\N
579	98	2026-09-19 08:47:52.331634	Order Pending	Order placed
580	98	2026-09-19 08:57:52.331634	Payment Successful	\N
581	98	2026-09-19 08:57:52.331634	Order Confirmed	\N
582	98	2026-09-19 08:57:52.331634	Shipment Pending	\N
583	99	2026-08-30 20:47:52.331634	Order Pending	Order placed
584	99	2026-08-30 20:57:52.331634	Payment Successful	\N
585	99	2026-08-30 20:57:52.331634	Order Confirmed	\N
586	99	2026-08-30 20:57:52.331634	Shipment Pending	\N
587	99	2026-08-31 20:47:52.331634	Shipment Shipped	\N
588	99	2026-08-31 20:47:52.331634	Order Shipped	\N
589	99	2026-09-01 20:47:52.331634	Shipment In Transit	\N
590	100	2026-08-25 20:47:52.331634	Order Pending	Order placed
591	100	2026-08-25 20:57:52.331634	Payment Successful	\N
592	100	2026-08-25 20:57:52.331634	Order Confirmed	\N
593	100	2026-08-25 20:57:52.331634	Shipment Pending	\N
594	100	2026-08-26 20:47:52.331634	Shipment Shipped	\N
595	100	2026-08-26 20:47:52.331634	Order Shipped	\N
596	100	2026-08-27 20:47:52.331634	Shipment In Transit	\N
597	101	2026-09-13 08:47:52.331634	Order Pending	Order placed
598	101	2026-09-13 08:57:52.331634	Payment Successful	\N
599	101	2026-09-13 08:57:52.331634	Order Confirmed	\N
600	101	2026-09-13 08:57:52.331634	Shipment Pending	\N
601	102	2026-09-08 00:47:52.331634	Order Pending	Order placed
602	102	2026-09-08 00:57:52.331634	Payment Successful	\N
603	102	2026-09-08 00:57:52.331634	Order Confirmed	\N
604	102	2026-09-08 00:57:52.331634	Shipment Pending	\N
605	103	2026-08-15 09:47:52.331634	Order Pending	Order placed
606	103	2026-08-15 09:57:52.331634	Payment Successful	\N
607	103	2026-08-15 09:57:52.331634	Order Confirmed	\N
608	103	2026-08-15 09:57:52.331634	Shipment Pending	\N
609	103	2026-08-16 09:47:52.331634	Shipment Shipped	\N
610	103	2026-08-16 09:47:52.331634	Order Shipped	\N
611	103	2026-08-17 09:47:52.331634	Shipment In Transit	\N
612	103	2026-08-19 09:47:52.331634	Shipment Delivered	\N
613	103	2026-08-19 09:47:52.331634	Order Delivered	\N
614	104	2026-08-20 21:47:52.331634	Order Pending	Order placed
615	104	2026-08-20 21:52:52.331634	Payment Failed	Insufficient funds
616	104	2026-08-20 21:57:52.331634	Payment Successful	\N
617	104	2026-08-20 21:57:52.331634	Order Confirmed	\N
618	104	2026-08-20 21:57:52.331634	Shipment Pending	\N
619	104	2026-08-21 21:47:52.331634	Shipment Shipped	\N
620	104	2026-08-21 21:47:52.331634	Order Shipped	\N
621	104	2026-08-22 21:47:52.331634	Shipment In Transit	\N
622	104	2026-08-24 21:47:52.331634	Shipment Delivered	\N
623	104	2026-08-24 21:47:52.331634	Order Delivered	\N
624	105	2026-11-09 22:03:52.331634	Order Pending	Order placed
625	106	2026-09-19 17:47:52.331634	Order Pending	Order placed
626	106	2026-09-19 17:57:52.331634	Payment Successful	\N
627	106	2026-09-19 17:57:52.331634	Order Confirmed	\N
628	106	2026-09-19 17:57:52.331634	Shipment Pending	\N
629	106	2026-09-20 17:47:52.331634	Shipment Shipped	\N
630	106	2026-09-20 17:47:52.331634	Order Shipped	\N
631	106	2026-09-21 17:47:52.331634	Shipment In Transit	\N
632	107	2026-08-30 15:47:52.331634	Order Pending	Order placed
633	107	2026-08-30 15:57:52.331634	Payment Successful	\N
634	107	2026-08-30 15:57:52.331634	Order Confirmed	\N
635	107	2026-08-30 15:57:52.331634	Shipment Pending	\N
636	107	2026-08-31 15:47:52.331634	Shipment Shipped	\N
637	107	2026-08-31 15:47:52.331634	Order Shipped	\N
638	108	2026-11-10 05:55:52.331634	Order Pending	Order placed
639	108	2026-11-10 06:00:52.331634	Payment Failed	Card declined by bank
640	109	2026-10-17 22:47:52.331634	Order Pending	Order placed
641	109	2026-10-17 22:57:52.331634	Payment Successful	\N
642	109	2026-10-17 22:57:52.331634	Order Confirmed	\N
643	109	2026-10-17 22:57:52.331634	Shipment Pending	\N
644	109	2026-10-18 22:47:52.331634	Shipment Shipped	\N
645	109	2026-10-18 22:47:52.331634	Order Shipped	\N
646	110	2026-09-04 19:47:52.331634	Order Pending	Order placed
647	110	2026-09-04 19:57:52.331634	Payment Successful	\N
648	110	2026-09-04 19:57:52.331634	Order Confirmed	\N
649	110	2026-09-04 19:57:52.331634	Shipment Pending	\N
650	110	2026-09-05 19:47:52.331634	Shipment Shipped	\N
651	110	2026-09-05 19:47:52.331634	Order Shipped	\N
652	110	2026-09-06 19:47:52.331634	Shipment In Transit	\N
653	111	2026-10-29 13:47:52.331634	Order Pending	Order placed
654	111	2026-10-29 13:57:52.331634	Payment Successful	\N
655	111	2026-10-29 13:57:52.331634	Order Confirmed	\N
656	111	2026-10-29 13:57:52.331634	Shipment Pending	\N
657	112	2026-09-05 22:47:52.331634	Order Pending	Order placed
658	112	2026-09-05 22:57:52.331634	Payment Successful	\N
659	112	2026-09-05 22:57:52.331634	Order Confirmed	\N
660	112	2026-09-05 22:57:52.331634	Shipment Pending	\N
661	113	2026-10-11 08:47:52.331634	Order Pending	Order placed
662	113	2026-10-11 08:57:52.331634	Payment Successful	\N
663	113	2026-10-11 08:57:52.331634	Order Confirmed	\N
664	113	2026-10-11 08:57:52.331634	Shipment Pending	\N
665	113	2026-10-12 08:47:52.331634	Shipment Shipped	\N
666	113	2026-10-12 08:47:52.331634	Order Shipped	\N
667	113	2026-10-13 08:47:52.331634	Shipment In Transit	\N
668	113	2026-10-15 08:47:52.331634	Shipment Delivered	\N
669	113	2026-10-15 08:47:52.331634	Order Delivered	\N
670	114	2026-09-20 18:47:52.331634	Order Pending	Order placed
671	114	2026-09-20 18:52:52.331634	Payment Failed	Insufficient funds
672	114	2026-09-20 18:57:52.331634	Payment Successful	\N
673	114	2026-09-20 18:57:52.331634	Order Confirmed	\N
674	114	2026-09-20 18:57:52.331634	Shipment Pending	\N
675	114	2026-09-21 18:47:52.331634	Shipment Shipped	\N
676	114	2026-09-21 18:47:52.331634	Order Shipped	\N
677	114	2026-09-22 18:47:52.331634	Shipment In Transit	\N
678	115	2026-08-29 13:47:52.331634	Order Pending	Order placed
679	115	2026-08-29 14:47:52.331634	Order Cancelled	Cancelled by customer
680	115	2026-08-29 14:47:52.331634	Payment Failed	Order cancelled before payment
681	116	2026-10-21 06:47:52.331634	Order Pending	Order placed
682	116	2026-10-21 06:52:52.331634	Payment Failed	Insufficient funds
683	116	2026-10-21 06:57:52.331634	Payment Successful	\N
684	116	2026-10-21 06:57:52.331634	Order Confirmed	\N
685	116	2026-10-21 06:57:52.331634	Shipment Pending	\N
686	116	2026-10-22 06:47:52.331634	Shipment Shipped	\N
687	116	2026-10-22 06:47:52.331634	Order Shipped	\N
688	116	2026-10-23 06:47:52.331634	Shipment In Transit	\N
689	116	2026-10-25 06:47:52.331634	Shipment Delivered	\N
690	116	2026-10-25 06:47:52.331634	Order Delivered	\N
691	117	2026-11-10 06:27:52.331634	Order Pending	Order placed
692	117	2026-11-10 06:32:52.331634	Payment Failed	Card declined by bank
693	118	2026-08-19 03:47:52.331634	Order Pending	Order placed
694	118	2026-08-19 03:57:52.331634	Payment Successful	\N
695	118	2026-08-19 03:57:52.331634	Order Confirmed	\N
696	118	2026-08-19 03:57:52.331634	Shipment Pending	\N
697	119	2026-10-06 16:47:52.331634	Order Pending	Order placed
698	119	2026-10-06 16:57:52.331634	Payment Successful	\N
699	119	2026-10-06 16:57:52.331634	Order Confirmed	\N
700	119	2026-10-06 16:57:52.331634	Shipment Pending	\N
701	119	2026-10-07 16:47:52.331634	Shipment Shipped	\N
702	119	2026-10-07 16:47:52.331634	Order Shipped	\N
703	119	2026-10-08 16:47:52.331634	Shipment In Transit	\N
704	120	2026-09-16 15:47:52.331634	Order Pending	Order placed
705	120	2026-09-16 15:57:52.331634	Payment Successful	\N
706	120	2026-09-16 15:57:52.331634	Order Confirmed	\N
707	120	2026-09-16 15:57:52.331634	Shipment Pending	\N
708	120	2026-09-17 15:47:52.331634	Shipment Shipped	\N
709	120	2026-09-17 15:47:52.331634	Order Shipped	\N
710	120	2026-09-18 15:47:52.331634	Shipment In Transit	\N
711	120	2026-09-20 15:47:52.331634	Shipment Delivered	\N
712	120	2026-09-20 15:47:52.331634	Order Delivered	\N
713	121	2026-10-29 08:47:52.331634	Order Pending	Order placed
714	121	2026-10-29 08:57:52.331634	Payment Successful	\N
715	121	2026-10-29 08:57:52.331634	Order Confirmed	\N
716	121	2026-10-29 08:57:52.331634	Shipment Pending	\N
717	121	2026-10-30 08:47:52.331634	Shipment Shipped	\N
718	121	2026-10-30 08:47:52.331634	Order Shipped	\N
719	121	2026-10-31 08:47:52.331634	Shipment In Transit	\N
720	121	2026-11-02 08:47:52.331634	Shipment Delivered	\N
721	121	2026-11-02 08:47:52.331634	Order Delivered	\N
722	122	2026-09-25 07:47:52.331634	Order Pending	Order placed
723	122	2026-09-25 08:47:52.331634	Order Cancelled	Cancelled by customer
724	122	2026-09-25 08:47:52.331634	Payment Failed	Order cancelled before payment
725	123	2026-11-10 05:08:52.331634	Order Pending	Order placed
726	124	2026-11-10 02:48:52.331634	Order Pending	Order placed
727	124	2026-11-10 02:53:52.331634	Payment Failed	Card declined by bank
728	125	2026-09-19 18:47:52.331634	Order Pending	Order placed
729	125	2026-09-19 18:57:52.331634	Payment Successful	\N
730	125	2026-09-19 18:57:52.331634	Order Confirmed	\N
731	125	2026-09-19 18:57:52.331634	Shipment Pending	\N
732	125	2026-09-20 18:47:52.331634	Shipment Shipped	\N
733	125	2026-09-20 18:47:52.331634	Order Shipped	\N
734	125	2026-09-21 18:47:52.331634	Shipment In Transit	\N
735	125	2026-09-23 18:47:52.331634	Shipment Delivered	\N
736	125	2026-09-23 18:47:52.331634	Order Delivered	\N
737	126	2026-10-30 00:47:52.331634	Order Pending	Order placed
738	126	2026-10-30 00:57:52.331634	Payment Successful	\N
739	126	2026-10-30 00:57:52.331634	Order Confirmed	\N
740	126	2026-10-30 00:57:52.331634	Shipment Pending	\N
741	126	2026-10-31 00:47:52.331634	Shipment Shipped	\N
742	126	2026-10-31 00:47:52.331634	Order Shipped	\N
743	127	2026-11-10 05:42:52.331634	Order Pending	Order placed
744	127	2026-11-10 05:47:52.331634	Payment Failed	Card declined by bank
745	128	2026-09-17 03:47:52.331634	Order Pending	Order placed
746	128	2026-09-17 03:57:52.331634	Payment Successful	\N
747	128	2026-09-17 03:57:52.331634	Order Confirmed	\N
748	128	2026-09-17 03:57:52.331634	Shipment Pending	\N
749	128	2026-09-18 03:47:52.331634	Shipment Shipped	\N
750	128	2026-09-18 03:47:52.331634	Order Shipped	\N
751	128	2026-09-19 03:47:52.331634	Shipment In Transit	\N
752	129	2026-11-10 04:48:52.331634	Order Pending	Order placed
753	130	2026-10-28 21:47:52.331634	Order Pending	Order placed
754	130	2026-10-28 21:52:52.331634	Payment Failed	Insufficient funds
755	130	2026-10-28 21:57:52.331634	Payment Successful	\N
756	130	2026-10-28 21:57:52.331634	Order Confirmed	\N
757	130	2026-10-28 21:57:52.331634	Shipment Pending	\N
758	130	2026-10-29 21:47:52.331634	Shipment Shipped	\N
759	130	2026-10-29 21:47:52.331634	Order Shipped	\N
760	130	2026-10-30 21:47:52.331634	Shipment In Transit	\N
761	130	2026-11-01 21:47:52.331634	Shipment Delivered	\N
762	130	2026-11-01 21:47:52.331634	Order Delivered	\N
763	131	2026-10-08 13:47:52.331634	Order Pending	Order placed
764	131	2026-10-08 13:52:52.331634	Payment Failed	Insufficient funds
765	131	2026-10-08 13:57:52.331634	Payment Successful	\N
766	131	2026-10-08 13:57:52.331634	Order Confirmed	\N
767	131	2026-10-08 13:57:52.331634	Shipment Pending	\N
768	131	2026-10-09 13:47:52.331634	Shipment Shipped	\N
769	131	2026-10-09 13:47:52.331634	Order Shipped	\N
770	131	2026-10-10 13:47:52.331634	Shipment In Transit	\N
771	131	2026-10-12 13:47:52.331634	Shipment Delivered	\N
772	131	2026-10-12 13:47:52.331634	Order Delivered	\N
773	132	2026-09-27 17:47:52.331634	Order Pending	Order placed
774	132	2026-09-27 17:57:52.331634	Payment Successful	\N
775	132	2026-09-27 17:57:52.331634	Order Confirmed	\N
776	132	2026-09-27 17:57:52.331634	Shipment Pending	\N
777	132	2026-09-28 17:47:52.331634	Shipment Shipped	\N
778	132	2026-09-28 17:47:52.331634	Order Shipped	\N
779	132	2026-09-29 17:47:52.331634	Shipment In Transit	\N
780	132	2026-10-01 17:47:52.331634	Shipment Delivered	\N
781	132	2026-10-01 17:47:52.331634	Order Delivered	\N
782	133	2026-10-13 08:47:52.331634	Order Pending	Order placed
783	133	2026-10-13 08:52:52.331634	Payment Failed	Insufficient funds
784	133	2026-10-13 08:57:52.331634	Payment Successful	\N
785	133	2026-10-13 08:57:52.331634	Order Confirmed	\N
786	133	2026-10-13 08:57:52.331634	Shipment Pending	\N
787	133	2026-10-13 09:47:52.331634	Order Cancelled	Ordered by mistake
788	133	2026-10-13 09:47:52.331634	Payment Refunded	Ordered by mistake
789	133	2026-10-13 09:47:52.331634	Shipment Cancelled	Ordered by mistake
790	134	2026-08-12 21:47:52.331634	Order Pending	Order placed
791	134	2026-08-12 21:57:52.331634	Payment Successful	\N
792	134	2026-08-12 21:57:52.331634	Order Confirmed	\N
793	134	2026-08-12 21:57:52.331634	Shipment Pending	\N
794	134	2026-08-13 21:47:52.331634	Shipment Shipped	\N
795	134	2026-08-13 21:47:52.331634	Order Shipped	\N
796	134	2026-08-14 21:47:52.331634	Shipment In Transit	\N
797	134	2026-08-16 21:47:52.331634	Shipment Delivered	\N
798	134	2026-08-16 21:47:52.331634	Order Delivered	\N
799	135	2026-10-29 11:47:52.331634	Order Pending	Order placed
800	135	2026-10-29 11:52:52.331634	Payment Failed	Insufficient funds
801	135	2026-10-29 11:57:52.331634	Payment Successful	\N
802	135	2026-10-29 11:57:52.331634	Order Confirmed	\N
803	135	2026-10-29 11:57:52.331634	Shipment Pending	\N
804	135	2026-10-30 11:47:52.331634	Shipment Shipped	\N
805	135	2026-10-30 11:47:52.331634	Order Shipped	\N
806	136	2026-09-09 05:47:52.331634	Order Pending	Order placed
807	136	2026-09-09 05:52:52.331634	Payment Failed	Insufficient funds
808	136	2026-09-09 05:57:52.331634	Payment Successful	\N
809	136	2026-09-09 05:57:52.331634	Order Confirmed	\N
810	136	2026-09-09 05:57:52.331634	Shipment Pending	\N
811	136	2026-09-10 05:47:52.331634	Shipment Shipped	\N
812	136	2026-09-10 05:47:52.331634	Order Shipped	\N
813	137	2026-10-10 21:47:52.331634	Order Pending	Order placed
814	137	2026-10-10 21:57:52.331634	Payment Successful	\N
815	137	2026-10-10 21:57:52.331634	Order Confirmed	\N
816	137	2026-10-10 21:57:52.331634	Shipment Pending	\N
817	137	2026-10-11 21:47:52.331634	Shipment Shipped	\N
818	137	2026-10-11 21:47:52.331634	Order Shipped	\N
819	137	2026-10-12 21:47:52.331634	Shipment In Transit	\N
820	137	2026-10-14 21:47:52.331634	Shipment Delivered	\N
821	137	2026-10-14 21:47:52.331634	Order Delivered	\N
822	138	2026-09-29 22:47:52.331634	Order Pending	Order placed
823	138	2026-09-29 22:57:52.331634	Payment Successful	\N
824	138	2026-09-29 22:57:52.331634	Order Confirmed	\N
825	138	2026-09-29 22:57:52.331634	Shipment Pending	\N
826	138	2026-09-30 22:47:52.331634	Shipment Shipped	\N
827	138	2026-09-30 22:47:52.331634	Order Shipped	\N
828	139	2026-09-18 21:47:52.331634	Order Pending	Order placed
829	139	2026-09-18 21:57:52.331634	Payment Successful	\N
830	139	2026-09-18 21:57:52.331634	Order Confirmed	\N
831	139	2026-09-18 21:57:52.331634	Shipment Pending	\N
832	139	2026-09-19 21:47:52.331634	Shipment Shipped	\N
833	139	2026-09-19 21:47:52.331634	Order Shipped	\N
834	139	2026-09-20 21:47:52.331634	Shipment In Transit	\N
835	139	2026-09-22 21:47:52.331634	Shipment Delivered	\N
836	139	2026-09-22 21:47:52.331634	Order Delivered	\N
837	140	2026-11-09 21:23:52.331634	Order Pending	Order placed
838	141	2026-09-24 04:47:52.331634	Order Pending	Order placed
839	141	2026-09-24 04:57:52.331634	Payment Successful	\N
840	141	2026-09-24 04:57:52.331634	Order Confirmed	\N
841	141	2026-09-24 04:57:52.331634	Shipment Pending	\N
842	141	2026-09-24 05:47:52.331634	Order Cancelled	Ordered by mistake
843	141	2026-09-24 05:47:52.331634	Payment Refunded	Ordered by mistake
844	141	2026-09-24 05:47:52.331634	Shipment Cancelled	Ordered by mistake
845	142	2026-10-08 15:47:52.331634	Order Pending	Order placed
846	142	2026-10-08 15:52:52.331634	Payment Failed	Insufficient funds
847	142	2026-10-08 15:57:52.331634	Payment Successful	\N
848	142	2026-10-08 15:57:52.331634	Order Confirmed	\N
849	142	2026-10-08 15:57:52.331634	Shipment Pending	\N
850	142	2026-10-09 15:47:52.331634	Shipment Shipped	\N
851	142	2026-10-09 15:47:52.331634	Order Shipped	\N
852	142	2026-10-10 15:47:52.331634	Shipment In Transit	\N
853	142	2026-10-12 15:47:52.331634	Shipment Delivered	\N
854	142	2026-10-12 15:47:52.331634	Order Delivered	\N
855	143	2026-11-10 00:27:52.331634	Order Pending	Order placed
856	144	2026-10-28 08:47:52.331634	Order Pending	Order placed
857	144	2026-10-28 08:57:52.331634	Payment Successful	\N
859	144	2026-10-28 08:57:52.331634	Shipment Pending	\N
860	144	2026-10-28 09:47:52.331634	Order Cancelled	Ordered by mistake
861	144	2026-10-28 09:47:52.331634	Payment Refunded	Ordered by mistake
862	144	2026-10-28 09:47:52.331634	Shipment Cancelled	Ordered by mistake
863	145	2026-10-01 05:47:52.331634	Order Pending	Order placed
864	145	2026-10-01 05:57:52.331634	Payment Successful	\N
865	145	2026-10-01 05:57:52.331634	Order Confirmed	\N
866	145	2026-10-01 05:57:52.331634	Shipment Pending	\N
867	146	2026-08-23 08:47:52.331634	Order Pending	Order placed
868	146	2026-08-23 08:57:52.331634	Payment Successful	\N
869	146	2026-08-23 08:57:52.331634	Order Confirmed	\N
870	146	2026-08-23 08:57:52.331634	Shipment Pending	\N
871	146	2026-08-23 09:47:52.331634	Order Cancelled	Ordered by mistake
872	146	2026-08-23 09:47:52.331634	Payment Refunded	Ordered by mistake
873	146	2026-08-23 09:47:52.331634	Shipment Cancelled	Ordered by mistake
874	147	2026-10-07 18:47:52.331634	Order Pending	Order placed
875	147	2026-10-07 18:52:52.331634	Payment Failed	Insufficient funds
876	147	2026-10-07 18:57:52.331634	Payment Successful	\N
877	147	2026-10-07 18:57:52.331634	Order Confirmed	\N
878	147	2026-10-07 18:57:52.331634	Shipment Pending	\N
879	147	2026-10-08 18:47:52.331634	Shipment Shipped	\N
880	147	2026-10-08 18:47:52.331634	Order Shipped	\N
881	147	2026-10-09 18:47:52.331634	Shipment In Transit	\N
882	147	2026-10-11 18:47:52.331634	Shipment Delivered	\N
883	147	2026-10-11 18:47:52.331634	Order Delivered	\N
884	148	2026-09-13 15:47:52.331634	Order Pending	Order placed
885	148	2026-09-13 15:57:52.331634	Payment Successful	\N
886	148	2026-09-13 15:57:52.331634	Order Confirmed	\N
887	148	2026-09-13 15:57:52.331634	Shipment Pending	\N
888	148	2026-09-14 15:47:52.331634	Shipment Shipped	\N
889	148	2026-09-14 15:47:52.331634	Order Shipped	\N
890	148	2026-09-15 15:47:52.331634	Shipment In Transit	\N
891	148	2026-09-17 15:47:52.331634	Shipment Delivered	\N
892	148	2026-09-17 15:47:52.331634	Order Delivered	\N
893	149	2026-08-29 12:47:52.331634	Order Pending	Order placed
894	149	2026-08-29 12:52:52.331634	Payment Failed	Insufficient funds
895	149	2026-08-29 12:57:52.331634	Payment Successful	\N
896	149	2026-08-29 12:57:52.331634	Order Confirmed	\N
897	149	2026-08-29 12:57:52.331634	Shipment Pending	\N
898	150	2026-09-10 07:47:52.331634	Order Pending	Order placed
899	150	2026-09-10 07:57:52.331634	Payment Successful	\N
900	150	2026-09-10 07:57:52.331634	Order Confirmed	\N
901	150	2026-09-10 07:57:52.331634	Shipment Pending	\N
902	151	2026-10-06 22:47:52.331634	Order Pending	Order placed
903	151	2026-10-06 22:57:52.331634	Payment Successful	\N
904	151	2026-10-06 22:57:52.331634	Order Confirmed	\N
905	151	2026-10-06 22:57:52.331634	Shipment Pending	\N
906	151	2026-10-07 22:47:52.331634	Shipment Shipped	\N
907	151	2026-10-07 22:47:52.331634	Order Shipped	\N
908	152	2026-09-16 09:47:52.331634	Order Pending	Order placed
909	152	2026-09-16 09:57:52.331634	Payment Successful	\N
910	152	2026-09-16 09:57:52.331634	Order Confirmed	\N
911	152	2026-09-16 09:57:52.331634	Shipment Pending	\N
912	152	2026-09-17 09:47:52.331634	Shipment Shipped	\N
913	152	2026-09-17 09:47:52.331634	Order Shipped	\N
914	152	2026-09-18 09:47:52.331634	Shipment In Transit	\N
915	152	2026-09-20 09:47:52.331634	Shipment Delivered	\N
916	152	2026-09-20 09:47:52.331634	Order Delivered	\N
917	153	2026-10-29 22:47:52.331634	Order Pending	Order placed
918	153	2026-10-29 22:57:52.331634	Payment Successful	\N
919	153	2026-10-29 22:57:52.331634	Order Confirmed	\N
920	153	2026-10-29 22:57:52.331634	Shipment Pending	\N
921	153	2026-10-30 22:47:52.331634	Shipment Shipped	\N
922	153	2026-10-30 22:47:52.331634	Order Shipped	\N
923	154	2026-11-10 04:37:52.331634	Order Pending	Order placed
924	155	2026-10-24 03:47:52.331634	Order Pending	Order placed
925	155	2026-10-24 03:52:52.331634	Payment Failed	Insufficient funds
926	155	2026-10-24 03:57:52.331634	Payment Successful	\N
927	155	2026-10-24 03:57:52.331634	Order Confirmed	\N
928	155	2026-10-24 03:57:52.331634	Shipment Pending	\N
929	155	2026-10-25 03:47:52.331634	Shipment Shipped	\N
930	155	2026-10-25 03:47:52.331634	Order Shipped	\N
931	155	2026-10-26 03:47:52.331634	Shipment In Transit	\N
932	156	2026-10-28 15:47:52.331634	Order Pending	Order placed
933	156	2026-10-28 15:57:52.331634	Payment Successful	\N
934	156	2026-10-28 15:57:52.331634	Order Confirmed	\N
935	156	2026-10-28 15:57:52.331634	Shipment Pending	\N
936	157	2026-11-01 09:47:52.331634	Order Pending	Order placed
937	157	2026-11-01 10:47:52.331634	Order Cancelled	Cancelled by customer
938	157	2026-11-01 10:47:52.331634	Payment Failed	Order cancelled before payment
939	158	2026-09-14 19:47:52.331634	Order Pending	Order placed
940	158	2026-09-14 20:47:52.331634	Order Cancelled	Cancelled by customer
941	158	2026-09-14 20:47:52.331634	Payment Failed	Order cancelled before payment
942	159	2026-11-09 21:53:52.331634	Order Pending	Order placed
943	160	2026-09-19 08:47:52.331634	Order Pending	Order placed
944	160	2026-09-19 08:57:52.331634	Payment Successful	\N
945	160	2026-09-19 08:57:52.331634	Order Confirmed	\N
946	160	2026-09-19 08:57:52.331634	Shipment Pending	\N
947	160	2026-09-20 08:47:52.331634	Shipment Shipped	\N
948	160	2026-09-20 08:47:52.331634	Order Shipped	\N
949	160	2026-09-21 08:47:52.331634	Shipment In Transit	\N
950	160	2026-09-23 08:47:52.331634	Shipment Delivered	\N
951	160	2026-09-23 08:47:52.331634	Order Delivered	\N
952	161	2026-10-13 21:47:52.331634	Order Pending	Order placed
953	161	2026-10-13 21:57:52.331634	Payment Successful	\N
954	161	2026-10-13 21:57:52.331634	Order Confirmed	\N
955	161	2026-10-13 21:57:52.331634	Shipment Pending	\N
956	161	2026-10-14 21:47:52.331634	Shipment Shipped	\N
957	161	2026-10-14 21:47:52.331634	Order Shipped	\N
958	161	2026-10-15 21:47:52.331634	Shipment In Transit	\N
959	161	2026-10-17 21:47:52.331634	Shipment Delivered	\N
960	161	2026-10-17 21:47:52.331634	Order Delivered	\N
961	162	2026-09-29 15:47:52.331634	Order Pending	Order placed
962	162	2026-09-29 15:57:52.331634	Payment Successful	\N
963	162	2026-09-29 15:57:52.331634	Order Confirmed	\N
964	162	2026-09-29 15:57:52.331634	Shipment Pending	\N
965	163	2026-09-22 07:47:52.331634	Order Pending	Order placed
966	163	2026-09-22 07:57:52.331634	Payment Successful	\N
967	163	2026-09-22 07:57:52.331634	Order Confirmed	\N
968	163	2026-09-22 07:57:52.331634	Shipment Pending	\N
969	163	2026-09-23 07:47:52.331634	Shipment Shipped	\N
970	163	2026-09-23 07:47:52.331634	Order Shipped	\N
971	163	2026-09-24 07:47:52.331634	Shipment In Transit	\N
972	163	2026-09-26 07:47:52.331634	Shipment Delivered	\N
973	163	2026-09-26 07:47:52.331634	Order Delivered	\N
974	164	2026-10-22 07:47:52.331634	Order Pending	Order placed
975	164	2026-10-22 07:57:52.331634	Payment Successful	\N
976	164	2026-10-22 07:57:52.331634	Order Confirmed	\N
977	164	2026-10-22 07:57:52.331634	Shipment Pending	\N
978	164	2026-10-22 08:47:52.331634	Order Cancelled	Ordered by mistake
979	164	2026-10-22 08:47:52.331634	Payment Refunded	Ordered by mistake
980	164	2026-10-22 08:47:52.331634	Shipment Cancelled	Ordered by mistake
981	165	2026-09-23 01:47:52.331634	Order Pending	Order placed
982	165	2026-09-23 01:57:52.331634	Payment Successful	\N
983	165	2026-09-23 01:57:52.331634	Order Confirmed	\N
984	165	2026-09-23 01:57:52.331634	Shipment Pending	\N
985	165	2026-09-24 01:47:52.331634	Shipment Shipped	\N
986	165	2026-09-24 01:47:52.331634	Order Shipped	\N
987	165	2026-09-25 01:47:52.331634	Shipment In Transit	\N
988	166	2026-10-24 09:47:52.331634	Order Pending	Order placed
989	166	2026-10-24 09:57:52.331634	Payment Successful	\N
990	166	2026-10-24 09:57:52.331634	Order Confirmed	\N
991	166	2026-10-24 09:57:52.331634	Shipment Pending	\N
992	166	2026-10-25 09:47:52.331634	Shipment Shipped	\N
993	166	2026-10-25 09:47:52.331634	Order Shipped	\N
994	167	2026-10-06 07:47:52.331634	Order Pending	Order placed
995	167	2026-10-06 07:57:52.331634	Payment Successful	\N
996	167	2026-10-06 07:57:52.331634	Order Confirmed	\N
997	167	2026-10-06 07:57:52.331634	Shipment Pending	\N
998	167	2026-10-07 07:47:52.331634	Shipment Shipped	\N
999	167	2026-10-07 07:47:52.331634	Order Shipped	\N
1000	167	2026-10-08 07:47:52.331634	Shipment In Transit	\N
1001	168	2026-08-15 13:47:52.331634	Order Pending	Order placed
1002	168	2026-08-15 13:57:52.331634	Payment Successful	\N
1003	168	2026-08-15 13:57:52.331634	Order Confirmed	\N
1004	168	2026-08-15 13:57:52.331634	Shipment Pending	\N
1005	168	2026-08-16 13:47:52.331634	Shipment Shipped	\N
1006	168	2026-08-16 13:47:52.331634	Order Shipped	\N
1007	168	2026-08-17 13:47:52.331634	Shipment In Transit	\N
1008	169	2026-11-04 11:47:52.331634	Order Pending	Order placed
1009	169	2026-11-04 11:52:52.331634	Payment Failed	Insufficient funds
1010	169	2026-11-04 11:57:52.331634	Payment Successful	\N
1011	169	2026-11-04 11:57:52.331634	Order Confirmed	\N
1012	169	2026-11-04 11:57:52.331634	Shipment Pending	\N
1013	169	2026-11-05 11:47:52.331634	Shipment Shipped	\N
1014	169	2026-11-05 11:47:52.331634	Order Shipped	\N
1015	169	2026-11-06 11:47:52.331634	Shipment In Transit	\N
1016	169	2026-11-08 11:47:52.331634	Shipment Delivered	\N
1017	169	2026-11-08 11:47:52.331634	Order Delivered	\N
1018	170	2026-09-10 07:47:52.331634	Order Pending	Order placed
1019	170	2026-09-10 07:52:52.331634	Payment Failed	Insufficient funds
1020	170	2026-09-10 07:57:52.331634	Payment Successful	\N
1021	170	2026-09-10 07:57:52.331634	Order Confirmed	\N
1022	170	2026-09-10 07:57:52.331634	Shipment Pending	\N
1023	170	2026-09-11 07:47:52.331634	Shipment Shipped	\N
1024	170	2026-09-11 07:47:52.331634	Order Shipped	\N
1025	170	2026-09-12 07:47:52.331634	Shipment In Transit	\N
1026	170	2026-09-14 07:47:52.331634	Shipment Delivered	\N
1027	170	2026-09-14 07:47:52.331634	Order Delivered	\N
1028	171	2026-10-25 18:47:52.331634	Order Pending	Order placed
1029	171	2026-10-25 18:57:52.331634	Payment Successful	\N
1030	171	2026-10-25 18:57:52.331634	Order Confirmed	\N
1031	171	2026-10-25 18:57:52.331634	Shipment Pending	\N
1032	171	2026-10-26 18:47:52.331634	Shipment Shipped	\N
1033	171	2026-10-26 18:47:52.331634	Order Shipped	\N
1034	172	2026-09-20 18:47:52.331634	Order Pending	Order placed
1035	172	2026-09-20 18:57:52.331634	Payment Successful	\N
1036	172	2026-09-20 18:57:52.331634	Order Confirmed	\N
1037	172	2026-09-20 18:57:52.331634	Shipment Pending	\N
1038	172	2026-09-21 18:47:52.331634	Shipment Shipped	\N
1039	172	2026-09-21 18:47:52.331634	Order Shipped	\N
1040	172	2026-09-22 18:47:52.331634	Shipment In Transit	\N
1041	172	2026-09-24 18:47:52.331634	Shipment Delivered	\N
1042	172	2026-09-24 18:47:52.331634	Order Delivered	\N
1043	173	2026-08-17 06:47:52.331634	Order Pending	Order placed
1044	173	2026-08-17 07:47:52.331634	Order Cancelled	Cancelled by customer
1045	173	2026-08-17 07:47:52.331634	Payment Failed	Order cancelled before payment
1046	174	2026-11-01 15:47:52.331634	Order Pending	Order placed
1047	174	2026-11-01 15:52:52.331634	Payment Failed	Insufficient funds
1048	174	2026-11-01 15:57:52.331634	Payment Successful	\N
1049	174	2026-11-01 15:57:52.331634	Order Confirmed	\N
1050	174	2026-11-01 15:57:52.331634	Shipment Pending	\N
1051	174	2026-11-02 15:47:52.331634	Shipment Shipped	\N
1052	174	2026-11-02 15:47:52.331634	Order Shipped	\N
1053	174	2026-11-03 15:47:52.331634	Shipment In Transit	\N
1054	174	2026-11-05 15:47:52.331634	Shipment Delivered	\N
1055	174	2026-11-05 15:47:52.331634	Order Delivered	\N
1056	175	2026-08-24 09:47:52.331634	Order Pending	Order placed
1057	175	2026-08-24 09:57:52.331634	Payment Successful	\N
1058	175	2026-08-24 09:57:52.331634	Order Confirmed	\N
1059	175	2026-08-24 09:57:52.331634	Shipment Pending	\N
1060	175	2026-08-25 09:47:52.331634	Shipment Shipped	\N
1061	175	2026-08-25 09:47:52.331634	Order Shipped	\N
1062	175	2026-08-26 09:47:52.331634	Shipment In Transit	\N
1063	176	2026-08-29 07:47:52.331634	Order Pending	Order placed
1064	176	2026-08-29 07:57:52.331634	Payment Successful	\N
1065	176	2026-08-29 07:57:52.331634	Order Confirmed	\N
1066	176	2026-08-29 07:57:52.331634	Shipment Pending	\N
1067	177	2026-09-16 10:47:52.331634	Order Pending	Order placed
1068	177	2026-09-16 10:57:52.331634	Payment Successful	\N
1069	177	2026-09-16 10:57:52.331634	Order Confirmed	\N
1070	177	2026-09-16 10:57:52.331634	Shipment Pending	\N
1071	177	2026-09-17 10:47:52.331634	Shipment Shipped	\N
1072	177	2026-09-17 10:47:52.331634	Order Shipped	\N
1073	177	2026-09-18 10:47:52.331634	Shipment In Transit	\N
1074	177	2026-09-20 10:47:52.331634	Shipment Delivered	\N
1075	177	2026-09-20 10:47:52.331634	Order Delivered	\N
1076	178	2026-10-14 01:47:52.331634	Order Pending	Order placed
1077	178	2026-10-14 01:52:52.331634	Payment Failed	Insufficient funds
1078	178	2026-10-14 01:57:52.331634	Payment Successful	\N
1079	178	2026-10-14 01:57:52.331634	Order Confirmed	\N
1080	178	2026-10-14 01:57:52.331634	Shipment Pending	\N
1081	178	2026-10-15 01:47:52.331634	Shipment Shipped	\N
1082	178	2026-10-15 01:47:52.331634	Order Shipped	\N
1083	178	2026-10-16 01:47:52.331634	Shipment In Transit	\N
1084	179	2026-08-27 16:47:52.331634	Order Pending	Order placed
1085	179	2026-08-27 16:57:52.331634	Payment Successful	\N
1086	179	2026-08-27 16:57:52.331634	Order Confirmed	\N
1087	179	2026-08-27 16:57:52.331634	Shipment Pending	\N
1088	179	2026-08-28 16:47:52.331634	Shipment Shipped	\N
1089	179	2026-08-28 16:47:52.331634	Order Shipped	\N
1090	180	2026-10-05 23:47:52.331634	Order Pending	Order placed
1091	180	2026-10-05 23:57:52.331634	Payment Successful	\N
1092	180	2026-10-05 23:57:52.331634	Order Confirmed	\N
1093	180	2026-10-05 23:57:52.331634	Shipment Pending	\N
1094	180	2026-10-06 23:47:52.331634	Shipment Shipped	\N
1095	180	2026-10-06 23:47:52.331634	Order Shipped	\N
1096	181	2026-10-24 14:47:52.331634	Order Pending	Order placed
1097	181	2026-10-24 14:57:52.331634	Payment Successful	\N
1098	181	2026-10-24 14:57:52.331634	Order Confirmed	\N
1099	181	2026-10-24 14:57:52.331634	Shipment Pending	\N
1100	181	2026-10-25 14:47:52.331634	Shipment Shipped	\N
1101	181	2026-10-25 14:47:52.331634	Order Shipped	\N
1102	181	2026-10-26 14:47:52.331634	Shipment In Transit	\N
1103	181	2026-10-28 14:47:52.331634	Shipment Delivered	\N
1104	181	2026-10-28 14:47:52.331634	Order Delivered	\N
1105	182	2026-08-26 14:47:52.331634	Order Pending	Order placed
1106	182	2026-08-26 14:57:52.331634	Payment Successful	\N
1107	182	2026-08-26 14:57:52.331634	Order Confirmed	\N
1108	182	2026-08-26 14:57:52.331634	Shipment Pending	\N
1109	182	2026-08-27 14:47:52.331634	Shipment Shipped	\N
1110	182	2026-08-27 14:47:52.331634	Order Shipped	\N
1111	182	2026-08-28 14:47:52.331634	Shipment In Transit	\N
1112	182	2026-08-30 14:47:52.331634	Shipment Delivered	\N
1113	182	2026-08-30 14:47:52.331634	Order Delivered	\N
1114	183	2026-10-27 00:47:52.331634	Order Pending	Order placed
1115	183	2026-10-27 00:52:52.331634	Payment Failed	Insufficient funds
1116	183	2026-10-27 00:57:52.331634	Payment Successful	\N
1117	183	2026-10-27 00:57:52.331634	Order Confirmed	\N
1118	183	2026-10-27 00:57:52.331634	Shipment Pending	\N
1119	183	2026-10-28 00:47:52.331634	Shipment Shipped	\N
1120	183	2026-10-28 00:47:52.331634	Order Shipped	\N
1121	183	2026-10-29 00:47:52.331634	Shipment In Transit	\N
1122	183	2026-10-31 00:47:52.331634	Shipment Delivered	\N
1123	183	2026-10-31 00:47:52.331634	Order Delivered	\N
1124	184	2026-10-23 11:47:52.331634	Order Pending	Order placed
1125	184	2026-10-23 11:57:52.331634	Payment Successful	\N
1126	184	2026-10-23 11:57:52.331634	Order Confirmed	\N
1127	184	2026-10-23 11:57:52.331634	Shipment Pending	\N
1128	184	2026-10-24 11:47:52.331634	Shipment Shipped	\N
1129	184	2026-10-24 11:47:52.331634	Order Shipped	\N
1130	184	2026-10-25 11:47:52.331634	Shipment In Transit	\N
1131	184	2026-10-27 11:47:52.331634	Shipment Delivered	\N
1132	184	2026-10-27 11:47:52.331634	Order Delivered	\N
1133	185	2026-08-18 09:47:52.331634	Order Pending	Order placed
1134	185	2026-08-18 09:57:52.331634	Payment Successful	\N
1135	185	2026-08-18 09:57:52.331634	Order Confirmed	\N
1136	185	2026-08-18 09:57:52.331634	Shipment Pending	\N
1137	186	2026-09-28 03:47:52.331634	Order Pending	Order placed
1138	186	2026-09-28 04:47:52.331634	Order Cancelled	Cancelled by customer
1139	186	2026-09-28 04:47:52.331634	Payment Failed	Order cancelled before payment
1140	187	2026-11-10 03:20:52.331634	Order Pending	Order placed
1141	188	2026-10-09 20:47:52.331634	Order Pending	Order placed
1142	188	2026-10-09 20:57:52.331634	Payment Successful	\N
1143	188	2026-10-09 20:57:52.331634	Order Confirmed	\N
1144	188	2026-10-09 20:57:52.331634	Shipment Pending	\N
1145	188	2026-10-09 21:47:52.331634	Order Cancelled	Ordered by mistake
1146	188	2026-10-09 21:47:52.331634	Payment Refunded	Ordered by mistake
1147	188	2026-10-09 21:47:52.331634	Shipment Cancelled	Ordered by mistake
1148	189	2026-09-25 03:47:52.331634	Order Pending	Order placed
1149	189	2026-09-25 03:57:52.331634	Payment Successful	\N
1150	189	2026-09-25 03:57:52.331634	Order Confirmed	\N
1151	189	2026-09-25 03:57:52.331634	Shipment Pending	\N
1152	189	2026-09-26 03:47:52.331634	Shipment Shipped	\N
1153	189	2026-09-26 03:47:52.331634	Order Shipped	\N
1154	190	2026-10-06 20:47:52.331634	Order Pending	Order placed
1155	190	2026-10-06 20:57:52.331634	Payment Successful	\N
1156	190	2026-10-06 20:57:52.331634	Order Confirmed	\N
1157	190	2026-10-06 20:57:52.331634	Shipment Pending	\N
1158	191	2026-08-19 13:47:52.331634	Order Pending	Order placed
1159	191	2026-08-19 13:57:52.331634	Payment Successful	\N
1160	191	2026-08-19 13:57:52.331634	Order Confirmed	\N
1161	191	2026-08-19 13:57:52.331634	Shipment Pending	\N
1162	191	2026-08-20 13:47:52.331634	Shipment Shipped	\N
1163	191	2026-08-20 13:47:52.331634	Order Shipped	\N
1164	191	2026-08-21 13:47:52.331634	Shipment In Transit	\N
1165	191	2026-08-23 13:47:52.331634	Shipment Delivered	\N
1166	191	2026-08-23 13:47:52.331634	Order Delivered	\N
1167	192	2026-11-09 21:01:52.331634	Order Pending	Order placed
1168	192	2026-11-09 21:06:52.331634	Payment Failed	Card declined by bank
1169	193	2026-11-03 23:47:52.331634	Order Pending	Order placed
1170	193	2026-11-03 23:57:52.331634	Payment Successful	\N
1171	193	2026-11-03 23:57:52.331634	Order Confirmed	\N
1172	193	2026-11-03 23:57:52.331634	Shipment Pending	\N
1173	194	2026-10-17 08:47:52.331634	Order Pending	Order placed
1174	194	2026-10-17 08:52:52.331634	Payment Failed	Insufficient funds
1175	194	2026-10-17 08:57:52.331634	Payment Successful	\N
1176	194	2026-10-17 08:57:52.331634	Order Confirmed	\N
1177	194	2026-10-17 08:57:52.331634	Shipment Pending	\N
1178	194	2026-10-18 08:47:52.331634	Shipment Shipped	\N
1179	194	2026-10-18 08:47:52.331634	Order Shipped	\N
1180	194	2026-10-19 08:47:52.331634	Shipment In Transit	\N
1181	194	2026-10-21 08:47:52.331634	Shipment Delivered	\N
1182	194	2026-10-21 08:47:52.331634	Order Delivered	\N
1183	195	2026-11-04 01:47:52.331634	Order Pending	Order placed
1184	195	2026-11-04 01:57:52.331634	Payment Successful	\N
1185	195	2026-11-04 01:57:52.331634	Order Confirmed	\N
1186	195	2026-11-04 01:57:52.331634	Shipment Pending	\N
1187	195	2026-11-05 01:47:52.331634	Shipment Shipped	\N
1188	195	2026-11-05 01:47:52.331634	Order Shipped	\N
1189	195	2026-11-06 01:47:52.331634	Shipment In Transit	\N
1190	196	2026-08-15 09:47:52.331634	Order Pending	Order placed
1191	196	2026-08-15 09:57:52.331634	Payment Successful	\N
1192	196	2026-08-15 09:57:52.331634	Order Confirmed	\N
1193	196	2026-08-15 09:57:52.331634	Shipment Pending	\N
1194	196	2026-08-16 09:47:52.331634	Shipment Shipped	\N
1195	196	2026-08-16 09:47:52.331634	Order Shipped	\N
1196	196	2026-08-17 09:47:52.331634	Shipment In Transit	\N
1197	196	2026-08-19 09:47:52.331634	Shipment Delivered	\N
1198	196	2026-08-19 09:47:52.331634	Order Delivered	\N
1199	197	2026-09-14 16:47:52.331634	Order Pending	Order placed
1200	197	2026-09-14 16:57:52.331634	Payment Successful	\N
1201	197	2026-09-14 16:57:52.331634	Order Confirmed	\N
1202	197	2026-09-14 16:57:52.331634	Shipment Pending	\N
1203	198	2026-11-10 02:13:52.331634	Order Pending	Order placed
1204	199	2026-08-13 15:47:52.331634	Order Pending	Order placed
1205	199	2026-08-13 16:47:52.331634	Order Cancelled	Cancelled by customer
1206	199	2026-08-13 16:47:52.331634	Payment Failed	Order cancelled before payment
1207	200	2026-08-29 06:47:52.331634	Order Pending	Order placed
1208	200	2026-08-29 06:57:52.331634	Payment Successful	\N
1209	200	2026-08-29 06:57:52.331634	Order Confirmed	\N
1210	200	2026-08-29 06:57:52.331634	Shipment Pending	\N
1211	200	2026-08-30 06:47:52.331634	Shipment Shipped	\N
1212	200	2026-08-30 06:47:52.331634	Order Shipped	\N
1213	201	2026-08-17 20:47:52.331634	Order Pending	Order placed
1214	201	2026-08-17 20:57:52.331634	Payment Successful	\N
1215	201	2026-08-17 20:57:52.331634	Order Confirmed	\N
1216	201	2026-08-17 20:57:52.331634	Shipment Pending	\N
1217	201	2026-08-18 20:47:52.331634	Shipment Shipped	\N
1218	201	2026-08-18 20:47:52.331634	Order Shipped	\N
1219	202	2026-10-12 08:47:52.331634	Order Pending	Order placed
1220	202	2026-10-12 08:57:52.331634	Payment Successful	\N
1221	202	2026-10-12 08:57:52.331634	Order Confirmed	\N
1222	202	2026-10-12 08:57:52.331634	Shipment Pending	\N
1223	202	2026-10-13 08:47:52.331634	Shipment Shipped	\N
1224	202	2026-10-13 08:47:52.331634	Order Shipped	\N
1225	202	2026-10-14 08:47:52.331634	Shipment In Transit	\N
1226	202	2026-10-16 08:47:52.331634	Shipment Delivered	\N
1227	202	2026-10-16 08:47:52.331634	Order Delivered	\N
1228	203	2026-10-27 15:47:52.331634	Order Pending	Order placed
1229	203	2026-10-27 15:57:52.331634	Payment Successful	\N
1230	203	2026-10-27 15:57:52.331634	Order Confirmed	\N
1231	203	2026-10-27 15:57:52.331634	Shipment Pending	\N
1232	203	2026-10-28 15:47:52.331634	Shipment Shipped	\N
1233	203	2026-10-28 15:47:52.331634	Order Shipped	\N
1234	204	2026-08-31 05:47:52.331634	Order Pending	Order placed
1235	204	2026-08-31 05:52:52.331634	Payment Failed	Insufficient funds
1236	204	2026-08-31 05:57:52.331634	Payment Successful	\N
1237	204	2026-08-31 05:57:52.331634	Order Confirmed	\N
1238	204	2026-08-31 05:57:52.331634	Shipment Pending	\N
1239	204	2026-09-01 05:47:52.331634	Shipment Shipped	\N
1240	204	2026-09-01 05:47:52.331634	Order Shipped	\N
1241	205	2026-08-18 10:47:52.331634	Order Pending	Order placed
1242	205	2026-08-18 10:52:52.331634	Payment Failed	Insufficient funds
1243	205	2026-08-18 10:57:52.331634	Payment Successful	\N
1244	205	2026-08-18 10:57:52.331634	Order Confirmed	\N
1245	205	2026-08-18 10:57:52.331634	Shipment Pending	\N
1246	205	2026-08-19 10:47:52.331634	Shipment Shipped	\N
1247	205	2026-08-19 10:47:52.331634	Order Shipped	\N
1248	205	2026-08-20 10:47:52.331634	Shipment In Transit	\N
1249	205	2026-08-22 10:47:52.331634	Shipment Delivered	\N
1250	205	2026-08-22 10:47:52.331634	Order Delivered	\N
1251	206	2026-09-09 11:47:52.331634	Order Pending	Order placed
1252	206	2026-09-09 11:57:52.331634	Payment Successful	\N
1253	206	2026-09-09 11:57:52.331634	Order Confirmed	\N
1254	206	2026-09-09 11:57:52.331634	Shipment Pending	\N
1255	206	2026-09-10 11:47:52.331634	Shipment Shipped	\N
1256	206	2026-09-10 11:47:52.331634	Order Shipped	\N
1257	206	2026-09-11 11:47:52.331634	Shipment In Transit	\N
1258	206	2026-09-13 11:47:52.331634	Shipment Delivered	\N
1259	206	2026-09-13 11:47:52.331634	Order Delivered	\N
1260	207	2026-11-10 02:21:52.331634	Order Pending	Order placed
1261	208	2026-10-14 05:47:52.331634	Order Pending	Order placed
1262	208	2026-10-14 05:52:52.331634	Payment Failed	Insufficient funds
1263	208	2026-10-14 05:57:52.331634	Payment Successful	\N
1264	208	2026-10-14 05:57:52.331634	Order Confirmed	\N
1265	208	2026-10-14 05:57:52.331634	Shipment Pending	\N
1266	208	2026-10-15 05:47:52.331634	Shipment Shipped	\N
1267	208	2026-10-15 05:47:52.331634	Order Shipped	\N
1268	208	2026-10-16 05:47:52.331634	Shipment In Transit	\N
1269	209	2026-08-19 08:47:52.331634	Order Pending	Order placed
1270	209	2026-08-19 08:57:52.331634	Payment Successful	\N
1271	209	2026-08-19 08:57:52.331634	Order Confirmed	\N
1272	209	2026-08-19 08:57:52.331634	Shipment Pending	\N
1273	210	2026-11-04 17:47:52.331634	Order Pending	Order placed
1274	210	2026-11-04 18:47:52.331634	Order Cancelled	Cancelled by customer
1275	210	2026-11-04 18:47:52.331634	Payment Failed	Order cancelled before payment
1276	211	2026-09-02 16:47:52.331634	Order Pending	Order placed
1277	211	2026-09-02 16:57:52.331634	Payment Successful	\N
1279	211	2026-09-02 16:57:52.331634	Shipment Pending	\N
1280	211	2026-09-03 16:47:52.331634	Shipment Shipped	\N
1281	211	2026-09-03 16:47:52.331634	Order Shipped	\N
1282	211	2026-09-04 16:47:52.331634	Shipment In Transit	\N
1283	211	2026-09-06 16:47:52.331634	Shipment Delivered	\N
1284	211	2026-09-06 16:47:52.331634	Order Delivered	\N
1285	212	2026-11-10 01:25:52.331634	Order Pending	Order placed
1286	213	2026-11-01 22:47:52.331634	Order Pending	Order placed
1287	213	2026-11-01 23:47:52.331634	Order Cancelled	Cancelled by customer
1288	213	2026-11-01 23:47:52.331634	Payment Failed	Order cancelled before payment
1289	214	2026-09-13 19:47:52.331634	Order Pending	Order placed
1290	214	2026-09-13 19:57:52.331634	Payment Successful	\N
1291	214	2026-09-13 19:57:52.331634	Order Confirmed	\N
1292	214	2026-09-13 19:57:52.331634	Shipment Pending	\N
1293	214	2026-09-13 20:47:52.331634	Order Cancelled	Ordered by mistake
1294	214	2026-09-13 20:47:52.331634	Payment Refunded	Ordered by mistake
1295	214	2026-09-13 20:47:52.331634	Shipment Cancelled	Ordered by mistake
1296	215	2026-10-01 03:47:52.331634	Order Pending	Order placed
1297	215	2026-10-01 03:57:52.331634	Payment Successful	\N
1298	215	2026-10-01 03:57:52.331634	Order Confirmed	\N
1299	215	2026-10-01 03:57:52.331634	Shipment Pending	\N
1300	215	2026-10-02 03:47:52.331634	Shipment Shipped	\N
1301	215	2026-10-02 03:47:52.331634	Order Shipped	\N
1302	215	2026-10-03 03:47:52.331634	Shipment In Transit	\N
1303	215	2026-10-05 03:47:52.331634	Shipment Delivered	\N
1304	215	2026-10-05 03:47:52.331634	Order Delivered	\N
1305	216	2026-10-19 22:47:52.331634	Order Pending	Order placed
1306	216	2026-10-19 22:52:52.331634	Payment Failed	Insufficient funds
1307	216	2026-10-19 22:57:52.331634	Payment Successful	\N
1308	216	2026-10-19 22:57:52.331634	Order Confirmed	\N
1309	216	2026-10-19 22:57:52.331634	Shipment Pending	\N
1310	216	2026-10-20 22:47:52.331634	Shipment Shipped	\N
1311	216	2026-10-20 22:47:52.331634	Order Shipped	\N
1312	217	2026-08-21 16:47:52.331634	Order Pending	Order placed
1313	217	2026-08-21 16:57:52.331634	Payment Successful	\N
1314	217	2026-08-21 16:57:52.331634	Order Confirmed	\N
1315	217	2026-08-21 16:57:52.331634	Shipment Pending	\N
1316	217	2026-08-21 17:47:52.331634	Order Cancelled	Ordered by mistake
1317	217	2026-08-21 17:47:52.331634	Payment Refunded	Ordered by mistake
1318	217	2026-08-21 17:47:52.331634	Shipment Cancelled	Ordered by mistake
1319	218	2026-10-15 04:47:52.331634	Order Pending	Order placed
1320	218	2026-10-15 04:57:52.331634	Payment Successful	\N
1321	218	2026-10-15 04:57:52.331634	Order Confirmed	\N
1322	218	2026-10-15 04:57:52.331634	Shipment Pending	\N
1323	218	2026-10-16 04:47:52.331634	Shipment Shipped	\N
1324	218	2026-10-16 04:47:52.331634	Order Shipped	\N
1325	219	2026-08-23 21:47:52.331634	Order Pending	Order placed
1326	219	2026-08-23 21:57:52.331634	Payment Successful	\N
1327	219	2026-08-23 21:57:52.331634	Order Confirmed	\N
1328	219	2026-08-23 21:57:52.331634	Shipment Pending	\N
1329	219	2026-08-24 21:47:52.331634	Shipment Shipped	\N
1330	219	2026-08-24 21:47:52.331634	Order Shipped	\N
1331	220	2026-08-28 13:47:52.331634	Order Pending	Order placed
1332	220	2026-08-28 13:57:52.331634	Payment Successful	\N
1333	220	2026-08-28 13:57:52.331634	Order Confirmed	\N
1334	220	2026-08-28 13:57:52.331634	Shipment Pending	\N
1335	220	2026-08-29 13:47:52.331634	Shipment Shipped	\N
1336	220	2026-08-29 13:47:52.331634	Order Shipped	\N
1337	220	2026-08-30 13:47:52.331634	Shipment In Transit	\N
1338	220	2026-09-01 13:47:52.331634	Shipment Delivered	\N
1339	220	2026-09-01 13:47:52.331634	Order Delivered	\N
1340	221	2026-10-20 08:47:52.331634	Order Pending	Order placed
1341	221	2026-10-20 08:57:52.331634	Payment Successful	\N
1342	221	2026-10-20 08:57:52.331634	Order Confirmed	\N
1343	221	2026-10-20 08:57:52.331634	Shipment Pending	\N
1344	221	2026-10-21 08:47:52.331634	Shipment Shipped	\N
1345	221	2026-10-21 08:47:52.331634	Order Shipped	\N
1346	221	2026-10-22 08:47:52.331634	Shipment In Transit	\N
1347	221	2026-10-24 08:47:52.331634	Shipment Delivered	\N
1348	221	2026-10-24 08:47:52.331634	Order Delivered	\N
1349	222	2026-09-21 10:47:52.331634	Order Pending	Order placed
1350	222	2026-09-21 10:57:52.331634	Payment Successful	\N
1351	222	2026-09-21 10:57:52.331634	Order Confirmed	\N
1352	222	2026-09-21 10:57:52.331634	Shipment Pending	\N
1353	222	2026-09-22 10:47:52.331634	Shipment Shipped	\N
1354	222	2026-09-22 10:47:52.331634	Order Shipped	\N
1355	223	2026-09-06 20:47:52.331634	Order Pending	Order placed
1356	223	2026-09-06 20:57:52.331634	Payment Successful	\N
1357	223	2026-09-06 20:57:52.331634	Order Confirmed	\N
1358	223	2026-09-06 20:57:52.331634	Shipment Pending	\N
1359	223	2026-09-07 20:47:52.331634	Shipment Shipped	\N
1360	223	2026-09-07 20:47:52.331634	Order Shipped	\N
1361	224	2026-09-16 12:47:52.331634	Order Pending	Order placed
1362	224	2026-09-16 12:57:52.331634	Payment Successful	\N
1363	224	2026-09-16 12:57:52.331634	Order Confirmed	\N
1364	224	2026-09-16 12:57:52.331634	Shipment Pending	\N
1365	225	2026-08-29 00:47:52.331634	Order Pending	Order placed
1366	225	2026-08-29 01:47:52.331634	Order Cancelled	Cancelled by customer
1367	225	2026-08-29 01:47:52.331634	Payment Failed	Order cancelled before payment
1368	226	2026-09-10 15:47:52.331634	Order Pending	Order placed
1369	226	2026-09-10 15:57:52.331634	Payment Successful	\N
1370	226	2026-09-10 15:57:52.331634	Order Confirmed	\N
1371	226	2026-09-10 15:57:52.331634	Shipment Pending	\N
1372	226	2026-09-11 15:47:52.331634	Shipment Shipped	\N
1373	226	2026-09-11 15:47:52.331634	Order Shipped	\N
1374	226	2026-09-12 15:47:52.331634	Shipment In Transit	\N
1375	226	2026-09-14 15:47:52.331634	Shipment Delivered	\N
1376	226	2026-09-14 15:47:52.331634	Order Delivered	\N
1377	227	2026-09-30 17:47:52.331634	Order Pending	Order placed
1378	227	2026-09-30 17:57:52.331634	Payment Successful	\N
1379	227	2026-09-30 17:57:52.331634	Order Confirmed	\N
1380	227	2026-09-30 17:57:52.331634	Shipment Pending	\N
1381	227	2026-09-30 18:47:52.331634	Order Cancelled	Ordered by mistake
1382	227	2026-09-30 18:47:52.331634	Payment Refunded	Ordered by mistake
1383	227	2026-09-30 18:47:52.331634	Shipment Cancelled	Ordered by mistake
1384	228	2026-09-05 02:47:52.331634	Order Pending	Order placed
1385	228	2026-09-05 02:52:52.331634	Payment Failed	Insufficient funds
1386	228	2026-09-05 02:57:52.331634	Payment Successful	\N
1387	228	2026-09-05 02:57:52.331634	Order Confirmed	\N
1388	228	2026-09-05 02:57:52.331634	Shipment Pending	\N
1389	228	2026-09-06 02:47:52.331634	Shipment Shipped	\N
1390	228	2026-09-06 02:47:52.331634	Order Shipped	\N
1391	229	2026-09-18 18:47:52.331634	Order Pending	Order placed
1392	229	2026-09-18 18:52:52.331634	Payment Failed	Insufficient funds
1393	229	2026-09-18 18:57:52.331634	Payment Successful	\N
1394	229	2026-09-18 18:57:52.331634	Order Confirmed	\N
1395	229	2026-09-18 18:57:52.331634	Shipment Pending	\N
1396	229	2026-09-19 18:47:52.331634	Shipment Shipped	\N
1397	229	2026-09-19 18:47:52.331634	Order Shipped	\N
1398	229	2026-09-20 18:47:52.331634	Shipment In Transit	\N
1399	229	2026-09-22 18:47:52.331634	Shipment Delivered	\N
1400	229	2026-09-22 18:47:52.331634	Order Delivered	\N
1401	230	2026-09-07 06:47:52.331634	Order Pending	Order placed
1402	230	2026-09-07 06:57:52.331634	Payment Successful	\N
1403	230	2026-09-07 06:57:52.331634	Order Confirmed	\N
1404	230	2026-09-07 06:57:52.331634	Shipment Pending	\N
1405	230	2026-09-08 06:47:52.331634	Shipment Shipped	\N
1406	230	2026-09-08 06:47:52.331634	Order Shipped	\N
1407	230	2026-09-09 06:47:52.331634	Shipment In Transit	\N
1408	230	2026-09-11 06:47:52.331634	Shipment Delivered	\N
1409	230	2026-09-11 06:47:52.331634	Order Delivered	\N
1410	231	2026-08-23 06:47:52.331634	Order Pending	Order placed
1411	231	2026-08-23 06:57:52.331634	Payment Successful	\N
1412	231	2026-08-23 06:57:52.331634	Order Confirmed	\N
1413	231	2026-08-23 06:57:52.331634	Shipment Pending	\N
1414	232	2026-10-11 00:47:52.331634	Order Pending	Order placed
1415	232	2026-10-11 00:57:52.331634	Payment Successful	\N
1416	232	2026-10-11 00:57:52.331634	Order Confirmed	\N
1417	232	2026-10-11 00:57:52.331634	Shipment Pending	\N
1418	232	2026-10-12 00:47:52.331634	Shipment Shipped	\N
1419	232	2026-10-12 00:47:52.331634	Order Shipped	\N
1420	232	2026-10-13 00:47:52.331634	Shipment In Transit	\N
1421	233	2026-11-04 19:47:52.331634	Order Pending	Order placed
1422	233	2026-11-04 19:57:52.331634	Payment Successful	\N
1423	233	2026-11-04 19:57:52.331634	Order Confirmed	\N
1424	233	2026-11-04 19:57:52.331634	Shipment Pending	\N
1425	233	2026-11-05 19:47:52.331634	Shipment Shipped	\N
1426	233	2026-11-05 19:47:52.331634	Order Shipped	\N
1427	233	2026-11-06 19:47:52.331634	Shipment In Transit	\N
1428	234	2026-09-15 03:47:52.331634	Order Pending	Order placed
1429	234	2026-09-15 03:57:52.331634	Payment Successful	\N
1430	234	2026-09-15 03:57:52.331634	Order Confirmed	\N
1431	234	2026-09-15 03:57:52.331634	Shipment Pending	\N
1432	234	2026-09-16 03:47:52.331634	Shipment Shipped	\N
1433	234	2026-09-16 03:47:52.331634	Order Shipped	\N
1434	235	2026-10-15 11:47:52.331634	Order Pending	Order placed
1435	235	2026-10-15 11:57:52.331634	Payment Successful	\N
1436	235	2026-10-15 11:57:52.331634	Order Confirmed	\N
1437	235	2026-10-15 11:57:52.331634	Shipment Pending	\N
1438	236	2026-11-05 06:47:52.331634	Order Pending	Order placed
1439	236	2026-11-05 06:57:52.331634	Payment Successful	\N
1440	236	2026-11-05 06:57:52.331634	Order Confirmed	\N
1441	236	2026-11-05 06:57:52.331634	Shipment Pending	\N
1442	236	2026-11-06 06:47:52.331634	Shipment Shipped	\N
1443	236	2026-11-06 06:47:52.331634	Order Shipped	\N
1444	236	2026-11-07 06:47:52.331634	Shipment In Transit	\N
1445	237	2026-10-21 07:47:52.331634	Order Pending	Order placed
1446	237	2026-10-21 07:57:52.331634	Payment Successful	\N
1447	237	2026-10-21 07:57:52.331634	Order Confirmed	\N
1448	237	2026-10-21 07:57:52.331634	Shipment Pending	\N
1449	237	2026-10-22 07:47:52.331634	Shipment Shipped	\N
1450	237	2026-10-22 07:47:52.331634	Order Shipped	\N
1451	237	2026-10-23 07:47:52.331634	Shipment In Transit	\N
1452	238	2026-10-27 15:47:52.331634	Order Pending	Order placed
1453	238	2026-10-27 15:57:52.331634	Payment Successful	\N
1454	238	2026-10-27 15:57:52.331634	Order Confirmed	\N
1455	238	2026-10-27 15:57:52.331634	Shipment Pending	\N
1456	239	2026-10-13 21:47:52.331634	Order Pending	Order placed
1457	239	2026-10-13 21:52:52.331634	Payment Failed	Insufficient funds
1458	239	2026-10-13 21:57:52.331634	Payment Successful	\N
1459	239	2026-10-13 21:57:52.331634	Order Confirmed	\N
1460	239	2026-10-13 21:57:52.331634	Shipment Pending	\N
1461	239	2026-10-14 21:47:52.331634	Shipment Shipped	\N
1462	239	2026-10-14 21:47:52.331634	Order Shipped	\N
1463	239	2026-10-15 21:47:52.331634	Shipment In Transit	\N
1464	239	2026-10-17 21:47:52.331634	Shipment Delivered	\N
1465	239	2026-10-17 21:47:52.331634	Order Delivered	\N
1466	240	2026-10-27 18:47:52.331634	Order Pending	Order placed
1467	240	2026-10-27 18:57:52.331634	Payment Successful	\N
1468	240	2026-10-27 18:57:52.331634	Order Confirmed	\N
1469	240	2026-10-27 18:57:52.331634	Shipment Pending	\N
1470	240	2026-10-28 18:47:52.331634	Shipment Shipped	\N
1471	240	2026-10-28 18:47:52.331634	Order Shipped	\N
1472	240	2026-10-29 18:47:52.331634	Shipment In Transit	\N
1473	240	2026-10-31 18:47:52.331634	Shipment Delivered	\N
1474	240	2026-10-31 18:47:52.331634	Order Delivered	\N
1475	241	2026-11-10 03:55:52.331634	Order Pending	Order placed
1476	241	2026-11-10 04:00:52.331634	Payment Failed	Card declined by bank
1477	242	2026-09-01 04:47:52.331634	Order Pending	Order placed
1478	242	2026-09-01 04:52:52.331634	Payment Failed	Insufficient funds
1479	242	2026-09-01 04:57:52.331634	Payment Successful	\N
1480	242	2026-09-01 04:57:52.331634	Order Confirmed	\N
1481	242	2026-09-01 04:57:52.331634	Shipment Pending	\N
1482	242	2026-09-02 04:47:52.331634	Shipment Shipped	\N
1483	242	2026-09-02 04:47:52.331634	Order Shipped	\N
1484	242	2026-09-03 04:47:52.331634	Shipment In Transit	\N
1485	242	2026-09-05 04:47:52.331634	Shipment Delivered	\N
1486	242	2026-09-05 04:47:52.331634	Order Delivered	\N
1487	243	2026-10-20 11:47:52.331634	Order Pending	Order placed
1488	243	2026-10-20 11:57:52.331634	Payment Successful	\N
1489	243	2026-10-20 11:57:52.331634	Order Confirmed	\N
1490	243	2026-10-20 11:57:52.331634	Shipment Pending	\N
1491	244	2026-08-21 13:47:52.331634	Order Pending	Order placed
1492	244	2026-08-21 13:57:52.331634	Payment Successful	\N
1493	244	2026-08-21 13:57:52.331634	Order Confirmed	\N
1494	244	2026-08-21 13:57:52.331634	Shipment Pending	\N
1495	244	2026-08-22 13:47:52.331634	Shipment Shipped	\N
1496	244	2026-08-22 13:47:52.331634	Order Shipped	\N
1497	245	2026-09-04 23:47:52.331634	Order Pending	Order placed
1498	245	2026-09-04 23:57:52.331634	Payment Successful	\N
1499	245	2026-09-04 23:57:52.331634	Order Confirmed	\N
1500	245	2026-09-04 23:57:52.331634	Shipment Pending	\N
1501	246	2026-10-05 14:47:52.331634	Order Pending	Order placed
1502	246	2026-10-05 14:57:52.331634	Payment Successful	\N
1503	246	2026-10-05 14:57:52.331634	Order Confirmed	\N
1504	246	2026-10-05 14:57:52.331634	Shipment Pending	\N
1505	246	2026-10-06 14:47:52.331634	Shipment Shipped	\N
1506	246	2026-10-06 14:47:52.331634	Order Shipped	\N
1507	246	2026-10-07 14:47:52.331634	Shipment In Transit	\N
1508	247	2026-10-12 05:47:52.331634	Order Pending	Order placed
1509	247	2026-10-12 05:57:52.331634	Payment Successful	\N
1510	247	2026-10-12 05:57:52.331634	Order Confirmed	\N
1511	247	2026-10-12 05:57:52.331634	Shipment Pending	\N
1512	247	2026-10-13 05:47:52.331634	Shipment Shipped	\N
1513	247	2026-10-13 05:47:52.331634	Order Shipped	\N
1514	247	2026-10-14 05:47:52.331634	Shipment In Transit	\N
1515	247	2026-10-16 05:47:52.331634	Shipment Delivered	\N
1516	247	2026-10-16 05:47:52.331634	Order Delivered	\N
1517	248	2026-10-13 14:47:52.331634	Order Pending	Order placed
1518	248	2026-10-13 14:57:52.331634	Payment Successful	\N
1519	248	2026-10-13 14:57:52.331634	Order Confirmed	\N
1520	248	2026-10-13 14:57:52.331634	Shipment Pending	\N
1521	248	2026-10-14 14:47:52.331634	Shipment Shipped	\N
1522	248	2026-10-14 14:47:52.331634	Order Shipped	\N
1523	248	2026-10-15 14:47:52.331634	Shipment In Transit	\N
1524	248	2026-10-17 14:47:52.331634	Shipment Delivered	\N
1525	248	2026-10-17 14:47:52.331634	Order Delivered	\N
1526	249	2026-09-21 20:47:52.331634	Order Pending	Order placed
1527	249	2026-09-21 20:57:52.331634	Payment Successful	\N
1528	249	2026-09-21 20:57:52.331634	Order Confirmed	\N
1529	249	2026-09-21 20:57:52.331634	Shipment Pending	\N
1530	249	2026-09-22 20:47:52.331634	Shipment Shipped	\N
1531	249	2026-09-22 20:47:52.331634	Order Shipped	\N
1532	250	2026-10-14 22:47:52.331634	Order Pending	Order placed
1533	250	2026-10-14 22:57:52.331634	Payment Successful	\N
1534	250	2026-10-14 22:57:52.331634	Order Confirmed	\N
1535	250	2026-10-14 22:57:52.331634	Shipment Pending	\N
1536	250	2026-10-15 22:47:52.331634	Shipment Shipped	\N
1537	250	2026-10-15 22:47:52.331634	Order Shipped	\N
1538	250	2026-10-16 22:47:52.331634	Shipment In Transit	\N
1539	251	2026-09-19 18:47:52.331634	Order Pending	Order placed
1540	251	2026-09-19 18:57:52.331634	Payment Successful	\N
1541	251	2026-09-19 18:57:52.331634	Order Confirmed	\N
1542	251	2026-09-19 18:57:52.331634	Shipment Pending	\N
1543	252	2026-10-03 03:47:52.331634	Order Pending	Order placed
1544	252	2026-10-03 03:57:52.331634	Payment Successful	\N
1545	252	2026-10-03 03:57:52.331634	Order Confirmed	\N
1546	252	2026-10-03 03:57:52.331634	Shipment Pending	\N
1547	252	2026-10-04 03:47:52.331634	Shipment Shipped	\N
1548	252	2026-10-04 03:47:52.331634	Order Shipped	\N
1549	252	2026-10-05 03:47:52.331634	Shipment In Transit	\N
1550	252	2026-10-07 03:47:52.331634	Shipment Delivered	\N
1551	252	2026-10-07 03:47:52.331634	Order Delivered	\N
1552	253	2026-08-29 22:47:52.331634	Order Pending	Order placed
1553	253	2026-08-29 22:52:52.331634	Payment Failed	Insufficient funds
1554	253	2026-08-29 22:57:52.331634	Payment Successful	\N
1555	253	2026-08-29 22:57:52.331634	Order Confirmed	\N
1556	253	2026-08-29 22:57:52.331634	Shipment Pending	\N
1557	253	2026-08-30 22:47:52.331634	Shipment Shipped	\N
1558	253	2026-08-30 22:47:52.331634	Order Shipped	\N
1559	253	2026-08-31 22:47:52.331634	Shipment In Transit	\N
1560	253	2026-09-02 22:47:52.331634	Shipment Delivered	\N
1561	253	2026-09-02 22:47:52.331634	Order Delivered	\N
1562	254	2026-08-18 05:47:52.331634	Order Pending	Order placed
1563	254	2026-08-18 05:57:52.331634	Payment Successful	\N
1564	254	2026-08-18 05:57:52.331634	Order Confirmed	\N
1565	254	2026-08-18 05:57:52.331634	Shipment Pending	\N
1566	254	2026-08-19 05:47:52.331634	Shipment Shipped	\N
1567	254	2026-08-19 05:47:52.331634	Order Shipped	\N
1568	255	2026-09-25 05:47:52.331634	Order Pending	Order placed
1569	255	2026-09-25 05:52:52.331634	Payment Failed	Insufficient funds
1570	255	2026-09-25 05:57:52.331634	Payment Successful	\N
1571	255	2026-09-25 05:57:52.331634	Order Confirmed	\N
1572	255	2026-09-25 05:57:52.331634	Shipment Pending	\N
1573	255	2026-09-26 05:47:52.331634	Shipment Shipped	\N
1574	255	2026-09-26 05:47:52.331634	Order Shipped	\N
1575	255	2026-09-27 05:47:52.331634	Shipment In Transit	\N
1576	256	2026-10-25 09:47:52.331634	Order Pending	Order placed
1577	256	2026-10-25 10:47:52.331634	Order Cancelled	Cancelled by customer
1578	256	2026-10-25 10:47:52.331634	Payment Failed	Order cancelled before payment
1579	257	2026-09-12 21:47:52.331634	Order Pending	Order placed
1580	257	2026-09-12 22:47:52.331634	Order Cancelled	Cancelled by customer
1581	257	2026-09-12 22:47:52.331634	Payment Failed	Order cancelled before payment
1582	258	2026-09-18 03:47:52.331634	Order Pending	Order placed
1583	258	2026-09-18 03:57:52.331634	Payment Successful	\N
1584	258	2026-09-18 03:57:52.331634	Order Confirmed	\N
1585	258	2026-09-18 03:57:52.331634	Shipment Pending	\N
1586	258	2026-09-19 03:47:52.331634	Shipment Shipped	\N
1587	258	2026-09-19 03:47:52.331634	Order Shipped	\N
1588	258	2026-09-20 03:47:52.331634	Shipment In Transit	\N
1589	259	2026-09-02 00:47:52.331634	Order Pending	Order placed
1590	259	2026-09-02 01:47:52.331634	Order Cancelled	Cancelled by customer
1591	259	2026-09-02 01:47:52.331634	Payment Failed	Order cancelled before payment
1592	260	2026-08-13 04:47:52.331634	Order Pending	Order placed
1593	260	2026-08-13 05:47:52.331634	Order Cancelled	Cancelled by customer
1594	260	2026-08-13 05:47:52.331634	Payment Failed	Order cancelled before payment
1595	261	2026-10-08 19:47:52.331634	Order Pending	Order placed
1596	261	2026-10-08 19:57:52.331634	Payment Successful	\N
1597	261	2026-10-08 19:57:52.331634	Order Confirmed	\N
1598	261	2026-10-08 19:57:52.331634	Shipment Pending	\N
1599	262	2026-10-03 15:47:52.331634	Order Pending	Order placed
1600	262	2026-10-03 15:52:52.331634	Payment Failed	Insufficient funds
1601	262	2026-10-03 15:57:52.331634	Payment Successful	\N
1602	262	2026-10-03 15:57:52.331634	Order Confirmed	\N
1710	277	2026-08-12 10:57:52.331634	Order Confirmed	\N
1603	262	2026-10-03 15:57:52.331634	Shipment Pending	\N
1604	263	2026-10-30 16:47:52.331634	Order Pending	Order placed
1605	263	2026-10-30 16:52:52.331634	Payment Failed	Insufficient funds
1606	263	2026-10-30 16:57:52.331634	Payment Successful	\N
1607	263	2026-10-30 16:57:52.331634	Order Confirmed	\N
1608	263	2026-10-30 16:57:52.331634	Shipment Pending	\N
1609	263	2026-10-31 16:47:52.331634	Shipment Shipped	\N
1610	263	2026-10-31 16:47:52.331634	Order Shipped	\N
1611	263	2026-11-01 16:47:52.331634	Shipment In Transit	\N
1612	264	2026-08-13 01:47:52.331634	Order Pending	Order placed
1613	264	2026-08-13 01:57:52.331634	Payment Successful	\N
1614	264	2026-08-13 01:57:52.331634	Order Confirmed	\N
1615	264	2026-08-13 01:57:52.331634	Shipment Pending	\N
1616	264	2026-08-14 01:47:52.331634	Shipment Shipped	\N
1617	264	2026-08-14 01:47:52.331634	Order Shipped	\N
1618	265	2026-10-04 23:47:52.331634	Order Pending	Order placed
1619	265	2026-10-04 23:52:52.331634	Payment Failed	Insufficient funds
1620	265	2026-10-04 23:57:52.331634	Payment Successful	\N
1621	265	2026-10-04 23:57:52.331634	Order Confirmed	\N
1622	265	2026-10-04 23:57:52.331634	Shipment Pending	\N
1623	265	2026-10-05 23:47:52.331634	Shipment Shipped	\N
1624	265	2026-10-05 23:47:52.331634	Order Shipped	\N
1625	266	2026-09-18 21:47:52.331634	Order Pending	Order placed
1626	266	2026-09-18 21:52:52.331634	Payment Failed	Insufficient funds
1627	266	2026-09-18 21:57:52.331634	Payment Successful	\N
1628	266	2026-09-18 21:57:52.331634	Order Confirmed	\N
1629	266	2026-09-18 21:57:52.331634	Shipment Pending	\N
1630	266	2026-09-18 22:47:52.331634	Order Cancelled	Ordered by mistake
1631	266	2026-09-18 22:47:52.331634	Payment Refunded	Ordered by mistake
1632	266	2026-09-18 22:47:52.331634	Shipment Cancelled	Ordered by mistake
1633	267	2026-10-13 21:47:52.331634	Order Pending	Order placed
1634	267	2026-10-13 21:57:52.331634	Payment Successful	\N
1635	267	2026-10-13 21:57:52.331634	Order Confirmed	\N
1636	267	2026-10-13 21:57:52.331634	Shipment Pending	\N
1637	267	2026-10-14 21:47:52.331634	Shipment Shipped	\N
1638	267	2026-10-14 21:47:52.331634	Order Shipped	\N
1639	268	2026-09-23 13:47:52.331634	Order Pending	Order placed
1640	268	2026-09-23 13:52:52.331634	Payment Failed	Insufficient funds
1641	268	2026-09-23 13:57:52.331634	Payment Successful	\N
1642	268	2026-09-23 13:57:52.331634	Order Confirmed	\N
1643	268	2026-09-23 13:57:52.331634	Shipment Pending	\N
1644	268	2026-09-24 13:47:52.331634	Shipment Shipped	\N
1645	268	2026-09-24 13:47:52.331634	Order Shipped	\N
1646	268	2026-09-25 13:47:52.331634	Shipment In Transit	\N
1647	268	2026-09-27 13:47:52.331634	Shipment Delivered	\N
1648	268	2026-09-27 13:47:52.331634	Order Delivered	\N
1649	269	2026-10-30 22:47:52.331634	Order Pending	Order placed
1650	269	2026-10-30 22:57:52.331634	Payment Successful	\N
1651	269	2026-10-30 22:57:52.331634	Order Confirmed	\N
1652	269	2026-10-30 22:57:52.331634	Shipment Pending	\N
1653	269	2026-10-31 22:47:52.331634	Shipment Shipped	\N
1654	269	2026-10-31 22:47:52.331634	Order Shipped	\N
1655	270	2026-10-08 18:47:52.331634	Order Pending	Order placed
1656	270	2026-10-08 18:57:52.331634	Payment Successful	\N
1657	270	2026-10-08 18:57:52.331634	Order Confirmed	\N
1658	270	2026-10-08 18:57:52.331634	Shipment Pending	\N
1659	270	2026-10-09 18:47:52.331634	Shipment Shipped	\N
1660	270	2026-10-09 18:47:52.331634	Order Shipped	\N
1661	271	2026-09-16 03:47:52.331634	Order Pending	Order placed
1662	271	2026-09-16 03:57:52.331634	Payment Successful	\N
1663	271	2026-09-16 03:57:52.331634	Order Confirmed	\N
1664	271	2026-09-16 03:57:52.331634	Shipment Pending	\N
1665	271	2026-09-17 03:47:52.331634	Shipment Shipped	\N
1666	271	2026-09-17 03:47:52.331634	Order Shipped	\N
1667	271	2026-09-18 03:47:52.331634	Shipment In Transit	\N
1668	271	2026-09-20 03:47:52.331634	Shipment Delivered	\N
1669	271	2026-09-20 03:47:52.331634	Order Delivered	\N
1670	272	2026-09-20 08:47:52.331634	Order Pending	Order placed
1671	272	2026-09-20 08:57:52.331634	Payment Successful	\N
1672	272	2026-09-20 08:57:52.331634	Order Confirmed	\N
1673	272	2026-09-20 08:57:52.331634	Shipment Pending	\N
1674	272	2026-09-21 08:47:52.331634	Shipment Shipped	\N
1675	272	2026-09-21 08:47:52.331634	Order Shipped	\N
1676	273	2026-10-18 12:47:52.331634	Order Pending	Order placed
1677	273	2026-10-18 12:57:52.331634	Payment Successful	\N
1678	273	2026-10-18 12:57:52.331634	Order Confirmed	\N
1679	273	2026-10-18 12:57:52.331634	Shipment Pending	\N
1680	273	2026-10-19 12:47:52.331634	Shipment Shipped	\N
1681	273	2026-10-19 12:47:52.331634	Order Shipped	\N
1682	273	2026-10-20 12:47:52.331634	Shipment In Transit	\N
1683	273	2026-10-22 12:47:52.331634	Shipment Delivered	\N
1684	273	2026-10-22 12:47:52.331634	Order Delivered	\N
1685	274	2026-09-21 11:47:52.331634	Order Pending	Order placed
1686	274	2026-09-21 11:52:52.331634	Payment Failed	Insufficient funds
1687	274	2026-09-21 11:57:52.331634	Payment Successful	\N
1688	274	2026-09-21 11:57:52.331634	Order Confirmed	\N
1689	274	2026-09-21 11:57:52.331634	Shipment Pending	\N
1690	274	2026-09-22 11:47:52.331634	Shipment Shipped	\N
1691	274	2026-09-22 11:47:52.331634	Order Shipped	\N
1692	275	2026-08-15 18:47:52.331634	Order Pending	Order placed
1693	275	2026-08-15 18:57:52.331634	Payment Successful	\N
1694	275	2026-08-15 18:57:52.331634	Order Confirmed	\N
1695	275	2026-08-15 18:57:52.331634	Shipment Pending	\N
1696	275	2026-08-16 18:47:52.331634	Shipment Shipped	\N
1697	275	2026-08-16 18:47:52.331634	Order Shipped	\N
1698	275	2026-08-17 18:47:52.331634	Shipment In Transit	\N
1699	275	2026-08-19 18:47:52.331634	Shipment Delivered	\N
1700	275	2026-08-19 18:47:52.331634	Order Delivered	\N
1701	276	2026-09-27 05:47:52.331634	Order Pending	Order placed
1702	276	2026-09-27 05:52:52.331634	Payment Failed	Insufficient funds
1703	276	2026-09-27 05:57:52.331634	Payment Successful	\N
1704	276	2026-09-27 05:57:52.331634	Order Confirmed	\N
1705	276	2026-09-27 05:57:52.331634	Shipment Pending	\N
1706	276	2026-09-28 05:47:52.331634	Shipment Shipped	\N
1707	276	2026-09-28 05:47:52.331634	Order Shipped	\N
1708	277	2026-08-12 10:47:52.331634	Order Pending	Order placed
1709	277	2026-08-12 10:57:52.331634	Payment Successful	\N
1711	277	2026-08-12 10:57:52.331634	Shipment Pending	\N
1712	277	2026-08-13 10:47:52.331634	Shipment Shipped	\N
1713	277	2026-08-13 10:47:52.331634	Order Shipped	\N
1714	277	2026-08-14 10:47:52.331634	Shipment In Transit	\N
1715	277	2026-08-16 10:47:52.331634	Shipment Delivered	\N
1716	277	2026-08-16 10:47:52.331634	Order Delivered	\N
1717	278	2026-08-28 17:47:52.331634	Order Pending	Order placed
1718	278	2026-08-28 17:57:52.331634	Payment Successful	\N
1719	278	2026-08-28 17:57:52.331634	Order Confirmed	\N
1720	278	2026-08-28 17:57:52.331634	Shipment Pending	\N
1721	278	2026-08-29 17:47:52.331634	Shipment Shipped	\N
1722	278	2026-08-29 17:47:52.331634	Order Shipped	\N
1723	278	2026-08-30 17:47:52.331634	Shipment In Transit	\N
1724	279	2026-09-17 18:47:52.331634	Order Pending	Order placed
1725	279	2026-09-17 18:52:52.331634	Payment Failed	Insufficient funds
1726	279	2026-09-17 18:57:52.331634	Payment Successful	\N
1727	279	2026-09-17 18:57:52.331634	Order Confirmed	\N
1728	279	2026-09-17 18:57:52.331634	Shipment Pending	\N
1729	279	2026-09-18 18:47:52.331634	Shipment Shipped	\N
1730	279	2026-09-18 18:47:52.331634	Order Shipped	\N
1731	280	2026-09-01 03:47:52.331634	Order Pending	Order placed
1732	280	2026-09-01 03:57:52.331634	Payment Successful	\N
1733	280	2026-09-01 03:57:52.331634	Order Confirmed	\N
1734	280	2026-09-01 03:57:52.331634	Shipment Pending	\N
1735	280	2026-09-02 03:47:52.331634	Shipment Shipped	\N
1736	280	2026-09-02 03:47:52.331634	Order Shipped	\N
1737	280	2026-09-03 03:47:52.331634	Shipment In Transit	\N
1738	280	2026-09-05 03:47:52.331634	Shipment Delivered	\N
1739	280	2026-09-05 03:47:52.331634	Order Delivered	\N
1740	281	2026-10-06 02:47:52.331634	Order Pending	Order placed
1741	281	2026-10-06 02:57:52.331634	Payment Successful	\N
1742	281	2026-10-06 02:57:52.331634	Order Confirmed	\N
1743	281	2026-10-06 02:57:52.331634	Shipment Pending	\N
1744	281	2026-10-07 02:47:52.331634	Shipment Shipped	\N
1745	281	2026-10-07 02:47:52.331634	Order Shipped	\N
1746	281	2026-10-08 02:47:52.331634	Shipment In Transit	\N
1747	282	2026-09-08 05:47:52.331634	Order Pending	Order placed
1748	282	2026-09-08 06:47:52.331634	Order Cancelled	Cancelled by customer
1749	282	2026-09-08 06:47:52.331634	Payment Failed	Order cancelled before payment
1750	283	2026-09-29 09:47:52.331634	Order Pending	Order placed
1751	283	2026-09-29 10:47:52.331634	Order Cancelled	Cancelled by customer
1752	283	2026-09-29 10:47:52.331634	Payment Failed	Order cancelled before payment
1753	284	2026-09-10 22:47:52.331634	Order Pending	Order placed
1754	284	2026-09-10 22:57:52.331634	Payment Successful	\N
1755	284	2026-09-10 22:57:52.331634	Order Confirmed	\N
1756	284	2026-09-10 22:57:52.331634	Shipment Pending	\N
1757	284	2026-09-11 22:47:52.331634	Shipment Shipped	\N
1758	284	2026-09-11 22:47:52.331634	Order Shipped	\N
1759	284	2026-09-12 22:47:52.331634	Shipment In Transit	\N
1760	285	2026-10-19 20:47:52.331634	Order Pending	Order placed
1761	285	2026-10-19 20:57:52.331634	Payment Successful	\N
1762	285	2026-10-19 20:57:52.331634	Order Confirmed	\N
1763	285	2026-10-19 20:57:52.331634	Shipment Pending	\N
1764	285	2026-10-20 20:47:52.331634	Shipment Shipped	\N
1765	285	2026-10-20 20:47:52.331634	Order Shipped	\N
1766	285	2026-10-21 20:47:52.331634	Shipment In Transit	\N
1767	285	2026-10-23 20:47:52.331634	Shipment Delivered	\N
1768	285	2026-10-23 20:47:52.331634	Order Delivered	\N
1769	286	2026-08-30 23:47:52.331634	Order Pending	Order placed
1770	286	2026-08-30 23:57:52.331634	Payment Successful	\N
1771	286	2026-08-30 23:57:52.331634	Order Confirmed	\N
1772	286	2026-08-30 23:57:52.331634	Shipment Pending	\N
1773	287	2026-11-10 03:30:52.331634	Order Pending	Order placed
1774	287	2026-11-10 03:35:52.331634	Payment Failed	Card declined by bank
1775	288	2026-09-13 16:47:52.331634	Order Pending	Order placed
1776	288	2026-09-13 16:57:52.331634	Payment Successful	\N
1777	288	2026-09-13 16:57:52.331634	Order Confirmed	\N
1778	288	2026-09-13 16:57:52.331634	Shipment Pending	\N
1779	288	2026-09-14 16:47:52.331634	Shipment Shipped	\N
1780	288	2026-09-14 16:47:52.331634	Order Shipped	\N
1781	288	2026-09-15 16:47:52.331634	Shipment In Transit	\N
1782	289	2026-10-31 05:47:52.331634	Order Pending	Order placed
1783	289	2026-10-31 05:57:52.331634	Payment Successful	\N
1784	289	2026-10-31 05:57:52.331634	Order Confirmed	\N
1785	289	2026-10-31 05:57:52.331634	Shipment Pending	\N
1786	289	2026-11-01 05:47:52.331634	Shipment Shipped	\N
1787	289	2026-11-01 05:47:52.331634	Order Shipped	\N
1788	289	2026-11-02 05:47:52.331634	Shipment In Transit	\N
1789	289	2026-11-04 05:47:52.331634	Shipment Delivered	\N
1790	289	2026-11-04 05:47:52.331634	Order Delivered	\N
1791	290	2026-10-21 17:47:52.331634	Order Pending	Order placed
1792	290	2026-10-21 17:52:52.331634	Payment Failed	Insufficient funds
1793	290	2026-10-21 17:57:52.331634	Payment Successful	\N
1794	290	2026-10-21 17:57:52.331634	Order Confirmed	\N
1795	290	2026-10-21 17:57:52.331634	Shipment Pending	\N
1796	290	2026-10-22 17:47:52.331634	Shipment Shipped	\N
1797	290	2026-10-22 17:47:52.331634	Order Shipped	\N
1798	290	2026-10-23 17:47:52.331634	Shipment In Transit	\N
1799	291	2026-10-04 22:47:52.331634	Order Pending	Order placed
1800	291	2026-10-04 22:57:52.331634	Payment Successful	\N
1801	291	2026-10-04 22:57:52.331634	Order Confirmed	\N
1802	291	2026-10-04 22:57:52.331634	Shipment Pending	\N
1803	291	2026-10-05 22:47:52.331634	Shipment Shipped	\N
1804	291	2026-10-05 22:47:52.331634	Order Shipped	\N
1805	291	2026-10-06 22:47:52.331634	Shipment In Transit	\N
1806	292	2026-09-05 22:47:52.331634	Order Pending	Order placed
1807	292	2026-09-05 22:57:52.331634	Payment Successful	\N
1808	292	2026-09-05 22:57:52.331634	Order Confirmed	\N
1809	292	2026-09-05 22:57:52.331634	Shipment Pending	\N
1810	292	2026-09-06 22:47:52.331634	Shipment Shipped	\N
1811	292	2026-09-06 22:47:52.331634	Order Shipped	\N
1812	292	2026-09-07 22:47:52.331634	Shipment In Transit	\N
1813	292	2026-09-09 22:47:52.331634	Shipment Delivered	\N
1814	292	2026-09-09 22:47:52.331634	Order Delivered	\N
1815	293	2026-11-09 22:46:52.331634	Order Pending	Order placed
1816	294	2026-10-18 12:47:52.331634	Order Pending	Order placed
1817	294	2026-10-18 12:52:52.331634	Payment Failed	Insufficient funds
1818	294	2026-10-18 12:57:52.331634	Payment Successful	\N
1819	294	2026-10-18 12:57:52.331634	Order Confirmed	\N
1820	294	2026-10-18 12:57:52.331634	Shipment Pending	\N
1821	294	2026-10-19 12:47:52.331634	Shipment Shipped	\N
1822	294	2026-10-19 12:47:52.331634	Order Shipped	\N
1823	294	2026-10-20 12:47:52.331634	Shipment In Transit	\N
1824	294	2026-10-22 12:47:52.331634	Shipment Delivered	\N
1825	294	2026-10-22 12:47:52.331634	Order Delivered	\N
1826	295	2026-08-12 21:47:52.331634	Order Pending	Order placed
1827	295	2026-08-12 21:52:52.331634	Payment Failed	Insufficient funds
1828	295	2026-08-12 21:57:52.331634	Payment Successful	\N
1829	295	2026-08-12 21:57:52.331634	Order Confirmed	\N
1830	295	2026-08-12 21:57:52.331634	Shipment Pending	\N
1831	295	2026-08-13 21:47:52.331634	Shipment Shipped	\N
1832	295	2026-08-13 21:47:52.331634	Order Shipped	\N
1833	295	2026-08-14 21:47:52.331634	Shipment In Transit	\N
1834	295	2026-08-16 21:47:52.331634	Shipment Delivered	\N
1835	295	2026-08-16 21:47:52.331634	Order Delivered	\N
1836	296	2026-10-14 07:47:52.331634	Order Pending	Order placed
1837	296	2026-10-14 08:47:52.331634	Order Cancelled	Cancelled by customer
1838	296	2026-10-14 08:47:52.331634	Payment Failed	Order cancelled before payment
1839	297	2026-10-30 12:47:52.331634	Order Pending	Order placed
1840	297	2026-10-30 12:57:52.331634	Payment Successful	\N
1841	297	2026-10-30 12:57:52.331634	Order Confirmed	\N
1842	297	2026-10-30 12:57:52.331634	Shipment Pending	\N
1843	297	2026-10-31 12:47:52.331634	Shipment Shipped	\N
1844	297	2026-10-31 12:47:52.331634	Order Shipped	\N
1845	298	2026-09-19 14:47:52.331634	Order Pending	Order placed
1846	298	2026-09-19 14:57:52.331634	Payment Successful	\N
1847	298	2026-09-19 14:57:52.331634	Order Confirmed	\N
1848	298	2026-09-19 14:57:52.331634	Shipment Pending	\N
1849	298	2026-09-20 14:47:52.331634	Shipment Shipped	\N
1850	298	2026-09-20 14:47:52.331634	Order Shipped	\N
1851	299	2026-10-10 08:47:52.331634	Order Pending	Order placed
1852	299	2026-10-10 08:57:52.331634	Payment Successful	\N
1853	299	2026-10-10 08:57:52.331634	Order Confirmed	\N
1854	299	2026-10-10 08:57:52.331634	Shipment Pending	\N
1855	300	2026-10-16 10:47:52.331634	Order Pending	Order placed
1856	300	2026-10-16 10:52:52.331634	Payment Failed	Insufficient funds
1857	300	2026-10-16 10:57:52.331634	Payment Successful	\N
1858	300	2026-10-16 10:57:52.331634	Order Confirmed	\N
1859	300	2026-10-16 10:57:52.331634	Shipment Pending	\N
1860	300	2026-10-17 10:47:52.331634	Shipment Shipped	\N
1861	300	2026-10-17 10:47:52.331634	Order Shipped	\N
1862	300	2026-10-18 10:47:52.331634	Shipment In Transit	\N
1863	301	2026-08-25 20:47:52.331634	Order Pending	Order placed
1864	301	2026-08-25 20:52:52.331634	Payment Failed	Insufficient funds
1865	301	2026-08-25 20:57:52.331634	Payment Successful	\N
1866	301	2026-08-25 20:57:52.331634	Order Confirmed	\N
1867	301	2026-08-25 20:57:52.331634	Shipment Pending	\N
1868	301	2026-08-26 20:47:52.331634	Shipment Shipped	\N
1869	301	2026-08-26 20:47:52.331634	Order Shipped	\N
1870	301	2026-08-27 20:47:52.331634	Shipment In Transit	\N
1871	302	2026-09-02 16:47:52.331634	Order Pending	Order placed
1872	302	2026-09-02 16:57:52.331634	Payment Successful	\N
1873	302	2026-09-02 16:57:52.331634	Order Confirmed	\N
1874	302	2026-09-02 16:57:52.331634	Shipment Pending	\N
1875	303	2026-11-10 01:29:52.331634	Order Pending	Order placed
1876	304	2026-08-27 06:47:52.331634	Order Pending	Order placed
1877	304	2026-08-27 06:57:52.331634	Payment Successful	\N
1878	304	2026-08-27 06:57:52.331634	Order Confirmed	\N
1879	304	2026-08-27 06:57:52.331634	Shipment Pending	\N
1880	304	2026-08-28 06:47:52.331634	Shipment Shipped	\N
1881	304	2026-08-28 06:47:52.331634	Order Shipped	\N
1882	305	2026-08-22 23:47:52.331634	Order Pending	Order placed
1883	305	2026-08-22 23:52:52.331634	Payment Failed	Insufficient funds
1884	305	2026-08-22 23:57:52.331634	Payment Successful	\N
1885	305	2026-08-22 23:57:52.331634	Order Confirmed	\N
1886	305	2026-08-22 23:57:52.331634	Shipment Pending	\N
1887	306	2026-09-15 03:47:52.331634	Order Pending	Order placed
1888	306	2026-09-15 03:57:52.331634	Payment Successful	\N
1889	306	2026-09-15 03:57:52.331634	Order Confirmed	\N
1890	306	2026-09-15 03:57:52.331634	Shipment Pending	\N
1891	306	2026-09-16 03:47:52.331634	Shipment Shipped	\N
1892	306	2026-09-16 03:47:52.331634	Order Shipped	\N
1893	306	2026-09-17 03:47:52.331634	Shipment In Transit	\N
1894	306	2026-09-19 03:47:52.331634	Shipment Delivered	\N
1895	306	2026-09-19 03:47:52.331634	Order Delivered	\N
1896	307	2026-09-23 06:47:52.331634	Order Pending	Order placed
1897	307	2026-09-23 06:57:52.331634	Payment Successful	\N
1898	307	2026-09-23 06:57:52.331634	Order Confirmed	\N
1899	307	2026-09-23 06:57:52.331634	Shipment Pending	\N
1900	308	2026-09-03 22:47:52.331634	Order Pending	Order placed
1901	308	2026-09-03 22:52:52.331634	Payment Failed	Insufficient funds
1902	308	2026-09-03 22:57:52.331634	Payment Successful	\N
1903	308	2026-09-03 22:57:52.331634	Order Confirmed	\N
1904	308	2026-09-03 22:57:52.331634	Shipment Pending	\N
1905	309	2026-08-31 04:47:52.331634	Order Pending	Order placed
1906	309	2026-08-31 04:57:52.331634	Payment Successful	\N
1907	309	2026-08-31 04:57:52.331634	Order Confirmed	\N
1908	309	2026-08-31 04:57:52.331634	Shipment Pending	\N
1909	309	2026-09-01 04:47:52.331634	Shipment Shipped	\N
1910	309	2026-09-01 04:47:52.331634	Order Shipped	\N
1911	309	2026-09-02 04:47:52.331634	Shipment In Transit	\N
1912	310	2026-10-04 22:47:52.331634	Order Pending	Order placed
1913	310	2026-10-04 22:52:52.331634	Payment Failed	Insufficient funds
1914	310	2026-10-04 22:57:52.331634	Payment Successful	\N
1915	310	2026-10-04 22:57:52.331634	Order Confirmed	\N
1916	310	2026-10-04 22:57:52.331634	Shipment Pending	\N
1917	310	2026-10-05 22:47:52.331634	Shipment Shipped	\N
1918	310	2026-10-05 22:47:52.331634	Order Shipped	\N
1919	310	2026-10-06 22:47:52.331634	Shipment In Transit	\N
1920	310	2026-10-08 22:47:52.331634	Shipment Delivered	\N
1921	310	2026-10-08 22:47:52.331634	Order Delivered	\N
1922	311	2026-10-07 09:47:52.331634	Order Pending	Order placed
1923	311	2026-10-07 09:57:52.331634	Payment Successful	\N
1924	311	2026-10-07 09:57:52.331634	Order Confirmed	\N
1925	311	2026-10-07 09:57:52.331634	Shipment Pending	\N
1926	311	2026-10-08 09:47:52.331634	Shipment Shipped	\N
1927	311	2026-10-08 09:47:52.331634	Order Shipped	\N
1928	311	2026-10-09 09:47:52.331634	Shipment In Transit	\N
1929	312	2026-09-18 22:47:52.331634	Order Pending	Order placed
1930	312	2026-09-18 22:57:52.331634	Payment Successful	\N
1931	312	2026-09-18 22:57:52.331634	Order Confirmed	\N
1932	312	2026-09-18 22:57:52.331634	Shipment Pending	\N
1933	312	2026-09-19 22:47:52.331634	Shipment Shipped	\N
1934	312	2026-09-19 22:47:52.331634	Order Shipped	\N
1935	312	2026-09-20 22:47:52.331634	Shipment In Transit	\N
1936	312	2026-09-22 22:47:52.331634	Shipment Delivered	\N
1937	312	2026-09-22 22:47:52.331634	Order Delivered	\N
\.


--
-- Data for Name: order_fn_backup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_fn_backup (backup_id, backed_up_at, function_signature, definition) FROM stdin;
1	2026-11-10 06:47:31.879101	place_order(bigint,bigint,jsonb,character varying)	CREATE OR REPLACE FUNCTION public.place_order(p_customer_id bigint, p_address_id bigint, p_items jsonb, p_method character varying)\n RETURNS bigint\n LANGUAGE plpgsql\nAS $function$\nDECLARE\n  v_order_id bigint;\n  v_item     record;\n  v_price    numeric;\n  v_stock    integer;\nBEGIN\n  IF NOT EXISTS (SELECT 1 FROM address\n                 WHERE address_id = p_address_id AND customer_id = p_customer_id) THEN\n    RAISE EXCEPTION 'ADDRESS_INVALID';\n  END IF;\n  IF p_items IS NULL OR jsonb_typeof(p_items) <> 'array' OR jsonb_array_length(p_items) = 0 THEN\n    RAISE EXCEPTION 'EMPTY_ORDER';\n  END IF;\n\n  INSERT INTO orders (customer_id, address_id)\n  VALUES (p_customer_id, p_address_id)\n  RETURNING order_id INTO v_order_id;\n\n  -- lock products in id order so two concurrent orders cannot deadlock\n  FOR v_item IN\n    SELECT (e->>'product_id')::bigint AS product_id, (e->>'quantity')::int AS quantity\n    FROM jsonb_array_elements(p_items) AS e\n    ORDER BY 1\n  LOOP\n    IF v_item.quantity IS NULL OR v_item.quantity <= 0 THEN\n      RAISE EXCEPTION 'QTY_INVALID';\n    END IF;\n\n    SELECT price, quantity_in_stock INTO v_price, v_stock\n    FROM product WHERE product_id = v_item.product_id FOR UPDATE;\n    IF NOT FOUND THEN\n      RAISE EXCEPTION 'PRODUCT_NOT_FOUND:%', v_item.product_id;\n    END IF;\n    IF v_stock < v_item.quantity THEN\n      RAISE EXCEPTION 'INSUFFICIENT_STOCK:%', v_item.product_id;\n    END IF;\n\n    -- subtotal is a GENERATED column, so it is not inserted\n    INSERT INTO order_item (order_id, product_id, quantity, unit_price)\n    VALUES (v_order_id, v_item.product_id, v_item.quantity, v_price);\n\n    UPDATE product SET quantity_in_stock = quantity_in_stock - v_item.quantity\n    WHERE product_id = v_item.product_id;\n  END LOOP;\n\n  UPDATE orders\n  SET total_amount = (SELECT COALESCE(SUM(subtotal), 0) FROM order_item WHERE order_id = v_order_id)\n  WHERE order_id = v_order_id;\n\n  INSERT INTO payment (order_id, payment_method) VALUES (v_order_id, p_method);  -- status defaults to Pending\n  RETURN v_order_id;\nEND $function$\n
2	2026-11-10 06:47:31.879101	pay_order(bigint)	CREATE OR REPLACE FUNCTION public.pay_order(p_order_id bigint)\n RETURNS void\n LANGUAGE plpgsql\nAS $function$\nDECLARE v_status text;\nBEGIN\n  SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;\n  IF NOT FOUND THEN RAISE EXCEPTION 'ORDER_NOT_FOUND'; END IF;\n  IF v_status <> 'Pending' THEN RAISE EXCEPTION 'NOT_PAYABLE:%', v_status; END IF;\n\n  UPDATE payment SET payment_status = 'Successful', payment_date = now()\n  WHERE order_id = p_order_id AND payment_status = 'Pending';\n  IF NOT FOUND THEN RAISE EXCEPTION 'NOT_PAYABLE:no pending payment'; END IF;\n\n  UPDATE orders SET order_status = 'Confirmed' WHERE order_id = p_order_id;\n  INSERT INTO shipment (order_id) VALUES (p_order_id);                           -- status defaults to Pending\nEND $function$\n
3	2026-11-10 06:47:31.879101	recalculate_order_total()	CREATE OR REPLACE FUNCTION public.recalculate_order_total()\n RETURNS trigger\n LANGUAGE plpgsql\nAS $function$\nDECLARE\n    v_old_order_id BIGINT;\n    v_new_order_id BIGINT;\n    v_order_id BIGINT;\nBEGIN\n    -- Identify the affected order(s)\n    IF TG_OP = 'INSERT' THEN\n        v_new_order_id := NEW.order_id;\n        v_old_order_id := NULL;\n\n    ELSIF TG_OP = 'DELETE' THEN\n        v_old_order_id := OLD.order_id;\n        v_new_order_id := NULL;\n\n    ELSE\n        v_old_order_id := OLD.order_id;\n        v_new_order_id := NEW.order_id;\n    END IF;\n\n    -- Lock affected orders in a consistent order\n    -- to reduce concurrency-related inconsistencies.\n    FOR v_order_id IN\n        SELECT o.order_id\n        FROM public.orders AS o\n        WHERE o.order_id = v_old_order_id\n           OR o.order_id = v_new_order_id\n        ORDER BY o.order_id\n        FOR UPDATE\n    LOOP\n        NULL;\n    END LOOP;\n\n    -- Recalculate the total for the old and/or new order\n    UPDATE public.orders AS o\n    SET total_amount = COALESCE(\n        (\n            SELECT SUM(oi.subtotal)\n            FROM public.order_item AS oi\n            WHERE oi.order_id = o.order_id\n        ),\n        0\n    )\n    WHERE o.order_id = v_old_order_id\n       OR o.order_id = v_new_order_id;\n\n    -- Return the appropriate row\n    IF TG_OP = 'DELETE' THEN\n        RETURN OLD;\n    ELSE\n        RETURN NEW;\n    END IF;\nEND;\n$function$\n
4	2026-11-10 06:47:31.879101	cancel_order(bigint)	CREATE OR REPLACE FUNCTION public.cancel_order(p_order_id bigint)\n RETURNS void\n LANGUAGE plpgsql\nAS $function$\nDECLARE v_status text;\nBEGIN\n  SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;\n  IF NOT FOUND THEN RAISE EXCEPTION 'ORDER_NOT_FOUND'; END IF;\n  IF v_status NOT IN ('Pending', 'Confirmed') THEN\n    RAISE EXCEPTION 'NOT_CANCELLABLE:%', v_status;\n  END IF;\n\n  UPDATE product p SET quantity_in_stock = p.quantity_in_stock + oi.quantity\n  FROM order_item oi\n  WHERE oi.order_id = p_order_id AND oi.product_id = p.product_id;\n\n  UPDATE orders  SET order_status = 'Cancelled' WHERE order_id = p_order_id;\n  UPDATE payment SET payment_status = 'Refunded'\n  WHERE order_id = p_order_id AND payment_status = 'Successful';\n  DELETE FROM shipment WHERE order_id = p_order_id AND shipment_status = 'Pending';  -- unshipped placeholder\nEND $function$\n
\.


--
-- Data for Name: seller; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seller (seller_id, name, email, phone, registration_date) FROM stdin;
1	Banyan Tree Living	seller0001@example.in	8000000000	2025-11-06
2	OfficeCraft Solutions	seller0002@example.in	8000000001	2024-07-09
3	Kosha Fashion House	seller0003@example.in	8000000002	2024-11-29
4	BharatMart	seller0004@example.in	8000000003	2026-08-17
5	The Indian Basket	seller0005@example.in	8000000004	2024-03-26
6	Shree Ganesh Enterprises	seller0006@example.in	8000000005	2025-05-15
7	Vijayawada Value Mart	seller0007@example.in	8000000006	2025-07-29
8	Imphal Heritage Store	seller0008@example.in	8000000007	2025-02-25
9	Kota Study Store	seller0009@example.in	8000000008	2025-02-14
10	Ganga Enterprises	seller0010@example.in	8000000009	2025-01-27
11	PureHarvest Foods	seller0011@example.in	8000000010	2026-07-31
12	Karigar Collective	seller0012@example.in	8000000011	2024-03-09
13	Siliguri Travel Goods	seller0013@example.in	8000000012	2026-03-04
14	Raipur Retail Hub	seller0014@example.in	8000000013	2024-04-28
15	Cuttack Stationery World	seller0015@example.in	8000000014	2024-03-05
16	Kerala Kitchen	seller0016@example.in	8000000015	2024-06-16
17	Sari Street	seller0017@example.in	8000000016	2024-06-28
18	Neem & Co.	seller0018@example.in	8000000017	2024-02-14
19	Pondicherry Lifestyle Studio	seller0019@example.in	8000000018	2024-05-26
20	Virasat India	seller0020@example.in	8000000019	2026-03-27
21	DigitalDukaan	seller0021@example.in	8000000020	2024-10-31
22	Noida Smart Living	seller0022@example.in	8000000021	2023-10-27
23	QuickCart Enterprises	seller0023@example.in	8000000022	2026-09-05
24	Omkar Business Solutions	seller0024@example.in	8000000023	2026-08-25
25	SportSphere India	seller0025@example.in	8000000024	2024-01-12
26	The Wardrobe Co	seller0026@example.in	8000000025	2026-03-27
27	GlowNest Beauty	seller0027@example.in	8000000026	2025-09-14
28	Agra Craft Bazaar	seller0028@example.in	8000000027	2025-05-11
29	StyleStreet Retail	seller0029@example.in	8000000028	2024-04-03
30	Solapur Textile Mart	seller0030@example.in	8000000029	2026-08-01
31	Kaveri Traders	seller0031@example.in	8000000030	2024-08-26
32	Himalayan Travel Gear	seller0032@example.in	8000000031	2026-05-21
33	Thanjavur Art House	seller0033@example.in	8000000032	2025-07-21
34	Jaipur Jewel Box	seller0034@example.in	8000000033	2026-06-15
35	Pragati Retail Works	seller0035@example.in	8000000034	2024-11-20
36	NCR Tech Traders	seller0036@example.in	8000000035	2024-05-11
37	Marigold Collections	seller0037@example.in	8000000036	2025-06-18
38	SchoolBag Central	seller0038@example.in	8000000037	2026-01-14
39	FreshField Grocers	seller0039@example.in	8000000038	2026-02-17
40	SmartBuy Junction	seller0040@example.in	8000000039	2025-09-21
41	Coastal Kitchenware	seller0041@example.in	8000000040	2024-04-04
42	MangoTree Books	seller0042@example.in	8000000041	2025-03-30
43	FitNation India	seller0043@example.in	8000000042	2025-11-06
44	Gadget Grove	seller0044@example.in	8000000043	2024-01-01
45	Rajputana Handicrafts	seller0045@example.in	8000000044	2024-06-05
46	Pioneer Office Solutions	seller0046@example.in	8000000045	2024-11-23
47	Rajdhani Traders	seller0047@example.in	8000000046	2024-04-14
48	Mangalore Coastal Goods	seller0048@example.in	8000000047	2025-01-11
49	Krishna Retail	seller0049@example.in	8000000048	2026-08-10
50	Walkway Footwear	seller0050@example.in	8000000049	2024-11-14
51	Riwaayat Collections	seller0051@example.in	8000000050	2025-05-30
52	Farm2Shelf Market	seller0052@example.in	8000000051	2024-03-27
53	Shree Balaji Traders	seller0053@example.in	8000000052	2026-05-21
54	Pixel & Parts	seller0054@example.in	8000000053	2025-07-18
55	Ethnic Edit	seller0055@example.in	8000000054	2024-04-26
56	Royal Living	seller0056@example.in	8000000055	2024-05-03
57	TechTrove India	seller0057@example.in	8000000056	2026-08-07
58	Aavartan Retail	seller0058@example.in	8000000057	2024-01-12
59	Heritage Lane	seller0059@example.in	8000000058	2025-06-17
60	RoadReady Auto	seller0060@example.in	8000000059	2026-08-04
61	Narmada Marketplace	seller0061@example.in	8000000060	2024-06-03
62	Sattva Naturals	seller0062@example.in	8000000061	2024-07-23
63	Kochi Travel Store	seller0063@example.in	8000000062	2024-03-30
64	Udaipur Decor Studio	seller0064@example.in	8000000063	2025-01-30
65	Saraswati Book House	seller0065@example.in	8000000064	2026-02-19
66	Chennai Computer Depot	seller0066@example.in	8000000065	2024-06-23
67	Indigo Loom	seller0067@example.in	8000000066	2026-02-17
68	Bharat Bazaar	seller0068@example.in	8000000067	2025-02-10
69	Vishwakarma Tools & Supply	seller0069@example.in	8000000068	2026-07-13
70	AyurVeda Essentials	seller0070@example.in	8000000069	2024-11-02
71	Srinagar Artisan Collective	seller0071@example.in	8000000070	2024-12-09
72	Crafted in Bharat	seller0072@example.in	8000000071	2024-09-14
73	Kala Kendra	seller0073@example.in	8000000072	2025-09-17
74	Kaveri Lifestyle	seller0074@example.in	8000000073	2026-07-01
75	DailyBasket Traders	seller0075@example.in	8000000074	2026-02-05
76	Computer Corner	seller0076@example.in	8000000075	2026-09-17
77	Panchvati Stores	seller0077@example.in	8000000076	2025-01-26
78	Bengaluru Gadget Works	seller0078@example.in	8000000077	2023-12-06
79	Jalandhar Sports Depot	seller0079@example.in	8000000078	2026-02-16
80	Maa Durga Enterprises	seller0080@example.in	8000000079	2026-01-27
81	Guwahati Outdoor Store	seller0081@example.in	8000000080	2026-01-28
82	Astitva Creations	seller0082@example.in	8000000081	2026-08-01
83	Dastkari Bazaar	seller0083@example.in	8000000082	2025-01-07
84	The Living Room Store	seller0084@example.in	8000000083	2025-06-23
85	Lakshmi Trading House	seller0085@example.in	8000000084	2026-08-16
86	Madurai Textile Works	seller0086@example.in	8000000085	2023-11-23
87	Ananta Marketplace	seller0087@example.in	8000000086	2025-09-25
88	Footprint Footwear	seller0088@example.in	8000000087	2025-10-18
89	Ghaziabad Retail Works	seller0089@example.in	8000000088	2024-11-12
90	Kitchen Canvas	seller0090@example.in	8000000089	2024-12-26
91	Eastern Valley Traders	seller0091@example.in	8000000090	2023-12-29
92	Salem Appliance House	seller0092@example.in	8000000091	2025-08-07
93	PlayZone Bazaar	seller0093@example.in	8000000092	2026-08-03
94	Golden Peacock Crafts	seller0094@example.in	8000000093	2025-04-18
95	Mitti & More	seller0095@example.in	8000000094	2025-01-06
96	Patna Stationery Hub	seller0096@example.in	8000000095	2024-11-11
97	Meerut Sports Supply	seller0097@example.in	8000000096	2023-11-18
98	Cookware Collective	seller0098@example.in	8000000097	2026-08-22
99	Hubballi Hardware House	seller0099@example.in	8000000098	2024-08-26
100	Malabar Essentials	seller0100@example.in	8000000099	2026-08-14
101	Nilgiri Naturals	seller0101@example.in	8000000100	2026-09-10
102	KitchenKart India	seller0102@example.in	8000000101	2024-09-21
103	HomeHive India	seller0103@example.in	8000000102	2023-11-25
104	Vadodara Home Essentials	seller0104@example.in	8000000103	2026-02-19
105	Veda Wellness	seller0105@example.in	8000000104	2024-12-24
106	PetPal Supplies	seller0106@example.in	8000000105	2025-06-28
107	Chai & Craft	seller0107@example.in	8000000106	2023-11-28
108	Banjara Crafts	seller0108@example.in	8000000107	2026-05-29
109	Indus Mercantile	seller0109@example.in	8000000108	2024-08-12
110	OfficeOrbit	seller0110@example.in	8000000109	2026-09-05
111	Tulsi Home Store	seller0111@example.in	8000000110	2026-05-04
112	Visakhapatnam Electronics	seller0112@example.in	8000000111	2025-02-04
113	Saffron Homeware	seller0113@example.in	8000000112	2025-12-12
114	Lucknow Lifestyle	seller0114@example.in	8000000113	2024-01-21
115	Spice Garden India	seller0115@example.in	8000000114	2025-07-26
116	AutoGear India	seller0116@example.in	8000000115	2025-05-12
117	Aangan Decor	seller0117@example.in	8000000116	2025-10-22
118	MobileMania Store	seller0118@example.in	8000000117	2026-06-10
119	Mysuru Furnishings	seller0119@example.in	8000000118	2023-11-24
120	NatureNest Organics	seller0120@example.in	8000000119	2025-08-12
121	Furniture Foundry	seller0121@example.in	8000000120	2025-09-27
122	Prakruti Organics	seller0122@example.in	8000000121	2026-07-03
123	Cauvery Traders	seller0123@example.in	8000000122	2025-02-17
124	Konkan Auto Mart	seller0124@example.in	8000000123	2026-05-19
125	Ananya Collections	seller0125@example.in	8000000124	2025-10-08
126	Vellore Tech Point	seller0126@example.in	8000000125	2026-05-27
127	Bharat Artisan House	seller0127@example.in	8000000126	2024-03-31
128	Mitra Fashion Studio	seller0128@example.in	8000000127	2026-08-28
129	Abhivyakti Arts	seller0129@example.in	8000000128	2026-04-24
130	Surya Enterprises	seller0130@example.in	8000000129	2025-01-08
131	Urban Loom	seller0131@example.in	8000000130	2025-04-30
132	Dehradun Adventure Shop	seller0132@example.in	8000000131	2025-06-12
133	Ahmedabad Appliance Centre	seller0133@example.in	8000000132	2024-07-31
134	Sai Krupa Retailers	seller0134@example.in	8000000133	2025-10-08
135	Deccan Digital Store	seller0135@example.in	8000000134	2026-08-11
136	Panaji Beachside Retail	seller0136@example.in	8000000135	2023-12-16
137	Avani Enterprises	seller0137@example.in	8000000136	2026-07-31
138	Jamshedpur Industrial Supply	seller0138@example.in	8000000137	2025-06-20
139	UrbanNest Furnishings	seller0139@example.in	8000000138	2023-10-02
140	Book World India	seller0140@example.in	8000000139	2026-04-27
141	Delhi Daily Mart	seller0141@example.in	8000000140	2024-10-11
142	HomeChef Depot	seller0142@example.in	8000000141	2026-08-12
143	Desi Pantry	seller0143@example.in	8000000142	2025-11-06
144	Earth & Earthy	seller0144@example.in	8000000143	2024-04-05
145	Thiruvananthapuram Green Store	seller0145@example.in	8000000144	2026-02-08
146	SoleStory	seller0146@example.in	8000000145	2024-06-23
147	Millet House India	seller0147@example.in	8000000146	2024-03-08
148	Nashik Fresh Basket	seller0148@example.in	8000000147	2025-03-15
149	Dharohar India	seller0149@example.in	8000000148	2026-03-18
150	ValueKart India	seller0150@example.in	8000000149	2025-02-10
151	Shillong Mountain Goods	seller0151@example.in	8000000150	2026-07-23
152	Nagpur Auto Accessories	seller0152@example.in	8000000151	2025-12-11
153	Coconut Grove Goods	seller0153@example.in	8000000152	2025-09-19
154	Surat Textile House	seller0154@example.in	8000000153	2024-03-08
155	Aranya Naturals	seller0155@example.in	8000000154	2025-03-01
156	ChoicePoint Marketplace	seller0156@example.in	8000000155	2025-02-18
157	CasaCraft India	seller0157@example.in	8000000156	2026-03-28
158	BlueKite Technologies	seller0158@example.in	8000000157	2026-04-29
159	RoamReady	seller0159@example.in	8000000158	2025-03-23
160	Aarav Ventures	seller0160@example.in	8000000159	2026-01-18
161	Beauty Basket India	seller0161@example.in	8000000160	2025-06-21
162	Lotus Living	seller0162@example.in	8000000161	2023-10-18
163	Evergreen Retail	seller0163@example.in	8000000162	2024-12-06
164	Made in India Store	seller0164@example.in	8000000163	2025-03-15
165	TrailBlaze Sports	seller0165@example.in	8000000164	2026-08-14
166	Peacock Avenue	seller0166@example.in	8000000165	2023-12-23
167	Desi Drapes	seller0167@example.in	8000000166	2024-12-05
168	Coimbatore Kitchen Mart	seller0168@example.in	8000000167	2024-04-16
169	Mumbai Mobile Hub	seller0169@example.in	8000000168	2023-10-05
170	Chandigarh Living	seller0170@example.in	8000000169	2024-05-16
171	Cotton Route	seller0171@example.in	8000000170	2024-10-16
172	Wellness Window	seller0172@example.in	8000000171	2026-07-31
173	Modern Muse Apparel	seller0173@example.in	8000000172	2023-10-12
174	Appliance Avenue	seller0174@example.in	8000000173	2023-10-30
175	Varanasi Heritage	seller0175@example.in	8000000174	2025-05-14
176	DriveMate Accessories	seller0176@example.in	8000000175	2026-08-09
177	TravelTrail India	seller0177@example.in	8000000176	2025-10-13
178	Little Explorers Store	seller0178@example.in	8000000177	2026-02-09
179	Sundar Handicrafts	seller0179@example.in	8000000178	2025-01-30
180	PetNest Supplies	seller0180@example.in	8000000179	2023-10-04
181	Jaipur Craft House	seller0181@example.in	8000000180	2023-10-22
182	Amravati General Store	seller0182@example.in	8000000181	2026-07-19
183	Rajkot Machine Mart	seller0183@example.in	8000000182	2023-12-07
184	Kanpur Footwear House	seller0184@example.in	8000000183	2023-10-02
185	SoleCraft India	seller0185@example.in	8000000184	2024-05-02
186	Rangoli Home Studio	seller0186@example.in	8000000185	2025-10-05
187	Amrut Foods	seller0187@example.in	8000000186	2025-09-28
188	Prime Choice Retail	seller0188@example.in	8000000187	2023-11-06
189	Faridabad Home Centre	seller0189@example.in	8000000188	2024-07-03
190	Tiruchirappalli Book Depot	seller0190@example.in	8000000189	2026-07-17
191	Kolkata Book Corner	seller0191@example.in	8000000190	2024-03-08
192	Godavari Home Store	seller0192@example.in	8000000191	2024-08-16
193	WeaveWorks India	seller0193@example.in	8000000192	2026-02-27
194	Puri Coastal Crafts	seller0194@example.in	8000000193	2023-10-16
195	Everyday Essentials	seller0195@example.in	8000000194	2026-07-16
196	Thread & Trend	seller0196@example.in	8000000195	2023-10-13
197	Asansol Home Market	seller0197@example.in	8000000196	2026-06-28
198	Sahyadri Goods	seller0198@example.in	8000000197	2024-08-12
199	Warangal Daily Needs	seller0199@example.in	8000000198	2025-02-26
200	Dhanbad Electronics Point	seller0200@example.in	8000000199	2024-07-01
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (product_id, seller_id, category_id, product_name, description, brand, price, quantity_in_stock, reorder_level, last_updated, is_active) FROM stdin;
2	21	1	VistaCore 50-inch 4K Smart TV (DigitalDukaan)	4K HDR smart television. Suitable for everyday Indian household, personal, office, or leisure use.	VistaCore	32599.00	0	10	2026-09-04 00:00:00	t
3	21	1	Nexon 55-inch QLED TV (DigitalDukaan)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Nexon	107000.00	89	19	2026-09-22 00:00:00	t
4	21	1	Auralis 43-inch 4K Smart TV (DigitalDukaan)	4K HDR smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	41000.00	112	17	2026-08-26 00:00:00	t
8	40	1	VistaCore Bluetooth Party Speaker (SmartBuy Junction)	portable high-output Bluetooth speaker. Suitable for everyday Indian household, personal, office, or leisure use.	VistaCore	14049.00	15	25	2026-10-01 00:00:00	t
11	54	1	Orion True Wireless Earbuds (Pixel & Parts)	wireless in-ear audio earbuds. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	5000.00	122	18	2026-09-19 00:00:00	t
13	112	1	Orion Wi-Fi 6 Router (Visakhapatnam Electronics)	dual-band Wi-Fi 6 wireless router. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	2599.00	116	19	2026-08-26 00:00:00	t
599	12	16	HomeCanvas Storage Basket Set (Karigar Collective)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	760.00	87	22	2026-11-10 06:47:25.783141	t
20	130	1	Auralis 50-inch 4K Smart TV (Surya Enterprises)	4K HDR smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	29599.00	6	10	2026-09-13 00:00:00	t
21	160	1	Auralis Bluetooth Party Speaker (Aarav Ventures)	portable high-output Bluetooth speaker. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	2849.00	127	5	2026-09-13 00:00:00	t
304	161	9	GlowNest Vitamin C Face Serum (Beauty Basket India)	brightening facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	989.00	3	8	2026-11-10 06:47:25.783141	t
26	200	1	Orion Over-Ear Wireless Headphones (Dhanbad Electronics Point)	Bluetooth over-ear headphones. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	10099.00	46	17	2026-08-30 00:00:00	t
126	56	6	Oak & Loom Bookshelf (Royal Living)	multi-shelf storage bookcase. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	5700.00	113	17	2026-11-10 06:47:25.783141	t
29	44	2	Astra 5G Smartphone 128GB (Gadget Grove)	5G smartphone with 128GB storage. Suitable for everyday Indian household, personal, office, or leisure use.	Astra	32549.00	92	5	2026-08-28 00:00:00	t
362	68	10	FarmBasket Tea 500g (Bharat Bazaar)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	490.00	98	6	2026-11-10 06:47:25.783141	t
661	95	16	CasaCraft Glass Storage Container Set (Mitti & More)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1000.00	140	18	2026-11-10 06:47:25.783141	t
701	137	16	NestNook Wall Decor Set (Avani Enterprises)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	889.00	134	12	2026-11-10 06:47:25.783141	t
37	118	2	Pixelra 10000mAh Power Bank (MobileMania Store)	portable USB-C power bank. Suitable for everyday Indian household, personal, office, or leisure use.	Pixelra	1100.00	55	23	2026-08-22 00:00:00	t
41	169	2	NexCell Wireless Charging Pad (Mumbai Mobile Hub)	Qi-compatible wireless charging pad. Suitable for everyday Indian household, personal, office, or leisure use.	NexCell	1699.00	88	18	2026-09-12 00:00:00	t
44	169	2	Voltix USB-C Braided Cable (Mumbai Mobile Hub)	durable USB-C charging cable. Suitable for everyday Indian household, personal, office, or leisure use.	Voltix	679.00	85	15	2026-08-17 00:00:00	t
45	36	3	Vertex 15.6-inch Performance Laptop (NCR Tech Traders)	performance-oriented Windows laptop. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	92000.00	121	25	2026-09-10 00:00:00	t
46	36	3	ZenByte 14-inch Business Laptop (NCR Tech Traders)	business-focused lightweight laptop. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	59099.00	111	5	2026-09-12 00:00:00	t
88	174	4	EverCool Single Door Refrigerator (Appliance Avenue)	energy-efficient single-door refrigerator. Suitable for everyday Indian household, personal, office, or leisure use.	EverCool	24549.00	46	20	2026-11-10 06:47:25.783141	t
76	22	4	Cresta Front Load Washing Machine (Noida Smart Living)	fully automatic front-load washing machine. Suitable for everyday Indian household, personal, office, or leisure use.	Cresta	48599.00	113	11	2026-11-10 06:47:25.783141	t
260	185	8	SoleStory Men's Casual Sneakers (SoleCraft India)	everyday casual sneakers. Suitable for everyday Indian household, personal, office, or leisure use.	SoleStory	4099.00	36	6	2026-11-10 06:47:25.783141	t
65	135	3	CoreNova Mechanical Keyboard (Deccan Digital Store)	backlit mechanical desktop keyboard. Suitable for everyday Indian household, personal, office, or leisure use.	CoreNova	4899.00	96	8	2026-11-10 06:47:25.783141	t
401	109	10	PureHarvest Moong Dal 1kg (Indus Mercantile)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	149.00	109	25	2026-11-10 06:47:25.783141	t
525	46	12	CampusPro Highlighter Set (Pioneer Office Solutions)	assorted fluorescent highlighters. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	129.00	56	9	2026-11-10 06:47:25.783141	t
238	196	7	ThreadCraft Women's Anarkali Kurta (Thread & Trend)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1700.00	14	24	2026-11-10 06:47:25.783141	t
66	135	3	Vertex 27-inch QHD Monitor (Deccan Digital Store)	QHD IPS desktop monitor. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	16000.00	98	24	2026-09-27 00:00:00	t
68	135	3	TechEdge Gaming Laptop (Deccan Digital Store)	dedicated-GPU gaming laptop. Suitable for everyday Indian household, personal, office, or leisure use.	TechEdge	116049.00	11	14	2026-09-20 00:00:00	t
70	158	3	ByteCraft USB-C Docking Station (BlueKite Technologies)	multi-port USB-C laptop dock. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	7999.00	23	10	2026-08-25 00:00:00	t
504	191	11	Campus Reads Database Systems (Kolkata Book Corner)	academic introduction to database systems. Suitable for everyday Indian household, personal, office, or leisure use.	Campus Reads	1099.00	88	23	2026-11-10 06:47:25.783141	t
396	100	10	PureHarvest Basmati Rice 5kg (Malabar Essentials)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	489.00	40	8	2026-11-10 06:47:25.783141	t
293	144	9	AuraCare Foaming Face Wash (Earth & Earthy)	refreshing foaming face wash. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	260.00	96	20	2026-11-10 06:47:25.783141	t
425	143	10	FreshField Breakfast Oats 1kg (Desi Pantry)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	330.00	66	22	2026-11-10 06:47:25.783141	t
78	92	4	Cresta Ceiling Fan (Salem Appliance House)	high-air-delivery ceiling fan. Suitable for everyday Indian household, personal, office, or leisure use.	Cresta	2399.00	77	8	2026-09-28 00:00:00	t
693	127	16	NestNook Glass Storage Container Set (Bharat Artisan House)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	789.00	81	9	2026-11-10 06:47:25.783141	t
83	133	4	HomeZen Air Purifier (Ahmedabad Appliance Centre)	HEPA air purifier for indoor spaces. Suitable for everyday Indian household, personal, office, or leisure use.	HomeZen	9200.00	144	19	2026-08-25 00:00:00	t
610	28	16	TableTop Water Bottle Set (Agra Craft Bazaar)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1199.00	143	7	2026-11-10 06:47:25.783141	t
356	53	10	PureHarvest Basmati Rice 5kg (Shree Balaji Traders)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	699.00	77	18	2026-11-10 06:47:25.783141	t
86	174	4	AeroHome Double Door Refrigerator (Appliance Avenue)	frost-free double-door refrigerator. Suitable for everyday Indian household, personal, office, or leisure use.	AeroHome	39500.00	108	20	2026-09-03 00:00:00	t
265	27	9	SattvaSkin Foaming Face Wash (GlowNest Beauty)	refreshing foaming face wash. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	650.00	8	14	2026-11-10 06:47:25.783141	t
89	189	4	Cresta Top Load Washing Machine (Faridabad Home Centre)	fully automatic top-load washing machine. Suitable for everyday Indian household, personal, office, or leisure use.	Cresta	24599.00	0	12	2026-08-23 00:00:00	t
35	78	2	MobiOne 33W GaN Charger (Bengaluru Gadget Works)	GaN fast charging adapter. Suitable for everyday Indian household, personal, office, or leisure use.	MobiOne	1400.00	10	25	2026-11-10 06:47:25.783141	t
60	76	3	CoreNova USB-C Docking Station (Computer Corner)	multi-port USB-C laptop dock. Suitable for everyday Indian household, personal, office, or leisure use.	CoreNova	7099.00	42	23	2026-11-10 06:47:25.783141	t
94	16	5	SpiceMate Air Fryer 4L (Kerala Kitchen)	digital hot-air fryer. Suitable for everyday Indian household, personal, office, or leisure use.	SpiceMate	4249.00	16	25	2026-08-31 00:00:00	t
95	16	5	CookEase Mixer Grinder 750W (Kerala Kitchen)	multi-jar mixer grinder. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	4399.00	67	12	2026-09-30 00:00:00	t
666	99	16	KitchenKart Dinner Set (Hubballi Hardware House)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	3149.00	7	8	2026-11-10 06:47:25.783141	t
97	41	5	KitchPro Microwave Oven 28L (Coastal Kitchenware)	convection microwave oven. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	11099.00	146	5	2026-09-15 00:00:00	t
433	147	10	FreshField Filter Coffee 500g (Millet House India)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	669.00	67	16	2026-11-10 06:47:25.783141	t
130	84	6	Oak & Loom Coffee Table (The Living Room Store)	modern living-room coffee table. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	7399.00	48	18	2026-11-10 06:47:25.783141	t
103	90	5	CookEase Rice Cooker 1.8L (Kitchen Canvas)	automatic electric rice cooker. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	2899.00	121	21	2026-08-20 00:00:00	t
786	49	18	WhiskersCo Cat Litter 5kg (Krishna Retail)	clumping cat litter. Suitable for everyday Indian household, personal, office, or leisure use.	WhiskersCo	610.00	54	22	2026-11-10 06:47:25.783141	t
105	98	5	SpiceMate OTG 30L (Cookware Collective)	countertop oven toaster grill. Suitable for everyday Indian household, personal, office, or leisure use.	SpiceMate	5599.00	37	12	2026-11-10 06:47:25.783141	t
150	162	6	Oak & Loom Computer Table (Lotus Living)	compact computer workstation. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	4649.00	38	17	2026-11-10 06:47:25.783141	t
112	102	5	CookEase Mixer Grinder 1000W (KitchenKart India)	high-power mixer grinder. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	5000.00	66	6	2026-09-30 00:00:00	t
529	96	12	DeskMate Whiteboard Marker Set (Patna Stationery Hub)	low-odour whiteboard markers. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	339.00	60	24	2026-11-10 06:47:25.783141	t
114	142	5	SpiceMate Electric Kettle 1.5L (HomeChef Depot)	stainless-steel electric kettle. Suitable for everyday Indian household, personal, office, or leisure use.	SpiceMate	1949.00	58	23	2026-08-30 00:00:00	t
71	158	3	ZenByte Mechanical Keyboard (BlueKite Technologies)	backlit mechanical desktop keyboard. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	5300.00	46	25	2026-11-10 06:47:25.783141	t
303	161	9	VedaGlow Conditioner (Beauty Basket India)	moisturising hair conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	739.00	90	23	2026-11-10 06:47:25.783141	t
120	168	5	ChefNest Electric Kettle 1.5L (Coimbatore Kitchen Mart)	stainless-steel electric kettle. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	2300.00	47	15	2026-08-20 00:00:00	t
129	84	6	TimberLine Shoe Rack (The Living Room Store)	multi-tier shoe storage unit. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	3399.00	54	5	2026-08-31 00:00:00	t
131	84	6	UrbanNest Office Chair (The Living Room Store)	ergonomic adjustable office chair. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	9400.00	99	6	2026-08-20 00:00:00	t
133	119	6	TimberLine Study Table (Mysuru Furnishings)	engineered-wood study table. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	6849.00	145	16	2026-09-09 00:00:00	t
374	80	10	DailyGrain Tea 500g (Maa Durga Enterprises)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	689.00	18	8	2026-11-10 06:47:25.783141	t
136	119	6	TimberLine Accent Chair (Mysuru Furnishings)	upholstered accent chair. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	13500.00	17	8	2026-09-21 00:00:00	t
137	120	6	CasaCraft Bookshelf (NatureNest Organics)	multi-shelf storage bookcase. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	5899.00	98	23	2026-09-01 00:00:00	t
140	120	6	Woodora Office Desk (NatureNest Organics)	spacious work-from-home desk. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	9900.00	128	11	2026-09-01 00:00:00	t
143	121	6	Oak & Loom Bedside Table (Furniture Foundry)	two-drawer bedside table. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	2900.00	145	5	2026-09-17 00:00:00	t
147	139	6	UrbanNest Accent Chair (UrbanNest Furnishings)	upholstered accent chair. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	10099.00	25	23	2026-09-02 00:00:00	t
148	139	6	Oak & Loom Dining Table (UrbanNest Furnishings)	four-seater dining table. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	23099.00	8	6	2026-09-12 00:00:00	t
316	5	10	FreshField Moong Dal 1kg (The Indian Basket)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	210.00	62	19	2026-11-10 06:47:25.783141	t
153	170	6	TimberLine TV Unit (Chandigarh Living)	living-room television console. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	6699.00	58	17	2026-09-12 00:00:00	t
662	95	16	TableTop Stainless Steel Cookware Set (Mitti & More)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	5849.00	124	16	2026-11-10 06:47:25.783141	t
155	170	6	CasaCraft Bedside Table (Chandigarh Living)	two-drawer bedside table. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	4300.00	74	23	2026-09-05 00:00:00	t
620	35	16	TableTop Glass Storage Container Set (Pragati Retail Works)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1600.00	117	21	2026-11-10 06:47:25.783141	t
163	17	7	IndigoLane Women's Anarkali Kurta (Sari Street)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	3449.00	87	19	2026-09-01 00:00:00	t
792	89	18	TailWaggers Pet Grooming Brush (Ghaziabad Retail Works)	deshedding grooming brush. Suitable for everyday Indian household, personal, office, or leisure use.	TailWaggers	510.00	95	12	2026-11-10 06:47:25.783141	t
32	44	2	NexCell Budget 5G Smartphone (Gadget Grove)	value-oriented 5G smartphone. Suitable for everyday Indian household, personal, office, or leisure use.	NexCell	11500.00	66	12	2026-11-10 06:47:25.783141	t
55	66	3	ZenByte 27-inch QHD Monitor (Chennai Computer Depot)	QHD IPS desktop monitor. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	15500.00	47	19	2026-11-10 06:47:25.783141	t
597	12	16	TableTop Bath Towel Set (Karigar Collective)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1000.00	95	7	2026-11-10 06:47:25.783141	t
195	86	7	IndigoLane Women's Straight Trousers (Madurai Textile Works)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1799.00	149	18	2026-11-10 06:47:25.783141	t
146	139	6	TimberLine Coffee Table (UrbanNest Furnishings)	modern living-room coffee table. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	3449.00	30	10	2026-11-10 06:47:25.783141	t
181	55	7	ThreadCraft Unisex Hoodie (Ethnic Edit)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1500.00	2	21	2026-09-24 00:00:00	t
183	55	7	CottonRoot Women's Straight Trousers (Ethnic Edit)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	1049.00	146	17	2026-09-07 00:00:00	t
565	60	15	DriveMate Car Air Compressor (RoadReady Auto)	portable tyre inflator. Suitable for everyday Indian household, personal, office, or leisure use.	DriveMate	3999.00	115	11	2026-11-10 06:47:25.783141	t
187	67	7	UrbanWeave Kids' Cotton T-Shirt (Indigo Loom)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	639.00	58	6	2026-08-20 00:00:00	t
188	67	7	EthnicEdit Men's Formal Shirt (Indigo Loom)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	1749.00	98	5	2026-09-19 00:00:00	t
347	47	10	FreshField Multigrain Atta 5kg (Rajdhani Traders)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	379.00	7	10	2026-11-10 06:47:25.783141	t
190	74	7	UrbanWeave Women's Cotton Kurta (Kaveri Lifestyle)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1499.00	7	12	2026-09-04 00:00:00	t
225	171	7	ThreadCraft Women's Saree (Cotton Route)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	4149.00	26	15	2026-11-10 06:47:25.783141	t
563	178	14	BrainyKids Jigsaw Puzzle 500 Piece (Little Explorers Store)	500-piece illustrated jigsaw puzzle. Suitable for everyday Indian household, personal, office, or leisure use.	BrainyKids	809.00	37	23	2026-11-10 06:47:25.783141	t
200	114	7	EthnicEdit Unisex Hoodie (Lucknow Lifestyle)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	1999.00	9	22	2026-09-24 00:00:00	t
202	125	7	EthnicEdit Men's Chino Trousers (Ananya Collections)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	959.00	0	22	2026-09-13 00:00:00	t
99	41	5	CookEase Microwave Oven 20L (Coastal Kitchenware)	solo microwave oven. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	7149.00	122	25	2026-11-10 06:47:25.783141	t
204	125	7	IndigoLane Men's Cotton T-Shirt (Ananya Collections)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	789.00	1	9	2026-09-27 00:00:00	t
205	128	7	CottonRoot Women's Casual Top (Mitra Fashion Studio)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	649.00	67	12	2026-09-09 00:00:00	t
328	11	10	PureHarvest Toor Dal 1kg (PureHarvest Foods)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	140.00	19	23	2026-11-10 06:47:25.783141	t
209	131	7	EthnicEdit Women's Casual Top (Urban Loom)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	949.00	45	9	2026-08-25 00:00:00	t
745	13	17	RoamReady Medium Trolley Bag (Siliguri Travel Goods)	medium hard-shell trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	6399.00	104	5	2026-11-10 06:47:25.783141	t
213	154	7	CottonRoot Unisex Hoodie (Surat Textile House)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	1449.00	72	18	2026-09-27 00:00:00	t
605	20	16	KitchenKart Dinner Set (Virasat India)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	2400.00	53	17	2026-11-10 06:47:25.783141	t
611	28	16	HomeCanvas Cotton Bedsheet (Agra Craft Bazaar)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1600.00	141	10	2026-11-10 06:47:25.783141	t
218	166	7	UrbanWeave Men's Formal Shirt (Peacock Avenue)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1349.00	110	20	2026-09-05 00:00:00	t
659	94	16	CasaCraft Curtain Set (Golden Peacock Crafts)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	989.00	52	18	2026-11-10 06:47:25.783141	t
672	103	16	NestNook Curtain Set (HomeHive India)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2199.00	8	10	2026-11-10 06:47:25.783141	t
223	167	7	CottonRoot Women's Straight Trousers (Desi Drapes)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2300.00	108	21	2026-09-28 00:00:00	t
227	171	7	EthnicEdit Women's Straight Trousers (Cotton Route)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	2200.00	5	22	2026-09-10 00:00:00	t
228	171	7	UrbanWeave Kids' Cotton T-Shirt (Cotton Route)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	680.00	0	5	2026-08-29 00:00:00	t
323	10	10	DailyGrain Breakfast Oats 1kg (Ganga Enterprises)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	199.00	53	24	2026-11-10 06:47:25.783141	t
773	151	17	NomadGear Large Trolley Bag (Shillong Mountain Goods)	large check-in trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	8200.00	108	7	2026-11-10 06:47:25.783141	t
192	74	7	ThreadCraft Men's Formal Shirt (Kaveri Lifestyle)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	2099.00	147	12	2026-11-10 06:47:25.783141	t
234	193	7	CottonRoot Women's Cotton Kurta (WeaveWorks India)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	1100.00	142	20	2026-08-30 00:00:00	t
237	196	7	IndigoLane Women's Casual Top (Thread & Trend)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	649.00	139	12	2026-08-29 00:00:00	t
239	196	7	UrbanWeave Women's Straight Trousers (Thread & Trend)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1899.00	19	21	2026-08-20 00:00:00	t
240	196	7	CottonRoot Women's Saree (Thread & Trend)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2199.00	86	22	2026-08-31 00:00:00	t
241	50	8	StrideOne Men's Casual Sneakers (Walkway Footwear)	everyday casual sneakers. Suitable for everyday Indian household, personal, office, or leisure use.	StrideOne	4699.00	51	20	2026-08-26 00:00:00	t
242	50	8	WalkMate Men's Formal Loafers (Walkway Footwear)	synthetic-leather formal loafers. Suitable for everyday Indian household, personal, office, or leisure use.	WalkMate	2299.00	43	9	2026-09-29 00:00:00	t
67	135	3	ByteCraft 24-inch Full HD Monitor (Deccan Digital Store)	Full HD IPS desktop monitor. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	14099.00	90	6	2026-11-10 06:47:25.783141	t
250	146	8	UrbanSole Women's Ballet Flats (SoleStory)	comfortable flat footwear. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanSole	1899.00	21	8	2026-09-15 00:00:00	t
251	146	8	StrideOne Kids' Velcro Shoes (SoleStory)	easy-wear children's shoes. Suitable for everyday Indian household, personal, office, or leisure use.	StrideOne	1549.00	42	14	2026-09-14 00:00:00	t
569	69	15	AutoGear Car Dashboard Cleaner (Vishwakarma Tools & Supply)	interior dashboard cleaning kit. Suitable for everyday Indian household, personal, office, or leisure use.	AutoGear	829.00	97	18	2026-11-10 06:47:25.783141	t
253	184	8	StepCraft Men's Casual Sneakers (Kanpur Footwear House)	everyday casual sneakers. Suitable for everyday Indian household, personal, office, or leisure use.	StepCraft	1649.00	45	22	2026-09-16 00:00:00	t
256	184	8	UrbanSole Men's Leather Sandals (Kanpur Footwear House)	casual leather sandals. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanSole	640.00	4	8	2026-08-19 00:00:00	t
258	185	8	StrideOne Men's Formal Loafers (SoleCraft India)	synthetic-leather formal loafers. Suitable for everyday Indian household, personal, office, or leisure use.	StrideOne	2300.00	21	8	2026-09-06 00:00:00	t
432	145	10	FreshField Wheat Flour 5kg (Thiruvananthapuram Green Store)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	379.00	100	13	2026-11-10 06:47:25.783141	t
255	184	8	UrbanSole Men's Running Shoes (Kanpur Footwear House)	lightweight running shoes. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanSole	3799.00	56	6	2026-11-10 06:47:52.331634	t
248	88	8	StepCraft Men's Walking Shoes (Footprint Footwear)	cushioned walking shoes. Suitable for everyday Indian household, personal, office, or leisure use.	StepCraft	1800.00	117	10	2026-11-10 06:47:52.331634	t
270	34	9	AuraCare Body Lotion (Jaipur Jewel Box)	daily hydrating body lotion. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	639.00	2	22	2026-10-01 00:00:00	t
273	62	9	SattvaSkin Hyaluronic Acid Serum (Sattva Naturals)	hydrating facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	1500.00	108	19	2026-09-29 00:00:00	t
274	62	9	VedaGlow Beard Grooming Kit (Sattva Naturals)	beard oil, balm and comb kit. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	889.00	117	18	2026-09-21 00:00:00	t
281	101	9	PureBloom Herbal Shampoo (Nilgiri Naturals)	plant-extract daily shampoo. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	690.00	17	11	2026-09-08 00:00:00	t
283	101	9	GlowNest Sunscreen SPF 50 (Nilgiri Naturals)	broad-spectrum sunscreen. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	610.00	46	6	2026-09-12 00:00:00	t
285	105	9	AuraCare Beard Grooming Kit (Veda Wellness)	beard oil, balm and comb kit. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	549.00	68	15	2026-09-03 00:00:00	t
286	105	9	SattvaSkin Conditioner (Veda Wellness)	moisturising hair conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	339.00	146	19	2026-08-28 00:00:00	t
288	105	9	VedaGlow Herbal Shampoo (Veda Wellness)	plant-extract daily shampoo. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	979.00	14	16	2026-09-24 00:00:00	t
296	144	9	VedaGlow Sunscreen SPF 50 (Earth & Earthy)	broad-spectrum sunscreen. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	740.00	96	20	2026-09-29 00:00:00	t
299	155	9	AuraCare Herbal Shampoo (Aranya Naturals)	plant-extract daily shampoo. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	300.00	21	24	2026-09-30 00:00:00	t
271	34	9	SattvaSkin Herbal Shampoo (Jaipur Jewel Box)	plant-extract daily shampoo. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	490.00	4	7	2026-11-10 06:47:52.331634	t
301	161	9	GlowNest Beard Grooming Kit (Beauty Basket India)	beard oil, balm and comb kit. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	1099.00	141	15	2026-11-10 06:47:52.331634	t
290	122	9	PureBloom Beard Grooming Kit (Prakruti Organics)	beard oil, balm and comb kit. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	699.00	138	11	2026-11-10 06:47:52.331634	t
300	155	9	PureBloom Conditioner (Aranya Naturals)	moisturising hair conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	620.00	90	11	2026-11-10 06:47:52.331634	t
295	144	9	GlowNest Gentle Face Cleanser (Earth & Earthy)	mild daily facial cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	440.00	111	25	2026-11-10 06:47:52.331634	t
284	101	9	SattvaSkin Daily Moisturizer (Nilgiri Naturals)	lightweight daily moisturizer. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	1149.00	34	19	2026-11-10 06:47:52.331634	t
277	70	9	VedaGlow Daily Moisturizer (AyurVeda Essentials)	lightweight daily moisturizer. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	669.00	127	6	2026-11-10 06:47:52.331634	t
282	101	9	AuraCare Anti-Dandruff Shampoo (Nilgiri Naturals)	anti-dandruff hair cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	300.00	7	10	2026-11-10 06:47:52.331634	t
392	93	10	DailyGrain Filter Coffee 500g (PlayZone Bazaar)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	769.00	9	25	2026-11-10 06:47:52.331634	t
84	133	4	ArcticNest Room Heater (Ahmedabad Appliance Centre)	electric room heater with thermostat. Suitable for everyday Indian household, personal, office, or leisure use.	ArcticNest	3300.00	73	5	2026-11-10 06:47:52.331634	t
278	70	9	PureBloom Foaming Face Wash (AyurVeda Essentials)	refreshing foaming face wash. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	609.00	131	11	2026-11-10 06:47:52.331634	t
602	19	16	TableTop Stainless Steel Cookware Set (Pondicherry Lifestyle Studio)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	6900.00	108	11	2026-11-10 06:47:52.331634	t
145	139	6	Woodora Office Chair (UrbanNest Furnishings)	ergonomic adjustable office chair. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	5200.00	62	18	2026-11-10 06:47:52.331634	t
721	179	16	TableTop Stainless Steel Cookware Set (Sundar Handicrafts)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	5649.00	21	24	2026-11-10 06:47:52.331634	t
307	172	9	SattvaSkin Foaming Face Wash (Wellness Window)	refreshing foaming face wash. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	899.00	105	5	2026-08-17 00:00:00	t
308	172	9	VedaGlow Gentle Face Cleanser (Wellness Window)	mild daily facial cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	500.00	74	23	2026-08-19 00:00:00	t
310	4	10	PureHarvest Sona Masoori Rice 5kg (BharatMart)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	470.00	81	20	2026-08-29 00:00:00	t
311	4	10	DailyGrain Moong Dal 1kg (BharatMart)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	220.00	91	23	2026-08-20 00:00:00	t
312	4	10	DesiHarvest Toor Dal 1kg (BharatMart)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	179.00	35	15	2026-08-27 00:00:00	t
319	7	10	FarmBasket Filter Coffee 500g (Vijayawada Value Mart)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	759.00	43	5	2026-09-09 00:00:00	t
341	39	10	PureHarvest Moong Dal 1kg (FreshField Grocers)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	229.00	92	18	2026-11-10 06:47:52.331634	t
515	15	12	OfficeOrbit Desk Organizer (Cuttack Stationery World)	multi-compartment desk organizer. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	200.00	65	8	2026-11-10 06:47:52.331634	t
226	171	7	IndigoLane Unisex Hoodie (Cotton Route)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	2349.00	17	21	2026-11-10 06:47:52.331634	t
527	46	12	WriteWell Document Folder (Pioneer Office Solutions)	durable document storage folder. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	90.00	86	9	2026-11-10 06:47:52.331634	t
330	14	10	PureHarvest Sugar 5kg (Raipur Retail Hub)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	270.00	101	7	2026-09-28 00:00:00	t
333	23	10	FreshField Filter Coffee 500g (QuickCart Enterprises)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	830.00	36	18	2026-09-01 00:00:00	t
336	23	10	FarmBasket Mixed Nuts 500g (QuickCart Enterprises)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	350.00	1	10	2026-09-06 00:00:00	t
338	31	10	DailyGrain Sona Masoori Rice 5kg (Kaveri Traders)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	500.00	143	23	2026-08-24 00:00:00	t
370	77	10	PureHarvest Sona Masoori Rice 5kg (Panchvati Stores)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	830.00	20	12	2026-11-10 06:47:52.331634	t
340	31	10	DesiHarvest Breakfast Oats 1kg (Kaveri Traders)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	399.00	2	7	2026-09-10 00:00:00	t
342	39	10	FarmBasket Toor Dal 1kg (FreshField Grocers)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	180.00	46	13	2026-09-03 00:00:00	t
343	39	10	DailyGrain Multigrain Atta 5kg (FreshField Grocers)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	300.00	100	11	2026-08-22 00:00:00	t
176	37	7	CottonRoot Women's Cotton Kurta (Marigold Collections)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	859.00	96	11	2026-11-10 06:47:52.331634	t
27	200	1	Zenith Mirrorless Camera (Dhanbad Electronics Point)	interchangeable-lens mirrorless camera. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	77000.00	38	12	2026-11-10 06:47:52.331634	t
349	52	10	DailyGrain Filter Coffee 500g (Farm2Shelf Market)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	660.00	0	22	2026-09-27 00:00:00	t
572	69	15	WheelWise Microfiber Cleaning Kit (Vishwakarma Tools & Supply)	automotive cleaning cloth kit. Suitable for everyday Indian household, personal, office, or leisure use.	WheelWise	790.00	36	24	2026-11-10 06:47:52.331634	t
354	53	10	DesiHarvest Sona Masoori Rice 5kg (Shree Balaji Traders)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	659.00	11	22	2026-08-23 00:00:00	t
207	128	7	IndigoLane Women's Cotton Kurta (Mitra Fashion Studio)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1549.00	68	23	2026-11-10 06:47:52.331634	t
236	193	7	EthnicEdit Women's Anarkali Kurta (WeaveWorks India)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	2800.00	22	18	2026-11-10 06:47:52.331634	t
359	61	10	DailyGrain Sugar 5kg (Narmada Marketplace)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	259.00	72	23	2026-09-17 00:00:00	t
361	68	10	FreshField Sugar 5kg (Bharat Bazaar)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	289.00	81	15	2026-09-23 00:00:00	t
363	68	10	DesiHarvest Mixed Nuts 500g (Bharat Bazaar)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	700.00	2	5	2026-09-07 00:00:00	t
364	68	10	PureHarvest Filter Coffee 500g (Bharat Bazaar)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	700.00	91	13	2026-08-24 00:00:00	t
371	77	10	DesiHarvest Toor Dal 1kg (Panchvati Stores)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	239.00	59	15	2026-08-31 00:00:00	t
372	77	10	DailyGrain Moong Dal 1kg (Panchvati Stores)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	160.00	120	8	2026-08-24 00:00:00	t
376	80	10	DesiHarvest Sugar 5kg (Maa Durga Enterprises)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	280.00	59	19	2026-08-25 00:00:00	t
379	83	10	DesiHarvest Breakfast Oats 1kg (Dastkari Bazaar)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	350.00	79	21	2026-08-21 00:00:00	t
185	67	7	UrbanWeave Men's Cotton T-Shirt (Indigo Loom)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	880.00	58	14	2026-11-10 06:47:52.331634	t
385	91	10	DailyGrain Wheat Flour 5kg (Eastern Valley Traders)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	370.00	132	19	2026-08-23 00:00:00	t
490	65	11	Campus Reads Digital Electronics (Saraswati Book House)	undergraduate digital electronics textbook. Suitable for everyday Indian household, personal, office, or leisure use.	Campus Reads	1349.00	46	12	2026-11-10 06:47:52.331634	t
771	136	17	NomadGear Travel Neck Pillow (Panaji Beachside Retail)	memory-foam travel neck pillow. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	609.00	26	18	2026-11-10 06:47:52.331634	t
9	54	1	Auralis Mirrorless Camera (Pixel & Parts)	interchangeable-lens mirrorless camera. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	29549.00	140	9	2026-11-10 06:47:52.331634	t
514	15	12	DeskMate Printer Paper 500 Sheets (Cuttack Stationery World)	A4 multipurpose printer paper. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	369.00	143	19	2026-11-10 06:47:52.331634	t
132	84	6	Woodora Dining Table (The Living Room Store)	four-seater dining table. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	21049.00	107	6	2026-11-10 06:47:52.331634	t
108	98	5	ChefNest Hand Blender (Cookware Collective)	variable-speed immersion blender. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	1449.00	91	11	2026-11-10 06:47:52.331634	t
325	11	10	FarmBasket Sona Masoori Rice 5kg (PureHarvest Foods)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	380.00	9	15	2026-11-10 06:47:52.331634	t
397	104	10	FreshField Toor Dal 1kg (Vadodara Home Essentials)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	120.00	113	7	2026-09-16 00:00:00	t
398	104	10	FarmBasket Moong Dal 1kg (Vadodara Home Essentials)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	209.00	25	21	2026-09-28 00:00:00	t
400	104	10	DailyGrain Sona Masoori Rice 5kg (Vadodara Home Essentials)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	780.00	2	9	2026-08-17 00:00:00	t
402	109	10	DesiHarvest Wheat Flour 5kg (Indus Mercantile)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	430.00	61	5	2026-08-30 00:00:00	t
404	109	10	DailyGrain Multigrain Atta 5kg (Indus Mercantile)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	489.00	20	24	2026-08-23 00:00:00	t
389	93	10	PureHarvest Sugar 5kg (PlayZone Bazaar)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	260.00	106	10	2026-11-10 06:47:52.331634	t
440	148	10	DesiHarvest Basmati Rice 5kg (Nashik Fresh Basket)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	520.00	129	19	2026-11-10 06:47:52.331634	t
415	124	10	DailyGrain Toor Dal 1kg (Konkan Auto Mart)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	200.00	17	7	2026-11-10 06:47:52.331634	t
431	145	10	DesiHarvest Toor Dal 1kg (Thiruvananthapuram Green Store)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	219.00	148	8	2026-11-10 06:47:52.331634	t
369	77	10	FreshField Wheat Flour 5kg (Panchvati Stores)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	470.00	6	24	2026-11-10 06:47:52.331634	t
414	124	10	DesiHarvest Sona Masoori Rice 5kg (Konkan Auto Mart)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	670.00	148	24	2026-08-29 00:00:00	t
416	124	10	FreshField Moong Dal 1kg (Konkan Auto Mart)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	129.00	100	15	2026-09-11 00:00:00	t
211	131	7	IndigoLane Women's Saree (Urban Loom)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	2399.00	30	5	2026-11-10 06:47:52.331634	t
420	134	10	DesiHarvest Multigrain Atta 5kg (Sai Krupa Retailers)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	339.00	113	8	2026-08-28 00:00:00	t
553	165	13	TrailBlaze Cricket Bat (TrailBlaze Sports)	English-willow style cricket bat. Suitable for everyday Indian household, personal, office, or leisure use.	TrailBlaze	5600.00	50	21	2026-11-10 06:47:52.331634	t
382	87	10	FreshField Sona Masoori Rice 5kg (Ananta Marketplace)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	640.00	143	6	2026-11-10 06:47:52.331634	t
124	1	6	UrbanNest Office Desk (Banyan Tree Living)	spacious work-from-home desk. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	7849.00	123	9	2026-11-10 06:47:52.331634	t
429	145	10	DailyGrain Moong Dal 1kg (Thiruvananthapuram Green Store)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	179.00	31	16	2026-09-22 00:00:00	t
191	74	7	CottonRoot Women's Anarkali Kurta (Kaveri Lifestyle)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	1899.00	17	23	2026-11-10 06:47:52.331634	t
412	123	10	FreshField Mixed Nuts 500g (Cauvery Traders)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	1049.00	66	16	2026-11-10 06:47:52.331634	t
438	148	10	FarmBasket Filter Coffee 500g (Nashik Fresh Basket)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	719.00	74	21	2026-09-15 00:00:00	t
443	150	10	FreshField Sona Masoori Rice 5kg (ValueKart India)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	529.00	38	17	2026-08-29 00:00:00	t
471	188	10	DesiHarvest Toor Dal 1kg (Prime Choice Retail)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	180.00	4	24	2026-11-10 06:47:52.331634	t
451	156	10	DailyGrain Filter Coffee 500g (ChoicePoint Marketplace)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	319.00	117	17	2026-08-31 00:00:00	t
454	163	10	DesiHarvest Sona Masoori Rice 5kg (Evergreen Retail)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	450.00	1	6	2026-08-28 00:00:00	t
455	163	10	PureHarvest Breakfast Oats 1kg (Evergreen Retail)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	179.00	12	24	2026-08-18 00:00:00	t
766	132	17	TravelTrail Weekender Bag (Dehradun Adventure Shop)	compact weekend travel bag. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	3149.00	99	15	2026-11-10 06:47:52.331634	t
463	183	10	DesiHarvest Wheat Flour 5kg (Rajkot Machine Mart)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	459.00	84	23	2026-09-22 00:00:00	t
467	187	10	DesiHarvest Filter Coffee 500g (Amrut Foods)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	480.00	113	24	2026-09-02 00:00:00	t
448	153	10	DesiHarvest Moong Dal 1kg (Coconut Grove Goods)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	120.00	49	18	2026-11-10 06:47:52.331634	t
139	120	6	UrbanNest Computer Table (NatureNest Organics)	compact computer workstation. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	3849.00	97	23	2026-11-10 06:47:52.331634	t
472	188	10	FarmBasket Breakfast Oats 1kg (Prime Choice Retail)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	289.00	146	20	2026-09-28 00:00:00	t
259	185	8	UrbanSole Women's Running Shoes (SoleCraft India)	lightweight women's running shoes. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanSole	6700.00	37	8	2026-11-10 06:47:52.331634	t
474	195	10	DailyGrain Toor Dal 1kg (Everyday Essentials)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	179.00	4	15	2026-08-26 00:00:00	t
495	140	11	Saraswati Press The Monsoon Letters (Book World India)	contemporary Indian fiction. Suitable for everyday Indian household, personal, office, or leisure use.	Saraswati Press	790.00	0	15	2026-11-10 06:47:52.331634	t
478	197	10	DesiHarvest Multigrain Atta 5kg (Asansol Home Market)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	269.00	135	9	2026-09-18 00:00:00	t
479	197	10	FarmBasket Filter Coffee 500g (Asansol Home Market)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	609.00	24	11	2026-09-21 00:00:00	t
174	37	7	ThreadCraft Men's Casual Shirt (Marigold Collections)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1599.00	12	22	2026-11-10 06:47:52.331634	t
235	193	7	UrbanWeave Men's Chino Trousers (WeaveWorks India)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	2099.00	130	18	2026-11-10 06:47:52.331634	t
484	199	10	PureHarvest Filter Coffee 500g (Warangal Daily Needs)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	750.00	11	16	2026-08-19 00:00:00	t
488	42	11	Campus Reads Introduction to Economics (MangoTree Books)	introductory economics textbook. Suitable for everyday Indian household, personal, office, or leisure use.	Campus Reads	1100.00	2	18	2026-09-18 00:00:00	t
360	61	10	PureHarvest Wheat Flour 5kg (Narmada Marketplace)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	480.00	7	18	2026-11-10 06:47:52.331634	t
696	127	16	TableTop Dinner Set (Bharat Artisan House)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	2049.00	76	25	2026-11-10 06:47:52.331634	t
491	65	11	Saraswati Press Data Structures in C++ (Saraswati Book House)	data structures and algorithms textbook. Suitable for everyday Indian household, personal, office, or leisure use.	Saraswati Press	1499.00	71	10	2026-09-01 00:00:00	t
493	140	11	PageTurner Digital Electronics (Book World India)	undergraduate digital electronics textbook. Suitable for everyday Indian household, personal, office, or leisure use.	PageTurner	1499.00	18	25	2026-09-03 00:00:00	t
494	140	11	MangoTree Publishing The Mango Orchard (Book World India)	Indian literary fiction. Suitable for everyday Indian household, personal, office, or leisure use.	MangoTree Publishing	330.00	117	9	2026-09-10 00:00:00	t
497	190	11	PageTurner Indian Polity Handbook (Tiruchirappalli Book Depot)	reference guide to Indian polity and governance. Suitable for everyday Indian household, personal, office, or leisure use.	PageTurner	769.00	42	19	2026-09-12 00:00:00	t
499	190	11	Campus Reads The Mango Orchard (Tiruchirappalli Book Depot)	Indian literary fiction. Suitable for everyday Indian household, personal, office, or leisure use.	Campus Reads	749.00	0	6	2026-10-01 00:00:00	t
501	191	11	PageTurner Data Structures in C++ (Kolkata Book Corner)	data structures and algorithms textbook. Suitable for everyday Indian household, personal, office, or leisure use.	PageTurner	1100.00	17	16	2026-09-28 00:00:00	t
703	137	16	HomeCanvas Curtain Set (Avani Enterprises)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1000.00	140	17	2026-11-10 06:47:52.331634	t
638	71	16	HomeCanvas Water Bottle Set (Srinagar Artisan Collective)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	909.00	32	22	2026-11-10 06:47:52.331634	t
991	1	1	Wireless Mouse	Testing	Logitech	599.00	25	5	2026-11-14 08:29:37.645307	t
534	110	12	WriteWell Whiteboard Marker Set (OfficeOrbit)	low-odour whiteboard markers. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	289.00	91	18	2026-11-10 06:47:52.331634	t
518	24	12	WriteWell Printer Paper 500 Sheets (Omkar Business Solutions)	A4 multipurpose printer paper. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	399.00	87	6	2026-11-10 06:47:52.331634	t
511	9	12	DeskMate Mechanical Pencil Set (Kota Study Store)	mechanical pencils with refills. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	439.00	44	21	2026-09-19 00:00:00	t
537	25	13	TrailBlaze Kettlebell (SportSphere India)	powder-coated fitness kettlebell. Suitable for everyday Indian household, personal, office, or leisure use.	TrailBlaze	3799.00	109	24	2026-11-10 06:47:52.331634	t
516	15	12	PaperTrail Sticky Notes Set (Cuttack Stationery World)	assorted adhesive note pads. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	160.00	0	6	2026-09-12 00:00:00	t
517	24	12	CampusPro A4 Project Notebook (Omkar Business Solutions)	large ruled project notebook. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	169.00	17	19	2026-08-30 00:00:00	t
691	117	16	CasaCraft Wall Decor Set (Aangan Decor)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2149.00	22	8	2026-11-10 06:47:52.331634	t
384	87	10	FarmBasket Toor Dal 1kg (Ananta Marketplace)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	179.00	6	8	2026-11-10 06:47:52.331634	t
526	46	12	PaperTrail Mechanical Pencil Set (Pioneer Office Solutions)	mechanical pencils with refills. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	459.00	92	15	2026-09-09 00:00:00	t
496	140	11	ScholarHouse Signals and Systems (Book World India)	engineering signals and systems textbook. Suitable for everyday Indian household, personal, office, or leisure use.	ScholarHouse	1499.00	90	5	2026-11-10 06:47:52.331634	t
535	110	12	WriteWell A5 Spiral Notebook (OfficeOrbit)	ruled spiral notebook. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	340.00	59	14	2026-09-05 00:00:00	t
536	110	12	CampusPro Gel Pen Pack (OfficeOrbit)	smooth-writing gel pens. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	249.00	38	6	2026-08-31 00:00:00	t
368	75	10	DailyGrain Mixed Nuts 500g (DailyBasket Traders)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	889.00	2	8	2026-11-10 06:47:52.331634	t
541	43	13	FitNation Cricket Bat (FitNation India)	English-willow style cricket bat. Suitable for everyday Indian household, personal, office, or leisure use.	FitNation	8249.00	51	6	2026-09-09 00:00:00	t
544	43	13	PlayField Kettlebell (FitNation India)	powder-coated fitness kettlebell. Suitable for everyday Indian household, personal, office, or leisure use.	PlayField	3199.00	34	9	2026-09-26 00:00:00	t
556	165	13	SportSphere Kettlebell (TrailBlaze Sports)	powder-coated fitness kettlebell. Suitable for everyday Indian household, personal, office, or leisure use.	SportSphere	1300.00	42	7	2026-11-10 06:47:52.331634	t
546	79	13	TrailBlaze Football (Jalandhar Sports Depot)	machine-stitched football. Suitable for everyday Indian household, personal, office, or leisure use.	TrailBlaze	919.00	149	14	2026-08-25 00:00:00	t
542	43	13	ActivePeak Cricket Ball Pack (FitNation India)	practice cricket balls. Suitable for everyday Indian household, personal, office, or leisure use.	ActivePeak	1099.00	44	24	2026-11-10 06:47:52.331634	t
552	97	13	TrailBlaze Fitness Bottle (Meerut Sports Supply)	leak-resistant sports bottle. Suitable for everyday Indian household, personal, office, or leisure use.	TrailBlaze	310.00	40	13	2026-09-22 00:00:00	t
388	91	10	FreshField Multigrain Atta 5kg (Eastern Valley Traders)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	469.00	27	16	2026-11-10 06:47:52.331634	t
554	165	13	ActivePeak Adjustable Dumbbell (TrailBlaze Sports)	adjustable cast-iron dumbbell. Suitable for everyday Indian household, personal, office, or leisure use.	ActivePeak	4000.00	107	24	2026-09-10 00:00:00	t
555	165	13	FitNation Resistance Band Set (TrailBlaze Sports)	multi-resistance fitness bands. Suitable for everyday Indian household, personal, office, or leisure use.	FitNation	1149.00	132	7	2026-09-07 00:00:00	t
557	177	13	FitNation Cricket Ball Pack (TravelTrail India)	practice cricket balls. Suitable for everyday Indian household, personal, office, or leisure use.	FitNation	569.00	42	15	2026-09-29 00:00:00	t
50	57	3	ByteCraft Gaming Laptop (TechTrove India)	dedicated-GPU gaming laptop. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	68099.00	110	11	2026-11-10 06:47:52.331634	t
561	178	14	TinyTots Magnetic Tiles Set (Little Explorers Store)	magnetic construction tile set. Suitable for everyday Indian household, personal, office, or leisure use.	TinyTots	1449.00	11	10	2026-09-28 00:00:00	t
317	7	10	DailyGrain Sugar 5kg (Vijayawada Value Mart)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	289.00	90	12	2026-11-10 06:47:52.331634	t
564	178	14	PlayCraft Wooden Puzzle (Little Explorers Store)	educational wooden puzzle. Suitable for everyday Indian household, personal, office, or leisure use.	PlayCraft	799.00	114	6	2026-11-10 06:47:52.331634	t
413	124	10	FarmBasket Wheat Flour 5kg (Konkan Auto Mart)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	370.00	49	16	2026-11-10 06:47:52.331634	t
574	116	15	RoadReady LED Headlight Bulb (AutoGear India)	automotive LED replacement bulb. Suitable for everyday Indian household, personal, office, or leisure use.	RoadReady	1600.00	68	23	2026-09-13 00:00:00	t
577	138	15	WheelWise Car Air Compressor (Jamshedpur Industrial Supply)	portable tyre inflator. Suitable for everyday Indian household, personal, office, or leisure use.	WheelWise	2949.00	1	23	2026-08-27 00:00:00	t
580	138	15	MotorWorks Car Vacuum Cleaner (Jamshedpur Industrial Supply)	compact 12V car vacuum cleaner. Suitable for everyday Indian household, personal, office, or leisure use.	MotorWorks	3699.00	51	20	2026-11-10 06:47:52.331634	t
591	6	16	NestNook Dinner Set (Shree Ganesh Enterprises)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2549.00	80	17	2026-11-10 06:47:52.331634	t
581	152	15	MotorWorks Car Seat Cover Set (Nagpur Auto Accessories)	universal-fit car seat covers. Suitable for everyday Indian household, personal, office, or leisure use.	MotorWorks	4499.00	0	16	2026-08-24 00:00:00	t
100	41	5	HomeChef Air Fryer 6L (Coastal Kitchenware)	large-capacity digital air fryer. Suitable for everyday Indian household, personal, office, or leisure use.	HomeChef	7300.00	14	6	2026-11-10 06:47:52.331634	t
61	126	3	CoreNova 14-inch Business Laptop (Vellore Tech Point)	business-focused lightweight laptop. Suitable for everyday Indian household, personal, office, or leisure use.	CoreNova	58000.00	138	11	2026-11-10 06:47:52.331634	t
587	176	15	AutoGear Tyre Inflator Gauge (DriveMate Accessories)	digital tyre pressure inflator. Suitable for everyday Indian household, personal, office, or leisure use.	AutoGear	2100.00	83	5	2026-09-07 00:00:00	t
437	148	10	DesiHarvest Breakfast Oats 1kg (Nashik Fresh Basket)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	309.00	106	10	2026-11-10 06:47:52.331634	t
106	98	5	HomeChef Mixer Grinder 1000W (Cookware Collective)	high-power mixer grinder. Suitable for everyday Indian household, personal, office, or leisure use.	HomeChef	5449.00	61	22	2026-11-10 06:47:52.331634	t
594	8	16	TableTop Dinner Set (Imphal Heritage Store)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1449.00	82	16	2026-10-01 00:00:00	t
487	42	11	MangoTree Publishing Modern Indian History (MangoTree Books)	study guide to modern Indian history. Suitable for everyday Indian household, personal, office, or leisure use.	MangoTree Publishing	950.00	96	24	2026-11-10 06:47:52.331634	t
503	191	11	MangoTree Publishing Introduction to Economics (Kolkata Book Corner)	introductory economics textbook. Suitable for everyday Indian household, personal, office, or leisure use.	MangoTree Publishing	480.00	86	12	2026-11-10 06:47:52.331634	t
320	7	10	FreshField Tea 500g (Vijayawada Value Mart)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	239.00	28	13	2026-11-10 06:47:52.331634	t
603	19	16	NestNook Wall Decor Set (Pondicherry Lifestyle Studio)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	949.00	6	8	2026-09-03 00:00:00	t
436	147	10	DailyGrain Tea 500g (Millet House India)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	539.00	112	8	2026-11-10 06:47:52.331634	t
619	35	16	NestNook Stainless Steel Cookware Set (Pragati Retail Works)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	3299.00	68	5	2026-11-10 06:47:52.331634	t
609	28	16	CasaCraft Kitchen Knife Set (Agra Craft Bazaar)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1549.00	10	6	2026-11-10 06:47:52.331634	t
614	33	16	HomeCanvas Wall Decor Set (Thanjavur Art House)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1399.00	113	25	2026-08-31 00:00:00	t
616	33	16	NestNook Bath Towel Set (Thanjavur Art House)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1199.00	146	6	2026-08-24 00:00:00	t
543	43	13	SportSphere Football (FitNation India)	machine-stitched football. Suitable for everyday Indian household, personal, office, or leisure use.	SportSphere	739.00	92	25	2026-11-10 06:47:52.331634	t
618	35	16	KitchenKart Wall Decor Set (Pragati Retail Works)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1899.00	138	18	2026-09-13 00:00:00	t
519	24	12	OfficeOrbit A5 Spiral Notebook (Omkar Business Solutions)	ruled spiral notebook. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	359.00	136	12	2026-11-10 06:47:52.331634	t
151	162	6	TimberLine Office Desk (Lotus Living)	spacious work-from-home desk. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	14500.00	47	22	2026-11-10 06:47:52.331634	t
522	38	12	PaperTrail A4 Project Notebook (SchoolBag Central)	large ruled project notebook. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	309.00	79	19	2026-11-10 06:47:52.331634	t
682	111	16	TableTop Cotton Bedsheet (Tulsi Home Store)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1999.00	9	12	2026-11-10 06:47:52.331634	t
626	58	16	HomeCanvas Bath Towel Set (Aavartan Retail)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	639.00	110	15	2026-08-22 00:00:00	t
628	58	16	KitchenKart Curtain Set (Aavartan Retail)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1449.00	123	19	2026-09-27 00:00:00	t
629	59	16	CasaCraft Wall Decor Set (Heritage Lane)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	509.00	74	13	2026-08-18 00:00:00	t
630	59	16	NestNook Curtain Set (Heritage Lane)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2149.00	124	12	2026-09-01 00:00:00	t
633	64	16	TableTop Dinner Set (Udaipur Decor Studio)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1600.00	60	24	2026-09-30 00:00:00	t
636	64	16	HomeCanvas Non-Stick Fry Pan (Udaipur Decor Studio)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1499.00	91	15	2026-09-07 00:00:00	t
344	39	10	DesiHarvest Wheat Flour 5kg (FreshField Grocers)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	399.00	62	8	2026-11-10 06:47:52.331634	t
502	191	11	Saraswati Press Modern Indian History (Kolkata Book Corner)	study guide to modern Indian history. Suitable for everyday Indian household, personal, office, or leisure use.	Saraswati Press	959.00	111	17	2026-11-10 06:47:52.331634	t
366	75	10	FreshField Basmati Rice 5kg (DailyBasket Traders)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	690.00	30	22	2026-11-10 06:47:52.331634	t
648	73	16	NestNook Storage Basket Set (Kala Kendra)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1299.00	69	12	2026-11-10 06:47:52.331634	t
644	72	16	KitchenKart Storage Basket Set (Crafted in Bharat)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1249.00	59	15	2026-09-05 00:00:00	t
667	99	16	TableTop Kitchen Knife Set (Hubballi Hardware House)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	990.00	149	7	2026-11-10 06:47:52.331634	t
656	85	16	CasaCraft Water Bottle Set (Lakshmi Trading House)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	740.00	12	6	2026-11-10 06:47:52.331634	t
653	85	16	HomeCanvas Kitchen Knife Set (Lakshmi Trading House)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1300.00	144	15	2026-11-10 06:47:52.331634	t
540	25	13	FitNation Yoga Mat (SportSphere India)	non-slip exercise yoga mat. Suitable for everyday Indian household, personal, office, or leisure use.	FitNation	1799.00	65	13	2026-11-10 06:47:52.331634	t
405	115	10	DesiHarvest Filter Coffee 500g (Spice Garden India)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	789.00	80	20	2026-11-10 06:47:52.331634	t
468	187	10	DailyGrain Mixed Nuts 500g (Amrut Foods)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	940.00	147	25	2026-11-10 06:47:52.331634	t
660	94	16	KitchenKart Wall Decor Set (Golden Peacock Crafts)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1599.00	102	25	2026-09-02 00:00:00	t
111	102	5	ChefNest Microwave Oven 20L (KitchenKart India)	solo microwave oven. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	9949.00	147	10	2026-11-10 06:47:52.331634	t
261	18	9	PureBloom Gentle Face Cleanser (Neem & Co.)	mild daily facial cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	259.00	138	20	2026-11-10 06:47:52.331634	t
665	99	16	HomeCanvas Glass Storage Container Set (Hubballi Hardware House)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	859.00	100	10	2026-09-17 00:00:00	t
221	167	7	ThreadCraft Women's Cotton Kurta (Desi Drapes)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	960.00	53	22	2026-11-10 06:47:52.331634	t
351	52	10	FreshField Mixed Nuts 500g (Farm2Shelf Market)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	820.00	126	8	2026-11-10 06:47:52.331634	t
680	108	16	KitchenKart Non-Stick Fry Pan (Banjara Crafts)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	819.00	85	11	2026-10-01 00:00:00	t
681	111	16	KitchenKart Water Bottle Set (Tulsi Home Store)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	450.00	2	10	2026-09-02 00:00:00	t
102	90	5	ChefNest Induction Cooktop (Kitchen Canvas)	portable induction cooktop. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	1899.00	136	21	2026-11-10 06:47:52.331634	t
357	61	10	DesiHarvest Multigrain Atta 5kg (Narmada Marketplace)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	290.00	121	16	2026-11-10 06:47:52.331634	t
689	117	16	TableTop Storage Basket Set (Aangan Decor)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	479.00	128	9	2026-09-27 00:00:00	t
480	197	10	DailyGrain Sugar 5kg (Asansol Home Market)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	220.00	80	20	2026-11-10 06:47:52.331634	t
18	130	1	Zenith 43-inch 4K Smart TV (Surya Enterprises)	4K HDR smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	46599.00	99	19	2026-11-10 06:47:52.331634	t
695	127	16	CasaCraft Water Bottle Set (Bharat Artisan House)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	490.00	66	14	2026-08-22 00:00:00	t
697	129	16	NestNook Cotton Bedsheet (Abhivyakti Arts)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	970.00	87	15	2026-09-26 00:00:00	t
38	118	2	MobiOne USB-C Braided Cable (MobileMania Store)	durable USB-C charging cable. Suitable for everyday Indian household, personal, office, or leisure use.	MobiOne	749.00	19	21	2026-11-10 06:47:52.331634	t
702	137	16	KitchenKart Storage Basket Set (Avani Enterprises)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	810.00	19	16	2026-08-22 00:00:00	t
642	72	16	HomeCanvas Curtain Set (Crafted in Bharat)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	709.00	68	13	2026-11-10 06:47:52.331634	t
266	27	9	GlowNest Daily Moisturizer (GlowNest Beauty)	lightweight daily moisturizer. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	430.00	134	8	2026-11-10 06:47:52.331634	t
706	149	16	HomeCanvas Glass Storage Container Set (Dharohar India)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1349.00	14	8	2026-08-29 00:00:00	t
733	192	16	KitchenKart Stainless Steel Cookware Set (Godavari Home Store)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	6799.00	4	8	2026-11-10 06:47:52.331634	t
729	186	16	TableTop Storage Basket Set (Rangoli Home Studio)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	919.00	74	9	2026-11-10 06:47:52.331634	t
718	175	16	KitchenKart Non-Stick Fry Pan (Varanasi Heritage)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1449.00	1	5	2026-11-10 06:47:52.331634	t
712	157	16	CasaCraft Kitchen Knife Set (CasaCraft India)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1699.00	2	15	2026-09-11 00:00:00	t
738	194	16	NestNook Stainless Steel Cookware Set (Puri Coastal Crafts)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	4500.00	1	8	2026-11-10 06:47:52.331634	t
123	1	6	TimberLine Bookshelf (Banyan Tree Living)	multi-shelf storage bookcase. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	6849.00	155	17	2026-11-14 11:08:23.341872	t
715	164	16	NestNook Bath Towel Set (Made in India Store)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1200.00	1	21	2026-09-03 00:00:00	t
716	164	16	HomeCanvas Kitchen Knife Set (Made in India Store)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1500.00	52	23	2026-08-18 00:00:00	t
615	33	16	TableTop Curtain Set (Thanjavur Art House)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	2049.00	64	18	2026-11-10 06:47:52.331634	t
492	65	11	MangoTree Publishing Python Programming (Saraswati Book House)	practical Python programming guide. Suitable for everyday Indian household, personal, office, or leisure use.	MangoTree Publishing	659.00	88	6	2026-11-10 06:47:52.331634	t
724	179	16	NestNook Non-Stick Fry Pan (Sundar Handicrafts)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	579.00	7	12	2026-09-17 00:00:00	t
725	181	16	CasaCraft Cotton Bedsheet (Jaipur Craft House)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1900.00	118	5	2026-08-27 00:00:00	t
726	181	16	TableTop Kitchen Knife Set (Jaipur Craft House)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	779.00	128	10	2026-09-16 00:00:00	t
727	181	16	KitchenKart Dinner Set (Jaipur Craft House)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	830.00	123	15	2026-09-26 00:00:00	t
441	150	10	FarmBasket Toor Dal 1kg (ValueKart India)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	150.00	43	16	2026-11-10 06:47:52.331634	t
730	186	16	HomeCanvas Cotton Bedsheet (Rangoli Home Studio)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1449.00	11	15	2026-09-06 00:00:00	t
731	186	16	KitchenKart Bath Towel Set (Rangoli Home Studio)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	949.00	135	10	2026-09-23 00:00:00	t
545	79	13	PlayField Badminton Racket (Jalandhar Sports Depot)	lightweight badminton racket. Suitable for everyday Indian household, personal, office, or leisure use.	PlayField	1449.00	41	22	2026-11-10 06:47:52.331634	t
589	6	16	CasaCraft Non-Stick Fry Pan (Shree Ganesh Enterprises)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1349.00	8	12	2026-11-10 06:47:52.331634	t
161	17	7	ThreadCraft Women's Cotton Kurta (Sari Street)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1799.00	125	14	2026-11-10 06:47:52.331634	t
736	192	16	HomeCanvas Wall Decor Set (Godavari Home Store)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1700.00	146	21	2026-09-01 00:00:00	t
737	194	16	TableTop Glass Storage Container Set (Puri Coastal Crafts)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1999.00	120	7	2026-09-11 00:00:00	t
741	198	16	TableTop Cotton Bedsheet (Sahyadri Goods)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1399.00	84	13	2026-10-01 00:00:00	t
742	198	16	KitchenKart Water Bottle Set (Sahyadri Goods)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	589.00	64	12	2026-09-15 00:00:00	t
743	198	16	CasaCraft Bath Towel Set (Sahyadri Goods)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	860.00	96	17	2026-08-24 00:00:00	t
749	32	17	TravelTrail Travel Duffle Bag (Himalayan Travel Gear)	spacious travel duffle bag. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	3399.00	95	20	2026-11-10 06:47:52.331634	t
442	150	10	DailyGrain Basmati Rice 5kg (ValueKart India)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	759.00	47	5	2026-11-10 06:47:52.331634	t
378	83	10	FarmBasket Filter Coffee 500g (Dastkari Bazaar)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	570.00	3	14	2026-11-10 06:47:52.331634	t
617	35	16	KitchenKart Non-Stick Fry Pan (Pragati Retail Works)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	789.00	10	17	2026-11-10 06:47:52.331634	t
408	115	10	FarmBasket Sugar 5kg (Spice Garden India)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	309.00	121	20	2026-11-10 06:47:52.331634	t
753	48	17	NomadGear Packing Cube Set (Mangalore Coastal Goods)	multi-size packing organiser set. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	1100.00	101	21	2026-09-03 00:00:00	t
714	164	16	TableTop Curtain Set (Made in India Store)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1699.00	147	16	2026-11-10 06:47:52.331634	t
757	63	17	CarryOn Foldable Travel Backpack (Kochi Travel Store)	lightweight foldable daypack. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	990.00	118	9	2026-09-26 00:00:00	t
212	131	7	UrbanWeave Unisex Hoodie (Urban Loom)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1900.00	77	11	2026-11-10 06:47:52.331634	t
446	153	10	FarmBasket Sugar 5kg (Coconut Grove Goods)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	300.00	10	9	2026-11-10 06:47:52.331634	t
760	63	17	CarryOn Cabin Trolley Bag (Kochi Travel Store)	compact cabin-size trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	5100.00	120	21	2026-09-23 00:00:00	t
528	46	12	DeskMate Desk Organizer (Pioneer Office Solutions)	multi-compartment desk organizer. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	350.00	5	16	2026-11-10 06:47:52.331634	t
764	81	17	TravelTrail Medium Trolley Bag (Guwahati Outdoor Store)	medium hard-shell trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	3549.00	47	18	2026-08-20 00:00:00	t
500	190	11	PageTurner Everyday Indian Cooking (Tiruchirappalli Book Depot)	Indian home-cooking recipe collection. Suitable for everyday Indian household, personal, office, or leisure use.	PageTurner	990.00	99	16	2026-11-10 06:47:52.331634	t
767	132	17	RoamReady Passport Holder (Dehradun Adventure Shop)	travel document organiser. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	550.00	140	12	2026-09-04 00:00:00	t
768	132	17	Voyage Packing Cube Set (Dehradun Adventure Shop)	multi-size packing organiser set. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	620.00	81	23	2026-09-01 00:00:00	t
590	6	16	KitchenKart Glass Storage Container Set (Shree Ganesh Enterprises)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1100.00	111	6	2026-11-10 06:47:52.331634	t
772	136	17	TravelTrail Toiletry Travel Kit (Panaji Beachside Retail)	compact travel toiletry organiser. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	329.00	124	8	2026-09-04 00:00:00	t
699	129	16	HomeCanvas Water Bottle Set (Abhivyakti Arts)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	460.00	141	8	2026-11-10 06:47:52.331634	t
337	31	10	DesiHarvest Basmati Rice 5kg (Kaveri Traders)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	520.00	122	7	2026-11-10 06:47:52.331634	t
776	151	17	Voyage Foldable Travel Backpack (Shillong Mountain Goods)	lightweight foldable daypack. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	1000.00	144	11	2026-09-13 00:00:00	t
777	159	17	RoamReady Laptop Backpack (RoamReady)	padded laptop travel backpack. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	1400.00	131	6	2026-08-29 00:00:00	t
793	106	18	TailWaggers Adult Dog Food 3kg (PetPal Supplies)	complete dry food for adult dogs. Suitable for everyday Indian household, personal, office, or leisure use.	TailWaggers	1299.00	81	18	2026-11-10 06:47:52.331634	t
781	29	18	PetNest Adult Dog Food 3kg (StyleStreet Retail)	complete dry food for adult dogs. Suitable for everyday Indian household, personal, office, or leisure use.	PetNest	1549.00	95	18	2026-09-29 00:00:00	t
783	29	18	FurryFriends Adult Cat Food 2kg (StyleStreet Retail)	complete dry food for adult cats. Suitable for everyday Indian household, personal, office, or leisure use.	FurryFriends	769.00	69	7	2026-09-03 00:00:00	t
784	29	18	TailWaggers Cat Litter 5kg (StyleStreet Retail)	clumping cat litter. Suitable for everyday Indian household, personal, office, or leisure use.	TailWaggers	480.00	149	25	2026-09-22 00:00:00	t
592	6	16	HomeCanvas Stainless Steel Cookware Set (Shree Ganesh Enterprises)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	3049.00	15	13	2026-11-10 06:47:52.331634	t
751	32	17	Voyage Passport Holder (Himalayan Travel Gear)	travel document organiser. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	480.00	55	21	2026-11-10 06:47:52.331634	t
650	82	16	TableTop Water Bottle Set (Astitva Creations)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	970.00	11	17	2026-11-10 06:47:52.331634	t
791	89	18	Pawfect Pet Bed (Ghaziabad Retail Works)	washable padded pet bed. Suitable for everyday Indian household, personal, office, or leisure use.	Pawfect	1899.00	125	19	2026-09-02 00:00:00	t
244	50	8	UrbanSole Men's Walking Shoes (Walkway Footwear)	cushioned walking shoes. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanSole	4649.00	147	17	2026-11-10 06:47:52.331634	t
795	106	18	FurryFriends Pet Bed (PetPal Supplies)	washable padded pet bed. Suitable for everyday Indian household, personal, office, or leisure use.	FurryFriends	1249.00	72	13	2026-09-14 00:00:00	t
42	169	2	NexCell 5G Smartphone 128GB (Mumbai Mobile Hub)	5G smartphone with 128GB storage. Suitable for everyday Indian household, personal, office, or leisure use.	NexCell	23599.00	61	17	2026-11-10 06:47:52.331634	t
722	179	16	CasaCraft Glass Storage Container Set (Sundar Handicrafts)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1900.00	113	23	2026-11-10 06:47:52.331634	t
367	75	10	FarmBasket Sona Masoori Rice 5kg (DailyBasket Traders)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	379.00	35	7	2026-11-10 06:47:52.331634	t
756	48	17	CarryOn Passport Holder (Mangalore Coastal Goods)	travel document organiser. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	519.00	67	23	2026-11-10 06:47:52.331634	t
152	162	6	CasaCraft Accent Chair (Lotus Living)	upholstered accent chair. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	12099.00	11	23	2026-11-10 06:47:52.331634	t
329	14	10	FreshField Wheat Flour 5kg (Raipur Retail Hub)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	289.00	11	8	2026-11-10 06:47:52.331634	t
231	173	7	CottonRoot Men's Cotton T-Shirt (Modern Muse Apparel)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	1099.00	36	10	2026-11-10 06:47:25.783141	t
194	86	7	ThreadCraft Women's Casual Top (Madurai Textile Works)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1399.00	53	20	2026-10-11 13:53:19.221477	t
110	102	5	KitchPro Air Fryer 4L (KitchenKart India)	digital hot-air fryer. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	6300.00	59	16	2026-11-10 06:47:25.783141	t
717	175	16	HomeCanvas Storage Basket Set (Varanasi Heritage)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	590.00	25	22	2026-11-10 06:47:25.783141	t
327	11	10	DesiHarvest Moong Dal 1kg (PureHarvest Foods)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	249.00	21	9	2026-11-10 06:47:25.783141	t
748	13	17	CarryOn Laptop Backpack (Siliguri Travel Goods)	padded laptop travel backpack. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	4349.00	52	16	2026-11-10 06:47:25.783141	t
81	133	4	AeroHome Tower Fan (Ahmedabad Appliance Centre)	oscillating tower fan. Suitable for everyday Indian household, personal, office, or leisure use.	AeroHome	2599.00	146	11	2026-11-10 06:47:25.783141	t
578	138	15	MotorWorks Car Sunshade (Jamshedpur Industrial Supply)	foldable windshield sunshade. Suitable for everyday Indian household, personal, office, or leisure use.	MotorWorks	519.00	69	18	2026-11-10 06:47:52.331634	t
439	148	10	PureHarvest Mixed Nuts 500g (Nashik Fresh Basket)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	910.00	102	21	2026-11-10 06:47:52.331634	t
788	49	18	Pawfect Dog Collar (Krishna Retail)	adjustable pet collar. Suitable for everyday Indian household, personal, office, or leisure use.	Pawfect	629.00	81	23	2026-11-10 06:47:52.331634	t
298	155	9	SattvaSkin Sunscreen SPF 50 (Aranya Naturals)	broad-spectrum sunscreen. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	879.00	5	24	2026-11-10 06:47:52.331634	t
486	42	11	PageTurner Database Systems (MangoTree Books)	academic introduction to database systems. Suitable for everyday Indian household, personal, office, or leisure use.	PageTurner	789.00	13	9	2026-11-10 06:47:52.331634	t
663	95	16	NestNook Non-Stick Fry Pan (Mitti & More)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1099.00	28	25	2026-11-10 06:47:52.331634	t
758	63	17	Voyage Toiletry Travel Kit (Kochi Travel Store)	compact travel toiletry organiser. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	470.00	64	15	2026-11-10 06:47:52.331634	t
165	26	7	IndigoLane Unisex Hoodie (The Wardrobe Co)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1249.00	63	15	2026-11-10 06:47:52.331634	t
688	113	16	KitchenKart Curtain Set (Saffron Homeware)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1699.00	94	14	2026-11-10 06:47:25.783141	t
294	144	9	PureBloom Daily Moisturizer (Earth & Earthy)	lightweight daily moisturizer. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	1099.00	9	18	2026-11-10 06:47:25.783141	t
96	16	5	ChefNest Air Fryer 6L (Kerala Kitchen)	large-capacity digital air fryer. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	6049.00	139	7	2026-11-10 06:47:25.783141	t
421	141	10	DailyGrain Breakfast Oats 1kg (Delhi Daily Mart)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	250.00	142	23	2026-11-10 06:47:25.783141	t
302	161	9	SattvaSkin Body Lotion (Beauty Basket India)	daily hydrating body lotion. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	580.00	47	23	2026-11-10 06:47:25.783141	t
23	160	1	Zenith Soundbar 2.1 Channel (Aarav Ventures)	wireless home theatre soundbar. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	13049.00	88	19	2026-11-10 06:47:25.783141	t
559	177	13	SportSphere Badminton Racket (TravelTrail India)	lightweight badminton racket. Suitable for everyday Indian household, personal, office, or leisure use.	SportSphere	1449.00	47	22	2026-11-10 06:47:25.783141	t
184	55	7	EthnicEdit Women's Saree (Ethnic Edit)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	4300.00	121	19	2026-11-10 06:47:52.331634	t
93	16	5	KitchPro Mixer Grinder 1000W (Kerala Kitchen)	high-power mixer grinder. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	5749.00	2	5	2026-11-10 06:47:52.331634	t
551	97	13	TrailBlaze Yoga Mat (Meerut Sports Supply)	non-slip exercise yoga mat. Suitable for everyday Indian household, personal, office, or leisure use.	TrailBlaze	889.00	34	12	2026-11-10 06:47:52.331634	t
25	200	1	Nexon True Wireless Earbuds (Dhanbad Electronics Point)	wireless in-ear audio earbuds. Suitable for everyday Indian household, personal, office, or leisure use.	Nexon	3199.00	26	19	2026-11-10 06:47:52.331634	t
173	37	7	IndigoLane Men's Formal Shirt (Marigold Collections)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1600.00	38	10	2026-11-10 06:47:52.331634	t
334	23	10	DailyGrain Tea 500g (QuickCart Enterprises)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	610.00	143	6	2026-11-10 06:47:52.331634	t
48	36	3	ByteCraft 14-inch Student Laptop (NCR Tech Traders)	portable laptop for everyday study and office work. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	52500.00	127	20	2026-11-10 06:47:52.331634	t
450	156	10	DesiHarvest Tea 500g (ChoicePoint Marketplace)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	499.00	109	20	2026-11-10 06:47:52.331634	t
507	2	12	WriteWell Gel Pen Pack (OfficeCraft Solutions)	smooth-writing gel pens. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	170.00	129	19	2026-11-10 06:47:52.331634	t
406	115	10	PureHarvest Tea 500g (Spice Garden India)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	210.00	46	8	2026-11-10 06:47:52.331634	t
452	156	10	FreshField Mixed Nuts 500g (ChoicePoint Marketplace)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	560.00	7	20	2026-11-10 06:47:52.331634	t
407	115	10	DailyGrain Mixed Nuts 500g (Spice Garden India)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	1000.00	83	17	2026-11-10 06:47:52.331634	t
508	2	12	OfficeOrbit Ball Pen Pack (OfficeCraft Solutions)	everyday ball pens. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	239.00	115	13	2026-11-10 06:47:52.331634	t
687	113	16	NestNook Storage Basket Set (Saffron Homeware)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	690.00	74	7	2026-11-10 06:47:52.331634	t
92	189	4	HomeZen Double Door Refrigerator (Faridabad Home Centre)	frost-free double-door refrigerator. Suitable for everyday Indian household, personal, office, or leisure use.	HomeZen	48599.00	7	21	2026-11-10 06:47:52.331634	t
720	175	16	CasaCraft Curtain Set (Varanasi Heritage)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1900.00	74	9	2026-11-10 06:47:52.331634	t
746	13	17	Voyage Large Trolley Bag (Siliguri Travel Goods)	large check-in trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	5349.00	67	18	2026-11-10 06:47:25.783141	t
276	62	9	VedaGlow Vitamin C Face Serum (Sattva Naturals)	brightening facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	589.00	132	20	2026-11-10 06:47:25.783141	t
216	154	7	EthnicEdit Kids' Cotton T-Shirt (Surat Textile House)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	510.00	7	24	2026-11-10 06:47:25.783141	t
346	47	10	PureHarvest Tea 500g (Rajdhani Traders)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	330.00	138	9	2026-11-10 06:47:25.783141	t
684	111	16	NestNook Kitchen Knife Set (Tulsi Home Store)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	960.00	18	11	2026-11-10 06:47:25.783141	t
582	152	15	AutoGear Microfiber Cleaning Kit (Nagpur Auto Accessories)	automotive cleaning cloth kit. Suitable for everyday Indian household, personal, office, or leisure use.	AutoGear	310.00	104	5	2026-11-10 06:47:25.783141	t
789	89	18	PetNest Pet Feeding Bowl (Ghaziabad Retail Works)	stainless steel feeding bowl. Suitable for everyday Indian household, personal, office, or leisure use.	PetNest	480.00	38	9	2026-11-10 06:47:25.783141	t
246	88	8	SoleStory Women's Running Shoes (Footprint Footwear)	lightweight women's running shoes. Suitable for everyday Indian household, personal, office, or leisure use.	SoleStory	5299.00	21	25	2026-11-10 06:47:52.331634	t
744	198	16	NestNook Kitchen Knife Set (Sahyadri Goods)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1599.00	107	10	2026-11-10 06:47:52.331634	t
584	152	15	RoadReady Car Air Compressor (Nagpur Auto Accessories)	portable tyre inflator. Suitable for everyday Indian household, personal, office, or leisure use.	RoadReady	3799.00	82	9	2026-11-10 06:47:52.331634	t
575	116	15	DriveMate Emergency Roadside Kit (AutoGear India)	basic vehicle emergency kit. Suitable for everyday Indian household, personal, office, or leisure use.	DriveMate	1299.00	71	10	2026-11-10 06:47:52.331634	t
22	160	1	VistaCore True Wireless Earbuds (Aarav Ventures)	wireless in-ear audio earbuds. Suitable for everyday Indian household, personal, office, or leisure use.	VistaCore	13500.00	147	20	2026-11-10 06:47:52.331634	t
30	44	2	MobiOne 5G Smartphone 256GB (Gadget Grove)	5G smartphone with 256GB storage. Suitable for everyday Indian household, personal, office, or leisure use.	MobiOne	25500.00	14	20	2026-11-10 06:47:52.331634	t
373	80	10	PureHarvest Multigrain Atta 5kg (Maa Durga Enterprises)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	449.00	54	5	2026-11-10 06:47:52.331634	t
700	129	16	KitchenKart Kitchen Knife Set (Abhivyakti Arts)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1000.00	33	12	2026-11-10 06:47:25.783141	t
135	119	6	CasaCraft Office Chair (Mysuru Furnishings)	ergonomic adjustable office chair. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	16549.00	139	20	2026-11-10 06:47:25.783141	t
728	181	16	NestNook Water Bottle Set (Jaipur Craft House)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	480.00	148	21	2026-11-10 06:47:25.783141	t
649	82	16	KitchenKart Glass Storage Container Set (Astitva Creations)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	610.00	21	20	2026-11-10 06:47:25.783141	t
267	27	9	AuraCare Sunscreen SPF 50 (GlowNest Beauty)	broad-spectrum sunscreen. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	1249.00	68	21	2026-11-10 06:47:25.783141	t
586	176	15	RoadReady Bike Cover (DriveMate Accessories)	water-resistant motorcycle cover. Suitable for everyday Indian household, personal, office, or leisure use.	RoadReady	1499.00	62	25	2026-11-10 06:47:25.783141	t
477	197	10	FreshField Tea 500g (Asansol Home Market)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	679.00	24	17	2026-11-10 06:47:25.783141	t
800	180	18	PetNest Puppy Food 3kg (PetNest Supplies)	balanced dry food for puppies. Suitable for everyday Indian household, personal, office, or leisure use.	PetNest	649.00	116	6	2026-11-10 06:47:52.331634	t
482	199	10	DesiHarvest Mixed Nuts 500g (Warangal Daily Needs)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	830.00	66	23	2026-11-10 06:47:52.331634	t
197	114	7	ThreadCraft Kids' Cotton T-Shirt (Lucknow Lifestyle)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	819.00	5	8	2026-11-10 06:47:52.331634	t
635	64	16	KitchenKart Stainless Steel Cookware Set (Udaipur Decor Studio)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	4099.00	79	23	2026-11-10 06:47:52.331634	t
430	145	10	FarmBasket Multigrain Atta 5kg (Thiruvananthapuram Green Store)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	279.00	94	9	2026-11-10 06:47:52.331634	t
646	73	16	TableTop Wall Decor Set (Kala Kendra)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	2399.00	84	21	2026-10-11 13:53:19.221477	t
47	36	3	CoreNova 15.6-inch Creator Laptop (NCR Tech Traders)	laptop designed for creative workloads. Suitable for everyday Indian household, personal, office, or leisure use.	CoreNova	112599.00	123	12	2026-10-11 13:53:19.221477	t
576	116	15	MotorWorks Car Dashboard Cleaner (AutoGear India)	interior dashboard cleaning kit. Suitable for everyday Indian household, personal, office, or leisure use.	MotorWorks	289.00	39	15	2026-11-10 06:47:52.331634	t
761	81	17	CarryOn Travel Duffle Bag (Guwahati Outdoor Store)	spacious travel duffle bag. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	1599.00	97	22	2026-11-10 06:47:52.331634	t
49	57	3	CoreNova 27-inch QHD Monitor (TechTrove India)	QHD IPS desktop monitor. Suitable for everyday Indian household, personal, office, or leisure use.	CoreNova	30049.00	137	18	2026-11-10 06:47:52.331634	t
77	92	4	AeroHome Top Load Washing Machine (Salem Appliance House)	fully automatic top-load washing machine. Suitable for everyday Indian household, personal, office, or leisure use.	AeroHome	29500.00	114	8	2026-11-10 06:47:52.331634	t
80	92	4	HomeZen 1.5 Ton Split AC (Salem Appliance House)	inverter split air conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	HomeZen	53049.00	89	12	2026-11-10 06:47:52.331634	t
348	47	10	DesiHarvest Filter Coffee 500g (Rajdhani Traders)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	530.00	13	21	2026-11-10 06:47:52.331634	t
566	60	15	MotorWorks Microfiber Cleaning Kit (RoadReady Auto)	automotive cleaning cloth kit. Suitable for everyday Indian household, personal, office, or leisure use.	MotorWorks	469.00	94	9	2026-11-10 06:47:52.331634	t
600	12	16	CasaCraft Curtain Set (Karigar Collective)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1800.00	99	23	2026-11-10 06:47:52.331634	t
31	44	2	Voltix AMOLED Smartphone 256GB (Gadget Grove)	AMOLED display smartphone. Suitable for everyday Indian household, personal, office, or leisure use.	Voltix	49599.00	9	14	2026-11-10 06:47:25.783141	t
233	193	7	IndigoLane Men's Formal Shirt (WeaveWorks India)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1000.00	62	7	2026-11-10 06:47:25.783141	t
567	60	15	RoadReady Car Vacuum Cleaner (RoadReady Auto)	compact 12V car vacuum cleaner. Suitable for everyday Indian household, personal, office, or leisure use.	RoadReady	2000.00	15	21	2026-11-10 06:47:25.783141	t
104	90	5	KitchPro OTG 30L (Kitchen Canvas)	countertop oven toaster grill. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	8100.00	104	22	2026-10-11 13:53:19.221477	t
15	112	1	Nexon Action Camera (Visakhapatnam Electronics)	compact 4K action camera. Suitable for everyday Indian household, personal, office, or leisure use.	Nexon	44049.00	92	22	2026-11-10 06:47:25.783141	t
109	102	5	SpiceMate Air Fryer 6L (KitchenKart India)	large-capacity digital air fryer. Suitable for everyday Indian household, personal, office, or leisure use.	SpiceMate	7600.00	147	20	2026-11-10 06:47:25.783141	t
787	49	18	FurryFriends Pet Grooming Brush (Krishna Retail)	deshedding grooming brush. Suitable for everyday Indian household, personal, office, or leisure use.	FurryFriends	870.00	5	13	2026-11-10 06:47:25.783141	t
621	45	16	NestNook Kitchen Knife Set (Rajputana Handicrafts)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1499.00	44	24	2026-11-10 06:47:52.331634	t
533	110	12	OfficeOrbit A4 Project Notebook (OfficeOrbit)	large ruled project notebook. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	160.00	53	22	2026-11-10 06:47:52.331634	t
275	62	9	PureBloom Body Lotion (Sattva Naturals)	daily hydrating body lotion. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	710.00	137	8	2026-11-10 06:47:52.331634	t
142	121	6	UrbanNest Shoe Rack (Furniture Foundry)	multi-tier shoe storage unit. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	5399.00	25	20	2026-11-10 06:47:52.331634	t
289	122	9	SattvaSkin Gentle Face Cleanser (Prakruti Organics)	mild daily facial cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	SattvaSkin	830.00	31	7	2026-11-10 06:47:52.331634	t
5	40	1	Auralis Soundbar 2.1 Channel (SmartBuy Junction)	wireless home theatre soundbar. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	19099.00	129	18	2026-11-10 06:47:52.331634	t
309	4	10	FarmBasket Basmati Rice 5kg (BharatMart)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	629.00	39	23	2026-11-10 06:47:52.331634	t
393	100	10	FreshField Filter Coffee 500g (Malabar Essentials)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	869.00	137	7	2026-11-10 06:47:25.783141	t
483	199	10	DailyGrain Breakfast Oats 1kg (Warangal Daily Needs)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	159.00	120	20	2026-11-10 06:47:25.783141	t
90	189	4	ArcticNest Front Load Washing Machine (Faridabad Home Centre)	fully automatic front-load washing machine. Suitable for everyday Indian household, personal, office, or leisure use.	ArcticNest	37000.00	5	17	2026-11-10 06:47:25.783141	t
34	78	2	Astra 20W USB-C Charger (Bengaluru Gadget Works)	compact USB-C fast charger. Suitable for everyday Indian household, personal, office, or leisure use.	Astra	500.00	25	18	2026-11-10 06:47:25.783141	t
780	159	17	TravelTrail Large Trolley Bag (RoamReady)	large check-in trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	8249.00	5	13	2026-11-10 06:47:25.783141	t
623	45	16	KitchenKart Water Bottle Set (Rajputana Handicrafts)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	870.00	2	15	2026-11-10 06:47:52.331634	t
498	190	11	ScholarHouse Modern Indian History (Tiruchirappalli Book Depot)	study guide to modern Indian history. Suitable for everyday Indian household, personal, office, or leisure use.	ScholarHouse	789.00	123	7	2026-11-10 06:47:52.331634	t
268	27	9	PureBloom Anti-Dandruff Shampoo (GlowNest Beauty)	anti-dandruff hair cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	829.00	96	21	2026-11-10 06:47:52.331634	t
505	2	12	PaperTrail A5 Spiral Notebook (OfficeCraft Solutions)	ruled spiral notebook. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	229.00	44	9	2026-11-10 06:47:52.331634	t
604	19	16	NestNook Non-Stick Fry Pan (Pondicherry Lifestyle Studio)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	919.00	48	19	2026-11-10 06:47:52.331634	t
532	96	12	PaperTrail Printer Paper 500 Sheets (Patna Stationery Hub)	A4 multipurpose printer paper. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	360.00	72	10	2026-11-10 06:47:52.331634	t
162	17	7	UrbanWeave Women's Casual Top (Sari Street)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1200.00	23	22	2026-11-10 06:47:52.331634	t
562	178	14	WonderBox Building Blocks Set (Little Explorers Store)	colourful construction blocks. Suitable for everyday Indian household, personal, office, or leisure use.	WonderBox	1249.00	6	7	2026-11-10 06:47:52.331634	t
530	96	12	CampusPro Sticky Notes Set (Patna Stationery Hub)	assorted adhesive note pads. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	310.00	133	5	2026-11-10 06:47:52.331634	t
324	10	10	FreshField Sona Masoori Rice 5kg (Ganga Enterprises)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	520.00	59	21	2026-11-10 06:47:52.331634	t
466	187	10	FreshField Breakfast Oats 1kg (Amrut Foods)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	220.00	34	25	2026-11-10 06:47:25.783141	t
326	11	10	DailyGrain Wheat Flour 5kg (PureHarvest Foods)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	489.00	76	14	2026-11-10 06:47:25.783141	t
524	38	12	DeskMate Gel Pen Pack (SchoolBag Central)	smooth-writing gel pens. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	80.00	13	20	2026-11-13 16:43:59.964014	t
627	58	16	CasaCraft Cotton Bedsheet (Aavartan Retail)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2100.00	107	17	2026-11-10 06:47:25.783141	t
579	138	15	AutoGear Emergency Roadside Kit (Jamshedpur Industrial Supply)	basic vehicle emergency kit. Suitable for everyday Indian household, personal, office, or leisure use.	AutoGear	1400.00	51	14	2026-11-10 06:47:25.783141	t
198	114	7	ThreadCraft Men's Cotton T-Shirt (Lucknow Lifestyle)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	869.00	7	14	2026-11-10 06:47:25.783141	t
113	142	5	HomeChef Microwave Oven 20L (HomeChef Depot)	solo microwave oven. Suitable for everyday Indian household, personal, office, or leisure use.	HomeChef	9399.00	127	23	2026-11-10 06:47:25.783141	t
607	20	16	HomeCanvas Glass Storage Container Set (Virasat India)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1249.00	8	9	2026-11-10 06:47:25.783141	t
462	183	10	DailyGrain Multigrain Atta 5kg (Rajkot Machine Mart)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	439.00	148	5	2026-11-10 06:47:25.783141	t
469	188	10	FarmBasket Basmati Rice 5kg (Prime Choice Retail)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	610.00	9	15	2026-11-10 06:47:52.331634	t
180	51	7	EthnicEdit Women's Cotton Kurta (Riwaayat Collections)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	820.00	111	16	2026-11-10 06:47:52.331634	t
778	159	17	CarryOn Weekender Bag (RoamReady)	compact weekend travel bag. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	2199.00	96	22	2026-11-10 06:47:52.331634	t
763	81	17	Voyage Laptop Backpack (Guwahati Outdoor Store)	padded laptop travel backpack. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	2499.00	124	13	2026-11-10 06:47:52.331634	t
798	180	18	FurryFriends Cat Litter 5kg (PetNest Supplies)	clumping cat litter. Suitable for everyday Indian household, personal, office, or leisure use.	FurryFriends	880.00	39	12	2026-11-10 06:47:52.331634	t
457	182	10	FreshField Toor Dal 1kg (Amravati General Store)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	209.00	49	23	2026-11-10 06:47:52.331634	t
179	51	7	IndigoLane Women's Casual Top (Riwaayat Collections)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1449.00	2	19	2026-11-10 06:47:52.331634	t
625	58	16	TableTop Kitchen Knife Set (Aavartan Retail)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1349.00	81	13	2026-11-10 06:47:52.331634	t
387	91	10	DesiHarvest Moong Dal 1kg (Eastern Valley Traders)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	220.00	67	19	2026-11-10 06:47:52.331634	t
380	83	10	FreshField Tea 500g (Dastkari Bazaar)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	319.00	142	11	2026-11-10 06:47:52.331634	t
36	78	2	Pixelra Budget 5G Smartphone (Bengaluru Gadget Works)	value-oriented 5G smartphone. Suitable for everyday Indian household, personal, office, or leisure use.	Pixelra	16549.00	97	21	2026-11-10 06:47:25.783141	t
121	1	1	wireless	Updated wireless mouse	Logitech	640.00	30	1	2026-11-14 08:54:20.035034	f
245	88	8	WalkMate Women's Ballet Flats (Footprint Footwear)	comfortable flat footwear. Suitable for everyday Indian household, personal, office, or leisure use.	WalkMate	869.00	51	8	2026-11-10 06:47:25.783141	t
154	170	6	Woodora Computer Table (Chandigarh Living)	compact computer workstation. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	4699.00	110	12	2026-11-10 06:47:25.783141	t
774	151	17	Voyage Cabin Trolley Bag (Shillong Mountain Goods)	compact cabin-size trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	2999.00	79	7	2026-11-10 06:47:25.783141	t
403	109	10	FreshField Sugar 5kg (Indus Mercantile)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	240.00	10	14	2026-10-11 13:53:19.221477	t
739	194	16	HomeCanvas Water Bottle Set (Puri Coastal Crafts)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	769.00	50	7	2026-11-10 06:47:52.331634	t
637	71	16	KitchenKart Kitchen Knife Set (Srinagar Artisan Collective)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1749.00	137	7	2026-11-10 06:47:52.331634	t
670	103	16	KitchenKart Bath Towel Set (HomeHive India)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	859.00	16	19	2026-11-10 06:47:52.331634	t
759	63	17	NomadGear Medium Trolley Bag (Kochi Travel Store)	medium hard-shell trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	6349.00	28	11	2026-11-10 06:47:52.331634	t
395	100	10	PureHarvest Breakfast Oats 1kg (Malabar Essentials)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	230.00	107	17	2026-11-10 06:47:52.331634	t
461	183	10	FarmBasket Tea 500g (Rajkot Machine Mart)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	550.00	54	7	2026-11-10 06:47:52.331634	t
652	82	16	NestNook Dinner Set (Astitva Creations)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2500.00	131	5	2026-11-10 06:47:52.331634	t
14	112	1	Zenith Portable Projector (Visakhapatnam Electronics)	Full HD portable LED projector. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	30549.00	25	9	2026-11-10 06:47:52.331634	t
63	126	3	ByteCraft 15.6-inch Performance Laptop (Vellore Tech Point)	performance-oriented Windows laptop. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	69099.00	137	5	2026-11-10 06:47:52.331634	t
458	182	10	PureHarvest Wheat Flour 5kg (Amravati General Store)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	270.00	16	23	2026-11-10 06:47:52.331634	t
797	180	18	Pawfect Adult Cat Food 2kg (PetNest Supplies)	complete dry food for adult cats. Suitable for everyday Indian household, personal, office, or leisure use.	Pawfect	749.00	6	9	2026-11-10 06:47:52.331634	t
704	137	16	CasaCraft Bath Towel Set (Avani Enterprises)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	680.00	34	12	2026-11-10 06:47:52.331634	t
464	183	10	FreshField Sugar 5kg (Rajkot Machine Mart)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	320.00	48	20	2026-11-10 06:47:52.331634	t
16	112	1	Orion 43-inch 4K Smart TV (Visakhapatnam Electronics)	4K HDR smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	36000.00	113	20	2026-11-10 06:47:52.331634	t
634	64	16	NestNook Glass Storage Container Set (Udaipur Decor Studio)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1949.00	34	25	2026-11-10 06:47:52.331634	t
775	151	17	CarryOn Medium Trolley Bag (Shillong Mountain Goods)	medium hard-shell trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	7299.00	77	14	2026-11-10 06:47:25.783141	t
203	125	7	UrbanWeave Men's Casual Shirt (Ananya Collections)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1399.00	18	25	2026-11-10 06:47:25.783141	t
101	90	5	HomeChef Electric Kettle 1.5L (Kitchen Canvas)	stainless-steel electric kettle. Suitable for everyday Indian household, personal, office, or leisure use.	HomeChef	1149.00	86	10	2026-11-10 06:47:25.783141	t
332	14	10	DesiHarvest Tea 500g (Raipur Retail Hub)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	579.00	143	7	2026-11-10 06:47:25.783141	t
59	76	3	TechEdge 15.6-inch Performance Laptop (Computer Corner)	performance-oriented Windows laptop. Suitable for everyday Indian household, personal, office, or leisure use.	TechEdge	84000.00	97	24	2026-11-10 06:47:52.331634	t
6	40	1	Zenith 65-inch QLED TV (SmartBuy Junction)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	89500.00	2	6	2026-11-10 06:47:52.331634	t
171	30	7	CottonRoot Kids' Cotton T-Shirt (Solapur Textile Mart)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	570.00	50	23	2026-11-10 06:47:52.331634	t
435	147	10	DesiHarvest Sugar 5kg (Millet House India)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	339.00	47	23	2026-11-10 06:47:52.331634	t
345	47	10	FarmBasket Sugar 5kg (Rajdhani Traders)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	260.00	64	15	2026-11-10 06:47:52.331634	t
657	94	16	HomeCanvas Storage Basket Set (Golden Peacock Crafts)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	680.00	147	24	2026-11-10 06:47:52.331634	t
272	34	9	GlowNest Conditioner (Jaipur Jewel Box)	moisturising hair conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	479.00	23	11	2026-11-10 06:47:52.331634	t
331	14	10	FarmBasket Multigrain Atta 5kg (Raipur Retail Hub)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	299.00	21	22	2026-11-10 06:47:52.331634	t
399	104	10	DesiHarvest Basmati Rice 5kg (Vadodara Home Essentials)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	450.00	95	14	2026-11-10 06:47:52.331634	t
632	59	16	CasaCraft Non-Stick Fry Pan (Heritage Lane)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1149.00	76	21	2026-11-10 06:47:52.331634	t
24	160	1	Orion 65-inch QLED TV (Aarav Ventures)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	101599.00	31	22	2026-11-10 06:47:52.331634	t
762	81	17	RoamReady Large Trolley Bag (Guwahati Outdoor Store)	large check-in trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	4349.00	87	7	2026-11-10 06:47:52.331634	t
12	54	1	Zenith Over-Ear Wireless Headphones (Pixel & Parts)	Bluetooth over-ear headphones. Suitable for everyday Indian household, personal, office, or leisure use.	Zenith	3100.00	16	15	2026-11-10 06:47:52.331634	t
386	91	10	PureHarvest Toor Dal 1kg (Eastern Valley Traders)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	160.00	96	25	2026-11-10 06:47:52.331634	t
254	184	8	WalkMate Kids' Velcro Shoes (Kanpur Footwear House)	easy-wear children's shoes. Suitable for everyday Indian household, personal, office, or leisure use.	WalkMate	840.00	5	23	2026-11-10 06:47:52.331634	t
447	153	10	FreshField Multigrain Atta 5kg (Coconut Grove Goods)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	250.00	33	17	2026-11-10 06:47:25.783141	t
707	149	16	TableTop Non-Stick Fry Pan (Dharohar India)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1400.00	24	21	2026-11-10 06:47:25.783141	t
222	167	7	UrbanWeave Women's Casual Top (Desi Drapes)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1149.00	10	25	2026-11-10 06:47:25.783141	t
247	88	8	StrideOne Women's Casual Sneakers (Footprint Footwear)	everyday women's sneakers. Suitable for everyday Indian household, personal, office, or leisure use.	StrideOne	3899.00	13	25	2026-11-10 06:47:25.783141	t
141	121	6	Woodora TV Unit (Furniture Foundry)	living-room television console. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	13000.00	33	12	2026-11-10 06:47:25.783141	t
314	5	10	DesiHarvest Sugar 5kg (The Indian Basket)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	239.00	136	17	2026-11-10 06:47:25.783141	t
57	76	3	ZenByte 14-inch Student Laptop (Computer Corner)	portable laptop for everyday study and office work. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	38000.00	78	14	2026-11-10 06:47:25.783141	t
217	166	7	CottonRoot Men's Chino Trousers (Peacock Avenue)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2200.00	70	5	2026-11-10 06:47:52.331634	t
160	3	7	ThreadCraft Men's Cotton T-Shirt (Kosha Fashion House)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	830.00	114	13	2026-11-10 06:47:52.331634	t
641	72	16	TableTop Cotton Bedsheet (Crafted in Bharat)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1300.00	91	19	2026-11-10 06:47:52.331634	t
62	126	3	ZenByte Gaming Laptop (Vellore Tech Point)	dedicated-GPU gaming laptop. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	98500.00	44	10	2026-11-10 06:47:52.331634	t
655	85	16	NestNook Bath Towel Set (Lakshmi Trading House)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	759.00	72	12	2026-11-10 06:47:52.331634	t
645	73	16	TableTop Non-Stick Fry Pan (Kala Kendra)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	620.00	46	20	2026-11-10 06:47:52.331634	t
631	59	16	TableTop Storage Basket Set (Heritage Lane)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1400.00	81	6	2026-11-10 06:47:52.331634	t
19	130	1	Nexon 65-inch QLED TV (Surya Enterprises)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Nexon	106500.00	83	22	2026-11-10 06:47:52.331634	t
125	56	6	CasaCraft Shoe Rack (Royal Living)	multi-tier shoe storage unit. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2499.00	60	21	2026-11-10 06:47:52.331634	t
178	51	7	UrbanWeave Women's Straight Trousers (Riwaayat Collections)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	2200.00	38	10	2026-11-10 06:47:52.331634	t
735	192	16	CasaCraft Storage Basket Set (Godavari Home Store)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1149.00	107	20	2026-11-10 06:47:52.331634	t
613	33	16	CasaCraft Storage Basket Set (Thanjavur Art House)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	739.00	5	7	2026-11-10 06:47:25.783141	t
677	108	16	NestNook Stainless Steel Cookware Set (Banjara Crafts)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	4949.00	134	15	2026-11-10 06:47:25.783141	t
520	24	12	OfficeOrbit Whiteboard Marker Set (Omkar Business Solutions)	low-odour whiteboard markers. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	209.00	69	8	2026-11-10 06:47:25.783141	t
549	97	13	SportSphere Cycling Helmet (Meerut Sports Supply)	ventilated cycling helmet. Suitable for everyday Indian household, personal, office, or leisure use.	SportSphere	2399.00	101	22	2026-11-10 06:47:25.783141	t
713	164	16	KitchenKart Cotton Bedsheet (Made in India Store)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	2300.00	49	10	2026-11-10 06:47:52.331634	t
229	173	7	ThreadCraft Men's Formal Shirt (Modern Muse Apparel)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	2100.00	105	8	2026-11-10 06:47:52.331634	t
651	82	16	HomeCanvas Stainless Steel Cookware Set (Astitva Creations)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	6549.00	49	24	2026-11-10 06:47:52.331634	t
427	143	10	PureHarvest Toor Dal 1kg (Desi Pantry)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	219.00	62	16	2026-11-10 06:47:52.331634	t
193	86	7	UrbanWeave Women's Saree (Madurai Textile Works)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	3049.00	57	8	2026-11-10 06:47:52.331634	t
475	195	10	FarmBasket Wheat Flour 5kg (Everyday Essentials)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	399.00	14	24	2026-11-10 06:47:52.331634	t
7	40	1	Nexon True Wireless Earbuds (SmartBuy Junction)	wireless in-ear audio earbuds. Suitable for everyday Indian household, personal, office, or leisure use.	Nexon	12500.00	15	24	2026-11-10 06:47:52.331634	t
115	142	5	CookEase Microwave Oven 28L (HomeChef Depot)	convection microwave oven. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	15549.00	27	8	2026-11-10 06:47:52.331634	t
548	79	13	ActivePeak Cycling Helmet (Jalandhar Sports Depot)	ventilated cycling helmet. Suitable for everyday Indian household, personal, office, or leisure use.	ActivePeak	1800.00	81	6	2026-11-10 06:47:52.331634	t
673	107	16	TableTop Curtain Set (Chai & Craft)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	2099.00	36	5	2026-11-10 06:47:25.783141	t
485	42	11	Saraswati Press Indian Polity Handbook (MangoTree Books)	reference guide to Indian polity and governance. Suitable for everyday Indian household, personal, office, or leisure use.	Saraswati Press	780.00	109	10	2026-10-11 13:53:19.221477	t
365	75	10	FreshField Breakfast Oats 1kg (DailyBasket Traders)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	279.00	50	11	2026-11-10 06:47:25.783141	t
43	169	2	Pixelra MagSafe-Compatible Stand (Mumbai Mobile Hub)	magnetic smartphone charging stand. Suitable for everyday Indian household, personal, office, or leisure use.	Pixelra	2299.00	27	5	2026-11-10 06:47:25.783141	t
28	200	1	Auralis Action Camera (Dhanbad Electronics Point)	compact 4K action camera. Suitable for everyday Indian household, personal, office, or leisure use.	Auralis	86500.00	21	24	2026-11-10 06:47:25.783141	t
220	166	7	EthnicEdit Women's Cotton Kurta (Peacock Avenue)	printed cotton kurta. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	990.00	77	7	2026-11-10 06:47:25.783141	t
199	114	7	CottonRoot Women's Saree (Lucknow Lifestyle)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2099.00	99	12	2026-11-10 06:47:52.331634	t
708	149	16	TableTop Wall Decor Set (Dharohar India)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	2000.00	52	21	2026-11-10 06:47:52.331634	t
426	143	10	FreshField Basmati Rice 5kg (Desi Pantry)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	469.00	123	9	2026-11-10 06:47:52.331634	t
85	174	4	EverCool 40-inch Smart TV (Appliance Avenue)	smart LED television. Suitable for everyday Indian household, personal, office, or leisure use.	EverCool	42049.00	103	17	2026-11-10 06:47:52.331634	t
585	176	15	DriveMate Car Dashboard Cleaner (DriveMate Accessories)	interior dashboard cleaning kit. Suitable for everyday Indian household, personal, office, or leisure use.	DriveMate	409.00	128	8	2026-11-10 06:47:52.331634	t
394	100	10	FarmBasket Mixed Nuts 500g (Malabar Essentials)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	460.00	138	20	2026-11-10 06:47:52.331634	t
17	130	1	VistaCore 55-inch QLED TV (Surya Enterprises)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	VistaCore	92500.00	47	8	2026-11-10 06:47:52.331634	t
79	92	4	ArcticNest 2 Ton Split AC (Salem Appliance House)	large-room inverter split air conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	ArcticNest	64599.00	87	16	2026-11-10 06:47:52.331634	t
243	50	8	SoleStory Men's Running Shoes (Walkway Footwear)	lightweight running shoes. Suitable for everyday Indian household, personal, office, or leisure use.	SoleStory	5899.00	58	20	2026-11-10 06:47:25.783141	t
796	106	18	WhiskersCo Puppy Food 3kg (PetPal Supplies)	balanced dry food for puppies. Suitable for everyday Indian household, personal, office, or leisure use.	WhiskersCo	769.00	68	21	2026-10-11 13:53:19.221477	t
568	60	15	AutoGear Car Phone Holder (RoadReady Auto)	dashboard and vent phone mount. Suitable for everyday Indian household, personal, office, or leisure use.	AutoGear	899.00	146	20	2026-11-10 06:47:25.783141	t
799	180	18	TailWaggers Dog Leash (PetNest Supplies)	adjustable nylon dog leash. Suitable for everyday Indian household, personal, office, or leisure use.	TailWaggers	1100.00	11	19	2026-11-10 06:47:25.783141	t
383	87	10	DailyGrain Breakfast Oats 1kg (Ananta Marketplace)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	299.00	17	24	2026-11-10 06:47:25.783141	t
182	55	7	IndigoLane Kids' Cotton T-Shirt (Ethnic Edit)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	760.00	96	24	2026-11-10 06:47:25.783141	t
73	22	4	EverCool Top Load Washing Machine (Noida Smart Living)	fully automatic top-load washing machine. Suitable for everyday Indian household, personal, office, or leisure use.	EverCool	21549.00	23	11	2026-11-10 06:47:25.783141	t
453	163	10	FarmBasket Mixed Nuts 500g (Evergreen Retail)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	599.00	130	14	2026-11-10 06:47:52.331634	t
460	182	10	DailyGrain Sona Masoori Rice 5kg (Amravati General Store)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	750.00	109	6	2026-11-10 06:47:52.331634	t
158	3	7	IndigoLane Men's Casual Shirt (Kosha Fashion House)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1799.00	19	8	2026-11-10 06:47:52.331634	t
87	174	4	Cresta Room Heater (Appliance Avenue)	electric room heater with thermostat. Suitable for everyday Indian household, personal, office, or leisure use.	Cresta	4100.00	142	18	2026-11-10 06:47:52.331634	t
74	22	4	HomeZen Single Door Refrigerator (Noida Smart Living)	energy-efficient single-door refrigerator. Suitable for everyday Indian household, personal, office, or leisure use.	HomeZen	20049.00	30	21	2026-11-10 06:47:52.331634	t
40	118	2	Astra 20000mAh Power Bank (MobileMania Store)	high-capacity USB-C power bank. Suitable for everyday Indian household, personal, office, or leisure use.	Astra	1400.00	144	16	2026-11-10 06:47:52.331634	t
669	103	16	CasaCraft Kitchen Knife Set (HomeHive India)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1799.00	10	21	2026-11-10 06:47:52.331634	t
390	93	10	FarmBasket Multigrain Atta 5kg (PlayZone Bazaar)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	320.00	6	15	2026-10-11 13:53:19.221477	t
598	12	16	NestNook Cotton Bedsheet (Karigar Collective)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2100.00	143	21	2026-11-10 06:47:25.783141	t
679	108	16	CasaCraft Dinner Set (Banjara Crafts)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1700.00	99	23	2026-11-10 06:47:25.783141	t
82	133	4	EverCool Ceiling Fan (Ahmedabad Appliance Centre)	high-air-delivery ceiling fan. Suitable for everyday Indian household, personal, office, or leisure use.	EverCool	2049.00	10	25	2026-11-10 06:47:25.783141	t
219	166	7	IndigoLane Men's Casual Shirt (Peacock Avenue)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	1649.00	93	18	2026-11-10 06:47:25.783141	t
734	192	16	HomeCanvas Non-Stick Fry Pan (Godavari Home Store)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1449.00	18	18	2026-11-10 06:47:25.783141	t
513	15	12	CampusPro Document Folder (Cuttack Stationery World)	durable document storage folder. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	110.00	17	23	2026-11-10 06:47:25.783141	t
75	22	4	ArcticNest Double Door Refrigerator (Noida Smart Living)	frost-free double-door refrigerator. Suitable for everyday Indian household, personal, office, or leisure use.	ArcticNest	44500.00	12	17	2026-11-10 06:47:25.783141	t
785	49	18	PetNest Dog Leash (Krishna Retail)	adjustable nylon dog leash. Suitable for everyday Indian household, personal, office, or leisure use.	PetNest	960.00	37	13	2026-10-11 13:53:19.221477	t
118	168	5	HomeChef Rice Cooker 1.8L (Coimbatore Kitchen Mart)	automatic electric rice cooker. Suitable for everyday Indian household, personal, office, or leisure use.	HomeChef	3699.00	16	20	2026-11-10 06:47:52.331634	t
570	69	15	RoadReady Car Seat Cover Set (Vishwakarma Tools & Supply)	universal-fit car seat covers. Suitable for everyday Indian household, personal, office, or leisure use.	RoadReady	3100.00	45	16	2026-11-10 06:47:52.331634	t
53	66	3	ByteCraft Wireless Keyboard Mouse Combo (Chennai Computer Depot)	wireless keyboard and mouse set. Suitable for everyday Indian household, personal, office, or leisure use.	ByteCraft	2849.00	126	13	2026-11-10 06:47:52.331634	t
169	30	7	UrbanWeave Unisex Hoodie (Solapur Textile Mart)	fleece-lined casual hoodie. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	2400.00	17	19	2026-11-10 06:47:52.331634	t
138	120	6	TimberLine Bedside Table (NatureNest Organics)	two-drawer bedside table. Suitable for everyday Indian household, personal, office, or leisure use.	TimberLine	2249.00	117	15	2026-11-10 06:47:52.331634	t
175	37	7	UrbanWeave Men's Chino Trousers (Marigold Collections)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1399.00	2	13	2026-11-10 06:47:52.331634	t
754	48	17	RoamReady Toiletry Travel Kit (Mangalore Coastal Goods)	compact travel toiletry organiser. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	1000.00	97	21	2026-11-10 06:47:52.331634	t
547	79	13	FitNation Skipping Rope (Jalandhar Sports Depot)	adjustable speed skipping rope. Suitable for everyday Indian household, personal, office, or leisure use.	FitNation	359.00	120	14	2026-11-10 06:47:52.331634	t
54	66	3	Vertex USB-C Docking Station (Chennai Computer Depot)	multi-port USB-C laptop dock. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	7200.00	69	22	2026-11-10 06:47:52.331634	t
770	136	17	CarryOn Packing Cube Set (Panaji Beachside Retail)	multi-size packing organiser set. Suitable for everyday Indian household, personal, office, or leisure use.	CarryOn	1549.00	26	13	2026-11-10 06:47:52.331634	t
449	156	10	PureHarvest Sugar 5kg (ChoicePoint Marketplace)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	330.00	45	20	2026-11-10 06:47:25.783141	t
782	29	18	Pawfect Puppy Food 3kg (StyleStreet Retail)	balanced dry food for puppies. Suitable for everyday Indian household, personal, office, or leisure use.	Pawfect	1049.00	20	24	2026-11-10 06:47:25.783141	t
573	116	15	WheelWise Tyre Inflator Gauge (AutoGear India)	digital tyre pressure inflator. Suitable for everyday Indian household, personal, office, or leisure use.	WheelWise	4100.00	148	25	2026-11-10 06:47:25.783141	t
232	173	7	EthnicEdit Men's Casual Shirt (Modern Muse Apparel)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	710.00	41	16	2026-11-10 06:47:25.783141	t
377	83	10	PureHarvest Mixed Nuts 500g (Dastkari Bazaar)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	1099.00	69	7	2026-11-10 06:47:25.783141	t
157	3	7	CottonRoot Men's Chino Trousers (Kosha Fashion House)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2200.00	63	10	2026-11-10 06:47:25.783141	t
418	134	10	PureHarvest Wheat Flour 5kg (Sai Krupa Retailers)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	469.00	125	11	2026-11-10 06:47:25.783141	t
539	25	13	SportSphere Adjustable Dumbbell (SportSphere India)	adjustable cast-iron dumbbell. Suitable for everyday Indian household, personal, office, or leisure use.	SportSphere	1699.00	12	19	2026-11-10 06:47:52.331634	t
280	70	9	GlowNest Hyaluronic Acid Serum (AyurVeda Essentials)	hydrating facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	1200.00	123	5	2026-11-10 06:47:52.331634	t
107	98	5	ChefNest Mixer Grinder 750W (Cookware Collective)	multi-jar mixer grinder. Suitable for everyday Indian household, personal, office, or leisure use.	ChefNest	2549.00	57	25	2026-11-10 06:47:52.331634	t
423	141	10	PureHarvest Filter Coffee 500g (Delhi Daily Mart)	South Indian filter coffee blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	770.00	53	12	2026-11-10 06:47:52.331634	t
119	168	5	KitchPro Hand Blender (Coimbatore Kitchen Mart)	variable-speed immersion blender. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	1799.00	68	21	2026-11-10 06:47:52.331634	t
506	2	12	DeskMate A4 Project Notebook (OfficeCraft Solutions)	large ruled project notebook. Suitable for everyday Indian household, personal, office, or leisure use.	DeskMate	369.00	6	12	2026-11-10 06:47:52.331634	t
512	9	12	WriteWell Desk Organizer (Kota Study Store)	multi-compartment desk organizer. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	579.00	77	6	2026-11-10 06:47:52.331634	t
321	10	10	DesiHarvest Mixed Nuts 500g (Ganga Enterprises)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	650.00	134	8	2026-11-10 06:47:52.331634	t
444	150	10	PureHarvest Moong Dal 1kg (ValueKart India)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	150.00	44	21	2026-11-10 06:47:52.331634	t
694	127	16	KitchenKart Stainless Steel Cookware Set (Bharat Artisan House)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	3100.00	29	14	2026-11-10 06:47:52.331634	t
170	30	7	CottonRoot Men's Cotton T-Shirt (Solapur Textile Mart)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	850.00	81	11	2026-11-10 06:47:52.331634	t
186	67	7	CottonRoot Men's Casual Shirt (Indigo Loom)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	860.00	130	12	2026-11-10 06:47:52.331634	t
322	10	10	DailyGrain Basmati Rice 5kg (Ganga Enterprises)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	409.00	106	16	2026-11-10 06:47:52.331634	t
353	53	10	FreshField Moong Dal 1kg (Shree Balaji Traders)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	200.00	124	17	2026-11-10 06:47:52.331634	t
481	199	10	DailyGrain Basmati Rice 5kg (Warangal Daily Needs)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	860.00	47	5	2026-11-10 06:47:52.331634	t
128	56	6	Woodora Bedside Table (Royal Living)	two-drawer bedside table. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	4400.00	61	25	2026-11-10 06:47:52.331634	t
755	48	17	TravelTrail Travel Neck Pillow (Mangalore Coastal Goods)	memory-foam travel neck pillow. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	1299.00	127	23	2026-11-10 06:47:52.331634	t
790	89	18	WhiskersCo Interactive Pet Toy (Ghaziabad Retail Works)	engagement toy for dogs and cats. Suitable for everyday Indian household, personal, office, or leisure use.	WhiskersCo	1149.00	94	5	2026-11-10 06:47:25.783141	t
596	8	16	HomeCanvas Kitchen Knife Set (Imphal Heritage Store)	multi-piece kitchen knife set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	780.00	46	13	2026-11-10 06:47:25.783141	t
698	129	16	TableTop Bath Towel Set (Abhivyakti Arts)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1000.00	104	19	2026-10-11 13:53:19.221477	t
269	34	9	VedaGlow Anti-Dandruff Shampoo (Jaipur Jewel Box)	anti-dandruff hair cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	790.00	135	17	2026-11-10 06:47:25.783141	t
214	154	7	EthnicEdit Men's Cotton T-Shirt (Surat Textile House)	regular-fit cotton T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	850.00	27	11	2026-10-11 13:53:19.221477	t
177	51	7	ThreadCraft Women's Anarkali Kurta (Riwaayat Collections)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	2000.00	78	22	2026-11-10 06:47:52.331634	t
473	195	10	PureHarvest Multigrain Atta 5kg (Everyday Essentials)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	289.00	28	12	2026-11-10 06:47:52.331634	t
287	105	9	GlowNest Body Lotion (Veda Wellness)	daily hydrating body lotion. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	470.00	144	20	2026-11-10 06:47:52.331634	t
189	74	7	IndigoLane Men's Chino Trousers (Kaveri Lifestyle)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	940.00	90	15	2026-11-10 06:47:52.331634	t
723	179	16	HomeCanvas Dinner Set (Sundar Handicrafts)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	3100.00	114	10	2026-11-10 06:47:52.331634	t
164	17	7	EthnicEdit Men's Chino Trousers (Sari Street)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	940.00	5	12	2026-11-10 06:47:52.331634	t
489	65	11	ScholarHouse Database Systems (Saraswati Book House)	academic introduction to database systems. Suitable for everyday Indian household, personal, office, or leisure use.	ScholarHouse	489.00	126	21	2026-11-10 06:47:52.331634	t
350	52	10	FarmBasket Basmati Rice 5kg (Farm2Shelf Market)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	480.00	11	10	2026-11-10 06:47:52.331634	t
476	195	10	FreshField Moong Dal 1kg (Everyday Essentials)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	130.00	3	19	2026-11-10 06:47:52.331634	t
612	28	16	KitchenKart Bath Towel Set (Agra Craft Bazaar)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1700.00	46	17	2026-11-10 06:47:52.331634	t
116	142	5	KitchPro Induction Cooktop (HomeChef Depot)	portable induction cooktop. Suitable for everyday Indian household, personal, office, or leisure use.	KitchPro	2299.00	54	17	2026-11-10 06:47:52.331634	t
262	18	9	GlowNest Vitamin C Face Serum (Neem & Co.)	brightening facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	1149.00	40	20	2026-11-10 06:47:52.331634	t
747	13	17	TravelTrail Cabin Trolley Bag (Siliguri Travel Goods)	compact cabin-size trolley suitcase. Suitable for everyday Indian household, personal, office, or leisure use.	TravelTrail	4100.00	5	20	2026-11-10 06:47:52.331634	t
465	187	10	PureHarvest Tea 500g (Amrut Foods)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	690.00	21	20	2026-11-10 06:47:52.331634	t
51	57	3	TechEdge 14-inch Business Laptop (TechTrove India)	business-focused lightweight laptop. Suitable for everyday Indian household, personal, office, or leisure use.	TechEdge	46049.00	134	22	2026-11-10 06:47:52.331634	t
134	119	6	Oak & Loom Office Desk (Mysuru Furnishings)	spacious work-from-home desk. Suitable for everyday Indian household, personal, office, or leisure use.	Oak & Loom	8249.00	95	7	2026-11-10 06:47:52.331634	t
39	118	2	NexCell 65W GaN Charger (MobileMania Store)	multi-device GaN charger. Suitable for everyday Indian household, personal, office, or leisure use.	NexCell	3449.00	6	19	2026-11-10 06:47:52.331634	t
692	117	16	CasaCraft Non-Stick Fry Pan (Aangan Decor)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	500.00	11	15	2026-11-10 06:47:25.783141	t
709	157	16	NestNook Dinner Set (CasaCraft India)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1199.00	43	9	2026-11-10 06:47:25.783141	t
172	30	7	EthnicEdit Men's Casual Shirt (Solapur Textile Mart)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	1599.00	88	20	2026-10-11 13:53:19.221477	t
678	108	16	TableTop Glass Storage Container Set (Banjara Crafts)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1649.00	57	21	2026-10-11 13:53:19.221477	t
339	31	10	FreshField Toor Dal 1kg (Kaveri Traders)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	129.00	141	12	2026-11-10 06:47:25.783141	t
98	41	5	SpiceMate Induction Cooktop (Coastal Kitchenware)	portable induction cooktop. Suitable for everyday Indian household, personal, office, or leisure use.	SpiceMate	1699.00	91	5	2026-11-10 06:47:25.783141	t
208	128	7	ThreadCraft Men's Chino Trousers (Mitra Fashion Studio)	slim-fit chino trousers. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	2100.00	8	11	2026-11-10 06:47:25.783141	t
654	85	16	KitchenKart Cotton Bedsheet (Lakshmi Trading House)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	2299.00	83	8	2026-11-10 06:47:52.331634	t
588	176	15	WheelWise Car Seat Cover Set (DriveMate Accessories)	universal-fit car seat covers. Suitable for everyday Indian household, personal, office, or leisure use.	WheelWise	3799.00	29	9	2026-11-10 06:47:52.331634	t
769	136	17	RoamReady Foldable Travel Backpack (Panaji Beachside Retail)	lightweight foldable daypack. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	1749.00	121	12	2026-11-10 06:47:52.331634	t
711	157	16	KitchenKart Glass Storage Container Set (CasaCraft India)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	689.00	140	23	2026-11-10 06:47:52.331634	t
306	172	9	PureBloom Hyaluronic Acid Serum (Wellness Window)	hydrating facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	1300.00	79	21	2026-11-10 06:47:52.331634	t
560	177	13	PlayField Cricket Bat (TravelTrail India)	English-willow style cricket bat. Suitable for everyday Indian household, personal, office, or leisure use.	PlayField	6399.00	120	10	2026-11-10 06:47:52.331634	t
719	175	16	KitchenKart Wall Decor Set (Varanasi Heritage)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	880.00	116	20	2026-11-10 06:47:52.331634	t
196	86	7	EthnicEdit Women's Anarkali Kurta (Madurai Textile Works)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	3299.00	131	20	2026-11-10 06:47:52.331634	t
740	194	16	CasaCraft Dinner Set (Puri Coastal Crafts)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2600.00	70	20	2026-11-10 06:47:52.331634	t
305	172	9	AuraCare Vitamin C Face Serum (Wellness Window)	brightening facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	1000.00	133	22	2026-11-10 06:47:52.331634	t
127	56	6	UrbanNest TV Unit (Royal Living)	living-room television console. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	6849.00	55	11	2026-11-10 06:47:52.331634	t
456	163	10	PureHarvest Basmati Rice 5kg (Evergreen Retail)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	429.00	103	21	2026-11-10 06:47:52.331634	t
459	182	10	FarmBasket Moong Dal 1kg (Amravati General Store)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	139.00	123	21	2026-11-10 06:47:25.783141	t
750	32	17	RoamReady Weekender Bag (Himalayan Travel Gear)	compact weekend travel bag. Suitable for everyday Indian household, personal, office, or leisure use.	RoamReady	1299.00	46	6	2026-10-11 13:53:19.221477	t
279	70	9	AuraCare Gentle Face Cleanser (AyurVeda Essentials)	mild daily facial cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	370.00	82	9	2026-11-10 06:47:25.783141	t
583	152	15	DriveMate Car Phone Holder (Nagpur Auto Accessories)	dashboard and vent phone mount. Suitable for everyday Indian household, personal, office, or leisure use.	DriveMate	789.00	106	10	2026-11-10 06:47:25.783141	t
52	57	3	Vertex 24-inch Full HD Monitor (TechTrove India)	Full HD IPS desktop monitor. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	8499.00	79	21	2026-11-10 06:47:25.783141	t
521	38	12	OfficeOrbit Highlighter Set (SchoolBag Central)	assorted fluorescent highlighters. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	209.00	25	19	2026-11-10 06:47:25.783141	t
210	131	7	ThreadCraft Women's Straight Trousers (Urban Loom)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1700.00	84	14	2026-11-10 06:47:25.783141	t
144	121	6	CasaCraft Coffee Table (Furniture Foundry)	modern living-room coffee table. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	5249.00	88	9	2026-11-10 06:47:52.331634	t
624	45	16	HomeCanvas Dinner Set (Rajputana Handicrafts)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1399.00	89	23	2026-11-10 06:47:52.331634	t
643	72	16	CasaCraft Bath Towel Set (Crafted in Bharat)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1049.00	56	16	2026-11-10 06:47:52.331634	t
381	87	10	DailyGrain Basmati Rice 5kg (Ananta Marketplace)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	760.00	110	12	2026-11-10 06:47:52.331634	t
409	123	10	FarmBasket Breakfast Oats 1kg (Cauvery Traders)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	290.00	149	6	2026-11-10 06:47:52.331634	t
671	103	16	HomeCanvas Cotton Bedsheet (HomeHive India)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1199.00	82	6	2026-11-10 06:47:52.331634	t
640	71	16	NestNook Cotton Bedsheet (Srinagar Artisan Collective)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1500.00	99	6	2026-11-10 06:47:52.331634	t
168	26	7	EthnicEdit Women's Straight Trousers (The Wardrobe Co)	comfortable straight-fit trousers. Suitable for everyday Indian household, personal, office, or leisure use.	EthnicEdit	1499.00	34	15	2026-11-10 06:47:52.331634	t
571	69	15	DriveMate Bike Cover (Vishwakarma Tools & Supply)	water-resistant motorcycle cover. Suitable for everyday Indian household, personal, office, or leisure use.	DriveMate	1799.00	9	15	2026-11-10 06:47:52.331634	t
358	61	10	FarmBasket Moong Dal 1kg (Narmada Marketplace)	split yellow moong dal. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	190.00	109	21	2026-11-10 06:47:52.331634	t
417	134	10	FreshField Tea 500g (Sai Krupa Retailers)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FreshField	469.00	122	11	2026-11-10 06:47:52.331634	t
647	73	16	CasaCraft Stainless Steel Cookware Set (Kala Kendra)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2549.00	142	20	2026-11-10 06:47:52.331634	t
64	126	3	Vertex 15.6-inch Creator Laptop (Vellore Tech Point)	laptop designed for creative workloads. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	71500.00	11	18	2026-11-10 06:47:52.331634	t
69	158	3	TechEdge Wireless Keyboard Mouse Combo (BlueKite Technologies)	wireless keyboard and mouse set. Suitable for everyday Indian household, personal, office, or leisure use.	TechEdge	1099.00	4	14	2026-11-10 06:47:52.331634	t
606	20	16	NestNook Water Bottle Set (Virasat India)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	1049.00	29	22	2026-11-10 06:47:52.331634	t
375	80	10	FarmBasket Wheat Flour 5kg (Maa Durga Enterprises)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	469.00	43	24	2026-11-10 06:47:25.783141	t
705	149	16	CasaCraft Stainless Steel Cookware Set (Dharohar India)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2149.00	39	14	2026-11-10 06:47:25.783141	t
91	189	4	EverCool 1.5 Ton Split AC (Faridabad Home Centre)	inverter split air conditioner. Suitable for everyday Indian household, personal, office, or leisure use.	EverCool	53099.00	79	6	2026-11-10 06:47:25.783141	t
434	147	10	PureHarvest Multigrain Atta 5kg (Millet House India)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	409.00	127	13	2026-11-10 06:47:25.783141	t
264	18	9	AuraCare Hyaluronic Acid Serum (Neem & Co.)	hydrating facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	AuraCare	1349.00	76	25	2026-10-11 13:53:19.221477	t
292	122	9	PureBloom Vitamin C Face Serum (Prakruti Organics)	brightening facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	PureBloom	810.00	71	13	2026-11-10 06:47:52.331634	t
33	78	2	Voltix 65W GaN Charger (Bengaluru Gadget Works)	multi-device GaN charger. Suitable for everyday Indian household, personal, office, or leisure use.	Voltix	1700.00	20	19	2026-11-10 06:47:52.331634	t
676	107	16	HomeCanvas Wall Decor Set (Chai & Craft)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1449.00	44	24	2026-11-10 06:47:52.331634	t
335	23	10	PureHarvest Breakfast Oats 1kg (QuickCart Enterprises)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	230.00	44	14	2026-11-10 06:47:52.331634	t
249	146	8	SoleStory Unisex Sports Shoes (SoleStory)	multi-purpose sports footwear. Suitable for everyday Indian household, personal, office, or leisure use.	SoleStory	2400.00	33	24	2026-11-10 06:47:52.331634	t
683	111	16	HomeCanvas Dinner Set (Tulsi Home Store)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	2800.00	76	23	2026-11-10 06:47:52.331634	t
215	154	7	ThreadCraft Men's Casual Shirt (Surat Textile House)	cotton casual shirt. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	1100.00	3	16	2026-11-10 06:47:52.331634	t
252	146	8	StepCraft Women's Sandals (SoleStory)	casual everyday sandals. Suitable for everyday Indian household, personal, office, or leisure use.	StepCraft	1149.00	111	19	2026-11-10 06:47:52.331634	t
230	173	7	CottonRoot Kids' Cotton T-Shirt (Modern Muse Apparel)	soft cotton children's T-shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	449.00	53	21	2026-11-10 06:47:52.331634	t
523	38	12	WriteWell Ball Pen Pack (SchoolBag Central)	everyday ball pens. Suitable for everyday Indian household, personal, office, or leisure use.	WriteWell	160.00	82	18	2026-11-10 06:47:52.331634	t
558	177	13	ActivePeak Football (TravelTrail India)	machine-stitched football. Suitable for everyday Indian household, personal, office, or leisure use.	ActivePeak	1749.00	92	16	2026-11-10 06:47:52.331634	t
355	53	10	DailyGrain Toor Dal 1kg (Shree Balaji Traders)	polished toor dal. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	209.00	68	15	2026-11-10 06:47:52.331634	t
765	132	17	NomadGear Travel Duffle Bag (Dehradun Adventure Shop)	spacious travel duffle bag. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	1300.00	129	11	2026-11-10 06:47:52.331634	t
166	26	7	CottonRoot Women's Casual Top (The Wardrobe Co)	everyday casual top. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	809.00	145	14	2026-11-10 06:47:52.331634	t
291	122	9	VedaGlow Hyaluronic Acid Serum (Prakruti Organics)	hydrating facial serum. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	1099.00	144	21	2026-11-10 06:47:52.331634	t
410	123	10	PureHarvest Sona Masoori Rice 5kg (Cauvery Traders)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	659.00	127	17	2026-11-10 06:47:52.331634	t
156	170	6	UrbanNest Bookshelf (Chandigarh Living)	multi-shelf storage bookcase. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanNest	6799.00	108	21	2026-11-10 06:47:52.331634	t
428	143	10	FarmBasket Sona Masoori Rice 5kg (Desi Pantry)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	410.00	62	25	2026-11-10 06:47:52.331634	t
685	113	16	CasaCraft Cotton Bedsheet (Saffron Homeware)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2399.00	138	9	2026-11-10 06:47:52.331634	t
668	99	16	NestNook Water Bottle Set (Hubballi Hardware House)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	519.00	74	20	2026-11-10 06:47:52.331634	t
263	18	9	VedaGlow Foaming Face Wash (Neem & Co.)	refreshing foaming face wash. Suitable for everyday Indian household, personal, office, or leisure use.	VedaGlow	819.00	15	7	2026-11-10 06:47:25.783141	t
419	134	10	DailyGrain Sugar 5kg (Sai Krupa Retailers)	refined white sugar. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	259.00	123	16	2026-10-11 13:53:19.221477	t
352	52	10	FarmBasket Breakfast Oats 1kg (Farm2Shelf Market)	rolled oats for breakfast. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	170.00	29	20	2026-11-10 06:47:52.331634	t
315	5	10	PureHarvest Multigrain Atta 5kg (The Indian Basket)	multigrain whole wheat flour. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	339.00	119	16	2026-11-10 06:47:52.331634	t
639	71	16	CasaCraft Dinner Set (Srinagar Artisan Collective)	ceramic dinnerware set. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	2049.00	55	25	2026-11-10 06:47:52.331634	t
257	185	8	WalkMate Men's Walking Shoes (SoleCraft India)	cushioned walking shoes. Suitable for everyday Indian household, personal, office, or leisure use.	WalkMate	5299.00	90	17	2026-11-10 06:47:52.331634	t
391	93	10	DesiHarvest Tea 500g (PlayZone Bazaar)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	640.00	7	15	2026-11-10 06:47:52.331634	t
424	141	10	DesiHarvest Mixed Nuts 500g (Delhi Daily Mart)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	DesiHarvest	699.00	59	23	2026-11-10 06:47:52.331634	t
470	188	10	PureHarvest Sona Masoori Rice 5kg (Prime Choice Retail)	everyday sona masoori rice. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	860.00	38	15	2026-11-10 06:47:52.331634	t
675	107	16	HomeCanvas Non-Stick Fry Pan (Chai & Craft)	non-stick kitchen frying pan. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	830.00	95	19	2026-11-10 06:47:52.331634	t
690	117	16	HomeCanvas Stainless Steel Cookware Set (Aangan Decor)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	5299.00	115	18	2026-11-10 06:47:52.331634	t
167	26	7	ThreadCraft Women's Saree (The Wardrobe Co)	lightweight printed saree. Suitable for everyday Indian household, personal, office, or leisure use.	ThreadCraft	4349.00	79	9	2026-11-10 06:47:52.331634	t
509	9	12	CampusPro Ball Pen Pack (Kota Study Store)	everyday ball pens. Suitable for everyday Indian household, personal, office, or leisure use.	CampusPro	270.00	78	21	2026-11-10 06:47:52.331634	t
601	19	16	KitchenKart Storage Basket Set (Pondicherry Lifestyle Studio)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1349.00	20	22	2026-11-10 06:47:52.331634	t
58	76	3	ZenByte 1TB NVMe SSD (Computer Corner)	PCIe NVMe solid-state drive. Suitable for everyday Indian household, personal, office, or leisure use.	ZenByte	5649.00	31	18	2026-11-10 06:47:52.331634	t
201	125	7	CottonRoot Men's Formal Shirt (Ananya Collections)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	CottonRoot	2400.00	67	23	2026-11-10 06:47:52.331634	t
10	54	1	VistaCore Action Camera (Pixel & Parts)	compact 4K action camera. Suitable for everyday Indian household, personal, office, or leisure use.	VistaCore	71000.00	88	12	2026-11-10 06:47:52.331634	t
445	153	10	DailyGrain Wheat Flour 5kg (Coconut Grove Goods)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	DailyGrain	280.00	126	20	2026-11-10 06:47:52.331634	t
622	45	16	CasaCraft Glass Storage Container Set (Rajputana Handicrafts)	airtight glass food containers. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	619.00	4	7	2026-11-10 06:47:25.783141	t
538	25	13	ActivePeak Resistance Band Set (SportSphere India)	multi-resistance fitness bands. Suitable for everyday Indian household, personal, office, or leisure use.	ActivePeak	1399.00	107	5	2026-10-11 13:53:19.221477	t
752	32	17	NomadGear Laptop Backpack (Himalayan Travel Gear)	padded laptop travel backpack. Suitable for everyday Indian household, personal, office, or leisure use.	NomadGear	2249.00	19	22	2026-11-10 06:47:25.783141	t
122	1	6	Woodora Study Table (Banyan Tree Living)	engineered-wood study table. Suitable for everyday Indian household, personal, office, or leisure use.	Woodora	8100.00	97	5	2026-11-10 06:47:25.783141	t
608	20	16	CasaCraft Stainless Steel Cookware Set (Virasat India)	multi-piece stainless steel cookware. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	5749.00	101	19	2026-11-10 06:47:52.331634	t
422	141	10	FarmBasket Tea 500g (Delhi Daily Mart)	Indian black tea blend. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	609.00	125	14	2026-11-10 06:47:52.331634	t
297	155	9	GlowNest Anti-Dandruff Shampoo (Aranya Naturals)	anti-dandruff hair cleanser. Suitable for everyday Indian household, personal, office, or leisure use.	GlowNest	530.00	16	8	2026-11-10 06:47:52.331634	t
510	9	12	PaperTrail Highlighter Set (Kota Study Store)	assorted fluorescent highlighters. Suitable for everyday Indian household, personal, office, or leisure use.	PaperTrail	189.00	3	18	2026-11-10 06:47:52.331634	t
313	5	10	FarmBasket Wheat Flour 5kg (The Indian Basket)	whole wheat atta. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	389.00	50	18	2026-11-10 06:47:52.331634	t
732	186	16	NestNook Curtain Set (Rangoli Home Studio)	ready-to-hang window curtains. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	929.00	109	16	2026-11-10 06:47:52.331634	t
318	7	10	PureHarvest Mixed Nuts 500g (Vijayawada Value Mart)	assorted roasted nuts. Suitable for everyday Indian household, personal, office, or leisure use.	PureHarvest	730.00	10	14	2026-11-10 06:47:52.331634	t
674	107	16	CasaCraft Storage Basket Set (Chai & Craft)	woven household storage baskets. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	509.00	88	10	2026-11-10 06:47:52.331634	t
1	21	1	Orion 65-inch QLED TV (DigitalDukaan)	QLED smart television. Suitable for everyday Indian household, personal, office, or leisure use.	Orion	59099.00	101	13	2026-11-10 06:47:52.331634	t
710	157	16	TableTop Water Bottle Set (CasaCraft India)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	330.00	46	25	2026-11-10 06:47:52.331634	t
593	8	16	CasaCraft Water Bottle Set (Imphal Heritage Store)	reusable household water bottles. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	1000.00	146	19	2026-11-10 06:47:52.331634	t
72	158	3	Vertex 1TB NVMe SSD (BlueKite Technologies)	PCIe NVMe solid-state drive. Suitable for everyday Indian household, personal, office, or leisure use.	Vertex	7000.00	1	9	2026-11-10 06:47:52.331634	t
149	162	6	CasaCraft Study Table (Lotus Living)	engineered-wood study table. Suitable for everyday Indian household, personal, office, or leisure use.	CasaCraft	4899.00	24	6	2026-11-10 06:47:52.331634	t
56	66	3	TechEdge Mechanical Keyboard (Chennai Computer Depot)	backlit mechanical desktop keyboard. Suitable for everyday Indian household, personal, office, or leisure use.	TechEdge	4499.00	121	8	2026-11-10 06:47:52.331634	t
550	97	13	PlayField Resistance Band Set (Meerut Sports Supply)	multi-resistance fitness bands. Suitable for everyday Indian household, personal, office, or leisure use.	PlayField	1100.00	102	8	2026-11-10 06:47:52.331634	t
117	168	5	CookEase OTG 30L (Coimbatore Kitchen Mart)	countertop oven toaster grill. Suitable for everyday Indian household, personal, office, or leisure use.	CookEase	8300.00	1	14	2026-11-10 06:47:52.331634	t
686	113	16	HomeCanvas Bath Towel Set (Saffron Homeware)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	HomeCanvas	1400.00	75	21	2026-11-10 06:47:52.331634	t
779	159	17	Voyage Travel Duffle Bag (RoamReady)	spacious travel duffle bag. Suitable for everyday Indian household, personal, office, or leisure use.	Voyage	3300.00	49	21	2026-11-10 06:47:52.331634	t
206	128	7	UrbanWeave Women's Anarkali Kurta (Mitra Fashion Studio)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	2249.00	129	22	2026-11-10 06:47:52.331634	t
595	8	16	KitchenKart Cotton Bedsheet (Imphal Heritage Store)	soft cotton bedsheet. Suitable for everyday Indian household, personal, office, or leisure use.	KitchenKart	1799.00	24	5	2026-11-10 06:47:52.331634	t
658	94	16	TableTop Bath Towel Set (Golden Peacock Crafts)	absorbent cotton bath towels. Suitable for everyday Indian household, personal, office, or leisure use.	TableTop	1000.00	15	24	2026-11-10 06:47:52.331634	t
159	3	7	UrbanWeave Men's Formal Shirt (Kosha Fashion House)	formal cotton-blend shirt. Suitable for everyday Indian household, personal, office, or leisure use.	UrbanWeave	1300.00	46	22	2026-11-10 06:47:52.331634	t
224	167	7	IndigoLane Women's Anarkali Kurta (Desi Drapes)	flowing ethnic anarkali. Suitable for everyday Indian household, personal, office, or leisure use.	IndigoLane	3349.00	109	22	2026-11-10 06:47:52.331634	t
664	95	16	NestNook Wall Decor Set (Mitti & More)	decorative wall art set. Suitable for everyday Indian household, personal, office, or leisure use.	NestNook	2249.00	6	20	2026-11-10 06:47:52.331634	t
794	106	18	TailWaggers Pet Shampoo (PetPal Supplies)	mild pet grooming shampoo. Suitable for everyday Indian household, personal, office, or leisure use.	TailWaggers	519.00	102	12	2026-11-10 06:47:52.331634	t
411	123	10	FarmBasket Basmati Rice 5kg (Cauvery Traders)	premium long-grain basmati rice. Suitable for everyday Indian household, personal, office, or leisure use.	FarmBasket	569.00	42	20	2026-11-10 06:47:52.331634	t
531	96	12	OfficeOrbit Document Folder (Patna Stationery Hub)	durable document storage folder. Suitable for everyday Indian household, personal, office, or leisure use.	OfficeOrbit	99.00	103	11	2026-11-10 06:47:52.331634	t
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_item (order_item_id, order_id, product_id, quantity, unit_price) FROM stdin;
11	13	145	1	5200.00
12	14	180	3	820.00
13	14	292	3	810.00
14	14	721	2	5649.00
15	15	793	3	1299.00
16	16	291	3	1099.00
17	17	301	2	1099.00
18	17	651	2	6549.00
19	17	663	1	1099.00
20	18	244	2	4649.00
21	19	642	2	709.00
22	20	617	2	789.00
23	21	246	2	5299.00
24	21	261	2	259.00
25	21	534	2	289.00
26	22	341	2	229.00
27	23	255	3	3799.00
28	23	515	1	200.00
29	23	713	1	2300.00
30	24	440	3	520.00
31	25	406	1	210.00
32	26	85	2	42049.00
33	26	518	3	399.00
34	26	668	1	519.00
35	27	637	1	1749.00
36	28	289	2	830.00
37	28	415	2	200.00
38	29	749	1	3399.00
39	30	162	3	1200.00
40	31	370	2	830.00
41	31	556	1	1300.00
42	31	639	3	2049.00
43	32	226	1	2349.00
44	32	249	2	2400.00
45	32	527	2	90.00
46	33	77	2	29500.00
47	33	475	2	399.00
48	33	623	3	870.00
49	34	609	3	1549.00
50	34	756	3	519.00
51	35	176	2	859.00
52	35	199	3	2099.00
53	35	318	2	730.00
54	36	27	3	77000.00
55	36	473	1	289.00
56	36	551	2	889.00
57	37	106	3	5449.00
58	37	612	1	1700.00
59	38	572	3	790.00
60	39	207	1	1549.00
61	39	528	3	350.00
62	40	236	1	2800.00
63	41	431	1	219.00
64	41	619	2	3299.00
65	42	106	1	5449.00
66	43	123	2	6849.00
67	43	621	2	1499.00
68	44	387	2	220.00
69	44	547	3	359.00
70	44	634	3	1949.00
71	45	125	3	2499.00
72	45	185	3	880.00
73	45	533	3	160.00
74	46	116	1	2299.00
75	46	248	3	1800.00
76	47	271	2	490.00
77	47	498	2	789.00
78	47	537	1	3799.00
79	48	334	1	610.00
80	48	469	1	610.00
81	48	751	3	480.00
82	49	490	2	1349.00
83	50	201	1	2400.00
84	50	331	1	299.00
85	51	648	1	1299.00
86	51	771	3	609.00
87	52	53	3	2849.00
88	53	9	2	29549.00
89	53	275	3	710.00
90	53	423	1	770.00
91	54	439	2	910.00
92	54	514	3	369.00
93	55	532	3	360.00
94	56	132	1	21049.00
95	56	229	1	2100.00
96	56	669	2	1799.00
97	57	108	2	1449.00
98	57	325	2	380.00
99	58	578	2	519.00
100	59	10	1	71000.00
101	59	217	3	2200.00
102	60	144	2	5249.00
103	60	313	2	389.00
104	60	800	3	649.00
105	61	508	2	239.00
106	61	667	2	990.00
107	62	369	3	470.00
108	62	580	3	3699.00
109	62	651	3	6549.00
110	63	427	2	219.00
111	64	389	3	260.00
112	64	656	3	740.00
113	65	128	1	4400.00
114	65	439	3	910.00
115	65	658	3	1000.00
116	66	180	1	820.00
117	66	211	3	2399.00
118	66	224	2	3349.00
119	67	480	2	220.00
120	67	609	3	1549.00
121	67	671	2	1199.00
122	68	324	2	520.00
123	68	553	2	5600.00
124	69	19	2	106500.00
125	69	669	2	1799.00
126	70	495	3	790.00
127	70	669	2	1799.00
128	71	48	2	52500.00
129	71	458	1	270.00
130	72	492	3	659.00
131	73	382	1	640.00
132	73	399	2	450.00
133	74	58	3	5649.00
134	74	471	3	180.00
135	74	638	2	909.00
136	75	160	2	830.00
137	75	512	1	579.00
138	76	268	3	829.00
139	77	177	3	2000.00
140	77	450	1	499.00
141	77	503	1	480.00
142	78	124	1	7849.00
143	78	482	2	830.00
144	78	571	1	1799.00
145	79	224	2	3349.00
146	79	334	3	610.00
147	79	591	1	2549.00
148	80	351	2	820.00
149	81	191	2	1899.00
150	81	645	2	620.00
151	82	442	2	759.00
152	82	641	2	1300.00
153	82	739	1	769.00
154	83	162	2	1200.00
155	84	352	2	170.00
156	84	412	3	1049.00
157	84	550	1	1100.00
158	85	624	1	1399.00
159	86	329	2	289.00
160	86	592	3	3049.00
161	86	690	1	5299.00
162	87	84	3	3300.00
163	88	653	3	1300.00
164	88	733	2	6799.00
165	89	69	2	1099.00
166	89	652	2	2500.00
167	89	711	3	689.00
168	90	456	3	429.00
169	90	571	3	1799.00
170	90	766	1	3149.00
171	91	142	3	5399.00
172	91	166	2	809.00
173	92	301	1	1099.00
174	93	345	2	260.00
175	93	448	2	120.00
176	93	550	3	1100.00
177	94	139	1	3849.00
178	94	259	2	6700.00
179	94	654	3	2299.00
180	95	174	2	1599.00
181	95	235	2	2099.00
182	96	59	2	84000.00
183	96	118	2	3699.00
184	96	344	3	399.00
185	97	87	2	4100.00
186	98	360	3	480.00
187	98	696	2	2049.00
188	99	331	1	299.00
189	100	5	2	19099.00
190	100	708	2	2000.00
191	101	290	1	699.00
192	101	560	3	6399.00
193	102	608	2	5749.00
194	102	703	3	1000.00
195	102	788	1	629.00
196	103	59	2	84000.00
197	104	201	3	2400.00
198	104	755	2	1299.00
199	105	542	2	1099.00
200	106	392	3	769.00
201	106	638	2	909.00
202	107	531	2	99.00
203	107	691	2	2149.00
204	107	758	1	470.00
205	108	384	1	179.00
206	109	165	1	1249.00
207	109	175	1	1399.00
208	109	320	1	239.00
209	110	6	1	89500.00
210	110	637	1	1749.00
211	111	48	1	52500.00
212	111	735	2	1149.00
213	112	496	3	1499.00
214	112	729	2	919.00
215	113	54	2	7200.00
216	113	315	3	339.00
217	114	368	2	889.00
218	114	718	3	1449.00
219	115	388	3	469.00
220	116	313	1	389.00
221	117	357	2	290.00
222	118	50	3	68099.00
223	118	300	2	620.00
224	118	317	1	289.00
225	119	320	3	239.00
226	120	358	2	190.00
227	121	184	2	4300.00
228	122	439	3	910.00
229	122	505	2	229.00
230	122	564	2	799.00
231	123	413	1	370.00
232	123	588	2	3799.00
233	124	106	1	5449.00
234	124	215	2	1100.00
235	125	116	1	2299.00
236	125	492	3	659.00
237	126	100	3	7300.00
238	126	604	1	919.00
239	127	61	1	58000.00
240	127	331	3	299.00
241	128	446	1	300.00
242	129	437	2	309.00
243	129	761	1	1599.00
244	130	639	2	2049.00
245	131	601	1	1349.00
246	132	106	1	5449.00
247	132	249	2	2400.00
248	133	487	1	950.00
249	133	503	1	480.00
250	133	524	2	80.00
251	134	93	2	5749.00
252	134	320	1	239.00
253	135	585	1	409.00
254	136	284	3	1149.00
255	136	436	1	539.00
256	137	543	1	739.00
257	138	519	3	359.00
258	139	151	2	14500.00
259	139	457	2	209.00
260	139	522	2	309.00
261	140	551	1	889.00
262	141	682	1	1999.00
263	142	62	1	98500.00
264	142	193	3	3049.00
265	142	473	1	289.00
266	143	468	1	940.00
267	143	551	1	889.00
268	144	344	1	399.00
269	144	502	1	959.00
270	145	366	2	690.00
271	145	426	1	469.00
272	145	540	1	1799.00
273	146	405	3	789.00
274	146	468	2	940.00
275	146	711	2	689.00
276	147	295	1	440.00
277	147	355	1	209.00
278	147	570	3	3100.00
279	148	111	1	9949.00
280	148	306	1	1300.00
281	148	331	3	299.00
282	149	261	3	259.00
283	149	602	2	6900.00
284	149	670	2	859.00
285	150	769	3	1749.00
286	151	453	2	599.00
287	151	755	3	1299.00
288	152	373	3	449.00
289	152	778	3	2199.00
290	153	178	3	2200.00
291	153	643	3	1049.00
292	153	738	3	4500.00
293	154	206	1	2249.00
294	154	221	1	960.00
295	154	407	1	1000.00
296	155	351	1	820.00
297	155	744	3	1599.00
298	156	197	2	819.00
299	157	287	2	470.00
300	157	615	3	2049.00
301	157	755	3	1299.00
302	158	102	1	1899.00
303	158	171	3	570.00
304	159	357	1	290.00
305	159	566	1	469.00
306	160	17	2	92500.00
307	160	539	2	1699.00
308	160	615	1	2049.00
309	161	480	1	220.00
310	161	532	2	360.00
311	162	18	1	46599.00
312	162	606	2	1049.00
313	163	635	3	4099.00
314	163	686	1	1400.00
315	163	720	1	1900.00
316	164	38	1	749.00
317	164	642	3	709.00
318	165	788	2	629.00
319	166	266	1	430.00
320	166	337	3	520.00
321	166	394	3	460.00
322	167	123	3	6849.00
323	167	615	2	2049.00
324	168	72	3	7000.00
325	168	492	2	659.00
326	168	778	2	2199.00
327	169	381	3	760.00
328	170	62	2	98500.00
329	170	441	3	150.00
330	171	545	2	1449.00
331	171	589	1	1349.00
332	172	161	2	1799.00
333	172	284	2	1149.00
334	172	759	1	6349.00
335	173	277	1	669.00
336	173	409	1	290.00
337	174	442	2	759.00
338	174	460	3	750.00
339	175	289	2	830.00
340	175	600	3	1800.00
341	176	378	3	570.00
342	176	395	1	230.00
343	176	617	2	789.00
344	177	408	2	309.00
345	177	714	1	1699.00
346	178	570	2	3100.00
347	179	212	3	1900.00
348	179	601	1	1349.00
349	180	446	2	300.00
350	180	528	1	350.00
351	180	788	2	629.00
352	181	289	2	830.00
353	181	500	3	990.00
354	182	215	2	1100.00
355	183	590	2	1100.00
356	184	410	3	659.00
357	184	699	1	460.00
358	184	751	1	480.00
359	185	337	2	520.00
360	185	650	3	970.00
361	185	671	2	1199.00
362	186	244	1	4649.00
363	187	658	2	1000.00
364	188	655	3	759.00
365	189	171	1	570.00
366	189	450	1	499.00
367	190	42	3	23599.00
368	190	722	3	1900.00
369	191	25	2	3199.00
370	191	298	3	879.00
371	191	367	1	379.00
372	192	116	3	2299.00
373	192	282	2	300.00
374	192	669	3	1799.00
375	193	756	3	519.00
376	194	257	3	5299.00
377	195	152	3	12099.00
378	195	391	2	640.00
379	196	329	1	289.00
380	196	585	1	409.00
381	196	765	2	1300.00
382	197	53	3	2849.00
383	198	486	2	789.00
384	198	663	1	1099.00
385	198	758	1	470.00
386	199	744	1	1599.00
387	200	685	2	2399.00
388	201	58	1	5649.00
389	202	165	1	1249.00
390	202	173	1	1600.00
391	202	334	1	610.00
392	203	48	2	52500.00
393	204	450	1	499.00
394	204	461	3	550.00
395	204	507	1	170.00
396	205	406	2	210.00
397	205	452	3	560.00
398	205	584	3	3799.00
399	206	686	2	1400.00
400	207	407	3	1000.00
401	207	508	2	239.00
402	207	687	3	690.00
403	208	92	3	48599.00
404	209	85	1	42049.00
405	209	720	2	1900.00
406	209	754	2	1000.00
407	210	575	3	1299.00
408	211	22	3	13500.00
409	211	30	1	25500.00
410	211	373	1	449.00
411	212	121	2	3049.00
412	212	430	3	279.00
413	213	121	2	3049.00
414	213	576	2	289.00
415	213	761	3	1599.00
416	214	49	3	30049.00
417	215	77	2	29500.00
418	215	80	2	53049.00
419	216	348	1	530.00
420	216	566	3	469.00
421	216	600	3	1800.00
422	217	5	2	19099.00
423	217	51	3	46049.00
424	217	585	2	409.00
425	218	309	3	629.00
426	218	608	1	5749.00
427	219	740	1	2600.00
428	220	162	2	1200.00
429	220	475	1	399.00
430	221	562	3	1249.00
431	222	391	3	640.00
432	222	690	3	5299.00
433	222	770	2	1549.00
434	223	422	2	609.00
435	223	428	1	410.00
436	223	640	2	1500.00
437	224	394	3	460.00
438	225	158	3	1799.00
439	225	435	1	339.00
440	226	530	1	310.00
441	227	87	3	4100.00
442	228	324	2	520.00
443	228	647	1	2549.00
444	229	149	1	4899.00
445	230	74	2	20049.00
446	230	763	1	2499.00
447	230	798	3	880.00
448	231	134	3	8249.00
449	231	423	3	770.00
450	231	457	1	209.00
451	232	179	1	1449.00
452	232	524	3	80.00
453	233	625	1	1349.00
454	233	631	3	1400.00
455	233	711	1	689.00
456	234	387	2	220.00
457	235	380	2	319.00
458	235	645	2	620.00
459	236	169	2	2400.00
460	236	652	1	2500.00
461	237	14	1	30549.00
462	237	63	2	69099.00
463	238	189	1	940.00
464	238	306	1	1300.00
465	239	17	2	92500.00
466	239	458	1	270.00
467	239	797	3	749.00
468	240	704	1	680.00
469	241	464	3	320.00
470	242	16	1	36000.00
471	242	634	2	1949.00
472	243	121	1	3049.00
473	243	345	2	260.00
474	243	657	2	680.00
475	244	272	1	479.00
476	244	280	1	1200.00
477	244	331	2	299.00
478	245	399	1	450.00
479	246	297	3	530.00
480	247	632	3	1149.00
481	248	24	1	101599.00
482	248	156	1	6799.00
483	249	40	2	1400.00
484	249	762	2	4349.00
485	250	12	1	3100.00
486	250	386	1	160.00
487	251	254	3	840.00
488	251	631	2	1400.00
489	252	19	2	106500.00
490	252	138	2	2249.00
491	253	125	1	2499.00
492	253	175	2	1399.00
493	253	178	1	2200.00
494	254	735	3	1149.00
495	255	56	2	4499.00
496	256	7	2	12500.00
497	256	115	3	15549.00
498	256	548	3	1800.00
499	257	79	1	64599.00
500	257	506	3	369.00
501	257	669	3	1799.00
502	258	138	3	2249.00
503	258	175	2	1399.00
504	258	754	1	1000.00
505	259	547	2	359.00
506	260	54	3	7200.00
507	260	770	2	1549.00
508	261	723	2	3100.00
509	262	107	1	2549.00
510	262	423	2	770.00
511	263	58	2	5649.00
512	263	119	3	1799.00
513	263	506	2	369.00
514	264	33	3	1700.00
515	264	512	2	579.00
516	265	321	2	650.00
517	265	444	2	150.00
518	265	694	2	3100.00
519	266	170	3	850.00
520	266	186	2	860.00
521	266	322	1	409.00
522	267	353	3	200.00
523	267	481	2	860.00
524	268	128	3	4400.00
525	268	424	3	699.00
526	268	755	3	1299.00
527	269	164	3	940.00
528	269	489	1	489.00
529	270	350	1	480.00
530	270	476	2	130.00
531	270	612	1	1700.00
532	271	116	1	2299.00
533	271	262	3	1149.00
534	271	747	1	4100.00
535	272	465	1	690.00
536	272	560	2	6399.00
537	273	51	3	46049.00
538	273	134	2	8249.00
539	274	39	3	3449.00
540	274	445	1	280.00
541	274	719	1	880.00
542	275	196	3	3299.00
543	275	740	1	2600.00
544	276	305	3	1000.00
545	277	127	3	6849.00
546	277	335	3	230.00
547	277	456	2	429.00
548	278	168	3	1499.00
549	278	470	3	860.00
550	278	571	1	1799.00
551	279	358	2	190.00
552	279	417	3	469.00
553	279	647	2	2549.00
554	280	64	3	71500.00
555	280	69	1	1099.00
556	281	606	3	1049.00
557	282	676	2	1449.00
558	283	335	1	230.00
559	284	249	2	2400.00
560	284	683	3	2800.00
561	285	215	1	1100.00
562	285	252	2	1149.00
563	286	230	3	449.00
564	286	523	2	160.00
565	286	558	1	1749.00
566	287	355	1	209.00
567	288	765	1	1300.00
568	289	601	1	1349.00
569	290	166	3	809.00
570	290	291	1	1099.00
571	290	410	1	659.00
572	291	156	3	6799.00
573	291	428	3	410.00
574	291	685	3	2399.00
575	292	668	2	519.00
576	292	675	3	830.00
577	292	690	1	5299.00
578	293	167	2	4349.00
579	293	509	2	270.00
580	293	601	3	1349.00
581	294	58	2	5649.00
582	294	201	3	2400.00
583	295	10	1	71000.00
584	295	445	2	280.00
585	295	510	1	189.00
586	296	313	3	389.00
587	296	732	3	929.00
588	297	318	1	730.00
589	297	674	3	509.00
590	298	1	3	59099.00
591	299	710	1	330.00
592	300	72	2	7000.00
593	300	593	3	1000.00
594	301	72	3	7000.00
595	302	149	1	4899.00
596	303	56	2	4499.00
597	303	550	3	1100.00
598	304	117	2	8300.00
599	304	686	1	1400.00
600	305	779	3	3300.00
601	306	206	3	2249.00
602	306	595	2	1799.00
603	306	658	1	1000.00
604	307	392	1	769.00
605	308	84	2	3300.00
606	308	278	3	609.00
607	308	602	3	6900.00
608	309	159	1	1300.00
609	309	224	2	3349.00
610	309	664	3	2249.00
611	310	794	3	519.00
612	311	411	1	569.00
613	312	531	1	99.00
639	340	524	1	80.00
640	341	524	1	80.00
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment (payment_id, order_id, payment_date, payment_method, payment_status, amount, transaction_ref, refund_ref, refunded_at, failure_reason, attempts) FROM stdin;
329	340	\N	UPI	Pending	80.00	\N	\N	\N	\N	0
8	14	\N	Wallet	Failed	16188.00	\N	\N	\N	Card declined by bank	1
16	22	\N	Debit Card	Failed	458.00	\N	\N	\N	Order cancelled before payment	0
17	23	\N	Wallet	Failed	13897.00	\N	\N	\N	Card declined by bank	1
27	33	\N	Net Banking	Pending	62408.00	\N	\N	\N	\N	0
29	35	\N	Debit Card	Failed	9475.00	\N	\N	\N	Order cancelled before payment	0
30	36	\N	Debit Card	Pending	233067.00	\N	\N	\N	\N	0
330	341	2026-11-13 17:44:42.620669	UPI	Successful	80.00	SIM-341-b834e5eb	\N	\N	\N	1
60	66	\N	Wallet	Pending	14715.00	\N	\N	\N	\N	0
61	67	\N	Wallet	Pending	7485.00	\N	\N	\N	\N	0
70	76	\N	UPI	Failed	2487.00	\N	\N	\N	Card declined by bank	1
78	84	\N	Net Banking	Failed	4587.00	\N	\N	\N	Order cancelled before payment	0
81	87	\N	Wallet	Failed	9900.00	\N	\N	\N	Order cancelled before payment	0
84	90	\N	Wallet	Failed	9833.00	\N	\N	\N	Order cancelled before payment	0
86	92	\N	Net Banking	Failed	1099.00	\N	\N	\N	Order cancelled before payment	0
99	105	\N	UPI	Pending	2198.00	\N	\N	\N	\N	0
102	108	\N	UPI	Failed	179.00	\N	\N	\N	Card declined by bank	1
109	115	\N	UPI	Failed	1407.00	\N	\N	\N	Order cancelled before payment	0
111	117	\N	Debit Card	Failed	580.00	\N	\N	\N	Card declined by bank	1
116	122	\N	Debit Card	Failed	4786.00	\N	\N	\N	Order cancelled before payment	0
117	123	\N	Debit Card	Pending	7968.00	\N	\N	\N	\N	0
118	124	\N	UPI	Failed	7649.00	\N	\N	\N	Card declined by bank	1
121	127	\N	Net Banking	Failed	58897.00	\N	\N	\N	Card declined by bank	1
123	129	\N	Wallet	Pending	2217.00	\N	\N	\N	\N	0
134	140	\N	UPI	Pending	889.00	\N	\N	\N	\N	0
137	143	\N	UPI	Pending	1829.00	\N	\N	\N	\N	0
148	154	\N	Wallet	Pending	4209.00	\N	\N	\N	\N	0
151	157	\N	Wallet	Failed	10984.00	\N	\N	\N	Order cancelled before payment	0
152	158	\N	Wallet	Failed	3609.00	\N	\N	\N	Order cancelled before payment	0
153	159	\N	Debit Card	Pending	759.00	\N	\N	\N	\N	0
167	173	\N	Debit Card	Failed	959.00	\N	\N	\N	Order cancelled before payment	0
180	186	\N	Net Banking	Failed	4649.00	\N	\N	\N	Order cancelled before payment	0
181	187	\N	Net Banking	Pending	2000.00	\N	\N	\N	\N	0
186	192	\N	Net Banking	Failed	12894.00	\N	\N	\N	Card declined by bank	1
192	198	\N	Credit Card	Pending	3147.00	\N	\N	\N	\N	0
193	199	\N	Debit Card	Failed	1599.00	\N	\N	\N	Order cancelled before payment	0
201	207	\N	Net Banking	Pending	5548.00	\N	\N	\N	\N	0
204	210	\N	UPI	Failed	3897.00	\N	\N	\N	Order cancelled before payment	0
206	212	\N	Debit Card	Pending	6935.00	\N	\N	\N	\N	0
207	213	\N	UPI	Failed	11473.00	\N	\N	\N	Order cancelled before payment	0
219	225	\N	Net Banking	Failed	5736.00	\N	\N	\N	Order cancelled before payment	0
235	241	\N	Debit Card	Failed	960.00	\N	\N	\N	Card declined by bank	1
250	256	\N	Credit Card	Failed	77047.00	\N	\N	\N	Order cancelled before payment	0
251	257	\N	UPI	Failed	71103.00	\N	\N	\N	Order cancelled before payment	0
253	259	\N	Credit Card	Failed	718.00	\N	\N	\N	Order cancelled before payment	0
254	260	\N	Net Banking	Failed	24698.00	\N	\N	\N	Order cancelled before payment	0
276	282	\N	Wallet	Failed	2898.00	\N	\N	\N	Order cancelled before payment	0
277	283	\N	Debit Card	Failed	230.00	\N	\N	\N	Order cancelled before payment	0
281	287	\N	UPI	Failed	209.00	\N	\N	\N	Card declined by bank	1
287	293	\N	UPI	Pending	13285.00	\N	\N	\N	\N	0
290	296	\N	UPI	Failed	3954.00	\N	\N	\N	Order cancelled before payment	0
297	303	\N	Credit Card	Pending	12298.00	\N	\N	\N	\N	0
21	27	2026-10-02 16:57:52.331634	UPI	Successful	1749.00	SIM-27-7b39b43f	\N	\N	\N	1
22	28	2026-09-01 06:57:52.331634	Wallet	Successful	2060.00	SIM-28-05ff00f4	\N	\N	\N	1
7	13	2026-10-07 15:57:52.331634	Debit Card	Successful	5200.00	SIM-13-a52b427a	\N	\N	\N	2
9	15	2026-10-31 02:57:52.331634	Debit Card	Successful	3897.00	SIM-15-309c6754	\N	\N	\N	1
10	16	2026-09-07 00:57:52.331634	Wallet	Successful	3297.00	SIM-16-90a0f89e	\N	\N	\N	2
11	17	2026-10-29 07:57:52.331634	Net Banking	Successful	16395.00	SIM-17-eac7bab1	\N	\N	\N	1
12	18	2026-10-16 12:57:52.331634	UPI	Successful	9298.00	SIM-18-18729e25	\N	\N	\N	1
13	19	2026-10-11 17:57:52.331634	Net Banking	Successful	1418.00	SIM-19-bbc91a5b	\N	\N	\N	1
14	20	2026-08-12 19:57:52.331634	Wallet	Successful	1578.00	SIM-20-8e2e07a6	\N	\N	\N	1
15	21	2026-09-26 03:57:52.331634	Debit Card	Successful	11694.00	SIM-21-e45ba39f	\N	\N	\N	1
18	24	2026-11-02 14:57:52.331634	UPI	Successful	1560.00	SIM-24-c500a980	\N	\N	\N	1
19	25	2026-08-18 00:57:52.331634	Wallet	Successful	210.00	SIM-25-17118e4f	\N	\N	\N	2
20	26	2026-09-14 12:57:52.331634	Net Banking	Successful	85814.00	SIM-26-6a081ab1	\N	\N	\N	2
23	29	2026-08-16 14:57:52.331634	Debit Card	Successful	3399.00	SIM-29-68da5ad3	\N	\N	\N	1
24	30	2026-09-23 12:57:52.331634	Credit Card	Successful	3600.00	SIM-30-9edb2b5f	\N	\N	\N	2
25	31	2026-09-17 16:57:52.331634	UPI	Successful	9107.00	SIM-31-ed3de717	\N	\N	\N	1
26	32	2026-09-06 04:57:52.331634	Wallet	Successful	7329.00	SIM-32-9d9adaa2	\N	\N	\N	2
28	34	2026-11-04 01:57:52.331634	Credit Card	Successful	6204.00	SIM-34-52b97be3	\N	\N	\N	2
31	37	2026-10-07 13:57:52.331634	Wallet	Successful	18047.00	SIM-37-0f74ecf7	\N	\N	\N	2
32	38	2026-11-03 15:57:52.331634	Net Banking	Successful	2370.00	SIM-38-35b301ce	\N	\N	\N	1
33	39	2026-08-25 04:57:52.331634	UPI	Successful	2599.00	SIM-39-71205689	\N	\N	\N	1
34	40	2026-10-30 23:57:52.331634	UPI	Successful	2800.00	SIM-40-a265c3a7	\N	\N	\N	1
35	41	2026-10-08 00:57:52.331634	Wallet	Successful	6817.00	SIM-41-d1bd7a42	\N	\N	\N	1
36	42	2026-10-29 21:57:52.331634	Credit Card	Successful	5449.00	SIM-42-48b68ccc	\N	\N	\N	1
37	43	2026-08-18 11:57:52.331634	Debit Card	Successful	16696.00	SIM-43-298d448d	\N	\N	\N	1
38	44	2026-09-21 07:57:52.331634	Net Banking	Successful	7364.00	SIM-44-bcce97b2	\N	\N	\N	1
39	45	2026-10-26 07:57:52.331634	Net Banking	Successful	10617.00	SIM-45-226347e6	\N	\N	\N	1
41	47	2026-11-05 01:57:52.331634	UPI	Successful	6357.00	SIM-47-73d43f4e	\N	\N	\N	1
42	48	2026-08-16 12:57:52.331634	Wallet	Successful	2660.00	SIM-48-b46fbf07	\N	\N	\N	1
43	49	2026-09-19 06:57:52.331634	Net Banking	Successful	2698.00	SIM-49-d3cdda03	\N	\N	\N	1
44	50	2026-09-05 02:57:52.331634	UPI	Successful	2699.00	SIM-50-2765ca1a	\N	\N	\N	2
45	51	2026-09-26 09:57:52.331634	Net Banking	Successful	3126.00	SIM-51-e471b5d4	\N	\N	\N	1
46	52	2026-08-26 20:57:52.331634	Wallet	Successful	8547.00	SIM-52-b8aaed4a	\N	\N	\N	2
47	53	2026-10-07 04:57:52.331634	Wallet	Successful	61998.00	SIM-53-99aff17c	\N	\N	\N	1
48	54	2026-09-09 05:57:52.331634	Net Banking	Successful	2927.00	SIM-54-11e27248	\N	\N	\N	2
49	55	2026-09-03 16:57:52.331634	Net Banking	Successful	1080.00	SIM-55-bf95c0f6	\N	\N	\N	1
50	56	2026-09-18 11:57:52.331634	Wallet	Successful	26747.00	SIM-56-07ecc421	\N	\N	\N	2
51	57	2026-10-10 08:57:52.331634	Debit Card	Successful	3658.00	SIM-57-0523e148	\N	\N	\N	1
52	58	2026-10-06 20:57:52.331634	UPI	Successful	1038.00	SIM-58-d50727d6	\N	\N	\N	1
53	59	2026-09-26 00:57:52.331634	Net Banking	Successful	77600.00	SIM-59-9ac62f35	\N	\N	\N	1
54	60	2026-08-31 08:57:52.331634	UPI	Successful	13223.00	SIM-60-69c372f5	\N	\N	\N	1
57	63	2026-09-16 04:57:52.331634	Wallet	Successful	438.00	SIM-63-e328ff57	\N	\N	\N	1
58	64	2026-11-05 03:57:52.331634	Debit Card	Successful	3000.00	SIM-64-fba4185d	\N	\N	\N	2
59	65	2026-08-26 13:57:52.331634	Credit Card	Successful	10130.00	SIM-65-262fc16b	\N	\N	\N	1
62	68	2026-08-20 06:57:52.331634	UPI	Successful	12240.00	SIM-68-3d921edd	\N	\N	\N	2
63	69	2026-11-03 07:57:52.331634	Credit Card	Successful	216598.00	SIM-69-09ee0baf	\N	\N	\N	1
64	70	2026-08-24 20:57:52.331634	Credit Card	Successful	5968.00	SIM-70-365a0e74	\N	\N	\N	1
65	71	2026-08-20 18:57:52.331634	Wallet	Successful	105270.00	SIM-71-95ee2151	\N	\N	\N	1
66	72	2026-10-14 13:57:52.331634	Debit Card	Successful	1977.00	SIM-72-3b828987	\N	\N	\N	1
67	73	2026-09-24 11:57:52.331634	Net Banking	Successful	1540.00	SIM-73-c6821122	\N	\N	\N	1
68	74	2026-10-12 03:57:52.331634	Net Banking	Successful	19305.00	SIM-74-5e7fbdbd	\N	\N	\N	1
69	75	2026-08-15 08:57:52.331634	Debit Card	Successful	2239.00	SIM-75-3de0105f	\N	\N	\N	1
71	77	2026-09-18 19:57:52.331634	Credit Card	Successful	6979.00	SIM-77-5cd74e88	\N	\N	\N	2
72	78	2026-09-04 18:57:52.331634	UPI	Successful	11308.00	SIM-78-b8e1957f	\N	\N	\N	1
73	79	2026-08-28 17:57:52.331634	Credit Card	Successful	11077.00	SIM-79-3e83adfd	\N	\N	\N	1
74	80	2026-09-10 07:57:52.331634	Debit Card	Successful	1640.00	SIM-80-f054319f	\N	\N	\N	2
75	81	2026-08-19 08:57:52.331634	Credit Card	Successful	5038.00	SIM-81-a7a5fa1d	\N	\N	\N	2
76	82	2026-09-02 14:57:52.331634	Debit Card	Successful	4887.00	SIM-82-f3226358	\N	\N	\N	2
77	83	2026-08-21 22:57:52.331634	Debit Card	Successful	2400.00	SIM-83-8c59864d	\N	\N	\N	1
79	85	2026-10-12 19:57:52.331634	Wallet	Successful	1399.00	SIM-85-8bf8e11a	\N	\N	\N	1
80	86	2026-08-23 04:57:52.331634	Wallet	Successful	15024.00	SIM-86-9f53b8e4	\N	\N	\N	1
82	88	2026-10-15 22:57:52.331634	Wallet	Successful	17498.00	SIM-88-8cbcea93	\N	\N	\N	1
83	89	2026-10-16 10:57:52.331634	Net Banking	Successful	9265.00	SIM-89-a964a777	\N	\N	\N	1
85	91	2026-09-24 17:57:52.331634	Credit Card	Successful	17815.00	SIM-91-5708aa88	\N	\N	\N	1
87	93	2026-09-24 03:57:52.331634	UPI	Successful	4060.00	SIM-93-5b71c754	\N	\N	\N	2
88	94	2026-10-12 12:57:52.331634	Credit Card	Successful	24146.00	SIM-94-2423674b	\N	\N	\N	1
89	95	2026-09-21 22:57:52.331634	Credit Card	Successful	7396.00	SIM-95-5de61f00	\N	\N	\N	1
90	96	2026-10-22 00:57:52.331634	Wallet	Successful	176595.00	SIM-96-064a5b30	\N	\N	\N	1
91	97	2026-11-03 07:57:52.331634	UPI	Successful	8200.00	SIM-97-88c670c4	\N	\N	\N	2
92	98	2026-09-19 08:57:52.331634	UPI	Successful	5538.00	SIM-98-01d1f52c	\N	\N	\N	1
93	99	2026-08-30 20:57:52.331634	UPI	Successful	299.00	SIM-99-39eb74c2	\N	\N	\N	1
94	100	2026-08-25 20:57:52.331634	Wallet	Successful	42198.00	SIM-100-a401cd25	\N	\N	\N	1
95	101	2026-09-13 08:57:52.331634	Net Banking	Successful	19896.00	SIM-101-7f5ae84a	\N	\N	\N	1
96	102	2026-09-08 00:57:52.331634	UPI	Successful	15127.00	SIM-102-ca2403fc	\N	\N	\N	1
97	103	2026-08-15 09:57:52.331634	UPI	Successful	168000.00	SIM-103-99df5e7e	\N	\N	\N	1
98	104	2026-08-20 21:57:52.331634	UPI	Successful	9798.00	SIM-104-ae09ee93	\N	\N	\N	2
100	106	2026-09-19 17:57:52.331634	Debit Card	Successful	4125.00	SIM-106-9f9fd809	\N	\N	\N	1
101	107	2026-08-30 15:57:52.331634	UPI	Successful	4966.00	SIM-107-812d15a7	\N	\N	\N	1
103	109	2026-10-17 22:57:52.331634	UPI	Successful	2887.00	SIM-109-6bbfc7c7	\N	\N	\N	1
104	110	2026-09-04 19:57:52.331634	Debit Card	Successful	91249.00	SIM-110-dfa4a14d	\N	\N	\N	1
105	111	2026-10-29 13:57:52.331634	Wallet	Successful	54798.00	SIM-111-7fc124d9	\N	\N	\N	1
106	112	2026-09-05 22:57:52.331634	UPI	Successful	6335.00	SIM-112-58380468	\N	\N	\N	1
107	113	2026-10-11 08:57:52.331634	UPI	Successful	15417.00	SIM-113-14ac329e	\N	\N	\N	1
108	114	2026-09-20 18:57:52.331634	Debit Card	Successful	6125.00	SIM-114-a750c5d9	\N	\N	\N	2
110	116	2026-10-21 06:57:52.331634	Net Banking	Successful	389.00	SIM-116-ffcb3e43	\N	\N	\N	2
112	118	2026-08-19 03:57:52.331634	Credit Card	Successful	205826.00	SIM-118-32a642e1	\N	\N	\N	1
113	119	2026-10-06 16:57:52.331634	Credit Card	Successful	717.00	SIM-119-79823b02	\N	\N	\N	1
114	120	2026-09-16 15:57:52.331634	Wallet	Successful	380.00	SIM-120-24fdbecb	\N	\N	\N	1
115	121	2026-10-29 08:57:52.331634	Wallet	Successful	8600.00	SIM-121-57fbda5f	\N	\N	\N	1
119	125	2026-09-19 18:57:52.331634	Wallet	Successful	4276.00	SIM-125-71189d14	\N	\N	\N	1
120	126	2026-10-30 00:57:52.331634	Net Banking	Successful	22819.00	SIM-126-624f31b2	\N	\N	\N	1
122	128	2026-09-17 03:57:52.331634	Credit Card	Successful	300.00	SIM-128-b2c3d720	\N	\N	\N	1
124	130	2026-10-28 21:57:52.331634	Debit Card	Successful	4098.00	SIM-130-ac69b540	\N	\N	\N	2
125	131	2026-10-08 13:57:52.331634	Wallet	Successful	1349.00	SIM-131-5640fb48	\N	\N	\N	2
126	132	2026-09-27 17:57:52.331634	Debit Card	Successful	10249.00	SIM-132-7141f466	\N	\N	\N	1
128	134	2026-08-12 21:57:52.331634	UPI	Successful	11737.00	SIM-134-d43e2eb1	\N	\N	\N	1
129	135	2026-10-29 11:57:52.331634	Wallet	Successful	409.00	SIM-135-b3b1d74b	\N	\N	\N	2
130	136	2026-09-09 05:57:52.331634	Wallet	Successful	3986.00	SIM-136-6cb9b262	\N	\N	\N	2
131	137	2026-10-10 21:57:52.331634	Wallet	Successful	739.00	SIM-137-18bc1a0a	\N	\N	\N	1
132	138	2026-09-29 22:57:52.331634	Credit Card	Successful	1077.00	SIM-138-060d4918	\N	\N	\N	1
133	139	2026-09-18 21:57:52.331634	Debit Card	Successful	30036.00	SIM-139-a588fdbe	\N	\N	\N	1
136	142	2026-10-08 15:57:52.331634	Wallet	Successful	107936.00	SIM-142-c4e58c57	\N	\N	\N	2
139	145	2026-10-01 05:57:52.331634	Credit Card	Successful	3648.00	SIM-145-deda632c	\N	\N	\N	1
141	147	2026-10-07 18:57:52.331634	Credit Card	Successful	9949.00	SIM-147-68e7ae99	\N	\N	\N	2
142	148	2026-09-13 15:57:52.331634	UPI	Successful	12146.00	SIM-148-7fb61338	\N	\N	\N	1
143	149	2026-08-29 12:57:52.331634	Net Banking	Successful	16295.00	SIM-149-a88430dc	\N	\N	\N	2
144	150	2026-09-10 07:57:52.331634	Net Banking	Successful	5247.00	SIM-150-1f89cbd9	\N	\N	\N	1
145	151	2026-10-06 22:57:52.331634	UPI	Successful	5095.00	SIM-151-8476dc34	\N	\N	\N	1
146	152	2026-09-16 09:57:52.331634	Debit Card	Successful	7944.00	SIM-152-c5585481	\N	\N	\N	1
147	153	2026-10-29 22:57:52.331634	Net Banking	Successful	23247.00	SIM-153-ddbcd634	\N	\N	\N	1
149	155	2026-10-24 03:57:52.331634	Credit Card	Successful	5617.00	SIM-155-a44e3002	\N	\N	\N	2
150	156	2026-10-28 15:57:52.331634	Debit Card	Successful	1638.00	SIM-156-d18d38a5	\N	\N	\N	1
154	160	2026-09-19 08:57:52.331634	UPI	Successful	190447.00	SIM-160-853bc808	\N	\N	\N	1
155	161	2026-10-13 21:57:52.331634	Debit Card	Successful	940.00	SIM-161-5e5ed7cf	\N	\N	\N	1
156	162	2026-09-29 15:57:52.331634	Net Banking	Successful	48697.00	SIM-162-6ca20c75	\N	\N	\N	1
157	163	2026-09-22 07:57:52.331634	Debit Card	Successful	15597.00	SIM-163-9f451388	\N	\N	\N	1
159	165	2026-09-23 01:57:52.331634	UPI	Successful	1258.00	SIM-165-0ce368e3	\N	\N	\N	1
160	166	2026-10-24 09:57:52.331634	Debit Card	Successful	3370.00	SIM-166-6cdd23a3	\N	\N	\N	1
161	167	2026-10-06 07:57:52.331634	Wallet	Successful	24645.00	SIM-167-f8377b4f	\N	\N	\N	1
162	168	2026-08-15 13:57:52.331634	Wallet	Successful	26716.00	SIM-168-f7d97564	\N	\N	\N	1
163	169	2026-11-04 11:57:52.331634	UPI	Successful	2280.00	SIM-169-49ecb3ad	\N	\N	\N	2
164	170	2026-09-10 07:57:52.331634	UPI	Successful	197450.00	SIM-170-1787badc	\N	\N	\N	2
165	171	2026-10-25 18:57:52.331634	Debit Card	Successful	4247.00	SIM-171-9c931fd3	\N	\N	\N	1
166	172	2026-09-20 18:57:52.331634	Debit Card	Successful	12245.00	SIM-172-d4305afc	\N	\N	\N	1
168	174	2026-11-01 15:57:52.331634	Credit Card	Successful	3768.00	SIM-174-a013509e	\N	\N	\N	2
169	175	2026-08-24 09:57:52.331634	Credit Card	Successful	7060.00	SIM-175-5021eeac	\N	\N	\N	1
170	176	2026-08-29 07:57:52.331634	Net Banking	Successful	3518.00	SIM-176-9e5e9ea4	\N	\N	\N	1
171	177	2026-09-16 10:57:52.331634	Credit Card	Successful	2317.00	SIM-177-4aebe8c3	\N	\N	\N	1
172	178	2026-10-14 01:57:52.331634	Credit Card	Successful	6200.00	SIM-178-930c574c	\N	\N	\N	2
173	179	2026-08-27 16:57:52.331634	Net Banking	Successful	7049.00	SIM-179-259bf636	\N	\N	\N	1
174	180	2026-10-05 23:57:52.331634	Wallet	Successful	2208.00	SIM-180-0b6bbac5	\N	\N	\N	1
175	181	2026-10-24 14:57:52.331634	Net Banking	Successful	4630.00	SIM-181-1b0a7385	\N	\N	\N	1
176	182	2026-08-26 14:57:52.331634	Credit Card	Successful	2200.00	SIM-182-26009edf	\N	\N	\N	1
177	183	2026-10-27 00:57:52.331634	Wallet	Successful	2200.00	SIM-183-dbd23675	\N	\N	\N	2
178	184	2026-10-23 11:57:52.331634	Credit Card	Successful	2917.00	SIM-184-410ac499	\N	\N	\N	1
179	185	2026-08-18 09:57:52.331634	Net Banking	Successful	6348.00	SIM-185-a060817d	\N	\N	\N	1
183	189	2026-09-25 03:57:52.331634	UPI	Successful	1069.00	SIM-189-e48ac206	\N	\N	\N	1
184	190	2026-10-06 20:57:52.331634	UPI	Successful	76497.00	SIM-190-d77deba1	\N	\N	\N	1
185	191	2026-08-19 13:57:52.331634	Debit Card	Successful	9414.00	SIM-191-e941a289	\N	\N	\N	1
187	193	2026-11-03 23:57:52.331634	Net Banking	Successful	1557.00	SIM-193-068c6ab7	\N	\N	\N	1
188	194	2026-10-17 08:57:52.331634	Wallet	Successful	15897.00	SIM-194-428ffeaf	\N	\N	\N	2
189	195	2026-11-04 01:57:52.331634	Net Banking	Successful	37577.00	SIM-195-38de21a5	\N	\N	\N	1
190	196	2026-08-15 09:57:52.331634	Wallet	Successful	3298.00	SIM-196-a1dccc22	\N	\N	\N	1
191	197	2026-09-14 16:57:52.331634	UPI	Successful	8547.00	SIM-197-babe100c	\N	\N	\N	1
194	200	2026-08-29 06:57:52.331634	Net Banking	Successful	4798.00	SIM-200-bb37109a	\N	\N	\N	1
195	201	2026-08-17 20:57:52.331634	Credit Card	Successful	5649.00	SIM-201-b4f27750	\N	\N	\N	1
196	202	2026-10-12 08:57:52.331634	Credit Card	Successful	3459.00	SIM-202-2c766d8e	\N	\N	\N	1
197	203	2026-10-27 15:57:52.331634	Net Banking	Successful	105000.00	SIM-203-6311a380	\N	\N	\N	1
198	204	2026-08-31 05:57:52.331634	Credit Card	Successful	2319.00	SIM-204-579a318b	\N	\N	\N	2
199	205	2026-08-18 10:57:52.331634	UPI	Successful	13497.00	SIM-205-cbf51bc0	\N	\N	\N	2
200	206	2026-09-09 11:57:52.331634	Debit Card	Successful	2800.00	SIM-206-7a91b286	\N	\N	\N	1
202	208	2026-10-14 05:57:52.331634	Net Banking	Successful	145797.00	SIM-208-36e79014	\N	\N	\N	2
203	209	2026-08-19 08:57:52.331634	Wallet	Successful	47849.00	SIM-209-7a4842a1	\N	\N	\N	1
205	211	2026-09-02 16:57:52.331634	Wallet	Successful	66449.00	SIM-211-e7cf842a	\N	\N	\N	1
209	215	2026-10-01 03:57:52.331634	Net Banking	Successful	165098.00	SIM-215-73a0329c	\N	\N	\N	1
210	216	2026-10-19 22:57:52.331634	Debit Card	Successful	7337.00	SIM-216-f4d447a8	\N	\N	\N	2
212	218	2026-10-15 04:57:52.331634	Net Banking	Successful	7636.00	SIM-218-91e6d35d	\N	\N	\N	1
213	219	2026-08-23 21:57:52.331634	Credit Card	Successful	2600.00	SIM-219-88b7bb0e	\N	\N	\N	1
214	220	2026-08-28 13:57:52.331634	UPI	Successful	2799.00	SIM-220-4ca5e6ad	\N	\N	\N	1
215	221	2026-10-20 08:57:52.331634	Debit Card	Successful	3747.00	SIM-221-0a0e4ce3	\N	\N	\N	1
216	222	2026-09-21 10:57:52.331634	Wallet	Successful	20915.00	SIM-222-f34387a3	\N	\N	\N	1
217	223	2026-09-06 20:57:52.331634	UPI	Successful	4628.00	SIM-223-0194f3a1	\N	\N	\N	1
218	224	2026-09-16 12:57:52.331634	Wallet	Successful	1380.00	SIM-224-744461cb	\N	\N	\N	1
220	226	2026-09-10 15:57:52.331634	Credit Card	Successful	310.00	SIM-226-e5dc79ca	\N	\N	\N	1
222	228	2026-09-05 02:57:52.331634	UPI	Successful	3589.00	SIM-228-38f421a7	\N	\N	\N	2
223	229	2026-09-18 18:57:52.331634	Credit Card	Successful	4899.00	SIM-229-125ddcf5	\N	\N	\N	2
224	230	2026-09-07 06:57:52.331634	Debit Card	Successful	45237.00	SIM-230-1b84a85a	\N	\N	\N	1
225	231	2026-08-23 06:57:52.331634	Credit Card	Successful	27266.00	SIM-231-00a2bfc8	\N	\N	\N	1
226	232	2026-10-11 00:57:52.331634	Credit Card	Successful	1689.00	SIM-232-328923bb	\N	\N	\N	1
227	233	2026-11-04 19:57:52.331634	Wallet	Successful	6238.00	SIM-233-ce01a34d	\N	\N	\N	1
228	234	2026-09-15 03:57:52.331634	Net Banking	Successful	440.00	SIM-234-a4433e6a	\N	\N	\N	1
229	235	2026-10-15 11:57:52.331634	Credit Card	Successful	1878.00	SIM-235-2573a614	\N	\N	\N	1
230	236	2026-11-05 06:57:52.331634	UPI	Successful	7300.00	SIM-236-fb485459	\N	\N	\N	1
231	237	2026-10-21 07:57:52.331634	Wallet	Successful	168747.00	SIM-237-b423a7c6	\N	\N	\N	1
232	238	2026-10-27 15:57:52.331634	Wallet	Successful	2240.00	SIM-238-84b50d5c	\N	\N	\N	1
233	239	2026-10-13 21:57:52.331634	Debit Card	Successful	187517.00	SIM-239-4b067a70	\N	\N	\N	2
234	240	2026-10-27 18:57:52.331634	Debit Card	Successful	680.00	SIM-240-abb7cf1f	\N	\N	\N	1
236	242	2026-09-01 04:57:52.331634	Credit Card	Successful	39898.00	SIM-242-f6b07064	\N	\N	\N	2
237	243	2026-10-20 11:57:52.331634	Net Banking	Successful	4929.00	SIM-243-512649bb	\N	\N	\N	1
238	244	2026-08-21 13:57:52.331634	Net Banking	Successful	2277.00	SIM-244-e365a8e3	\N	\N	\N	1
239	245	2026-09-04 23:57:52.331634	Net Banking	Successful	450.00	SIM-245-b76130b3	\N	\N	\N	1
240	246	2026-10-05 14:57:52.331634	UPI	Successful	1590.00	SIM-246-ef2aacf6	\N	\N	\N	1
241	247	2026-10-12 05:57:52.331634	Net Banking	Successful	3447.00	SIM-247-137d46d7	\N	\N	\N	1
242	248	2026-10-13 14:57:52.331634	Credit Card	Successful	108398.00	SIM-248-8139936d	\N	\N	\N	1
243	249	2026-09-21 20:57:52.331634	Net Banking	Successful	11498.00	SIM-249-7980fe1c	\N	\N	\N	1
244	250	2026-10-14 22:57:52.331634	Net Banking	Successful	3260.00	SIM-250-03740e2d	\N	\N	\N	1
245	251	2026-09-19 18:57:52.331634	Debit Card	Successful	5320.00	SIM-251-6697570b	\N	\N	\N	1
246	252	2026-10-03 03:57:52.331634	Debit Card	Successful	217498.00	SIM-252-bc17408a	\N	\N	\N	1
247	253	2026-08-29 22:57:52.331634	Net Banking	Successful	7497.00	SIM-253-98a17907	\N	\N	\N	2
248	254	2026-08-18 05:57:52.331634	UPI	Successful	3447.00	SIM-254-326d2d24	\N	\N	\N	1
249	255	2026-09-25 05:57:52.331634	UPI	Successful	8998.00	SIM-255-5ab27ce4	\N	\N	\N	2
252	258	2026-09-18 03:57:52.331634	Debit Card	Successful	10545.00	SIM-258-e35e02b8	\N	\N	\N	1
255	261	2026-10-08 19:57:52.331634	Wallet	Successful	6200.00	SIM-261-7156b89f	\N	\N	\N	1
256	262	2026-10-03 15:57:52.331634	Credit Card	Successful	4089.00	SIM-262-9b7b7cd6	\N	\N	\N	2
257	263	2026-10-30 16:57:52.331634	UPI	Successful	17433.00	SIM-263-8388879e	\N	\N	\N	2
258	264	2026-08-13 01:57:52.331634	Net Banking	Successful	6258.00	SIM-264-7f9aaf99	\N	\N	\N	1
259	265	2026-10-04 23:57:52.331634	Credit Card	Successful	7800.00	SIM-265-4a67b49e	\N	\N	\N	2
261	267	2026-10-13 21:57:52.331634	Credit Card	Successful	2320.00	SIM-267-06733e5c	\N	\N	\N	1
262	268	2026-09-23 13:57:52.331634	Credit Card	Successful	19194.00	SIM-268-28e9eaec	\N	\N	\N	2
263	269	2026-10-30 22:57:52.331634	UPI	Successful	3309.00	SIM-269-47e06291	\N	\N	\N	1
264	270	2026-10-08 18:57:52.331634	Wallet	Successful	2440.00	SIM-270-9d619ced	\N	\N	\N	1
265	271	2026-09-16 03:57:52.331634	Net Banking	Successful	9846.00	SIM-271-599aa2e9	\N	\N	\N	1
266	272	2026-09-20 08:57:52.331634	Net Banking	Successful	13488.00	SIM-272-cbbfbefb	\N	\N	\N	1
267	273	2026-10-18 12:57:52.331634	Net Banking	Successful	154645.00	SIM-273-62a9e6ed	\N	\N	\N	1
268	274	2026-09-21 11:57:52.331634	Wallet	Successful	11507.00	SIM-274-21082f98	\N	\N	\N	2
269	275	2026-08-15 18:57:52.331634	Debit Card	Successful	12497.00	SIM-275-829e356c	\N	\N	\N	1
270	276	2026-09-27 05:57:52.331634	Net Banking	Successful	3000.00	SIM-276-d37220ee	\N	\N	\N	2
271	277	2026-08-12 10:57:52.331634	Net Banking	Successful	22095.00	SIM-277-5985d0c9	\N	\N	\N	1
272	278	2026-08-28 17:57:52.331634	Debit Card	Successful	8876.00	SIM-278-82c8d2b8	\N	\N	\N	1
273	279	2026-09-17 18:57:52.331634	Credit Card	Successful	6885.00	SIM-279-15a3a9b6	\N	\N	\N	2
274	280	2026-09-01 03:57:52.331634	Net Banking	Successful	215599.00	SIM-280-ec2e8748	\N	\N	\N	1
275	281	2026-10-06 02:57:52.331634	UPI	Successful	3147.00	SIM-281-27743d03	\N	\N	\N	1
278	284	2026-09-10 22:57:52.331634	Credit Card	Successful	13200.00	SIM-284-df2fff8c	\N	\N	\N	1
279	285	2026-10-19 20:57:52.331634	Net Banking	Successful	3398.00	SIM-285-76e30a7a	\N	\N	\N	1
280	286	2026-08-30 23:57:52.331634	UPI	Successful	3416.00	SIM-286-4f74a981	\N	\N	\N	1
282	288	2026-09-13 16:57:52.331634	Debit Card	Successful	1300.00	SIM-288-1e1de0bf	\N	\N	\N	1
283	289	2026-10-31 05:57:52.331634	Wallet	Successful	1349.00	SIM-289-07276047	\N	\N	\N	1
284	290	2026-10-21 17:57:52.331634	Wallet	Successful	4185.00	SIM-290-32486cdf	\N	\N	\N	2
285	291	2026-10-04 22:57:52.331634	Wallet	Successful	28824.00	SIM-291-2b8f32c9	\N	\N	\N	1
286	292	2026-09-05 22:57:52.331634	Net Banking	Successful	8827.00	SIM-292-23ca30a0	\N	\N	\N	1
288	294	2026-10-18 12:57:52.331634	Debit Card	Successful	18498.00	SIM-294-d434e225	\N	\N	\N	2
289	295	2026-08-12 21:57:52.331634	Net Banking	Successful	71749.00	SIM-295-b22c0ce7	\N	\N	\N	2
291	297	2026-10-30 12:57:52.331634	Wallet	Successful	2257.00	SIM-297-633afafe	\N	\N	\N	1
292	298	2026-09-19 14:57:52.331634	Wallet	Successful	177297.00	SIM-298-db3c473a	\N	\N	\N	1
293	299	2026-10-10 08:57:52.331634	Credit Card	Successful	330.00	SIM-299-922b2ee9	\N	\N	\N	1
294	300	2026-10-16 10:57:52.331634	Wallet	Successful	17000.00	SIM-300-f05126bc	\N	\N	\N	2
295	301	2026-08-25 20:57:52.331634	Wallet	Successful	21000.00	SIM-301-1877dbd4	\N	\N	\N	2
296	302	2026-09-02 16:57:52.331634	Net Banking	Successful	4899.00	SIM-302-f23eb452	\N	\N	\N	1
298	304	2026-08-27 06:57:52.331634	UPI	Successful	18000.00	SIM-304-372b68db	\N	\N	\N	1
299	305	2026-08-22 23:57:52.331634	Net Banking	Successful	9900.00	SIM-305-0a91a7e3	\N	\N	\N	2
300	306	2026-09-15 03:57:52.331634	Credit Card	Successful	11345.00	SIM-306-f2fd307a	\N	\N	\N	1
301	307	2026-09-23 06:57:52.331634	Net Banking	Successful	769.00	SIM-307-f8e9e9ae	\N	\N	\N	1
302	308	2026-09-03 22:57:52.331634	Wallet	Successful	29127.00	SIM-308-fd5cf023	\N	\N	\N	2
303	309	2026-08-31 04:57:52.331634	UPI	Successful	14745.00	SIM-309-a6b2e05b	\N	\N	\N	1
304	310	2026-10-04 22:57:52.331634	UPI	Successful	1557.00	SIM-310-5b095cbb	\N	\N	\N	2
305	311	2026-10-07 09:57:52.331634	Credit Card	Successful	569.00	SIM-311-df6d65fd	\N	\N	\N	1
306	312	2026-09-18 22:57:52.331634	Debit Card	Successful	99.00	SIM-312-293077f7	\N	\N	\N	1
40	46	2026-10-07 21:57:52.331634	Debit Card	Refunded	7699.00	SIM-46-53cf15ee	SIMREF-46	2026-10-07 22:57:52.331634	\N	1
55	61	2026-11-01 06:57:52.331634	Debit Card	Refunded	2458.00	SIM-61-59592bd1	SIMREF-61	2026-11-01 07:57:52.331634	\N	1
56	62	2026-11-04 20:57:52.331634	UPI	Refunded	32154.00	SIM-62-dc058b38	SIMREF-62	2026-11-04 21:57:52.331634	\N	2
127	133	2026-10-13 08:57:52.331634	UPI	Refunded	1590.00	SIM-133-b62bd73a	SIMREF-133	2026-10-13 09:57:52.331634	\N	2
135	141	2026-09-24 04:57:52.331634	Credit Card	Refunded	1999.00	SIM-141-5987ced5	SIMREF-141	2026-09-24 05:57:52.331634	\N	1
138	144	2026-10-28 08:57:52.331634	Credit Card	Refunded	1358.00	SIM-144-6660901e	SIMREF-144	2026-10-28 09:57:52.331634	\N	1
140	146	2026-08-23 08:57:52.331634	UPI	Refunded	5625.00	SIM-146-a7d6dc8a	SIMREF-146	2026-08-23 09:57:52.331634	\N	1
158	164	2026-10-22 07:57:52.331634	Debit Card	Refunded	2876.00	SIM-164-a307a508	SIMREF-164	2026-10-22 08:57:52.331634	\N	1
182	188	2026-10-09 20:57:52.331634	Debit Card	Refunded	2277.00	SIM-188-931287f7	SIMREF-188	2026-10-09 21:57:52.331634	\N	1
208	214	2026-09-13 19:57:52.331634	UPI	Refunded	90147.00	SIM-214-9e6d9519	SIMREF-214	2026-09-13 20:57:52.331634	\N	1
211	217	2026-08-21 16:57:52.331634	UPI	Refunded	177163.00	SIM-217-58c7b68b	SIMREF-217	2026-08-21 17:57:52.331634	\N	1
221	227	2026-09-30 17:57:52.331634	Credit Card	Refunded	12300.00	SIM-227-ac42732b	SIMREF-227	2026-09-30 18:57:52.331634	\N	1
260	266	2026-09-18 21:57:52.331634	Net Banking	Refunded	4679.00	SIM-266-d0862682	SIMREF-266	2026-09-18 22:57:52.331634	\N	2
\.


--
-- Data for Name: shipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipment (shipment_id, order_id, shipment_date, delivery_date, shipment_status, carrier, tracking_number) FROM stdin;
263	341	\N	\N	Pending	\N	\N
37	53	\N	\N	Pending	\N	\N
4	15	\N	\N	Pending	\N	\N
7	18	\N	\N	Pending	\N	\N
21	37	\N	\N	Pending	\N	\N
25	41	\N	\N	Pending	\N	\N
30	46	\N	\N	Cancelled	\N	\N
34	50	\N	\N	Pending	\N	\N
35	51	\N	\N	Pending	\N	\N
40	56	\N	\N	Pending	\N	\N
43	59	\N	\N	Pending	\N	\N
45	61	\N	\N	Cancelled	\N	\N
46	62	\N	\N	Cancelled	\N	\N
47	63	\N	\N	Pending	\N	\N
49	65	\N	\N	Pending	\N	\N
56	74	\N	\N	Pending	\N	\N
60	79	\N	\N	Pending	\N	\N
65	85	\N	\N	Pending	\N	\N
75	98	\N	\N	Pending	\N	\N
78	101	\N	\N	Pending	\N	\N
79	102	\N	\N	Pending	\N	\N
201	251	\N	\N	Pending	\N	\N
86	111	\N	\N	Pending	\N	\N
87	112	\N	\N	Pending	\N	\N
91	118	\N	\N	Pending	\N	\N
101	133	\N	\N	Cancelled	\N	\N
108	141	\N	\N	Cancelled	\N	\N
110	144	\N	\N	Cancelled	\N	\N
111	145	\N	\N	Pending	\N	\N
112	146	\N	\N	Cancelled	\N	\N
115	149	\N	\N	Pending	\N	\N
116	150	\N	\N	Pending	\N	\N
121	156	\N	\N	Pending	\N	\N
124	162	\N	\N	Pending	\N	\N
126	164	\N	\N	Cancelled	\N	\N
137	176	\N	\N	Pending	\N	\N
146	185	\N	\N	Pending	\N	\N
147	188	\N	\N	Cancelled	\N	\N
149	190	\N	\N	Pending	\N	\N
151	193	\N	\N	Pending	\N	\N
155	197	\N	\N	Pending	\N	\N
193	243	2026-11-14 08:21:36.704333	\N	Shipped	blue dart	TRK000000193
164	209	\N	\N	Pending	\N	\N
166	214	\N	\N	Cancelled	\N	\N
169	217	\N	\N	Cancelled	\N	\N
176	224	\N	\N	Pending	\N	\N
178	227	\N	\N	Cancelled	\N	\N
182	231	\N	\N	Pending	\N	\N
186	235	\N	\N	Pending	\N	\N
189	238	\N	\N	Pending	\N	\N
195	245	\N	\N	Pending	\N	\N
207	261	\N	\N	Pending	\N	\N
208	262	\N	\N	Pending	\N	\N
212	266	\N	\N	Cancelled	\N	\N
230	286	\N	\N	Pending	\N	\N
240	299	\N	\N	Pending	\N	\N
243	302	\N	\N	Pending	\N	\N
245	305	\N	\N	Pending	\N	\N
247	307	\N	\N	Pending	\N	\N
248	308	\N	\N	Pending	\N	\N
15	28	2026-09-02 06:47:52.331634	\N	Shipped	Delhivery	TRK000000015
5	16	2026-09-08 00:47:52.331634	\N	In Transit	DTDC	TRK000000005
8	19	2026-10-12 17:47:52.331634	\N	Shipped	Ecom Express	TRK000000008
10	21	2026-09-27 03:47:52.331634	\N	In Transit	Delhivery	TRK000000010
11	24	2026-11-03 14:47:52.331634	\N	Shipped	BlueDart	TRK000000011
17	30	2026-09-24 12:47:52.331634	\N	Shipped	Delhivery	TRK000000017
18	31	2026-09-18 16:47:52.331634	\N	In Transit	DTDC	TRK000000018
19	32	2026-09-07 04:47:52.331634	\N	In Transit	BlueDart	TRK000000019
22	38	2026-11-04 15:47:52.331634	\N	In Transit	Delhivery	TRK000000022
23	39	2026-08-26 04:47:52.331634	\N	In Transit	BlueDart	TRK000000023
24	40	2026-10-31 23:47:52.331634	\N	In Transit	DTDC	TRK000000024
29	45	2026-10-27 07:47:52.331634	\N	Shipped	Ecom Express	TRK000000029
31	47	2026-11-06 01:47:52.331634	\N	Shipped	Ecom Express	TRK000000031
36	52	2026-08-27 20:47:52.331634	\N	In Transit	Delhivery	TRK000000036
38	54	2026-09-10 05:47:52.331634	\N	In Transit	Delhivery	TRK000000038
39	55	2026-09-04 16:47:52.331634	\N	In Transit	Delhivery	TRK000000039
42	58	2026-10-07 20:47:52.331634	\N	Shipped	DTDC	TRK000000042
44	60	2026-09-01 08:47:52.331634	\N	In Transit	Ecom Express	TRK000000044
48	64	2026-11-06 03:47:52.331634	\N	In Transit	Ecom Express	TRK000000048
50	68	2026-08-21 06:47:52.331634	\N	In Transit	BlueDart	TRK000000050
51	69	2026-11-04 07:47:52.331634	\N	Shipped	BlueDart	TRK000000051
53	71	2026-08-21 18:47:52.331634	\N	Shipped	BlueDart	TRK000000053
57	75	2026-08-16 08:47:52.331634	\N	In Transit	DTDC	TRK000000057
58	77	2026-09-19 19:47:52.331634	\N	In Transit	DTDC	TRK000000058
59	78	2026-09-05 18:47:52.331634	\N	In Transit	Delhivery	TRK000000059
63	82	2026-09-03 14:47:52.331634	\N	Shipped	Delhivery	TRK000000063
64	83	2026-08-22 22:47:52.331634	\N	Shipped	BlueDart	TRK000000064
67	88	2026-10-16 22:47:52.331634	\N	Shipped	BlueDart	TRK000000067
69	91	2026-09-25 17:47:52.331634	\N	Shipped	Delhivery	TRK000000069
73	96	2026-10-23 00:47:52.331634	\N	In Transit	Delhivery	TRK000000073
76	99	2026-08-31 20:47:52.331634	\N	In Transit	BlueDart	TRK000000076
77	100	2026-08-26 20:47:52.331634	\N	In Transit	BlueDart	TRK000000077
82	106	2026-09-20 17:47:52.331634	\N	In Transit	Delhivery	TRK000000082
83	107	2026-08-31 15:47:52.331634	\N	Shipped	Ecom Express	TRK000000083
84	109	2026-10-18 22:47:52.331634	\N	Shipped	Ecom Express	TRK000000084
85	110	2026-09-05 19:47:52.331634	\N	In Transit	Delhivery	TRK000000085
89	114	2026-09-21 18:47:52.331634	\N	In Transit	DTDC	TRK000000089
92	119	2026-10-07 16:47:52.331634	\N	In Transit	Delhivery	TRK000000092
96	126	2026-10-31 00:47:52.331634	\N	Shipped	BlueDart	TRK000000096
97	128	2026-09-18 03:47:52.331634	\N	In Transit	BlueDart	TRK000000097
103	135	2026-10-30 11:47:52.331634	\N	Shipped	Ecom Express	TRK000000103
104	136	2026-09-10 05:47:52.331634	\N	Shipped	Delhivery	TRK000000104
106	138	2026-09-30 22:47:52.331634	\N	Shipped	Delhivery	TRK000000106
117	151	2026-10-07 22:47:52.331634	\N	Shipped	Delhivery	TRK000000117
119	153	2026-10-30 22:47:52.331634	\N	Shipped	Ecom Express	TRK000000119
120	155	2026-10-25 03:47:52.331634	\N	In Transit	BlueDart	TRK000000120
127	165	2026-09-24 01:47:52.331634	\N	In Transit	Delhivery	TRK000000127
128	166	2026-10-25 09:47:52.331634	\N	Shipped	Ecom Express	TRK000000128
129	167	2026-10-07 07:47:52.331634	\N	In Transit	BlueDart	TRK000000129
130	168	2026-08-16 13:47:52.331634	\N	In Transit	Delhivery	TRK000000130
133	171	2026-10-26 18:47:52.331634	\N	Shipped	Delhivery	TRK000000133
136	175	2026-08-25 09:47:52.331634	\N	In Transit	DTDC	TRK000000136
139	178	2026-10-15 01:47:52.331634	\N	In Transit	BlueDart	TRK000000139
140	179	2026-08-28 16:47:52.331634	\N	Shipped	Delhivery	TRK000000140
141	180	2026-10-06 23:47:52.331634	\N	Shipped	Delhivery	TRK000000141
148	189	2026-09-26 03:47:52.331634	\N	Shipped	Ecom Express	TRK000000148
153	195	2026-11-05 01:47:52.331634	\N	In Transit	BlueDart	TRK000000153
156	200	2026-08-30 06:47:52.331634	\N	Shipped	Delhivery	TRK000000156
157	201	2026-08-18 20:47:52.331634	\N	Shipped	DTDC	TRK000000157
159	203	2026-10-28 15:47:52.331634	\N	Shipped	DTDC	TRK000000159
160	204	2026-09-01 05:47:52.331634	\N	Shipped	Ecom Express	TRK000000160
163	208	2026-10-15 05:47:52.331634	\N	In Transit	Delhivery	TRK000000163
168	216	2026-10-20 22:47:52.331634	\N	Shipped	Delhivery	TRK000000168
170	218	2026-10-16 04:47:52.331634	\N	Shipped	DTDC	TRK000000170
171	219	2026-08-24 21:47:52.331634	\N	Shipped	Ecom Express	TRK000000171
174	222	2026-09-22 10:47:52.331634	\N	Shipped	DTDC	TRK000000174
175	223	2026-09-07 20:47:52.331634	\N	Shipped	BlueDart	TRK000000175
179	228	2026-09-06 02:47:52.331634	\N	Shipped	DTDC	TRK000000179
183	232	2026-10-12 00:47:52.331634	\N	In Transit	Ecom Express	TRK000000183
184	233	2026-11-05 19:47:52.331634	\N	In Transit	BlueDart	TRK000000184
185	234	2026-09-16 03:47:52.331634	\N	Shipped	Ecom Express	TRK000000185
187	236	2026-11-06 06:47:52.331634	\N	In Transit	DTDC	TRK000000187
188	237	2026-10-22 07:47:52.331634	\N	In Transit	Ecom Express	TRK000000188
194	244	2026-08-22 13:47:52.331634	\N	Shipped	Delhivery	TRK000000194
196	246	2026-10-06 14:47:52.331634	\N	In Transit	BlueDart	TRK000000196
199	249	2026-09-22 20:47:52.331634	\N	Shipped	BlueDart	TRK000000199
200	250	2026-10-15 22:47:52.331634	\N	In Transit	BlueDart	TRK000000200
204	254	2026-08-19 05:47:52.331634	\N	Shipped	BlueDart	TRK000000204
205	255	2026-09-26 05:47:52.331634	\N	In Transit	Ecom Express	TRK000000205
206	258	2026-09-19 03:47:52.331634	\N	In Transit	BlueDart	TRK000000206
209	263	2026-10-31 16:47:52.331634	\N	In Transit	Delhivery	TRK000000209
210	264	2026-08-14 01:47:52.331634	\N	Shipped	DTDC	TRK000000210
211	265	2026-10-05 23:47:52.331634	\N	Shipped	BlueDart	TRK000000211
213	267	2026-10-14 21:47:52.331634	\N	Shipped	DTDC	TRK000000213
215	269	2026-10-31 22:47:52.331634	\N	Shipped	Ecom Express	TRK000000215
216	270	2026-10-09 18:47:52.331634	\N	Shipped	DTDC	TRK000000216
218	272	2026-09-21 08:47:52.331634	\N	Shipped	Ecom Express	TRK000000218
220	274	2026-09-22 11:47:52.331634	\N	Shipped	BlueDart	TRK000000220
222	276	2026-09-28 05:47:52.331634	\N	Shipped	Ecom Express	TRK000000222
224	278	2026-08-29 17:47:52.331634	\N	In Transit	Delhivery	TRK000000224
225	279	2026-09-18 18:47:52.331634	\N	Shipped	DTDC	TRK000000225
227	281	2026-10-07 02:47:52.331634	\N	In Transit	Delhivery	TRK000000227
228	284	2026-09-11 22:47:52.331634	\N	In Transit	BlueDart	TRK000000228
231	288	2026-09-14 16:47:52.331634	\N	In Transit	BlueDart	TRK000000231
233	290	2026-10-22 17:47:52.331634	\N	In Transit	Delhivery	TRK000000233
234	291	2026-10-05 22:47:52.331634	\N	In Transit	DTDC	TRK000000234
238	297	2026-10-31 12:47:52.331634	\N	Shipped	BlueDart	TRK000000238
239	298	2026-09-20 14:47:52.331634	\N	Shipped	BlueDart	TRK000000239
241	300	2026-10-17 10:47:52.331634	\N	In Transit	Ecom Express	TRK000000241
242	301	2026-08-26 20:47:52.331634	\N	In Transit	DTDC	TRK000000242
244	304	2026-08-28 06:47:52.331634	\N	Shipped	Ecom Express	TRK000000244
249	309	2026-09-01 04:47:52.331634	\N	In Transit	Delhivery	TRK000000249
251	311	2026-10-08 09:47:52.331634	\N	In Transit	BlueDart	TRK000000251
14	27	2026-10-03 16:47:52.331634	2026-10-06 16:47:52.331634	Delivered	Delhivery	TRK000000014
3	13	2026-10-08 15:47:52.331634	2026-10-11 15:47:52.331634	Delivered	Ecom Express	TRK000000003
6	17	2026-10-30 07:47:52.331634	2026-11-02 07:47:52.331634	Delivered	Delhivery	TRK000000006
9	20	2026-08-13 19:47:52.331634	2026-08-16 19:47:52.331634	Delivered	BlueDart	TRK000000009
12	25	2026-08-19 00:47:52.331634	2026-08-22 00:47:52.331634	Delivered	Ecom Express	TRK000000012
13	26	2026-09-15 12:47:52.331634	2026-09-18 12:47:52.331634	Delivered	Ecom Express	TRK000000013
16	29	2026-08-17 14:47:52.331634	2026-08-20 14:47:52.331634	Delivered	DTDC	TRK000000016
20	34	2026-11-05 01:47:52.331634	2026-11-08 01:47:52.331634	Delivered	BlueDart	TRK000000020
26	42	2026-10-30 21:47:52.331634	2026-11-02 21:47:52.331634	Delivered	DTDC	TRK000000026
27	43	2026-08-19 11:47:52.331634	2026-08-22 11:47:52.331634	Delivered	BlueDart	TRK000000027
28	44	2026-09-22 07:47:52.331634	2026-09-25 07:47:52.331634	Delivered	Delhivery	TRK000000028
32	48	2026-08-17 12:47:52.331634	2026-08-20 12:47:52.331634	Delivered	Ecom Express	TRK000000032
33	49	2026-09-20 06:47:52.331634	2026-09-23 06:47:52.331634	Delivered	Ecom Express	TRK000000033
41	57	2026-10-11 08:47:52.331634	2026-10-14 08:47:52.331634	Delivered	DTDC	TRK000000041
52	70	2026-08-25 20:47:52.331634	2026-08-28 20:47:52.331634	Delivered	Delhivery	TRK000000052
54	72	2026-10-15 13:47:52.331634	2026-10-18 13:47:52.331634	Delivered	DTDC	TRK000000054
55	73	2026-09-25 11:47:52.331634	2026-09-28 11:47:52.331634	Delivered	DTDC	TRK000000055
61	80	2026-09-11 07:47:52.331634	2026-09-14 07:47:52.331634	Delivered	BlueDart	TRK000000061
62	81	2026-08-20 08:47:52.331634	2026-08-23 08:47:52.331634	Delivered	DTDC	TRK000000062
66	86	2026-08-24 04:47:52.331634	2026-08-27 04:47:52.331634	Delivered	BlueDart	TRK000000066
68	89	2026-10-17 10:47:52.331634	2026-10-20 10:47:52.331634	Delivered	BlueDart	TRK000000068
70	93	2026-09-25 03:47:52.331634	2026-09-28 03:47:52.331634	Delivered	BlueDart	TRK000000070
71	94	2026-10-13 12:47:52.331634	2026-10-16 12:47:52.331634	Delivered	Ecom Express	TRK000000071
72	95	2026-09-22 22:47:52.331634	2026-09-25 22:47:52.331634	Delivered	Ecom Express	TRK000000072
74	97	2026-11-04 07:47:52.331634	2026-11-07 07:47:52.331634	Delivered	Delhivery	TRK000000074
80	103	2026-08-16 09:47:52.331634	2026-08-19 09:47:52.331634	Delivered	DTDC	TRK000000080
81	104	2026-08-21 21:47:52.331634	2026-08-24 21:47:52.331634	Delivered	DTDC	TRK000000081
88	113	2026-10-12 08:47:52.331634	2026-10-15 08:47:52.331634	Delivered	DTDC	TRK000000088
90	116	2026-10-22 06:47:52.331634	2026-10-25 06:47:52.331634	Delivered	Ecom Express	TRK000000090
93	120	2026-09-17 15:47:52.331634	2026-09-20 15:47:52.331634	Delivered	Ecom Express	TRK000000093
94	121	2026-10-30 08:47:52.331634	2026-11-02 08:47:52.331634	Delivered	Delhivery	TRK000000094
95	125	2026-09-20 18:47:52.331634	2026-09-23 18:47:52.331634	Delivered	Ecom Express	TRK000000095
98	130	2026-10-29 21:47:52.331634	2026-11-01 21:47:52.331634	Delivered	Ecom Express	TRK000000098
99	131	2026-10-09 13:47:52.331634	2026-10-12 13:47:52.331634	Delivered	BlueDart	TRK000000099
100	132	2026-09-28 17:47:52.331634	2026-10-01 17:47:52.331634	Delivered	Delhivery	TRK000000100
102	134	2026-08-13 21:47:52.331634	2026-08-16 21:47:52.331634	Delivered	Delhivery	TRK000000102
105	137	2026-10-11 21:47:52.331634	2026-10-14 21:47:52.331634	Delivered	BlueDart	TRK000000105
107	139	2026-09-19 21:47:52.331634	2026-09-22 21:47:52.331634	Delivered	Ecom Express	TRK000000107
109	142	2026-10-09 15:47:52.331634	2026-10-12 15:47:52.331634	Delivered	Delhivery	TRK000000109
113	147	2026-10-08 18:47:52.331634	2026-10-11 18:47:52.331634	Delivered	Ecom Express	TRK000000113
114	148	2026-09-14 15:47:52.331634	2026-09-17 15:47:52.331634	Delivered	Ecom Express	TRK000000114
118	152	2026-09-17 09:47:52.331634	2026-09-20 09:47:52.331634	Delivered	DTDC	TRK000000118
122	160	2026-09-20 08:47:52.331634	2026-09-23 08:47:52.331634	Delivered	BlueDart	TRK000000122
123	161	2026-10-14 21:47:52.331634	2026-10-17 21:47:52.331634	Delivered	Ecom Express	TRK000000123
125	163	2026-09-23 07:47:52.331634	2026-09-26 07:47:52.331634	Delivered	Delhivery	TRK000000125
131	169	2026-11-05 11:47:52.331634	2026-11-08 11:47:52.331634	Delivered	BlueDart	TRK000000131
132	170	2026-09-11 07:47:52.331634	2026-09-14 07:47:52.331634	Delivered	Delhivery	TRK000000132
134	172	2026-09-21 18:47:52.331634	2026-09-24 18:47:52.331634	Delivered	Delhivery	TRK000000134
135	174	2026-11-02 15:47:52.331634	2026-11-05 15:47:52.331634	Delivered	BlueDart	TRK000000135
138	177	2026-09-17 10:47:52.331634	2026-09-20 10:47:52.331634	Delivered	BlueDart	TRK000000138
142	181	2026-10-25 14:47:52.331634	2026-10-28 14:47:52.331634	Delivered	DTDC	TRK000000142
143	182	2026-08-27 14:47:52.331634	2026-08-30 14:47:52.331634	Delivered	DTDC	TRK000000143
144	183	2026-10-28 00:47:52.331634	2026-10-31 00:47:52.331634	Delivered	Delhivery	TRK000000144
145	184	2026-10-24 11:47:52.331634	2026-10-27 11:47:52.331634	Delivered	Delhivery	TRK000000145
150	191	2026-08-20 13:47:52.331634	2026-08-23 13:47:52.331634	Delivered	Delhivery	TRK000000150
152	194	2026-10-18 08:47:52.331634	2026-10-21 08:47:52.331634	Delivered	Delhivery	TRK000000152
154	196	2026-08-16 09:47:52.331634	2026-08-19 09:47:52.331634	Delivered	DTDC	TRK000000154
158	202	2026-10-13 08:47:52.331634	2026-10-16 08:47:52.331634	Delivered	DTDC	TRK000000158
161	205	2026-08-19 10:47:52.331634	2026-08-22 10:47:52.331634	Delivered	Delhivery	TRK000000161
162	206	2026-09-10 11:47:52.331634	2026-09-13 11:47:52.331634	Delivered	BlueDart	TRK000000162
165	211	2026-09-03 16:47:52.331634	2026-09-06 16:47:52.331634	Delivered	DTDC	TRK000000165
167	215	2026-10-02 03:47:52.331634	2026-10-05 03:47:52.331634	Delivered	Delhivery	TRK000000167
172	220	2026-08-29 13:47:52.331634	2026-09-01 13:47:52.331634	Delivered	BlueDart	TRK000000172
173	221	2026-10-21 08:47:52.331634	2026-10-24 08:47:52.331634	Delivered	Delhivery	TRK000000173
177	226	2026-09-11 15:47:52.331634	2026-09-14 15:47:52.331634	Delivered	DTDC	TRK000000177
180	229	2026-09-19 18:47:52.331634	2026-09-22 18:47:52.331634	Delivered	Delhivery	TRK000000180
181	230	2026-09-08 06:47:52.331634	2026-09-11 06:47:52.331634	Delivered	BlueDart	TRK000000181
190	239	2026-10-14 21:47:52.331634	2026-10-17 21:47:52.331634	Delivered	Delhivery	TRK000000190
191	240	2026-10-28 18:47:52.331634	2026-10-31 18:47:52.331634	Delivered	Delhivery	TRK000000191
192	242	2026-09-02 04:47:52.331634	2026-09-05 04:47:52.331634	Delivered	DTDC	TRK000000192
197	247	2026-10-13 05:47:52.331634	2026-10-16 05:47:52.331634	Delivered	Delhivery	TRK000000197
198	248	2026-10-14 14:47:52.331634	2026-10-17 14:47:52.331634	Delivered	Ecom Express	TRK000000198
202	252	2026-10-04 03:47:52.331634	2026-10-07 03:47:52.331634	Delivered	DTDC	TRK000000202
203	253	2026-08-30 22:47:52.331634	2026-09-02 22:47:52.331634	Delivered	Delhivery	TRK000000203
214	268	2026-09-24 13:47:52.331634	2026-09-27 13:47:52.331634	Delivered	Delhivery	TRK000000214
217	271	2026-09-17 03:47:52.331634	2026-09-20 03:47:52.331634	Delivered	Delhivery	TRK000000217
219	273	2026-10-19 12:47:52.331634	2026-10-22 12:47:52.331634	Delivered	BlueDart	TRK000000219
221	275	2026-08-16 18:47:52.331634	2026-08-19 18:47:52.331634	Delivered	Delhivery	TRK000000221
223	277	2026-08-13 10:47:52.331634	2026-08-16 10:47:52.331634	Delivered	Ecom Express	TRK000000223
226	280	2026-09-02 03:47:52.331634	2026-09-05 03:47:52.331634	Delivered	Ecom Express	TRK000000226
229	285	2026-10-20 20:47:52.331634	2026-10-23 20:47:52.331634	Delivered	Ecom Express	TRK000000229
232	289	2026-11-01 05:47:52.331634	2026-11-04 05:47:52.331634	Delivered	Delhivery	TRK000000232
235	292	2026-09-06 22:47:52.331634	2026-09-09 22:47:52.331634	Delivered	Ecom Express	TRK000000235
236	294	2026-10-19 12:47:52.331634	2026-10-22 12:47:52.331634	Delivered	Delhivery	TRK000000236
237	295	2026-08-13 21:47:52.331634	2026-08-16 21:47:52.331634	Delivered	Ecom Express	TRK000000237
246	306	2026-09-16 03:47:52.331634	2026-09-19 03:47:52.331634	Delivered	Ecom Express	TRK000000246
250	310	2026-10-05 22:47:52.331634	2026-10-08 22:47:52.331634	Delivered	Delhivery	TRK000000250
252	312	2026-09-19 22:47:52.331634	2026-09-22 22:47:52.331634	Delivered	Delhivery	TRK000000252
\.


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.address_address_id_seq', 1592, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_category_id_seq', 211, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1834, true);


--
-- Name: order_event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_event_event_id_seq', 2121, true);


--
-- Name: order_fn_backup_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_fn_backup_backup_id_seq', 4, true);


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_item_order_item_id_seq', 640, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 341, true);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 330, true);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_product_id_seq', 992, true);


--
-- Name: seller_seller_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seller_seller_id_seq', 829, true);


--
-- Name: shipment_shipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipment_shipment_id_seq', 263, true);


--
-- PostgreSQL database dump complete
--


