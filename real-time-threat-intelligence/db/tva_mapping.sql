--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-16 14:37:05

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
-- TOC entry 7 (class 2615 OID 16390)
-- Name: tva_mapping; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tva_mapping;


ALTER SCHEMA tva_mapping OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16414)
-- Name: tva_mapping; Type: TABLE; Schema: tva_mapping; Owner: postgres
--

CREATE TABLE tva_mapping.tva_mapping (
    id integer NOT NULL,
    asset_id integer,
    threat_name character varying(255),
    vulnerability_description text,
    likelihood integer,
    impact integer,
    risk_score integer GENERATED ALWAYS AS ((likelihood * impact)) STORED,
    CONSTRAINT tva_mapping_impact_check CHECK (((impact >= 1) AND (impact <= 5))),
    CONSTRAINT tva_mapping_likelihood_check CHECK (((likelihood >= 1) AND (likelihood <= 5)))
);


ALTER TABLE tva_mapping.tva_mapping OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16413)
-- Name: tva_mapping_id_seq; Type: SEQUENCE; Schema: tva_mapping; Owner: postgres
--

CREATE SEQUENCE tva_mapping.tva_mapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE tva_mapping.tva_mapping_id_seq OWNER TO postgres;

--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 222
-- Name: tva_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: tva_mapping; Owner: postgres
--

ALTER SEQUENCE tva_mapping.tva_mapping_id_seq OWNED BY tva_mapping.tva_mapping.id;


--
-- TOC entry 4794 (class 2604 OID 16417)
-- Name: tva_mapping id; Type: DEFAULT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping ALTER COLUMN id SET DEFAULT nextval('tva_mapping.tva_mapping_id_seq'::regclass);


--
-- TOC entry 4947 (class 0 OID 16414)
-- Dependencies: 223
-- Data for Name: tva_mapping; Type: TABLE DATA; Schema: tva_mapping; Owner: postgres
--

COPY tva_mapping.tva_mapping (id, asset_id, threat_name, vulnerability_description, likelihood, impact) FROM stdin;
1	1	SQL Injection	Improper input validation allows attackers to manipulate SQL queries	4	5
2	11	Phishing Attack	Social engineering attack tricking employees into revealing credentials	5	4
3	4	DDoS Attack	Large-scale traffic overload disrupts availability of web services	3	5
4	10	Credential Stuffing	Attackers use leaked passwords from breaches to gain unauthorized access	4	4
5	3	Man-in-the-Middle Attack	Intercepted communications lead to data theft or manipulation	3	5
\.


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 222
-- Name: tva_mapping_id_seq; Type: SEQUENCE SET; Schema: tva_mapping; Owner: postgres
--

SELECT pg_catalog.setval('tva_mapping.tva_mapping_id_seq', 5, true);


--
-- TOC entry 4799 (class 2606 OID 16424)
-- Name: tva_mapping tva_mapping_pkey; Type: CONSTRAINT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping
    ADD CONSTRAINT tva_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 16425)
-- Name: tva_mapping tva_mapping_asset_id_fkey; Type: FK CONSTRAINT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping
    ADD CONSTRAINT tva_mapping_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES assets.assets(id);


-- Completed on 2025-03-16 14:37:05

--
-- PostgreSQL database dump complete
--

