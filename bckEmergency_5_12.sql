PGDMP     #                    w            emergencyReact     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     11.6 (Ubuntu 11.6-1.pgdg19.10+1) +    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16507    emergencyReact    DATABASE     �   CREATE DATABASE "emergencyReact" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
     DROP DATABASE "emergencyReact";
             tp    false            �            1259    16545 	   codeState    TABLE     R   CREATE TABLE public."codeState" (
    id integer NOT NULL,
    "libState" text
);
    DROP TABLE public."codeState";
       public         tp    false            �            1259    16543    codeState_id_seq    SEQUENCE     �   CREATE SEQUENCE public."codeState_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."codeState_id_seq";
       public       tp    false    202            �           0    0    codeState_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."codeState_id_seq" OWNED BY public."codeState".id;
            public       tp    false    201            �            1259    16510    fire    TABLE     �   CREATE TABLE public.fire (
    id integer NOT NULL,
    x integer,
    y integer,
    intensity integer,
    "dateSignalement" date DEFAULT now(),
    "dateFin" date
);
    DROP TABLE public.fire;
       public         tp    false            �            1259    16556    fireStation    TABLE     �   CREATE TABLE public."fireStation" (
    id integer NOT NULL,
    name text,
    longitude double precision,
    latitude double precision
);
 !   DROP TABLE public."fireStation";
       public         tp    false            �            1259    16554    fireStation_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireStation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."fireStation_id_seq";
       public       tp    false    204            �           0    0    fireStation_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."fireStation_id_seq" OWNED BY public."fireStation".id;
            public       tp    false    203            �            1259    16528 	   fireTruck    TABLE     �   CREATE TABLE public."fireTruck" (
    id integer NOT NULL,
    "intensityCapacity" integer,
    speed numeric,
    "fireStation" integer,
    state integer DEFAULT 1
);
    DROP TABLE public."fireTruck";
       public         tp    false            �            1259    16526    fireTruck_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireTruck_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."fireTruck_id_seq";
       public       tp    false    200            �           0    0    fireTruck_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."fireTruck_id_seq" OWNED BY public."fireTruck".id;
            public       tp    false    199            �            1259    16508    fire_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fire_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.fire_id_seq;
       public       tp    false    197            �           0    0    fire_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.fire_id_seq OWNED BY public.fire.id;
            public       tp    false    196            �            1259    16516    intervention    TABLE     �   CREATE TABLE public.intervention (
    "idFire" integer NOT NULL,
    "idFireTruck" integer NOT NULL,
    "dateStartIntervention" date,
    "dateEndIntervention" date
);
     DROP TABLE public.intervention;
       public         tp    false            �            1259    24680 	   truckinfo    VIEW     �  CREATE VIEW public.truckinfo WITH (security_barrier='false') AS
 SELECT ft.id AS "fireTruckID",
    ft.state,
    fs.id AS "fireStationID",
    fs.name,
    s.id AS "stateID",
    s."libState",
    i."idFire",
    fs.latitude,
    fs.longitude
   FROM (((public."fireTruck" ft
     JOIN public."codeState" s ON ((ft.state = s.id)))
     JOIN public."fireStation" fs ON ((ft."fireStation" = fs.id)))
     LEFT JOIN public.intervention i ON (((ft.id = i."idFireTruck") AND (i."dateEndIntervention" IS NULL))));
    DROP VIEW public.truckinfo;
       public       tp    false    198    202    200    200    200    198    198    204    204    204    204    202            $           2604    24675    codeState id    DEFAULT     p   ALTER TABLE ONLY public."codeState" ALTER COLUMN id SET DEFAULT nextval('public."codeState_id_seq"'::regclass);
 =   ALTER TABLE public."codeState" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    201    202    202                        2604    24676    fire id    DEFAULT     b   ALTER TABLE ONLY public.fire ALTER COLUMN id SET DEFAULT nextval('public.fire_id_seq'::regclass);
 6   ALTER TABLE public.fire ALTER COLUMN id DROP DEFAULT;
       public       tp    false    196    197    197            %           2604    24677    fireStation id    DEFAULT     t   ALTER TABLE ONLY public."fireStation" ALTER COLUMN id SET DEFAULT nextval('public."fireStation_id_seq"'::regclass);
 ?   ALTER TABLE public."fireStation" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    203    204    204            "           2604    24678    fireTruck id    DEFAULT     p   ALTER TABLE ONLY public."fireTruck" ALTER COLUMN id SET DEFAULT nextval('public."fireTruck_id_seq"'::regclass);
 =   ALTER TABLE public."fireTruck" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    200    199    200            �          0    16545 	   codeState 
   TABLE DATA               5   COPY public."codeState" (id, "libState") FROM stdin;
    public       tp    false    202   d/       �          0    16510    fire 
   TABLE DATA               Q   COPY public.fire (id, x, y, intensity, "dateSignalement", "dateFin") FROM stdin;
    public       tp    false    197   �/       �          0    16556    fireStation 
   TABLE DATA               F   COPY public."fireStation" (id, name, longitude, latitude) FROM stdin;
    public       tp    false    204   �/       �          0    16528 	   fireTruck 
   TABLE DATA               [   COPY public."fireTruck" (id, "intensityCapacity", speed, "fireStation", state) FROM stdin;
    public       tp    false    200   U0       �          0    16516    intervention 
   TABLE DATA               o   COPY public.intervention ("idFire", "idFireTruck", "dateStartIntervention", "dateEndIntervention") FROM stdin;
    public       tp    false    198   �0       �           0    0    codeState_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."codeState_id_seq"', 3, true);
            public       tp    false    201            �           0    0    fireStation_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."fireStation_id_seq"', 2, true);
            public       tp    false    203            �           0    0    fireTruck_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."fireTruck_id_seq"', 12, true);
            public       tp    false    199            �           0    0    fire_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.fire_id_seq', 2, true);
            public       tp    false    196            )           2606    16520    intervention Intervention_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT "Intervention_pkey" PRIMARY KEY ("idFire", "idFireTruck");
 J   ALTER TABLE ONLY public.intervention DROP CONSTRAINT "Intervention_pkey";
       public         tp    false    198    198            0           2606    16553    codeState codeState_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."codeState"
    ADD CONSTRAINT "codeState_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."codeState" DROP CONSTRAINT "codeState_pkey";
       public         tp    false    202            2           2606    16564    fireStation fireStation_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."fireStation"
    ADD CONSTRAINT "fireStation_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."fireStation" DROP CONSTRAINT "fireStation_pkey";
       public         tp    false    204            ,           2606    16536    fireTruck fireTruck_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fireTruck_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fireTruck_pkey";
       public         tp    false    200            '           2606    16515    fire fire_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.fire
    ADD CONSTRAINT fire_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.fire DROP CONSTRAINT fire_pkey;
       public         tp    false    197            -           1259    16576    fki_fk_codeState    INDEX     K   CREATE INDEX "fki_fk_codeState" ON public."fireTruck" USING btree (state);
 &   DROP INDEX public."fki_fk_codeState";
       public         tp    false    200            .           1259    16570    fki_fk_fireStation    INDEX     U   CREATE INDEX "fki_fk_fireStation" ON public."fireTruck" USING btree ("fireStation");
 (   DROP INDEX public."fki_fk_fireStation";
       public         tp    false    200            *           1259    16542    fki_fk_fireTruck    INDEX     T   CREATE INDEX "fki_fk_fireTruck" ON public.intervention USING btree ("idFireTruck");
 &   DROP INDEX public."fki_fk_fireTruck";
       public         tp    false    198            6           2606    16571    fireTruck fk_codeState    FK CONSTRAINT     �   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fk_codeState" FOREIGN KEY (state) REFERENCES public."codeState"(id) NOT VALID;
 D   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fk_codeState";
       public       tp    false    200    202    2864            3           2606    16521    intervention fk_fire    FK CONSTRAINT     s   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT fk_fire FOREIGN KEY ("idFire") REFERENCES public.fire(id);
 >   ALTER TABLE ONLY public.intervention DROP CONSTRAINT fk_fire;
       public       tp    false    2855    197    198            5           2606    16565    fireTruck fk_fireStation    FK CONSTRAINT     �   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fk_fireStation" FOREIGN KEY ("fireStation") REFERENCES public."fireStation"(id) NOT VALID;
 F   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fk_fireStation";
       public       tp    false    2866    200    204            4           2606    16537    intervention fk_fireTruck    FK CONSTRAINT     �   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT "fk_fireTruck" FOREIGN KEY ("idFireTruck") REFERENCES public."fireTruck"(id) NOT VALID;
 E   ALTER TABLE ONLY public.intervention DROP CONSTRAINT "fk_fireTruck";
       public       tp    false    198    2860    200            �   9   x�3�L�,.���L�I�2�L�S��+I-*K�+����2����$&��Ÿb���� ��.      �   #   x�3�4�4��420��54�5��������� ;�O      �   e   x�3�tN,N-�KUHIU���I--JJ��K�41�3�01�42�� KN=3KSK(06�2B6��2?���������������� *dif����� �6P      �   (   x����!CNC.8ۘ���1�4�24�s��b���� I	v      �      x�3����".#NCC(3F��� @��     