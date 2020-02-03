--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.13
-- Dumped by pg_dump version 9.3.13
-- Started on 2020-02-03 12:03:07 ART

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 18852)
-- Name: sqitch; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sqitch;


ALTER SCHEMA sqitch OWNER TO postgres;

--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA sqitch; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA sqitch IS 'Sqitch database deployment metadata v1.0.';


--
-- TOC entry 1 (class 3079 OID 11789)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 18950)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 1855 (class 1247 OID 20316)
-- Name: org_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE org_type AS ENUM (
    'counsil',
    'organization'
);


ALTER TYPE public.org_type OWNER TO postgres;

--
-- TOC entry 1858 (class 1247 OID 20322)
-- Name: project_progress_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE project_progress_type AS ENUM (
    'late',
    'in_progress',
    'completed'
);


ALTER TYPE public.project_progress_type OWNER TO postgres;

--
-- TOC entry 1861 (class 1247 OID 20330)
-- Name: user_request_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE user_request_type AS ENUM (
    'pending',
    'denied',
    'accepted'
);


ALTER TYPE public.user_request_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 194 (class 1259 OID 20337)
-- Name: budget; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE budget (
    id integer NOT NULL,
    business_name text,
    cnpj text,
    goal_number integer,
    dedicated_value text,
    liquidated_value text,
    observation text,
    contract_code text,
    dedicated_year text,
    organ_code integer,
    organ_name text,
    business_name_url text,
    company_id integer,
    cod_emp text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.budget OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 20344)
-- Name: budget_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE budget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.budget_id_seq OWNER TO postgres;

--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 195
-- Name: budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE budget_id_seq OWNED BY budget.id;


--
-- TOC entry 196 (class 1259 OID 20346)
-- Name: campaign; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campaign (
    id integer NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    name text NOT NULL,
    start_in date NOT NULL,
    end_on date NOT NULL,
    region_id integer,
    address text,
    latitude text,
    longitude text,
    organization_id integer,
    free_text text,
    objective text NOT NULL,
    project_id integer,
    mobile_campaign_id integer,
    request_council boolean DEFAULT false
);


ALTER TABLE public.campaign OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 20354)
-- Name: campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_id_seq OWNER TO postgres;

--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 197
-- Name: campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campaign_id_seq OWNED BY campaign.id;


--
-- TOC entry 198 (class 1259 OID 20356)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE city (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text,
    state_id integer,
    country_id integer
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 20362)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 20364)
-- Name: comment_goal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comment_goal (
    id integer NOT NULL,
    description text,
    "timestamp" timestamp without time zone DEFAULT now(),
    approved boolean DEFAULT false,
    goal_id integer,
    active boolean DEFAULT true,
    user_id integer
);


ALTER TABLE public.comment_goal OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 20373)
-- Name: comment_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_goal_id_seq OWNER TO postgres;

--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 201
-- Name: comment_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_goal_id_seq OWNED BY comment_goal.id;


--
-- TOC entry 202 (class 1259 OID 20375)
-- Name: comment_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comment_project (
    id integer NOT NULL,
    description text,
    "timestamp" timestamp without time zone DEFAULT now(),
    approved boolean DEFAULT false,
    project_id integer,
    user_id integer,
    active boolean DEFAULT true,
    org_id integer
);


ALTER TABLE public.comment_project OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 20384)
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 203
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_id_seq OWNED BY comment_project.id;


--
-- TOC entry 204 (class 1259 OID 20386)
-- Name: company; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text NOT NULL,
    cnpj text
);


ALTER TABLE public.company OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 20392)
-- Name: company_documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE company_documents (
    id integer NOT NULL,
    url_name text NOT NULL,
    company_id integer,
    description text
);


ALTER TABLE public.company_documents OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 20398)
-- Name: company_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE company_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_documents_id_seq OWNER TO postgres;

--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 206
-- Name: company_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE company_documents_id_seq OWNED BY company_documents.id;


--
-- TOC entry 207 (class 1259 OID 20400)
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_id_seq OWNER TO postgres;

--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 207
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- TOC entry 208 (class 1259 OID 20402)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contact (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.contact OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 20409)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_id_seq OWNER TO postgres;

--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 209
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- TOC entry 210 (class 1259 OID 20411)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE country (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 20417)
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 20419)
-- Name: district; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE district (
    id integer NOT NULL,
    name text NOT NULL,
    city_id integer NOT NULL,
    center_lat_long point NOT NULL,
    perimeter text NOT NULL
);


ALTER TABLE public.district OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 20425)
-- Name: district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.district_id_seq OWNER TO postgres;

--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 213
-- Name: district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE district_id_seq OWNED BY district.id;


--
-- TOC entry 214 (class 1259 OID 20427)
-- Name: email_queue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE email_queue (
    id integer NOT NULL,
    recipient_id integer,
    body text NOT NULL,
    sent boolean DEFAULT false,
    sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying
);


ALTER TABLE public.email_queue OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 20435)
-- Name: email_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE email_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_queue_id_seq OWNER TO postgres;

--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 215
-- Name: email_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE email_queue_id_seq OWNED BY email_queue.id;


--
-- TOC entry 298 (class 1259 OID 37686)
-- Name: encuestas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuestas (
    id integer NOT NULL,
    goal_id integer,
    tipo text,
    sessionid text,
    voto text,
    project_id integer
);


ALTER TABLE public.encuestas OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 37724)
-- Name: encuestas_beneficio_mpn; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW encuestas_beneficio_mpn AS
 SELECT encuestas.goal_id,
    encuestas.tipo,
    encuestas.voto,
    count(*) AS count
   FROM encuestas
  GROUP BY encuestas.goal_id, encuestas.tipo, encuestas.voto
 HAVING (encuestas.tipo = 'beneficio'::text)
  ORDER BY encuestas.goal_id;


ALTER TABLE public.encuestas_beneficio_mpn OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 37684)
-- Name: encuestas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE encuestas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encuestas_id_seq OWNER TO postgres;

--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 297
-- Name: encuestas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE encuestas_id_seq OWNED BY encuestas.id;


--
-- TOC entry 299 (class 1259 OID 37720)
-- Name: encuestas_progreso_sino; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW encuestas_progreso_sino AS
 SELECT encuestas.goal_id,
    encuestas.tipo,
    encuestas.voto,
    count(*) AS count
   FROM encuestas
  GROUP BY encuestas.goal_id, encuestas.tipo, encuestas.voto
 HAVING (encuestas.tipo = 'progreso'::text)
  ORDER BY encuestas.goal_id;


ALTER TABLE public.encuestas_progreso_sino OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 37734)
-- Name: encuestas_proyectos_progreso_sino; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW encuestas_proyectos_progreso_sino AS
 SELECT encuestas.project_id,
    encuestas.tipo,
    encuestas.voto,
    count(*) AS count
   FROM encuestas
  GROUP BY encuestas.project_id, encuestas.tipo, encuestas.voto
 HAVING (encuestas.tipo = 'progreso'::text)
  ORDER BY encuestas.project_id;


ALTER TABLE public.encuestas_proyectos_progreso_sino OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 20437)
-- Name: event; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE event (
    id integer NOT NULL,
    description text,
    date timestamp without time zone NOT NULL,
    campaign_id integer,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    name text NOT NULL,
    council_id integer
);


ALTER TABLE public.event OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 20444)
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;


--
-- TOC entry 218 (class 1259 OID 20446)
-- Name: file; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE file (
    id integer NOT NULL,
    name text,
    status_text json,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer
);


ALTER TABLE public.file OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20453)
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO postgres;

--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 219
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE file_id_seq OWNED BY file.id;


--
-- TOC entry 220 (class 1259 OID 20455)
-- Name: goal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal (
    id integer NOT NULL,
    name text NOT NULL,
    will_be_delivered text,
    description text NOT NULL,
    technically text NOT NULL,
    expected_start_date timestamp without time zone,
    expected_end_date timestamp without time zone,
    start_date date,
    end_date date,
    percentage text,
    management_id integer,
    user_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    country_id integer,
    original_link text,
    keywords text[],
    expected_budget double precision,
    real_value_expended double precision,
    origin text,
    transversality text,
    objective_id integer,
    goal_number integer,
    qualitative_progress_1 text,
    qualitative_progress_2 text,
    qualitative_progress_3 text,
    qualitative_progress_4 text,
    qualitative_progress_5 text,
    qualitative_progress_6 text
);


ALTER TABLE public.goal OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20462)
-- Name: goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_id_seq OWNER TO postgres;

--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 221
-- Name: goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_id_seq OWNED BY goal.id;


--
-- TOC entry 222 (class 1259 OID 20464)
-- Name: goal_organization; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_organization (
    id integer NOT NULL,
    goal_id integer,
    organization_id integer
);


ALTER TABLE public.goal_organization OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20467)
-- Name: goal_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_organization_id_seq OWNER TO postgres;

--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 223
-- Name: goal_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_organization_id_seq OWNED BY goal_organization.id;


--
-- TOC entry 224 (class 1259 OID 20469)
-- Name: goal_porcentage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_porcentage (
    id integer NOT NULL,
    goal_id integer,
    owned double precision NOT NULL,
    remainder double precision NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.goal_porcentage OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20473)
-- Name: goal_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_porcentage_id_seq OWNER TO postgres;

--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 225
-- Name: goal_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_porcentage_id_seq OWNED BY goal_porcentage.id;


--
-- TOC entry 226 (class 1259 OID 20475)
-- Name: goal_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_project (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.goal_project OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20479)
-- Name: goal_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_project_id_seq OWNER TO postgres;

--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 227
-- Name: goal_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_project_id_seq OWNED BY goal_project.id;


--
-- TOC entry 228 (class 1259 OID 20481)
-- Name: goal_secretary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_secretary (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    secretary_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    update_at timestamp without time zone
);


ALTER TABLE public.goal_secretary OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20485)
-- Name: goal_secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_secretary_id_seq OWNER TO postgres;

--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 229
-- Name: goal_secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_secretary_id_seq OWNED BY goal_secretary.id;


--
-- TOC entry 230 (class 1259 OID 20487)
-- Name: images_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE images_project (
    id integer NOT NULL,
    project_id integer,
    name_image text NOT NULL,
    user_id integer,
    description text
);


ALTER TABLE public.images_project OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 20493)
-- Name: invite_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE invite_counsil (
    id integer NOT NULL,
    email text NOT NULL,
    hash text NOT NULL,
    organization_id integer,
    valid_until boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.invite_counsil OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 20501)
-- Name: invite_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invite_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invite_counsil_id_seq OWNER TO postgres;

--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 232
-- Name: invite_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invite_counsil_id_seq OWNED BY invite_counsil.id;


--
-- TOC entry 233 (class 1259 OID 20503)
-- Name: management; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE management (
    id integer NOT NULL,
    name text NOT NULL,
    start_date text NOT NULL,
    expected_end_date text NOT NULL,
    city_id integer NOT NULL,
    organization_id integer NOT NULL,
    active boolean,
    created_at text
);


ALTER TABLE public.management OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 20509)
-- Name: management_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE management_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.management_id_seq OWNER TO postgres;

--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 234
-- Name: management_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE management_id_seq OWNED BY management.id;


--
-- TOC entry 235 (class 1259 OID 20511)
-- Name: milestones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE milestones (
    id integer NOT NULL,
    name text NOT NULL,
    project_type_id integer,
    percentage integer,
    sequence integer
);


ALTER TABLE public.milestones OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 20517)
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.milestones_id_seq OWNER TO postgres;

--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 236
-- Name: milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE milestones_id_seq OWNED BY milestones.id;


--
-- TOC entry 237 (class 1259 OID 20519)
-- Name: objective; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE objective (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.objective OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 20526)
-- Name: objective_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE objective_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.objective_id_seq OWNER TO postgres;

--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 238
-- Name: objective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE objective_id_seq OWNED BY objective.id;


--
-- TOC entry 239 (class 1259 OID 20528)
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organization (
    id integer NOT NULL,
    name text NOT NULL,
    address text,
    postal_code text,
    city_id integer,
    description text,
    email text,
    website text,
    phone text,
    subprefecture_id integer,
    organization_type_id integer
);


ALTER TABLE public.organization OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 20534)
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_id_seq OWNER TO postgres;

--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 240
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organization_id_seq OWNED BY organization.id;


--
-- TOC entry 241 (class 1259 OID 20536)
-- Name: organization_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organization_type (
    id integer NOT NULL,
    name text,
    type org_type
);


ALTER TABLE public.organization_type OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 20542)
-- Name: organization_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_type_id_seq OWNER TO postgres;

--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 242
-- Name: organization_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organization_type_id_seq OWNED BY organization_type.id;


--
-- TOC entry 243 (class 1259 OID 20544)
-- Name: password_reset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE password_reset (
    id integer NOT NULL,
    user_id integer,
    hash text NOT NULL,
    expires_at timestamp without time zone DEFAULT (now() + '7 days'::interval),
    valid boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.password_reset OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 20553)
-- Name: password_reset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE password_reset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.password_reset_id_seq OWNER TO postgres;

--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 244
-- Name: password_reset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE password_reset_id_seq OWNED BY password_reset.id;


--
-- TOC entry 245 (class 1259 OID 20555)
-- Name: pre_register; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pre_register (
    id integer NOT NULL,
    username text NOT NULL,
    useremail text NOT NULL
);


ALTER TABLE public.pre_register OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 20561)
-- Name: pre_register_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pre_register_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pre_register_id_seq OWNER TO postgres;

--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 246
-- Name: pre_register_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pre_register_id_seq OWNED BY pre_register.id;


--
-- TOC entry 247 (class 1259 OID 20563)
-- Name: prefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prefecture (
    id integer NOT NULL,
    name text NOT NULL,
    acronym text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    latitude text NOT NULL,
    longitude text NOT NULL
);


ALTER TABLE public.prefecture OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 20570)
-- Name: prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prefecture_id_seq OWNER TO postgres;

--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 248
-- Name: prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE prefecture_id_seq OWNED BY prefecture.id;


--
-- TOC entry 249 (class 1259 OID 20572)
-- Name: progress_goal_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE progress_goal_counsil (
    id integer NOT NULL,
    remainder double precision NOT NULL,
    owned double precision NOT NULL,
    goal_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.progress_goal_counsil OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 20576)
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE progress_goal_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.progress_goal_counsil_id_seq OWNER TO postgres;

--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 250
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE progress_goal_counsil_id_seq OWNED BY progress_goal_counsil.id;


--
-- TOC entry 251 (class 1259 OID 20578)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project (
    id integer NOT NULL,
    name text NOT NULL,
    address text,
    latitude text,
    longitude text,
    budget_executed double precision,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    region_id integer,
    project_number integer,
    qualitative_progress_6 text,
    qualitative_progress_5 text,
    qualitative_progress_4 text,
    qualitative_progress_3 text,
    qualitative_progress_2 text,
    qualitative_progress_1 text,
    percentage numeric,
    type integer,
    goal_id integer,
    clarifications text
);


ALTER TABLE public.project OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 20585)
-- Name: project_accept_porcentage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_accept_porcentage (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    progress project_progress_type
);


ALTER TABLE public.project_accept_porcentage OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 20589)
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_accept_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_accept_porcentage_id_seq OWNER TO postgres;

--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 253
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_accept_porcentage_id_seq OWNED BY project_accept_porcentage.id;


--
-- TOC entry 254 (class 1259 OID 20591)
-- Name: project_event; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_event (
    id integer NOT NULL,
    text text,
    ts timestamp without time zone DEFAULT now(),
    project_id integer,
    user_id integer,
    approved boolean DEFAULT false,
    active boolean DEFAULT true,
    is_last boolean DEFAULT true,
    CONSTRAINT project_event_is_last_check CHECK ((is_last <> false))
);


ALTER TABLE public.project_event OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 20602)
-- Name: project_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_event_id_seq OWNER TO postgres;

--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 255
-- Name: project_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_event_id_seq OWNED BY project_event.id;


--
-- TOC entry 256 (class 1259 OID 20604)
-- Name: project_event_read; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_event_read (
    id integer NOT NULL,
    project_event_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_event_read OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 20608)
-- Name: project_event_read_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_event_read_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_event_read_id_seq OWNER TO postgres;

--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 257
-- Name: project_event_read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_event_read_id_seq OWNED BY project_event_read.id;


--
-- TOC entry 258 (class 1259 OID 20610)
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_id_seq OWNER TO postgres;

--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 258
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- TOC entry 259 (class 1259 OID 20612)
-- Name: project_image; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_image (
    id integer NOT NULL,
    project_id integer,
    md5_image text NOT NULL
);


ALTER TABLE public.project_image OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 20618)
-- Name: project_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_image_id_seq OWNER TO postgres;

--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 260
-- Name: project_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_image_id_seq OWNED BY project_image.id;


--
-- TOC entry 261 (class 1259 OID 20620)
-- Name: project_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_images_id_seq OWNER TO postgres;

--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 261
-- Name: project_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_images_id_seq OWNED BY images_project.id;


--
-- TOC entry 262 (class 1259 OID 20622)
-- Name: project_milestones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_milestones (
    id integer NOT NULL,
    project_id integer,
    milestone integer,
    status integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.project_milestones OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 20626)
-- Name: project_milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_milestones_id_seq OWNER TO postgres;

--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 263
-- Name: project_milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_milestones_id_seq OWNED BY project_milestones.id;


--
-- TOC entry 264 (class 1259 OID 20628)
-- Name: project_prefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_prefecture (
    id integer NOT NULL,
    project_id integer NOT NULL,
    prefecture_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.project_prefecture OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 20632)
-- Name: project_prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_prefecture_id_seq OWNER TO postgres;

--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 265
-- Name: project_prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_prefecture_id_seq OWNED BY project_prefecture.id;


--
-- TOC entry 266 (class 1259 OID 20634)
-- Name: project_progress; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_progress (
    project_id integer NOT NULL,
    milestone_id integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.project_progress OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 20638)
-- Name: project_region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_region (
    id integer NOT NULL,
    project_id integer,
    region_id integer
);


ALTER TABLE public.project_region OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 20641)
-- Name: project_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_region_id_seq OWNER TO postgres;

--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 268
-- Name: project_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_region_id_seq OWNED BY project_region.id;


--
-- TOC entry 269 (class 1259 OID 20643)
-- Name: project_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_types (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.project_types OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 20649)
-- Name: project_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_types_id_seq OWNER TO postgres;

--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 270
-- Name: project_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_types_id_seq OWNED BY project_types.id;


--
-- TOC entry 271 (class 1259 OID 20651)
-- Name: region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE region (
    id integer NOT NULL,
    geom geometry,
    name text COLLATE pg_catalog."C.UTF-8",
    lat text,
    long text,
    subprefecture_id integer
);


ALTER TABLE public.region OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 20657)
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO postgres;

--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 272
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE region_id_seq OWNED BY region.id;


--
-- TOC entry 273 (class 1259 OID 20659)
-- Name: register_counsil_manual; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE register_counsil_manual (
    id integer NOT NULL,
    email text NOT NULL,
    phone_number text NOT NULL,
    council text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.register_counsil_manual OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 20666)
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE register_counsil_manual_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.register_counsil_manual_id_seq OWNER TO postgres;

--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 274
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE register_counsil_manual_id_seq OWNED BY register_counsil_manual.id;


--
-- TOC entry 275 (class 1259 OID 20668)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 20674)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO postgres;

--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 276
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- TOC entry 277 (class 1259 OID 20676)
-- Name: secretary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE secretary (
    id integer NOT NULL,
    acronym text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.secretary OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 20683)
-- Name: secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secretary_id_seq OWNER TO postgres;

--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 278
-- Name: secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE secretary_id_seq OWNED BY secretary.id;


--
-- TOC entry 279 (class 1259 OID 20685)
-- Name: state; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE state (
    id integer NOT NULL,
    name text NOT NULL,
    uf text NOT NULL,
    country_id integer NOT NULL,
    created_by integer
);


ALTER TABLE public.state OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 20691)
-- Name: state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE state_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_id_seq OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 20693)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 20699)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO postgres;

--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 282
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- TOC entry 283 (class 1259 OID 20701)
-- Name: subprefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subprefecture (
    id integer NOT NULL,
    acronym text,
    name text NOT NULL,
    latitude text,
    longitude text,
    "timestamp" timestamp without time zone DEFAULT now(),
    site text,
    deputy_mayor text,
    email text,
    telephone text,
    address text
);


ALTER TABLE public.subprefecture OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 20708)
-- Name: subprefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subprefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subprefecture_id_seq OWNER TO postgres;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 284
-- Name: subprefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subprefecture_id_seq OWNED BY subprefecture.id;


--
-- TOC entry 285 (class 1259 OID 20710)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    password text NOT NULL,
    created_by integer,
    type character varying(12),
    organization_id integer,
    username text,
    phone_number text,
    image_perfil text,
    accept_email boolean,
    accept_sms boolean,
    request_council boolean DEFAULT false,
    mobile_campaign_id integer
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 20719)
-- Name: user_follow_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_follow_counsil (
    id integer NOT NULL,
    counsil_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


ALTER TABLE public.user_follow_counsil OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 20724)
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_follow_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_follow_counsil_id_seq OWNER TO postgres;

--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 287
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_follow_counsil_id_seq OWNED BY user_follow_counsil.id;


--
-- TOC entry 288 (class 1259 OID 20726)
-- Name: user_follow_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_follow_project (
    id integer NOT NULL,
    project_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


ALTER TABLE public.user_follow_project OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 20731)
-- Name: user_follow_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_follow_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_follow_project_id_seq OWNER TO postgres;

--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 289
-- Name: user_follow_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_follow_project_id_seq OWNED BY user_follow_project.id;


--
-- TOC entry 290 (class 1259 OID 20733)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 290
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 291 (class 1259 OID 20735)
-- Name: user_request_council; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_request_council (
    id integer NOT NULL,
    user_id integer NOT NULL,
    organization_id integer NOT NULL,
    user_status user_request_type NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_request_council OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 20739)
-- Name: user_request_council_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_request_council_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_request_council_id_seq OWNER TO postgres;

--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 292
-- Name: user_request_council_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_request_council_id_seq OWNED BY user_request_council.id;


--
-- TOC entry 293 (class 1259 OID 20741)
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 20744)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq OWNER TO postgres;

--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 294
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_role_id_seq OWNED BY user_role.id;


--
-- TOC entry 295 (class 1259 OID 20746)
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_session (
    id integer NOT NULL,
    user_id integer NOT NULL,
    api_key text,
    valid_for_ip text,
    valid_until timestamp without time zone DEFAULT (now() + '1 day'::interval) NOT NULL,
    ts_created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 20754)
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_session_id_seq OWNER TO postgres;

--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 296
-- Name: user_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_session_id_seq OWNED BY user_session.id;


SET search_path = sqitch, pg_catalog;

--
-- TOC entry 175 (class 1259 OID 18873)
-- Name: changes; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE changes (
    change_id text NOT NULL,
    script_hash text,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.changes OWNER TO postgres;

--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE changes; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE changes IS 'Tracks the changes currently deployed to the database.';


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change_id IS 'Change primary key.';


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.script_hash; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.script_hash IS 'Deploy script SHA-1 hash.';


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change IS 'Name of a deployed change.';


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.note IS 'Description of the change.';


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committed_at IS 'Date the change was deployed.';


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_name IS 'Name of the user who deployed the change.';


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_email IS 'Email address of the user who deployed the change.';


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planned_at IS 'Date the change was added to the plan.';


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_name IS 'Name of the user who planed the change.';


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN changes.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_email IS 'Email address of the user who planned the change.';


--
-- TOC entry 177 (class 1259 OID 18912)
-- Name: dependencies; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencies (
    change_id text NOT NULL,
    type text NOT NULL,
    dependency text NOT NULL,
    dependency_id text,
    CONSTRAINT dependencies_check CHECK ((((type = 'require'::text) AND (dependency_id IS NOT NULL)) OR ((type = 'conflict'::text) AND (dependency_id IS NULL))))
);


ALTER TABLE sqitch.dependencies OWNER TO postgres;

--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE dependencies; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE dependencies IS 'Tracks the currently satisfied dependencies.';


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN dependencies.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.change_id IS 'ID of the depending change.';


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN dependencies.type; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.type IS 'Type of dependency.';


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN dependencies.dependency; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency IS 'Dependency name.';


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN dependencies.dependency_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency_id IS 'Change ID the dependency resolves to.';


--
-- TOC entry 178 (class 1259 OID 18931)
-- Name: events; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE events (
    event text NOT NULL,
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    requires text[] DEFAULT '{}'::text[] NOT NULL,
    conflicts text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL,
    CONSTRAINT events_event_check CHECK ((event = ANY (ARRAY['deploy'::text, 'revert'::text, 'fail'::text, 'merge'::text])))
);


ALTER TABLE sqitch.events OWNER TO postgres;

--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE events; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE events IS 'Contains full history of all deployment events.';


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.event; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.event IS 'Type of event.';


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change_id IS 'Change ID.';


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change IS 'Change name.';


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.note IS 'Description of the change.';


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.requires; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.requires IS 'Array of the names of required changes.';


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.conflicts; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.conflicts IS 'Array of the names of conflicting changes.';


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.tags IS 'Tags associated with the change.';


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committed_at IS 'Date the event was committed.';


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_name IS 'Name of the user who committed the event.';


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_email IS 'Email address of the user who committed the event.';


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planned_at IS 'Date the event was added to the plan.';


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_name IS 'Name of the user who planed the change.';


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN events.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_email IS 'Email address of the user who plan planned the change.';


--
-- TOC entry 174 (class 1259 OID 18862)
-- Name: projects; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE projects (
    project text NOT NULL,
    uri text,
    created_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    creator_name text NOT NULL,
    creator_email text NOT NULL
);


ALTER TABLE sqitch.projects OWNER TO postgres;

--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE projects; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE projects IS 'Sqitch projects deployed to this database.';


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN projects.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.project IS 'Unique Name of a project.';


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN projects.uri; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.uri IS 'Optional project URI';


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN projects.created_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.created_at IS 'Date the project was added to the database.';


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN projects.creator_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_name IS 'Name of the user who added the project.';


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN projects.creator_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_email IS 'Email address of the user who added the project.';


--
-- TOC entry 173 (class 1259 OID 18853)
-- Name: releases; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE releases (
    version real NOT NULL,
    installed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    installer_name text NOT NULL,
    installer_email text NOT NULL
);


ALTER TABLE sqitch.releases OWNER TO postgres;

--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE releases; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE releases IS 'Sqitch registry releases.';


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN releases.version; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.version IS 'Version of the Sqitch registry.';


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN releases.installed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installed_at IS 'Date the registry release was installed.';


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN releases.installer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installer_name IS 'Name of the user who installed the registry release.';


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN releases.installer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installer_email IS 'Email address of the user who installed the registry release.';


--
-- TOC entry 176 (class 1259 OID 18890)
-- Name: tags; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    tag_id text NOT NULL,
    tag text NOT NULL,
    project text NOT NULL,
    change_id text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.tags OWNER TO postgres;

--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE tags IS 'Tracks the tags currently applied to the database.';


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.tag_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag_id IS 'Tag primary key.';


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.tag; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag IS 'Project-unique tag name.';


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.project IS 'Name of the Sqitch project to which the tag belongs.';


--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.change_id IS 'ID of last change deployed before the tag was applied.';


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.note IS 'Description of the tag.';


--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committed_at IS 'Date the tag was applied to the database.';


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_name IS 'Name of the user who applied the tag.';


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_email IS 'Email address of the user who applied the tag.';


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planned_at IS 'Date the tag was added to the plan.';


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_name IS 'Name of the user who planed the tag.';


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN tags.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_email IS 'Email address of the user who planned the tag.';


SET search_path = public, pg_catalog;

--
-- TOC entry 3586 (class 2604 OID 20756)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget ALTER COLUMN id SET DEFAULT nextval('budget_id_seq'::regclass);


--
-- TOC entry 3589 (class 2604 OID 20757)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign ALTER COLUMN id SET DEFAULT nextval('campaign_id_seq'::regclass);


--
-- TOC entry 3593 (class 2604 OID 20758)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal ALTER COLUMN id SET DEFAULT nextval('comment_goal_id_seq'::regclass);


--
-- TOC entry 3597 (class 2604 OID 20759)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- TOC entry 3598 (class 2604 OID 20760)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- TOC entry 3599 (class 2604 OID 20761)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company_documents ALTER COLUMN id SET DEFAULT nextval('company_documents_id_seq'::regclass);


--
-- TOC entry 3601 (class 2604 OID 20762)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- TOC entry 3602 (class 2604 OID 20763)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY district ALTER COLUMN id SET DEFAULT nextval('district_id_seq'::regclass);


--
-- TOC entry 3605 (class 2604 OID 20764)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email_queue ALTER COLUMN id SET DEFAULT nextval('email_queue_id_seq'::regclass);


--
-- TOC entry 3683 (class 2604 OID 37689)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas ALTER COLUMN id SET DEFAULT nextval('encuestas_id_seq'::regclass);


--
-- TOC entry 3607 (class 2604 OID 20765)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);


--
-- TOC entry 3609 (class 2604 OID 20766)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY file ALTER COLUMN id SET DEFAULT nextval('file_id_seq'::regclass);


--
-- TOC entry 3611 (class 2604 OID 20767)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal ALTER COLUMN id SET DEFAULT nextval('goal_id_seq'::regclass);


--
-- TOC entry 3612 (class 2604 OID 20768)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization ALTER COLUMN id SET DEFAULT nextval('goal_organization_id_seq'::regclass);


--
-- TOC entry 3614 (class 2604 OID 20769)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_porcentage ALTER COLUMN id SET DEFAULT nextval('goal_porcentage_id_seq'::regclass);


--
-- TOC entry 3616 (class 2604 OID 20770)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project ALTER COLUMN id SET DEFAULT nextval('goal_project_id_seq'::regclass);


--
-- TOC entry 3618 (class 2604 OID 20771)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary ALTER COLUMN id SET DEFAULT nextval('goal_secretary_id_seq'::regclass);


--
-- TOC entry 3619 (class 2604 OID 20772)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project ALTER COLUMN id SET DEFAULT nextval('project_images_id_seq'::regclass);


--
-- TOC entry 3622 (class 2604 OID 20773)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invite_counsil ALTER COLUMN id SET DEFAULT nextval('invite_counsil_id_seq'::regclass);


--
-- TOC entry 3623 (class 2604 OID 20774)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management ALTER COLUMN id SET DEFAULT nextval('management_id_seq'::regclass);


--
-- TOC entry 3624 (class 2604 OID 20775)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY milestones ALTER COLUMN id SET DEFAULT nextval('milestones_id_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 20776)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY objective ALTER COLUMN id SET DEFAULT nextval('objective_id_seq'::regclass);


--
-- TOC entry 3627 (class 2604 OID 20777)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


--
-- TOC entry 3628 (class 2604 OID 20778)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_type ALTER COLUMN id SET DEFAULT nextval('organization_type_id_seq'::regclass);


--
-- TOC entry 3632 (class 2604 OID 20779)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY password_reset ALTER COLUMN id SET DEFAULT nextval('password_reset_id_seq'::regclass);


--
-- TOC entry 3633 (class 2604 OID 20780)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pre_register ALTER COLUMN id SET DEFAULT nextval('pre_register_id_seq'::regclass);


--
-- TOC entry 3635 (class 2604 OID 20781)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prefecture ALTER COLUMN id SET DEFAULT nextval('prefecture_id_seq'::regclass);


--
-- TOC entry 3637 (class 2604 OID 20782)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progress_goal_counsil ALTER COLUMN id SET DEFAULT nextval('progress_goal_counsil_id_seq'::regclass);


--
-- TOC entry 3639 (class 2604 OID 20783)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- TOC entry 3641 (class 2604 OID 20784)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage ALTER COLUMN id SET DEFAULT nextval('project_accept_porcentage_id_seq'::regclass);


--
-- TOC entry 3646 (class 2604 OID 20785)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event ALTER COLUMN id SET DEFAULT nextval('project_event_id_seq'::regclass);


--
-- TOC entry 3649 (class 2604 OID 20786)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read ALTER COLUMN id SET DEFAULT nextval('project_event_read_id_seq'::regclass);


--
-- TOC entry 3650 (class 2604 OID 20787)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_image ALTER COLUMN id SET DEFAULT nextval('project_image_id_seq'::regclass);


--
-- TOC entry 3652 (class 2604 OID 20788)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones ALTER COLUMN id SET DEFAULT nextval('project_milestones_id_seq'::regclass);


--
-- TOC entry 3654 (class 2604 OID 20789)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture ALTER COLUMN id SET DEFAULT nextval('project_prefecture_id_seq'::regclass);


--
-- TOC entry 3656 (class 2604 OID 20790)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region ALTER COLUMN id SET DEFAULT nextval('project_region_id_seq'::regclass);


--
-- TOC entry 3657 (class 2604 OID 20791)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_types ALTER COLUMN id SET DEFAULT nextval('project_types_id_seq'::regclass);


--
-- TOC entry 3658 (class 2604 OID 20792)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY region ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- TOC entry 3660 (class 2604 OID 20793)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY register_counsil_manual ALTER COLUMN id SET DEFAULT nextval('register_counsil_manual_id_seq'::regclass);


--
-- TOC entry 3661 (class 2604 OID 20794)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- TOC entry 3663 (class 2604 OID 20795)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY secretary ALTER COLUMN id SET DEFAULT nextval('secretary_id_seq'::regclass);


--
-- TOC entry 3664 (class 2604 OID 20796)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- TOC entry 3666 (class 2604 OID 20797)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subprefecture ALTER COLUMN id SET DEFAULT nextval('subprefecture_id_seq'::regclass);


--
-- TOC entry 3670 (class 2604 OID 20798)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 3673 (class 2604 OID 20799)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil ALTER COLUMN id SET DEFAULT nextval('user_follow_counsil_id_seq'::regclass);


--
-- TOC entry 3676 (class 2604 OID 20800)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project ALTER COLUMN id SET DEFAULT nextval('user_follow_project_id_seq'::regclass);


--
-- TOC entry 3678 (class 2604 OID 20801)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council ALTER COLUMN id SET DEFAULT nextval('user_request_council_id_seq'::regclass);


--
-- TOC entry 3679 (class 2604 OID 20802)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role ALTER COLUMN id SET DEFAULT nextval('user_role_id_seq'::regclass);


--
-- TOC entry 3682 (class 2604 OID 20803)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_session ALTER COLUMN id SET DEFAULT nextval('user_session_id_seq'::regclass);


--
-- TOC entry 4033 (class 0 OID 20337)
-- Dependencies: 194
-- Data for Name: budget; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY budget (id, business_name, cnpj, goal_number, dedicated_value, liquidated_value, observation, contract_code, dedicated_year, organ_code, organ_name, business_name_url, company_id, cod_emp, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 195
-- Name: budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('budget_id_seq', 56507, true);


--
-- TOC entry 4035 (class 0 OID 20346)
-- Dependencies: 196
-- Data for Name: campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY campaign (id, description, created_at, user_id, name, start_in, end_on, region_id, address, latitude, longitude, organization_id, free_text, objective, project_id, mobile_campaign_id, request_council) FROM stdin;
\.


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 197
-- Name: campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('campaign_id_seq', 13, true);


--
-- TOC entry 4037 (class 0 OID 20356)
-- Dependencies: 198
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY city (id, name, name_url, state_id, country_id) FROM stdin;
2	Mendoza	mendoza	50	2
3	Godoy Cruz	godoy-cruz	50	2
4	Lujan	lujan	50	2
\.


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 199
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('city_id_seq', 2, true);


--
-- TOC entry 4039 (class 0 OID 20364)
-- Dependencies: 200
-- Data for Name: comment_goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comment_goal (id, description, "timestamp", approved, goal_id, active, user_id) FROM stdin;
\.


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 201
-- Name: comment_goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comment_goal_id_seq', 16, true);


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 203
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comment_id_seq', 40, true);


--
-- TOC entry 4041 (class 0 OID 20375)
-- Dependencies: 202
-- Data for Name: comment_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comment_project (id, description, "timestamp", approved, project_id, user_id, active, org_id) FROM stdin;
\.


--
-- TOC entry 4043 (class 0 OID 20386)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY company (id, name, name_url, cnpj) FROM stdin;
11132	Jose S.A.	jose-s.a.	1
11133	Cooperativa Mendoza	cooperativa-mendoza	2
11134	Juan S.R.L.	juan-s.r.l.	3
11135	Maria S.A.	maria-s.a.	4
11136	Mendoza S.A.	mendoza-s.a.	5
\.


--
-- TOC entry 4044 (class 0 OID 20392)
-- Dependencies: 205
-- Data for Name: company_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY company_documents (id, url_name, company_id, description) FROM stdin;
\.


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 206
-- Name: company_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('company_documents_id_seq', 6686, true);


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 207
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('company_id_seq', 11136, true);


--
-- TOC entry 4047 (class 0 OID 20402)
-- Dependencies: 208
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contact (id, name, email, message, created_at) FROM stdin;
\.


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 209
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contact_id_seq', 265, true);


--
-- TOC entry 4049 (class 0 OID 20411)
-- Dependencies: 210
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY country (id, name) FROM stdin;
2	Argentina
\.


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 211
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('country_id_seq', 2, true);


--
-- TOC entry 4051 (class 0 OID 20419)
-- Dependencies: 212
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY district (id, name, city_id, center_lat_long, perimeter) FROM stdin;
1	Ciudad de Mendoza no se usa	2	(-32.9194377999999972,-69.4814226000000019)	1
\.


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 213
-- Name: district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('district_id_seq', 1, false);


--
-- TOC entry 4053 (class 0 OID 20427)
-- Dependencies: 214
-- Data for Name: email_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY email_queue (id, recipient_id, body, sent, sent_at, created_at, title) FROM stdin;
64	\N	Content-Transfer-Encoding: binary\nContent-Type: multipart/related; boundary="_----------=_1467342393215320"\nMIME-Version: 1.0\nX-Mailer: MIME::Lite 3.030 (F2.84; T2.13; A2.14; B3.13; Q3.13)\nDate: Fri, 1 Jul 2016 00:06:33 -0300\nTo: =?UTF-8?B?ZmxhdmlhQGVtYWlsLmNvbQ==?=\nSubject: =?UTF-8?B?RGUgT2xobyBuYXMgTWV0YXM6IFJlc3Bvc3RhIGRlIHNvbGljaXRhw6fDo28gZGU=?=\n  =?UTF-8?B?IGNvbnNlbGhlaXJv?=\nFrom: "donm" <no-reply@deolhonasmetas.org.br>\n\nThis is a multi-part message in MIME format.\n\n--_----------=_1467342393215320\nContent-Disposition: inline\nContent-Length: 2673\nContent-Transfer-Encoding: binary\nContent-Type: text/html; charset=utf-8\n\n<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n<html>\n<head>\n<meta http-equiv="Content-type" content="text/html;charset=UTF-8">\n<title>veratrum: Informativo</title>\n</head>\n<body style="padding: 0; margin: 0; background-color: #FAFAFA;">\n<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" style="background-color: #FAFAFA;">\n    <tr>\n        <td align="center" vertical-align="top">\n      <table cellspacing="0" cellpadding="6" border="0" width="638">\n        <tr>\n          <td align="center" vertical-align="top" style="background-color: #00a99d;">\n            <!--// header //-->\n            <table cellspacing="0" cellpadding="0" border="0" width="638" style="background-color: #00a99d;">\n              <tr>\n                <td style="padding: 10px 20px;">\n                  <div style="text-align: left;">\n                  </div>\n                </td>\n              </tr>\n              <tr>\n                <td style="padding: 20px;">\n                  <p style="font-family: arial, verdana; font-size: 16pt; color: #FFFFFF; text-align: left; margin: 0; padding: 0;">Resposta de solicitação de conselheiro - De Olho Nas Metas</p>\n                </td>\n              </tr>\n            </table>\n            <!--// fim header //-->\n\n            <table cellspacing="0" cellpadding="0" border="0">\n              <tr>\n                <td style="background-color: #ffffff; text-align: left;" bgcolor="#ffffff" width="638">\n                  <table border="0" width="100%"><tr><td>\n                    <table cellspacing="0" cellpadding="0" border="0" width="100%">\n                      <tr>\n                        <td style="vertical-align: top; padding: 50px;font-family: arial, verdana;">\n                            <div style="font-family: arial, verdana; color: #333333;">\n\n<p>Caro(a) usuário(a),</p>\n\n<p>Email: flavia@email.com</p>\n\n<p>Data: 01/07/16 00:06:33</p>\n\n<p>Prezado Usuário, \n         O seu cadastro como conselheiro foi aceito. Obrigado por se cadastrar! E fique De Olho nas Metas!\n</p>\n<p>\n         Abraços. \n         Equipe do De Olho nas Metas.\n\n</p>\n\n</div>\n\n\n                        </td>\n                      </tr>\n                    </table>\n                  </td></tr></table>\n                </td>\n              </tr>\n            </table>\n            <!--// footer //-->\n\n          </td>\n        </tr>\n      </table>\n      <table cellspacing="0" cellpadding="0" border="0" width="650" height="25">\n        <tr>\n          <td align="center" vertical-align="top">\n          </td>\n        </tr>\n      </table>\n        </td>\n    </tr>\n</table>\n</body>\n</html>\n\n\n\n\n\n\n--_----------=_1467342393215320\nContent-Disposition: inline\nContent-Id: <logo.png>\nContent-Transfer-Encoding: base64\nContent-Type: image/png\n\niVBORw0KGgoAAAANSUhEUgAAALoAAABtCAYAAAAWNXtmAAAWGElEQVR42u2deVRUV57Ho5NkumOm\nnZ4+Z+ZMn5yZM/3fnP4j6Z7+I8lMa4EbIDsI7nHfA4oa9xUlrKISjRuK+56EuCEqLoiCC6jRaKIi\nEhKjorghbnDnfm+9++q+oqoooMCi+D3P92C9eu++W/d+3u/97vZ7bwT4eL1Bckptuf6Rqx1Xe64/\ncP2JqzPXUK5YrnSufVynuYq57nNVc7E6VK0dW6ydu09LK1ZLu7N2rT9o126n5aUt1YtzokKwrze5\n3tHA+jcuE1cM11qus1yVTgDsalVq116r5cWk5a29ltc3qd4IdGcs9m81aP6DK5JrCVfRawC6virS\n8hqp5b299lvI4hPoQv+guQH/wtWBK56rsAWAXZcKtd/SQftt7bTfSqC3Msv9jgaAH9cqrrseALc9\n3dV+o5/2m99pjZa+Nf3Yt7n+metDrsVc5R4Mtz2Va7/9Q60s3ibQPUNtNAv2R64orvOtEG57Oq+V\nyR+1MmpDoLdM9+SfuN7nWsr1nMC2q+daGb2vlVlbAr1lNC5/x/V3rkyCuN7K1Mrud57WePU0C46B\nlRwCttHK0crSYyy8J0D+LtdHXNkEqMuVrZXtuwT66xMGRP6bazMB2eTarJX1bwn05h2a/1euOAKw\n2RWnlf2bBHrTCiN8wVxlBN1rU5lWB+0IdNfrLa7/4tpJoLmNdmp18haB7jor3pfrEcHldnqk1U07\nAr1xfeLvkRVvMdb9PXfue3dXyH/D1YXrDkHUYnRHq7PfEOjOCYMUswmcFqvZWh0S6A4mYL1HAz8e\nM9D0njtNFHOnvvH/4SolSDxGpVqdvkmgW+aJh3C9IDg8Ti+0un27tYOOIeWxBITHa+zrnj7wOiHH\nZP8UgqDVKEWr81YFOlrl66jyW53Wva4emdcBeXtaFNHqF3e093TQ8QN3U2W3eu1ubtibE3Isz9pF\nlUzStEtjwqNAx6Sfb6hySVb6prkmhDXXvJUMqlSSHWU0x/yY5hgMSqbKJNWh5KYeVGrqYf0oqkSS\nk4pqyukCTTlBK5Aqj1RPBTbVRLCmAv0DrmdUcaR66pnGTosAHYHpS6jSSA1UicaQW4OO1nMWVRap\nkcpydU+Mq9d4zqJKIrlIs1y5BtWVoHtR5ZBcLC93Ax3Rm25RxZBcrFsaW24BOvo+t1OlkJpI213R\nv+4K0COpMmoryM+Lhfp7s4ggb9YnzJvFDOnCZkV3ZXPHdRP6bEQXNqhnJ/F9eIA3C+5OZeZAka8b\n9H8PML8IlipDE4AFvDOjurLdy/xZSXYwe1EYZlf380LZiU2BbPFMH/ZJRCdxcwT6Ujla6Z7G2msB\nHS3ibVQJFgveK8SbLY/1ZbcOhziE256enw1je5f7sxH9OnPgqUyttK0xvTCNAd2PCt8sWOHYmG7s\n1yMhtcB9ejqMPS4IZQ9PmvXghFn4P/bjexxnDf3W1O7ixiHrbpBfc4OONyDcoII3uyl7uIuiQvrs\nDIc7P5QVZwWzHYu7s9njurIhvTsJXxyWP4z/HdSrE5s5tivbkOLHru4NFsfjPDUdnD9mQGeC3aIb\nAQ18+0ZDJ2xRyDguNDK/+ybIACes9OmtgWzSyC6GYwFrEPffg/zNfwP9jGnFDOvCjm8IEMCrFh6f\np47uKm4QKnM95F2b5gD9P7mqCHJv9v23QQY3pexQiOhR0f12DnRwED92qBcbOdvEYhab2ISlZkUl\nmdjgiSbWI5IfE2BJd/KoLqIBq1r3Ku7eAHay7EJVGoNNCjreULaefHJvYbVVV+Xs9kAWGexttt5w\nT3p4sagEE4s70JEln5DqoMiyf/omExsQZWJBGvBwcdATU6XA/ohb9pH9OxPoZq0PqOfb8hoy/bZV\nFzKs6vokP4Mlh8shrS1ck6GTTCzhiAXulBNeLDW/M1uY340tKvBhi/jfhfld2IKT3gbgp20wsYje\nlmsdXB1gsOzX9wWz8EBvAt2sD5oKdNxBe1p7AaNxqPrQ8NHlYA8s8vgvTDq4KSe9BNhbL45lBWUb\n2YXSQ2x5ehIbM+YTNmXGcJaYPoKlHgpkqSc76+ckHO7I+g3n6Wk3zin+5FCvt3mBH7kwZu2pj1Wv\nD+gfU1+5l3BRJHTluaFikEdYeg77xGUWyGGxv748hd2tvMGw3b17hw0Z0LtWmiH+fMQ0fgRbcMSX\nn2c+P+l4R9Z3mPl7uENqvzz89cG9OhHoZn3satBx5+xv7QU7gfeMqC4LRjPld6NiVci7sqJbXzO5\n1dTUsNnTJzlMe0DfcJa6N1JPI/5QRxYeYf5u/vhuBhcGI64EudB+Z626s6D/lQrVix1ZG6DDhp4R\nuT+ynxdLzjMDmnqyE7t4Zz9TtxvF153ryYkMYgsPhuuwT15t0t0UtRsTXZiy4UsSbLoE9DY0O9GL\n9eCNwMpTFqu6eIbFmk9eY7HmOTfSmPX21Y6tTl9n5PC+vPHaSU+vzxCLVVf761Om+BDkltmNbVwB\n+p+4qlt7gc7ho5gSMgzbY3he3AC8H1xC+eVp7ktXP6sF+qrlS+p1rS25s/Q0J600mX153gbA1AGZ\nh8MZAQS5WdUao40GPZUK04ttW9hdh6xoR6DFAs+2WPO80jXM1rZ9y8Z6XSs3P0t0SSLNxKMdRZcl\n9h9bb3GdfuENVOp90ZXaWNAxr+ABFaQXO7k50DDhSu6forgtsofFert86SKH0jmfOjSgK3vwoIJl\nnBukpyt7YFbO8zW4L+Sn63pQ1xyYukAfQoVoFiZeScAWTrf4x7G7zDAuyvdljraJ40Y7MRjlzb5Y\nlCKO338tSQd92BSz+4IZkiro6NOnutE1pKGgo9umgArQrJ9zLH3Z6nyW+BwzjKsL+zkE/Zefy9gn\nfcLtWvYgv05s1LABrPLJE3H8Ce4GSdBHzzPV6t6EJltNHGvlKnDU1egI9D9T4VmECVsSMFjWWqAX\n9Wd1bT+X/cQmjB3NwoN8xEBRMBdclR7Bvix29jT25Mlj/di80tUW0OebQR87mECvQ39uCOhJVHAW\nlR6wuC7xn3Wr5bqkFfixGv6vrq26upqdPpXP1q5ZydIWJrNN6zOED2+9ZV9PsbguU82gTx/T1QB6\nzFAC3UpJ9QUdS5bo5baKzn9lGbBJj/O1NEYzTPrkrftPS5lrthq2/vwwS2N0uPlaqdN8DKBjcTXV\njUGl9pbb2QO9AxWaUVkrLauIcpQ+7FFzLb0uBWUbXIL5w6pb+khr4rGO+nz1zCXdDaOj1L1oUx3q\nA3oaFZhRaTMt1hRrQ+WKH0yrTdKgXH4m3OaAUf1seY0YXdWnAaSb9OnB1/ZZ3Cc8YahebCrNWdDb\nkttSW8P7GqfnIi6L7r6s1WYdcvclrzSDT+KqbjDodyqv8+m95nnquIH6jzTp11fdFsyJp3qx6760\ndQb0D6iw6u5Lx6II6Tr0Hsiteq5lAUVxRUGDYK98UcHSi/oZFmJIa565tLth5iT1oddvUYYt0GdQ\nQdnWl3N8dauOv4i/Ir+LTjbpLswCPoPx2r089qr6hVOAV9e8Yg+qfmXrzg3hafxdn6bbo6c57YGR\nndiTAss8l0vfkttSh2Y4A/pxKijbwlrOO8cs/elntgUaQslNXSdh78ASjn/MDhUvYo+fl7OX1c8F\nzEzpfoTFf1Xzgr149ZRd4tN6007565BjfgvWkIrIX7wtgAlcqjWPm9CN6sOxjtcFOt7T/pIKyr6W\nzfU1+OpLuZWXDVOs+hewH9d6TPL+l68V7cKyrsazH+4eZuWVNwX4FbxX5eaDQjEotKqwt7gp5IJp\nLKUbFGNxWZImG4f9yZo7pZcay3ZB96FCqntx9JXdxlguiLOoxl35NN68OFpa98S8/+Mwf8Tij3+o\n6COWwG+EJA1w+PhzMjuyXgMt18GQvzoHvvJUKIseRINETsrHEejxVEB1C755hTI3HDBivrrqxkT0\n8WKfrTADn5hrXgcq+sY14SbAPvSTz9vTkQ2fYbIEKuU3DYb3EeJCDamREU89LfVQvCPQc6mAnBPm\nu8DCqpZ99ee+wo9XB3JCQ7zYEB6oKGaRiU1db2IztnQUmrTKxMbEmVi/ocanBcLVLZntY3CPAHkO\nLbSor3Ltgf4WReCqn5L5cja1N0T40JlBbDyfgxKmxVl0NrpAGA+KFDWwsyHKgFj1zyHP2xhAIeka\nFtHrLVug/4UKp2GWHTHOrSPiAtiESd1Y71BvAT2ie2E5HNwb/MVn7MeSvPm8FyV/c2CtiLpwifYs\npxX/jdBfbIFOiywaMWp6eVeQWEtqK+45YjRirgyCD2Uk+LHNPILuvhX+YmW/rZDRsOKIGbNgKi2A\ndtViDJrf4uIBJQQbgiW2BXBdQnAiRM/NXuXP+obTzERXzntRQT9KBdN4wS35YpaPsPCAFtDDQgN8\na2E/ngLw8zFRbCePpY446lSOLtNRa9ARF+M2FYxrhaH7FO5+YHptwZZA0f+OGYhQIY8kkJ3uz1bw\nBc+0gKLJdFvGfJGg/54KheSh+r0K+t+oQEgeqr+poEdQgZA8VBEq6OOpQEgeqvEq6ClUICQPVYoK\n+hb3miHobZAzxzg6FsGBIOvv7Z1T1zWt99lKu6707KXl6NqOruPMfntl5kiNzZcbaIsK+kF3ytzg\nT3qx0cMH6hrQpwcLC/QRBYrvwwK7Gb6XGjqwjyGd4O6dRXSs+XNmsMTPY9mYEYNEwCB9RHNwPzaw\nX6ThnIiQ7iItBBWyzhfSl8ejYpEPBCRKTpjH5syYzHqFB+p5lOobGSLSw1/DaCq/Nvarxw8b1Ffs\nQ75VkHpHBLHYWVPFdaZPmSCuo4KFzzgPeVev0b9XmNgvgyXZKrPo0cN4uQy2+d0Inkekgzd14LNa\ndrh+z7AA8YID5GvWtM9EPq1/vxvooAp6oTtlzlZAnzIe5Soxbq4oyLFjhtlcklZ8/ZoBcgQJevny\npXjjBAIHYTtzuoD16xUqjrl/r1wEE1KvHRc7Uxw3ddK42kGMSkv040cNHcCuXf1RD0qEayDSFipd\nhXDLpvXimAvnigz7cW1sgNR88/IoAy/MS++mTByrHzdtUgyrrKw0/E4cN3lCtH7MuoxV5qi9WzcZ\nQJTlODFmjIC1vtu98nKRDoKeYoufN1tPf9ynw9mDiopawZni5s5wN9ALVdBL3ClzF84XsVu//Mxm\nTJ0glBQfy65cviQKc9GCRBY9aqgeYF8eA8G6yjQQkxxb7tHDwjL1iQhmy5cuZq84+EgLN8LtX2+x\nkydyDdeeN2d6Ldikrl+/Ko6H5QIEDx8+YAlxc1jvHoHi5rt08YI4F9ZNnoNIXHJDHuV+XBsbrCI+\nwzLKLfPrHTqsd27fFvtwkx3OOcB+uPK9AP3zebP0tPbt+VYc8+jhQxHuDvtUY4CbD09JCePNkhu6\nECYPaeP/VVVV4hjkDZ+Lzp7hQI/Q0zl8KNtQFjKmJPJ18bsL7Pnz52zJ4gXuBnqJCnqFu4F+/dqP\ntXzBkhvFwrrBmmFbkBRn8/zI0O6i0q7+eKXWd2tWLRPnwnI3FPQtG9eJY+Zyd0L9Hu5Oxf374lUu\n0npL0GHx8QSQj3Zr0Pfu/lY/DvDgfLge2KqePhWuh7zO+OiRws2RnwvPntZhRJg77Ms5mK3vW5+R\nroP++PEj+9HIzhXWivwrn0jI16NHj4SBQF7wGYoMs8yuxFPu05GD3Q30ChX0Z24HOofKen9q0uf6\nI1pa92DN/1RBkO7H4tSk2jcBrxhYtWNHcxyCDl8Yvq0quEY4HhYQltZW3mGNsQ3X/FsJ+v3798Rf\nPAGsQQfUeGsd8gXIsSGyLp4c0i3CUwJtAls+MKyyuCH4zV1y47pol+DJhRtExHHM2qODjmi9cJOk\nVHcK5a7e5PgO9YDrl2nXwHeA/flzc6AmuJP28uUmeqaCzloC6GgQYSs4mSf+wl/esW2TUEb6Cv04\nWDBscHFspQ+YAK0j0AvyT7CsvbsMgmuQf+K4gO9EXq7NtFMS4wzWXoK+Yd1q4esCStw0KujSzcBv\n3rlts/g//G6cn5d7lL169Ursg2uERjUAVZ90sh2CN2tgg8uBz/LJc67orA66hFYKVtge6IP799Rf\nHbl65Zfi/998tV1/AuFmwnb1xx+E0bFuDLuR3pATuloE6LKyZIXASsoKQ2PP2i+29V5P6YIANEeg\n4xEPN0QVgANE2A5m77OZtjw/JWG+IS8rvkxjK5d9If6PYP8q6Js2mI/ZuztTNObEWzK+vyQgxk2x\nc/sW4TYAUgm87BWC9ZYNx749Q9izZ8/0hrkEFe0dWXayMSsVNWqIXdCXLVkkPh/PPaK7i9KtgmBQ\n0CCVDX08TdBecUPQ28jXt7QI0OGbYjt25JDeyLJ1vrQ+k8ZH2ez3hYUCSI5AVxu2UvCxcTwe2/CL\nbV17adoCQ8NTB51DHqxZ8vLyu4ZeF7RHZIMTjTppeeGjqy4XgJdQoWGN/fCnsaGRKhumOBc3mvSl\nYfGHar0uaOOgcS6ldhlagy5vatwo0n+XbpUe64Y3fjeuW6NbdzxF3BD0dwF6u5YAOgDF4xwVl66B\nnJocb/N8VBSOg8Wp1ReuVfiuzK8a3Bi9+N150ZWouhAyj0dyDgrLL/vNVdCFa8MBVDf07cveEAD5\nSpO0/CH+xim8cJ2k343P6JESLw7gLo6IUMDh/fXWL7rPDEsvb3psyLejcpe/HQ166RLJfL3U8oV6\nsM5X1r7d4jvkzw1Bb+e2PjoevbKRiUJFLwN83LKfSnWf1roxKgdaABx8YVhNWEU5MgrrdWD/PgHi\n+OhRAnRUjJqGbMg6Ah09GwAA7QKcg+vh2oAWQJzi/r21GyVBh9ArIzfZB45zZDcpLKR00XBDwj3B\nTQXriePEO444WGofuvSdRXg8Pggk/w9LL10padExAKdKWnUV9Pj5s8X/8YSR+YL7Jd0qlOOg/pF6\no/bQgSz9d7irj+6WoANSDPhAuzO/Fj4q/Ga4FLIfHb6jPAZS3+eJXhO4GD+V3hS9NRgdhcsDQNGw\nlD0fpTdLDGmgr7gu0AE2GnhIC4Ch4bls6SLRZkCDVe36swU6RlGlvy0HdQCW6qbgZpSNUOE+cCst\nB2iwHy6SsKT8t2BLX7HUZlnC0ssuRnubHBxTQZflsDQt1TAI9/RppZ532ecu3TA8ldDodmfQ3SrM\nBSoH0MCCQ/BpMSghh6TR+4LCRcXLYyD4kmo60yePFyDLLjrcKKgI2aX2w5XLhutIIW1bb5GDzwpL\nJkcy4Q+j8SdHXtFIRN7UcwAg0pP921IYocW17965LdwLOUIqBcuI89DQxjXgNqDxCIuMLkz5G+Aq\n4Ti8A8lWWcJnxvfozcFfW5K/VZQ7PvORVDQs8f+hVg16NMJFvviTFd2ZMl/oyjywf6/oanTDsBc6\n6Pc8N4Sct6gsANgUlQBfFoMkcAGa6jfgJpDzUXqEuE+0Lvx25Al5UweO3Ez3VNCLaTonyUNVrIJ+\nlgqE5KE6q4K+nwqE5KHar4K+gQqE5KHaoIKeSAVC8lAlqKBHU4GQPFTRKughVCAkD1WICvr7VCAk\nD9X7Kuh4sVENFQrJw1SjsW2IpltGBUPyMJUF2AgbnU0FQ/IwZdsCPZkKhuRhSpZ8/z9n2mExA8fR\nfgAAAABJRU5ErkJggg==\n\n--_----------=_1467342393215320--\n\n	f	\N	2016-07-01 00:06:33.115398	De Olho nas Metas: Resposta de solicitação de conselheiro
\.


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 215
-- Name: email_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('email_queue_id_seq', 64, true);


--
-- TOC entry 4137 (class 0 OID 37686)
-- Dependencies: 298
-- Data for Name: encuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY encuestas (id, goal_id, tipo, sessionid, voto, project_id) FROM stdin;
28	132	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Mucho	\N
29	132	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	\N
30	124	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Poco	\N
31	124	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	\N
32	126	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Mucho	\N
33	126	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Si	\N
34	127	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Mucho	\N
35	127	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	\N
36	130	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Mucho	\N
37	130	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	\N
38	131	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Poco	\N
39	131	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Si	\N
40	124	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Nada	\N
41	124	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Si	\N
42	126	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Mucho	\N
43	126	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	No	\N
44	127	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Poco	\N
45	127	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	No	\N
46	130	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Mucho	\N
47	130	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	No	\N
48	131	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Mucho	\N
49	131	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	No	\N
50	132	beneficio	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Mucho	\N
51	132	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	No	\N
52	124	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Mucho	\N
53	124	progreso	439afc39c783a1f745b009250ef99419ba15f25f	Si	\N
54	126	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Poco	\N
55	126	progreso	439afc39c783a1f745b009250ef99419ba15f25f	No	\N
58	124	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Mucho	\N
59	124	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	\N
60	126	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Poco	\N
61	126	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	\N
62	127	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Poco	\N
63	127	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	\N
64	130	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Poco	\N
65	130	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	\N
66	124	beneficio	775179be5576d35abf10917a913f4984d102461d	Nada	\N
67	124	progreso	775179be5576d35abf10917a913f4984d102461d	No	\N
68	126	progreso	775179be5576d35abf10917a913f4984d102461d	Si	\N
69	126	beneficio	775179be5576d35abf10917a913f4984d102461d	Mucho	\N
70	127	beneficio	775179be5576d35abf10917a913f4984d102461d	Mucho	\N
71	127	progreso	775179be5576d35abf10917a913f4984d102461d	Si	\N
95	132	beneficio	35fe4c6dd3e23857ac302ec7b2e59ebbae86b3c4	Mucho	\N
73	131	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Nada	\N
74	131	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	\N
75	124	beneficio	d7a692f8399bfca1de682967d6566ba7d727c0a1	Poco	\N
76	124	progreso	d7a692f8399bfca1de682967d6566ba7d727c0a1	Si	\N
77	124	beneficio	7d8736126a3bfcfcc25c02117f1ce39751c5bbda	Poco	\N
78	133	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Mucho	\N
79	133	progreso	439afc39c783a1f745b009250ef99419ba15f25f	Si	\N
80	124	beneficio	194b1eb937aac2c15de007625a79be0634dbe001	Nada	\N
81	124	progreso	194b1eb937aac2c15de007625a79be0634dbe001	No	\N
96	132	progreso	35fe4c6dd3e23857ac302ec7b2e59ebbae86b3c4	No	\N
84	126	beneficio	194b1eb937aac2c15de007625a79be0634dbe001	Poco	\N
85	126	progreso	194b1eb937aac2c15de007625a79be0634dbe001	No	\N
86	132	beneficio	asdfasd	Poco	\N
87	132	beneficio	asdfasdfasdfasdfasdf	Mucho	\N
88	132	beneficio	2304985702394857	Mucho	\N
89	132	beneficio	asdñlkfajñsdlkfj	Nada	\N
93	132	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Poco	\N
94	132	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Si	\N
97	124	beneficio	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	Mucho	\N
98	124	progreso	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	Si	\N
99	124	beneficio	a8a349cd0154ce3d91092a139b5e0626ecab394b	Nada	\N
100	124	progreso	a8a349cd0154ce3d91092a139b5e0626ecab394b	No	\N
101	132	beneficio	274f99a7744494671a8f9678bfd9fe4746081a9f	Nada	\N
102	132	progreso	274f99a7744494671a8f9678bfd9fe4746081a9f	No	\N
103	133	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	\N
104	133	beneficio	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Nada	\N
105	133	beneficio	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Mucho	\N
106	133	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	Si	\N
107	132	progreso	439afc39c783a1f745b009250ef99419ba15f25f	No	\N
108	132	beneficio	d7a692f8399bfca1de682967d6566ba7d727c0a1	Nada	\N
109	132	progreso	d7a692f8399bfca1de682967d6566ba7d727c0a1	No	\N
110	133	beneficio	6be233443be5f91f1887561619b3774816e07dcd	Mucho	\N
111	133	progreso	274f99a7744494671a8f9678bfd9fe4746081a9f	No	\N
112	133	beneficio	274f99a7744494671a8f9678bfd9fe4746081a9f	Poco	\N
113	135	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Poco	\N
114	135	progreso	439afc39c783a1f745b009250ef99419ba15f25f	Si	\N
115	134	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Mucho	\N
116	134	progreso	439afc39c783a1f745b009250ef99419ba15f25f	Si	\N
117	136	beneficio	439afc39c783a1f745b009250ef99419ba15f25f	Nada	\N
118	136	progreso	439afc39c783a1f745b009250ef99419ba15f25f	No	\N
119	136	progreso	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	No	\N
120	135	beneficio	a8a349cd0154ce3d91092a139b5e0626ecab394b	Mucho	\N
121	135	progreso	a8a349cd0154ce3d91092a139b5e0626ecab394b	No	\N
122	134	beneficio	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	Mucho	\N
123	134	beneficio	6be233443be5f91f1887561619b3774816e07dcd	Mucho	\N
124	134	progreso	6be233443be5f91f1887561619b3774816e07dcd	Si	\N
125	\N	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	4982
126	\N	progreso	8e6e183903a9b4a479adccc94c15a63ef6a6bfc4	Si	4982
127	\N	progreso	969e5edd1d8eb2b60788fd033af09bf2e200febe	Si	4982
128	\N	progreso	4b7e7c9c57f861a9aeca95b07b44184cf65b3e5b	Si	4983
129	\N	progreso	4b7e7c9c57f861a9aeca95b07b44184cf65b3e5b	No	4980
130	134	beneficio	4b7e7c9c57f861a9aeca95b07b44184cf65b3e5b	Poco	\N
131	134	progreso	4b7e7c9c57f861a9aeca95b07b44184cf65b3e5b	No	\N
132	\N	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Si	4978
133	\N	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	No	4987
134	\N	progreso	b4e9c5ed790428012fc61e8f12ffef39eb98ae03	Si	4983
135	\N	progreso	1b291932b297ad3214fd5689a0bd0227816277ee	Si	4981
136	\N	progreso	ab714fb6861bd28a8c8ee134a2f3cbc0169e0e6c	No	4991
137	135	beneficio	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	Mucho	\N
138	135	progreso	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	No	\N
139	\N	progreso	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	Si	4985
140	\N	progreso	a8a349cd0154ce3d91092a139b5e0626ecab394b	Si	4987
141	134	beneficio	786f065443c31b01da2c286f713516bc52128d3b	Poco	\N
142	134	progreso	786f065443c31b01da2c286f713516bc52128d3b	No	\N
143	\N	progreso	786f065443c31b01da2c286f713516bc52128d3b	No	4984
144	135	beneficio	786f065443c31b01da2c286f713516bc52128d3b	Mucho	\N
145	135	progreso	786f065443c31b01da2c286f713516bc52128d3b	Si	\N
146	\N	progreso	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	No	4991
147	136	beneficio	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	Poco	\N
148	134	progreso	c8ea74e29c0ae647ec10b6ab4186115c022e9cf2	Si	\N
149	134	beneficio	2411c3b9a5a47a975bb5728516a00737a863f249	Mucho	\N
150	134	progreso	2411c3b9a5a47a975bb5728516a00737a863f249	No	\N
151	\N	progreso	f10a18bdf0778135f43325a7563e687435eba591	No	4980
152	\N	progreso	f10a18bdf0778135f43325a7563e687435eba591	No	4989
153	135	beneficio	2411c3b9a5a47a975bb5728516a00737a863f249	Poco	\N
154	135	progreso	2411c3b9a5a47a975bb5728516a00737a863f249	Si	\N
155	\N	progreso	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	No	4983
156	\N	progreso	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	No	4982
157	\N	progreso	34a8de8336ce8ff1b32ef79ffa67f9e9c8a30c3e	Si	4990
158	134	beneficio	6e2b8dde5c8a548745e54f698dfe2cd206c6410f	Mucho	\N
159	134	progreso	6e2b8dde5c8a548745e54f698dfe2cd206c6410f	No	\N
160	\N	progreso	6e2b8dde5c8a548745e54f698dfe2cd206c6410f	Si	4988
161	135	beneficio	6e2b8dde5c8a548745e54f698dfe2cd206c6410f	Poco	\N
162	\N	progreso	a28a2692acd9e4b66f476331b3d8aa81b14b47b6	Si	4982
163	134	beneficio	2c076b8c99b305fcd2d0ac0df7ec1bdcb46a24f9	Nada	\N
164	134	beneficio	fa0a03983928970170cf02f69d407896d2de29e8	Poco	\N
165	135	beneficio	fa0a03983928970170cf02f69d407896d2de29e8	Mucho	\N
166	135	progreso	fa0a03983928970170cf02f69d407896d2de29e8	Si	\N
167	136	beneficio	fa0a03983928970170cf02f69d407896d2de29e8	Poco	\N
168	136	progreso	fa0a03983928970170cf02f69d407896d2de29e8	Si	\N
169	134	progreso	fa0a03983928970170cf02f69d407896d2de29e8	Si	\N
170	134	beneficio	dccef480c005f9f17b5fab1b7cfc2131ed67580b	Mucho	\N
171	\N	progreso	dccef480c005f9f17b5fab1b7cfc2131ed67580b	Si	4983
172	134	progreso	dccef480c005f9f17b5fab1b7cfc2131ed67580b	No	\N
173	\N	progreso	f10a18bdf0778135f43325a7563e687435eba591	No	4977
176	\N	progreso	6b338ab9a2e36c1d49938ac71a98a303f46700e9	Si	4987
179	\N	progreso	c6006682dcb8fdd74f54eb7db14554dca6e659d8	No	4983
180	\N	progreso	049c0e21d370b61a34ad4c6eb8d2708524d114c7	Si	4982
177	137	beneficio	c6006682dcb8fdd74f54eb7db14554dca6e659d8	Nada	\N
178	137	progreso	c6006682dcb8fdd74f54eb7db14554dca6e659d8	No	\N
174	137	progreso	d7a692f8399bfca1de682967d6566ba7d727c0a1	Si	\N
175	137	beneficio	d7a692f8399bfca1de682967d6566ba7d727c0a1	Mucho	\N
181	138	beneficio	3e1fa91483e0fcc366250afafe9d0c77ea67bdaf	Nada	\N
182	138	progreso	3e1fa91483e0fcc366250afafe9d0c77ea67bdaf	No	\N
183	137	progreso	3e1fa91483e0fcc366250afafe9d0c77ea67bdaf	Si	\N
184	137	beneficio	3e1fa91483e0fcc366250afafe9d0c77ea67bdaf	Mucho	\N
\.


--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 297
-- Name: encuestas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('encuestas_id_seq', 184, true);


--
-- TOC entry 4055 (class 0 OID 20437)
-- Dependencies: 216
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event (id, description, date, campaign_id, created_at, user_id, name, council_id) FROM stdin;
\.


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('event_id_seq', 3, true);


--
-- TOC entry 4057 (class 0 OID 20446)
-- Dependencies: 218
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY file (id, name, status_text, created_at, created_by) FROM stdin;
1	lMSVGlPwNj.xls	{"accepted":"Linhas aceitas: 1\\n"}	2016-05-11 10:02:17.540225	1
2	s74WK3NLp7.xls	{"error":"CabeÃ§alho nÃ£o encontrado!\\n","accepted":"Linhas aceitas: 0\\n"}	2016-05-12 18:14:37.681221	1
3	vC9tpUOTLM.xls	{"error":"CabeÃ§alho nÃ£o encontrado!\\n","accepted":"Linhas aceitas: 0\\n"}	2016-05-16 20:13:53.269499	1
\.


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 219
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('file_id_seq', 3, true);


--
-- TOC entry 4059 (class 0 OID 20455)
-- Dependencies: 220
-- Data for Name: goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal (id, name, will_be_delivered, description, technically, expected_start_date, expected_end_date, start_date, end_date, percentage, management_id, user_id, created_at, updated_at, country_id, original_link, keywords, expected_budget, real_value_expended, origin, transversality, objective_id, goal_number, qualitative_progress_1, qualitative_progress_2, qualitative_progress_3, qualitative_progress_4, qualitative_progress_5, qualitative_progress_6) FROM stdin;
137	a	a	a	a	\N	\N	\N	\N	0	\N	\N	2017-05-31 10:32:56.513526	\N	\N	\N	\N	0	\N	\N	\N	25	1	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 221
-- Name: goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_id_seq', 137, true);


--
-- TOC entry 4061 (class 0 OID 20464)
-- Dependencies: 222
-- Data for Name: goal_organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_organization (id, goal_id, organization_id) FROM stdin;
\.


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 223
-- Name: goal_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_organization_id_seq', 2, true);


--
-- TOC entry 4063 (class 0 OID 20469)
-- Dependencies: 224
-- Data for Name: goal_porcentage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_porcentage (id, goal_id, owned, remainder, active) FROM stdin;
\.


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 225
-- Name: goal_porcentage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_porcentage_id_seq', 124, true);


--
-- TOC entry 4065 (class 0 OID 20475)
-- Dependencies: 226
-- Data for Name: goal_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_project (id, goal_id, project_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 227
-- Name: goal_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_project_id_seq', 14702, true);


--
-- TOC entry 4067 (class 0 OID 20481)
-- Dependencies: 228
-- Data for Name: goal_secretary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_secretary (id, goal_id, secretary_id, created_at, update_at) FROM stdin;
\.


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 229
-- Name: goal_secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_secretary_id_seq', 15524, true);


--
-- TOC entry 4069 (class 0 OID 20487)
-- Dependencies: 230
-- Data for Name: images_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY images_project (id, project_id, name_image, user_id, description) FROM stdin;
\.


--
-- TOC entry 4070 (class 0 OID 20493)
-- Dependencies: 231
-- Data for Name: invite_counsil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY invite_counsil (id, email, hash, organization_id, valid_until, created_at) FROM stdin;
\.


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 232
-- Name: invite_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('invite_counsil_id_seq', 29, true);


--
-- TOC entry 4072 (class 0 OID 20503)
-- Dependencies: 233
-- Data for Name: management; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY management (id, name, start_date, expected_end_date, city_id, organization_id, active, created_at) FROM stdin;
\.


--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 234
-- Name: management_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('management_id_seq', 6, true);


--
-- TOC entry 4074 (class 0 OID 20511)
-- Dependencies: 235
-- Data for Name: milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY milestones (id, name, project_type_id, percentage, sequence) FROM stdin;
\.


--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 236
-- Name: milestones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('milestones_id_seq', 39, true);


--
-- TOC entry 4076 (class 0 OID 20519)
-- Dependencies: 237
-- Data for Name: objective; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY objective (id, name, created_at, updated_at) FROM stdin;
22	Educacion	2016-06-20 19:06:18.952586	\N
23	Salud	2016-06-20 19:06:29.158482	\N
25	Cultura	2016-06-20 22:40:02.869757	\N
26	Infraestructura	2016-06-20 23:13:51.446472	\N
21	Desarrollo Social	2016-05-11 09:25:49.354295	\N
27	Transporte	2016-06-30 19:33:38.543015	\N
28	Medio Ambiente	2016-06-30 19:33:49.476518	\N
\.


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 238
-- Name: objective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('objective_id_seq', 29, true);


--
-- TOC entry 4078 (class 0 OID 20528)
-- Dependencies: 239
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organization (id, name, address, postal_code, city_id, description, email, website, phone, subprefecture_id, organization_type_id) FROM stdin;
41	Fundacion Mendoza	Garibaldi 124	5501	2	Montevideo 200	fundacion@gmail.com	www.fmendoza.com.ar	2614233456	39	2
\.


--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 240
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organization_id_seq', 42, true);


--
-- TOC entry 4080 (class 0 OID 20536)
-- Dependencies: 241
-- Data for Name: organization_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organization_type (id, name, type) FROM stdin;
1	Asociación Civil	organization
2	Grupo Comunitario	counsil
3	Fundación	counsil
4	Unión Vecinal	counsil
5	Cooperativa	counsil
6	Entidad Religiosa	counsil
7	Centro de Jubilados	counsil
8	Mutual	organization
9	Club Social	organization
\.


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 242
-- Name: organization_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organization_type_id_seq', 9, true);


--
-- TOC entry 4082 (class 0 OID 20544)
-- Dependencies: 243
-- Data for Name: password_reset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_reset (id, user_id, hash, expires_at, valid, created_at) FROM stdin;
\.


--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 244
-- Name: password_reset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('password_reset_id_seq', 21, true);


--
-- TOC entry 4084 (class 0 OID 20555)
-- Dependencies: 245
-- Data for Name: pre_register; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pre_register (id, username, useremail) FROM stdin;
\.


--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 246
-- Name: pre_register_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pre_register_id_seq', 9, true);


--
-- TOC entry 4086 (class 0 OID 20563)
-- Dependencies: 247
-- Data for Name: prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prefecture (id, name, acronym, created_at, updated_at, latitude, longitude) FROM stdin;
1	Gobierno de Mendoza	GMZA	2016-05-11 09:26:48.113336	\N	-32.8990155	-68.8485678
\.


--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 248
-- Name: prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('prefecture_id_seq', 338, true);


--
-- TOC entry 4088 (class 0 OID 20572)
-- Dependencies: 249
-- Data for Name: progress_goal_counsil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY progress_goal_counsil (id, remainder, owned, goal_id, created_at) FROM stdin;
\.


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 250
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('progress_goal_counsil_id_seq', 8, true);


--
-- TOC entry 4090 (class 0 OID 20578)
-- Dependencies: 251
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project (id, name, address, latitude, longitude, budget_executed, created_at, updated_at, region_id, project_number, qualitative_progress_6, qualitative_progress_5, qualitative_progress_4, qualitative_progress_3, qualitative_progress_2, qualitative_progress_1, percentage, type, goal_id, clarifications) FROM stdin;
4992	proyecto general	Colocar rampas en las esquinas de la calle pellegrini	-32.889544	-68.845430	1023	2017-05-31 10:33:28.317615	\N	676	1	\N	\N	\N	\N	\N	empezar con los cordones	10	\N	137	hay un retraso en el comienzo de esta obra
\.


--
-- TOC entry 4091 (class 0 OID 20585)
-- Dependencies: 252
-- Data for Name: project_accept_porcentage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_accept_porcentage (id, project_id, user_id, created_at, progress) FROM stdin;
\.


--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 253
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_accept_porcentage_id_seq', 6, true);


--
-- TOC entry 4093 (class 0 OID 20591)
-- Dependencies: 254
-- Data for Name: project_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_event (id, text, ts, project_id, user_id, approved, active, is_last) FROM stdin;
\.


--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 255
-- Name: project_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_event_id_seq', 41, true);


--
-- TOC entry 4095 (class 0 OID 20604)
-- Dependencies: 256
-- Data for Name: project_event_read; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_event_read (id, project_event_id, user_id, ts) FROM stdin;
\.


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 257
-- Name: project_event_read_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_event_read_id_seq', 22, true);


--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 258
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_id_seq', 4997, true);


--
-- TOC entry 4098 (class 0 OID 20612)
-- Dependencies: 259
-- Data for Name: project_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_image (id, project_id, md5_image) FROM stdin;
\.


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 260
-- Name: project_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_image_id_seq', 1, false);


--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 261
-- Name: project_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_images_id_seq', 40, true);


--
-- TOC entry 4101 (class 0 OID 20622)
-- Dependencies: 262
-- Data for Name: project_milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_milestones (id, project_id, milestone, status, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 263
-- Name: project_milestones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_milestones_id_seq', 23114, true);


--
-- TOC entry 4103 (class 0 OID 20628)
-- Dependencies: 264
-- Data for Name: project_prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_prefecture (id, project_id, prefecture_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 265
-- Name: project_prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_prefecture_id_seq', 317669, true);


--
-- TOC entry 4105 (class 0 OID 20634)
-- Dependencies: 266
-- Data for Name: project_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_progress (project_id, milestone_id, status, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4106 (class 0 OID 20638)
-- Dependencies: 267
-- Data for Name: project_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_region (id, project_id, region_id) FROM stdin;
\.


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 268
-- Name: project_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_region_id_seq', 1, true);


--
-- TOC entry 4108 (class 0 OID 20643)
-- Dependencies: 269
-- Data for Name: project_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_types (id, name) FROM stdin;
1	Construção de equipamento
2	Obras de infraestrutura
3	Novos equipamentos em imóvel alugado
4	Equipamentos readequados
5	Novos órgãos ou estruturas administrativas
6	Sistemas
7	Atos Normativos
8	Novos serviços ou benefícios
\.


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 270
-- Name: project_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_types_id_seq', 8, true);


--
-- TOC entry 4110 (class 0 OID 20651)
-- Dependencies: 271
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY region (id, geom, name, lat, long, subprefecture_id) FROM stdin;
676	01030000000100000004000000B047E17A143651C0C520B072687140C01804560E2D3251C0A8C64B37897140C068BC7493183451C04C378941607540C0D8A3703D0A3751C02DB29DEFA77640C0	Ciudad	-32.925135	-68.843505	39
694	01030000000100000006000000E46C3A525B3351C083D9C3C1277440C0E46C3AF2E73351C0DD53FE823D7140C0E46C3AE2713251C00E013151C86F40C0E46C3A72B53151C0C28AF1D5E27140C0E46C3A02AD3151C0E8E6E630DA7540C0E46C3A92B23251C06BBFCE4DC77540C0	Prueba1	\N	\N	39
695	01030000000100000006000000ACBE9D43F73651C04CC96C96C87740C0ACBE9D8BBD3751C035223C15437640C0ACBE9D03463751C03CEB77BBEB7540C0ACBE9D1B4D3651C00F272872657740C0ACBE9D63E63651C0575B75B6F67840C0ACBE9D93C43751C03E80ED41777840C0	Las tortugas	\N	\N	39
\.


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 272
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('region_id_seq', 695, true);


--
-- TOC entry 4112 (class 0 OID 20659)
-- Dependencies: 273
-- Data for Name: register_counsil_manual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY register_counsil_manual (id, email, phone_number, council, name, created_at) FROM stdin;
\.


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 274
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('register_counsil_manual_id_seq', 18, true);


--
-- TOC entry 4114 (class 0 OID 20668)
-- Dependencies: 275
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role (id, name) FROM stdin;
0	superadmin
1	admin
2	organization
3	user
4	webapi
6	management
11	counsil
12	counsil_master
\.


--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 276
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_id_seq', 12, true);


--
-- TOC entry 4116 (class 0 OID 20676)
-- Dependencies: 277
-- Data for Name: secretary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY secretary (id, acronym, name, created_at) FROM stdin;
1	men	men	2016-05-11 09:26:48.113336
\.


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 278
-- Name: secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('secretary_id_seq', 24, true);


--
-- TOC entry 3571 (class 0 OID 19239)
-- Dependencies: 180
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- TOC entry 4118 (class 0 OID 20685)
-- Dependencies: 279
-- Data for Name: state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY state (id, name, uf, country_id, created_by) FROM stdin;
50	Mendoza	10	2	1
55	San Juan	12	2	1
\.


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 280
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('state_id_seq', 2, false);


--
-- TOC entry 4120 (class 0 OID 20693)
-- Dependencies: 281
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY status (id, description) FROM stdin;
\.


--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 282
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('status_id_seq', 1, false);


--
-- TOC entry 4122 (class 0 OID 20701)
-- Dependencies: 283
-- Data for Name: subprefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subprefecture (id, acronym, name, latitude, longitude, "timestamp", site, deputy_mayor, email, telephone, address) FROM stdin;
39	GC	Godoy Cruz	-32.9287462	-68.8847255	2016-05-12 17:59:03.19633	www.godoycruz.gov.ar	godoycruz	\N	1111111	\N
\.


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 284
-- Name: subprefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('subprefecture_id_seq', 44, true);


--
-- TOC entry 4124 (class 0 OID 20710)
-- Dependencies: 285
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "user" (id, name, email, active, created_at, password, created_by, type, organization_id, username, phone_number, image_perfil, accept_email, accept_sms, request_council, mobile_campaign_id) FROM stdin;
1	superadmin	superadmin@email.com	t	2013-10-28 10:18:12.570887	$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW	\N	superadmin	\N	\N	\N	\N	\N	\N	f	\N
2	admin	admin@email.com	t	2013-10-28 10:18:12.570887	$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW	\N	admin	\N	\N	\N	\N	\N	\N	f	\N
3	webapi	no-email	t	2015-10-28 10:18:12.570887	no-password	\N		\N	\N	\N	\N	\N	\N	f	\N
436	ejemplo	ejemplo@email.com	t	2017-05-31 10:49:05.112373	$2a$08$YIMPNpZ3hI/gXnY5epXj8uSjCtdHz998Ev2bMdLV52hZqqm7cem0K	\N	\N	\N	\N	\N	\N	t	t	f	\N
\.


--
-- TOC entry 4125 (class 0 OID 20719)
-- Dependencies: 286
-- Data for Name: user_follow_counsil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_follow_counsil (id, counsil_id, user_id, ts, active) FROM stdin;
\.


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 287
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_follow_counsil_id_seq', 68, true);


--
-- TOC entry 4127 (class 0 OID 20726)
-- Dependencies: 288
-- Data for Name: user_follow_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_follow_project (id, project_id, user_id, ts, active) FROM stdin;
\.


--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 289
-- Name: user_follow_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_follow_project_id_seq', 304, true);


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 290
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_id_seq', 436, true);


--
-- TOC entry 4130 (class 0 OID 20735)
-- Dependencies: 291
-- Data for Name: user_request_council; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_request_council (id, user_id, organization_id, user_status, created_at) FROM stdin;
\.


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 292
-- Name: user_request_council_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_request_council_id_seq', 13, true);


--
-- TOC entry 4132 (class 0 OID 20741)
-- Dependencies: 293
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_role (id, user_id, role_id) FROM stdin;
468	1	0
469	1	1
471	3	4
478	2	1
480	436	3
\.


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 294
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_role_id_seq', 480, true);


--
-- TOC entry 4134 (class 0 OID 20746)
-- Dependencies: 295
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_session (id, user_id, api_key, valid_for_ip, valid_until, ts_created) FROM stdin;
851	3	you-may-change-it-on-user-session-where-user-id=3	\N	2040-01-01 00:00:00	2016-04-01 20:49:48.298344
852	2	2d472137b65d2135f5371f389dc17a54ff95c754	127.0.0.1	2016-04-02 21:01:17.757153	2016-04-01 21:01:17.757153
853	2	6054d3b6557e6242fd059bcb35015511d799fe44	127.0.0.1	2016-04-02 21:03:27.316337	2016-04-01 21:03:27.316337
854	1	524fce39429da10077048f25bc2a329d85931939	127.0.0.1	2016-05-12 09:24:07.965398	2016-05-11 09:24:07.965398
855	1	36e423ff1cc1de9372300c6a9e456003bbbfbe98	127.0.0.1	2016-05-12 09:37:09.089166	2016-05-11 09:37:09.089166
856	1	397efa468b23f1fc53f08d533aeed79024b7c8f9	127.0.0.1	2016-05-12 09:57:10.77796	2016-05-11 09:57:10.77796
857	1	c30608cbdcd419aa8e06a0c5d3ac2b3073790213	127.0.0.1	2016-05-13 11:15:06.692569	2016-05-12 11:15:06.692569
858	1	c2149083037370c9551ce2ffcd6f6067133b88d1	127.0.0.1	2016-05-13 17:53:05.42279	2016-05-12 17:53:05.42279
859	1	c95cddb9f26e69bca44f1e3c5624f051d27a10ac	127.0.0.1	2016-05-13 17:59:46.1103	2016-05-12 17:59:46.1103
860	1	28a17c04e567d5d92849c3748ac4887ef448ce24	127.0.0.1	2016-05-13 18:16:29.165348	2016-05-12 18:16:29.165348
861	1	e2dae64104412936af4e135a8a65d6e5828ef648	127.0.0.1	2016-05-13 18:18:43.618791	2016-05-12 18:18:43.618791
862	1	f1136b103d700a122b29f149ab5d4d9ace98546b	127.0.0.1	2016-05-17 18:27:05.186809	2016-05-16 18:27:05.186809
863	1	b084791d681546dc11d53744c055e40b5539db08	127.0.0.1	2016-05-17 18:27:18.285245	2016-05-16 18:27:18.285245
864	1	6a880e6f47ad061d0e81581f9b6c4580979e2e96	127.0.0.1	2016-05-17 19:39:05.517638	2016-05-16 19:39:05.517638
865	1	334b22c7cf5270f129178b5198ff80f36bc56364	127.0.0.1	2016-05-18 09:54:37.29166	2016-05-17 09:54:37.29166
866	1	29b2362acbe3a568c0937a5a661074bf75ad6389	127.0.0.1	2016-05-18 10:23:50.373956	2016-05-17 10:23:50.373956
867	1	60d551cd3fc6648b6333ceeff148115d1dc7ba2c	127.0.0.1	2016-05-23 18:32:33.056999	2016-05-22 18:32:33.056999
868	1	5f4b10bf2a7c93601559b87818a9102bc79831a2	127.0.0.1	2016-05-24 10:40:41.74174	2016-05-23 10:40:41.74174
869	1	0bd94a0a39f06fdb7498df1421851ea076133fd3	127.0.0.1	2016-05-24 10:46:15.556299	2016-05-23 10:46:15.556299
902	1	039a0eae0d397ea9508a3818fa4c040a0de9f718	127.0.0.1	2016-05-24 11:36:03.45327	2016-05-23 11:36:03.45327
903	1	59668572899f124aebefbd0409ad41c12742cddd	127.0.0.1	2016-05-25 18:56:03.74604	2016-05-24 18:56:03.74604
904	1	1ce55e9d70d1d878e86c0f094883a265c05d736a	127.0.0.1	2016-05-26 19:09:26.66422	2016-05-25 19:09:26.66422
905	2	bf9aebfac9fe65a4f37d723fa7b11c2ab4f853d8	127.0.0.1	2016-06-11 09:58:29.551506	2016-06-10 09:58:29.551506
906	2	40ed9f02b6dff5dc908c0eb7be680bc09ee12662	127.0.0.1	2016-06-16 11:57:11.691383	2016-06-15 11:57:11.691383
907	1	aeecc2409d1a563b2dfecc477d9c306be3974e17	127.0.0.1	2016-06-17 09:56:07.841345	2016-06-16 09:56:07.841345
908	1	29d3787ccd79eeebad6f320a55ca948cbb906167	127.0.0.1	2016-06-17 10:04:53.445364	2016-06-16 10:04:53.445364
909	1	dca2564c2fda44a853d7a1350023b1e131fc44f9	127.0.0.1	2016-06-17 10:07:46.312526	2016-06-16 10:07:46.312526
910	1	380a4df3d3df81000e4fed9676dc4ea3e0034cda	127.0.0.1	2016-06-18 10:32:16.116521	2016-06-17 10:32:16.116521
911	1	373cfb29f552fcc77ae87c7175852d175a8c236d	127.0.0.1	2016-06-21 19:03:49.32783	2016-06-20 19:03:49.32783
912	1	8b56d3bf38444bc05bf4e4313fcdd799d145cdbd	127.0.0.1	2016-06-21 19:38:00.92672	2016-06-20 19:38:00.92672
913	1	4ed90c6c877220416a232322d6d559e0c1fd0edc	127.0.0.1	2016-06-21 22:40:24.135989	2016-06-20 22:40:24.135989
914	1	74a6da604b3ea371b852f61f3e177883f1b93db9	127.0.0.1	2016-06-21 22:50:10.723619	2016-06-20 22:50:10.723619
915	1	18eed666d8eef70b497b6ad67b95195c6ff841ed	127.0.0.1	2016-06-21 22:58:28.02675	2016-06-20 22:58:28.02675
916	1	d570793d7e768c7d38045259c0fead7cf9e95ecf	127.0.0.1	2016-06-21 23:13:01.72003	2016-06-20 23:13:01.72003
917	1	cb7a5618bed00f92f3c4cc4d5bb12067604f35c2	127.0.0.1	2016-06-21 23:27:57.956518	2016-06-20 23:27:57.956518
918	1	ae8022b432b5276047ef7e765ac719595e68ba47	127.0.0.1	2016-06-22 15:27:35.51616	2016-06-21 15:27:35.51616
919	2	0586ac53ea686a4978340626507cf5b4e9e8947f	127.0.0.1	2016-06-22 16:25:13.339741	2016-06-21 16:25:13.339741
920	2	4cb709f730b3279c9993c251988931e976b21766	127.0.0.1	2016-06-22 17:37:42.383752	2016-06-21 17:37:42.383752
921	2	c4e1c0c70061e99ca3a74741440040f1bd56c867	127.0.0.1	2016-06-22 17:42:53.771957	2016-06-21 17:42:53.771957
922	2	3ed4ef864b853e17183bf5817061df47bfb41438	127.0.0.1	2016-06-22 17:44:59.68719	2016-06-21 17:44:59.68719
923	2	a53a9ba8683014a32dead546f712a3f4d0f7df40	127.0.0.1	2016-06-23 14:04:07.362689	2016-06-22 14:04:07.362689
924	1	8cc3344d44fa94bfc104ba8c504a4a93de0af857	127.0.0.1	2016-06-23 18:37:34.453655	2016-06-22 18:37:34.453655
925	1	008f9c9d30c0694beb007b0abfbc853e0941d69b	127.0.0.1	2016-06-23 19:17:02.516225	2016-06-22 19:17:02.516225
926	1	94bb30d9ae5abfdd8eeb9d9f27700653968ce591	127.0.0.1	2016-06-24 12:07:38.552682	2016-06-23 12:07:38.552682
927	2	45d3971f28823d8cab24d10a2b058a072b0533ca	127.0.0.1	2016-06-24 12:09:04.093824	2016-06-23 12:09:04.093824
928	1	c4e539f8b6d98ea4328f9d79fca8cc52392f95ab	127.0.0.1	2016-06-24 12:16:01.72195	2016-06-23 12:16:01.72195
929	1	2bdcdeb3ddeda9cd4c3cf395233c209f1c014128	127.0.0.1	2016-06-24 12:21:13.681176	2016-06-23 12:21:13.681176
930	1	0265d2a5cad88e8cec836b2deebbc56da753e557	127.0.0.1	2016-06-24 12:25:12.801552	2016-06-23 12:25:12.801552
931	2	df2c03553b38f78817d033b69744e91c9a022d5d	127.0.0.1	2016-06-24 22:10:24.390812	2016-06-23 22:10:24.390812
932	1	3f4925de161df88857897b5f6463d957c9f4a925	127.0.0.1	2016-06-25 16:35:57.782591	2016-06-24 16:35:57.782591
933	1	3d50e9cec19583a023188418cf690ae0b7ab08be	127.0.0.1	2016-06-25 16:41:52.066771	2016-06-24 16:41:52.066771
934	1	5b7387adb05dfed8a8fd83996b75d5e243eb1ccd	127.0.0.1	2016-06-25 16:44:44.523983	2016-06-24 16:44:44.523983
935	1	b4ebe5c0a2c70cb9fa289fac7ca321840875558f	127.0.0.1	2016-06-25 17:06:37.368344	2016-06-24 17:06:37.368344
936	1	2cc017db3fe8444c55dd65612b9b85c4258a1ac6	127.0.0.1	2016-06-25 17:10:05.512007	2016-06-24 17:10:05.512007
937	1	5feab53b491ec90d1b1566091909dee6219b61e3	127.0.0.1	2016-06-25 17:19:41.488992	2016-06-24 17:19:41.488992
938	1	463f86c20228ee75675f781147863f4902b2ce07	127.0.0.1	2016-06-25 17:22:00.016316	2016-06-24 17:22:00.016316
939	1	0dedb1b70188aeeabcb1ed06625f47d49142b5df	127.0.0.1	2016-06-25 17:25:16.813955	2016-06-24 17:25:16.813955
940	1	035197f27e3ceff1bfefea72a615611b5be32f1e	127.0.0.1	2016-06-25 17:28:00.805295	2016-06-24 17:28:00.805295
941	1	50c07e8ef93b7e644711bc57e66c65b92936bdc5	127.0.0.1	2016-06-25 17:30:00.870229	2016-06-24 17:30:00.870229
942	1	04b81325551e66e4779fb9431a5b7ab3a9b336cf	127.0.0.1	2016-06-25 17:32:41.940969	2016-06-24 17:32:41.940969
943	1	ce91b5903ee9449dc76a5f7a55599da93f5dda0a	127.0.0.1	2016-06-25 17:52:32.440302	2016-06-24 17:52:32.440302
944	1	b797bf62b2f64d67821a79988d22e46302012921	127.0.0.1	2016-06-25 18:10:48.965457	2016-06-24 18:10:48.965457
945	1	7da0b68c5b7e2086b07b5ab3081f01e6cf01d060	127.0.0.1	2016-06-25 18:22:09.992511	2016-06-24 18:22:09.992511
946	1	483aeb5f66c0d4d24076fc0b244f452eb4e782ea	127.0.0.1	2016-06-25 19:36:45.680573	2016-06-24 19:36:45.680573
947	1	3c7d61dff71e34edbfbeacfeb45c0e742cd9e47b	127.0.0.1	2016-06-26 10:37:49.217452	2016-06-25 10:37:49.217452
948	1	2cfa7ca674b6acadc66963247f3874107532921d	127.0.0.1	2016-06-26 10:49:37.737752	2016-06-25 10:49:37.737752
949	1	edcaf853a352a1427e762e7121f7d4d3ebf14da2	127.0.0.1	2016-06-26 11:01:03.812396	2016-06-25 11:01:03.812396
950	2	26e6e7bbbbf333d1d38ea4f77ec8ac2054bc2557	127.0.0.1	2016-06-26 20:20:27.878117	2016-06-25 20:20:27.878117
951	2	4ede9de82796066ceb4977aa6606dea9bbc0c5d9	127.0.0.1	2016-06-26 22:33:22.241238	2016-06-25 22:33:22.241238
952	2	9d6343bdc271962e0d3919c395cecd10db67d14e	127.0.0.1	2016-06-26 23:13:03.65348	2016-06-25 23:13:03.65348
953	2	e8647960391bdb145e695fd77006500cf19ac9ca	127.0.0.1	2016-06-26 23:47:39.280574	2016-06-25 23:47:39.280574
954	2	da3467d69582c803e87fb1c42b4f97f96d7e2604	127.0.0.1	2016-06-26 23:51:11.456751	2016-06-25 23:51:11.456751
955	2	8e559a71ffd0a0e0758f20c04c4131b64b73530e	127.0.0.1	2016-06-26 23:54:16.889792	2016-06-25 23:54:16.889792
956	2	53b44f0d07b6442808fe7fdea2f51b031d889e21	127.0.0.1	2016-06-26 23:58:04.144792	2016-06-25 23:58:04.144792
957	2	4e486141c0af33a66894c5f200efde797ee98f5e	127.0.0.1	2016-06-27 00:01:00.358457	2016-06-26 00:01:00.358457
958	2	41c9ee8c8b6f6dc046310675c2ec61eca12f8a07	127.0.0.1	2016-06-27 00:05:43.492094	2016-06-26 00:05:43.492094
960	2	f7d22fb11619523d3bc6adc31f268bc75d30cb55	127.0.0.1	2016-06-27 00:12:52.686243	2016-06-26 00:12:52.686243
962	2	8c6b7f4c0ee74dccb7f2fe3e04e19a0d4992540d	127.0.0.1	2016-06-27 14:42:54.520899	2016-06-26 14:42:54.520899
965	1	cbe086dd6cc8ba338586ee1d5912d42ca42f62be	127.0.0.1	2016-06-28 07:47:39.737942	2016-06-27 07:47:39.737942
959	2	096968596a539a11ae742705d54219c896b989b2	127.0.0.1	2016-06-27 00:06:34.266589	2016-06-26 00:06:34.266589
961	2	b30d235cc1adf2c8943d1f1daf85e81fd3e9e502	127.0.0.1	2016-06-27 00:27:13.5732	2016-06-26 00:27:13.5732
963	2	26435dc01359043d2294c0578ebfa98366a92ced	127.0.0.1	2016-06-27 19:30:18.547628	2016-06-26 19:30:18.547628
964	2	805b6fd78bd84db5bd80452e856636a073153a1b	127.0.0.1	2016-06-27 19:37:20.858648	2016-06-26 19:37:20.858648
966	1	ea0f73193ebacf3fea80b786415b41cd5e57cf96	127.0.0.1	2016-06-28 11:24:43.662227	2016-06-27 11:24:43.662227
967	1	c1707824a500cac2ba82c6ded490b5a1c0cfe6ea	127.0.0.1	2016-06-28 11:37:41.978779	2016-06-27 11:37:41.978779
968	2	c65e38f0c9dc76689ef1854aa092e5e15331e05a	127.0.0.1	2016-06-28 15:16:35.661633	2016-06-27 15:16:35.661633
969	1	5d9b3ce079703fa2824045b1c7c09cf0446ec5f9	127.0.0.1	2016-06-28 18:48:06.429365	2016-06-27 18:48:06.429365
970	2	c8316256be67820be86cc2fc2108087846ed0113	127.0.0.1	2016-06-28 19:07:08.000009	2016-06-27 19:07:08.000009
971	1	0e02f579cfaa7bf77cafab330289a7e16d0e91a0	127.0.0.1	2016-06-28 19:19:32.43838	2016-06-27 19:19:32.43838
972	1	1488b4441a9901dbb8cb1bcde971100575200639	127.0.0.1	2016-06-28 19:45:48.206315	2016-06-27 19:45:48.206315
973	1	351c24dabb61a74f9d0d2e6ebc7cd68f938d7b3e	127.0.0.1	2016-06-28 20:04:38.144705	2016-06-27 20:04:38.144705
974	1	f805a9a4eb1e0077d901e4336e2fa387ad6b4c80	127.0.0.1	2016-06-28 22:00:37.623632	2016-06-27 22:00:37.623632
975	1	e561570e29afd11c08136c0431d4f781007d1d99	127.0.0.1	2016-06-28 22:37:13.669598	2016-06-27 22:37:13.669598
976	1	fbcdcba8e5f33250e9661a915a1b056f878c286d	127.0.0.1	2016-06-28 23:42:11.995323	2016-06-27 23:42:11.995323
977	1	8638cd8c56c667830ef30a4c83675cd7f72ab263	127.0.0.1	2016-06-29 01:21:30.132923	2016-06-28 01:21:30.132923
978	1	79094cb2f52fcb38c213e9d1fd3f8d4c787c70d9	127.0.0.1	2016-06-29 01:24:03.17855	2016-06-28 01:24:03.17855
979	1	f466ca61971bb670cf1334ad4368dead4fc6e660	127.0.0.1	2016-06-29 01:27:40.995236	2016-06-28 01:27:40.995236
980	2	2363f29f362c8b54c69b6d3bbfd28735373aa798	127.0.0.1	2016-07-01 19:34:40.139143	2016-06-30 19:34:40.139143
981	2	5f88a4f2be21ea31ec731f9f0f5a8e9061355f11	127.0.0.1	2016-07-01 19:50:22.221354	2016-06-30 19:50:22.221354
982	2	486b694e52d98e69e7b1009e1cdd9e677713d967	127.0.0.1	2016-07-01 23:19:39.141717	2016-06-30 23:19:39.141717
983	2	50c00ae99ed8a92ec08c4ff0197b9808b8116d33	127.0.0.1	2016-07-01 23:20:36.320944	2016-06-30 23:20:36.320944
984	2	506226d383eb4c90af5340ab7c162df96da88d4d	127.0.0.1	2016-07-01 23:24:18.903147	2016-06-30 23:24:18.903147
985	2	09ff611d1ff5eb29bef5bee5ce98d0926f6932ce	127.0.0.1	2016-07-01 23:41:30.541832	2016-06-30 23:41:30.541832
986	2	d766b2408a2ea0adb4efafec500dbea3aab0fad5	127.0.0.1	2016-07-01 23:43:04.028463	2016-06-30 23:43:04.028463
987	2	525191c6a84dc05e069312851a8b76eb0937d999	127.0.0.1	2016-07-02 00:03:47.746507	2016-07-01 00:03:47.746507
988	2	c1f5089d565d89b44f3a70f924b00f8e527dec42	127.0.0.1	2016-07-02 00:04:22.561914	2016-07-01 00:04:22.561914
989	2	795d62e549b14dffa9eaeed8961dbcef2805127c	127.0.0.1	2016-07-02 00:06:09.967726	2016-07-01 00:06:09.967726
990	2	a1a12c136b361c8aa1539a9d4029011647cae60e	127.0.0.1	2016-07-02 00:09:09.809444	2016-07-01 00:09:09.809444
991	2	a94ce6592ce966108b0ec94e073c0b96d8de3748	127.0.0.1	2016-07-02 00:15:21.132348	2016-07-01 00:15:21.132348
992	2	b037c865e935b8c2570ad2313a36a163c354f3b2	127.0.0.1	2016-07-05 10:56:32.349736	2016-07-04 10:56:32.349736
993	1	4f9a81d05f4dbf669d92bf40faa16a580bd428f0	127.0.0.1	2016-07-05 12:59:38.062812	2016-07-04 12:59:38.062812
994	1	e3ef2d748977f59848c0729f61d48d3f66faeabc	127.0.0.1	2016-07-05 13:03:53.231143	2016-07-04 13:03:53.231143
995	1	882a60cb24b66075f7f34adf89982803b453f602	127.0.0.1	2016-07-05 13:18:58.420125	2016-07-04 13:18:58.420125
996	1	d99ad087c67d5ff1c3985eeaf7a6a09fc1c10c89	127.0.0.1	2016-07-05 21:17:53.519283	2016-07-04 21:17:53.519283
997	2	4e93658aa465256725b15c1617a133be3da5a486	127.0.0.1	2016-07-05 22:27:53.3695	2016-07-04 22:27:53.3695
1000	1	79d8f588206d593689072d69cadc0e10e710dd57	127.0.0.1	2016-07-05 22:58:37.545892	2016-07-04 22:58:37.545892
1001	1	0d180c61864da1188f608e07cda1221cee42776b	127.0.0.1	2016-07-06 21:05:28.576368	2016-07-05 21:05:28.576368
1002	1	486f5af2dcfb23fa9f653e114dd8c9d392c6e4cd	127.0.0.1	2016-07-06 21:07:14.351819	2016-07-05 21:07:14.351819
1003	1	c5567e65a4adc084e3c42e5bb557d4d0f7e3e009	127.0.0.1	2016-07-14 10:12:33.469774	2016-07-13 10:12:33.469774
1004	1	b09cf25db7973ebf6e4884ef9218cc8ad7eed215	127.0.0.1	2016-07-14 10:14:35.86105	2016-07-13 10:14:35.86105
1005	1	815be70bb5483d9bd29b9550fd3f41c89d7bed27	127.0.0.1	2016-07-14 10:20:44.846889	2016-07-13 10:20:44.846889
1006	1	53b8e7afb7a1c7ab0e340b0859564c5881c2996b	127.0.0.1	2016-07-14 10:41:15.650618	2016-07-13 10:41:15.650618
1007	1	040847d0bc6ce6949658ae4e8a362676cb93cb53	127.0.0.1	2016-07-14 10:41:52.018461	2016-07-13 10:41:52.018461
1009	1	aa5e596c369f7d284e96a83dfbf24648df427daf	127.0.0.1	2016-07-14 10:43:10.906804	2016-07-13 10:43:10.906804
1010	1	ea417c7294d81bd55ce23469807efcf853166d92	127.0.0.1	2016-07-14 10:43:55.861262	2016-07-13 10:43:55.861262
1012	1	967be8b6e254faf73639f047506762ef05024e94	127.0.0.1	2016-07-14 10:44:40.111736	2016-07-13 10:44:40.111736
1013	1	2b13908b7b4ecd7be210d0cf837d1182537559e0	127.0.0.1	2016-07-14 11:05:58.663725	2016-07-13 11:05:58.663725
1014	1	a0b918c2d00b66424f22dd91720525dc7743d2f4	127.0.0.1	2016-07-15 09:59:46.653331	2016-07-14 09:59:46.653331
1015	1	2d565cbc05d9222b3e1ea83e2d7323ebc87c8818	127.0.0.1	2016-07-15 12:53:37.738886	2016-07-14 12:53:37.738886
1016	1	33a2cacac30d181aacf463c63cdeeaf062786781	127.0.0.1	2016-07-15 12:59:36.145434	2016-07-14 12:59:36.145434
1017	1	3318fffe02fb4e1625a74c2d6f0f69ffd54db610	127.0.0.1	2016-07-15 16:37:00.777983	2016-07-14 16:37:00.777983
1018	1	48b4bb1e1f68404d6b3a6cb90256b1e436f74416	127.0.0.1	2016-07-16 10:27:09.505784	2016-07-15 10:27:09.505784
1019	1	2d99f2b32149bdf11080477c96ea88151d51d526	127.0.0.1	2016-07-16 11:14:08.883518	2016-07-15 11:14:08.883518
1020	1	a82a5695cfb4860b368900cde7b9d415113a6db9	127.0.0.1	2016-07-17 18:50:10.962215	2016-07-16 18:50:10.962215
1021	1	dde1bd6b45ceb29e27cc738ec830512d275165b7	127.0.0.1	2016-07-17 18:52:23.623732	2016-07-16 18:52:23.623732
1022	1	2706bc745391ad5cdd376ff7b772b446c65aaa22	127.0.0.1	2016-07-17 18:55:25.070867	2016-07-16 18:55:25.070867
1023	1	092ba61e0a1ca4f317e945eb754127fd167564eb	127.0.0.1	2016-07-17 19:08:51.603995	2016-07-16 19:08:51.603995
1024	1	721546af4d7878535aaf674045aab7a2abee005d	127.0.0.1	2016-07-17 19:34:02.511834	2016-07-16 19:34:02.511834
1025	1	7ae577c3d369e834ea54dc17886b2a7e31fd5ffa	127.0.0.1	2016-07-17 20:20:46.878998	2016-07-16 20:20:46.878998
1026	1	69de236fbeef330fbab0412fa7e01b03dbed973d	127.0.0.1	2016-07-19 01:00:19.499751	2016-07-18 01:00:19.499751
1027	1	0bed9bf4c6e04920f03e217a3b47cf7791fa6820	127.0.0.1	2016-07-19 01:07:32.010124	2016-07-18 01:07:32.010124
1028	1	abe38f815053d9b7e7196e6827cbc902b783ec7a	127.0.0.1	2016-07-19 01:08:31.617573	2016-07-18 01:08:31.617573
1029	1	499fba96ea545c17e3ef4e05abbde56acb343b47	127.0.0.1	2016-07-19 23:04:49.432695	2016-07-18 23:04:49.432695
1030	1	dc13ab654560c8fb31e4ec2d41fe66226cf7d554	127.0.0.1	2016-07-27 09:24:48.572162	2016-07-26 09:24:48.572162
1031	1	e9204624b7a4e3a87012ab60023e4b5fefc256bd	127.0.0.1	2016-07-28 10:29:46.791616	2016-07-27 10:29:46.791616
1032	1	24e52ddc0b07e2d2345f24b5672b01399e263c99	127.0.0.1	2016-07-30 13:50:23.153167	2016-07-29 13:50:23.153167
1033	1	6a08b9eb5977247f1bcbea6f765aa499c6ab32fb	127.0.0.1	2016-08-03 10:20:31.487161	2016-08-02 10:20:31.487161
1034	1	c56800e7f96409022615b3b31720244f95bb4ecc	127.0.0.1	2016-08-03 12:18:00.647838	2016-08-02 12:18:00.647838
1035	1	9c833b0ab366bce6941df25812b05fd4f7f6d1e4	127.0.0.1	2016-08-04 10:41:57.657602	2016-08-03 10:41:57.657602
1036	1	a0c1fb23611855f66169a0c66cfd2da27f93763b	127.0.0.1	2016-08-04 12:47:15.605863	2016-08-03 12:47:15.605863
1037	1	c504271e8e75e85d199a9c55074867b630c3b3ac	127.0.0.1	2016-08-07 14:59:59.568765	2016-08-06 14:59:59.568765
1038	1	12e720942969688899939065e081ea3d72e42e25	127.0.0.1	2016-08-09 12:21:52.548696	2016-08-08 12:21:52.548696
1039	1	740bd7c10d8a2b0c85727122953558ae25e1f3e5	127.0.0.1	2016-08-09 12:41:14.342935	2016-08-08 12:41:14.342935
1040	1	d4401753e77ef94855a638c5e953f86e8fdfccf0	127.0.0.1	2016-08-10 10:01:23.699127	2016-08-09 10:01:23.699127
1041	1	d1930af53da95cb8a72a235795c40ca11f049beb	127.0.0.1	2016-08-10 10:02:03.900703	2016-08-09 10:02:03.900703
1046	1	bb8ed097cd99a18b9303934d5ec4ae8ef4bc49bb	127.0.0.1	2016-08-10 10:42:15.588346	2016-08-09 10:42:15.588346
1047	1	314b4346d11dd50502c04603a291c446edb5a123	127.0.0.1	2016-08-10 18:23:29.994767	2016-08-09 18:23:29.994767
1050	2	3577bf69db2e074ef69076842207447c536900e9	127.0.0.1	2016-08-11 09:57:08.956222	2016-08-10 09:57:08.956222
1051	1	19ca57dda09f8fc6a031d25e41e2e6a0bcaeeb9d	127.0.0.1	2016-08-11 22:55:06.728693	2016-08-10 22:55:06.728693
1052	1	d0c5955bee99892be7a7f14e6c95339c231237f2	127.0.0.1	2016-08-11 23:31:46.720067	2016-08-10 23:31:46.720067
1053	1	8ee21a7780c7aea7c8f25c2709303d59e688cc70	127.0.0.1	2016-08-11 23:35:48.443563	2016-08-10 23:35:48.443563
1054	1	e468041e0fc65e0ff04b10e23c50a9746bf80672	127.0.0.1	2016-08-11 23:41:44.189293	2016-08-10 23:41:44.189293
1062	1	0240043c2ab7ff7abff3bd171d81198806a49c32	127.0.0.1	2016-08-12 00:25:10.900127	2016-08-11 00:25:10.900127
1063	1	d7b5372adaa88e9da31ac165603c5051ebd10bc8	127.0.0.1	2016-08-12 12:38:55.681561	2016-08-11 12:38:55.681561
1064	1	1ed89f6919754cea5bc0ba5e72d544e565b34819	127.0.0.1	2016-08-12 23:00:00.759295	2016-08-11 23:00:00.759295
1065	1	45f99e1c82e42c78e9e26dc12667dfaa72510166	127.0.0.1	2016-08-12 23:03:15.66067	2016-08-11 23:03:15.66067
1066	1	950f94af1ffee453512a3c758b539484b6395e5c	127.0.0.1	2016-08-12 23:03:42.414586	2016-08-11 23:03:42.414586
1067	1	0be81c1c251c4716291e8305f82a029bea429f0f	127.0.0.1	2016-08-12 23:06:38.802131	2016-08-11 23:06:38.802131
1068	1	0f3f64c14d4560e25c6dc8c410de65ab0230c6f1	127.0.0.1	2016-08-12 23:15:59.284405	2016-08-11 23:15:59.284405
1069	1	dae795e2dc4d1d852a752afa83892b29f835083c	127.0.0.1	2016-08-12 23:18:53.364589	2016-08-11 23:18:53.364589
1070	1	aed1e2afcaff3d4961814e4e7f4a0d596610a334	127.0.0.1	2016-08-12 23:20:01.324758	2016-08-11 23:20:01.324758
1071	1	7750da2ebe9d04eefdba9fb6473ebc718d903c10	127.0.0.1	2016-08-12 23:23:03.446885	2016-08-11 23:23:03.446885
1073	1	ff0f45a88cd4f168a2d9c06aa2c4d304233c0785	127.0.0.1	2016-08-12 23:46:43.049233	2016-08-11 23:46:43.049233
1074	1	78142e6ba6f5c672ea094d8b249b00020d262c65	127.0.0.1	2016-08-14 12:28:53.551194	2016-08-13 12:28:53.551194
1075	1	5073ec94d0253f58de92acd10c016b0fb95ca468	127.0.0.1	2016-08-30 19:36:23.839921	2016-08-29 19:36:23.839921
1076	1	627c4695ddcacdbc4685736a5f18f9a33dc9a290	127.0.0.1	2016-08-30 19:49:58.315852	2016-08-29 19:49:58.315852
1077	1	b011c643cb6368d039650352c1b08e74e0a34fd7	127.0.0.1	2016-08-30 20:04:40.732973	2016-08-29 20:04:40.732973
1078	1	a1baac444fa19051f9c1b098b0cbafc7329f9a23	127.0.0.1	2016-08-30 20:12:03.392751	2016-08-29 20:12:03.392751
1079	1	ee965c7677eb26a6e0eac6c1b42de1bd9a4caa67	127.0.0.1	2016-08-30 20:21:26.762686	2016-08-29 20:21:26.762686
1080	1	3d4180ce773506c1232fab643a7fcd307b910358	127.0.0.1	2016-08-30 20:45:24.191071	2016-08-29 20:45:24.191071
1081	1	f7af9bfe92000f4cb21f4ae385fb8da86d1302c1	127.0.0.1	2016-09-01 14:54:40.188757	2016-08-31 14:54:40.188757
1082	2	8163910336efca4ff490be0666c2246f5fd01c0b	127.0.0.1	2016-09-01 17:20:53.037898	2016-08-31 17:20:53.037898
1083	2	b2baf356c61b4ce8070ba08cbe4a0cc8f0da1aa3	127.0.0.1	2016-10-01 14:47:11.649402	2016-09-30 14:47:11.649402
1084	2	3a8e9b3bb29499c77292846a740ebf458ca5f024	127.0.0.1	2017-05-10 22:54:36.287576	2017-05-09 22:54:36.287576
1085	2	0e8e71976446a9cfb7c030613281477c227efd7b	127.0.0.1	2017-05-11 00:19:40.740779	2017-05-10 00:19:40.740779
1086	2	b85e81c720e16ed9fd0249fb99faf92e5a19bb40	127.0.0.1	2017-05-11 00:48:06.997406	2017-05-10 00:48:06.997406
1087	2	8b2a27ef13e742141d2229205114125e9183577c	127.0.0.1	2017-05-12 22:19:12.9104	2017-05-11 22:19:12.9104
1088	2	b2cd2df33d571d3b4398770ab1c8cea2b7f5c36d	127.0.0.1	2017-05-16 10:59:21.101364	2017-05-15 10:59:21.101364
1089	2	cc668b9b8947199b818898203235410ca832a0db	127.0.0.1	2017-05-16 11:24:10.155017	2017-05-15 11:24:10.155017
1090	2	4606c2a260021e7bdf8fe98bd45a79f11b29cc3b	127.0.0.1	2017-05-16 11:34:32.342632	2017-05-15 11:34:32.342632
1091	2	08c783137bae5ed90bf6c4757cfa6e2db0c9d150	127.0.0.1	2017-05-16 11:36:51.350332	2017-05-15 11:36:51.350332
1092	2	c4317462d9b4ce18fe63d81af6c5762303c5fb6d	127.0.0.1	2017-05-17 17:52:52.816013	2017-05-16 17:52:52.816013
1093	2	7ba69ed593400e24c4207d42207fd76463cf9eb2	127.0.0.1	2017-06-01 10:31:48.0091	2017-05-31 10:31:48.0091
1094	2	b3031dd5dfb7a2c673becf175dbd02eab8be5af9	127.0.0.1	2017-06-01 10:36:22.950126	2017-05-31 10:36:22.950126
1095	2	765650f6b66efadecafa70b5bde23f05665145bf	127.0.0.1	2017-06-01 10:48:22.15048	2017-05-31 10:48:22.15048
1096	436	f0835802aab2da5c567679fb3437c019704cd092	127.0.0.1	2017-06-01 10:49:40.193548	2017-05-31 10:49:40.193548
1097	2	cd406c0c47b389aa350929cec5064e202792459d	127.0.0.1	2017-06-01 10:50:19.812835	2017-05-31 10:50:19.812835
1098	436	1ec22213400091a14f08571123a5ab770144f4cb	127.0.0.1	2017-06-01 10:51:00.668335	2017-05-31 10:51:00.668335
1099	436	e5e4d3e47bdae88cf367d637a84ba91316a06815	127.0.0.1	2017-06-01 10:56:39.261055	2017-05-31 10:56:39.261055
1100	436	874f69bc5e2aec8a3179b6f70992be20f00c2c33	127.0.0.1	2017-06-01 11:21:52.911455	2017-05-31 11:21:52.911455
1101	2	a0433f9644f743290084913c9d261739e755cc8d	127.0.0.1	2017-06-01 11:30:28.392975	2017-05-31 11:30:28.392975
1102	436	312894a90336bda9718c7f4504446abfee54f1e9	127.0.0.1	2017-06-01 11:32:25.136908	2017-05-31 11:32:25.136908
1103	2	aac06aec87713e3ce61c0ac35f820360829d7820	127.0.0.1	2017-06-01 11:32:55.71995	2017-05-31 11:32:55.71995
1104	2	3a04b629dd5eb3de55b206e54017b478eb2b0b6e	127.0.0.1	2017-06-01 17:45:30.893181	2017-05-31 17:45:30.893181
1105	436	10aba5034a0a46eea2eb800938b4449ac8ea892d	127.0.0.1	2017-06-01 17:50:26.373949	2017-05-31 17:50:26.373949
1106	2	412d6ce2fbe05a8a9dad25049571728a79479050	127.0.0.1	2017-06-01 17:51:45.392255	2017-05-31 17:51:45.392255
1107	436	ed18c2265a7818734e40a15fa91aa8cec5010e8a	127.0.0.1	2017-06-01 17:52:08.813914	2017-05-31 17:52:08.813914
1108	2	664908c1437395abea009ce981cf4dc171023b06	127.0.0.1	2017-06-01 17:56:47.97527	2017-05-31 17:56:47.97527
1109	436	316eabd3417a7f8a7b59b827504317475c169a00	127.0.0.1	2017-06-01 18:39:06.435192	2017-05-31 18:39:06.435192
1110	436	bf42b5b7d5a5ccf793d5e4470ce92064f0015652	127.0.0.1	2017-06-01 19:08:40.046302	2017-05-31 19:08:40.046302
1111	2	821117a0cd6a2fe5068c3b6055185378981d9879	127.0.0.1	2017-06-01 19:12:04.557748	2017-05-31 19:12:04.557748
1112	436	d3552e0ab10602045c3df17096659774157f461f	127.0.0.1	2017-06-01 19:15:30.312776	2017-05-31 19:15:30.312776
1114	436	28c30f92e71cb5d6fee0c81168731d87c9c0e819	127.0.0.1	2017-06-02 10:59:31.095157	2017-06-01 10:59:31.095157
1115	2	2a38452d162b0e3138005a2eacb8f743f8d39754	127.0.0.1	2017-06-02 10:59:55.478629	2017-06-01 10:59:55.478629
1116	436	72d38e08987f52662afa9eeaa5dc8b31334a3fc5	127.0.0.1	2017-06-02 11:00:29.829704	2017-06-01 11:00:29.829704
1113	2	11b0148ad4d8b1c0fbf590698a1c5bc9b89e1c98	127.0.0.1	2017-06-02 10:59:13.476549	2017-06-01 10:59:13.476549
1117	2	6470ec16bd97c1f200ff51e1829c9ae77f9ce90d	127.0.0.1	2017-07-11 19:08:11.091904	2017-07-10 19:08:11.091904
1118	436	097aec34998fba9deacab5ef1b560ffa03055c99	127.0.0.1	2017-10-21 15:53:21.619788	2017-10-20 15:53:21.619788
1119	436	6048e560a7b821b37720753e7e17591cd4155bc1	127.0.0.1	2017-10-25 14:50:16.764149	2017-10-24 14:50:16.764149
1120	2	8453a4c7873a720902bb8d8710fbcaba21d3dd74	127.0.0.1	2017-10-25 14:50:54.215896	2017-10-24 14:50:54.215896
1121	436	fb0cb8acea6e3f5273fd83c2dbd84bd065a7c901	127.0.0.1	2017-10-25 14:51:36.9393	2017-10-24 14:51:36.9393
1122	2	a2d529c6e6b32cb672e53504e6a7a550b125eddc	127.0.0.1	2017-10-25 14:51:59.335288	2017-10-24 14:51:59.335288
1123	2	c85eecf5117f1354bf3f178296d026f4034d302d	127.0.0.1	2018-05-16 21:13:01.451339	2018-05-15 21:13:01.451339
1124	2	eec1ac00de06c887e611d3f3677967555e08a0cd	127.0.0.1	2018-07-14 16:02:35.859043	2018-07-13 16:02:35.859043
1125	2	212ec4de32b803a183e63d3aa3ddf54a13a02bfa	127.0.0.1	2018-07-14 19:20:36.628586	2018-07-13 19:20:36.628586
1126	2	ee96f73a0fd8aec9b4a9fbe9b980fc8d72889316	127.0.0.1	2018-07-14 19:56:16.87822	2018-07-13 19:56:16.87822
1127	2	d2e77855eea86257d828434d3015edbccb544f38	127.0.0.1	2018-07-14 20:53:33.031946	2018-07-13 20:53:33.031946
1128	2	9f26352525a7ebad725ecad64dcae2992a120ba0	127.0.0.1	2018-07-14 20:58:07.443174	2018-07-13 20:58:07.443174
1129	436	c1634f33efe8ddb93316013c66f2fd368ad7e6fa	127.0.0.1	2018-07-18 20:39:57.340352	2018-07-17 20:39:57.340352
1130	2	225cc6d701c3004475074f60cb75c9907114ee37	127.0.0.1	2018-07-21 15:52:13.162199	2018-07-20 15:52:13.162199
1131	2	0e1e23f24ff84d36aa8b849648305ef093bc579b	127.0.0.1	2018-07-21 17:44:46.057721	2018-07-20 17:44:46.057721
1132	2	7726cd7b7a1ba5bf6df7200502209d063442bff3	127.0.0.1	2018-08-28 09:48:28.244718	2018-08-27 09:48:28.244718
1133	2	b64c638cb23693626f884bff6621892f6d60d0cc	127.0.0.1	2018-08-28 09:53:59.250782	2018-08-27 09:53:59.250782
1134	2	bd67b9bce24637dd2d157e46f1c4686577351e38	127.0.0.1	2018-08-28 10:03:31.44117	2018-08-27 10:03:31.44117
1135	2	5e154e2448ab22632f7d775563c8cada6f02b846	127.0.0.1	2018-08-29 15:33:32.871212	2018-08-28 15:33:32.871212
1136	2	29dbf337fcdc15441252bf0ca9a2b9e80bd6f1dc	127.0.0.1	2018-08-30 14:13:19.46911	2018-08-29 14:13:19.46911
1137	2	eff2a1037f9d8bcff726d50828c75c5ba1d6fb3b	127.0.0.1	2018-09-04 14:43:51.775258	2018-09-03 14:43:51.775258
1138	2	a927368432f08abc940db9c8dc0f0eedb2195e3e	127.0.0.1	2018-09-04 14:45:44.070839	2018-09-03 14:45:44.070839
1139	2	c7e86b262f039ff30dbb1c8a7a50c3d83b223d07	127.0.0.1	2018-09-04 15:04:13.51565	2018-09-03 15:04:13.51565
1140	2	48ea444818c6672213f0f7ca243961cf0d9c1d80	127.0.0.1	2018-09-04 15:21:34.225657	2018-09-03 15:21:34.225657
1141	2	e855227602e43f8edfccb1a90964d9214aa4661f	127.0.0.1	2018-09-04 20:59:36.039121	2018-09-03 20:59:36.039121
1142	2	73805bc29d28edb90a1e328532da1d851fe89ef9	127.0.0.1	2018-09-04 21:17:02.216614	2018-09-03 21:17:02.216614
1143	2	79cbeceb0dc317fe80de816a84d8f593b0ea5add	127.0.0.1	2018-09-04 21:42:35.42415	2018-09-03 21:42:35.42415
1144	2	7763105d8a0877dddbfa953f6e61c9988eb3e628	127.0.0.1	2018-09-04 23:36:56.621061	2018-09-03 23:36:56.621061
1145	2	3bf8c61ecc4bc95f313b8a637c382bcf488da6bd	127.0.0.1	2018-09-05 00:11:54.874309	2018-09-04 00:11:54.874309
1146	2	3dbbd116412380cc2a886fda506c07d1aa848618	127.0.0.1	2018-09-05 01:08:10.938936	2018-09-04 01:08:10.938936
1147	2	5c3d5f59dde35a4e4f0265c9c2c0bd19976d5058	127.0.0.1	2018-09-05 01:13:12.415463	2018-09-04 01:13:12.415463
1148	2	e21161e57c52054131c2314a9f8d05b75304072c	127.0.0.1	2018-09-05 01:15:45.957125	2018-09-04 01:15:45.957125
1149	2	5d7ffc7508ae959dd0fd00faa3504750dbe72d95	127.0.0.1	2018-09-05 01:17:27.230516	2018-09-04 01:17:27.230516
1150	2	d8ecb07a9ef6efc68adb612ecdd9f9243df1e2ac	127.0.0.1	2018-09-05 01:32:50.365878	2018-09-04 01:32:50.365878
1151	2	4d240eef1f837775d7583dbaf8f549495120a284	127.0.0.1	2018-09-05 01:46:54.162023	2018-09-04 01:46:54.162023
1152	2	f357c090f56f3bfa0c4534e8e4e5906d7261311b	127.0.0.1	2018-09-05 01:52:47.441424	2018-09-04 01:52:47.441424
1153	2	8736bc22bd9f8199bf0a384360389e90be3a58f3	127.0.0.1	2018-09-05 09:00:04.487498	2018-09-04 09:00:04.487498
1154	2	0eb799d53757ff30b6fc3ce9db0cabd3f19bfee3	127.0.0.1	2018-09-05 09:05:33.911198	2018-09-04 09:05:33.911198
1155	2	ca214fe8f0f1d56a50de2108f7d6efc4648510ae	127.0.0.1	2018-09-05 10:16:20.361806	2018-09-04 10:16:20.361806
1156	2	601e7bc9ccfb7ee9a9be54cd39de21dd7c239e03	127.0.0.1	2018-09-05 13:34:21.05931	2018-09-04 13:34:21.05931
1157	2	df6277a62613c8fc0a6de7f9cf2a6ce5e6a31713	127.0.0.1	2018-09-05 18:14:15.266073	2018-09-04 18:14:15.266073
1158	2	9dd0f7506135dd94a78802b6c87e4bf8d0db049a	127.0.0.1	2018-09-05 18:21:48.968549	2018-09-04 18:21:48.968549
1159	2	f1a9966f95522deb7379ede0b7ca169d7bbeb319	127.0.0.1	2018-09-05 18:26:45.947091	2018-09-04 18:26:45.947091
1160	2	a2b7e4864afab31859457ec724f0e1288dcbe41b	127.0.0.1	2018-09-05 19:20:08.213708	2018-09-04 19:20:08.213708
1161	2	b7cad1700fd679a51ba4e2a2dcf13ec1e914d47e	127.0.0.1	2018-09-05 23:10:47.976095	2018-09-04 23:10:47.976095
1162	2	a3f6571e084b64bbf8dc74ff96525cf43dd0e44a	127.0.0.1	2018-09-05 23:12:45.420565	2018-09-04 23:12:45.420565
1163	2	60b6ef4bc6fac672b5124b2b1645f2bc77506dae	127.0.0.1	2018-09-05 23:22:48.510516	2018-09-04 23:22:48.510516
1164	2	bc2944afa23da4d0593d3adf759fc62216336786	127.0.0.1	2018-09-05 23:26:41.262308	2018-09-04 23:26:41.262308
1165	2	1e7bdcb546d2f6ed02110896cfbe4a6e7e908137	127.0.0.1	2018-09-06 00:07:40.25189	2018-09-05 00:07:40.25189
1166	2	7db8f2af996f94074688abd6884ae7acb7e291d7	127.0.0.1	2018-09-06 00:17:45.880775	2018-09-05 00:17:45.880775
1167	2	7aab4edabefb7bd685e4da912bdc90ff85ed313c	127.0.0.1	2018-09-06 00:40:08.992522	2018-09-05 00:40:08.992522
1168	2	694e7b690f0f908061ad805f08fe301774329a07	127.0.0.1	2018-09-06 08:33:34.113626	2018-09-05 08:33:34.113626
1169	2	d958105ccbdd74769fc4be3f531bfdc52f145d87	127.0.0.1	2018-09-06 08:35:28.052334	2018-09-05 08:35:28.052334
1170	2	900bd34bb38335ee974703412da3c1bb0ffe384c	127.0.0.1	2018-09-06 10:52:33.049365	2018-09-05 10:52:33.049365
1171	2	8c37f3ffc82fe1786aae574162628a55ccc4d7f0	127.0.0.1	2018-09-06 10:54:35.542914	2018-09-05 10:54:35.542914
1172	2	5492027e153019a2995226e28b1101244030bba4	127.0.0.1	2018-09-06 11:00:57.250693	2018-09-05 11:00:57.250693
1173	2	0977b3a285b001a6c2a009e9225ac81b9773643b	127.0.0.1	2018-09-06 11:32:07.992479	2018-09-05 11:32:07.992479
1174	2	46f5cbe0847552815c66dabb9c10204617297bc0	127.0.0.1	2018-09-06 11:33:04.331831	2018-09-05 11:33:04.331831
1175	2	139cf2a38bc1ec0f837eb8541efad4b2b72c7f19	127.0.0.1	2018-09-06 11:33:42.66218	2018-09-05 11:33:42.66218
1176	2	f873e58f877ee12f510bf5569718b9dc815dcb09	127.0.0.1	2018-09-12 15:58:39.838786	2018-09-11 15:58:39.838786
1177	2	a9fb4052ba6b1cffeb6b73df0285499095ccb384	127.0.0.1	2018-09-12 15:59:31.537907	2018-09-11 15:59:31.537907
\.


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 296
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_session_id_seq', 1177, true);


SET search_path = sqitch, pg_catalog;

--
-- TOC entry 4029 (class 0 OID 18873)
-- Dependencies: 175
-- Data for Name: changes; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY changes (change_id, script_hash, change, project, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
443f79a43f6ee35b86d7b276fc54eba8726e9a47	d5bc9cf9cb6f0eea0597f0bca471fe6ae7a123ed	0000-first-version	smm	first version	2016-04-01 20:49:50.549267-03	donm,,,	donm@donm-201603	2016-03-29 18:40:35-03	renatopc,,,	renato@oodcronpc
\.


--
-- TOC entry 4031 (class 0 OID 18912)
-- Dependencies: 177
-- Data for Name: dependencies; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY dependencies (change_id, type, dependency, dependency_id) FROM stdin;
\.


--
-- TOC entry 4032 (class 0 OID 18931)
-- Dependencies: 178
-- Data for Name: events; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY events (event, change_id, change, project, note, requires, conflicts, tags, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
deploy	443f79a43f6ee35b86d7b276fc54eba8726e9a47	0000-first-version	smm	first version	{}	{}	{}	2016-04-01 20:49:50.551398-03	donm,,,	donm@donm-201603	2016-03-29 18:40:35-03	renatopc,,,	renato@oodcronpc
\.


--
-- TOC entry 4028 (class 0 OID 18862)
-- Dependencies: 174
-- Data for Name: projects; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY projects (project, uri, created_at, creator_name, creator_email) FROM stdin;
smm	https://github.com/AwareTI/SMM	2016-04-01 20:49:48.188243-03	donm,,,	donm@donm-201603
\.


--
-- TOC entry 4027 (class 0 OID 18853)
-- Dependencies: 173
-- Data for Name: releases; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY releases (version, installed_at, installer_name, installer_email) FROM stdin;
1.10000002	2016-04-01 20:49:48.181643-03	donm,,,	donm@donm-201603
\.


--
-- TOC entry 4030 (class 0 OID 18890)
-- Dependencies: 176
-- Data for Name: tags; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY tags (tag_id, tag, project, change_id, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 3704 (class 2606 OID 20805)
-- Name: budget_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_pkey PRIMARY KEY (id);


--
-- TOC entry 3706 (class 2606 OID 20807)
-- Name: campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (id);


--
-- TOC entry 3708 (class 2606 OID 20809)
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 20811)
-- Name: comment_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_pkey PRIMARY KEY (id);


--
-- TOC entry 3715 (class 2606 OID 20813)
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3721 (class 2606 OID 20815)
-- Name: company_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY company_documents
    ADD CONSTRAINT company_documents_pkey PRIMARY KEY (id);


--
-- TOC entry 3717 (class 2606 OID 20817)
-- Name: company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- TOC entry 3723 (class 2606 OID 20819)
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3725 (class 2606 OID 20821)
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 3727 (class 2606 OID 20823)
-- Name: district_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);


--
-- TOC entry 3729 (class 2606 OID 20825)
-- Name: email_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_pkey PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 37696)
-- Name: encuestas_goal_id_tipo_sessionid_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuestas_goal_id_tipo_sessionid_key UNIQUE (goal_id, tipo, sessionid);


--
-- TOC entry 3831 (class 2606 OID 37694)
-- Name: encuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuestas_pkey PRIMARY KEY (id);


--
-- TOC entry 3731 (class 2606 OID 20827)
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3733 (class 2606 OID 20829)
-- Name: file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 3739 (class 2606 OID 20831)
-- Name: goal_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_pkey PRIMARY KEY (id);


--
-- TOC entry 3735 (class 2606 OID 20833)
-- Name: goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_pkey PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 20835)
-- Name: goal_porcentage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_pkey PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 20837)
-- Name: goal_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_pkey PRIMARY KEY (id);


--
-- TOC entry 3747 (class 2606 OID 20839)
-- Name: goal_secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_pkey PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 20841)
-- Name: invite_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 20843)
-- Name: management_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_pkey PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 20845)
-- Name: milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- TOC entry 3719 (class 2606 OID 20847)
-- Name: name_idx; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT name_idx UNIQUE (name);


--
-- TOC entry 3758 (class 2606 OID 20849)
-- Name: objective_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY objective
    ADD CONSTRAINT objective_pkey PRIMARY KEY (id);


--
-- TOC entry 3761 (class 2606 OID 20851)
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- TOC entry 3763 (class 2606 OID 20853)
-- Name: organization_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organization_type
    ADD CONSTRAINT organization_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3765 (class 2606 OID 20855)
-- Name: password_reset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_pkey PRIMARY KEY (id);


--
-- TOC entry 3767 (class 2606 OID 20857)
-- Name: pre_register_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pre_register
    ADD CONSTRAINT pre_register_pkey PRIMARY KEY (id);


--
-- TOC entry 3769 (class 2606 OID 20859)
-- Name: prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prefecture
    ADD CONSTRAINT prefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3771 (class 2606 OID 20861)
-- Name: progress_goal_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3775 (class 2606 OID 20863)
-- Name: project_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_pkey PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 20865)
-- Name: project_event_project_id_is_last_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_is_last_key UNIQUE (project_id, is_last);


--
-- TOC entry 3779 (class 2606 OID 20867)
-- Name: project_event_read_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_pkey PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 20869)
-- Name: project_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_pkey PRIMARY KEY (id);


--
-- TOC entry 3749 (class 2606 OID 20871)
-- Name: project_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_pkey PRIMARY KEY (id);


--
-- TOC entry 3783 (class 2606 OID 20873)
-- Name: project_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_pkey PRIMARY KEY (id);


--
-- TOC entry 3773 (class 2606 OID 20875)
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- TOC entry 3785 (class 2606 OID 20877)
-- Name: project_prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3787 (class 2606 OID 20879)
-- Name: project_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_pkey PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 20881)
-- Name: project_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_types
    ADD CONSTRAINT project_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 20883)
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 20885)
-- Name: register_counsil_manual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY register_counsil_manual
    ADD CONSTRAINT register_counsil_manual_pkey PRIMARY KEY (id);


--
-- TOC entry 3795 (class 2606 OID 20887)
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- TOC entry 3797 (class 2606 OID 20889)
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3799 (class 2606 OID 20891)
-- Name: secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY secretary
    ADD CONSTRAINT secretary_pkey PRIMARY KEY (id);


--
-- TOC entry 3801 (class 2606 OID 20893)
-- Name: state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- TOC entry 3803 (class 2606 OID 20895)
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 20897)
-- Name: subprefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subprefecture
    ADD CONSTRAINT subprefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3808 (class 2606 OID 20899)
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3814 (class 2606 OID 20901)
-- Name: user_follow_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3816 (class 2606 OID 20903)
-- Name: user_follow_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_pkey PRIMARY KEY (id);


--
-- TOC entry 3810 (class 2606 OID 20905)
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3818 (class 2606 OID 20907)
-- Name: user_request_council_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_pkey PRIMARY KEY (id);


--
-- TOC entry 3822 (class 2606 OID 20909)
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 20911)
-- Name: user_session_api_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_api_key_key UNIQUE (api_key);


--
-- TOC entry 3827 (class 2606 OID 20913)
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- TOC entry 3812 (class 2606 OID 20915)
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


SET search_path = sqitch, pg_catalog;

--
-- TOC entry 3691 (class 2606 OID 18882)
-- Name: changes_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (change_id);


--
-- TOC entry 3693 (class 2606 OID 18884)
-- Name: changes_project_script_hash_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_script_hash_key UNIQUE (project, script_hash);


--
-- TOC entry 3699 (class 2606 OID 18920)
-- Name: dependencies_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (change_id, dependency);


--
-- TOC entry 3701 (class 2606 OID 18944)
-- Name: events_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (change_id, committed_at);


--
-- TOC entry 3687 (class 2606 OID 18870)
-- Name: projects_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project);


--
-- TOC entry 3689 (class 2606 OID 18872)
-- Name: projects_uri_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_uri_key UNIQUE (uri);


--
-- TOC entry 3685 (class 2606 OID 18861)
-- Name: releases_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (version);


--
-- TOC entry 3695 (class 2606 OID 18899)
-- Name: tags_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 3697 (class 2606 OID 18901)
-- Name: tags_project_tag_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_tag_key UNIQUE (project, tag);


SET search_path = public, pg_catalog;

--
-- TOC entry 3702 (class 1259 OID 20916)
-- Name: budget_goal_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX budget_goal_idx ON budget USING btree (goal_number);


--
-- TOC entry 3713 (class 1259 OID 20917)
-- Name: comment_approved_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_approved_idx ON comment_project USING btree (approved);


--
-- TOC entry 3759 (class 1259 OID 20918)
-- Name: fki_city_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_city_id_fkey ON organization USING btree (city_id);


--
-- TOC entry 3709 (class 1259 OID 20919)
-- Name: fki_country_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_country_id_fkey ON city USING btree (country_id);


--
-- TOC entry 3752 (class 1259 OID 20920)
-- Name: fki_organization_id_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_organization_id_fk ON management USING btree (organization_id);


--
-- TOC entry 3806 (class 1259 OID 20921)
-- Name: fki_organization_id_fk_id_organization; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_organization_id_fk_id_organization ON "user" USING btree (organization_id);


--
-- TOC entry 3710 (class 1259 OID 20922)
-- Name: fki_state_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_state_id_fkey ON city USING btree (state_id);


--
-- TOC entry 3736 (class 1259 OID 20923)
-- Name: goal_organization_goal_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_organization_goal_id_idx ON goal_organization USING btree (goal_id);


--
-- TOC entry 3737 (class 1259 OID 20924)
-- Name: goal_organization_organization_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_organization_organization_id_idx ON goal_organization USING btree (organization_id);


--
-- TOC entry 3742 (class 1259 OID 20925)
-- Name: goal_project_goal_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_project_goal_id_idx ON goal_project USING btree (goal_id);


--
-- TOC entry 3745 (class 1259 OID 20926)
-- Name: goal_project_project_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_project_project_id_idx ON goal_project USING btree (project_id);


--
-- TOC entry 3819 (class 1259 OID 20927)
-- Name: user_role_idx_role_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_role_idx_role_id ON user_role USING btree (role_id);


--
-- TOC entry 3820 (class 1259 OID 20928)
-- Name: user_role_idx_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_role_idx_user_id ON user_role USING btree (user_id);


--
-- TOC entry 3825 (class 1259 OID 20929)
-- Name: user_session_idx_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_session_idx_user_id ON user_session USING btree (user_id);


--
-- TOC entry 3838 (class 2606 OID 20930)
-- Name: budget_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- TOC entry 3839 (class 2606 OID 20935)
-- Name: budget_goal_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_goal_number_fkey FOREIGN KEY (goal_number) REFERENCES goal(id);


--
-- TOC entry 3840 (class 2606 OID 20940)
-- Name: campaign_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3841 (class 2606 OID 20945)
-- Name: campaign_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3842 (class 2606 OID 20950)
-- Name: campaign_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3843 (class 2606 OID 20955)
-- Name: campaign_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3875 (class 2606 OID 20960)
-- Name: city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- TOC entry 3846 (class 2606 OID 20965)
-- Name: comment_goal_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3847 (class 2606 OID 20970)
-- Name: comment_goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3848 (class 2606 OID 20975)
-- Name: comment_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_org_id_fkey FOREIGN KEY (org_id) REFERENCES organization(id);


--
-- TOC entry 3849 (class 2606 OID 20980)
-- Name: comment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3850 (class 2606 OID 20985)
-- Name: comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3851 (class 2606 OID 20990)
-- Name: company_documents_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company_documents
    ADD CONSTRAINT company_documents_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- TOC entry 3844 (class 2606 OID 20995)
-- Name: country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY city
    ADD CONSTRAINT country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- TOC entry 3852 (class 2606 OID 21000)
-- Name: district_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- TOC entry 3853 (class 2606 OID 21005)
-- Name: email_queue_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES "user"(id) ON DELETE CASCADE;


--
-- TOC entry 3854 (class 2606 OID 21010)
-- Name: event_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES campaign(id);


--
-- TOC entry 3855 (class 2606 OID 21015)
-- Name: event_council_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_council_id_fkey FOREIGN KEY (council_id) REFERENCES organization(id);


--
-- TOC entry 3856 (class 2606 OID 21020)
-- Name: event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3857 (class 2606 OID 21025)
-- Name: file_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- TOC entry 3858 (class 2606 OID 21030)
-- Name: goal_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- TOC entry 3859 (class 2606 OID 21035)
-- Name: goal_management_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_management_id_fkey FOREIGN KEY (management_id) REFERENCES management(id);


--
-- TOC entry 3860 (class 2606 OID 21040)
-- Name: goal_objective_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_objective_id FOREIGN KEY (objective_id) REFERENCES objective(id);


--
-- TOC entry 3862 (class 2606 OID 21045)
-- Name: goal_organization_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3863 (class 2606 OID 21050)
-- Name: goal_organization_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3864 (class 2606 OID 21055)
-- Name: goal_porcentage_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3865 (class 2606 OID 21060)
-- Name: goal_project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3866 (class 2606 OID 21065)
-- Name: goal_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3867 (class 2606 OID 21070)
-- Name: goal_secretary_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3868 (class 2606 OID 21075)
-- Name: goal_secretary_secretary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_secretary_id_fkey FOREIGN KEY (secretary_id) REFERENCES secretary(id);


--
-- TOC entry 3861 (class 2606 OID 21080)
-- Name: goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3869 (class 2606 OID 21085)
-- Name: images_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT images_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3871 (class 2606 OID 21090)
-- Name: invite_counsil_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3872 (class 2606 OID 21095)
-- Name: management_fk_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_fk_city_id FOREIGN KEY (city_id) REFERENCES city(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3874 (class 2606 OID 21100)
-- Name: milestones_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES project_types(id);


--
-- TOC entry 3873 (class 2606 OID 21105)
-- Name: organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management
    ADD CONSTRAINT organization_id_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3899 (class 2606 OID 21110)
-- Name: organization_id_fk_id_organization; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT organization_id_fk_id_organization FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3876 (class 2606 OID 21115)
-- Name: organization_organization_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_organization_type_id_fkey FOREIGN KEY (organization_type_id) REFERENCES organization_type(id);


--
-- TOC entry 3877 (class 2606 OID 21120)
-- Name: organization_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- TOC entry 3878 (class 2606 OID 21125)
-- Name: password_reset_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3879 (class 2606 OID 21130)
-- Name: progress_goal_counsil_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3883 (class 2606 OID 21135)
-- Name: project_accept_porcentage_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3884 (class 2606 OID 21140)
-- Name: project_accept_porcentage_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3885 (class 2606 OID 21145)
-- Name: project_event_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3887 (class 2606 OID 21150)
-- Name: project_event_read_project_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_project_event_id_fkey FOREIGN KEY (project_event_id) REFERENCES project_event(id);


--
-- TOC entry 3888 (class 2606 OID 21155)
-- Name: project_event_read_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3886 (class 2606 OID 21160)
-- Name: project_event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3880 (class 2606 OID 21165)
-- Name: project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3889 (class 2606 OID 21170)
-- Name: project_image_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3870 (class 2606 OID 21175)
-- Name: project_images_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3890 (class 2606 OID 21180)
-- Name: project_milestones_milestone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_milestone_fkey FOREIGN KEY (milestone) REFERENCES milestones(id);


--
-- TOC entry 3891 (class 2606 OID 21185)
-- Name: project_milestones_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3892 (class 2606 OID 21190)
-- Name: project_prefecture_prefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_prefecture_id_fkey FOREIGN KEY (prefecture_id) REFERENCES prefecture(id);


--
-- TOC entry 3893 (class 2606 OID 21195)
-- Name: project_prefecture_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3894 (class 2606 OID 21200)
-- Name: project_progress_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_milestone_id_fkey FOREIGN KEY (milestone_id) REFERENCES project_types(id);


--
-- TOC entry 3895 (class 2606 OID 21205)
-- Name: project_progress_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3881 (class 2606 OID 21210)
-- Name: project_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3896 (class 2606 OID 21215)
-- Name: project_region_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3897 (class 2606 OID 21220)
-- Name: project_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3882 (class 2606 OID 21225)
-- Name: project_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_type_fkey FOREIGN KEY (type) REFERENCES project_types(id);


--
-- TOC entry 3898 (class 2606 OID 21230)
-- Name: region_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- TOC entry 3845 (class 2606 OID 21235)
-- Name: state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY city
    ADD CONSTRAINT state_id_fkey FOREIGN KEY (state_id) REFERENCES state(id);


--
-- TOC entry 3900 (class 2606 OID 21240)
-- Name: user_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- TOC entry 3901 (class 2606 OID 21245)
-- Name: user_follow_counsil_counsil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_counsil_id_fkey FOREIGN KEY (counsil_id) REFERENCES organization(id);


--
-- TOC entry 3902 (class 2606 OID 21250)
-- Name: user_follow_counsil_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3903 (class 2606 OID 21255)
-- Name: user_follow_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3904 (class 2606 OID 21260)
-- Name: user_follow_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3905 (class 2606 OID 21265)
-- Name: user_request_council_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3906 (class 2606 OID 21270)
-- Name: user_request_council_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3907 (class 2606 OID 21275)
-- Name: user_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3908 (class 2606 OID 21280)
-- Name: user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3909 (class 2606 OID 21285)
-- Name: user_session_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


SET search_path = sqitch, pg_catalog;

--
-- TOC entry 3832 (class 2606 OID 18885)
-- Name: changes_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- TOC entry 3835 (class 2606 OID 18921)
-- Name: dependencies_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3836 (class 2606 OID 18926)
-- Name: dependencies_dependency_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_dependency_id_fkey FOREIGN KEY (dependency_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- TOC entry 3837 (class 2606 OID 18945)
-- Name: events_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- TOC entry 3834 (class 2606 OID 18907)
-- Name: tags_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- TOC entry 3833 (class 2606 OID 18902)
-- Name: tags_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2020-02-03 12:03:07 ART

--
-- PostgreSQL database dump complete
--

