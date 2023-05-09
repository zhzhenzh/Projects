--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (3, 'user_1683567825921', 4, 643);
INSERT INTO public.users VALUES (2, 'user_1683567825922', 8, 119);
INSERT INTO public.users VALUES (5, 'user_1683568012821', 4, 389);
INSERT INTO public.users VALUES (4, 'user_1683568012822', 8, 10);
INSERT INTO public.users VALUES (7, 'user_1683568085065', 4, 137);
INSERT INTO public.users VALUES (6, 'user_1683568085066', 8, 109);
INSERT INTO public.users VALUES (8, 'user_1683620735094', NULL, NULL);
INSERT INTO public.users VALUES (10, 'user_1683620735093', NULL, NULL);
INSERT INTO public.users VALUES (20, 'user_1683621545203', 6, 105);
INSERT INTO public.users VALUES (1, 'Gina', 3, 15);
INSERT INTO public.users VALUES (11, 'user_1683620824527', NULL, NULL);
INSERT INTO public.users VALUES (12, 'user_1683620824526', NULL, NULL);
INSERT INTO public.users VALUES (14, 'user_1683621331185', 2, 894);
INSERT INTO public.users VALUES (23, 'user_1683621801212', 4, 635);
INSERT INTO public.users VALUES (13, 'user_1683621331186', 8, 133);
INSERT INTO public.users VALUES (22, 'user_1683621801213', 8, 195);
INSERT INTO public.users VALUES (17, 'user_1683621406463', 2, 846);
INSERT INTO public.users VALUES (16, 'user_1683621406464', 10, 185);
INSERT INTO public.users VALUES (25, 'user_1683622135005', 2, 837);
INSERT INTO public.users VALUES (19, 'user_1683621445399', 2, 841);
INSERT INTO public.users VALUES (24, 'user_1683622135006', 10, 153);
INSERT INTO public.users VALUES (26, 'Sam', NULL, NULL);
INSERT INTO public.users VALUES (18, 'user_1683621445400', 8, 371);
INSERT INTO public.users VALUES (15, 'Ken', 1, 14);
INSERT INTO public.users VALUES (28, 'user_1683622600067', 4, 447);
INSERT INTO public.users VALUES (21, 'user_1683621545202', 4, 738);
INSERT INTO public.users VALUES (27, 'user_1683622600068', 5, 262);
INSERT INTO public.users VALUES (30, 'user_1683623069108', 4, 733);
INSERT INTO public.users VALUES (29, 'user_1683623069109', 9, 344);
INSERT INTO public.users VALUES (33, 'user_1683623308994', 1, 327);
INSERT INTO public.users VALUES (32, 'user_1683623308995', 4, 490);
INSERT INTO public.users VALUES (31, 'Lo', 1, 11);
INSERT INTO public.users VALUES (34, 'user_1683623626889', NULL, NULL);
INSERT INTO public.users VALUES (35, 'user_1683623626888', NULL, NULL);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 35, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

