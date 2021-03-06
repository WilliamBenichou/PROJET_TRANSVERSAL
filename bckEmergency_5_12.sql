PGDMP         (    	    
         x            emergencyReact     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     11.6 (Ubuntu 11.6-1.pgdg19.10+1) 7    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16547    emergencyReact    DATABASE     �   CREATE DATABASE "emergencyReact" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
     DROP DATABASE "emergencyReact";
             tp    false            �            1255    16548    set_dateend_incendie()    FUNCTION     �   CREATE FUNCTION public.set_dateend_incendie() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.intensity = 0 THEN
    NEW."dateFin" :=NOW();
  END IF;
  RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.set_dateend_incendie();
       public       tp    false            �            1259    16549 	   codeState    TABLE     R   CREATE TABLE public."codeState" (
    id integer NOT NULL,
    "libState" text
);
    DROP TABLE public."codeState";
       public         tp    false            �            1259    16555    codeState_id_seq    SEQUENCE     �   CREATE SEQUENCE public."codeState_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."codeState_id_seq";
       public       tp    false    196            �           0    0    codeState_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."codeState_id_seq" OWNED BY public."codeState".id;
            public       tp    false    197            �            1259    16557    fire    TABLE     �   CREATE TABLE public.fire (
    id integer NOT NULL,
    intensity integer,
    "dateSignalement" date DEFAULT now(),
    "dateFin" date,
    "idSensor" integer
);
    DROP TABLE public.fire;
       public         tp    false            �            1259    24855 
   fireSensor    TABLE     }   CREATE TABLE public."fireSensor" (
    id integer NOT NULL,
    longitude double precision,
    latitude double precision
);
     DROP TABLE public."fireSensor";
       public         tp    false            �            1259    24858    fireSensor_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireSensor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."fireSensor_id_seq";
       public       tp    false    206            �           0    0    fireSensor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."fireSensor_id_seq" OWNED BY public."fireSensor".id;
            public       tp    false    207            �            1259    16561    fireStation    TABLE     �   CREATE TABLE public."fireStation" (
    id integer NOT NULL,
    name text,
    longitude double precision,
    latitude double precision
);
 !   DROP TABLE public."fireStation";
       public         tp    false            �            1259    16567    fireStation_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireStation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."fireStation_id_seq";
       public       tp    false    199            �           0    0    fireStation_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."fireStation_id_seq" OWNED BY public."fireStation".id;
            public       tp    false    200            �            1259    16569 	   fireTruck    TABLE     �   CREATE TABLE public."fireTruck" (
    id integer NOT NULL,
    "intensityCapacity" integer,
    speed numeric,
    "fireStation" integer,
    state integer DEFAULT 1
);
    DROP TABLE public."fireTruck";
       public         tp    false            �            1259    16576    fireTruck_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireTruck_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."fireTruck_id_seq";
       public       tp    false    201            �           0    0    fireTruck_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."fireTruck_id_seq" OWNED BY public."fireTruck".id;
            public       tp    false    202            �            1259    16578    fire_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fire_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.fire_id_seq;
       public       tp    false    198            �           0    0    fire_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.fire_id_seq OWNED BY public.fire.id;
            public       tp    false    203            �            1259    16580    intervention    TABLE     �   CREATE TABLE public.intervention (
    "idFire" integer NOT NULL,
    "idFireTruck" integer NOT NULL,
    "dateStartIntervention" date,
    "dateEndIntervention" date
);
     DROP TABLE public.intervention;
       public         tp    false            �            1259    24873    truckTarget    VIEW     Z  CREATE VIEW public."truckTarget" AS
 SELECT ft.id,
    s.longitude,
    s.latitude
   FROM (((public."fireTruck" ft
     LEFT JOIN public.intervention i ON (((i."idFireTruck" = ft.id) AND (i."dateEndIntervention" IS NULL))))
     LEFT JOIN public.fire f ON ((f.id = i."idFire")))
     LEFT JOIN public."fireSensor" s ON ((f."idSensor" = s.id)));
     DROP VIEW public."truckTarget";
       public       tp    false    206    206    206    198    198    201    204    204    204            �            1259    16583 	   truckinfo    VIEW     �  CREATE VIEW public.truckinfo WITH (security_barrier='false') AS
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
       public       tp    false    204    204    204    201    201    201    199    199    199    199    196    196            +           2604    16588    codeState id    DEFAULT     p   ALTER TABLE ONLY public."codeState" ALTER COLUMN id SET DEFAULT nextval('public."codeState_id_seq"'::regclass);
 =   ALTER TABLE public."codeState" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    197    196            -           2604    16589    fire id    DEFAULT     b   ALTER TABLE ONLY public.fire ALTER COLUMN id SET DEFAULT nextval('public.fire_id_seq'::regclass);
 6   ALTER TABLE public.fire ALTER COLUMN id DROP DEFAULT;
       public       tp    false    203    198            1           2604    24860    fireSensor id    DEFAULT     r   ALTER TABLE ONLY public."fireSensor" ALTER COLUMN id SET DEFAULT nextval('public."fireSensor_id_seq"'::regclass);
 >   ALTER TABLE public."fireSensor" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    207    206            .           2604    16590    fireStation id    DEFAULT     t   ALTER TABLE ONLY public."fireStation" ALTER COLUMN id SET DEFAULT nextval('public."fireStation_id_seq"'::regclass);
 ?   ALTER TABLE public."fireStation" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    200    199            0           2604    16591    fireTruck id    DEFAULT     p   ALTER TABLE ONLY public."fireTruck" ALTER COLUMN id SET DEFAULT nextval('public."fireTruck_id_seq"'::regclass);
 =   ALTER TABLE public."fireTruck" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    202    201            �          0    16549 	   codeState 
   TABLE DATA               5   COPY public."codeState" (id, "libState") FROM stdin;
    public       tp    false    196   s=       �          0    16557    fire 
   TABLE DATA               W   COPY public.fire (id, intensity, "dateSignalement", "dateFin", "idSensor") FROM stdin;
    public       tp    false    198   �=       �          0    24855 
   fireSensor 
   TABLE DATA               ?   COPY public."fireSensor" (id, longitude, latitude) FROM stdin;
    public       tp    false    206   �=       �          0    16561    fireStation 
   TABLE DATA               F   COPY public."fireStation" (id, name, longitude, latitude) FROM stdin;
    public       tp    false    199   '?       �          0    16569 	   fireTruck 
   TABLE DATA               [   COPY public."fireTruck" (id, "intensityCapacity", speed, "fireStation", state) FROM stdin;
    public       tp    false    201   �?       �          0    16580    intervention 
   TABLE DATA               o   COPY public.intervention ("idFire", "idFireTruck", "dateStartIntervention", "dateEndIntervention") FROM stdin;
    public       tp    false    204   �?       �           0    0    codeState_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."codeState_id_seq"', 3, true);
            public       tp    false    197            �           0    0    fireSensor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."fireSensor_id_seq"', 1, false);
            public       tp    false    207            �           0    0    fireStation_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."fireStation_id_seq"', 2, true);
            public       tp    false    200            �           0    0    fireTruck_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."fireTruck_id_seq"', 14, true);
            public       tp    false    202            �           0    0    fire_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.fire_id_seq', 32, true);
            public       tp    false    203            >           2606    16593    intervention Intervention_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT "Intervention_pkey" PRIMARY KEY ("idFire", "idFireTruck");
 J   ALTER TABLE ONLY public.intervention DROP CONSTRAINT "Intervention_pkey";
       public         tp    false    204    204            3           2606    16595    codeState codeState_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."codeState"
    ADD CONSTRAINT "codeState_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."codeState" DROP CONSTRAINT "codeState_pkey";
       public         tp    false    196            B           2606    24865    fireSensor fireSensor_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."fireSensor"
    ADD CONSTRAINT "fireSensor_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."fireSensor" DROP CONSTRAINT "fireSensor_pkey";
       public         tp    false    206            8           2606    16597    fireStation fireStation_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."fireStation"
    ADD CONSTRAINT "fireStation_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."fireStation" DROP CONSTRAINT "fireStation_pkey";
       public         tp    false    199            :           2606    16599    fireTruck fireTruck_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fireTruck_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fireTruck_pkey";
       public         tp    false    201            5           2606    16601    fire fire_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.fire
    ADD CONSTRAINT fire_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.fire DROP CONSTRAINT fire_pkey;
       public         tp    false    198            6           1259    24871    fki_fk__fireSensor    INDEX     K   CREATE INDEX "fki_fk__fireSensor" ON public.fire USING btree ("idSensor");
 (   DROP INDEX public."fki_fk__fireSensor";
       public         tp    false    198            ;           1259    16602    fki_fk_codeState    INDEX     K   CREATE INDEX "fki_fk_codeState" ON public."fireTruck" USING btree (state);
 &   DROP INDEX public."fki_fk_codeState";
       public         tp    false    201            ?           1259    24891    fki_fk_fire    INDEX     H   CREATE INDEX fki_fk_fire ON public.intervention USING btree ("idFire");
    DROP INDEX public.fki_fk_fire;
       public         tp    false    204            <           1259    16603    fki_fk_fireStation    INDEX     U   CREATE INDEX "fki_fk_fireStation" ON public."fireTruck" USING btree ("fireStation");
 (   DROP INDEX public."fki_fk_fireStation";
       public         tp    false    201            @           1259    16604    fki_fk_fireTruck    INDEX     T   CREATE INDEX "fki_fk_fireTruck" ON public.intervention USING btree ("idFireTruck");
 &   DROP INDEX public."fki_fk_fireTruck";
       public         tp    false    204            G           2620    16605    fire trigger_dateend_incendie    TRIGGER     �   CREATE TRIGGER trigger_dateend_incendie BEFORE UPDATE ON public.fire FOR EACH ROW EXECUTE PROCEDURE public.set_dateend_incendie();
 6   DROP TRIGGER trigger_dateend_incendie ON public.fire;
       public       tp    false    198    209            C           2606    24866    fire fk__fireSensor    FK CONSTRAINT     �   ALTER TABLE ONLY public.fire
    ADD CONSTRAINT "fk__fireSensor" FOREIGN KEY ("idSensor") REFERENCES public."fireSensor"(id) NOT VALID;
 ?   ALTER TABLE ONLY public.fire DROP CONSTRAINT "fk__fireSensor";
       public       tp    false    2882    206    198            F           2606    24886    intervention fk_fire    FK CONSTRAINT     �   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT fk_fire FOREIGN KEY ("idFire") REFERENCES public.fire(id) ON DELETE CASCADE NOT VALID;
 >   ALTER TABLE ONLY public.intervention DROP CONSTRAINT fk_fire;
       public       tp    false    2869    204    198            D           2606    16616    fireTruck fk_fireStation    FK CONSTRAINT     �   ALTER TABLE ONLY public."fireTruck"
    ADD CONSTRAINT "fk_fireStation" FOREIGN KEY ("fireStation") REFERENCES public."fireStation"(id) NOT VALID;
 F   ALTER TABLE ONLY public."fireTruck" DROP CONSTRAINT "fk_fireStation";
       public       tp    false    201    2872    199            E           2606    16621    intervention fk_fireTruck    FK CONSTRAINT     �   ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT "fk_fireTruck" FOREIGN KEY ("idFireTruck") REFERENCES public."fireTruck"(id) NOT VALID;
 E   ALTER TABLE ONLY public.intervention DROP CONSTRAINT "fk_fireTruck";
       public       tp    false    201    2874    204            �   9   x�3�L�,.���L�I�2�L�S��+I-*K�+����2����$&��Ÿb���� �Q+      �   "   x�36�4�4202�50�54����4����� :�,      �   )  x�}�[
!��纘�K�e/��:Z:�'��(D�Iy�5[�S�����F/U�˩�n)��3l7�q�����*G�[�be-G�o9���cˡV���r�<5?�<}�r�}�<ʒ7]��?��K���W}�R���H(y$�<J	%���GB�#���� Q12��7BDBTBdBtB�B�B�ڂVHy,�f��J��r��r��r��r��r��r��r��B*<��A,۵Jeiiiiii����X�v]+)��$��(��(��(��(��(��(����XH�WJ�6��      �   f   x�3�tN,N-�KUHIU���I--JJ��K�4ѳ0��05�4�c#NS=sK#K���2B6��2?������� �����������*fn����� ��P      �   -   x�34��!#N.K(ېӐ��.a�e�0�24AR���� ���      �   #   x�36���".c#N���me��qqq ��	Z     