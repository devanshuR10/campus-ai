--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: edges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.edges (
    edge_id integer NOT NULL,
    from_node integer,
    to_node integer,
    distance double precision NOT NULL
);


--
-- Name: edges_edge_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.edges_edge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edges_edge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.edges_edge_id_seq OWNED BY public.edges.edge_id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    event_time timestamp without time zone NOT NULL,
    society_id integer,
    created_at timestamp without time zone DEFAULT now(),
    place_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: places; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.places (
    place_id integer NOT NULL,
    place_name character varying(100),
    lat double precision,
    lng double precision,
    remark text,
    description text,
    image_url text
);


--
-- Name: places_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.places_place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: places_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.places_place_id_seq OWNED BY public.places.place_id;


--
-- Name: societies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.societies (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    instagram character varying(100),
    twitter character varying(100),
    website character varying(100)
);


--
-- Name: societies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.societies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: societies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.societies_id_seq OWNED BY public.societies.id;


--
-- Name: edges edge_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edges ALTER COLUMN edge_id SET DEFAULT nextval('public.edges_edge_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: places place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.places ALTER COLUMN place_id SET DEFAULT nextval('public.places_place_id_seq'::regclass);


--
-- Name: societies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.societies ALTER COLUMN id SET DEFAULT nextval('public.societies_id_seq'::regclass);


--
-- Data for Name: edges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.edges (edge_id, from_node, to_node, distance) FROM stdin;
1	1	2	83
2	2	1	83
3	2	5	36
4	5	2	36
5	2	3	20
6	3	2	20
7	7	3	36
8	3	7	36
9	4	2	67
10	2	4	67
11	4	106	19
12	106	4	19
13	4	101	59
14	101	4	59
15	7	8	118
16	8	7	118
17	8	9	39
18	9	8	39
19	9	101	79
20	101	9	79
21	8	10	82
22	10	8	82
23	10	11	72
24	11	10	72
25	11	50	41
26	50	11	41
27	11	12	61
28	12	11	61
29	12	241	70
30	241	12	70
31	12	13	97
32	13	12	97
33	13	14	35
34	14	13	35
35	14	15	26
36	15	14	26
37	16	15	35
38	15	16	35
39	17	16	34
40	16	17	34
41	17	18	29
42	18	17	29
43	18	20	19
44	20	18	19
45	21	19	20
46	19	21	20
47	19	22	83
48	22	19	83
49	22	23	50
50	23	22	50
51	23	24	23
52	24	23	23
53	24	27	34
54	27	24	34
55	27	26	25
56	26	27	25
57	26	25	23
58	25	26	23
59	25	213	38
60	213	25	38
61	213	28	11
62	28	213	11
63	28	29	31
64	29	28	31
65	213	212	83
66	212	213	83
67	212	211	54
68	211	212	54
69	211	210	22
70	210	211	22
71	210	207	75
72	207	210	75
73	207	208	13
74	208	207	13
75	207	174	78
76	174	207	78
77	211	217	86
78	217	211	86
79	217	229	34
80	229	217	34
81	218	229	19
82	229	218	19
83	217	215	57
84	215	217	57
85	215	214	40
86	214	215	40
87	214	175	59
88	175	214	59
89	216	215	16
90	215	216	16
93	29	30	18
94	30	29	18
95	30	33	20
96	33	30	20
97	32	33	20
98	33	32	20
99	31	32	22
100	32	31	22
101	31	34	14
102	34	31	14
103	34	35	32
104	35	34	32
105	35	36	27
106	36	35	27
107	38	36	37
108	36	38	37
109	37	38	31
110	38	37	31
111	39	37	56
112	37	39	56
113	39	40	20
114	40	39	20
115	40	41	12
116	41	40	12
117	43	41	12
118	41	43	12
119	42	43	12
120	43	42	12
121	44	42	62
122	42	44	62
123	44	45	23
124	45	44	23
125	45	46	31
126	46	45	31
127	46	47	37
128	47	46	37
129	48	47	24
130	47	48	24
131	49	48	34
132	48	49	34
133	49	230	267
134	230	49	267
135	230	231	37
136	231	230	37
137	231	178	23
138	178	231	23
139	179	178	32
140	178	179	32
141	229	35	103
142	35	229	103
143	210	206	105
144	206	210	105
145	206	204	11
146	204	206	11
147	204	205	19
148	205	204	19
149	204	202	61
150	202	204	61
151	202	203	20
152	203	202	20
153	202	156	72
154	156	202	72
155	241	242	31
156	242	241	31
157	242	244	101
158	244	242	101
159	244	247	71
160	247	244	71
161	244	142	53
162	142	244	53
163	142	141	20
164	141	142	20
165	143	142	15
166	142	143	15
167	140	141	12
168	141	140	12
169	140	139	33
170	139	140	33
171	139	138	35
172	138	139	35
173	139	147	30
174	147	139	30
175	147	148	25
176	148	147	25
177	148	149	18
178	149	148	18
179	149	150	19
180	150	149	19
181	150	151	24
182	151	150	24
183	150	152	30
184	152	150	30
185	10	51	101
186	51	10	101
187	51	52	13
188	52	51	13
189	51	53	25
190	53	51	25
191	51	54	30
192	54	51	30
193	54	55	26
194	55	54	26
195	55	112	43
196	112	55	43
197	112	97	80
198	97	112	80
199	97	102	22
200	102	97	22
201	97	109	10
202	109	97	10
203	109	110	14
204	110	109	14
205	110	111	31
206	111	110	31
207	111	107	20
208	107	111	20
209	107	108	13
210	108	107	13
211	97	98	41
212	98	97	41
213	108	105	19
214	105	108	19
215	107	105	31
216	105	107	31
217	102	103	31
218	103	102	31
219	103	104	21
220	104	103	21
221	102	99	26
222	99	102	26
223	99	100	48
224	100	99	48
225	100	116	40
226	116	100	40
227	100	245	48
228	245	100	48
229	116	114	38
230	114	116	38
231	116	115	37
232	115	116	37
233	114	113	54
234	113	114	54
235	73	113	44
236	113	73	44
237	113	99	83
238	99	113	83
239	56	73	25
240	73	56	25
241	56	83	95
242	83	56	95
243	83	115	66
244	115	83	66
245	80	115	29
246	115	80	29
247	80	79	92
248	79	80	92
249	79	78	25
250	78	79	25
251	78	77	59
252	77	78	59
253	75	77	104
254	77	75	104
255	74	75	60
256	75	74	60
257	5	74	69
258	74	5	69
259	83	84	58
260	84	83	58
261	84	87	28
262	87	84	28
263	84	86	21
264	86	84	21
265	84	85	20
266	85	84	20
267	86	117	34
268	117	86	34
269	117	118	20
270	118	117	20
271	119	118	11
272	118	119	11
273	120	119	22
274	119	120	22
275	120	121	14
276	121	120	14
277	120	122	22
278	122	120	22
279	87	122	15
280	122	87	15
281	122	123	50
282	123	122	50
283	87	88	63
284	88	87	63
285	88	89	33
286	89	88	33
287	89	90	23
288	90	89	23
289	91	90	11
290	90	91	11
291	91	92	26
292	92	91	26
293	91	240	29
294	240	91	29
295	80	81	11
296	81	80	11
297	81	82	38
298	82	81	38
299	81	89	80
300	89	81	80
305	240	239	38
306	239	240	38
307	239	238	21
308	238	239	21
309	238	237	17
310	237	238	17
311	238	236	57
312	236	238	57
313	236	235	10
314	235	236	10
315	236	246	33
316	246	236	33
317	234	246	48
318	246	234	48
319	236	234	52
320	234	236	52
321	233	234	18
322	234	233	18
323	234	232	61
324	232	234	61
325	78	232	94
326	232	78	94
329	123	219	79
330	219	123	79
331	219	220	94
332	220	219	94
333	220	221	30
334	221	220	30
335	221	222	36
336	222	221	36
337	222	220	46
338	220	222	46
339	222	223	80
340	223	222	80
341	224	223	55
342	223	224	55
343	224	131	65
344	131	224	65
345	131	135	25
346	135	131	25
347	132	131	54
348	131	132	54
349	132	133	18
350	133	132	18
351	133	134	19
352	134	133	19
353	133	135	57
354	135	133	57
355	129	130	54
356	130	129	54
357	54	58	35
358	58	54	35
359	58	60	37
360	60	58	37
361	57	60	37
362	60	57	37
363	57	56	42
364	56	57	42
365	57	59	12
366	59	57	12
367	58	61	34
368	61	58	34
369	61	64	8
370	64	61	8
371	64	62	26
372	62	64	26
373	62	63	5
374	63	62	5
375	64	65	35
376	65	64	35
377	65	66	12
378	66	65	12
379	65	67	29
380	67	65	29
381	67	68	20
382	68	67	20
383	67	69	23
384	69	67	23
385	70	71	31
386	71	70	31
387	71	72	34
388	72	71	34
389	72	93	44
390	93	72	44
391	72	124	44
392	124	72	44
393	124	83	110
394	83	124	110
395	124	125	11
396	125	124	11
397	125	126	19
398	126	125	19
399	126	127	24
400	127	126	24
401	95	128	91
402	128	95	91
403	128	126	61
404	126	128	61
405	94	95	10
406	95	94	10
407	129	94	26
408	94	129	26
409	129	95	29
410	95	129	29
411	152	129	82
412	129	152	82
413	153	152	32
414	152	153	32
415	154	153	56
416	153	154	56
417	155	153	106
418	153	155	106
419	155	159	21
420	159	155	21
421	155	157	52
422	157	155	52
423	158	157	78
424	157	158	78
425	158	160	13
426	160	158	13
427	158	163	20
428	163	158	20
429	163	166	16
430	166	163	16
431	163	164	24
432	164	163	24
433	164	167	16
434	167	164	16
435	160	162	37
436	162	160	37
437	158	168	60
438	168	158	60
439	169	168	13
440	168	169	13
441	168	225	126
442	225	168	126
443	224	225	97
444	225	224	97
445	225	226	159
446	226	225	159
447	226	227	48
448	227	226	48
449	227	228	37
450	228	227	37
451	168	171	169
452	171	168	169
453	171	173	88
454	173	171	88
455	168	170	117
456	170	168	117
457	157	160	81
458	160	157	81
459	160	161	103
460	161	160	103
463	155	174	110
464	174	155	110
465	175	174	112
466	174	175	112
467	176	175	211
468	175	176	211
469	176	177	29
470	177	176	29
471	178	176	116
472	176	178	116
473	175	180	38
474	180	175	38
475	180	189	15
476	189	180	15
477	180	185	30
478	185	180	30
479	185	186	33
480	186	185	33
481	186	187	17
482	187	186	17
483	187	188	23
484	188	187	23
485	186	196	20
486	196	186	20
487	186	199	22
488	199	186	22
489	186	198	31
490	198	186	31
491	197	186	38
492	186	197	38
493	193	186	44
494	186	193	44
495	194	186	55
496	186	194	55
497	186	184	56
498	184	186	56
499	180	182	24
500	182	180	24
501	182	183	47
502	183	182	47
503	180	190	14
504	190	180	14
505	180	200	18
506	200	180	18
507	180	191	34
508	191	180	34
509	180	201	41
510	201	180	41
513	156	155	5
514	155	156	5
515	129	136	26
516	136	129	26
517	137	136	15
518	136	137	15
519	137	138	25
520	138	137	25
523	138	247	83
524	247	138	83
525	56	248	90
526	248	56	90
527	124	248	60
528	248	124	60
529	248	83	50
530	83	248	50
533	48	44	70
534	44	48	70
535	42	39	34
536	39	42	34
537	37	34	66
538	34	37	66
541	31	29	56
542	29	31	56
543	25	23	59
544	23	25	59
545	28	25	48
546	25	28	48
551	20	21	65
552	21	20	65
561	23	23	0
563	22	22	0
567	19	18	67
568	18	19	67
569	17	13	62
570	13	17	62
573	54	56	63
574	56	54	63
591	76	75	15
592	75	76	15
597	108	76	86
598	76	108	86
599	96	95	46
600	95	96	46
603	94	93	68
604	93	94	68
609	243	235	89
610	235	243	89
611	238	243	114
612	243	238	114
613	164	165	46
614	165	164	46
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events (id, title, description, event_time, society_id, created_at, place_id) FROM stdin;
2	techsoc	enjoy	2026-04-10 13:45:00	1	2026-04-10 13:45:22.309714	248
3	techsoc	movie screening  	2026-04-11 17:00:00	1	2026-04-10 14:47:59.290886	184
4	techsoc	dance performance 	2026-04-11 14:48:00	1	2026-04-10 14:49:12.74674	184
5	techsoc	hackathon 	2026-04-11 14:51:00	1	2026-04-10 14:52:17.535661	121
6	techsoc	 great gala evening 	2026-04-14 15:20:00	1	2026-04-10 15:21:35.214611	141
7	techsoc	food fest	2026-04-17 15:26:00	1	2026-04-10 15:26:58.584428	161
8	ticc	mental health session	2026-04-13 10:52:00	1	2026-04-13 10:49:54.935115	55
\.


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.places (place_id, place_name, lat, lng, remark, description, image_url) FROM stdin;
1	main gate	30.352216876730207	76.37374145918918	road	\N	\N
2	mg_d3	30.35213939416846	76.37287927381297	road	\N	\N
6	mg_d3s	30.352061161515845	76.37302194163657	road	\N	\N
63	g block canteen	30.352871754961367	76.3690536005019	g block canteen, canteen, food, snacks, lunch, meal, chai, tea, coffee, maggi, fast food, drinks, refreshment, eat, sitting, break, g block food	G Block Canteen is a popular campus food spot offering a variety of snacks, meals, and beverages. It serves items like chai, coffee, maggi, and fast food, making it a convenient place for students to relax, eat, and take breaks between classes.	\N
64	iqbal juice	30.35283513453073	76.36937866232336	iqbal juice, juice shop, juice, fresh juice, fruit juice, shakes, lassi, cold drinks, beverages, drinks, refreshment, energy drink, healthy drink, fruits, smoothie	A well-known juice corner serving fresh fruit juices and shakes . Perfect for a healthy refreshment or a quick energy boost on campus.	\N
14	mg_r1_6_1	30.351755279157782	76.36793302339568	road	\N	\N
86	waterbody cafe	30.354782510784027	76.37004556596447	waterbody cafe, cafe, coffee, chai, tea, snacks, food, drinks, lakeside cafe, water view, relaxing, hangout, refreshments, fast food, beverages	A relaxing lakeside cafe serving coffee, chai, snacks, and refreshments. Known for its peaceful water view and chill vibe, it’s a perfect place to hang out and take a break.	\N
16	mg_r1_6_2	30.35169741454079	76.3673053864862	road	\N	\N
17	mg_r1_7	30.351393939956047	76.36732385667725	road	\N	\N
21	mg_r1_9_1	30.351451289433356	76.3663214232957	road	\N	\N
24	mg_r1_11_1	30.351315484649287	76.36489815188581	road	\N	\N
26	mg_r1_12_1	30.351245478417592	76.36430012742694	road	\N	\N
105	aahar canteen	30.353266772210624	76.37219118775819	aahar canteen, canteen, food, snacks, lunch, meal, chai, tea, coffee, fast food, drinks, refreshment, eat, sitting, break, campus food	Aahar Canteen is a popular campus food spot offering a variety of snacks, meals, and beverages including chai, coffee, and fast food. It’s a convenient place for students to eat, relax, and take breaks.	\N
30	mg_r1_14_1	30.351074331788155	76.36341766454322	road	\N	\N
32	mg_r1_15_1	30.35108937668767	76.36301399208648	road	\N	\N
35	mg_r1_16_1	30.351160916887913	76.36276425856514	road	\N	\N
38	mg_r1_17_1	30.35107759132247	76.36210577625198	road	\N	\N
40	mg_r1_18_1	30.350838799104338	76.36140058159879	road	\N	\N
45	mg_r1_20_1	30.350817955217785	76.36050809940616	road	\N	\N
47	mg_r1_21_1	30.350731689116518	76.35981608469838	road	\N	\N
51	mg_r1_3_1	30.35263676499687	76.37018110346266	road	\N	\N
54	mg_r1_3_2	30.35290623136941	76.37013508593051	road	\N	\N
56	mg_r1_3_3	30.353470996098128	76.37008036761671	road	\N	\N
57	mg_r1_3_3_1	30.353327494301553	76.36967267184644	road	\N	\N
58	mg_r1_3_2_1	30.352873842076413	76.36977727799803	road	\N	\N
61	mg_r1_3_2_2	30.352788430852847	76.36943983860004	road	\N	\N
62	mg_r1_3_2_3	30.35285786761488	76.3691072446822	road	\N	\N
65	mg_r1_3_2_2_1	30.353137798800667	76.3692992228683	road	\N	\N
67	mg_r1_3_2_2_2	30.353394194357847	76.36928825852247	road	\N	\N
69	gb_1	30.353600829056827	76.36925059020078	road	\N	\N
70	gb_2	30.35371539873645	76.36920499264752	road	\N	\N
71	gb_3	30.353688781550115	76.36888044535672	road	\N	\N
72	gb_4	30.35399376287684	76.36882009565389	road	\N	\N
74	mg_r3_1	30.35273471375173	76.37351643409622	road	\N	\N
75	mg_r3_2	30.353218675001738	76.37324104119301	road	\N	\N
77	mg_r3_3	30.35404320448028	76.37273864001156	road	\N	\N
78	mg_r3_4	30.354548614977617	76.37256218214888	road	\N	\N
81	cr_2_1	30.35448946881764	76.37134630362125	road	\N	\N
84	cr_3_1	30.354796397857346	76.37026282489468	road	\N	\N
87	cr_3_2	30.35504920245155	76.37024490083216	road	\N	\N
88	cr_3_2_1	30.355155669672985	76.37089131320475	road	\N	\N
89	cr_2_2	30.35520211983137	76.37123450769575	road	\N	\N
90	cr_2_2_1	30.35524609536812	76.37146517767103	road	\N	\N
91	cr_2_2_1_1	30.355341648887983	76.37143853396857	road	\N	\N
95	cr_5_1	30.35408337958939	76.3676574585847	road	\N	\N
103	e block_1	30.35343107326517	76.37193988649675	road	\N	\N
106	mg_r2_1	30.352519179919074	76.37212829625851	road	\N	\N
107	mg_r2_2	30.352998293892455	76.3722704533363	road	\N	\N
109	b block exit	30.35308441366376	76.37171718063072	road	\N	\N
110	b block exit 1	30.35296174230149	76.37174400272087	road	\N	\N
111	b block exit 2	30.352996460627175	76.37206050338463	road	\N	\N
112	b block cor1	30.353068387284353	76.37083329718952	road	\N	\N
113	c block cor1	30.353494264097147	76.37076624196415	road	\N	\N
114	d block cor1	30.353978388756016	76.3707023167268	road	\N	\N
115	cr_2.5	30.35436464142582	76.37105924293371	road	\N	\N
116	d block enter	30.35403366418166	76.37109142944189	road	\N	\N
3	mg_r1	30.35198015129574	76.37277466766139	main road	\N	\N
4	mg_r2	30.352380572587315	76.37223822585841	main road\n	\N	\N
5	mg_r3	30.352459267908575	76.37287122718593	main road	\N	\N
7	mg_r1_1	30.351890672236888	76.37241759231262	main road	\N	\N
8	mg_r1_2	30.351816605623515	76.37118647577938	main road	\N	\N
11	mg_r1_4	30.351626228632075	76.36960660726784	main road	\N	\N
12	mg_r1_5	30.35157013075906	76.36897282615793	main road	\N	\N
13	mg_r1_6	30.351446227787978	76.36797164968512	main road	\N	\N
18	mg_r1_8	30.351348598789524	76.36702198845555	main road	\N	\N
19	mg_r1_9	30.35126990257496	76.36632595521618	main road	\N	\N
22	mg_r1_10	30.351155777505454	76.36546711305944	main road	\N	\N
23	mg_r1_11	30.3511141147294	76.3649491138571	main road	\N	\N
25	mg_r1_12	30.351041793752806	76.36434304277118	main road	\N	\N
28	mg_r1_13	30.35096578544278	76.36384871513836	main road	\N	\N
29	mg_r1_14	30.350937770286794	76.3635222706948	main road	\N	\N
31	mg_r1_15	30.350896107417917	76.3629455957566	main road	\N	\N
34	mg_r1_16	30.350878535517786	76.36280449170036	main road	\N	\N
37	mg_r1_17	30.350798681621843	76.36212186950607	main road	\N	\N
39	mg_r1_18	30.35071496762241	76.3615467619901	main road	\N	\N
42	mg_r1_19	30.350677933877748	76.36119673371365	main road	\N	\N
43	mg_r1_19_1\n	30.350785754648374	76.36117731055538	road	\N	\N
44	mg_r1_20	30.350614269663055	76.36055369695941	main road	\N	\N
48	mg_r1_21	30.350518744929676	76.35983217795247	main road	\N	\N
49	mg_r1_22	30.350488654952887	76.35948349078053	main road	\N	\N
79	cr_1	30.35451975756787	76.37230406244879	main road	\N	\N
80	cr_2	30.354392258958097	76.37135703245731	main road	\N	\N
83	cr_3	30.35428557603407	76.37038074416395	main road	\N	\N
93	cr_4	30.35405959682578	76.36836549262082	main road	\N	\N
94	cr_5	30.35399079838871	76.36766550521175	main road	\N	\N
118	usw2	30.35494164616634	76.36964413931707	road	\N	\N
122	usw5	30.355065490930315	76.37008587107161	road	\N	\N
123	usw6	30.355511716214025	76.37004814800797	road	\N	\N
124	cr_3.5	30.354140603427357	76.36924736311937	road	\N	\N
125	cr_3.5_1	30.354238970799546	76.36922724655176	road	\N	\N
126	cr_3.5_2	30.354411610507526	76.3691977422526	road	\N	\N
119	usw3	30.355036540973632	76.36963368961493	road	\N	\N
128	cr_5_1_1	30.35432010806408	76.36856935567647	road	\N	\N
130	cr_6_1	30.354445150350966	76.3673227477407	road	\N	\N
131	cr_6_2	30.35498443210933	76.36722350600715	road	\N	\N
132	cr_6_1.5	30.354503450794965	76.36728241933669	road	\N	\N
133	cr_6_1.5_1	30.354482620121885	76.36709734691466	road	\N	\N
120	usw4	30.35505158526391	76.36985765406767	road	\N	\N
108	amritsari kulcha zone	30.353098976965363	76.37220473921543	amritsari kulcha zone, kulcha, amritsari kulcha, food, punjabi food, snacks, lunch, meal, street food, fast food, butter kulcha, chole kulcha, eat, spicy food, desi food, north indian food	A popular food spot serving authentic Amritsari kulchas with chole and other Punjabi dishes. Known for its rich flavors and satisfying meals, it’s a great place for enjoying spicy and delicious street food.	\N
136	cr_6l_1	30.353744233207724	76.3674842157551	road	\N	\N
138	ncr_1	30.35340611804881	76.36740426637687	road	\N	\N
139	ncr_2	30.35329814062528	76.36706093418444	road	\N	\N
140	ncr_3	30.353002157296682	76.36707926230929	road	\N	\N
142	ncr_4	30.35276714770531	76.36716432133235	road	\N	\N
145	ncr_4_2	30.3524641301861	76.3668200437513	road	\N	\N
146	ncr_4_3	30.352373053914768	76.36654526285608	road	\N	\N
147	ncr_2_1	30.353292047555815	76.36674596565085	road	\N	\N
148	ncr_2_2	30.353316585178224	76.36648176806288	road	\N	\N
149	ncr_2_2_1	30.3534767762548	76.36645508719593	road	\N	\N
141	nirvana fountain	30.352899543980328	76.3670275286726	nirvana fountain, fountain, water fountain, nirvana, water feature, landmark, campus fountain, relaxing spot, hangout, sitting area, aesthetic, garden fountain,relax ,peace 	A beautiful fountain area known for its peaceful vibe and aesthetic surroundings. Perfect for relaxing, sitting with friends, or enjoying a quiet break.	https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTiK6w7atrgy0deQm7cdLbO8XqRw0ODv-0r4QMs1HxGi1DiEUVb\n
157	cr_9_1	30.354184655600307	76.3649789476569	road	\N	\N
158	cr_9_2	30.354879136957557	76.36487257767578	road	\N	\N
151	Kravings	30.353635322340484	76.36683864308506	craving, cafe, food, snacks, fast food, drinks, coffee, chai, tea, dessert, hangout, relax, sitting area, indoor seating, comfort, chill, refreshment, meet, talk,Domino’s, NIC, Barista, and cafes	Food hub with multiple outlets including Domino’s, NIC, Barista, and cafes. Ideal for food, desserts, and hangouts.	https://i.ytimg.com/vi/8Z9kpPITGUs/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHBSlB63o8F4ZAOMJ_Nwl06eSowA
160	fete area gate 2	30.354879899681315	76.36474171373598	road	\N	\N
161	fete area	30.354218242772916	76.36398499961841	football, hockey, football , open sport filed, multiple posts, short filed play,long field play, open ground, events ,	\N	https://thapar.edu/upload/images/%288%29_MULTYPURPOSE_GROUND.jpg
163	cr_9_2_1	30.354955435034455	76.36505647144476	road	\N	\N
164	cr_9_2_2	30.354992467160116	76.36530323467413	road	\N	\N
165	basketball coutrs	30.355036442791135	76.36577530346075	basketball court, basketball, sports, play, game, court, outdoor court, indoor court, training, practice, fitness, recreation, hoops	\N	https://thapar.edu/upload/images/SYNTHETIC_BASKETBALL_COURT.jpg
168	cr_9_3	30.35542115951103	76.36482334866663	road	\N	\N
169	sports department	30.35554116088192	76.36484295129776	road	\N	\N
171	cr_9_4	30.35692771289218	76.36458938569572	road	\N	\N
172	cr_9_5	30.357581225817267	76.36448209733513	road	\N	\N
180	cr_11_1	30.35384989275315	76.36277596928358	road	\N	\N
182	cr_11__2	30.353829907600485	76.36302475580095	road	\N	\N
183	cr_11_2_1	30.354246522998725	76.36296038278459	road	\N	\N
185	cr_11_3	30.353814535579364	76.3624634149677	road	\N	\N
186	cr_11_4	30.354013585411124	76.36220860511129	road	\N	\N
187	cr_11_5	30.353958036661613	76.36204230815237	road	\N	\N
202	h_inter_1	30.35303473175717	76.36512111072892	road	\N	\N
204	h_inter_2	30.352490973069475	76.36522221541355	road	\N	\N
205	h canteen	30.35249560220255	76.36502641415547	road	\N	\N
206	h_inter_3	30.352391854677133	76.36523192395076	road	\N	\N
207	cr_10_1	30.35291213885015	76.36406118487972	road	\N	\N
210	cr_10_2	30.352246926051926	76.36415571408918	road	\N	\N
211	cr_10_2_1	30.35224202801054	76.36393129345478	road	\N	\N
212	cr_10_2_1_1	30.35175407913758	76.36393358935561	road	\N	\N
213	cr_10_2_1_2	30.35100385616562	76.36394953480425	road	\N	\N
214	cr_11_l_1	30.352978317496163	76.36284198847008	road	\N	\N
215	cr_11_l_2	30.35262481313645	76.3628872593545	road	\N	\N
217	cr_11_l_3	30.35213085667011	76.36304464413449	road	\N	\N
219	usw6_1	30.35620060592468	76.36984050210134	road	\N	\N
220	usw6_1_1	30.35579325680193	76.3689875596346	road	\N	\N
222	hs1	30.355670183224603	76.36853338751726	road	\N	\N
223	hs2	30.355565058849844	76.36770732650702	road	\N	\N
224	hs3	30.355565058849844	76.36713601598684	road	\N	\N
225	hs4	30.355566831208165	76.36612955933894	road	\N	\N
226	hs4_1	30.356983924940465	76.36591553316116	road	\N	\N
227	hs4_1_1	30.357069559934143	76.3664082654552	road	\N	\N
229	o_back	30.352085653548308	76.36269298383354	road	\N	\N
230	mg_r1_22_1	30.352875803028724	76.3591912955773	road	\N	\N
231	mg_r1_22_2	30.35294986884032	76.35956680483939	road	\N	\N
232	mg_r3_5	30.35539293246041	76.37253196295033	road	\N	\N
233	gate 2	30.35578648261612	76.37281755251206	road	\N	\N
234	mg_r3_6	30.355919491581407	76.37271468190809	road	\N	\N
129	cr_6	30.35396258214304	76.36739381413712	main road	\N	\N
144	ncr_4_1	30.3527219998942	76.36703438384019	road	\N	\N
152	cr_7	30.353877385024216	76.36654193460188	main road	\N	\N
153	cr_8	30.35384500142021	76.36621202289305	main road	\N	\N
155	cr_9	30.353727252610568	76.36511371270485	main road	\N	\N
174	cr_10	30.35360983506877	76.36397096416813	main road	\N	\N
175	cr_11	30.353512624335266	76.36280956766468	main road	\N	\N
176	cr_12\n	30.35325958451672	76.36062568923991	main road	\N	\N
178	cr_13	30.35312160345452	76.35942516850812	main road	\N	\N
162	badminton courts	30.355213563354756	76.36469042058933	badminton courts, badminton court, sports, indoor sports, outdoor sports, play, game, racket sport, fitness, training, practice, shuttle, court, recreation	\N	http://thapar.edu/upload/images/BADMINTON_HALL.jpg
236	mg_r3_6_1	30.356118101174857	76.37221953571701	road	\N	\N
9	auditorium	30.352158771199502	76.37111639736419	auditorium	\N	\N
238	vlab_1	30.355801713060824	76.37174563723735	road	\N	\N
239	vlab_2	30.355632755271184	76.37163834887676	road	\N	\N
240	vlab_3	30.35554943351408	76.37125479298763	road	\N	\N
241	mg_r1_5_1	30.3521732526931	76.36875038124988	road	\N	\N
242	mg_r1_5_2	30.352418839822246	76.3685977764484	road	\N	\N
85	waterbody	30.354814913952	76.37005897700955	waterbody,near libarary,fountain,relax, free time , study	A calm and airy spot near the library with seating, greenery, and a small fountain feature. Perfect for relaxing, studying outdoors, or taking a peaceful break.	\N
244	mg_r1_5_3	30.352886570582765	76.36770005898751	road	\N	\N
154	swimming pool	30.3543422223072	76.36611464582728	swimming pool, pool, swim, swimming, water, sports, fitness, recreation, leisure, aquatic, training, exercise, relaxation	\N	https://thapar.edu/upload/images/%289%29_SWIMMING_POOL.jpg
246	flavours cafe	30.356300550215114	76.37248644987926	road	\N	\N
247	nirvana__gblock_entry 1	30.35330503157534	76.36826513043266	road	\N	\N
249	\N	\N	\N	\N	\N	\N
10	mg_r1_3	30.351741789022064	76.37034123895889	main road	\N	\N
251	\N	\N	\N	\N	\N	\N
15	hostel q	30.35175643644978	76.36766480249419	Vahni Hall, hostel -Q,hostel q, girl hostel	\N	\N
20	mg_r1_8_1	30.351515249387912	76.3669965074699	dhriti hall,girls hostel	\N	\N
27	agira hall	30.351305544383223	76.36454790830612	hostel-a, agira hall,boys hostel	\N	\N
33	hostel b	30.351126410276613	76.36321918107612	Amritam Hal ,boys hostel,hostel-b	\N	\N
36	hostel o	30.35115050119612	76.36247860330505	hostel -o ,vyom hall,boys hostel	\N	\N
41	hostel c	30.35085963055319	76.36127451777509	hostel-c ,boys hostel ,Prithvi Hall.	\N	\N
46	hostel d	30.350821958795013	76.36018420451917	hostel -d ,nerrram hall thapar,boys hostel	\N	\N
50	guest house	30.351993622064757	76.36957139129642	guest house,parents accomidation 	\N	\N
52	nescafe	30.35259047372307	76.37005503963896	coffee, chai, tea, cafe, snacks, food,nescafe	\N	\N
53	atm	30.3526884615858	76.37043391212198	bank,money, withdraw,	\N	\N
55	b block	30.35299883060004	76.37038767758406	b block ,electronic and electrical department,various classroom, \n	\N	\N
59	g block	30.353336752488328	76.36954392581373	g block ,mathametics,maths department ,chemistry lab	\N	\N
60	g block parking	30.35305073317332	76.36945366859436	parking gblock parking	\N	\N
66	g block stalls	30.35313548424935	76.36917584125362	g block stalls, stalls, food stalls, street food, snacks, chai, tea, coffee, maggi, fast food, drinks, refreshment,  vendors, hangout, quick bite	\N	\N
68	nirvana gblock enrty	30.35339072253993	76.3690777051148	nirvana g block entry, nirvana entry, g block entry, entrance, gate, entry point, nirvana gate, g block gate, entry gate, main entry, access point	\N	\N
73	c block	30.35340097447949	76.3703257516552	c block ,C-Block at Thapar Institute of Engineering and Technology houses the Electrical & Instrumentation Engineering Department (EIED),various classroom, 	\N	\N
76	h block	30.353163125800897	76.37309888411522	h block ,postgraduate studies, research laboratories, and various classroom, 	\N	\N
82	manufacturing lab	30.35458436406352	76.37172985951038	manufacturing lab, mechanical lab, mechanical department, mech department, workshop, production lab, machining, fabrication, engineering lab, practical lab, machines, tools, mechanical engineering	\N	\N
96	sky walk lp side	30.354171331648878	76.36812952737132	near girls hostel sky walk and lp side	\N	\N
97	b block_1	30.35316205975097	76.37165885618585	b block  junction 	\N	\N
98	c hall	30.353180576154962	76.3720826452102	c hall ,c hall, meeting hall, seminar hall, guest lecture, lecture hall, conference, presentation, auditorium, event space, discussion, gathering, talk	\N	\N
99	e block	30.35358793615602	76.37162666967767	e block, block e, academic block, classrooms, lecture halls, study, department, labs, faculty rooms, education, teaching	\N	\N
100	d block	30.35400455258461	76.37150865248101	d block, block d, academic block, classrooms, lecture halls, study, department, labs, faculty rooms, education, teaching	\N	\N
102	bc block join	30.35335469327171	76.37162875025102	bc block join	\N	\N
104	e block enter	30.35345884779347	76.37216116874048	e block 	\N	\N
117	usw_1	30.35476805786601	76.36969644239286	near lt	\N	\N
121	csed	30.35517309675432	76.36983217308203	csed computer department, computer science department, cse department, cs department, programming, coding, software, labs, computers, engineering, it department, technology, study	\N	\N
127	lt	30.354622853764845	76.36925457320214	class ,LT ,teaches	\N	\N
134	vashudha hall	30.354366894079604	76.36694714320983	vashudha hall	\N	\N
135	hostel e	30.354981307204202	76.36696692347937	hostel-e ,girls hostel	\N	\N
137	nirvana cr enterence	30.353611703555487	76.36751180935738	park enters,	\N	\N
143	back hostel q	30.35265613865006	76.36724643685027	near park ,nirvana	\N	\N
150	front craving	30.353607547862282	76.36658785654217	tea shop ,cravings near	\N	\N
156	h instersection	30.353680961852703	76.36509761945076	junctionn on road	\N	\N
159	fete area gate 1	30.353795701990745	76.36490642653486	fete area gate 1, fete gate 1, gate 1, entry gate, sports area, event ground, open ground, open space, events, fest area, gathering, activities, access point, main entry	\N	\N
170	cricket ground	30.355870001967137	76.36372571439293	cricket ground, cricket field, cricket, sports, play, game, ground, pitch, stadium, outdoor sports, training, practice, match, recreation	\N	\N
173	hostel k	30.35684617075074	76.36367316140513	hostel k ,boys hostel	\N	\N
177	hostel m	30.352997626857775	76.36065787574809	premium hostel.hostel -m,boys hostel	\N	\N
179	back gate\n	30.35311465979927	76.35909257459028	back gate, rear gate, exit gate, entry gate, backside gate, secondary gate, access point, campus exit, gate, entrance	\N	\N
203	hostel h	30.353011423908672	76.36491726284379	hostel -h \n,boys hostel	\N	\N
208	hostel j	30.35291121964532	76.36392314307876	hostel -j ,boys hostel ,tejass hall	\N	\N
216	temple	30.352550634155914	76.36273960699923	maha shiva temple, temple, shiva temple, mandir, religious place, worship, prayer, spirituality, pooja, hindu temple, peaceful place, meditation, devotion	\N	\N
218	gurudwara sahib	30.352224434138115	76.36257380247116	gurudwara sahib, gurudwara, sikh temple, gurdwara, religious place, worship, prayer, langar, sikh, spiritual, seva, peaceful place, meditation	\N	\N
221	health center	30.355948327406555	76.36873006756917	health center, medical center, clinic, hospital, doctor, treatment, first aid, emergency, health services, checkup, pharmacy, care, medical help	\N	\N
228	hostel l	30.357396323123442	76.36636365323488	hostel i ,girsl hostel	\N	\N
235	teslas	30.356203736926446	76.372216853508	teslas building, tesla building, tesla block, academic building, classrooms, labs, engineering, study, research, faculty rooms, technology, innovation	\N	\N
237	venture lab thapar	30.355884338336264	76.37159189880752	venture lab thapar, venture lab, innovation lab, startup lab, incubation center, entrepreneurship, innovation, research, technology, prototyping, makerspace, development	\N	\N
243	teslas canteen	30.35681991972022	76.37163103056028	teslas canteen, tesla canteen, canteen, food, snacks, chai, tea, coffee, fast food, drinks, refreshment, eat, sitting, break	\N	\N
245	f block	30.353986788612126	76.37201292668229	f block ,class room 	\N	\N
166	main basketball court	30.35510124894816	76.36505110702673	main basketball court, basketball court, basketball, sports, play, game, court, outdoor court, indoor court, training, practice, fitness, recreation, hoops	\N	https://thapar.edu/upload/images/SYNTHETIC_BASKETBALL_COURT.jpg
184	oat	30.354406225097666	76.36257146247743	roadoat, open air theatre,event space, stage, performance area, cultural events, fest, gathering, seating area, open space, shows, functions, entertainment, public speaking	A vibrant open-air venue used for cultural events, performances, and college fests. With a stage and seating area, it serves as a central spot for entertainment, gatherings, and live shows.\n	\N
167	badminton indoor	30.354861185142077	76.36537216882911	indoor badminton, badminton indoor, badminton court indoor, indoor sports, badminton, court, play, game, training, practice, shuttle, racket sport, fitness, recreation	\N	http://thapar.edu/upload/images/BADMINTON_HALL.jpg
188	athletics track	30.35392331867714	76.36180359155004	athletics track, running track, track field, sports track, running, jogging, sprint, fitness, training, practice, outdoor sports, stadium, exercise	An outdoor sports track designed for running, jogging, and fitness activities. Ideal for practice, training, and maintaining an active lifestyle.	http://thapar.edu/upload/images/%283%29_INTERNATIONAL_STANDARD_SYNTHETIC_TRACK.jpg
189	airtel shop	30.353960329272272	76.36285757305423	airtel shop, airtel store, mobile shop, phone shop, sim card, recharge, prepaid, postpaid, telecom, mobile services, internet, data plan, customer service	A mobile service store offering SIM cards, recharges, and telecom services including prepaid, postpaid, and internet plans.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
190	cosmetics	30.35393720309067	76.36267572641373	cosmetics, beauty products, makeup, skincare, personal care, grooming, lipstick, foundation, cream, lotion, face wash, beauty shop, accessories	A store offering a variety of beauty and personal care products including makeup, skincare, and grooming essentials.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
191	stationery	30.35402515528158	76.3624906539917	stationery, stationery shop, books, notebooks, pens, pencils, study material, office supplies, print, photocopy, xerox, files, folders, school supplies	A convenient shop for books, notebooks, pens, and other study and office supplies, along with printing and photocopy services.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
193	wrapchik	30.354381592298356	76.36203736066818	wrapchik food, wrapchik, wraps, rolls, fast food, snacks, street food, lunch, meal, chicken wrap, veg wrap, spicy food, quick bite, eat, food stall	A food outlet known for tasty wraps, rolls, and quick bites. Perfect for grabbing a spicy and filling meal on the go.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
194	bombay manchury	30.354479265082997	76.36201584897616	bombay manchury food, manchurian, chinese food, indo chinese, street food, fast food, snacks, noodles, fried rice, spicy food, veg manchurian, chicken manchurian, quick bite, eat, food stall,dosa 	A street-style food spot serving Indo-Chinese dishes like manchurian, noodles, and fried rice with rich and spicy flavors.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
101	admin office	30.352648958159303	76.37170683118094	admin office, administration, office, campus admin, student services, official work, documents, verification, help desk, inquiry, support, admission, records	Campus administrative office handling student services, documents, and official inquiries.	https://www.thapar.edu/images/phocagallery/Thapar_Uni/481222_10200103839211427_1230338241_n.jpg
196	the dessert club	30.35410432730881	76.36238616850432	the dessert club, dessert, sweets, bakery, cakes, pastries, ice cream, chocolate, waffles, brownies, sweet treats, cafe, snacks, hangout, refreshments	A dessert cafe offering cakes, pastries, waffles, brownies, and ice creams. A great place for sweet treats and relaxing hangouts.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
197	juice	30.354347216471716	76.36213524806017	juice, fresh juice, fruit juice, shakes, smoothies, lassi, cold drinks, beverages, drinks, refreshment, healthy drink, summer drink, fruits	A refreshment spot serving fresh fruit juices, shakes, and cold beverages. Ideal for healthy drinks and quick energy boosts.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
198	sip and bites	30.35429282517361	76.36216341125483	sip and bites, sip & bites, food, cafe, snacks, fast food, drinks, beverages, coffee, chai, tea, sandwiches, burgers, quick bite, hangout, refreshments	A cafe offering snacks, beverages, coffee, and light meals. A comfortable place to relax, eat, and socialize.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
199	pizza nation	30.354204691644846	76.36226949479594	pizza nation, pizza, fast food, italian food, cheese pizza, veg pizza, non veg pizza, slices, snacks, meal, lunch, dinner, cafe, hangout, quick bite	A popular food outlet serving a variety of pizzas and fast food options. Perfect for casual meals and hangouts.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
200	chilli chatkara	30.353961666107573	76.36263829853549	food 	A food spot known for flavorful and spicy dishes, offering a variety of snacks and meals for quick bites.	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
201	kabir multi store	30.354080213180364	76.36243822541226	kabir multi store, general store, convenience store, grocery, daily needs, snacks, drinks, stationery, personal care, household items, shop, essentials	A general store providing daily essentials, snacks, groceries, stationery, and household items for everyday needs	https://campusutra.com/wp-content/uploads/Thapar-university-building1-1.jpg
92	sky walk	30.355324290142768	76.37116494864905	sky walk, skywalk, walkway, footbridge, elevated path, pedestrian bridge, walking path, passage, connector, overpass, campus walk,relief with nature	An elevated walkway offering smooth connectivity across campus with open views and a refreshing natural vibe. Ideal for walking, relaxing, and enjoying a peaceful stroll.	https://i.ytimg.com/vi/OWcQ97JTfDY/hq720.jpg?sqp=-oaymwE7CK4FEIIDSFryq4qpAy0IARUAAAAAGAElAADIQj0AgKJD8AEB-AH-DoACuAiKAgwIABABGDggXShyMA8=&rs=AOn4CLCtq_lzMYsP6H56cikqvY9Jh1Pyhw
248	nava nalanda central library	30.354255788612125	76.36986292668229	nava nalanda central library, central library, library, books, study, reading, silent, study space, academic, research, knowledge, quiet place, learning	Nava Nalanda Central Library is one of Asia’s largest libraries, ranked among the top in size and resources. It serves as a central academic hub with an extensive collection of books, journals, and digital materials. Known for its quiet and focused environment, it provides an ideal space for studying, research, and deep learning.	https://www.thapar.edu/upload/files/nava-library.jpg
\.


--
-- Data for Name: societies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.societies (id, name, username, password, instagram, twitter, website) FROM stdin;
1	Tech Society	techsoc	test123	@techsoc_tiet	\N	\N
\.


--
-- Name: edges_edge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.edges_edge_id_seq', 618, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_id_seq', 8, true);


--
-- Name: places_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.places_place_id_seq', 251, true);


--
-- Name: societies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.societies_id_seq', 1, true);


--
-- Name: edges edges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edges
    ADD CONSTRAINT edges_pkey PRIMARY KEY (edge_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (place_id);


--
-- Name: societies societies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.societies
    ADD CONSTRAINT societies_pkey PRIMARY KEY (id);


--
-- Name: societies societies_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.societies
    ADD CONSTRAINT societies_username_key UNIQUE (username);


--
-- Name: edges unique_edge; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edges
    ADD CONSTRAINT unique_edge UNIQUE (from_node, to_node);


--
-- Name: edges edges_from_node_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edges
    ADD CONSTRAINT edges_from_node_fkey FOREIGN KEY (from_node) REFERENCES public.places(place_id) ON DELETE CASCADE;


--
-- Name: edges edges_to_node_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edges
    ADD CONSTRAINT edges_to_node_fkey FOREIGN KEY (to_node) REFERENCES public.places(place_id) ON DELETE CASCADE;


--
-- Name: events events_society_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_society_id_fkey FOREIGN KEY (society_id) REFERENCES public.societies(id);


--
-- PostgreSQL database dump complete
--

