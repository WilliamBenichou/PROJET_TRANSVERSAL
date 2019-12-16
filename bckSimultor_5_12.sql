PGDMP     9                    w         	   simulator     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16440 	   simulator    DATABASE     {   CREATE DATABASE simulator WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
    DROP DATABASE simulator;
             tp    false            �            1255    16538    trigger_set_timestamp()    FUNCTION     �   CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.last_modified = NOW();
  RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.trigger_set_timestamp();
       public       tp    false            �            1259    16441    fire    TABLE     �   CREATE TABLE public.fire (
    id integer NOT NULL,
    x integer,
    y integer,
    intensity integer,
    last_modified timestamp without time zone DEFAULT now(),
    last_modified2 time without time zone DEFAULT now()
);
    DROP TABLE public.fire;
       public         tp    false            �            1259    16444 	   fireTruck    TABLE     [   CREATE TABLE public."fireTruck" (
    id integer NOT NULL,
    x integer,
    y integer
);
    DROP TABLE public."fireTruck";
       public         tp    false            �            1259    16447    fireTruck_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireTruck_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."fireTruck_id_seq";
       public       tp    false    197            �           0    0    fireTruck_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."fireTruck_id_seq" OWNED BY public."fireTruck".id;
            public       tp    false    198            �            1259    16449    fire_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fire_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.fire_id_seq;
       public       tp    false    196            �           0    0    fire_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.fire_id_seq OWNED BY public.fire.id;
            public       tp    false    199            
           2604    16451    fire id    DEFAULT     b   ALTER TABLE ONLY public.fire ALTER COLUMN id SET DEFAULT nextval('public.fire_id_seq'::regclass);
 6   ALTER TABLE public.fire ALTER COLUMN id DROP DEFAULT;
       public       tp    false    199    196                       2604    16452    fireTruck id    DEFAULT     p   ALTER TABLE ONLY public."fireTruck" ALTER COLUMN id SET DEFAULT nextval('public."fireTruck_id_seq"'::regclass);
 =   ALTER TABLE public."fireTruck" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    198    197            �          0    16441    fire 
   TABLE DATA               R   COPY public.fire (id, x, y, intensity, last_modified, last_modified2) FROM stdin;
    public       tp    false    196   �       �          0    16444 	   fireTruck 
   TABLE DATA               /   COPY public."fireTruck" (id, x, y) FROM stdin;
    public       tp    false    197   5       �           0    0    fireTruck_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."fireTruck_id_seq"', 1, false);
            public       tp    false    198            �           0    0    fire_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.fire_id_seq', 8, true);
            public       tp    false    199                       2606    16454    fireTruck fireTruck_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fireTruck_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fireTruck_pkey";
       public         tp    false    197                       2606    16456    fire fire_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.fire
    ADD CONSTRAINT fire_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.fire DROP CONSTRAINT fire_pkey;
       public         tp    false    196                       2620    16546    fire set_timestamp    TRIGGER     y   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.fire FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 +   DROP TRIGGER set_timestamp ON public.fire;
       public       tp    false    196    200            �   D   x�]˱ !���d����b�u�1��v��&������ʣ,e����9	o��gzሺ!���
3�3      �      x������ � �     