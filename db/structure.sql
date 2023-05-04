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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    slug character varying NOT NULL,
    name character varying NOT NULL,
    letters character varying NOT NULL,
    available boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: words; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.words (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    language_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT cr_words_name_length CHECK ((length((name)::text) = 5))
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: index_languages_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_slug ON public.languages USING btree (slug);


--
-- Name: index_words_on_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_words_on_language_id ON public.words USING btree (language_id);


--
-- Name: index_words_on_language_id_and_archived; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_words_on_language_id_and_archived ON public.words USING btree (language_id, archived);


--
-- Name: index_words_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_words_on_name ON public.words USING btree (name);


--
-- Name: index_words_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_words_on_updated_at ON public.words USING btree (updated_at);


--
-- Name: words fk_rails_b80de9677b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT fk_rails_b80de9677b FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230504060106'),
('20230504121044'),
('20230504124615');


