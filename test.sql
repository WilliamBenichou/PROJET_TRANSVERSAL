PGDMP                         w            postgres     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    13145    postgres    DATABASE     z   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
    DROP DATABASE postgres;
             postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                  postgres    false    2951            �            1259    16470    test    TABLE     D   CREATE TABLE public.test (
    id integer NOT NULL,
    lib text
);
    DROP TABLE public.test;
       public         tp    false            �            1259    16468    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public       tp    false    197            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
            public       tp    false    196                       2604    16473    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public       tp    false    197    196    197            �          0    16470    test 
   TABLE DATA               '   COPY public.test (id, lib) FROM stdin;
    public       tp    false    197   �
       �           0    0    test_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.test_id_seq', 17, true);
            public       tp    false    196                       2606    16478    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public         tp    false    197            �   T   x�M�1@0����)��X��̤H���6�V?�,%w��]œ8�]�I<�1=ԣij��[�k��z��`��߰� ^��=�     