--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-16 14:38:23

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
-- TOC entry 6 (class 2615 OID 16389)
-- Name: assets; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA assets;


ALTER SCHEMA assets OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16392)
-- Name: assets; Type: TABLE; Schema: assets; Owner: postgres
--

CREATE TABLE assets.assets (
    id integer NOT NULL,
    asset_name character varying(255) NOT NULL,
    asset_type character varying(50),
    description text,
    CONSTRAINT assets_asset_type_check CHECK (((asset_type)::text = ANY ((ARRAY['Hardware'::character varying, 'Software'::character varying, 'Data'::character varying, 'People'::character varying, 'Process'::character varying])::text[])))
);


ALTER TABLE assets.assets OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: assets_id_seq; Type: SEQUENCE; Schema: assets; Owner: postgres
--

CREATE SEQUENCE assets.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE assets.assets_id_seq OWNER TO postgres;

--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: assets; Owner: postgres
--

ALTER SEQUENCE assets.assets_id_seq OWNED BY assets.assets.id;


--
-- TOC entry 4794 (class 2604 OID 16395)
-- Name: assets id; Type: DEFAULT; Schema: assets; Owner: postgres
--

ALTER TABLE ONLY assets.assets ALTER COLUMN id SET DEFAULT nextval('assets.assets_id_seq'::regclass);


--
-- TOC entry 4944 (class 0 OID 16392)
-- Dependencies: 221
-- Data for Name: assets; Type: TABLE DATA; Schema: assets; Owner: postgres
--

COPY assets.assets (id, asset_name, asset_type, description) FROM stdin;
1	Servers	Hardware	Physical and virtual servers hosting applications and databases
2	Workstations	Hardware	Employee computers for daily business operations
3	Networking Devices	Hardware	Routers, switches, and firewalls for managing network traffic
4	Web Applications	Software	Online platforms and services used by customers and employees
5	Content Management System (CMS)	Software	System for managing website content
6	APIs	Software	Interfaces for integrating third-party services and internal systems
7	Databases	Software	Storage systems for structured data management
8	Customer Records	Data	Personal information and account details of customers
9	Transaction Logs	Data	Records of financial transactions and system events
10	User Credentials	Data	Authentication details including encrypted passwords
11	Employees	People	Staff members managing business operations
12	Customers	People	Users purchasing products or services from the platform
13	IT Staff	People	Personnel responsible for technical maintenance and cybersecurity
14	Payment Processing	Process	Procedures for handling online and in-store transactions
15	Account Authentication	Process	Methods for verifying user identity and access control
16	Backups	Process	Routine data backups to ensure data availability and disaster recovery
\.


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: assets; Owner: postgres
--

SELECT pg_catalog.setval('assets.assets_id_seq', 16, true);


--
-- TOC entry 4797 (class 2606 OID 16400)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: assets; Owner: postgres
--

ALTER TABLE ONLY assets.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


-- Completed on 2025-03-16 14:38:23

--
-- PostgreSQL database dump complete
--

