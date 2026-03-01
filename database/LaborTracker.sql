--
-- PostgreSQL database dump
--

\restrict rSJOL8kc5tHOY7kaUq3abNppf1z8cP8odjSeZc881HdAtWskr0bhwCV2varlUOR

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-18 20:36:54

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
-- TOC entry 219 (class 1259 OID 24577)
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    "empId" integer NOT NULL,
    "FIO" character varying(255) NOT NULL
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24582)
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
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 220
-- Name: Employee_empId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Employee_empId_seq" OWNED BY public."Employee"."empId";


--
-- TOC entry 221 (class 1259 OID 24583)
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
-- TOC entry 222 (class 1259 OID 24591)
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
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 222
-- Name: Task_taskId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Task_taskId_seq" OWNED BY public."Task"."taskId";


--
-- TOC entry 4760 (class 2604 OID 24592)
-- Name: Employee empId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee" ALTER COLUMN "empId" SET DEFAULT nextval('public."Employee_empId_seq"'::regclass);


--
-- TOC entry 4761 (class 2604 OID 24593)
-- Name: Task taskId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task" ALTER COLUMN "taskId" SET DEFAULT nextval('public."Task_taskId_seq"'::regclass);


--
-- TOC entry 4914 (class 0 OID 24577)
-- Dependencies: 219
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
-- TOC entry 4916 (class 0 OID 24583)
-- Dependencies: 221
-- Data for Name: Task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Task" ("taskId", name, description, start, final, date, "empId") FROM stdin;
64	Оформиь отчет		10:00:00	12:00:00	2026-02-16	33
65	Оформить отчет отчет по практике	Должен включать в себя руководство пользователя, руководство программиста и методика тестирования и испытания.	09:00:00	11:10:00	2026-02-17	4
54	Анализ производительности	Тестирование под нагрузкой	\N	\N	2026-01-21	30
57	Создание диаграмм	Визуализация данных	\N	\N	2026-01-25	33
58	Багфикс	Исправление критических ошибок	\N	\N	2026-01-27	34
59	Интеграция с внешним API	Подключение к платежной системе	\N	\N	2026-01-28	35
60	Обновление БД	Миграция данных	\N	\N	2026-01-30	36
61	Планирование спринта	Подготовка задач на следующий спринт	\N	\N	2026-02-01	37
62	Код ревью	Проверка кода коллег	\N	\N	2026-02-02	38
63	Создание презентации	Подготовка к демо	\N	\N	2026-02-03	39
47	Разработка API	Создание REST API для системы	10:10:10	14:11:00	2026-01-12	1
49	Документация	Написание технической документации	10:00:00	13:00:00	2026-01-14	4
50	Оптимизация запросов	Оптимизация SQL запросов к БД	09:40:00	10:50:00	2026-01-15	5
51	Фронтенд разработка	Верстка интерфейса пользователя	16:00:00	18:00:00	2026-01-16	6
52	Рефакторинг кода	Улучшение структуры кода	13:00:00	14:00:00	2026-01-17	7
53	Развертывание	Деплой на тестовый сервер	15:50:00	17:05:00	2026-01-20	29
55	Обучение стажера	Обучение новичка работе с системой	19:02:05.468323	19:02:48.077612	2026-01-23	31
77	Разработка модуля авторизации	Создание формы входа, JWT-токены	\N	\N	2026-02-17	1
78	Вёрстка страницы статистики	Адаптивная вёрстка, графики	\N	\N	2026-02-17	2
79	Тестирование API	Написание тестов для эндпоинтов	\N	\N	2026-02-18	4
80	Настройка сервера	Развёртывание на Ubuntu, настройка nginx	\N	\N	2026-02-18	5
81	Документирование кода	Написание docstring и комментариев	\N	\N	2026-02-19	6
82	Исправление багов	Поиск и устранение ошибок в интерфейсе	\N	\N	2026-02-19	7
83	Оптимизация запросов к БД	Добавление индексов, анализ планов	\N	\N	2026-02-20	29
84	Создание отчётов PDF	Генерация PDF с графиками	\N	\N	2026-02-20	30
85	Импорт данных из Excel	Реализация массового импорта задач	\N	\N	2026-02-21	1
86	Рефакторинг кода	Улучшение структуры проекта	\N	\N	2026-02-21	2
\.


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 220
-- Name: Employee_empId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Employee_empId_seq"', 49, true);


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 222
-- Name: Task_taskId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Task_taskId_seq"', 86, true);


--
-- TOC entry 4763 (class 2606 OID 24595)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("empId");


--
-- TOC entry 4765 (class 2606 OID 24597)
-- Name: Task Task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY ("taskId");


--
-- TOC entry 4766 (class 2606 OID 24598)
-- Name: Task fk_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT fk_employee FOREIGN KEY ("empId") REFERENCES public."Employee"("empId") ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-02-18 20:36:55

--
-- PostgreSQL database dump complete
--

\unrestrict rSJOL8kc5tHOY7kaUq3abNppf1z8cP8odjSeZc881HdAtWskr0bhwCV2varlUOR

