--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.1

-- Started on 2024-04-06 22:44:06 CST

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

DROP DATABASE go;
--
-- TOC entry 3412 (class 1262 OID 16384)
-- Name: go; Type: DATABASE; Schema: -; Owner: go
--

CREATE DATABASE go WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE go OWNER TO go;

\connect go

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16386)
-- Name: ad; Type: TABLE; Schema: public; Owner: go
--

CREATE TABLE public.ad (
    id integer NOT NULL,
    title text NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ad OWNER TO go;

--
-- TOC entry 214 (class 1259 OID 16385)
-- Name: ad_id_seq; Type: SEQUENCE; Schema: public; Owner: go
--

CREATE SEQUENCE public.ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ad_id_seq OWNER TO go;

--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 214
-- Name: ad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: go
--

ALTER SEQUENCE public.ad_id_seq OWNED BY public.ad.id;


--
-- TOC entry 218 (class 1259 OID 16396)
-- Name: condition; Type: TABLE; Schema: public; Owner: go
--

CREATE TABLE public.condition (
    id integer NOT NULL,
    ad_id integer NOT NULL,
    age_start smallint,
    age_end smallint,
    gender text[],
    country text[],
    platform text[]
);


ALTER TABLE public.condition OWNER TO go;

--
-- TOC entry 217 (class 1259 OID 16395)
-- Name: condition_ad_id_seq; Type: SEQUENCE; Schema: public; Owner: go
--

CREATE SEQUENCE public.condition_ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.condition_ad_id_seq OWNER TO go;

--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 217
-- Name: condition_ad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: go
--

ALTER SEQUENCE public.condition_ad_id_seq OWNED BY public.condition.ad_id;


--
-- TOC entry 216 (class 1259 OID 16394)
-- Name: condition_id_seq; Type: SEQUENCE; Schema: public; Owner: go
--

CREATE SEQUENCE public.condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.condition_id_seq OWNER TO go;

--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 216
-- Name: condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: go
--

ALTER SEQUENCE public.condition_id_seq OWNED BY public.condition.id;


--
-- TOC entry 3248 (class 2604 OID 16389)
-- Name: ad id; Type: DEFAULT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.ad ALTER COLUMN id SET DEFAULT nextval('public.ad_id_seq'::regclass);


--
-- TOC entry 3249 (class 2604 OID 16399)
-- Name: condition id; Type: DEFAULT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.condition ALTER COLUMN id SET DEFAULT nextval('public.condition_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 16400)
-- Name: condition ad_id; Type: DEFAULT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.condition ALTER COLUMN ad_id SET DEFAULT nextval('public.condition_ad_id_seq'::regclass);


--
-- TOC entry 3403 (class 0 OID 16386)
-- Dependencies: 215
-- Data for Name: ad; Type: TABLE DATA; Schema: public; Owner: go
--

INSERT INTO public.ad VALUES (1, 'AD 1', '2024-09-23 00:00:00', '2024-10-17 00:00:00');
INSERT INTO public.ad VALUES (2, 'AD 2', '2024-01-18 00:00:00', '2024-02-06 00:00:00');
INSERT INTO public.ad VALUES (3, 'AD 3', '2024-09-25 00:00:00', '2024-10-25 00:00:00');
INSERT INTO public.ad VALUES (4, 'AD 4', '2024-11-17 00:00:00', '2024-12-01 00:00:00');
INSERT INTO public.ad VALUES (5, 'AD 5', '2024-11-02 00:00:00', '2024-11-23 00:00:00');
INSERT INTO public.ad VALUES (6, 'AD 6', '2024-04-10 00:00:00', '2024-04-28 00:00:00');
INSERT INTO public.ad VALUES (7, 'AD 7', '2024-02-09 00:00:00', '2024-03-10 00:00:00');
INSERT INTO public.ad VALUES (8, 'AD 8', '2024-09-24 00:00:00', '2024-10-12 00:00:00');
INSERT INTO public.ad VALUES (9, 'AD 9', '2024-03-08 00:00:00', '2024-03-28 00:00:00');
INSERT INTO public.ad VALUES (10, 'AD 10', '2024-03-20 00:00:00', '2024-04-15 00:00:00');
INSERT INTO public.ad VALUES (11, 'AD 11', '2024-10-23 00:00:00', '2024-11-12 00:00:00');
INSERT INTO public.ad VALUES (12, 'AD 12', '2024-02-07 00:00:00', '2024-02-24 00:00:00');
INSERT INTO public.ad VALUES (13, 'AD 13', '2024-06-17 00:00:00', '2024-06-22 00:00:00');
INSERT INTO public.ad VALUES (14, 'AD 14', '2024-02-09 00:00:00', '2024-02-16 00:00:00');
INSERT INTO public.ad VALUES (15, 'AD 15', '2024-06-03 00:00:00', '2024-06-22 00:00:00');
INSERT INTO public.ad VALUES (16, 'AD 16', '2024-08-10 00:00:00', '2024-09-04 00:00:00');
INSERT INTO public.ad VALUES (17, 'AD 17', '2024-05-02 00:00:00', '2024-05-31 00:00:00');
INSERT INTO public.ad VALUES (18, 'AD 18', '2024-07-30 00:00:00', '2024-08-18 00:00:00');
INSERT INTO public.ad VALUES (19, 'AD 19', '2024-03-23 00:00:00', '2024-04-16 00:00:00');
INSERT INTO public.ad VALUES (20, 'AD 20', '2024-09-11 00:00:00', '2024-10-11 00:00:00');
INSERT INTO public.ad VALUES (21, 'AD 21', '2024-08-24 00:00:00', '2024-09-18 00:00:00');
INSERT INTO public.ad VALUES (22, 'AD 22', '2024-11-09 00:00:00', '2024-11-13 00:00:00');
INSERT INTO public.ad VALUES (23, 'AD 23', '2024-07-30 00:00:00', '2024-08-23 00:00:00');
INSERT INTO public.ad VALUES (24, 'AD 24', '2024-09-14 00:00:00', '2024-10-04 00:00:00');
INSERT INTO public.ad VALUES (25, 'AD 25', '2024-02-19 00:00:00', '2024-02-24 00:00:00');
INSERT INTO public.ad VALUES (26, 'AD 26', '2024-04-12 00:00:00', '2024-05-04 00:00:00');
INSERT INTO public.ad VALUES (27, 'AD 27', '2024-12-03 00:00:00', '2024-12-06 00:00:00');
INSERT INTO public.ad VALUES (28, 'AD 28', '2024-07-29 00:00:00', '2024-08-19 00:00:00');
INSERT INTO public.ad VALUES (29, 'AD 29', '2024-12-30 00:00:00', '2025-01-07 00:00:00');
INSERT INTO public.ad VALUES (30, 'AD 30', '2024-11-14 00:00:00', '2024-11-29 00:00:00');
INSERT INTO public.ad VALUES (31, 'AD 31', '2024-12-11 00:00:00', '2024-12-22 00:00:00');
INSERT INTO public.ad VALUES (32, 'AD 32', '2024-03-29 00:00:00', '2024-04-24 00:00:00');
INSERT INTO public.ad VALUES (33, 'AD 33', '2024-06-20 00:00:00', '2024-06-26 00:00:00');
INSERT INTO public.ad VALUES (34, 'AD 34', '2024-02-24 00:00:00', '2024-03-01 00:00:00');
INSERT INTO public.ad VALUES (35, 'AD 35', '2024-10-01 00:00:00', '2024-10-16 00:00:00');
INSERT INTO public.ad VALUES (36, 'AD 36', '2024-12-08 00:00:00', '2024-12-21 00:00:00');
INSERT INTO public.ad VALUES (37, 'AD 37', '2024-04-17 00:00:00', '2024-05-12 00:00:00');
INSERT INTO public.ad VALUES (38, 'AD 38', '2024-05-08 00:00:00', '2024-05-21 00:00:00');
INSERT INTO public.ad VALUES (39, 'AD 39', '2024-12-01 00:00:00', '2024-12-05 00:00:00');
INSERT INTO public.ad VALUES (40, 'AD 40', '2024-04-17 00:00:00', '2024-05-13 00:00:00');
INSERT INTO public.ad VALUES (41, 'AD 41', '2024-09-02 00:00:00', '2024-09-14 00:00:00');
INSERT INTO public.ad VALUES (42, 'AD 42', '2024-08-24 00:00:00', '2024-09-22 00:00:00');
INSERT INTO public.ad VALUES (43, 'AD 43', '2024-06-03 00:00:00', '2024-06-17 00:00:00');
INSERT INTO public.ad VALUES (44, 'AD 44', '2024-09-22 00:00:00', '2024-10-12 00:00:00');
INSERT INTO public.ad VALUES (45, 'AD 45', '2024-05-27 00:00:00', '2024-06-12 00:00:00');
INSERT INTO public.ad VALUES (46, 'AD 46', '2024-01-22 00:00:00', '2024-02-21 00:00:00');
INSERT INTO public.ad VALUES (47, 'AD 47', '2024-12-09 00:00:00', '2025-01-01 00:00:00');
INSERT INTO public.ad VALUES (48, 'AD 48', '2024-12-09 00:00:00', '2024-12-23 00:00:00');
INSERT INTO public.ad VALUES (49, 'AD 49', '2024-03-22 00:00:00', '2024-04-20 00:00:00');
INSERT INTO public.ad VALUES (50, 'AD 50', '2024-07-31 00:00:00', '2024-08-29 00:00:00');
INSERT INTO public.ad VALUES (51, 'AD 51', '2024-02-09 00:00:00', '2024-02-25 00:00:00');
INSERT INTO public.ad VALUES (52, 'AD 52', '2024-06-12 00:00:00', '2024-06-14 00:00:00');
INSERT INTO public.ad VALUES (53, 'AD 53', '2024-09-01 00:00:00', '2024-09-09 00:00:00');
INSERT INTO public.ad VALUES (54, 'AD 54', '2024-06-23 00:00:00', '2024-07-09 00:00:00');
INSERT INTO public.ad VALUES (55, 'AD 55', '2024-12-16 00:00:00', '2025-01-14 00:00:00');
INSERT INTO public.ad VALUES (56, 'AD 56', '2024-07-06 00:00:00', '2024-07-29 00:00:00');
INSERT INTO public.ad VALUES (57, 'AD 57', '2024-08-25 00:00:00', '2024-08-27 00:00:00');
INSERT INTO public.ad VALUES (58, 'AD 58', '2024-06-21 00:00:00', '2024-07-20 00:00:00');
INSERT INTO public.ad VALUES (59, 'AD 59', '2024-01-24 00:00:00', '2024-02-09 00:00:00');
INSERT INTO public.ad VALUES (60, 'AD 60', '2024-02-06 00:00:00', '2024-02-10 00:00:00');
INSERT INTO public.ad VALUES (61, 'AD 61', '2024-12-03 00:00:00', '2024-12-24 00:00:00');
INSERT INTO public.ad VALUES (62, 'AD 62', '2024-10-06 00:00:00', '2024-10-15 00:00:00');
INSERT INTO public.ad VALUES (63, 'AD 63', '2024-09-19 00:00:00', '2024-10-14 00:00:00');
INSERT INTO public.ad VALUES (64, 'AD 64', '2024-08-31 00:00:00', '2024-09-05 00:00:00');
INSERT INTO public.ad VALUES (65, 'AD 65', '2024-06-26 00:00:00', '2024-06-27 00:00:00');
INSERT INTO public.ad VALUES (66, 'AD 66', '2024-05-02 00:00:00', '2024-05-14 00:00:00');
INSERT INTO public.ad VALUES (67, 'AD 67', '2024-10-11 00:00:00', '2024-11-10 00:00:00');
INSERT INTO public.ad VALUES (68, 'AD 68', '2024-01-09 00:00:00', '2024-01-16 00:00:00');
INSERT INTO public.ad VALUES (69, 'AD 69', '2024-11-03 00:00:00', '2024-11-27 00:00:00');
INSERT INTO public.ad VALUES (70, 'AD 70', '2024-02-06 00:00:00', '2024-02-19 00:00:00');
INSERT INTO public.ad VALUES (71, 'AD 71', '2024-11-03 00:00:00', '2024-11-23 00:00:00');
INSERT INTO public.ad VALUES (72, 'AD 72', '2024-05-10 00:00:00', '2024-06-05 00:00:00');
INSERT INTO public.ad VALUES (73, 'AD 73', '2024-01-29 00:00:00', '2024-02-24 00:00:00');
INSERT INTO public.ad VALUES (74, 'AD 74', '2024-11-10 00:00:00', '2024-12-10 00:00:00');
INSERT INTO public.ad VALUES (75, 'AD 75', '2024-10-11 00:00:00', '2024-10-20 00:00:00');
INSERT INTO public.ad VALUES (76, 'AD 76', '2024-11-01 00:00:00', '2024-11-08 00:00:00');
INSERT INTO public.ad VALUES (77, 'AD 77', '2024-06-08 00:00:00', '2024-06-17 00:00:00');
INSERT INTO public.ad VALUES (78, 'AD 78', '2024-01-09 00:00:00', '2024-01-16 00:00:00');
INSERT INTO public.ad VALUES (79, 'AD 79', '2024-02-04 00:00:00', '2024-02-12 00:00:00');
INSERT INTO public.ad VALUES (80, 'AD 80', '2024-05-08 00:00:00', '2024-06-03 00:00:00');
INSERT INTO public.ad VALUES (81, 'AD 81', '2024-09-07 00:00:00', '2024-09-14 00:00:00');
INSERT INTO public.ad VALUES (82, 'AD 82', '2024-09-26 00:00:00', '2024-09-29 00:00:00');
INSERT INTO public.ad VALUES (83, 'AD 83', '2024-08-16 00:00:00', '2024-09-02 00:00:00');
INSERT INTO public.ad VALUES (84, 'AD 84', '2024-11-01 00:00:00', '2024-11-27 00:00:00');
INSERT INTO public.ad VALUES (85, 'AD 85', '2024-03-09 00:00:00', '2024-03-29 00:00:00');
INSERT INTO public.ad VALUES (86, 'AD 86', '2024-12-01 00:00:00', '2024-12-17 00:00:00');
INSERT INTO public.ad VALUES (87, 'AD 87', '2024-09-22 00:00:00', '2024-10-08 00:00:00');
INSERT INTO public.ad VALUES (88, 'AD 88', '2024-05-25 00:00:00', '2024-06-17 00:00:00');
INSERT INTO public.ad VALUES (89, 'AD 89', '2024-08-30 00:00:00', '2024-09-07 00:00:00');
INSERT INTO public.ad VALUES (90, 'AD 90', '2024-07-17 00:00:00', '2024-08-13 00:00:00');
INSERT INTO public.ad VALUES (91, 'AD 91', '2024-06-12 00:00:00', '2024-07-11 00:00:00');
INSERT INTO public.ad VALUES (92, 'AD 92', '2024-07-11 00:00:00', '2024-08-01 00:00:00');
INSERT INTO public.ad VALUES (93, 'AD 93', '2024-10-30 00:00:00', '2024-11-05 00:00:00');
INSERT INTO public.ad VALUES (94, 'AD 94', '2024-03-13 00:00:00', '2024-03-27 00:00:00');
INSERT INTO public.ad VALUES (95, 'AD 95', '2024-08-01 00:00:00', '2024-08-29 00:00:00');
INSERT INTO public.ad VALUES (96, 'AD 96', '2024-09-29 00:00:00', '2024-10-27 00:00:00');
INSERT INTO public.ad VALUES (97, 'AD 97', '2024-10-08 00:00:00', '2024-10-13 00:00:00');
INSERT INTO public.ad VALUES (98, 'AD 98', '2024-01-22 00:00:00', '2024-02-13 00:00:00');
INSERT INTO public.ad VALUES (99, 'AD 99', '2024-07-18 00:00:00', '2024-08-03 00:00:00');
INSERT INTO public.ad VALUES (100, 'AD 100', '2024-06-07 00:00:00', '2024-07-03 00:00:00');
INSERT INTO public.ad VALUES (101, 'AD 55', '2024-01-01 03:00:00', '2024-12-31 16:00:00');
INSERT INTO public.ad VALUES (102, 'AD 55', '2024-01-01 03:00:00', '2024-12-31 16:00:00');
INSERT INTO public.ad VALUES (103, 'AD 55', '2024-01-01 03:00:00', '2024-12-31 16:00:00');


--
-- TOC entry 3406 (class 0 OID 16396)
-- Dependencies: 218
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: go
--

INSERT INTO public.condition VALUES (1, 1, 24, 31, NULL, '{CA,JP}', '{android}');
INSERT INTO public.condition VALUES (2, 1, 41, 54, '{F}', '{AU,DE,JP}', '{ios,android}');
INSERT INTO public.condition VALUES (3, 1, 43, 60, '{M}', '{TW,DE}', '{ios}');
INSERT INTO public.condition VALUES (4, 2, 39, 48, '{M,F}', '{BR,TW}', '{ios}');
INSERT INTO public.condition VALUES (5, 2, 31, 37, '{M,F}', '{US,JP,FR}', '{ios}');
INSERT INTO public.condition VALUES (6, 3, 18, 28, NULL, '{IT}', '{android}');
INSERT INTO public.condition VALUES (7, 3, 47, 66, '{F}', '{AU,FR}', '{android}');
INSERT INTO public.condition VALUES (8, 4, 60, 71, NULL, '{CA,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (9, 4, 42, 53, '{M}', '{IT,FR}', '{android}');
INSERT INTO public.condition VALUES (10, 4, 37, 43, '{F}', '{CA}', '{ios,android}');
INSERT INTO public.condition VALUES (11, 5, 56, 67, NULL, '{GB}', '{ios,android}');
INSERT INTO public.condition VALUES (12, 5, 23, 34, NULL, '{TW,DE}', '{ios}');
INSERT INTO public.condition VALUES (13, 6, 18, 31, '{F,M}', '{IT}', '{android,ios}');
INSERT INTO public.condition VALUES (14, 7, 25, 32, '{M}', '{AU}', '{ios}');
INSERT INTO public.condition VALUES (15, 7, 23, 29, NULL, '{IT,TW}', '{android,ios}');
INSERT INTO public.condition VALUES (16, 8, 49, 56, NULL, '{US,JP,AU}', '{android,ios}');
INSERT INTO public.condition VALUES (17, 9, 30, 36, NULL, '{DE}', '{ios,android}');
INSERT INTO public.condition VALUES (18, 10, 22, 30, '{F,M}', '{GB,DE}', '{android}');
INSERT INTO public.condition VALUES (19, 10, 38, 57, NULL, '{CA,TW,FR}', '{ios,android}');
INSERT INTO public.condition VALUES (20, 10, 26, 37, '{F}', '{TW,DE}', '{ios}');
INSERT INTO public.condition VALUES (21, 11, 36, 51, NULL, '{JP}', '{ios,android}');
INSERT INTO public.condition VALUES (22, 11, 54, 71, '{F,M}', '{FR,CA}', '{ios,android}');
INSERT INTO public.condition VALUES (23, 11, 58, 70, '{M}', '{FR,GB,US}', '{ios}');
INSERT INTO public.condition VALUES (24, 12, 56, 67, '{M,F}', '{IT,GB}', '{ios}');
INSERT INTO public.condition VALUES (25, 13, 50, 62, '{M}', '{US,CA}', '{android,ios}');
INSERT INTO public.condition VALUES (26, 13, 24, 35, '{F}', '{CA,TW}', '{android,ios}');
INSERT INTO public.condition VALUES (27, 14, 21, 28, NULL, '{JP,TW,DE}', '{android,ios}');
INSERT INTO public.condition VALUES (28, 15, 59, 67, NULL, '{FR,CA}', '{ios}');
INSERT INTO public.condition VALUES (29, 15, 20, 37, NULL, '{CA,IT}', '{android,ios}');
INSERT INTO public.condition VALUES (30, 16, 35, 51, '{M,F}', '{FR,CA}', '{android,ios}');
INSERT INTO public.condition VALUES (31, 16, 24, 40, '{M,F}', '{DE,US,GB}', '{android,ios}');
INSERT INTO public.condition VALUES (32, 16, 51, 65, '{M,F}', '{BR}', '{android,ios}');
INSERT INTO public.condition VALUES (33, 17, 35, 42, '{M}', '{TW,DE,AU}', '{ios}');
INSERT INTO public.condition VALUES (34, 17, 41, 51, '{M}', '{US}', '{android}');
INSERT INTO public.condition VALUES (35, 18, 23, 41, '{M}', '{BR}', '{android}');
INSERT INTO public.condition VALUES (36, 19, 46, 53, '{M,F}', '{FR,BR}', '{ios}');
INSERT INTO public.condition VALUES (37, 19, 27, 34, '{F,M}', '{DE}', '{ios}');
INSERT INTO public.condition VALUES (38, 20, 22, 38, '{F,M}', '{IT}', '{ios,android}');
INSERT INTO public.condition VALUES (39, 21, 56, 70, NULL, '{DE}', '{android,ios}');
INSERT INTO public.condition VALUES (40, 21, 43, 59, NULL, '{IT,GB}', '{android}');
INSERT INTO public.condition VALUES (41, 21, 22, 29, NULL, '{AU}', '{android}');
INSERT INTO public.condition VALUES (42, 22, 45, 50, '{M,F}', '{DE,GB}', '{ios}');
INSERT INTO public.condition VALUES (43, 22, 48, 68, NULL, '{TW,GB,CA}', '{android}');
INSERT INTO public.condition VALUES (44, 22, 48, 65, NULL, '{GB,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (45, 23, 46, 61, NULL, '{FR,CA,AU}', '{ios}');
INSERT INTO public.condition VALUES (46, 23, 41, 57, '{M}', '{TW,BR}', '{android}');
INSERT INTO public.condition VALUES (47, 24, 56, 74, '{M}', '{AU,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (48, 24, 42, 58, '{M}', '{JP,DE,CA}', '{ios}');
INSERT INTO public.condition VALUES (49, 24, 53, 68, '{M}', '{AU}', '{android,ios}');
INSERT INTO public.condition VALUES (50, 25, 36, 42, '{F,M}', '{CA,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (51, 25, 18, 27, '{F,M}', '{IT,BR,GB}', '{android}');
INSERT INTO public.condition VALUES (52, 25, 25, 41, '{M,F}', '{FR}', '{ios,android}');
INSERT INTO public.condition VALUES (53, 26, 21, 41, '{F}', '{JP,TW}', '{android,ios}');
INSERT INTO public.condition VALUES (54, 27, 32, 46, '{F,M}', '{JP}', '{android,ios}');
INSERT INTO public.condition VALUES (55, 27, 37, 53, '{F}', '{TW}', '{android,ios}');
INSERT INTO public.condition VALUES (56, 28, 34, 44, '{M,F}', '{AU,JP}', '{ios}');
INSERT INTO public.condition VALUES (57, 29, 51, 71, NULL, '{AU,US}', '{android,ios}');
INSERT INTO public.condition VALUES (58, 29, 22, 30, NULL, '{CA,AU,DE}', '{android}');
INSERT INTO public.condition VALUES (59, 29, 32, 43, NULL, '{IT,DE,AU}', '{android}');
INSERT INTO public.condition VALUES (60, 30, 60, 77, NULL, '{DE,IT}', '{android}');
INSERT INTO public.condition VALUES (61, 30, 35, 42, '{M,F}', '{IT,TW,BR}', '{android}');
INSERT INTO public.condition VALUES (62, 31, 24, 41, NULL, '{TW,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (63, 31, 28, 35, NULL, '{FR,GB,TW}', '{ios}');
INSERT INTO public.condition VALUES (64, 31, 22, 37, '{M}', '{JP,US,CA}', '{ios,android}');
INSERT INTO public.condition VALUES (65, 32, 55, 72, '{F}', '{BR}', '{android}');
INSERT INTO public.condition VALUES (66, 32, 57, 75, NULL, '{FR,JP,TW}', '{ios,android}');
INSERT INTO public.condition VALUES (67, 32, 24, 33, '{M,F}', '{IT}', '{android}');
INSERT INTO public.condition VALUES (68, 33, 28, 40, NULL, '{JP,BR,US}', '{ios}');
INSERT INTO public.condition VALUES (69, 33, 50, 62, '{F,M}', '{FR,BR,CA}', '{android}');
INSERT INTO public.condition VALUES (70, 34, 19, 27, NULL, '{TW,CA}', '{ios}');
INSERT INTO public.condition VALUES (71, 35, 38, 47, '{F}', '{BR}', '{ios}');
INSERT INTO public.condition VALUES (72, 35, 39, 59, NULL, '{FR}', '{ios,android}');
INSERT INTO public.condition VALUES (73, 36, 46, 59, NULL, '{CA,DE}', '{ios}');
INSERT INTO public.condition VALUES (74, 36, 25, 40, NULL, '{DE,JP,AU}', '{android}');
INSERT INTO public.condition VALUES (75, 36, 41, 51, NULL, '{JP,DE,CA}', '{ios}');
INSERT INTO public.condition VALUES (76, 37, 33, 43, '{F,M}', '{DE,TW}', '{android}');
INSERT INTO public.condition VALUES (77, 38, 50, 61, NULL, '{BR,FR,DE}', '{android,ios}');
INSERT INTO public.condition VALUES (78, 38, 48, 67, '{M}', '{DE}', '{android,ios}');
INSERT INTO public.condition VALUES (79, 39, 20, 27, NULL, '{CA,DE}', '{android}');
INSERT INTO public.condition VALUES (80, 39, 34, 46, '{M,F}', '{IT,US}', '{android,ios}');
INSERT INTO public.condition VALUES (81, 39, 38, 52, NULL, '{IT}', '{android}');
INSERT INTO public.condition VALUES (82, 40, 58, 66, '{M,F}', '{GB,US}', '{android,ios}');
INSERT INTO public.condition VALUES (83, 41, 48, 62, '{F}', '{BR}', '{android}');
INSERT INTO public.condition VALUES (84, 41, 35, 50, '{F}', '{DE,GB}', '{ios,android}');
INSERT INTO public.condition VALUES (85, 41, 28, 44, '{M,F}', '{DE,JP}', '{android,ios}');
INSERT INTO public.condition VALUES (86, 42, 43, 63, NULL, '{JP,IT}', '{android,ios}');
INSERT INTO public.condition VALUES (87, 42, 35, 45, '{M}', '{AU,FR}', '{ios}');
INSERT INTO public.condition VALUES (88, 42, 26, 40, '{M,F}', '{CA}', '{ios}');
INSERT INTO public.condition VALUES (89, 43, 30, 46, '{F}', '{IT,BR,CA}', '{android,ios}');
INSERT INTO public.condition VALUES (90, 44, 43, 50, '{F}', '{DE,GB}', '{android,ios}');
INSERT INTO public.condition VALUES (91, 44, 30, 46, '{M,F}', '{AU}', '{android,ios}');
INSERT INTO public.condition VALUES (92, 44, 30, 42, '{M}', '{FR,BR}', '{android}');
INSERT INTO public.condition VALUES (93, 45, 28, 45, NULL, '{TW,IT,JP}', '{android}');
INSERT INTO public.condition VALUES (94, 45, 30, 44, '{F,M}', '{IT,DE,CA}', '{ios,android}');
INSERT INTO public.condition VALUES (95, 45, 46, 64, '{M}', '{IT,JP,US}', '{ios}');
INSERT INTO public.condition VALUES (96, 46, 18, 37, NULL, '{AU}', '{android,ios}');
INSERT INTO public.condition VALUES (97, 46, 42, 52, NULL, '{CA,JP,GB}', '{ios,android}');
INSERT INTO public.condition VALUES (98, 46, 24, 39, '{F}', '{CA}', '{ios}');
INSERT INTO public.condition VALUES (99, 47, 26, 35, '{M,F}', '{FR,BR,US}', '{ios}');
INSERT INTO public.condition VALUES (100, 48, 22, 34, NULL, '{DE}', '{ios,android}');
INSERT INTO public.condition VALUES (101, 48, 53, 69, '{F,M}', '{AU}', '{android}');
INSERT INTO public.condition VALUES (102, 49, 59, 74, NULL, '{TW,DE,IT}', '{android,ios}');
INSERT INTO public.condition VALUES (103, 50, 39, 52, '{M}', '{FR,DE,IT}', '{ios}');
INSERT INTO public.condition VALUES (104, 51, 51, 61, '{M}', '{BR}', '{ios}');
INSERT INTO public.condition VALUES (105, 52, 29, 47, NULL, '{TW}', '{android}');
INSERT INTO public.condition VALUES (106, 52, 45, 52, NULL, '{US}', '{android,ios}');
INSERT INTO public.condition VALUES (107, 52, 58, 65, '{M}', '{DE}', '{ios}');
INSERT INTO public.condition VALUES (108, 53, 22, 28, '{M,F}', '{AU,IT}', '{android}');
INSERT INTO public.condition VALUES (109, 53, 51, 58, '{F}', '{BR}', '{ios,android}');
INSERT INTO public.condition VALUES (110, 53, 60, 74, '{M}', '{DE,BR,AU}', '{android}');
INSERT INTO public.condition VALUES (111, 54, 18, 36, '{F,M}', '{IT,TW,JP}', '{android}');
INSERT INTO public.condition VALUES (112, 54, 25, 44, NULL, '{GB,CA}', '{ios,android}');
INSERT INTO public.condition VALUES (113, 54, 35, 52, '{M,F}', '{DE,JP}', '{ios,android}');
INSERT INTO public.condition VALUES (114, 55, 47, 65, NULL, '{FR,BR}', '{android}');
INSERT INTO public.condition VALUES (115, 56, 23, 43, NULL, '{US}', '{android,ios}');
INSERT INTO public.condition VALUES (116, 56, 38, 58, '{F,M}', '{BR,TW,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (117, 56, 47, 59, NULL, '{AU}', '{android,ios}');
INSERT INTO public.condition VALUES (118, 57, 47, 53, '{M,F}', '{DE,FR}', '{ios}');
INSERT INTO public.condition VALUES (119, 57, 50, 62, '{F,M}', '{CA,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (120, 58, 24, 30, NULL, '{BR}', '{ios}');
INSERT INTO public.condition VALUES (121, 58, 29, 44, NULL, '{CA}', '{ios,android}');
INSERT INTO public.condition VALUES (122, 58, 44, 57, NULL, '{DE,GB,TW}', '{android}');
INSERT INTO public.condition VALUES (123, 59, 32, 43, NULL, '{TW}', '{ios,android}');
INSERT INTO public.condition VALUES (124, 59, 49, 59, NULL, '{AU,US,TW}', '{android,ios}');
INSERT INTO public.condition VALUES (125, 60, 46, 56, NULL, '{TW}', '{android,ios}');
INSERT INTO public.condition VALUES (126, 60, 47, 64, '{M,F}', '{IT,FR}', '{ios,android}');
INSERT INTO public.condition VALUES (127, 61, 33, 51, NULL, '{US,CA,DE}', '{android,ios}');
INSERT INTO public.condition VALUES (128, 61, 20, 25, NULL, '{JP,AU,FR}', '{android,ios}');
INSERT INTO public.condition VALUES (129, 62, 52, 58, '{F}', '{JP,CA,FR}', '{ios}');
INSERT INTO public.condition VALUES (130, 63, 39, 54, NULL, '{GB,AU,CA}', '{ios,android}');
INSERT INTO public.condition VALUES (131, 63, 33, 48, NULL, '{TW,AU}', '{android}');
INSERT INTO public.condition VALUES (132, 63, 29, 34, NULL, '{BR}', '{ios,android}');
INSERT INTO public.condition VALUES (133, 64, 29, 48, '{F,M}', '{TW}', '{android}');
INSERT INTO public.condition VALUES (134, 64, 50, 60, NULL, '{AU,FR,CA}', '{android,ios}');
INSERT INTO public.condition VALUES (135, 65, 30, 38, NULL, '{US,JP,BR}', '{ios,android}');
INSERT INTO public.condition VALUES (136, 65, 36, 53, '{M}', '{JP}', '{ios,android}');
INSERT INTO public.condition VALUES (137, 65, 46, 58, NULL, '{TW,AU}', '{android}');
INSERT INTO public.condition VALUES (138, 66, 25, 42, '{F,M}', '{US,CA}', '{android}');
INSERT INTO public.condition VALUES (139, 66, 55, 66, '{M}', '{CA}', '{android}');
INSERT INTO public.condition VALUES (140, 67, 32, 46, '{M,F}', '{JP,US,TW}', '{android}');
INSERT INTO public.condition VALUES (141, 67, 37, 57, NULL, '{IT,TW}', '{ios}');
INSERT INTO public.condition VALUES (142, 68, 50, 66, NULL, '{US}', '{ios,android}');
INSERT INTO public.condition VALUES (143, 68, 31, 41, NULL, '{BR,TW}', '{android}');
INSERT INTO public.condition VALUES (144, 68, 60, 72, '{F,M}', '{CA}', '{ios,android}');
INSERT INTO public.condition VALUES (145, 69, 38, 46, NULL, '{AU}', '{ios,android}');
INSERT INTO public.condition VALUES (146, 69, 50, 65, NULL, '{GB,IT}', '{ios}');
INSERT INTO public.condition VALUES (147, 69, 22, 36, NULL, '{CA,JP}', '{ios,android}');
INSERT INTO public.condition VALUES (148, 70, 48, 53, NULL, '{CA,BR}', '{ios,android}');
INSERT INTO public.condition VALUES (149, 71, 25, 35, '{M,F}', '{DE}', '{ios,android}');
INSERT INTO public.condition VALUES (150, 72, 42, 47, NULL, '{DE,TW}', '{android,ios}');
INSERT INTO public.condition VALUES (151, 72, 32, 38, NULL, '{IT,US}', '{ios}');
INSERT INTO public.condition VALUES (152, 73, 21, 29, '{M}', '{GB,FR}', '{ios}');
INSERT INTO public.condition VALUES (153, 74, 34, 48, NULL, '{JP,US,AU}', '{android}');
INSERT INTO public.condition VALUES (154, 74, 26, 45, NULL, '{AU,DE}', '{ios}');
INSERT INTO public.condition VALUES (155, 74, 37, 52, NULL, '{AU}', '{android}');
INSERT INTO public.condition VALUES (156, 75, 50, 60, '{F}', '{TW,JP}', '{android}');
INSERT INTO public.condition VALUES (157, 75, 55, 67, '{M}', '{JP}', '{ios,android}');
INSERT INTO public.condition VALUES (158, 76, 27, 33, '{M,F}', '{US,AU,GB}', '{android,ios}');
INSERT INTO public.condition VALUES (159, 77, 26, 36, '{M,F}', '{BR,JP,IT}', '{ios,android}');
INSERT INTO public.condition VALUES (160, 77, 51, 59, '{F,M}', '{DE}', '{ios,android}');
INSERT INTO public.condition VALUES (161, 77, 26, 36, NULL, '{US}', '{android}');
INSERT INTO public.condition VALUES (162, 78, 21, 41, NULL, '{BR}', '{android}');
INSERT INTO public.condition VALUES (163, 79, 21, 35, NULL, '{DE}', '{android}');
INSERT INTO public.condition VALUES (164, 79, 60, 79, NULL, '{AU,GB}', '{android}');
INSERT INTO public.condition VALUES (165, 79, 43, 63, '{M,F}', '{IT}', '{ios}');
INSERT INTO public.condition VALUES (166, 80, 53, 68, NULL, '{CA,FR}', '{ios}');
INSERT INTO public.condition VALUES (167, 80, 50, 65, '{F}', '{AU,TW}', '{android}');
INSERT INTO public.condition VALUES (168, 80, 27, 45, '{M,F}', '{CA}', '{android,ios}');
INSERT INTO public.condition VALUES (169, 81, 50, 68, NULL, '{DE,US}', '{ios}');
INSERT INTO public.condition VALUES (170, 81, 28, 44, NULL, '{IT}', '{android}');
INSERT INTO public.condition VALUES (171, 82, 55, 63, '{F,M}', '{DE,IT,US}', '{android}');
INSERT INTO public.condition VALUES (172, 82, 26, 37, NULL, '{JP}', '{ios,android}');
INSERT INTO public.condition VALUES (173, 82, 55, 61, '{F,M}', '{AU}', '{android,ios}');
INSERT INTO public.condition VALUES (174, 83, 19, 38, '{M}', '{FR}', '{ios,android}');
INSERT INTO public.condition VALUES (175, 84, 44, 52, '{F,M}', '{IT,JP,GB}', '{ios,android}');
INSERT INTO public.condition VALUES (176, 84, 55, 74, NULL, '{JP,GB}', '{ios}');
INSERT INTO public.condition VALUES (177, 84, 22, 30, '{F,M}', '{GB,JP,FR}', '{ios,android}');
INSERT INTO public.condition VALUES (178, 85, 47, 66, '{M}', '{TW,FR,BR}', '{android}');
INSERT INTO public.condition VALUES (179, 86, 40, 54, NULL, '{IT,CA,JP}', '{ios,android}');
INSERT INTO public.condition VALUES (180, 86, 19, 34, NULL, '{DE,US}', '{ios}');
INSERT INTO public.condition VALUES (181, 86, 25, 40, NULL, '{FR}', '{android,ios}');
INSERT INTO public.condition VALUES (182, 87, 41, 59, NULL, '{IT}', '{ios}');
INSERT INTO public.condition VALUES (183, 88, 39, 51, '{F,M}', '{IT,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (184, 88, 28, 33, '{F,M}', '{US,BR}', '{ios}');
INSERT INTO public.condition VALUES (185, 89, 42, 57, '{F}', '{FR}', '{ios,android}');
INSERT INTO public.condition VALUES (186, 89, 55, 61, '{F,M}', '{US}', '{ios}');
INSERT INTO public.condition VALUES (187, 89, 49, 68, '{F}', '{BR}', '{android,ios}');
INSERT INTO public.condition VALUES (188, 90, 58, 70, NULL, '{GB,FR,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (189, 90, 41, 46, NULL, '{TW}', '{ios,android}');
INSERT INTO public.condition VALUES (190, 90, 19, 36, '{F,M}', '{GB,JP,TW}', '{android}');
INSERT INTO public.condition VALUES (191, 91, 31, 36, NULL, '{GB}', '{android}');
INSERT INTO public.condition VALUES (192, 92, 38, 52, NULL, '{US}', '{ios,android}');
INSERT INTO public.condition VALUES (193, 93, 33, 49, '{F}', '{GB,FR,IT}', '{ios}');
INSERT INTO public.condition VALUES (194, 93, 20, 38, NULL, '{CA,FR,GB}', '{ios,android}');
INSERT INTO public.condition VALUES (195, 93, 20, 25, '{M}', '{GB}', '{android}');
INSERT INTO public.condition VALUES (196, 94, 42, 58, NULL, '{BR,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (197, 94, 44, 63, '{F}', '{GB,AU,JP}', '{ios}');
INSERT INTO public.condition VALUES (198, 95, 48, 61, '{M,F}', '{TW}', '{android,ios}');
INSERT INTO public.condition VALUES (199, 96, 29, 43, NULL, '{GB,DE,CA}', '{android}');
INSERT INTO public.condition VALUES (200, 96, 20, 35, '{M}', '{CA}', '{android,ios}');
INSERT INTO public.condition VALUES (201, 97, 35, 53, NULL, '{FR}', '{ios,android}');
INSERT INTO public.condition VALUES (202, 98, 56, 68, NULL, '{DE}', '{ios,android}');
INSERT INTO public.condition VALUES (203, 98, 58, 77, '{M}', '{BR,IT}', '{ios}');
INSERT INTO public.condition VALUES (204, 98, 45, 56, '{M,F}', '{IT}', '{android}');
INSERT INTO public.condition VALUES (205, 99, 41, 58, NULL, '{IT,JP,AU}', '{ios}');
INSERT INTO public.condition VALUES (206, 99, 46, 64, '{M}', '{TW,FR,BR}', '{android,ios}');
INSERT INTO public.condition VALUES (207, 100, 39, 45, NULL, '{US,AU}', '{ios,android}');
INSERT INTO public.condition VALUES (208, 100, 50, 70, '{F}', '{CA}', '{android}');
INSERT INTO public.condition VALUES (209, 100, 20, 29, NULL, '{US,GB}', '{ios}');
INSERT INTO public.condition VALUES (210, 101, 20, 30, NULL, '{TW,JP}', '{android,ios}');
INSERT INTO public.condition VALUES (211, 101, 50, 60, '{F,M}', NULL, '{android,mobile}');
INSERT INTO public.condition VALUES (212, 102, 20, 30, NULL, '{TW,JP}', '{android,ios}');
INSERT INTO public.condition VALUES (213, 102, 50, 60, '{F,M}', NULL, '{android,mobile}');
INSERT INTO public.condition VALUES (214, 103, 20, 30, NULL, '{TW,JP}', '{android,ios}');
INSERT INTO public.condition VALUES (215, 103, 50, 60, '{F,M}', NULL, '{android,web}');


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 214
-- Name: ad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: go
--

SELECT pg_catalog.setval('public.ad_id_seq', 103, true);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 217
-- Name: condition_ad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: go
--

SELECT pg_catalog.setval('public.condition_ad_id_seq', 1, false);


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 216
-- Name: condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: go
--

SELECT pg_catalog.setval('public.condition_id_seq', 215, true);


--
-- TOC entry 3252 (class 2606 OID 16393)
-- Name: ad ad_pkey; Type: CONSTRAINT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT ad_pkey PRIMARY KEY (id);


--
-- TOC entry 3257 (class 2606 OID 16404)
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (id);


--
-- TOC entry 3255 (class 1259 OID 24576)
-- Name: ListAd; Type: INDEX; Schema: public; Owner: go
--

CREATE INDEX "ListAd" ON public.condition USING btree (age_start, age_end, gender, country, platform) WITH (deduplicate_items='true');


--
-- TOC entry 3253 (class 1259 OID 16411)
-- Name: idx_ad_end_at; Type: INDEX; Schema: public; Owner: go
--

CREATE INDEX idx_ad_end_at ON public.ad USING btree (end_at);


--
-- TOC entry 3254 (class 1259 OID 16410)
-- Name: idx_ad_start_at; Type: INDEX; Schema: public; Owner: go
--

CREATE INDEX idx_ad_start_at ON public.ad USING btree (start_at);


--
-- TOC entry 3258 (class 1259 OID 16412)
-- Name: idx_condition_age_start; Type: INDEX; Schema: public; Owner: go
--

CREATE INDEX idx_condition_age_start ON public.condition USING btree (age_start);


--
-- TOC entry 3259 (class 2606 OID 16405)
-- Name: condition condition_ad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: go
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_ad_id_fkey FOREIGN KEY (ad_id) REFERENCES public.ad(id);


-- Completed on 2024-04-06 22:44:06 CST

--
-- PostgreSQL database dump complete
--

