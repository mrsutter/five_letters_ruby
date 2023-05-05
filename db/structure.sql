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
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    attempts_count integer DEFAULT 0 NOT NULL,
    state character varying DEFAULT 'active'::character varying NOT NULL,
    user_id uuid NOT NULL,
    word_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT cr_games_state CHECK (((state)::text = ANY ((ARRAY['active'::character varying, 'wasted'::character varying, 'won'::character varying])::text[])))
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
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    jti character varying NOT NULL,
    type character varying NOT NULL,
    expired_at timestamp(6) without time zone NOT NULL,
    user_id uuid NOT NULL,
    refresh_token_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT cr_tokens_refresh_token_presence CHECK ((NOT (((type)::text = 'Tokens::AccessToken'::text) AND (refresh_token_id IS NULL))))
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying NOT NULL,
    password_digest character varying NOT NULL,
    game_available_at timestamp(6) without time zone NOT NULL,
    language_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
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
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


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
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: index_games_active_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_games_active_on_user_id ON public.games USING btree (user_id) WHERE ((state)::text = 'active'::text);


--
-- Name: index_games_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_games_on_user_id ON public.games USING btree (user_id);


--
-- Name: index_games_on_word_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_games_on_word_id ON public.games USING btree (word_id);


--
-- Name: index_languages_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_slug ON public.languages USING btree (slug);


--
-- Name: index_tokens_on_refresh_token_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tokens_on_refresh_token_id ON public.tokens USING btree (refresh_token_id);


--
-- Name: index_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tokens_on_user_id ON public.tokens USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_language_id ON public.users USING btree (language_id);


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
-- Name: users fk_rails_45f4f12508; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_45f4f12508 FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: games fk_rails_5dc53fe1dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_rails_5dc53fe1dd FOREIGN KEY (word_id) REFERENCES public.words(id);


--
-- Name: tokens fk_rails_ac8a5d0441; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT fk_rails_ac8a5d0441 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: words fk_rails_b80de9677b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT fk_rails_b80de9677b FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: games fk_rails_de9e6ea7f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_rails_de9e6ea7f7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tokens fk_rails_ea4a6c68e1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT fk_rails_ea4a6c68e1 FOREIGN KEY (refresh_token_id) REFERENCES public.tokens(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230504060106'),
('20230504121044'),
('20230504124615'),
('20230505033630'),
('20230505041410'),
('20230505045700'),
('20230505051244'),
('20230505053135');


