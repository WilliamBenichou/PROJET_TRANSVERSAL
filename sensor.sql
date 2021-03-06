PGDMP         '    	             x         	   simulator     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16626 	   simulator    DATABASE     {   CREATE DATABASE simulator WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
    DROP DATABASE simulator;
             tp    false            �            1259    24826 
   fireSensor    TABLE     }   CREATE TABLE public."fireSensor" (
    latitude double precision,
    longitude double precision,
    id integer NOT NULL
);
     DROP TABLE public."fireSensor";
       public         tp    false            �            1259    24843    fireSensor_id_seq    SEQUENCE     �   CREATE SEQUENCE public."fireSensor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."fireSensor_id_seq";
       public       tp    false    200            �           0    0    fireSensor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."fireSensor_id_seq" OWNED BY public."fireSensor".id;
            public       tp    false    201                       2604    24845    fireSensor id    DEFAULT     r   ALTER TABLE ONLY public."fireSensor" ALTER COLUMN id SET DEFAULT nextval('public."fireSensor_id_seq"'::regclass);
 >   ALTER TABLE public."fireSensor" ALTER COLUMN id DROP DEFAULT;
       public       tp    false    201    200            �          0    24826 
   fireSensor 
   TABLE DATA               ?   COPY public."fireSensor" (latitude, longitude, id) FROM stdin;
    public       tp    false    200   �
       �           0    0    fireSensor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."fireSensor_id_seq"', 60, true);
            public       tp    false    201                       2606    24850    fireSensor fireSensor_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."fireSensor"
    ADD CONSTRAINT "fireSensor_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."fireSensor" DROP CONSTRAINT "fireSensor_pkey";
       public         tp    false    200            �     x�u�Q
� E�ﺘbk�v/��uL-�`����\��^J�v����|o���lۑl�g�t����z[�2���V����c��}�m���|��+��g���\�x���W��3.Wy�e�6�k;0M��&J�%׉��D�}��@Qr�(9Q�''��,7�F"9�P�$�3	�NB9�P.%�S	�V���3��b,�K(�ʱ�r,�K(�ʱ�r�H�c�뛼)�ɱ�r,�K(�ʱ�r,�K(Ǌ�9Vy}�7�X"9�P�%�c	�XB9�P�%�c	�X�֜>{J��~��     