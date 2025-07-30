--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'GUEST'
);


ALTER TYPE public."Role" OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: CheraFamily; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."CheraFamily" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    "familyHeadId" integer
);


ALTER TABLE public."CheraFamily" OWNER TO neondb_owner;

--
-- Name: CheraFamily_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."CheraFamily_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CheraFamily_id_seq" OWNER TO neondb_owner;

--
-- Name: CheraFamily_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."CheraFamily_id_seq" OWNED BY public."CheraFamily".id;


--
-- Name: Person; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."Person" (
    id integer NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text,
    birth timestamp(3) without time zone,
    death timestamp(3) without time zone,
    "imageUrl" text,
    biography text,
    gender text,
    "isAlive" boolean DEFAULT true,
    "originPlace" text,
    "spouseId" integer,
    "fatherId" integer,
    "motherId" integer
);


ALTER TABLE public."Person" OWNER TO neondb_owner;

--
-- Name: Person_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."Person_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Person_id_seq" OWNER TO neondb_owner;

--
-- Name: Person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."Person_id_seq" OWNED BY public."Person".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    role public."Role" DEFAULT 'GUEST'::public."Role" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."User" OWNER TO neondb_owner;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO neondb_owner;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: CheraFamily id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."CheraFamily" ALTER COLUMN id SET DEFAULT nextval('public."CheraFamily_id_seq"'::regclass);


--
-- Name: Person id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Person" ALTER COLUMN id SET DEFAULT nextval('public."Person_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: CheraFamily; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."CheraFamily" (id, name, description, "familyHeadId") FROM stdin;
13	Malo Muñoz	\N	7
14	Timoteos Herranz	\N	273
17	Vitorinas	\N	447
18	Jacintas	\N	456
19	Gerardos	\N	210
\.


--
-- Data for Name: Person; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."Person" (id, "firstName", "lastName", birth, death, "imageUrl", biography, gender, "isAlive", "originPlace", "spouseId", "fatherId", "motherId") FROM stdin;
24	Juan	Muñoz Sainz	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	t	\N	25	297	\N
12	Emilio	Orejudo Gonzalo	1931-04-05 00:00:00	2022-07-15 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751303368/FAMILINK/PEOPLE/zynwpmmwnyrkukviab7u.png	\N	M	f	Zahorejas, España	13	10	11
32	Avelino	Malo Muñoz	1942-11-09 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751227066/FAMILINK/PEOPLE/t1mvow0e29dtwonfvcsr.jpg	Viva el vino	M	t	Chera, España	141	7	6
461	Miguel	Ruiz	\N	\N	\N	\N	M	t	\N	457	\N	\N
462	Alberto	Ruiz Gómez	\N	\N	\N	\N	M	t	\N	\N	461	457
17	Juana	Pinilla Segura	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	f	\N	16	\N	\N
20	Gregorio	Aparicio Calvera	\N	1938-03-21 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751226615/FAMILINK/PEOPLE/hd2t3bvpymaz7wrkntrz.jpg	\N	M	f	\N	21	\N	\N
38	Pedro	Hernández Larriba	1942-04-26 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751035531/FAMILINK/PEOPLE/dfi9uu22lddhdzpgceuz.jpg	\N	M	t	Fuembellida, España	96	14	15
36	Asunción	Hernández Larriba	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751036550/FAMILINK/PEOPLE/fhhm2gyzeewf5brncici.jpg	\N	F	t	Fuembellida, España	110	14	15
39	Úrsula	Hernández Larriba	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751036619/FAMILINK/PEOPLE/zg9t2nwum3repe0cjoka.jpg	\N	F	t	Fuembellida, España	77	14	15
35	Jesús	Malo Aznar	1966-12-07 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751224659/FAMILINK/PEOPLE/ngo29c2upsml4e1ubhhz.jpg	\N	M	t	Legazpia, España	44	4	5
18	Babil	Aznar Bonilla	\N	1932-10-04 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	A los 92 años	M	f	\N	19	\N	\N
22	Juan	Malo Torres	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	Hermano Pablo ??\n	M	t	\N	23	\N	\N
10	Quiterio	Orejudo Peco	\N	1978-03-07 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	f	Zahorejas, España	11	\N	\N
14	Tomás	Hernández Sanz	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	f	\N	15	\N	\N
25	Gabriela	Vizcaíno Sanz	\N	\N	\N	\N	F	t	\N	24	329	330
463	Javi	Ruiz Gómez	\N	\N	\N	\N	M	t	\N	\N	461	457
464	Óscar	Soto	\N	\N	\N	\N	M	t	\N	458	\N	\N
465	David	Soto Gómez	\N	\N	\N	\N	M	t	\N	\N	464	458
2	Santos	Orejudo Hernández	1970-03-25 00:00:00	\N	https://www.com-www.com.es/educaviva/wp-content/uploads/2019/11/Santos-Orejudo.jpeg	El decano de la facultad de educación de Unizar	M	t	Fuembellida, España	3	12	13
3	Carmen	Malo Aznar	1970-01-12 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584711/FAMILINK/PEOPLE/yywuccyidopst9aysv6f.jpg	\N	F	t	Legazpia, España	2	4	5
4	Santos	Malo Muñoz	1933-03-25 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750585204/FAMILINK/PEOPLE/txsdq3oswse6bdsvz48l.jpg	\N	M	t	Chera, España	5	7	6
23	Dominica	Rosado García	\N	\N	\N	\N	F	t	\N	22	\N	\N
27	Antonio	Orejudo Hernández	1968-09-16 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750444692/FAMILINK/PEOPLE/obxtnwafnnn7qux7hmrn.jpg	\N	M	t	Fuembellida, España	47	12	13
28	Elisa	Orejudo Hernández	1966-09-04 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750444657/FAMILINK/PEOPLE/xvhiolvaremaujyjmckv.jpg	\N	F	t	Fuembellida, España	41	12	13
29	José Emilio	Orejudo Hernández	1965-09-16 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750444615/FAMILINK/PEOPLE/t6txhfuxffezaiclqfnd.jpg	Aka Chapas	M	t	Fuembellida, España	\N	12	13
30	Ángel	Orejudo Hernández	1971-10-12 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750444507/FAMILINK/PEOPLE/eg7xoj0jc6hxbma8vtkb.jpg	\N	M	t	Fuembellida, España	48	12	13
31	Benjamín	Orejudo Hernández	1976-07-03 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750444548/FAMILINK/PEOPLE/nuhbjshzqavjx9hjtx5n.jpg	\N	M	t	Fuembellida, España	46	12	13
41	Jose María	Alguacil Martínez	1965-09-11 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584681/FAMILINK/PEOPLE/dno1rkbwrt2hz1o8xr2w.jpg	\N	M	t	Molina de Aragón, España	28	\N	\N
42	Jose María	Alguacil Orejudo	1989-05-25 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750583918/FAMILINK/PEOPLE/rargkv12yumydok4yz0s.jpg	\N	M	t	Molina de Aragón, España	\N	41	28
43	Javier	Alguacil Orejudo	1993-08-18 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750583987/FAMILINK/PEOPLE/yff1rxls4au4tgggvwol.jpg	\N	M	t	Molina de Aragón, España	\N	41	28
46	María	De Juana Soriano	1977-07-22 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584779/FAMILINK/PEOPLE/hzfe8budoe1a6iszaok5.jpg	\N	F	t	Molina de Aragón, España	31	\N	\N
47	Araceli	Herranz	1974-11-29 00:00:00	\N	\N	\N	F	t	\N	27	\N	\N
48	Ana	Gómez García	1985-06-09 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584734/FAMILINK/PEOPLE/jnhvbhvnjtpsgx4bbg0q.jpg	\N	F	t	Balazote, España	30	\N	\N
49	Adriana	Orejudo Gómez	2019-12-25 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584071/FAMILINK/PEOPLE/nyy8uczigw0lc0tz2dnh.jpg	\N	F	t	Molina de Aragón, España	\N	30	48
50	Ingrid	Orejudo Herranz	2008-02-28 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584040/FAMILINK/PEOPLE/jppzgbkomncmlgywsfc0.jpg	\N	F	t	Barcelona, España	\N	27	47
51	Paula	Orejudo de Juana	2007-04-03 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584100/FAMILINK/PEOPLE/ftrw24i92dksudfolp47.jpg	\N	F	t	Alcorcón, Madrid, España	\N	31	46
52	Clara	Orejudo de Juana	2009-02-13 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750584137/FAMILINK/PEOPLE/achksnbh1yyw3gmm5jnn.jpg	\N	F	t	Alcorcón, Madrid, España	\N	31	46
53	Julio	Orejudo Gonzalo	\N	\N	\N	\N	M	t	Zahorejas, España	58	10	11
54	Vitorina	Orejudo Gonzalo	\N	\N	\N	\N	F	t	Zahorejas, España	57	10	11
55	Vitoria	Orejudo Gonzalo	\N	\N	\N	\N	F	t	Zahorejas, España	59	10	11
56	Modesta	Orejudo Gonzalo	\N	\N	\N	\N	F	t	Zahorejas, España	60	10	11
57	Gregorio	Aliaga	\N	\N	\N	El tío Tano	M	t	\N	54	\N	\N
58	Mercedes	\N	\N	\N	\N	\N	F	t	\N	53	\N	\N
59	Antonio	\N	\N	\N	\N	\N	M	t	\N	55	\N	\N
60	Máximo	\N	\N	\N	\N	\N	M	t	\N	56	\N	\N
61	Vitoria	\N	\N	\N	\N	Tocada	F	t	\N	\N	59	55
62	Josep	Orejudo	\N	\N	\N	\N	M	t	\N	63	53	58
45	Pedro	Malo Perisé	1998-05-25 00:00:00	\N	https://github.com/pitazzo.png	\N	M	t	Zaragoza, España	\N	35	44
466	Marta	Soto Gómez	\N	\N	\N	\N	F	t	\N	\N	464	458
101	Teresa	Gómez	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751036434/FAMILINK/PEOPLE/iybysfpd2qgzkxkijrbi.jpg	\N	F	t	\N	40	\N	\N
125	María Pilar	de Borgas y Cortés	\N	1902-09-21 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751219781/FAMILINK/PEOPLE/jdslk3wxzbippacapqho.jpg	\N	F	f	Nápoles, Italia	124	\N	\N
102	Natalia	Hernández Gómez	1980-06-12 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751304168/FAMILINK/PEOPLE/kf3rqdmuufj9jizkiplh.png	\N	F	t	\N	103	40	101
155	Javier	Aznar Aparicio	\N	2006-09-29 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	A los 70 años	M	f	Garrapinillos, España	\N	8	9
156	Luis	Blasco Magén	\N	2011-10-26 00:00:00	\N	a los 87	M	f	\N	120	\N	\N
83	Fátima	Martínez	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751298823/FAMILINK/PEOPLE/wrkdyu9eilcpttxpsueg.png	\N	F	t	Legazpia, España	\N	81	82
112	Carlos	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299094/FAMILINK/PEOPLE/rr4ezf2io3nrabdge7hw.png	\N	M	t	Valencia, España	113	110	36
90	Emma	Lussana	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299227/FAMILINK/PEOPLE/bqbxivhwrlne7kllevy3.png	\N	F	t	\N	\N	89	88
84	María	Martínez	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299467/FAMILINK/PEOPLE/itz2waioxpjhuygldsja.png	\N	F	t	Legazpia, España	\N	81	82
108	Vanesa	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299628/FAMILINK/PEOPLE/p6eolcarc3xzrdriwl2e.png	\N	F	t	\N	107	\N	\N
145	Fernando	Malo Martínez	\N	\N	\N	\N	M	t	Zaragoza, España	\N	33	146
89	Filipo	Lussana	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299877/FAMILINK/PEOPLE/coxnjzdqqjagqf5tylyb.png	\N	M	t	Bérgamo, Italia	88	\N	\N
82	Yolanda	Montalvo Álvarez	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751300100/FAMILINK/PEOPLE/gzgrtojolhejm7o9tcrk.png	\N	F	t	Porullena, Granada, España	81	\N	\N
144	Lucía	Malo Martínez	1966-01-13 00:00:00	\N	\N	\N	F	t	Zaragoza, España	\N	33	146
467	Joaquín	Andújar	\N	\N	\N	\N	M	t	\N	399	\N	\N
468	Alejandro	Andújar Tineo	2004-04-03 00:00:00	\N	\N	\N	M	t	Utebo, España	\N	467	399
469	Cristián	Andújar Tineo	\N	\N	\N	\N	M	t	Utebo, España	\N	467	399
137	Eleuterio	Gil Litago	\N	\N	\N	\N	M	f	\N	131	\N	\N
63	Pilar	\N	\N	\N	\N	\N	F	t	\N	62	\N	\N
65	Meritxell	Orejudo	\N	\N	\N	\N	F	t	\N	\N	62	63
66	Emilio	Orejudo	\N	\N	\N	\N	M	t	\N	67	53	58
67	Eva	Navarrete	\N	\N	\N	\N	F	t	\N	66	\N	\N
69	Emma	Orejudo Navarrete	\N	\N	\N	\N	F	t	\N	\N	66	67
70	Julio	Orejudo	\N	\N	\N	\N	M	f	\N	\N	53	58
71	Felisa	Aliaga Orejudo	\N	\N	\N	\N	F	t	\N	\N	57	54
72	Soledad	Aliaga Orejudo	\N	\N	\N	\N	F	t	\N	73	57	54
73	Alejandro	\N	\N	\N	\N	\N	M	t	\N	72	\N	\N
74	Olga	\N	\N	\N	\N	\N	F	t	\N	\N	73	72
76	Alex	\N	\N	\N	\N	\N	M	t	\N	\N	73	72
77	Arturo	Martínez Martínez	\N	\N	\N	\N	M	t	\N	39	\N	\N
80	Daniel	Ramiro Martínez	2007-03-04 00:00:00	\N	\N	\N	M	t	Zaragoza, España	\N	79	78
85	Samuel	Martínez	\N	\N	\N	\N	M	t	Legazpia, España	\N	81	82
86	Andoni	Martínez	\N	\N	\N	\N	M	t	Legazpia, España	\N	81	82
91	Luca	Lussana	\N	\N	\N	\N	M	t	\N	\N	89	88
94	Raúl	Pellicer Martínez	2012-12-06 00:00:00	\N	\N	\N	M	t	Zaragoza, España	\N	93	92
95	Nicolás	Zaragoza, España	2012-12-06 00:00:00	\N	\N	\N	M	t	Zaragoza, España	\N	93	92
104	Martín	\N	\N	\N	\N	\N	M	t	\N	\N	103	102
105	Pablo	\N	\N	\N	\N	\N	M	t	\N	\N	103	102
107	José Luis	Hernández Gómez	1982-08-06 00:00:00	\N	\N	\N	M	t	\N	108	40	101
109	Mario	Hernández	\N	\N	\N	\N	M	t	\N	\N	107	108
110	Crescencio	\N	\N	\N	\N	\N	M	t	\N	36	\N	\N
111	Irene	\N	\N	\N	\N	\N	F	t	Valencia, España	\N	110	36
121	Gloria	Aznar Aparicio	\N	\N	\N	\N	F	t	Garrapinillos, España	186	8	9
126	Angelina	Cattani de Aceto y Borgas	\N	1886-12-22 00:00:00	\N	Fallecida en Palermo	F	f	Nápoles, Italia	127	124	125
127	Ricardo	Valero	\N	\N	\N	\N	M	f	\N	126	\N	\N
128	Luciano	Aparicio Cattani	\N	\N	\N	\N	M	f	Garrapinillos, España	134	20	21
129	Alejandro	Aparicio Cattani	\N	\N	\N	\N	M	f	\N	135	20	21
130	José	Aparicio Cattani	\N	\N	\N	\N	M	f	\N	136	20	21
131	Isabel	Aparicio Cattani	\N	\N	\N	\N	F	f	\N	137	20	21
133	Ascensión	Aparicio Cattani	\N	\N	\N	\N	F	f	\N	138	20	21
134	Concepción	Litago	\N	\N	\N	\N	F	f	\N	128	\N	\N
135	Natividad	Puyo	\N	\N	\N	\N	F	f	\N	129	\N	\N
136	Carmen	Urmeta	\N	\N	\N	\N	M	f	\N	130	\N	\N
138	Nicomedes	Larrea	\N	\N	\N	\N	M	f	\N	133	\N	\N
140	Contesa Caterina	Cattani de Aceto y Borgas	\N	\N	\N	\N	F	f	\N	\N	\N	\N
141	Carmen	Urkiola	\N	\N	\N	\N	F	t	Legazpia, España	32	\N	\N
142	Maite	Malo Urkiola	\N	\N	\N	\N	M	t	Legazpia, España	147	32	141
147	Martín	Ardanaz	\N	\N	\N	\N	M	t	Pamplona, España	142	\N	\N
148	Ander	Ardanaz Malo	2002-05-25 00:00:00	\N	\N	\N	M	t	Pamplona, España	\N	142	147
149	Irune	Ardanaz Malo	2005-11-22 00:00:00	\N	\N	\N	F	t	Pamplona, España	\N	142	147
150	Mónica	Lario Malo	\N	\N	\N	De Morenilla	F	t	Valencia, España	143	\N	\N
151	Unai	Malo Lario	\N	\N	\N	\N	M	t	Legazpia, España	\N	143	150
152	Pau	Malo Lario	\N	\N	\N	\N	M	t	Legazpia, España	\N	143	150
154	Jose María	Aznar Aparicio	\N	\N	\N	\N	M	f	Garrapinillos, España	183	8	9
157	José Luis	Blasco Aznar	\N	\N	\N	\N	M	t	\N	163	156	120
158	Miguel Ángel	Blasco Aznar	\N	\N	\N	\N	M	t	\N	164	156	120
163	Belén	\N	\N	\N	\N	\N	F	t	\N	157	\N	\N
166	Ester	Terrén	\N	\N	\N	\N	F	t	\N	153	\N	\N
167	Fernando	Aznar Terrén	\N	\N	\N	1960	M	t	\N	171	153	166
168	Jorge	Aznar Terrén	\N	\N	\N	1962	M	t	\N	174	153	166
170	Marta	Aznar Aparicio	\N	\N	\N	1966	M	t	\N	180	153	166
171	Carmen	\N	\N	\N	\N	\N	F	t	\N	167	\N	\N
172	Claudia	Aznar	\N	\N	\N	\N	F	t	\N	\N	167	171
173	Lucía	Aznar	\N	\N	\N	\N	F	t	\N	\N	167	171
175	Francisco	Aznar Embodas	\N	\N	\N	Paco	M	t	\N	\N	168	174
200	Ana	Lausín	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	t	\N	190	\N	\N
412	Victor	Pereira Tineo	2006-08-10 00:00:00	\N	\N	\N	M	t	Zaragoza, España	\N	411	398
470	Daniela	Pereira Tineo	\N	\N	\N	\N	F	t	\N	\N	411	398
205	Juan Francisco	Malo Rosado	\N	\N	\N	\N	M	f	Chera, España	209	22	23
212	Eleuterio	Herranz	\N	\N	\N	\N	M	f	Chera, España	206	\N	\N
26	Alba	Hernández Aznar	2006-10-18 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1750425545/FAMILINK/PEOPLE/bkmduvpzgt4loa43xymz.jpg	Estudiante de Ingeniería Aeroespacial, residiendo actualmente en Toledo.\nAka "La niña chica", "La señorita rock&roll" ...	F	t	Zaragoza, España	\N	2	3
64	Gerber	Orejudo	\N	\N	\N	\N	M	t	\N	\N	62	63
68	Lara	Orejudo Navarrete	\N	\N	\N	\N	F	t	\N	\N	66	67
75	Raul	\N	\N	\N	\N	\N	M	t	\N	\N	73	72
87	Imanol	Martínez	\N	\N	\N	\N	M	t	Legazpia, España	\N	81	82
132	Luis	Aparicio Cattani	\N	\N	\N	\N	M	f	\N	\N	20	21
143	José Antonio	Malo Urkiola	\N	\N	\N	cumpleaños 22/06\nAKA Josean	M	t	Legazpia, España	150	32	141
169	Eva	Aznar Aparicio	\N	\N	\N	1964	F	t	\N	177	153	166
176	Teresa	Aznar Embodas	\N	\N	\N	\N	F	t	\N	\N	168	174
177	José Antonio	Diarte de Miguel	\N	\N	\N	\N	M	t	\N	169	\N	\N
178	Jaime	Diarte Aznar	\N	\N	\N	\N	M	t	\N	\N	177	169
179	Blanca	Diarte Aznar	\N	\N	\N	\N	F	t	\N	\N	177	169
181	Ana	Pajares Aznar	\N	\N	\N	\N	F	t	\N	\N	170	180
182	Cristina	Pajares Aznar	\N	\N	\N	2004	F	t	\N	\N	170	180
183	Pilar	Caravantes	\N	\N	\N	\N	F	f	Pinseque, España	154	\N	\N
184	Carlos	Aznar Caravantes	\N	\N	\N	1971	M	t	\N	\N	154	183
185	Pilar	Aznar Caravantes	\N	\N	\N	\N	F	t	\N	\N	154	183
186	José	Zarazaga	\N	\N	\N	1934 Pepito	M	t	\N	121	\N	\N
188	Marisol	Zarazaga Aznar	\N	\N	\N	\N	F	t	\N	194	186	121
189	José Antonio	Zarazaga Aznar	\N	\N	\N	\N	M	t	\N	197	186	121
190	David	Zarazaga Aznar	1972-01-13 00:00:00	\N	\N	\N	M	t	\N	200	186	121
192	Roberto	\N	\N	\N	\N	\N	M	t	\N	\N	191	187
193	Julia	\N	\N	\N	\N	Enfermera	F	t	\N	\N	191	187
165	Covadonga	Blasco Per	\N	\N	\N	\N	F	t	\N	\N	158	164
174	Marisa	Embodas Mullerat	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	Hermana de Baudilio	F	t	\N	168	\N	\N
197	Margo	\N	\N	\N	\N	\N	F	t	Mallorca, España	189	\N	\N
198	Quioner	\N	\N	\N	\N	\N	M	t	\N	\N	189	197
199	Marduqueo	\N	\N	\N	\N	AKA Mardu	F	t	\N	\N	189	197
201	Andrea	Zarazaga	\N	\N	\N	2003	F	t	\N	\N	190	200
202	Mario	Zarazaga	\N	\N	\N	\N	M	t	\N	\N	190	200
16	Julián	Aznar Roda	\N	1970-05-26 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751220627/FAMILINK/PEOPLE/egulqugpdqlvzye3noqa.jpg	Falleció con 92 años	M	f	\N	17	18	19
120	Josefina	Aznar Aparicio	\N	2016-05-25 00:00:00	\N	A los 87	F	f	Garrapinillos, España	156	8	9
206	Daniela	Malo Rosado	\N	\N	\N	\N	F	f	Chera, España	212	22	23
213	Narciso	Muñoz	\N	\N	\N	\N	M	f	Chera, España	207	\N	\N
207	Agustina	Muñoz Vizcaíno	\N	\N	\N	\N	F	f	Chera, España	213	24	25
215	Dolores	Muñoz Muñoz	\N	\N	\N	AKA Pain	F	t	\N	\N	213	207
208	Aniceto	Muñoz Vizcaíno	\N	\N	\N	\N	M	f	Chera, España	217	24	25
222	Maricarmen	\N	\N	\N	\N	\N	F	f	\N	218	\N	\N
218	Ausencio	Muñoz Sanz	\N	\N	\N	\N	M	f	Chera, España	222	208	217
223	Luis	Calvo	\N	\N	\N	AKA El maño	M	f	\N	219	\N	\N
219	Fortunata	Muñoz Sanz	\N	\N	\N	\N	F	t	Chera, España	223	208	217
225	José Luis	Calvo Muñoz	\N	\N	\N	\N	M	t	Zaragoza, España	\N	223	219
226	Jesús	\N	\N	\N	\N	AKA Brasas, el palizas	M	t	\N	221	\N	\N
221	Amparo	Muñoz Sanz	\N	\N	\N	\N	F	t	Chera, España	226	208	217
21	Guillermina	Cattani de Aceto y Borgas	\N	1950-03-28 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751034952/FAMILINK/PEOPLE/wefki7s0f49pmoarpfgk.jpg	\N	F	f	Nápoles, Italia	20	124	125
40	José Luis	Hernández Larriba	1950-06-05 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751035549/FAMILINK/PEOPLE/nwakuidgohxtdfzubqv5.jpg	Aka, El Barón	M	t	Fuembellida, España	101	14	15
96	Isabel	Parra	1942-04-25 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751035567/FAMILINK/PEOPLE/a5wifmdh5qbatfxqeh8o.jpg	\N	F	t	\N	38	\N	\N
100	Lope	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751035765/FAMILINK/PEOPLE/ljqdztvqwotftrj4jywn.jpg	\N	M	t	Madrid, España	\N	99	98
19	Victoria	Roda Arpal	\N	1932-10-26 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	A los 84 años	F	f	\N	18	\N	\N
187	Victoria	Zarazaga Aznar	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751036305/FAMILINK/PEOPLE/khgmesbrtwokuspkprdm.jpg	26/12 cumple\nAKA Vicky	F	t	\N	191	186	121
216	Donato	Muñoz Muñoz	\N	\N	\N	\N	M	f	Chera, España	237	213	207
224	Javier	Calvo Muñoz	\N	\N	\N	\N	M	t	Zaragoza, España	243	223	219
194	Arturo	Montón Gómez	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	t	\N	188	\N	\N
195	Alejandro	Montón Zarazaga	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	t	\N	\N	194	188
191	Santiago	Gimeno	\N	\N	\N	\N	M	t	\N	187	\N	\N
1	Jorge	Hernández Aznar	2004-05-12 00:00:00	2023-05-12 00:00:00	https://github.com/hachejorge.png	\N	M	t	Zaragoza, España	\N	2	3
78	Mercedes	Martínez Hernández	1970-08-04 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751298703/FAMILINK/PEOPLE/fygk33ebcdgjlid5qm2g.png	\N	F	t	Legazpia, España	79	77	39
37	Margarita	Hernández Larriba	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299343/FAMILINK/PEOPLE/irzxgoybx8bqsojjqfuv.png	\N	F	t	Fuembellida, España	\N	14	15
106	Beatriz	Hernández Gómez	1981-09-23 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299589/FAMILINK/PEOPLE/ipzyjvxsmwhx9ejliosb.png	\N	F	t	\N	\N	40	101
114	Diego	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751300730/FAMILINK/PEOPLE/jmas4lgjbemp0sao5mtq.png	\N	\N	t	Valencia, España	\N	112	113
214	Elvira	Muñoz Muñoz	\N	\N	\N	\N	F	t	Chera, España	285	213	207
220	Urbano	Muñoz Sanz	\N	\N	\N	\N	M	f	Chera, España	289	208	217
146	Maruja	Martínez Sanz	1934-09-19 00:00:00	\N	\N	También llamada María	F	t	Chera, España	33	384	361
217	Miguela	Sanz Malo	\N	\N	\N	AKA Cara osito	F	f	Chera, España	208	386	\N
209	Inés	Malo	\N	\N	\N	\N	F	f	Chera, España	205	427	\N
227	Emiliana	Gómez	1939-02-08 00:00:00	\N	\N	\N	F	t	Chera, España	210	459	460
229	Inmaculada	Malo	\N	\N	\N	Enero 1972	F	t	Madrid, España	\N	210	227
228	Javier	Malo	\N	\N	\N	1966	M	t	Madrid, España	231	210	227
231	Marivi	\N	\N	\N	\N	Maestra	F	t	\N	228	\N	\N
232	Irene	Malo	\N	\N	\N	\N	F	t	Madrid, España	\N	228	231
233	Lorena	\N	\N	\N	\N	\N	F	t	\N	230	\N	\N
230	Gerardo	Malo	\N	\N	\N	\N	M	t	Madrid, España	233	210	227
471	Pedro Jose	Perisé	1941-01-21 00:00:00	\N	\N	\N	M	t	Zaragoza, España	472	\N	\N
236	Juan	Salas	\N	\N	\N	\N	M	t	\N	\N	\N	235
238	José Antonio	Muñoz	\N	\N	\N	\N	M	t	\N	\N	216	237
239	Cristina	Muñoz	\N	\N	\N	\N	F	t	\N	\N	216	237
240	Patricia	Muñoz	\N	\N	\N	2002	F	t	\N	\N	238	\N
241	Pelayo	Muñoz	\N	\N	\N	2005	M	t	\N	\N	238	\N
242	Noelia	García Muñoz	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751219036/FAMILINK/PEOPLE/tqztienwm3kclrnr2uey.jpg	Nº1 MIR 2024	F	t	\N	\N	\N	239
243	Maricarmen	\N	\N	\N	\N	\N	F	t	\N	224	\N	\N
244	Javier	Calvo 	\N	\N	\N	\N	M	t	\N	\N	224	243
245	Sara	Calvo	\N	\N	\N	\N	F	t	\N	\N	224	243
246	Anabel	Calvo	\N	\N	\N	\N	F	t	\N	\N	225	\N
247	Adrián	Calvo	\N	\N	\N	\N	M	t	\N	\N	225	\N
124	Guillermo	Cattani de Aceto Borja	\N	1922-11-05 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751219731/FAMILINK/PEOPLE/rmstepl5vuu33dspdc1s.jpg	\N	M	f	Nápoles, Italia	125	\N	\N
139	Guillermina	Larrea Aparicio	1950-12-19 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751036136/FAMILINK/PEOPLE/se6uvaxjpnuufmqsak9y.jpg	\N	F	t	\N	248	138	133
251	Cristina	\N	\N	\N	\N	\N	F	t	\N	249	\N	\N
249	José Ramón	Larrea Aparicio	\N	\N	\N	\N	M	t	Legazpia, España	251	138	133
252	Nora	Larrea	\N	\N	\N	\N	F	t	París, Francia	\N	249	251
253	Gaspar	Larrea	\N	\N	\N	\N	M	t	París, Francia	\N	249	251
254	Maxi	\N	\N	\N	\N	\N	F	t	\N	250	\N	\N
250	Jesúsmari	Larrea Aparicio	\N	\N	\N	\N	M	t	Legazpia, España	254	138	133
255	Josu	Larrea	\N	\N	\N	\N	M	t	Legazpia, España	\N	250	254
258	Naia	Fernández Espinal	2017-10-07 00:00:00	\N	\N	\N	F	t	Zaragoza, España	\N	257	256
259	Nora	Fernández Espinal	2020-01-24 00:00:00	\N	\N	\N	F	t	Zaragoza, España	\N	257	256
196	Raquel	Montón Zarazaga	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	t	\N	\N	194	188
164	Pilar	Per Labuena	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	t	\N	158	\N	\N
257	Javier	Fernández	1984-02-02 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751222016/FAMILINK/PEOPLE/svviwmlq9k3qmljunv07.jpg	\N	M	t	Zaragoza, España	256	\N	\N
180	Luis	Pajares Echeverría	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	M	f	\N	170	\N	\N
153	Luis	Aznar Aparicio	\N	1996-07-12 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	A los 65 años	M	f	Garrapinillos, España	166	8	9
248	Juan Antonio	Espinal Agredano	1954-03-30 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751223701/FAMILINK/PEOPLE/u9bqz25dtr0u1cscshdh.jpg	\N	M	t	Argallón, Córdoba, España	139	\N	\N
159	Pilar	Blasco Aznar	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751223926/FAMILINK/PEOPLE/lglh4w4byepat2gxc7yg.jpg	\N	F	t	\N	\N	156	120
256	Laida	Larrea Espinal	1984-05-10 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751224031/FAMILINK/PEOPLE/c3f20lq8e2vexam8to25.jpg	\N	F	t	Legazpia, España	257	248	139
260	Carmen	Rubio Embid	\N	2013-01-26 00:00:00	\N	Fallecida a los 90 años	F	f	\N	204	\N	\N
5	Carmen	Aznar Aparicio	1932-06-06 00:00:00	2020-06-02 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751225738/FAMILINK/PEOPLE/qwsqaeobjcwhp7bsicfu.jpg	\N	F	f	Garrapinillos, España	4	8	9
261	Carmen	Latorre Sanz	\N	1991-11-17 00:00:00	\N	Fallecida a los 81 años	F	f	\N	203	\N	\N
203	Indalecio	Aznar Pinilla	\N	1983-09-30 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751224989/FAMILINK/PEOPLE/iymtwcuy6pnwvkcq3d3s.jpg	Fallecido a los 76	M	f	\N	261	16	17
262	Carmen	Aznar Latorre	\N	1970-02-16 00:00:00	\N	A los 32 años falleció	F	f	\N	\N	203	261
263	Indalecio	Aznar Latorre	\N	1953-08-17 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751225180/FAMILINK/PEOPLE/gantcpfgol9gosgldgzr.jpg	A los 18 años	M	f	\N	\N	203	261
204	Valentín	Aznar Pinilla	\N	2002-04-28 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751225902/FAMILINK/PEOPLE/q7ftyak7mcrapu39ozhe.jpg	Fallecido a los 88	M	f	\N	260	16	17
9	Encarnación	Aparicio Cattani	\N	1980-02-21 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751226053/FAMILINK/PEOPLE/x1praphakqxqwyytvjjk.jpg	A los 70 años falleció	F	f	Garrapinillos, Zaragoza, España	8	20	21
8	José	Aznar Pinilla	\N	1979-07-25 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751226125/FAMILINK/PEOPLE/wximlvm8bzpvmbug5fgu.jpg	Fallecido a los 74 años	M	f	\N	9	16	17
33	Celestino	Malo Muñoz	\N	2024-07-31 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751228059/FAMILINK/PEOPLE/bp2nhywu04t8uxixkvdt.jpg	\N	M	f	Chera, España	146	7	6
81	Arturo	Martínez Hernández	1971-06-23 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751298748/FAMILINK/PEOPLE/gzfbenrwdtlxaykhv4pb.png	\N	M	t	Legazpia, España	82	77	39
98	Elena	Hernández Parra	1975-05-29 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751298976/FAMILINK/PEOPLE/lplspx3nzntg8bxrj7uf.png	\N	F	t	Madrid, España	99	38	96
93	Alberto	Pellicer Leoz	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299034/FAMILINK/PEOPLE/v16rfu4l6mg7mkisfrsg.png	\N	M	t	\N	92	\N	\N
99	Álvaro	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299156/FAMILINK/PEOPLE/jxi9pfipfd5kp8hrh5lm.png	Gran aficionado del Atlético de Madrid	M	t	Madrid, España	98	\N	\N
97	María Isabel	Hernández Parra	1973-07-18 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299304/FAMILINK/PEOPLE/j9lnqwhayelciwdkyy8u.png	\N	F	t	Madrid, España	\N	38	96
88	Begoña	Martínez Hernández	1972-12-06 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299520/FAMILINK/PEOPLE/za7uvkmoxafhrvronxep.png	\N	F	t	Legazpia, España	89	77	39
103	Iván	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751304107/FAMILINK/PEOPLE/xeuq0yaxoz6vx6n0kyk4.png	\N	M	t	\N	102	\N	\N
210	Gerardo	Malo Malo	1935-10-03 00:00:00	\N	\N	\N	M	f	Chera, España	227	205	209
234	Miguel	\N	\N	\N	\N	\N	M	t	\N	265	211	\N
235	Ester	\N	\N	\N	\N	\N	F	t	\N	287	\N	214
237	Cristina	Ramiro Malo	\N	\N	\N	\N	F	t	\N	216	323	319
333	Adriana	García Vizcaino	\N	\N	\N	\N	F	f	Chera, España	338	332	331
79	Julio	Ramiro	1961-07-01 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299840/FAMILINK/PEOPLE/cncmzeugmpcpfw30etc2.png	\N	M	t	Taravilla, España	78	\N	\N
113	Julia	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751299999/FAMILINK/PEOPLE/roukcjxenqs7orrioc5w.png	\N	F	t	Valencia, España	112	\N	\N
115	Teresa	\N	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751300031/FAMILINK/PEOPLE/l6rre2gehgwzgnvnizt8.png	\N	F	t	Valencia, España	\N	110	36
264	Martina	Sanz Martínez	\N	\N	\N	murió con 66 o 68\nPadre Angel, el tío Angel Custodio, madre encarnación\n\nhermanos de la madre,\n- cipriano\n- petra\n- encarnación	F	t	Chera, España	211	\N	\N
211	Leonilo	Malo Malo	\N	\N	\N	\N	M	f	Chera, España	264	205	209
265	Josefina	\N	\N	\N	\N	hermano que se casó con una hija de la veneranda	F	t	\N	234	\N	\N
266	Inés	\N	\N	\N	\N	\N	F	t	\N	\N	234	265
267	Enrique	\N	\N	\N	\N	\N	M	t	\N	\N	234	265
269	Marcos	\N	\N	\N	\N	De la autoescuela	M	t	Molina de Aragón, España	268	\N	\N
268	Puri	\N	\N	\N	\N	\N	F	t	\N	269	211	\N
275	Restituto	\N	\N	\N	\N	\N	M	f	Pradilla, España	270	\N	\N
270	Luisa	\N	\N	\N	\N	Restituto fallecido, y se caso con Luis un hermano de la jesusa molinero\n\n48 años fallecida	F	f	Chera, España	275	212	206
276	Pilar	Montesa	\N	\N	\N	\N	F	t	Leciñena, España	271	\N	\N
271	Bernardo	\N	\N	\N	\N	\N	M	t	Chera, España	276	212	206
277	Vitorina	\N	\N	\N	\N	mujer hermana de mujer de timoteo	F	f	\N	272	\N	\N
272	Jesús	\N	\N	\N	\N	\N	M	t	\N	277	212	206
278	Marivi	\N	\N	\N	\N	Rollo con Alemán	F	t	\N	\N	272	277
279	Severina	\N	\N	\N	\N	1931	F	t	\N	273	\N	\N
273	Timoteo	Herranz Malo	\N	\N	\N	\N	M	f	Chera, España	279	212	206
281	Nacho	Herranz	\N	\N	\N	\N	M	t	\N	\N	273	279
282	Montse	Herranz	\N	\N	\N	\N	F	f	\N	\N	273	279
283	Mari Angeles	\N	\N	\N	\N	\N	M	t	\N	\N	273	279
284	Maura	Muñoz Torres	\N	\N	\N	\N	F	t	\N	274	\N	\N
274	Isidoro	\N	\N	\N	\N	1931	M	f	\N	284	212	206
285	Eulalio	Pérez	\N	\N	\N	\N	M	f	Aldehuela, España	214	\N	\N
287	Juan	Salas	\N	\N	\N	\N	M	t	\N	235	\N	\N
288	Ángel	Sanz Sanchez	\N	\N	\N	\N	M	t	\N	286	\N	\N
286	Maricarmen	\N	\N	\N	\N	\N	F	t	\N	288	285	214
289	Marisol	\N	\N	\N	\N	\N	F	t	\N	220	\N	\N
290	Sergio	\N	\N	\N	\N	\N	M	t	Barcelona	\N	226	221
6	María	Muñoz Vizcaíno	1902-05-03 00:00:00	1993-01-03 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751366797/FAMILINK/PEOPLE/zrdtgtbpintpoh6w5lcc.png	\N	F	f	Chera, España	7	24	25
7	Florencio	Malo Rosado	1903-02-23 00:00:00	1970-07-03 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1751366836/FAMILINK/PEOPLE/oq8xoppb6tibo6x1bkcq.png	Cuando rompía a sudar es cuando mejor segaba	M	f	Chera, España	6	22	23
291	Brienne 	de Tarth	\N	\N	\N	\N	F	t	\N	280	\N	\N
280	Juan Carlos	Herranz	\N	\N	\N	\N	M	t	\N	291	273	279
292	Alvaro	Herranz	\N	\N	\N	VDG	M	t	Getafe, España	\N	280	291
293	Gonzalo	Herranz	\N	\N	\N	Jugador pro de ping pong	M	t	Getafe, España	\N	280	291
294	Rodrigo	Herranz	\N	\N	\N	\N	M	t	\N	\N	281	\N
296	Gabriela	\N	\N	\N	\N	\N	F	f	\N	295	\N	\N
297	  Dámaso	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
295	Gregorio	Muñoz Sainz	\N	\N	\N	\N	M	f	\N	296	297	\N
303	Ángela	Sanz	\N	\N	\N	\N	F	t	Chera, España	298	\N	\N
298	Primitivo	Muñoz Muñoz	1930-02-24 00:00:00	\N	\N	\N	M	f	Chera, España	303	295	296
304	Sagrario	Muñoz Sanz	\N	\N	\N	\N	F	t	\N	\N	298	303
305	Ángela	Muñoz Sanz	\N	\N	\N	\N	F	t	\N	\N	298	303
306	Hortensia	\N	\N	\N	\N	\N	F	t	Camarena de la Sierra, Teruel	301	\N	\N
301	Perfecto	Muñoz Muñoz	1933-04-17 00:00:00	\N	\N	\N	M	f	Chera, España	306	295	296
307	Pascual	Martínez	\N	\N	\N	Hijo del tío Pascual	M	t	Pradilla, España	299	\N	\N
299	Mercedes	Muñoz Muñoz	\N	\N	\N	\N	F	t	Chera, España	307	295	296
309	Mercedes	Martínez Muñoz	\N	\N	\N	\N	F	t	\N	\N	307	299
310	Pilar	\N	\N	\N	\N	\N	F	t	\N	308	\N	\N
308	Luis	Martínez Muñoz	\N	\N	\N	\N	M	t	\N	310	307	299
311	Luis	Martínez	2003-08-29 00:00:00	\N	\N	\N	M	t	Madrid, España	\N	308	310
312	Carmen	Martínez	2003-08-29 00:00:00	\N	\N	\N	F	t	Madrid, España	\N	308	310
313	Fernando	Martínez	2005-03-11 00:00:00	\N	\N	\N	M	t	Madrid, España	\N	308	310
11	Prudencia	Gonzalo Arcediano	\N	1956-09-08 00:00:00	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	f	Zahorejas, España	10	\N	\N
15	Robustiana	Larriba Garcíe	\N	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751304631/FAMILINK/PEOPLE/ujhknjolqdt5m2olxjwg.png	\N	F	f	\N	14	\N	\N
300	Pedro	Muñoz Muñoz	\N	\N	\N	\N	M	f	Chera, España	314	295	296
315	Araceli	\N	\N	\N	\N	\N	F	t	\N	\N	300	314
316	Fernando	\N	\N	\N	\N	\N	M	f	\N	\N	300	314
323	Rufino	Ramiro	\N	\N	\N	\N	M	f	Chera, España	319	\N	\N
319	Paz	Malo Martínez	\N	\N	\N	\N	F	f	Chera, España	323	317	318
317	Paulino	Malo	\N	\N	\N	Primo hermano de florencio\nFue sacristán en la iglesia	M	f	Chera, España	318	\N	\N
318	Petra	Martínez	\N	\N	\N	Prima de la maruja	F	f	Chera, España	317	\N	\N
314	Antonia	Malo Martínez	\N	\N	\N	\N	F	f	Chera, España	300	317	318
320	Aúrea	Malo Martínez	\N	\N	\N	\N	F	f	Chera, España	\N	317	318
321	Rafaela	Malo Martínez	\N	\N	\N	\N	F	f	Chera, España	\N	317	318
322	Amparo	Malo Martínez	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	\N	F	t	Chera, España	\N	317	318
324	Tomás	Ramiro Malo	\N	\N	\N	\N	M	t	Chera, España	\N	323	319
325	Ciriaco	\N	\N	\N	\N	\N	M	f	Prados Redondo, España	302	\N	\N
302	Gregoria	Muñoz Muñoz	\N	\N	\N	\N	F	f	Chera, España	325	295	296
327	Paulinico	\N	\N	\N	\N	Alguacil	M	f	Chera, España	326	\N	\N
326	Lorenza	Muñoz Sainz	\N	\N	\N	Vivía en actual casa de jesús y amparo	F	f	Chera, España	327	297	\N
328	Leoncio	\N	\N	\N	\N	Fallecido a los 17, una semana después de Adrián(hermano de la Justa)\n	M	f	Chera, España	\N	327	326
330	X	\N	\N	\N	\N	\N	F	t	\N	329	\N	\N
329	X	\N	\N	\N	\N	\N	M	t	\N	330	\N	\N
332	Lucio	García	\N	\N	\N	\N	M	f	Chera, España	331	\N	\N
331	Leonarda	Vizcaíno Sanz	\N	\N	\N	\N	F	f	\N	332	329	330
337	Iván	\N	\N	\N	\N	\N	M	t	\N	\N	\N	282
334	Vicente	García Vizcaino	\N	\N	\N	\N	M	f	Chera, España	354	332	331
335	Jesusa	García Vizcaino	\N	\N	\N	\N	F	f	\N	369	332	331
338	Teófilo	Remiro Sanchez	\N	\N	\N	Tocaba muy "limpio" el laúd	M	f	Chera, España	333	\N	\N
399	Merche	Tineo	\N	\N	\N	\N	F	t	\N	467	390	\N
342	Milagros	\N	\N	\N	\N	Maestra	F	t	Guadalajara, España	339	\N	\N
344	Jesús	\N	\N	\N	\N	Jesusín	M	t	\N	\N	339	342
345	Irene	\N	\N	\N	\N	\N	F	t	Zaragoza, España	343	\N	\N
343	Nacho	\N	\N	\N	\N	\N	M	t	\N	345	339	342
346	Carmen	\N	\N	\N	\N	\N	M	t	\N	\N	343	345
347	Pablo	\N	\N	\N	\N	\N	M	t	\N	\N	343	345
397	Rafael	López Sanz	\N	\N	\N	\N	M	f	\N	\N	394	388
349	Lola	\N	\N	\N	\N	\N	F	t	\N	\N	348	340
351	Javivi	\N	\N	\N	\N	\N	M	t	\N	\N	\N	349
352	Félix	\N	\N	\N	\N	\N	M	t	\N	350	\N	\N
350	Pili	\N	\N	\N	\N	\N	F	t	\N	352	348	340
353	Lucía	\N	\N	\N	\N	\N	F	t	\N	\N	352	350
395	Severino	López Sanz	\N	\N	\N	\N	M	t	\N	\N	394	388
357	Ana	Escolano	\N	\N	\N	\N	F	t	Zaragoza, España	356	\N	\N
356	Lucio	García Martínez	\N	\N	\N	\N	M	t	Chera, España	357	334	354
358	Álvaro	García Escolano	\N	\N	\N	\N	M	t	Zaragoza, España	\N	356	357
359	Diego	García Escolano	\N	\N	\N	\N	M	t	Zaragoza, España	\N	356	357
336	Trini	García Vizcaino	\N	\N	\N	\N	F	f	Chera, España	360	332	331
383	José	Sanchez	\N	\N	\N	Josete	M	t	Chera, España	\N	414	415
362	Josemari	Martínez García	\N	\N	\N	\N	M	t	Chera, España	\N	360	336
363	Emilio	Martínez García	\N	\N	\N	Agricultor	M	t	Chera, España	\N	360	336
364	Paco	Martínez García	\N	\N	\N	\N	M	t	Chera, España	365	360	336
366	David	Martínez	\N	\N	\N	También conocido como "El zurdo"\n	M	t	Molina de Aragón, España	\N	364	365
367	Patricia	Martínez	\N	\N	\N	\N	M	t	\N	\N	364	365
368	Jose Antonio	Martínez García	\N	\N	\N	"Paquillo" en la escuela hogar, 1970	M	t	Chera, España	\N	360	336
365	Gema	\N	\N	\N	\N	Miembro de los "Garfellas"\n	F	t	Molina de Aragón, España	364	\N	\N
372	Pablo	\N	\N	\N	\N	\N	M	t	\N	370	\N	\N
370	Ascensión	\N	\N	\N	\N	\N	F	t	Chera, España	372	369	335
373	Ángel	\N	\N	\N	\N	\N	M	t	Zaragoza, España	\N	372	370
374	Fernando	\N	\N	\N	\N	Cucharón	M	t	\N	\N	372	370
375	Rubén	\N	\N	\N	\N	\n	M	t	\N	\N	374	\N
376	Antonio	Buen	\N	\N	\N	\N	M	t	\N	371	\N	\N
371	Regina	\N	\N	\N	\N	\N	F	t	Chera, España	376	369	335
378	Sergio	Buen	\N	\N	\N	\N	M	t	\N	379	376	371
379	Sara	\N	\N	\N	\N	\N	F	t	\N	378	\N	\N
377	Lorena	Buen	\N	\N	\N	\N	F	t	\N	380	376	371
381	Adrían	Sanchez Buen	\N	\N	\N	DJ Sabu	M	t	Zaragoza, España	\N	380	377
382	Sergio	Sanchez Buen	\N	\N	\N	\N	M	t	\N	\N	380	377
380	Iván	Sanchez	\N	\N	\N	\N	M	t	\N	377	383	\N
341	Benancio	Ramiro García	\N	\N	\N	\N	M	t	\N	\N	338	333
339	Clementino	Ramiro García	\N	\N	\N	\N	M	t	Chera, España	342	338	333
348	Modesto	López Malo	\N	\N	\N	Guardia Civil	M	t	Chera, España	340	\N	\N
369	Ángel	Francisco	\N	\N	\N	Molineros	M	f	Chera, España	335	\N	\N
384	Emilio	Martínez	\N	\N	\N	\N	M	f	\N	361	\N	\N
354	Marina	Martínez Sanz	\N	\N	\N	Hermana de la tía maruja	F	f	\N	334	384	361
361	Lucila	Sanz	\N	\N	\N	\N	F	f	Chera, España	384	\N	\N
400	Pili	Tineo	\N	\N	\N	\N	F	t	\N	\N	390	\N
340	Dolores	Ramiro García	\N	\N	\N	\N	F	t	\N	348	338	333
385	Santiago	\N	\N	\N	\N	Le gustaba jugar a las cartas	M	t	\N	355	\N	\N
355	Rosario	García Martínez	\N	\N	\N	\N	F	t	Chera, España	385	334	354
360	Filadelfo	Martínez Sanz	\N	\N	\N	Hermanos de la maruja	M	t	Chera, España	336	384	361
386	Gregorio	Sanz	\N	\N	\N	\N	M	f	\N	\N	\N	\N
389	Isaac	Tineo	\N	\N	\N	\N	M	f	Campillo de Dueñas, España	387	\N	\N
387	Clara	Sanz	\N	\N	\N	\N	F	f	\N	389	386	\N
390	Valeriano	Tineo Sanz	\N	\N	\N	\N	M	t	\N	\N	389	387
391	Santiago	Tineo Sanz	\N	\N	\N	\N	M	f	\N	\N	389	387
393	Julio	Tineo Sanz	\N	\N	\N	\N	M	t	\N	\N	389	387
394	Pablo	López	\N	\N	\N	\N	M	f	\N	388	\N	\N
388	Máxima	Sanz	\N	\N	\N	\N	F	f	\N	394	386	\N
401	Carlos	Tineo	\N	\N	\N	AKA Carly	M	t	\N	\N	390	\N
402	Santi	Tineo	\N	\N	\N	\n	M	t	\N	\N	391	\N
403	Diego	Tineo	\N	\N	\N	\N	M	t	\N	\N	391	\N
404	Érika	Tineo	\N	\N	\N	\n	M	t	\N	\N	391	\N
405	Pablo	\N	\N	\N	\N	\N	M	f	\N	392	\N	\N
392	Donata	Tineo Sanz	\N	\N	\N	\N	F	f	\N	405	389	387
406	Pablo	\N	\N	\N	\N	Policía	M	t	\N	\N	405	392
407	Antonio	Pereira	\N	\N	\N	\N	M	f	\N	396	\N	\N
396	Teodora	López Sanz	\N	\N	\N	\N	F	t	\N	407	394	388
408	Antonio	Pereira	\N	\N	\N	\N	M	t	\N	\N	407	396
409	Macu	Pereira	\N	\N	\N	\N	F	t	\N	\N	407	396
92	Marisa	Martínez Hernández	1978-04-07 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751298785/FAMILINK/PEOPLE/s3c6cvgwydm0rgkcad2h.png	\N	F	t	Legazpia, España	93	77	39
13	Lucía	Hernández Larriba	1934-02-08 00:00:00	2016-02-20 00:00:00	https://res.cloudinary.com/dzaewwju2/image/upload/v1752846256/FAMILINK/PEOPLE/iioahuxffixqdqzbmqxt.png	\N	F	f	Fuembellida, España	12	14	15
411	Roberto	Pereira	\N	\N	\N	\N	M	t	\N	398	\N	\N
398	Almudena	Tineo	\N	\N	\N	\N	F	t	\N	411	390	\N
413	Daniela	Pereira Tineo	\N	\N	\N	\N	M	t	\N	\N	412	\N
415	Maximina	\N	\N	\N	\N	\N	F	f	Chera, España	414	\N	\N
424	Javier	López	\N	\N	\N	\N	M	t	Valencia, España	\N	421	\N
417	Soledad	Sanchez	\N	\N	\N	\N	F	t	\N	\N	414	415
418	Eduardo	Sanchez	\N	\N	\N	\N	M	t	\N	\N	414	415
416	Emilia	Sanchez	\N	\N	\N	\N	F	t	\N	420	414	415
422	Fernado	López Sanchez	\N	\N	\N	\N	M	t	\N	\N	420	416
423	Lucía	López	\N	\N	\N	\N	F	t	Zaragoza, España	\N	421	\N
419	Balbino	Sanchez	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	Es medio hermano, la madre falleció en el parto	M	t	Chera, España	\N	414	415
426	Carmen	\N	\N	\N	\N	\N	F	t	Valencia, España	421	\N	\N
421	Pedro José	López Sanchez	\N	\N	\N	\N	M	t	\N	426	420	416
414	Ricardo	Sanchez	\N	\N	https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png	Inicialmente casado con Aurelia que falleció en el parto de balbino	M	f	Chera, España	415	\N	\N
430	Rufino	Martínez	\N	\N	\N	Muy listo	M	f	Valhermoso, España	431	\N	\N
420	Gregorio	López Dominguez	\N	\N	\N	\N	M	f	Chera, España	416	438	\N
427	Padre Tirso	\N	\N	\N	\N	\N	M	t	\N	435	\N	\N
425	Tirso	Malo Domínguez	\N	\N	\N	\N	M	f	Chera, España	429	427	435
428	Resu	Malo	\N	\N	\N	\N	F	t	Chera, España	440	425	429
431	Marcelina	\N	\N	\N	\N	\N	F	f	Chera, España	430	\N	\N
457	Mercedes	Goméz Torres	\N	\N	\N	\N	F	t	\N	461	456	448
429	Águeda	Martínez	\N	\N	\N	\N	M	f	Chera, España	425	430	431
432	Fructuoso	Malo Martínez	\N	\N	\N	\N	M	f	\N	\N	425	429
433	Rafael	Malo Martínez	\N	\N	\N	Le pico una víbora	M	t	\N	\N	425	429
434	Carlos	Malo Martínez	\N	\N	\N	\N	M	t	\N	\N	425	429
435	Margarita	Domínguez	\N	\N	\N	\N	F	f	Chera, España	427	\N	\N
458	Rosa	Gómez Torres	\N	\N	\N	\N	F	t	\N	464	456	448
472	Conchita	Polo Montalvo	1941-07-14 00:00:00	\N	\N	\N	F	t	Zaragoza, España	471	\N	\N
44	Eva	Perisé Polo	1969-02-07 00:00:00	\N	https://res.cloudinary.com/dzaewwju2/image/upload/v1751224713/FAMILINK/PEOPLE/f6ms8imdy7vnebcamkg1.jpg	\N	F	t	Zaragoza, España	35	471	472
438	Mateo	López	\N	\N	\N	\N	M	f	El pobo, España	\N	\N	\N
439	Mujer de hombrados	\N	\N	\N	\N	\N	M	t	\N	436	\N	\N
436	Pedro	López Dominguez	\N	\N	\N	\N	M	t	Chera, España	439	438	435
440	José Luis	Espes	\N	\N	\N	Bombero	M	t	Zaragoza, España	428	\N	\N
441	Alex	Espes Malo	\N	\N	\N	\N	M	t	\N	\N	440	428
442	Sandra	Espes Malo	\N	\N	\N	\N	F	t	\N	\N	440	428
443	Edgar	Malo	\N	\N	\N	\N	M	t	\N	\N	434	\N
444	Natalia	\N	\N	\N	\N	\N	F	t	\N	\N	432	\N
474	Isabel	Gil Aparicio	\N	\N	\N	\N	F	t	\N	\N	137	131
446	Hilaria	Sainz	\N	\N	\N	\N	F	f	Aldehuela, Guadalajara, España	445	\N	\N
445	Perico	Torres	\N	\N	\N	\N	M	f	Chera, España	446	\N	\N
475	Laura	\N	\N	\N	\N	\N	F	t	\N	473	\N	\N
473	Angelito	Gil Aparicio	\N	\N	\N	\N	M	t	\N	475	137	131
449	Salvio	Valiente	\N	\N	\N	\N	M	f	Cuenca, España	447	\N	\N
447	Vitorina	Torres Sainz	1936-05-17 00:00:00	\N	\N	\N	F	t	Chera, España	449	445	446
450	Fernando	Valiente Torres	\N	\N	\N	Fallecio en un accidente de tráfico jóven	M	f	\N	\N	449	447
452	Garbiñe	Valiente Torres	\N	\N	\N	\N	F	t	\N	\N	449	447
453	Carlos	Valiente Torres	\N	\N	\N	AKA Calipo	M	t	\N	\N	449	447
454	Joaquín	\N	\N	\N	\N	\N	M	t	\N	451	\N	\N
451	Begoña	Valiente Torres	\N	\N	\N	\N	F	t	\N	454	449	447
455	Asier	\N	\N	\N	\N	\N	M	t	\N	\N	454	451
448	Eugenia	Torres Sainz	\N	\N	\N	\N	F	f	Chera, España	456	445	446
460	Vicenta	\N	\N	\N	\N	\N	F	f	Hinojosa, España	459	\N	\N
456	Jacinto	Gómez	\N	\N	\N	\N	M	t	Chera, España	448	459	460
459	Simeón	Gómez	\N	\N	\N	Los somarrones	M	f	Chera, España	460	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."User" (id, username, password, role, "createdAt") FROM stdin;
1	jorge	$2b$10$N9/SqELM1NbZda8XDkplb.Br/4ZBN2Lcbvj.UXna4VC/7jWUmNRES	ADMIN	2025-06-24 10:06:33.595
2	guest	$2b$10$Q99gIZCV38C7p3wt5caJiub7VbMWfD3Te2RHbtyEV4wROp7Jzcme.	GUEST	2025-06-24 10:07:06.783
\.


--
-- Name: CheraFamily_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."CheraFamily_id_seq"', 19, true);


--
-- Name: Person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."Person_id_seq"', 475, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."User_id_seq"', 2, true);


--
-- Name: CheraFamily CheraFamily_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."CheraFamily"
    ADD CONSTRAINT "CheraFamily_pkey" PRIMARY KEY (id);


--
-- Name: Person Person_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: CheraFamily_familyHeadId_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "CheraFamily_familyHeadId_key" ON public."CheraFamily" USING btree ("familyHeadId");


--
-- Name: CheraFamily_name_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "CheraFamily_name_key" ON public."CheraFamily" USING btree (name);


--
-- Name: Person_spouseId_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "Person_spouseId_key" ON public."Person" USING btree ("spouseId");


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: CheraFamily CheraFamily_familyHeadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."CheraFamily"
    ADD CONSTRAINT "CheraFamily_familyHeadId_fkey" FOREIGN KEY ("familyHeadId") REFERENCES public."Person"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Person Person_fatherId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_fatherId_fkey" FOREIGN KEY ("fatherId") REFERENCES public."Person"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Person Person_motherId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_motherId_fkey" FOREIGN KEY ("motherId") REFERENCES public."Person"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Person Person_spouseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_spouseId_fkey" FOREIGN KEY ("spouseId") REFERENCES public."Person"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

