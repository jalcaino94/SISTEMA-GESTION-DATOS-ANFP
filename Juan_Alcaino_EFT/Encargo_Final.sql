-- ======================================================================

DROP TABLE dominio_idioma CASCADE CONSTRAINTS;
DROP TABLE historial_club CASCADE CONSTRAINTS;
DROP TABLE trabajador CASCADE CONSTRAINTS;
DROP TABLE idioma CASCADE CONSTRAINTS;
DROP TABLE club_futbol CASCADE CONSTRAINTS;
DROP TABLE escuela CASCADE CONSTRAINTS;
DROP TABLE asociacion CASCADE CONSTRAINTS;
DROP TABLE nacionalidad CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;
DROP SEQUENCE seq_club_futbol;

-- ======================================================================


CREATE TABLE region (
    id_region NUMBER(3) NOT NULL,
    nombre VARCHAR2(50) NOT NULL
);
ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE comuna (
    id_comuna NUMBER(4) NOT NULL,
    id_region NUMBER(3) NOT NULL,
    nombre VARCHAR2(50) NOT NULL
);
ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );
ALTER TABLE comuna ADD CONSTRAINT com_reg_fk FOREIGN KEY ( id_region ) REFERENCES region ( id_region );

CREATE TABLE nacionalidad (
    -- Clave autoincremental
    id_nacion NUMBER(4) GENERATED ALWAYS AS IDENTITY (START WITH 210 INCREMENT BY 2) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);
ALTER TABLE nacionalidad ADD CONSTRAINT nacionalidad_pk PRIMARY KEY ( id_nacion );

CREATE TABLE asociacion (
    id_asociacion NUMBER(3) NOT NULL,
    nombre_asociacion VARCHAR2(100) NOT NULL,
    fecha_creacion DATE NOT NULL,
    tipo_asociacion CHAR(1) NOT NULL
);
ALTER TABLE asociacion ADD CONSTRAINT asociacion_pk PRIMARY KEY ( id_asociacion );
-- Validación
ALTER TABLE asociacion ADD CONSTRAINT asoc_fecha_ck CHECK (fecha_creacion >= TO_DATE('1980-12-31', 'YYYY-MM-DD'));

CREATE TABLE escuela (
    id_escuela NUMBER(5) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    capacidad NUMBER(5) NOT NULL,
    fecha_fundacion DATE NOT NULL
);
ALTER TABLE escuela ADD CONSTRAINT escuela_pk PRIMARY KEY ( id_escuela );

CREATE TABLE club_futbol (
    id_club NUMBER(4) NOT NULL,
    nombre_club VARCHAR2(100) NOT NULL,
    patrimonio NUMBER(15) NOT NULL,
    ubicacion_calle VARCHAR2(100) NOT NULL,
    tipo_club VARCHAR2(20) NOT NULL
);
ALTER TABLE club_futbol ADD CONSTRAINT club_pk PRIMARY KEY ( id_club );
-- Restricción 
ALTER TABLE club_futbol ADD CONSTRAINT club_nombre_un UNIQUE ( nombre_club );

-- Secuencia para el ID de CLUB_FUTBOL 
CREATE SEQUENCE seq_club_futbol START WITH 703 INCREMENT BY 4;

CREATE TABLE idioma (
    id_idioma NUMBER(3) NOT NULL,
    nombre_idioma VARCHAR2(50) NOT NULL
);
ALTER TABLE idioma ADD CONSTRAINT idioma_pk PRIMARY KEY ( id_idioma );

CREATE TABLE trabajador (
    nro_inscripcion NUMBER(10) NOT NULL,
    rut NUMBER(8) NOT NULL,
    dv CHAR(1) NOT NULL,
    nombres VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(50) NOT NULL,
    sueldo_base NUMBER(10) NOT NULL,
    fecha_nac DATE NOT NULL,
    genero CHAR(1) NOT NULL,
    estado_civil VARCHAR2(20) NOT NULL,
    telefono_movil VARCHAR2(15) NOT NULL,
    direccion VARCHAR2(100) NOT NULL,
    id_comuna NUMBER(4) NOT NULL,
    tipo_trabajador VARCHAR2(20) NOT NULL, 
    puesto VARCHAR2(30),
    monto_premios NUMBER(12),
    anio_fin_amateurismo NUMBER(4),
    id_escuela NUMBER(5),
    id_asociacion NUMBER(3),
    horas_trabajadas NUMBER(3),
    valor_hora_extra NUMBER(8)
);
ALTER TABLE trabajador ADD CONSTRAINT trabajador_pk PRIMARY KEY ( nro_inscripcion );
ALTER TABLE trabajador ADD CONSTRAINT trab_com_fk FOREIGN KEY ( id_comuna ) REFERENCES comuna ( id_comuna );
ALTER TABLE trabajador ADD CONSTRAINT trab_esc_fk FOREIGN KEY ( id_escuela ) REFERENCES escuela ( id_escuela );
ALTER TABLE trabajador ADD CONSTRAINT trab_asoc_fk FOREIGN KEY ( id_asociacion ) REFERENCES asociacion ( id_asociacion );

CREATE TABLE historial_club (
    nro_inscripcion NUMBER(10) NOT NULL,
    id_club NUMBER(4) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);
ALTER TABLE historial_club ADD CONSTRAINT historial_club_pk PRIMARY KEY ( nro_inscripcion, id_club, fecha_inicio );
ALTER TABLE historial_club ADD CONSTRAINT hist_trab_fk FOREIGN KEY ( nro_inscripcion ) REFERENCES trabajador ( nro_inscripcion );
ALTER TABLE historial_club ADD CONSTRAINT hist_club_fk FOREIGN KEY ( id_club ) REFERENCES club_futbol ( id_club );

CREATE TABLE dominio_idioma (
    nro_inscripcion NUMBER(10) NOT NULL,
    id_idioma NUMBER(3) NOT NULL,
    nivel_dominio VARCHAR2(20) NOT NULL
);
ALTER TABLE dominio_idioma ADD CONSTRAINT dominio_idioma_pk PRIMARY KEY ( nro_inscripcion, id_idioma );
ALTER TABLE dominio_idioma ADD CONSTRAINT dom_trab_fk FOREIGN KEY ( nro_inscripcion ) REFERENCES trabajador ( nro_inscripcion );
ALTER TABLE dominio_idioma ADD CONSTRAINT dom_idio_fk FOREIGN KEY ( id_idioma ) REFERENCES idioma ( id_idioma );


-- ======================================================================


-- 1. Insertar REGION 
INSERT INTO region VALUES (1, 'ARICA Y PARINACOTA Y TARAPACA');
INSERT INTO region VALUES (2, 'ANTOFAGASTA');
INSERT INTO region VALUES (3, 'ATACAMA Y COQUIMBO');
INSERT INTO region VALUES (5, 'VALPARAISO');
INSERT INTO region VALUES (8, 'DEL BIOBIO');
INSERT INTO region VALUES (13, 'METROPOLITANA');
INSERT INTO region VALUES (16, 'NUBLE');

-- 2. Insertar COMUNA
INSERT INTO comuna VALUES (101, 13, 'Santiago');
INSERT INTO comuna VALUES (102, 5, 'Valparaíso');
INSERT INTO comuna VALUES (103, 8, 'Concepción'); 
INSERT INTO comuna VALUES (104, 2, 'Antofagasta');
INSERT INTO comuna VALUES (105, 16, 'Chillán');

-- 3. Insertar ASOCIACION
INSERT INTO asociacion VALUES (25, 'Asociación de Fútbol de Santiago', TO_DATE('15-05-2001', 'DD-MM-YYYY'), 'P');
INSERT INTO asociacion VALUES (26, 'Asociación Nacional de Fútbol Amateur', TO_DATE('10-03-1998', 'DD-MM-YYYY'), 'A');
INSERT INTO asociacion VALUES (27, 'Asociación de Fútbol de Valparaíso', TO_DATE('21-07-1987', 'DD-MM-YYYY'), 'P');
INSERT INTO asociacion VALUES (28, 'Asociación de Fútbol de Concepción', TO_DATE('30-11-1995', 'DD-MM-YYYY'), 'A');
INSERT INTO asociacion VALUES (29, 'Asociación de Fútbol de Antofagasta', TO_DATE('25-06-2003', 'DD-MM-YYYY'), 'P');
INSERT INTO asociacion VALUES (30, 'Asociación de Fútbol de Temuco', TO_DATE('12-01-2010', 'DD-MM-YYYY'), 'A');
INSERT INTO asociacion VALUES (31, 'Asociación de Fútbol de Rancagua', TO_DATE('08-09-1999', 'DD-MM-YYYY'), 'P');
INSERT INTO asociacion VALUES (32, 'Asociación de Fútbol de Puerto Montt', TO_DATE('20-04-2005', 'DD-MM-YYYY'), 'A');
INSERT INTO asociacion VALUES (33, 'Asociación de Fútbol de La Serena', TO_DATE('14-08-2012', 'DD-MM-YYYY'), 'P');
INSERT INTO asociacion VALUES (34, 'Asociación de Fútbol de Chillán', TO_DATE('01-12-2018', 'DD-MM-YYYY'), 'A');

-- 4. Insertar NACIONALIDAD (IDENTITY)
INSERT INTO nacionalidad (descripcion) VALUES ('Chilena');   
INSERT INTO nacionalidad (descripcion) VALUES ('Argentina'); 
INSERT INTO nacionalidad (descripcion) VALUES ('Peruana');   
INSERT INTO nacionalidad (descripcion) VALUES ('Boliviana'); 
INSERT INTO nacionalidad (descripcion) VALUES ('Brasileña'); 

-- 5. Insertar CLUB_FUTBOL
INSERT INTO club_futbol VALUES (seq_club_futbol.NEXTVAL, 'Colo-Colo', 500000000, 'Av. Marathon 5300', 'Profesional');
INSERT INTO club_futbol VALUES (seq_club_futbol.NEXTVAL, 'Universidad de Chile', 450000000, 'Av. El Parrón 0931', 'Profesional');
INSERT INTO club_futbol VALUES (seq_club_futbol.NEXTVAL, 'Deportes Antofagasta', 180000000, 'Avenida Angamos 01606', 'Profesional');
INSERT INTO club_futbol VALUES (seq_club_futbol.NEXTVAL, 'Huachipato', 220000000, 'Avenida Desiderio García 909', 'Profesional');
INSERT INTO club_futbol VALUES (seq_club_futbol.NEXTVAL, 'Ñublense', 170000000, 'Avenida Pedro Aguirre Cerda 1003', 'Profesional');

COMMIT;

SELECT 
    'ID:' || id_asociacion || ' * ' || nombre_asociacion AS "ASOCIACION",
    TO_CHAR(fecha_creacion, 'DD-MM-YYYY') AS "CREADA",
    tipo_asociacion AS "TIPO"
FROM ASOCIACION
WHERE tipo_asociacion = 'P' 
  AND EXTRACT(YEAR FROM fecha_creacion) > 2000
ORDER BY fecha_creacion DESC;

SELECT 
    id_club AS "CLUB",
    nombre_club AS "NOMBRE CLUB",
    patrimonio AS "PATRIMONIO EN PESOS",
    (patrimonio / 955) AS "PATRIMONIO EN DOLARES"
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%' 
  AND patrimonio > 200000000 
  AND tipo_club = 'Profesional'
ORDER BY id_club DESC;