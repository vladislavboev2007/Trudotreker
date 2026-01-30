--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-10-13 20:11:42

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 25181)
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    "empId" integer NOT NULL,
    "FIO" character varying(255) NOT NULL
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25180)
-- Name: Employee_empId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Employee_empId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Employee_empId_seq" OWNER TO postgres;

--
-- TOC entry 4807 (class 0 OID 0)
-- Dependencies: 217
-- Name: Employee_empId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Employee_empId_seq" OWNED BY public."Employee"."empId";


--
-- TOC entry 220 (class 1259 OID 25188)
-- Name: Task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Task" (
    "taskId" integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    start time without time zone,
    final time without time zone,
    date date,
    "empId" integer NOT NULL
);


ALTER TABLE public."Task" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25187)
-- Name: Task_taskId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Task_taskId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Task_taskId_seq" OWNER TO postgres;

--
-- TOC entry 4808 (class 0 OID 0)
-- Dependencies: 219
-- Name: Task_taskId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Task_taskId_seq" OWNED BY public."Task"."taskId";


--
-- TOC entry 4646 (class 2604 OID 25184)
-- Name: Employee empId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee" ALTER COLUMN "empId" SET DEFAULT nextval('public."Employee_empId_seq"'::regclass);


--
-- TOC entry 4647 (class 2604 OID 25191)
-- Name: Task taskId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task" ALTER COLUMN "taskId" SET DEFAULT nextval('public."Task_taskId_seq"'::regclass);


--
-- TOC entry 4799 (class 0 OID 25181)
-- Dependencies: 218
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" ("empId", "FIO") FROM stdin;
1	Колпаков Матвей Николаевич
2	Иванов Иван Иванович
4	Боев Владислав Максимович
5	Дрожжина София Юрьевна
6	Марков Иван Дмитриевич
7	Бондарь Иван Дмитриевич
29	Гебель Игорь Романович
30	Кочедыков Андрей Михайлович
31	Круглов Егор Максимович
32	Крючкова Оксана Павловна
33	Мазанов Илья Алексеевич
34	Панчиков Иван Дмитриевич
35	Петухов Кирилл Вячеславович
36	Подгорбунский Лев Сергеевич
37	Самсонов Никита Максимович
38	Сачков Максим Денисович
39	Солдатов Даниил Антонович
40	Соловьев Вячеслав Андреевич
41	Соловьева Юлия Сергеевна
42	Сологуб Денис Марианович
43	Феоктистов Глеб Юрьевич
44	Хапов Дмитрий Сергеевич
45	Холодков Михаил Игоревич
46	Чижов Владислав Александрович
47	Чувага Роман Думитрувич
48	Шумов Владислав Михайлович
49	Шумов Дмитрий Михайлович
\.


--
-- TOC entry 4801 (class 0 OID 25188)
-- Dependencies: 220
-- Data for Name: Task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Task" ("taskId", name, description, start, final, date, "empId") FROM stdin;
17	Разработать чистое	Спроектировать здания и ограждения	\N	\N	2025-10-07	4
18	43	erer	\N	\N	2025-10-06	2
19	svdWSSF	SFFSD	20:42:17	20:42:31	2025-10-03	1
20	Задача №1	Описание первой задачи.	21:20:23	05:20:23	2025-10-07	1
21	Задача №2	Описание второй задачи.	21:20:23	07:20:23	2025-10-07	2
22	Задача №3	Описание третьей задачи.	21:20:23	09:20:23	2025-10-07	4
23	Задача №4	Описание четвертой задачи.	21:20:23	11:20:23	2025-10-07	5
24	Задача №5	Описание пятой задачи.	21:20:23	13:20:23	2025-10-07	6
25	Задача №6	Описание шестой задачи.	21:20:23	15:20:23	2025-10-07	7
26	Задача №7	Описание седьмой задачи.	21:20:23	17:20:23	2025-10-07	1
27	Задача №8	Описание восьмой задачи.	21:20:23	19:20:23	2025-10-07	2
28	Задача №9	Описание девятой задачи.	21:20:23	21:20:23	2025-10-07	4
29	Задача №10	Описание десятой задачи.	21:20:23	23:20:23	2025-10-07	5
\.


--
-- TOC entry 4809 (class 0 OID 0)
-- Dependencies: 217
-- Name: Employee_empId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Employee_empId_seq"', 49, true);


--
-- TOC entry 4810 (class 0 OID 0)
-- Dependencies: 219
-- Name: Task_taskId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Task_taskId_seq"', 29, true);


--
-- TOC entry 4649 (class 2606 OID 25186)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("empId");


--
-- TOC entry 4651 (class 2606 OID 25195)
-- Name: Task Task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY ("taskId");


--
-- TOC entry 4652 (class 2606 OID 25196)
-- Name: Task fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT fk_employee FOREIGN KEY ("empId") REFERENCES public."Employee"("empId") ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-10-13 20:11:42

--
-- PostgreSQL database dump complete
--

