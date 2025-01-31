PGDMP  :            
        |           bdveterinaria    16.4    16.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    17804    bdveterinaria    DATABASE     �   CREATE DATABASE bdveterinaria WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Paraguay.1252';
    DROP DATABASE bdveterinaria;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false                       0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    5            �            1259    17805    agendamiento    TABLE     �   CREATE TABLE public.agendamiento (
    idagendamiento integer NOT NULL,
    "fecha " date NOT NULL,
    hora timestamp with time zone NOT NULL,
    idclientes integer NOT NULL,
    iddoctores integer NOT NULL,
    idpaciente integer NOT NULL
);
     DROP TABLE public.agendamiento;
       public         heap    postgres    false    5            �            1259    17808    agendamiento_idagendamiento_seq    SEQUENCE     �   CREATE SEQUENCE public.agendamiento_idagendamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.agendamiento_idagendamiento_seq;
       public          postgres    false    215    5            	           0    0    agendamiento_idagendamiento_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.agendamiento_idagendamiento_seq OWNED BY public.agendamiento.idagendamiento;
          public          postgres    false    216            �            1259    17809    agendamiento_idclientes_seq    SEQUENCE     �   CREATE SEQUENCE public.agendamiento_idclientes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.agendamiento_idclientes_seq;
       public          postgres    false    5    215            
           0    0    agendamiento_idclientes_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.agendamiento_idclientes_seq OWNED BY public.agendamiento.idclientes;
          public          postgres    false    217            �            1259    17810    agendamiento_iddoctores_seq    SEQUENCE     �   CREATE SEQUENCE public.agendamiento_iddoctores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.agendamiento_iddoctores_seq;
       public          postgres    false    215    5                       0    0    agendamiento_iddoctores_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.agendamiento_iddoctores_seq OWNED BY public.agendamiento.iddoctores;
          public          postgres    false    218            �            1259    17811    agendamiento_idpaciente_seq    SEQUENCE     �   CREATE SEQUENCE public.agendamiento_idpaciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.agendamiento_idpaciente_seq;
       public          postgres    false    215    5                       0    0    agendamiento_idpaciente_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.agendamiento_idpaciente_seq OWNED BY public.agendamiento.idpaciente;
          public          postgres    false    219            �            1259    17812 	   aperturas    TABLE     �   CREATE TABLE public.aperturas (
    idaperturas integer NOT NULL,
    ape_fecha date NOT NULL,
    ape_monto integer NOT NULL,
    ape_estado character varying DEFAULT 'ABIERTA'::character varying NOT NULL,
    idusuarios integer NOT NULL
);
    DROP TABLE public.aperturas;
       public         heap    postgres    false    5            �            1259    17818    aperturas_idaperturas_seq    SEQUENCE     �   CREATE SEQUENCE public.aperturas_idaperturas_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.aperturas_idaperturas_seq;
       public          postgres    false    5    220                       0    0    aperturas_idaperturas_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.aperturas_idaperturas_seq OWNED BY public.aperturas.idaperturas;
          public          postgres    false    221            �            1259    17819    aperturas_idusuarios_seq    SEQUENCE     �   CREATE SEQUENCE public.aperturas_idusuarios_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.aperturas_idusuarios_seq;
       public          postgres    false    220    5                       0    0    aperturas_idusuarios_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.aperturas_idusuarios_seq OWNED BY public.aperturas.idusuarios;
          public          postgres    false    222            �            1259    17820    bancos    TABLE     \   CREATE TABLE public.bancos (
    idbancos integer NOT NULL,
    nombre character varying
);
    DROP TABLE public.bancos;
       public         heap    postgres    false    5            �            1259    17825    bancos_idbancos_seq    SEQUENCE     �   CREATE SEQUENCE public.bancos_idbancos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.bancos_idbancos_seq;
       public          postgres    false    223    5                       0    0    bancos_idbancos_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.bancos_idbancos_seq OWNED BY public.bancos.idbancos;
          public          postgres    false    224            �            1259    17826    cierre    TABLE     �   CREATE TABLE public.cierre (
    idcierre integer NOT NULL,
    cie_fecha date NOT NULL,
    cie_monto integer NOT NULL,
    idaperturas integer NOT NULL
);
    DROP TABLE public.cierre;
       public         heap    postgres    false    5            �            1259    17829    ciudades    TABLE     k   CREATE TABLE public.ciudades (
    idciudad integer NOT NULL,
    ciu_nombre character varying NOT NULL
);
    DROP TABLE public.ciudades;
       public         heap    postgres    false    5            �            1259    17834    ciudades_idciudad_seq    SEQUENCE     �   CREATE SEQUENCE public.ciudades_idciudad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.ciudades_idciudad_seq;
       public          postgres    false    5    226                       0    0    ciudades_idciudad_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.ciudades_idciudad_seq OWNED BY public.ciudades.idciudad;
          public          postgres    false    227            �            1259    17835    clientes    TABLE     �   CREATE TABLE public.clientes (
    idclientes integer NOT NULL,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    ci character varying NOT NULL,
    idciudad integer NOT NULL,
    telefono character varying NOT NULL
);
    DROP TABLE public.clientes;
       public         heap    postgres    false    5            �            1259    17840    clientes_idciudad_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_idciudad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.clientes_idciudad_seq;
       public          postgres    false    228    5                       0    0    clientes_idciudad_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.clientes_idciudad_seq OWNED BY public.clientes.idciudad;
          public          postgres    false    229            �            1259    17841    clientes_idclientes_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_idclientes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.clientes_idclientes_seq;
       public          postgres    false    5    228                       0    0    clientes_idclientes_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.clientes_idclientes_seq OWNED BY public.clientes.idclientes;
          public          postgres    false    230            �            1259    17842    consulta    TABLE     �  CREATE TABLE public.consulta (
    idconsulta integer NOT NULL,
    fecha date,
    total character varying DEFAULT 100000,
    estado character varying DEFAULT 'PENDIENTE'::character varying,
    idclientes integer,
    idusuarios integer,
    iddoctores integer,
    hora time without time zone,
    idempresa integer DEFAULT 1,
    numero character varying,
    condicion character varying DEFAULT 'CONTADO'::character varying,
    idmetodo integer,
    idbanco integer
);
    DROP TABLE public.consulta;
       public         heap    postgres    false    5            �            1259    17851    consulta_idconsulta_seq    SEQUENCE     �   CREATE SEQUENCE public.consulta_idconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.consulta_idconsulta_seq;
       public          postgres    false    231    5                       0    0    consulta_idconsulta_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.consulta_idconsulta_seq OWNED BY public.consulta.idconsulta;
          public          postgres    false    232            �            1259    17852    detalleconsulta    TABLE     .  CREATE TABLE public.detalleconsulta (
    iddetalleconsulta integer NOT NULL,
    idconsulta integer,
    precio character varying,
    idpacientes integer,
    idsintomas integer,
    recetas character varying,
    idmedicamentos integer,
    iva integer DEFAULT 10,
    cantidad integer DEFAULT 1
);
 #   DROP TABLE public.detalleconsulta;
       public         heap    postgres    false    5            �            1259    17859 %   detalleconsulta_iddetalleconsulta_seq    SEQUENCE     �   CREATE SEQUENCE public.detalleconsulta_iddetalleconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.detalleconsulta_iddetalleconsulta_seq;
       public          postgres    false    5    233                       0    0 %   detalleconsulta_iddetalleconsulta_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.detalleconsulta_iddetalleconsulta_seq OWNED BY public.detalleconsulta.iddetalleconsulta;
          public          postgres    false    234            �            1259    17860    doctores    TABLE     �   CREATE TABLE public.doctores (
    iddoctores integer NOT NULL,
    nombre character varying NOT NULL,
    telefono character varying NOT NULL,
    correo character varying NOT NULL
);
    DROP TABLE public.doctores;
       public         heap    postgres    false    5            �            1259    17865    doctores_iddoctores_seq    SEQUENCE     �   CREATE SEQUENCE public.doctores_iddoctores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.doctores_iddoctores_seq;
       public          postgres    false    235    5                       0    0    doctores_iddoctores_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.doctores_iddoctores_seq OWNED BY public.doctores.iddoctores;
          public          postgres    false    236            �            1259    17866    empresa    TABLE     �   CREATE TABLE public.empresa (
    idempresa integer NOT NULL,
    timbrado integer,
    fechatimbrado_inicio date,
    fechatimbrado_fin date,
    ruc character varying,
    establecimiento character varying,
    punto character varying
);
    DROP TABLE public.empresa;
       public         heap    postgres    false    5            �            1259    17871    empresa_idempresa_seq    SEQUENCE     �   CREATE SEQUENCE public.empresa_idempresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.empresa_idempresa_seq;
       public          postgres    false    5    237                       0    0    empresa_idempresa_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.empresa_idempresa_seq OWNED BY public.empresa.idempresa;
          public          postgres    false    238            �            1259    17872    especie    TABLE     h   CREATE TABLE public.especie (
    idespecies integer NOT NULL,
    nombre character varying NOT NULL
);
    DROP TABLE public.especie;
       public         heap    postgres    false    5            �            1259    17877    especie_idespecies_seq    SEQUENCE     �   CREATE SEQUENCE public.especie_idespecies_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.especie_idespecies_seq;
       public          postgres    false    5    239                       0    0    especie_idespecies_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.especie_idespecies_seq OWNED BY public.especie.idespecies;
          public          postgres    false    240            �            1259    17878    horarios    TABLE     �   CREATE TABLE public.horarios (
    idhorarios integer NOT NULL,
    dias character varying NOT NULL,
    hora_inicio character varying,
    hora_fin character varying,
    iddoctores integer
);
    DROP TABLE public.horarios;
       public         heap    postgres    false    5            �            1259    17883    horarios_idhorarios_seq    SEQUENCE     �   CREATE SEQUENCE public.horarios_idhorarios_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.horarios_idhorarios_seq;
       public          postgres    false    241    5                       0    0    horarios_idhorarios_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.horarios_idhorarios_seq OWNED BY public.horarios.idhorarios;
          public          postgres    false    242            �            1259    17884    indicaciones    TABLE     v   CREATE TABLE public.indicaciones (
    idindicaciones integer NOT NULL,
    descripcion character varying NOT NULL
);
     DROP TABLE public.indicaciones;
       public         heap    postgres    false    5            �            1259    17889    indicaciones_idindicaciones_seq    SEQUENCE     �   CREATE SEQUENCE public.indicaciones_idindicaciones_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.indicaciones_idindicaciones_seq;
       public          postgres    false    243    5                       0    0    indicaciones_idindicaciones_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.indicaciones_idindicaciones_seq OWNED BY public.indicaciones.idindicaciones;
          public          postgres    false    244            �            1259    17890    medicamentos    TABLE     �   CREATE TABLE public.medicamentos (
    idmedicamentos integer NOT NULL,
    nombre character varying NOT NULL,
    vencimiento character varying NOT NULL,
    lote character varying NOT NULL,
    codigodebarras character varying NOT NULL
);
     DROP TABLE public.medicamentos;
       public         heap    postgres    false    5            �            1259    17895    medicamentos_idmedicamentos_seq    SEQUENCE     �   CREATE SEQUENCE public.medicamentos_idmedicamentos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.medicamentos_idmedicamentos_seq;
       public          postgres    false    5    245                       0    0    medicamentos_idmedicamentos_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.medicamentos_idmedicamentos_seq OWNED BY public.medicamentos.idmedicamentos;
          public          postgres    false    246            �            1259    17896    metododepago    TABLE     b   CREATE TABLE public.metododepago (
    idmetodo integer NOT NULL,
    nombre character varying
);
     DROP TABLE public.metododepago;
       public         heap    postgres    false    5            �            1259    17901    metododepago_idmetodo_seq    SEQUENCE     �   CREATE SEQUENCE public.metododepago_idmetodo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.metododepago_idmetodo_seq;
       public          postgres    false    247    5                       0    0    metododepago_idmetodo_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.metododepago_idmetodo_seq OWNED BY public.metododepago.idmetodo;
          public          postgres    false    248            �            1259    17902 	   pacientes    TABLE     �   CREATE TABLE public.pacientes (
    idpaciente integer NOT NULL,
    nombre character varying NOT NULL,
    edad integer NOT NULL,
    sexo character varying NOT NULL,
    peso integer NOT NULL,
    idclientes integer NOT NULL,
    idraza integer
);
    DROP TABLE public.pacientes;
       public         heap    postgres    false    5            �            1259    17907    paciente_idclientes_seq    SEQUENCE     �   CREATE SEQUENCE public.paciente_idclientes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.paciente_idclientes_seq;
       public          postgres    false    249    5                       0    0    paciente_idclientes_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.paciente_idclientes_seq OWNED BY public.pacientes.idclientes;
          public          postgres    false    250            �            1259    17908    paciente_idpaciente_seq    SEQUENCE     �   CREATE SEQUENCE public.paciente_idpaciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.paciente_idpaciente_seq;
       public          postgres    false    249    5                       0    0    paciente_idpaciente_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.paciente_idpaciente_seq OWNED BY public.pacientes.idpaciente;
          public          postgres    false    251            �            1259    17909    pago    TABLE     �   CREATE TABLE public.pago (
    idpago integer NOT NULL,
    monto integer NOT NULL,
    metodo character varying NOT NULL,
    fecha date NOT NULL,
    idconsulta integer NOT NULL,
    idpaciente integer NOT NULL
);
    DROP TABLE public.pago;
       public         heap    postgres    false    5            �            1259    17914    pago_idconsulta_seq    SEQUENCE     �   CREATE SEQUENCE public.pago_idconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pago_idconsulta_seq;
       public          postgres    false    252    5                       0    0    pago_idconsulta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.pago_idconsulta_seq OWNED BY public.pago.idconsulta;
          public          postgres    false    253            �            1259    17915    pago_idpaciente_seq    SEQUENCE     �   CREATE SEQUENCE public.pago_idpaciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pago_idpaciente_seq;
       public          postgres    false    5    252                       0    0    pago_idpaciente_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.pago_idpaciente_seq OWNED BY public.pago.idpaciente;
          public          postgres    false    254            �            1259    17916    pago_idpago_seq    SEQUENCE     �   CREATE SEQUENCE public.pago_idpago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.pago_idpago_seq;
       public          postgres    false    5    252                        0    0    pago_idpago_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.pago_idpago_seq OWNED BY public.pago.idpago;
          public          postgres    false    255                        1259    17917 
   personales    TABLE     �   CREATE TABLE public.personales (
    idpersonales integer NOT NULL,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    ci character varying,
    telefono character varying,
    idciudad integer
);
    DROP TABLE public.personales;
       public         heap    postgres    false    5                       1259    17922    personales_idpersonales _seq    SEQUENCE     �   CREATE SEQUENCE public."personales_idpersonales _seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public."personales_idpersonales _seq";
       public          postgres    false    256    5            !           0    0    personales_idpersonales _seq    SEQUENCE OWNED BY     ^   ALTER SEQUENCE public."personales_idpersonales _seq" OWNED BY public.personales.idpersonales;
          public          postgres    false    257                       1259    17923    raza    TABLE     p   CREATE TABLE public.raza (
    idraza integer NOT NULL,
    nombre character varying,
    idespecies integer
);
    DROP TABLE public.raza;
       public         heap    postgres    false    5                       1259    17928    raza_idraza_seq    SEQUENCE     �   CREATE SEQUENCE public.raza_idraza_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.raza_idraza_seq;
       public          postgres    false    5    258            "           0    0    raza_idraza_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.raza_idraza_seq OWNED BY public.raza.idraza;
          public          postgres    false    259                       1259    17929    recetas    TABLE     �   CREATE TABLE public.recetas (
    idrecetas integer NOT NULL,
    idmedicamentos integer NOT NULL,
    idindicaciones integer NOT NULL,
    idconsulta integer NOT NULL
);
    DROP TABLE public.recetas;
       public         heap    postgres    false    5                       1259    17932    recetas_idconsulta_seq    SEQUENCE     �   CREATE SEQUENCE public.recetas_idconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.recetas_idconsulta_seq;
       public          postgres    false    5    260            #           0    0    recetas_idconsulta_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.recetas_idconsulta_seq OWNED BY public.recetas.idconsulta;
          public          postgres    false    261                       1259    17933    recetas_idindicaciones_seq    SEQUENCE     �   CREATE SEQUENCE public.recetas_idindicaciones_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.recetas_idindicaciones_seq;
       public          postgres    false    260    5            $           0    0    recetas_idindicaciones_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.recetas_idindicaciones_seq OWNED BY public.recetas.idindicaciones;
          public          postgres    false    262                       1259    17934    recetas_idmedicamentos_seq    SEQUENCE     �   CREATE SEQUENCE public.recetas_idmedicamentos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.recetas_idmedicamentos_seq;
       public          postgres    false    5    260            %           0    0    recetas_idmedicamentos_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.recetas_idmedicamentos_seq OWNED BY public.recetas.idmedicamentos;
          public          postgres    false    263                       1259    17935    recetas_idrecetas_seq    SEQUENCE     �   CREATE SEQUENCE public.recetas_idrecetas_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.recetas_idrecetas_seq;
       public          postgres    false    260    5            &           0    0    recetas_idrecetas_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.recetas_idrecetas_seq OWNED BY public.recetas.idrecetas;
          public          postgres    false    264            	           1259    17936 	   servicios    TABLE     �   CREATE TABLE public.servicios (
    idservicios integer NOT NULL,
    descripcion character varying NOT NULL,
    precio integer NOT NULL,
    iva integer NOT NULL
);
    DROP TABLE public.servicios;
       public         heap    postgres    false    5            
           1259    17941    servicios_idservicios_seq    SEQUENCE     �   CREATE SEQUENCE public.servicios_idservicios_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.servicios_idservicios_seq;
       public          postgres    false    5    265            '           0    0    servicios_idservicios_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.servicios_idservicios_seq OWNED BY public.servicios.idservicios;
          public          postgres    false    266                       1259    17942    sintomas    TABLE     i   CREATE TABLE public.sintomas (
    idsintomas integer NOT NULL,
    nombre character varying NOT NULL
);
    DROP TABLE public.sintomas;
       public         heap    postgres    false    5                       1259    17947    sintomas_idsintomas_seq    SEQUENCE     �   CREATE SEQUENCE public.sintomas_idsintomas_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sintomas_idsintomas_seq;
       public          postgres    false    5    267            (           0    0    sintomas_idsintomas_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.sintomas_idsintomas_seq OWNED BY public.sintomas.idsintomas;
          public          postgres    false    268                       1259    17948    usuarios    TABLE     �   CREATE TABLE public.usuarios (
    idusuarios integer NOT NULL,
    nombre character varying NOT NULL,
    clave character varying NOT NULL,
    rol character varying NOT NULL,
    estado character varying NOT NULL,
    idpersonales integer NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false    5                       1259    17953    usuarios _idpersonales_seq    SEQUENCE     �   CREATE SEQUENCE public."usuarios _idpersonales_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."usuarios _idpersonales_seq";
       public          postgres    false    5    269            )           0    0    usuarios _idpersonales_seq    SEQUENCE OWNED BY     Z   ALTER SEQUENCE public."usuarios _idpersonales_seq" OWNED BY public.usuarios.idpersonales;
          public          postgres    false    270                       1259    17954    usuarios _idusuarios_seq    SEQUENCE     �   CREATE SEQUENCE public."usuarios _idusuarios_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."usuarios _idusuarios_seq";
       public          postgres    false    5    269            *           0    0    usuarios _idusuarios_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public."usuarios _idusuarios_seq" OWNED BY public.usuarios.idusuarios;
          public          postgres    false    271            �           2604    18391    agendamiento idagendamiento    DEFAULT     �   ALTER TABLE ONLY public.agendamiento ALTER COLUMN idagendamiento SET DEFAULT nextval('public.agendamiento_idagendamiento_seq'::regclass);
 J   ALTER TABLE public.agendamiento ALTER COLUMN idagendamiento DROP DEFAULT;
       public          postgres    false    216    215            �           2604    18392    agendamiento idclientes    DEFAULT     �   ALTER TABLE ONLY public.agendamiento ALTER COLUMN idclientes SET DEFAULT nextval('public.agendamiento_idclientes_seq'::regclass);
 F   ALTER TABLE public.agendamiento ALTER COLUMN idclientes DROP DEFAULT;
       public          postgres    false    217    215            �           2604    18393    agendamiento iddoctores    DEFAULT     �   ALTER TABLE ONLY public.agendamiento ALTER COLUMN iddoctores SET DEFAULT nextval('public.agendamiento_iddoctores_seq'::regclass);
 F   ALTER TABLE public.agendamiento ALTER COLUMN iddoctores DROP DEFAULT;
       public          postgres    false    218    215            �           2604    18394    agendamiento idpaciente    DEFAULT     �   ALTER TABLE ONLY public.agendamiento ALTER COLUMN idpaciente SET DEFAULT nextval('public.agendamiento_idpaciente_seq'::regclass);
 F   ALTER TABLE public.agendamiento ALTER COLUMN idpaciente DROP DEFAULT;
       public          postgres    false    219    215            �           2604    18395    aperturas idaperturas    DEFAULT     ~   ALTER TABLE ONLY public.aperturas ALTER COLUMN idaperturas SET DEFAULT nextval('public.aperturas_idaperturas_seq'::regclass);
 D   ALTER TABLE public.aperturas ALTER COLUMN idaperturas DROP DEFAULT;
       public          postgres    false    221    220            �           2604    18396    aperturas idusuarios    DEFAULT     |   ALTER TABLE ONLY public.aperturas ALTER COLUMN idusuarios SET DEFAULT nextval('public.aperturas_idusuarios_seq'::regclass);
 C   ALTER TABLE public.aperturas ALTER COLUMN idusuarios DROP DEFAULT;
       public          postgres    false    222    220            �           2604    18397    bancos idbancos    DEFAULT     r   ALTER TABLE ONLY public.bancos ALTER COLUMN idbancos SET DEFAULT nextval('public.bancos_idbancos_seq'::regclass);
 >   ALTER TABLE public.bancos ALTER COLUMN idbancos DROP DEFAULT;
       public          postgres    false    224    223            �           2604    18398    ciudades idciudad    DEFAULT     v   ALTER TABLE ONLY public.ciudades ALTER COLUMN idciudad SET DEFAULT nextval('public.ciudades_idciudad_seq'::regclass);
 @   ALTER TABLE public.ciudades ALTER COLUMN idciudad DROP DEFAULT;
       public          postgres    false    227    226            �           2604    18399    clientes idclientes    DEFAULT     z   ALTER TABLE ONLY public.clientes ALTER COLUMN idclientes SET DEFAULT nextval('public.clientes_idclientes_seq'::regclass);
 B   ALTER TABLE public.clientes ALTER COLUMN idclientes DROP DEFAULT;
       public          postgres    false    230    228            �           2604    18400    clientes idciudad    DEFAULT     v   ALTER TABLE ONLY public.clientes ALTER COLUMN idciudad SET DEFAULT nextval('public.clientes_idciudad_seq'::regclass);
 @   ALTER TABLE public.clientes ALTER COLUMN idciudad DROP DEFAULT;
       public          postgres    false    229    228            �           2604    18401    consulta idconsulta    DEFAULT     z   ALTER TABLE ONLY public.consulta ALTER COLUMN idconsulta SET DEFAULT nextval('public.consulta_idconsulta_seq'::regclass);
 B   ALTER TABLE public.consulta ALTER COLUMN idconsulta DROP DEFAULT;
       public          postgres    false    232    231            �           2604    18402 !   detalleconsulta iddetalleconsulta    DEFAULT     �   ALTER TABLE ONLY public.detalleconsulta ALTER COLUMN iddetalleconsulta SET DEFAULT nextval('public.detalleconsulta_iddetalleconsulta_seq'::regclass);
 P   ALTER TABLE public.detalleconsulta ALTER COLUMN iddetalleconsulta DROP DEFAULT;
       public          postgres    false    234    233            �           2604    18403    doctores iddoctores    DEFAULT     z   ALTER TABLE ONLY public.doctores ALTER COLUMN iddoctores SET DEFAULT nextval('public.doctores_iddoctores_seq'::regclass);
 B   ALTER TABLE public.doctores ALTER COLUMN iddoctores DROP DEFAULT;
       public          postgres    false    236    235            �           2604    18404    empresa idempresa    DEFAULT     v   ALTER TABLE ONLY public.empresa ALTER COLUMN idempresa SET DEFAULT nextval('public.empresa_idempresa_seq'::regclass);
 @   ALTER TABLE public.empresa ALTER COLUMN idempresa DROP DEFAULT;
       public          postgres    false    238    237            �           2604    18405    especie idespecies    DEFAULT     x   ALTER TABLE ONLY public.especie ALTER COLUMN idespecies SET DEFAULT nextval('public.especie_idespecies_seq'::regclass);
 A   ALTER TABLE public.especie ALTER COLUMN idespecies DROP DEFAULT;
       public          postgres    false    240    239            �           2604    18406    horarios idhorarios    DEFAULT     z   ALTER TABLE ONLY public.horarios ALTER COLUMN idhorarios SET DEFAULT nextval('public.horarios_idhorarios_seq'::regclass);
 B   ALTER TABLE public.horarios ALTER COLUMN idhorarios DROP DEFAULT;
       public          postgres    false    242    241            �           2604    18407    indicaciones idindicaciones    DEFAULT     �   ALTER TABLE ONLY public.indicaciones ALTER COLUMN idindicaciones SET DEFAULT nextval('public.indicaciones_idindicaciones_seq'::regclass);
 J   ALTER TABLE public.indicaciones ALTER COLUMN idindicaciones DROP DEFAULT;
       public          postgres    false    244    243            �           2604    18408    medicamentos idmedicamentos    DEFAULT     �   ALTER TABLE ONLY public.medicamentos ALTER COLUMN idmedicamentos SET DEFAULT nextval('public.medicamentos_idmedicamentos_seq'::regclass);
 J   ALTER TABLE public.medicamentos ALTER COLUMN idmedicamentos DROP DEFAULT;
       public          postgres    false    246    245            �           2604    18409    metododepago idmetodo    DEFAULT     ~   ALTER TABLE ONLY public.metododepago ALTER COLUMN idmetodo SET DEFAULT nextval('public.metododepago_idmetodo_seq'::regclass);
 D   ALTER TABLE public.metododepago ALTER COLUMN idmetodo DROP DEFAULT;
       public          postgres    false    248    247            �           2604    18410    pacientes idpaciente    DEFAULT     {   ALTER TABLE ONLY public.pacientes ALTER COLUMN idpaciente SET DEFAULT nextval('public.paciente_idpaciente_seq'::regclass);
 C   ALTER TABLE public.pacientes ALTER COLUMN idpaciente DROP DEFAULT;
       public          postgres    false    251    249            �           2604    18411    pacientes idclientes    DEFAULT     {   ALTER TABLE ONLY public.pacientes ALTER COLUMN idclientes SET DEFAULT nextval('public.paciente_idclientes_seq'::regclass);
 C   ALTER TABLE public.pacientes ALTER COLUMN idclientes DROP DEFAULT;
       public          postgres    false    250    249            �           2604    18412    pago idpago    DEFAULT     j   ALTER TABLE ONLY public.pago ALTER COLUMN idpago SET DEFAULT nextval('public.pago_idpago_seq'::regclass);
 :   ALTER TABLE public.pago ALTER COLUMN idpago DROP DEFAULT;
       public          postgres    false    255    252            �           2604    18413    pago idconsulta    DEFAULT     r   ALTER TABLE ONLY public.pago ALTER COLUMN idconsulta SET DEFAULT nextval('public.pago_idconsulta_seq'::regclass);
 >   ALTER TABLE public.pago ALTER COLUMN idconsulta DROP DEFAULT;
       public          postgres    false    253    252            �           2604    18414    pago idpaciente    DEFAULT     r   ALTER TABLE ONLY public.pago ALTER COLUMN idpaciente SET DEFAULT nextval('public.pago_idpaciente_seq'::regclass);
 >   ALTER TABLE public.pago ALTER COLUMN idpaciente DROP DEFAULT;
       public          postgres    false    254    252            �           2604    18415    personales idpersonales    DEFAULT     �   ALTER TABLE ONLY public.personales ALTER COLUMN idpersonales SET DEFAULT nextval('public."personales_idpersonales _seq"'::regclass);
 F   ALTER TABLE public.personales ALTER COLUMN idpersonales DROP DEFAULT;
       public          postgres    false    257    256            �           2604    18416    raza idraza    DEFAULT     j   ALTER TABLE ONLY public.raza ALTER COLUMN idraza SET DEFAULT nextval('public.raza_idraza_seq'::regclass);
 :   ALTER TABLE public.raza ALTER COLUMN idraza DROP DEFAULT;
       public          postgres    false    259    258            �           2604    18417    recetas idrecetas    DEFAULT     v   ALTER TABLE ONLY public.recetas ALTER COLUMN idrecetas SET DEFAULT nextval('public.recetas_idrecetas_seq'::regclass);
 @   ALTER TABLE public.recetas ALTER COLUMN idrecetas DROP DEFAULT;
       public          postgres    false    264    260            �           2604    18418    recetas idmedicamentos    DEFAULT     �   ALTER TABLE ONLY public.recetas ALTER COLUMN idmedicamentos SET DEFAULT nextval('public.recetas_idmedicamentos_seq'::regclass);
 E   ALTER TABLE public.recetas ALTER COLUMN idmedicamentos DROP DEFAULT;
       public          postgres    false    263    260            �           2604    18419    recetas idindicaciones    DEFAULT     �   ALTER TABLE ONLY public.recetas ALTER COLUMN idindicaciones SET DEFAULT nextval('public.recetas_idindicaciones_seq'::regclass);
 E   ALTER TABLE public.recetas ALTER COLUMN idindicaciones DROP DEFAULT;
       public          postgres    false    262    260            �           2604    18420    recetas idconsulta    DEFAULT     x   ALTER TABLE ONLY public.recetas ALTER COLUMN idconsulta SET DEFAULT nextval('public.recetas_idconsulta_seq'::regclass);
 A   ALTER TABLE public.recetas ALTER COLUMN idconsulta DROP DEFAULT;
       public          postgres    false    261    260            �           2604    18421    servicios idservicios    DEFAULT     ~   ALTER TABLE ONLY public.servicios ALTER COLUMN idservicios SET DEFAULT nextval('public.servicios_idservicios_seq'::regclass);
 D   ALTER TABLE public.servicios ALTER COLUMN idservicios DROP DEFAULT;
       public          postgres    false    266    265            �           2604    18422    sintomas idsintomas    DEFAULT     z   ALTER TABLE ONLY public.sintomas ALTER COLUMN idsintomas SET DEFAULT nextval('public.sintomas_idsintomas_seq'::regclass);
 B   ALTER TABLE public.sintomas ALTER COLUMN idsintomas DROP DEFAULT;
       public          postgres    false    268    267            �           2604    18423    usuarios idusuarios    DEFAULT     }   ALTER TABLE ONLY public.usuarios ALTER COLUMN idusuarios SET DEFAULT nextval('public."usuarios _idusuarios_seq"'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN idusuarios DROP DEFAULT;
       public          postgres    false    271    269            �           2604    18424    usuarios idpersonales    DEFAULT     �   ALTER TABLE ONLY public.usuarios ALTER COLUMN idpersonales SET DEFAULT nextval('public."usuarios _idpersonales_seq"'::regclass);
 D   ALTER TABLE public.usuarios ALTER COLUMN idpersonales DROP DEFAULT;
       public          postgres    false    270    269            �          0    17805    agendamiento 
   TABLE DATA           j   COPY public.agendamiento (idagendamiento, "fecha ", hora, idclientes, iddoctores, idpaciente) FROM stdin;
    public          postgres    false    215   �      �          0    17812 	   aperturas 
   TABLE DATA           ^   COPY public.aperturas (idaperturas, ape_fecha, ape_monto, ape_estado, idusuarios) FROM stdin;
    public          postgres    false    220         �          0    17820    bancos 
   TABLE DATA           2   COPY public.bancos (idbancos, nombre) FROM stdin;
    public          postgres    false    223   T      �          0    17826    cierre 
   TABLE DATA           M   COPY public.cierre (idcierre, cie_fecha, cie_monto, idaperturas) FROM stdin;
    public          postgres    false    225   �      �          0    17829    ciudades 
   TABLE DATA           8   COPY public.ciudades (idciudad, ciu_nombre) FROM stdin;
    public          postgres    false    226   �      �          0    17835    clientes 
   TABLE DATA           X   COPY public.clientes (idclientes, nombre, apellido, ci, idciudad, telefono) FROM stdin;
    public          postgres    false    228   k      �          0    17842    consulta 
   TABLE DATA           �   COPY public.consulta (idconsulta, fecha, total, estado, idclientes, idusuarios, iddoctores, hora, idempresa, numero, condicion, idmetodo, idbanco) FROM stdin;
    public          postgres    false    231   4      �          0    17852    detalleconsulta 
   TABLE DATA           �   COPY public.detalleconsulta (iddetalleconsulta, idconsulta, precio, idpacientes, idsintomas, recetas, idmedicamentos, iva, cantidad) FROM stdin;
    public          postgres    false    233   �      �          0    17860    doctores 
   TABLE DATA           H   COPY public.doctores (iddoctores, nombre, telefono, correo) FROM stdin;
    public          postgres    false    235   �      �          0    17866    empresa 
   TABLE DATA           |   COPY public.empresa (idempresa, timbrado, fechatimbrado_inicio, fechatimbrado_fin, ruc, establecimiento, punto) FROM stdin;
    public          postgres    false    237   �      �          0    17872    especie 
   TABLE DATA           5   COPY public.especie (idespecies, nombre) FROM stdin;
    public          postgres    false    239   �      �          0    17878    horarios 
   TABLE DATA           W   COPY public.horarios (idhorarios, dias, hora_inicio, hora_fin, iddoctores) FROM stdin;
    public          postgres    false    241         �          0    17884    indicaciones 
   TABLE DATA           C   COPY public.indicaciones (idindicaciones, descripcion) FROM stdin;
    public          postgres    false    243   �      �          0    17890    medicamentos 
   TABLE DATA           a   COPY public.medicamentos (idmedicamentos, nombre, vencimiento, lote, codigodebarras) FROM stdin;
    public          postgres    false    245   �      �          0    17896    metododepago 
   TABLE DATA           8   COPY public.metododepago (idmetodo, nombre) FROM stdin;
    public          postgres    false    247   L       �          0    17902 	   pacientes 
   TABLE DATA           ]   COPY public.pacientes (idpaciente, nombre, edad, sexo, peso, idclientes, idraza) FROM stdin;
    public          postgres    false    249   |       �          0    17909    pago 
   TABLE DATA           T   COPY public.pago (idpago, monto, metodo, fecha, idconsulta, idpaciente) FROM stdin;
    public          postgres    false    252   !!      �          0    17917 
   personales 
   TABLE DATA           \   COPY public.personales (idpersonales, nombre, apellido, ci, telefono, idciudad) FROM stdin;
    public          postgres    false    256   >!      �          0    17923    raza 
   TABLE DATA           :   COPY public.raza (idraza, nombre, idespecies) FROM stdin;
    public          postgres    false    258   �!      �          0    17929    recetas 
   TABLE DATA           X   COPY public.recetas (idrecetas, idmedicamentos, idindicaciones, idconsulta) FROM stdin;
    public          postgres    false    260   �!      �          0    17936 	   servicios 
   TABLE DATA           J   COPY public.servicios (idservicios, descripcion, precio, iva) FROM stdin;
    public          postgres    false    265   "      �          0    17942    sintomas 
   TABLE DATA           6   COPY public.sintomas (idsintomas, nombre) FROM stdin;
    public          postgres    false    267   8"      �          0    17948    usuarios 
   TABLE DATA           X   COPY public.usuarios (idusuarios, nombre, clave, rol, estado, idpersonales) FROM stdin;
    public          postgres    false    269   �"      +           0    0    agendamiento_idagendamiento_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.agendamiento_idagendamiento_seq', 1, false);
          public          postgres    false    216            ,           0    0    agendamiento_idclientes_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.agendamiento_idclientes_seq', 1, false);
          public          postgres    false    217            -           0    0    agendamiento_iddoctores_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.agendamiento_iddoctores_seq', 1, false);
          public          postgres    false    218            .           0    0    agendamiento_idpaciente_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.agendamiento_idpaciente_seq', 1, false);
          public          postgres    false    219            /           0    0    aperturas_idaperturas_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.aperturas_idaperturas_seq', 1, true);
          public          postgres    false    221            0           0    0    aperturas_idusuarios_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.aperturas_idusuarios_seq', 1, false);
          public          postgres    false    222            1           0    0    bancos_idbancos_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.bancos_idbancos_seq', 7, true);
          public          postgres    false    224            2           0    0    ciudades_idciudad_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ciudades_idciudad_seq', 14, true);
          public          postgres    false    227            3           0    0    clientes_idciudad_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.clientes_idciudad_seq', 1, false);
          public          postgres    false    229            4           0    0    clientes_idclientes_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.clientes_idclientes_seq', 9, true);
          public          postgres    false    230            5           0    0    consulta_idconsulta_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.consulta_idconsulta_seq', 61, true);
          public          postgres    false    232            6           0    0 %   detalleconsulta_iddetalleconsulta_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.detalleconsulta_iddetalleconsulta_seq', 63, true);
          public          postgres    false    234            7           0    0    doctores_iddoctores_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.doctores_iddoctores_seq', 9, true);
          public          postgres    false    236            8           0    0    empresa_idempresa_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.empresa_idempresa_seq', 1, false);
          public          postgres    false    238            9           0    0    especie_idespecies_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.especie_idespecies_seq', 2, true);
          public          postgres    false    240            :           0    0    horarios_idhorarios_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.horarios_idhorarios_seq', 14, true);
          public          postgres    false    242            ;           0    0    indicaciones_idindicaciones_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.indicaciones_idindicaciones_seq', 2, true);
          public          postgres    false    244            <           0    0    medicamentos_idmedicamentos_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.medicamentos_idmedicamentos_seq', 3, true);
          public          postgres    false    246            =           0    0    metododepago_idmetodo_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.metododepago_idmetodo_seq', 3, true);
          public          postgres    false    248            >           0    0    paciente_idclientes_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.paciente_idclientes_seq', 1, false);
          public          postgres    false    250            ?           0    0    paciente_idpaciente_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.paciente_idpaciente_seq', 13, true);
          public          postgres    false    251            @           0    0    pago_idconsulta_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pago_idconsulta_seq', 1, false);
          public          postgres    false    253            A           0    0    pago_idpaciente_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pago_idpaciente_seq', 1, false);
          public          postgres    false    254            B           0    0    pago_idpago_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.pago_idpago_seq', 1, false);
          public          postgres    false    255            C           0    0    personales_idpersonales _seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."personales_idpersonales _seq"', 6, true);
          public          postgres    false    257            D           0    0    raza_idraza_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.raza_idraza_seq', 4, true);
          public          postgres    false    259            E           0    0    recetas_idconsulta_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.recetas_idconsulta_seq', 1, false);
          public          postgres    false    261            F           0    0    recetas_idindicaciones_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.recetas_idindicaciones_seq', 1, false);
          public          postgres    false    262            G           0    0    recetas_idmedicamentos_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.recetas_idmedicamentos_seq', 1, false);
          public          postgres    false    263            H           0    0    recetas_idrecetas_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.recetas_idrecetas_seq', 1, false);
          public          postgres    false    264            I           0    0    servicios_idservicios_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.servicios_idservicios_seq', 1, false);
          public          postgres    false    266            J           0    0    sintomas_idsintomas_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sintomas_idsintomas_seq', 13, true);
          public          postgres    false    268            K           0    0    usuarios _idpersonales_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."usuarios _idpersonales_seq"', 1, false);
          public          postgres    false    270            L           0    0    usuarios _idusuarios_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."usuarios _idusuarios_seq"', 4, true);
          public          postgres    false    271            �           2606    17990    agendamiento agendamiento_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.agendamiento
    ADD CONSTRAINT agendamiento_pkey PRIMARY KEY (idagendamiento);
 H   ALTER TABLE ONLY public.agendamiento DROP CONSTRAINT agendamiento_pkey;
       public            postgres    false    215            �           2606    17992    aperturas aperturas_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.aperturas
    ADD CONSTRAINT aperturas_pkey PRIMARY KEY (idaperturas);
 B   ALTER TABLE ONLY public.aperturas DROP CONSTRAINT aperturas_pkey;
       public            postgres    false    220            �           2606    17994    bancos bancos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.bancos
    ADD CONSTRAINT bancos_pkey PRIMARY KEY (idbancos);
 <   ALTER TABLE ONLY public.bancos DROP CONSTRAINT bancos_pkey;
       public            postgres    false    223            �           2606    17996    cierre cierre_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cierre
    ADD CONSTRAINT cierre_pkey PRIMARY KEY (idcierre);
 <   ALTER TABLE ONLY public.cierre DROP CONSTRAINT cierre_pkey;
       public            postgres    false    225            �           2606    17998    ciudades ciudades_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY (idciudad);
 @   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT ciudades_pkey;
       public            postgres    false    226            �           2606    18000    clientes clientes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (idclientes);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    228            �           2606    18002    consulta consulta_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (idconsulta);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_pkey;
       public            postgres    false    231                       2606    18004 $   detalleconsulta detalleconsulta_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.detalleconsulta
    ADD CONSTRAINT detalleconsulta_pkey PRIMARY KEY (iddetalleconsulta);
 N   ALTER TABLE ONLY public.detalleconsulta DROP CONSTRAINT detalleconsulta_pkey;
       public            postgres    false    233                       2606    18006    doctores doctores_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (iddoctores);
 @   ALTER TABLE ONLY public.doctores DROP CONSTRAINT doctores_pkey;
       public            postgres    false    235                       2606    18008    empresa empresa_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (idempresa);
 >   ALTER TABLE ONLY public.empresa DROP CONSTRAINT empresa_pkey;
       public            postgres    false    237                       2606    18010    especie especie_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (idespecies);
 >   ALTER TABLE ONLY public.especie DROP CONSTRAINT especie_pkey;
       public            postgres    false    239            	           2606    18012    horarios horarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.horarios
    ADD CONSTRAINT horarios_pkey PRIMARY KEY (idhorarios);
 @   ALTER TABLE ONLY public.horarios DROP CONSTRAINT horarios_pkey;
       public            postgres    false    241                       2606    18014    indicaciones indicaciones_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.indicaciones
    ADD CONSTRAINT indicaciones_pkey PRIMARY KEY (idindicaciones);
 H   ALTER TABLE ONLY public.indicaciones DROP CONSTRAINT indicaciones_pkey;
       public            postgres    false    243                       2606    18016    medicamentos medicamentos_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (idmedicamentos);
 H   ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
       public            postgres    false    245                       2606    18018    metododepago metododepago_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.metododepago
    ADD CONSTRAINT metododepago_pkey PRIMARY KEY (idmetodo);
 H   ALTER TABLE ONLY public.metododepago DROP CONSTRAINT metododepago_pkey;
       public            postgres    false    247                       2606    18020    pacientes paciente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (idpaciente);
 A   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT paciente_pkey;
       public            postgres    false    249                       2606    18022    pago pago_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (idpago);
 8   ALTER TABLE ONLY public.pago DROP CONSTRAINT pago_pkey;
       public            postgres    false    252                       2606    18024    personales personales_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.personales
    ADD CONSTRAINT personales_pkey PRIMARY KEY (idpersonales);
 D   ALTER TABLE ONLY public.personales DROP CONSTRAINT personales_pkey;
       public            postgres    false    256                       2606    18026    raza raza_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.raza
    ADD CONSTRAINT raza_pkey PRIMARY KEY (idraza);
 8   ALTER TABLE ONLY public.raza DROP CONSTRAINT raza_pkey;
       public            postgres    false    258                       2606    18028    recetas recetas_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT recetas_pkey PRIMARY KEY (idrecetas);
 >   ALTER TABLE ONLY public.recetas DROP CONSTRAINT recetas_pkey;
       public            postgres    false    260                       2606    18030    servicios servicios_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_pkey PRIMARY KEY (idservicios);
 B   ALTER TABLE ONLY public.servicios DROP CONSTRAINT servicios_pkey;
       public            postgres    false    265                       2606    18032    sintomas sintomas_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.sintomas
    ADD CONSTRAINT sintomas_pkey PRIMARY KEY (idsintomas);
 @   ALTER TABLE ONLY public.sintomas DROP CONSTRAINT sintomas_pkey;
       public            postgres    false    267                       2606    18034    usuarios usuarios _pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT "usuarios _pkey" PRIMARY KEY (idusuarios);
 C   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT "usuarios _pkey";
       public            postgres    false    269            $           2606    18035    clientes ciudades    FK CONSTRAINT     �   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT ciudades FOREIGN KEY (idciudad) REFERENCES public.ciudades(idciudad) NOT VALID;
 ;   ALTER TABLE ONLY public.clientes DROP CONSTRAINT ciudades;
       public          postgres    false    4859    228    226            +           2606    18040    detalleconsulta fkanimales    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleconsulta
    ADD CONSTRAINT fkanimales FOREIGN KEY (idpacientes) REFERENCES public.pacientes(idpaciente) NOT VALID;
 D   ALTER TABLE ONLY public.detalleconsulta DROP CONSTRAINT fkanimales;
       public          postgres    false    233    4881    249            %           2606    18045    consulta fkbanco    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkbanco FOREIGN KEY (idbanco) REFERENCES public.bancos(idbancos) NOT VALID;
 :   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkbanco;
       public          postgres    false    231    4855    223            4           2606    18050    personales fkciudades    FK CONSTRAINT     �   ALTER TABLE ONLY public.personales
    ADD CONSTRAINT fkciudades FOREIGN KEY (idciudad) REFERENCES public.ciudades(idciudad) NOT VALID;
 ?   ALTER TABLE ONLY public.personales DROP CONSTRAINT fkciudades;
       public          postgres    false    226    4859    256                        2606    18055    agendamiento fkcliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.agendamiento
    ADD CONSTRAINT fkcliente FOREIGN KEY (idclientes) REFERENCES public.clientes(idclientes) NOT VALID;
 @   ALTER TABLE ONLY public.agendamiento DROP CONSTRAINT fkcliente;
       public          postgres    false    4861    215    228            0           2606    18060    pacientes fkclientes    FK CONSTRAINT     �   ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT fkclientes FOREIGN KEY (idclientes) REFERENCES public.clientes(idclientes) NOT VALID;
 >   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT fkclientes;
       public          postgres    false    4861    249    228            &           2606    18065    consulta fkclientes    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkclientes FOREIGN KEY (idclientes) REFERENCES public.clientes(idclientes) NOT VALID;
 =   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkclientes;
       public          postgres    false    231    228    4861            6           2606    18070    recetas fkconsulta    FK CONSTRAINT     �   ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT fkconsulta FOREIGN KEY (idconsulta) REFERENCES public.consulta(idconsulta) NOT VALID;
 <   ALTER TABLE ONLY public.recetas DROP CONSTRAINT fkconsulta;
       public          postgres    false    4863    231    260            2           2606    18075    pago fkconsulta    FK CONSTRAINT     �   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT fkconsulta FOREIGN KEY (idconsulta) REFERENCES public.consulta(idconsulta) NOT VALID;
 9   ALTER TABLE ONLY public.pago DROP CONSTRAINT fkconsulta;
       public          postgres    false    231    252    4863            ,           2606    18080    detalleconsulta fkconsulta    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleconsulta
    ADD CONSTRAINT fkconsulta FOREIGN KEY (idconsulta) REFERENCES public.consulta(idconsulta) NOT VALID;
 D   ALTER TABLE ONLY public.detalleconsulta DROP CONSTRAINT fkconsulta;
       public          postgres    false    4863    231    233            !           2606    18085    agendamiento fkdoctores    FK CONSTRAINT     �   ALTER TABLE ONLY public.agendamiento
    ADD CONSTRAINT fkdoctores FOREIGN KEY (iddoctores) REFERENCES public.doctores(iddoctores) NOT VALID;
 A   ALTER TABLE ONLY public.agendamiento DROP CONSTRAINT fkdoctores;
       public          postgres    false    235    4867    215            /           2606    18090    horarios fkdoctores    FK CONSTRAINT     �   ALTER TABLE ONLY public.horarios
    ADD CONSTRAINT fkdoctores FOREIGN KEY (iddoctores) REFERENCES public.doctores(iddoctores) NOT VALID;
 =   ALTER TABLE ONLY public.horarios DROP CONSTRAINT fkdoctores;
       public          postgres    false    235    4867    241            '           2606    18095    consulta fkdoctores    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkdoctores FOREIGN KEY (iddoctores) REFERENCES public.doctores(iddoctores) NOT VALID;
 =   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkdoctores;
       public          postgres    false    231    235    4867            (           2606    18100    consulta fkempresa    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkempresa FOREIGN KEY (idempresa) REFERENCES public.empresa(idempresa) NOT VALID;
 <   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkempresa;
       public          postgres    false    237    4869    231            5           2606    18105    raza fkespecies    FK CONSTRAINT     �   ALTER TABLE ONLY public.raza
    ADD CONSTRAINT fkespecies FOREIGN KEY (idespecies) REFERENCES public.especie(idespecies) NOT VALID;
 9   ALTER TABLE ONLY public.raza DROP CONSTRAINT fkespecies;
       public          postgres    false    258    4871    239            7           2606    18110    recetas fkindicaciones    FK CONSTRAINT     �   ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT fkindicaciones FOREIGN KEY (idindicaciones) REFERENCES public.indicaciones(idindicaciones) NOT VALID;
 @   ALTER TABLE ONLY public.recetas DROP CONSTRAINT fkindicaciones;
       public          postgres    false    243    260    4875            8           2606    18115    recetas fkmedicamentos    FK CONSTRAINT     �   ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT fkmedicamentos FOREIGN KEY (idmedicamentos) REFERENCES public.medicamentos(idmedicamentos) NOT VALID;
 @   ALTER TABLE ONLY public.recetas DROP CONSTRAINT fkmedicamentos;
       public          postgres    false    245    4877    260            -           2606    18120    detalleconsulta fkmedicamentos    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleconsulta
    ADD CONSTRAINT fkmedicamentos FOREIGN KEY (idmedicamentos) REFERENCES public.medicamentos(idmedicamentos) NOT VALID;
 H   ALTER TABLE ONLY public.detalleconsulta DROP CONSTRAINT fkmedicamentos;
       public          postgres    false    233    245    4877            )           2606    18125    consulta fkmetodo    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkmetodo FOREIGN KEY (idmetodo) REFERENCES public.metododepago(idmetodo) NOT VALID;
 ;   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkmetodo;
       public          postgres    false    231    247    4879            "           2606    18130    agendamiento fkpaciente    FK CONSTRAINT     �   ALTER TABLE ONLY public.agendamiento
    ADD CONSTRAINT fkpaciente FOREIGN KEY (idpaciente) REFERENCES public.pacientes(idpaciente) NOT VALID;
 A   ALTER TABLE ONLY public.agendamiento DROP CONSTRAINT fkpaciente;
       public          postgres    false    215    4881    249            3           2606    18135    pago fkpaciente    FK CONSTRAINT     �   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT fkpaciente FOREIGN KEY (idpaciente) REFERENCES public.pacientes(idpaciente) NOT VALID;
 9   ALTER TABLE ONLY public.pago DROP CONSTRAINT fkpaciente;
       public          postgres    false    4881    252    249            9           2606    18140    usuarios fkpersonales    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fkpersonales FOREIGN KEY (idpersonales) REFERENCES public.personales(idpersonales) NOT VALID;
 ?   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT fkpersonales;
       public          postgres    false    269    4885    256            .           2606    18145    detalleconsulta fksintomas    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleconsulta
    ADD CONSTRAINT fksintomas FOREIGN KEY (idsintomas) REFERENCES public.sintomas(idsintomas) NOT VALID;
 D   ALTER TABLE ONLY public.detalleconsulta DROP CONSTRAINT fksintomas;
       public          postgres    false    4893    233    267            *           2606    18150    consulta fkusuarios    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkusuarios FOREIGN KEY (idusuarios) REFERENCES public.usuarios(idusuarios) NOT VALID;
 =   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkusuarios;
       public          postgres    false    4895    269    231            1           2606    18155    pacientes idraza    FK CONSTRAINT     {   ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT idraza FOREIGN KEY (idraza) REFERENCES public.raza(idraza) NOT VALID;
 :   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT idraza;
       public          postgres    false    258    249    4887            #           2606    18160    aperturas idusuarios    FK CONSTRAINT     �   ALTER TABLE ONLY public.aperturas
    ADD CONSTRAINT idusuarios FOREIGN KEY (idusuarios) REFERENCES public.usuarios(idusuarios);
 >   ALTER TABLE ONLY public.aperturas DROP CONSTRAINT idusuarios;
       public          postgres    false    269    220    4895            �      x������ � �      �   (   x�3�4202�5��50�45 NG'OנGNC�=... sF      �   [   x�-�9
�0���>A d�[[/]���p9<��ݤ��t�f�.��)cw����鉊d��ӵ�p��k�RS�>�OV���] |fs^      �      x������ � �      �      x�5��1Eѵ]E*@d$~�G⑂;$V�DU4�lX�	cZ*n�P��gZ�"��|!����\�.�@�~, ��7jS���H��H&Sa�c�c�@v>QE/0ݟS�m��B��$��M�����?5$�      �   �   x�5�͎�0���w)��݄��,�FJվ�s�S�%�>͌����^�W/�(s�)�N��I�h�ª��C�,S���ky��Шs�����dU���\��]��m�!%Q��v��c����������P��GN\Mi��~��R�gOI���
ًԃ�[����Aa��������߁��>�5,      �   a  x����n�0E���P��c��!B%�ȩ�tS�����5�1�����^�;6V(PT�*�������� �B	��?�ExZt7w_@�pҘ*E�Pa�)a��Q�Z�k�������b2R"���Jy���sL=a��g�H��ɋ������gʼ�-�Rg :,.T	�$~�����L[lB	I��\(�����Q�p��D�p*6c@׺��;K��殕{���� `�`�>�@�����s���/5���� ����B��&�Ԫ3 /�������괈*nS�$�L���d��X8�3���0�V4Fn�h�.�FE����m[���f�|�I)� Gs"X      �      x�u�1o�0���W�"l����������[�,���C��kZ��&A�|���ΰ3D1��{;����)7����ݶb�֎��n����=!cU����i�X�zW�;���>:ւ$������t0ߞE,���xE��)Ur�L\ā��/U&�4���0x�-H���%8��'�T�<*pRQ��Ş�V�#4��f�e��r�� �l�ь�1�'ҩ�D	چ�����.�����N�%��|9��[w�Mw���Й�Yi���"��
I�y��e�e�І��      �   �   x�e�K
� @��)z�i�u�X;�L�)��9:��e����,�$�ލ��C/Mx{�-!�n�IX�ɇ̖vF9m W�3���sX�����U'�T^q�_!�h����h%U|��4��䗽i��<'��:HX����T��&\7�f�y�$�x��s�γ��J�7�>���I�      �   6   x�3�443422����4202�50"�ʴ0073516�@>s��qqq :�
      �      x�3�tv�����2�ts�1b���� <�      �   �   x�3��M,*I-�44�20�4� �F\f����W%�瀤�Rf\���&%��s�E M�,9�JS���A��)�OiP�,g�eh FVl�ehs��@�F��A6ʂ��f1��%�9gXfj���qC��~6�x,F��� Nj>�      �      x�3䌈������� �Q      �   o   x�-�I�0@ѵ}���Ò[��Ԉ�"U��T*����`>�W�-�IR�&� ʢ�$Ĳ4����ly����D7��!�ak1�P�
z.E|u������-��'D��"�      �       x�3�tusu���2�tr�s������ C'�      �   �   x�=�A� E��� �.)%��b��z�st0�����g,���
�Ň��:X09���a�˻zX%�i@(��tO�/��s��%E�����Z!�\D�l�CZcn�]�06��ĥ���{�M����kk�7���ێ�v��?�=���-�      �      x������ � �      �   g   x�3�LN���I�L.JL��� .3�`7OG�W�(NSKc�4��4�@NC.#NgG_O�GNG�PO� GGGNSSK3�b#c ������ ��      �   %   x�3�tv��t�p�4�2��u���4����� \L�      �      x������ � �      �   !   x�3�����t�r�42500�44������ E��      �   9   x�3�t�t
ru�24�t���
�����24������24������� #�      �   D   x�3�tv���q�442�tt����	rt��tt���4�2��w�+11�t�wAȚq��qqq Kl�     