--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-16 14:31:20

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

--
-- TOC entry 8 (class 2615 OID 16430)
-- Name: schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schema;


ALTER SCHEMA schema OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 16390)
-- Name: tva_mapping; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tva_mapping;


ALTER SCHEMA tva_mapping OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 16625)
-- Name: update_modified_column(); Type: FUNCTION; Schema: schema; Owner: postgres
--

CREATE FUNCTION schema.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION schema.update_modified_column() OWNER TO postgres;

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
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: assets; Owner: postgres
--

ALTER SEQUENCE assets.assets_id_seq OWNED BY assets.assets.id;


--
-- TOC entry 233 (class 1259 OID 16487)
-- Name: asset_threats; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.asset_threats (
    id integer NOT NULL,
    asset_id integer,
    threat_id integer
);


ALTER TABLE schema.asset_threats OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16486)
-- Name: asset_threats_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.asset_threats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.asset_threats_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 232
-- Name: asset_threats_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.asset_threats_id_seq OWNED BY schema.asset_threats.id;


--
-- TOC entry 231 (class 1259 OID 16466)
-- Name: asset_vulnerabilities; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.asset_vulnerabilities (
    id integer NOT NULL,
    asset_id integer,
    vulnerability_id integer,
    date_identified date,
    notes text
);


ALTER TABLE schema.asset_vulnerabilities OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16465)
-- Name: asset_vulnerabilities_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.asset_vulnerabilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.asset_vulnerabilities_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 230
-- Name: asset_vulnerabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.asset_vulnerabilities_id_seq OWNED BY schema.asset_vulnerabilities.id;


--
-- TOC entry 225 (class 1259 OID 16432)
-- Name: assets; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.assets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    asset_type character varying(50) NOT NULL,
    owner character varying(100),
    description text,
    criticality integer,
    location character varying(100),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT assets_criticality_check CHECK (((criticality >= 1) AND (criticality <= 5)))
);


ALTER TABLE schema.assets OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16431)
-- Name: assets_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.assets_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 224
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.assets_id_seq OWNED BY schema.assets.id;


--
-- TOC entry 243 (class 1259 OID 16584)
-- Name: controls; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.controls (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    control_type character varying(50),
    description text,
    implementation_status character varying(50),
    effectiveness_score integer,
    cost numeric(10,2),
    responsible_party character varying(100),
    review_frequency character varying(50),
    last_review_date date,
    next_review_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT controls_effectiveness_score_check CHECK (((effectiveness_score >= 1) AND (effectiveness_score <= 5)))
);


ALTER TABLE schema.controls OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16583)
-- Name: controls_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.controls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.controls_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 242
-- Name: controls_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.controls_id_seq OWNED BY schema.controls.id;


--
-- TOC entry 237 (class 1259 OID 16535)
-- Name: incidents; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.incidents (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    incident_date timestamp with time zone,
    detection_date timestamp with time zone,
    resolution_date timestamp with time zone,
    severity character varying(20),
    status character varying(50),
    affected_assets text,
    threat_id integer,
    vulnerability_id integer,
    attack_vector text,
    response_actions text,
    lessons_learned text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE schema.incidents OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16534)
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.incidents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.incidents_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 236
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.incidents_id_seq OWNED BY schema.incidents.id;


--
-- TOC entry 241 (class 1259 OID 16568)
-- Name: intel_reports; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.intel_reports (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    source_id integer,
    report_date date,
    content text,
    confidence_level character varying(20),
    relevant_threats text,
    relevant_vulnerabilities text,
    tags text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE schema.intel_reports OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16567)
-- Name: intel_reports_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.intel_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.intel_reports_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 240
-- Name: intel_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.intel_reports_id_seq OWNED BY schema.intel_reports.id;


--
-- TOC entry 239 (class 1259 OID 16556)
-- Name: intel_sources; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.intel_sources (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    source_type character varying(50),
    feed_url character varying(255),
    api_key character varying(255),
    reliability_score integer,
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT intel_sources_reliability_score_check CHECK (((reliability_score >= 1) AND (reliability_score <= 10)))
);


ALTER TABLE schema.intel_sources OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16555)
-- Name: intel_sources_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.intel_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.intel_sources_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 238
-- Name: intel_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.intel_sources_id_seq OWNED BY schema.intel_sources.id;


--
-- TOC entry 235 (class 1259 OID 16506)
-- Name: risk_assessments; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.risk_assessments (
    id integer NOT NULL,
    asset_id integer,
    threat_id integer,
    vulnerability_id integer,
    likelihood integer,
    impact integer,
    risk_score numeric(5,2),
    risk_level character varying(20),
    assessment_date date DEFAULT CURRENT_DATE,
    next_review_date date,
    mitigations text,
    status character varying(50),
    assigned_to character varying(100),
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT risk_assessments_impact_check CHECK (((impact >= 1) AND (impact <= 5))),
    CONSTRAINT risk_assessments_likelihood_check CHECK (((likelihood >= 1) AND (likelihood <= 5)))
);


ALTER TABLE schema.risk_assessments OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16505)
-- Name: risk_assessments_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.risk_assessments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.risk_assessments_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 234
-- Name: risk_assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.risk_assessments_id_seq OWNED BY schema.risk_assessments.id;


--
-- TOC entry 245 (class 1259 OID 16596)
-- Name: risk_controls; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.risk_controls (
    id integer NOT NULL,
    risk_assessment_id integer,
    control_id integer,
    date_implemented date,
    notes text
);


ALTER TABLE schema.risk_controls OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16595)
-- Name: risk_controls_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.risk_controls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.risk_controls_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 244
-- Name: risk_controls_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.risk_controls_id_seq OWNED BY schema.risk_controls.id;


--
-- TOC entry 227 (class 1259 OID 16444)
-- Name: threats; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.threats (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    threat_type character varying(50) NOT NULL,
    source character varying(100),
    description text,
    tactics text,
    techniques text,
    indicators text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE schema.threats OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16443)
-- Name: threats_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.threats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.threats_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 226
-- Name: threats_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.threats_id_seq OWNED BY schema.threats.id;


--
-- TOC entry 229 (class 1259 OID 16455)
-- Name: vulnerabilities; Type: TABLE; Schema: schema; Owner: postgres
--

CREATE TABLE schema.vulnerabilities (
    id integer NOT NULL,
    cve_id character varying(20),
    name character varying(255) NOT NULL,
    description text,
    vulnerability_type character varying(50),
    severity character varying(20),
    cvss_score numeric(3,1),
    status character varying(20),
    disclosed_date date,
    remediation_steps text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE schema.vulnerabilities OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16454)
-- Name: vulnerabilities_id_seq; Type: SEQUENCE; Schema: schema; Owner: postgres
--

CREATE SEQUENCE schema.vulnerabilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE schema.vulnerabilities_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 228
-- Name: vulnerabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: schema; Owner: postgres
--

ALTER SEQUENCE schema.vulnerabilities_id_seq OWNED BY schema.vulnerabilities.id;


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
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 222
-- Name: tva_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: tva_mapping; Owner: postgres
--

ALTER SEQUENCE tva_mapping.tva_mapping_id_seq OWNED BY tva_mapping.tva_mapping.id;


--
-- TOC entry 4806 (class 2604 OID 16395)
-- Name: assets id; Type: DEFAULT; Schema: assets; Owner: postgres
--

ALTER TABLE ONLY assets.assets ALTER COLUMN id SET DEFAULT nextval('assets.assets_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 16490)
-- Name: asset_threats id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_threats ALTER COLUMN id SET DEFAULT nextval('schema.asset_threats_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 16469)
-- Name: asset_vulnerabilities id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_vulnerabilities ALTER COLUMN id SET DEFAULT nextval('schema.asset_vulnerabilities_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 16435)
-- Name: assets id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.assets ALTER COLUMN id SET DEFAULT nextval('schema.assets_id_seq'::regclass);


--
-- TOC entry 4833 (class 2604 OID 16587)
-- Name: controls id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.controls ALTER COLUMN id SET DEFAULT nextval('schema.controls_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 16538)
-- Name: incidents id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.incidents ALTER COLUMN id SET DEFAULT nextval('schema.incidents_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 16571)
-- Name: intel_reports id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.intel_reports ALTER COLUMN id SET DEFAULT nextval('schema.intel_reports_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 16559)
-- Name: intel_sources id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.intel_sources ALTER COLUMN id SET DEFAULT nextval('schema.intel_sources_id_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 16509)
-- Name: risk_assessments id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_assessments ALTER COLUMN id SET DEFAULT nextval('schema.risk_assessments_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 16599)
-- Name: risk_controls id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_controls ALTER COLUMN id SET DEFAULT nextval('schema.risk_controls_id_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 16447)
-- Name: threats id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.threats ALTER COLUMN id SET DEFAULT nextval('schema.threats_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 16458)
-- Name: vulnerabilities id; Type: DEFAULT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.vulnerabilities ALTER COLUMN id SET DEFAULT nextval('schema.vulnerabilities_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 16417)
-- Name: tva_mapping id; Type: DEFAULT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping ALTER COLUMN id SET DEFAULT nextval('tva_mapping.tva_mapping_id_seq'::regclass);


--
-- TOC entry 5053 (class 0 OID 16392)
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
-- TOC entry 5065 (class 0 OID 16487)
-- Dependencies: 233
-- Data for Name: asset_threats; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.asset_threats (id, asset_id, threat_id) FROM stdin;
\.


--
-- TOC entry 5063 (class 0 OID 16466)
-- Dependencies: 231
-- Data for Name: asset_vulnerabilities; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.asset_vulnerabilities (id, asset_id, vulnerability_id, date_identified, notes) FROM stdin;
\.


--
-- TOC entry 5057 (class 0 OID 16432)
-- Dependencies: 225
-- Data for Name: assets; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.assets (id, name, asset_type, owner, description, criticality, location, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5075 (class 0 OID 16584)
-- Dependencies: 243
-- Data for Name: controls; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.controls (id, name, control_type, description, implementation_status, effectiveness_score, cost, responsible_party, review_frequency, last_review_date, next_review_date, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5069 (class 0 OID 16535)
-- Dependencies: 237
-- Data for Name: incidents; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.incidents (id, title, description, incident_date, detection_date, resolution_date, severity, status, affected_assets, threat_id, vulnerability_id, attack_vector, response_actions, lessons_learned, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5073 (class 0 OID 16568)
-- Dependencies: 241
-- Data for Name: intel_reports; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.intel_reports (id, title, source_id, report_date, content, confidence_level, relevant_threats, relevant_vulnerabilities, tags, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5071 (class 0 OID 16556)
-- Dependencies: 239
-- Data for Name: intel_sources; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.intel_sources (id, name, source_type, feed_url, api_key, reliability_score, notes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5067 (class 0 OID 16506)
-- Dependencies: 235
-- Data for Name: risk_assessments; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.risk_assessments (id, asset_id, threat_id, vulnerability_id, likelihood, impact, risk_score, risk_level, assessment_date, next_review_date, mitigations, status, assigned_to, notes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5077 (class 0 OID 16596)
-- Dependencies: 245
-- Data for Name: risk_controls; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.risk_controls (id, risk_assessment_id, control_id, date_implemented, notes) FROM stdin;
\.


--
-- TOC entry 5059 (class 0 OID 16444)
-- Dependencies: 227
-- Data for Name: threats; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.threats (id, name, threat_type, source, description, tactics, techniques, indicators, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5061 (class 0 OID 16455)
-- Dependencies: 229
-- Data for Name: vulnerabilities; Type: TABLE DATA; Schema: schema; Owner: postgres
--

COPY schema.vulnerabilities (id, cve_id, name, description, vulnerability_type, severity, cvss_score, status, disclosed_date, remediation_steps, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5055 (class 0 OID 16414)
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
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: assets; Owner: postgres
--

SELECT pg_catalog.setval('assets.assets_id_seq', 16, true);


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 232
-- Name: asset_threats_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.asset_threats_id_seq', 1, false);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 230
-- Name: asset_vulnerabilities_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.asset_vulnerabilities_id_seq', 1, false);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 224
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.assets_id_seq', 1, false);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 242
-- Name: controls_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.controls_id_seq', 1, false);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 236
-- Name: incidents_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.incidents_id_seq', 1, false);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 240
-- Name: intel_reports_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.intel_reports_id_seq', 1, false);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 238
-- Name: intel_sources_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.intel_sources_id_seq', 1, false);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 234
-- Name: risk_assessments_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.risk_assessments_id_seq', 1, false);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 244
-- Name: risk_controls_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.risk_controls_id_seq', 1, false);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 226
-- Name: threats_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.threats_id_seq', 1, false);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 228
-- Name: vulnerabilities_id_seq; Type: SEQUENCE SET; Schema: schema; Owner: postgres
--

SELECT pg_catalog.setval('schema.vulnerabilities_id_seq', 1, false);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 222
-- Name: tva_mapping_id_seq; Type: SEQUENCE SET; Schema: tva_mapping; Owner: postgres
--

SELECT pg_catalog.setval('tva_mapping.tva_mapping_id_seq', 5, true);


--
-- TOC entry 4846 (class 2606 OID 16400)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: assets; Owner: postgres
--

ALTER TABLE ONLY assets.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 16494)
-- Name: asset_threats asset_threats_asset_id_threat_id_key; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_threats
    ADD CONSTRAINT asset_threats_asset_id_threat_id_key UNIQUE (asset_id, threat_id);


--
-- TOC entry 4868 (class 2606 OID 16492)
-- Name: asset_threats asset_threats_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_threats
    ADD CONSTRAINT asset_threats_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 16475)
-- Name: asset_vulnerabilities asset_vulnerabilities_asset_id_vulnerability_id_key; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_vulnerabilities
    ADD CONSTRAINT asset_vulnerabilities_asset_id_vulnerability_id_key UNIQUE (asset_id, vulnerability_id);


--
-- TOC entry 4864 (class 2606 OID 16473)
-- Name: asset_vulnerabilities asset_vulnerabilities_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_vulnerabilities
    ADD CONSTRAINT asset_vulnerabilities_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 16442)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 16594)
-- Name: controls controls_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.controls
    ADD CONSTRAINT controls_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16544)
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 16577)
-- Name: intel_reports intel_reports_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.intel_reports
    ADD CONSTRAINT intel_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 16566)
-- Name: intel_sources intel_sources_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.intel_sources
    ADD CONSTRAINT intel_sources_pkey PRIMARY KEY (id);


--
-- TOC entry 4871 (class 2606 OID 16518)
-- Name: risk_assessments risk_assessments_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_assessments
    ADD CONSTRAINT risk_assessments_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 16603)
-- Name: risk_controls risk_controls_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_controls
    ADD CONSTRAINT risk_controls_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 16605)
-- Name: risk_controls risk_controls_risk_assessment_id_control_id_key; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_controls
    ADD CONSTRAINT risk_controls_risk_assessment_id_control_id_key UNIQUE (risk_assessment_id, control_id);


--
-- TOC entry 4856 (class 2606 OID 16453)
-- Name: threats threats_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.threats
    ADD CONSTRAINT threats_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 16464)
-- Name: vulnerabilities vulnerabilities_pkey; Type: CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.vulnerabilities
    ADD CONSTRAINT vulnerabilities_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 16424)
-- Name: tva_mapping tva_mapping_pkey; Type: CONSTRAINT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping
    ADD CONSTRAINT tva_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 1259 OID 16616)
-- Name: idx_assets_name; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_assets_name ON schema.assets USING btree (name);


--
-- TOC entry 4852 (class 1259 OID 16617)
-- Name: idx_assets_type; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_assets_type ON schema.assets USING btree (asset_type);


--
-- TOC entry 4872 (class 1259 OID 16624)
-- Name: idx_incidents_severity; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_incidents_severity ON schema.incidents USING btree (severity);


--
-- TOC entry 4873 (class 1259 OID 16623)
-- Name: idx_incidents_status; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_incidents_status ON schema.incidents USING btree (status);


--
-- TOC entry 4869 (class 1259 OID 16622)
-- Name: idx_risk_assessments_level; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_risk_assessments_level ON schema.risk_assessments USING btree (risk_level);


--
-- TOC entry 4853 (class 1259 OID 16618)
-- Name: idx_threats_name; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_threats_name ON schema.threats USING btree (name);


--
-- TOC entry 4854 (class 1259 OID 16619)
-- Name: idx_threats_type; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_threats_type ON schema.threats USING btree (threat_type);


--
-- TOC entry 4857 (class 1259 OID 16620)
-- Name: idx_vulnerabilities_cve; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_vulnerabilities_cve ON schema.vulnerabilities USING btree (cve_id);


--
-- TOC entry 4858 (class 1259 OID 16621)
-- Name: idx_vulnerabilities_severity; Type: INDEX; Schema: schema; Owner: postgres
--

CREATE INDEX idx_vulnerabilities_severity ON schema.vulnerabilities USING btree (severity);


--
-- TOC entry 4899 (class 2620 OID 16626)
-- Name: assets update_assets_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_assets_modtime BEFORE UPDATE ON schema.assets FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4906 (class 2620 OID 16633)
-- Name: controls update_controls_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_controls_modtime BEFORE UPDATE ON schema.controls FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4903 (class 2620 OID 16630)
-- Name: incidents update_incidents_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_incidents_modtime BEFORE UPDATE ON schema.incidents FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4905 (class 2620 OID 16632)
-- Name: intel_reports update_intel_reports_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_intel_reports_modtime BEFORE UPDATE ON schema.intel_reports FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4904 (class 2620 OID 16631)
-- Name: intel_sources update_intel_sources_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_intel_sources_modtime BEFORE UPDATE ON schema.intel_sources FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4902 (class 2620 OID 16629)
-- Name: risk_assessments update_risk_assessments_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_risk_assessments_modtime BEFORE UPDATE ON schema.risk_assessments FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4900 (class 2620 OID 16627)
-- Name: threats update_threats_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_threats_modtime BEFORE UPDATE ON schema.threats FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4901 (class 2620 OID 16628)
-- Name: vulnerabilities update_vulnerabilities_modtime; Type: TRIGGER; Schema: schema; Owner: postgres
--

CREATE TRIGGER update_vulnerabilities_modtime BEFORE UPDATE ON schema.vulnerabilities FOR EACH ROW EXECUTE FUNCTION schema.update_modified_column();


--
-- TOC entry 4889 (class 2606 OID 16495)
-- Name: asset_threats asset_threats_asset_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_threats
    ADD CONSTRAINT asset_threats_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES schema.assets(id) ON DELETE CASCADE;


--
-- TOC entry 4890 (class 2606 OID 16500)
-- Name: asset_threats asset_threats_threat_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_threats
    ADD CONSTRAINT asset_threats_threat_id_fkey FOREIGN KEY (threat_id) REFERENCES schema.threats(id) ON DELETE CASCADE;


--
-- TOC entry 4887 (class 2606 OID 16476)
-- Name: asset_vulnerabilities asset_vulnerabilities_asset_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_vulnerabilities
    ADD CONSTRAINT asset_vulnerabilities_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES schema.assets(id) ON DELETE CASCADE;


--
-- TOC entry 4888 (class 2606 OID 16481)
-- Name: asset_vulnerabilities asset_vulnerabilities_vulnerability_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.asset_vulnerabilities
    ADD CONSTRAINT asset_vulnerabilities_vulnerability_id_fkey FOREIGN KEY (vulnerability_id) REFERENCES schema.vulnerabilities(id) ON DELETE CASCADE;


--
-- TOC entry 4894 (class 2606 OID 16545)
-- Name: incidents incidents_threat_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.incidents
    ADD CONSTRAINT incidents_threat_id_fkey FOREIGN KEY (threat_id) REFERENCES schema.threats(id);


--
-- TOC entry 4895 (class 2606 OID 16550)
-- Name: incidents incidents_vulnerability_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.incidents
    ADD CONSTRAINT incidents_vulnerability_id_fkey FOREIGN KEY (vulnerability_id) REFERENCES schema.vulnerabilities(id);


--
-- TOC entry 4896 (class 2606 OID 16578)
-- Name: intel_reports intel_reports_source_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.intel_reports
    ADD CONSTRAINT intel_reports_source_id_fkey FOREIGN KEY (source_id) REFERENCES schema.intel_sources(id);


--
-- TOC entry 4891 (class 2606 OID 16519)
-- Name: risk_assessments risk_assessments_asset_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_assessments
    ADD CONSTRAINT risk_assessments_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES schema.assets(id) ON DELETE CASCADE;


--
-- TOC entry 4892 (class 2606 OID 16524)
-- Name: risk_assessments risk_assessments_threat_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_assessments
    ADD CONSTRAINT risk_assessments_threat_id_fkey FOREIGN KEY (threat_id) REFERENCES schema.threats(id) ON DELETE CASCADE;


--
-- TOC entry 4893 (class 2606 OID 16529)
-- Name: risk_assessments risk_assessments_vulnerability_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_assessments
    ADD CONSTRAINT risk_assessments_vulnerability_id_fkey FOREIGN KEY (vulnerability_id) REFERENCES schema.vulnerabilities(id) ON DELETE CASCADE;


--
-- TOC entry 4897 (class 2606 OID 16611)
-- Name: risk_controls risk_controls_control_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_controls
    ADD CONSTRAINT risk_controls_control_id_fkey FOREIGN KEY (control_id) REFERENCES schema.controls(id) ON DELETE CASCADE;


--
-- TOC entry 4898 (class 2606 OID 16606)
-- Name: risk_controls risk_controls_risk_assessment_id_fkey; Type: FK CONSTRAINT; Schema: schema; Owner: postgres
--

ALTER TABLE ONLY schema.risk_controls
    ADD CONSTRAINT risk_controls_risk_assessment_id_fkey FOREIGN KEY (risk_assessment_id) REFERENCES schema.risk_assessments(id) ON DELETE CASCADE;


--
-- TOC entry 4886 (class 2606 OID 16425)
-- Name: tva_mapping tva_mapping_asset_id_fkey; Type: FK CONSTRAINT; Schema: tva_mapping; Owner: postgres
--

ALTER TABLE ONLY tva_mapping.tva_mapping
    ADD CONSTRAINT tva_mapping_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES assets.assets(id);


-- Completed on 2025-03-16 14:31:20

--
-- PostgreSQL database dump complete
--

