-- SYS

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER Desarrollo IDENTIFIED BY Cibertec
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
PROFILE DEFAULT;

GRANT CONNECT, RESOURCE TO Desarrollo;
GRANT CREATE ANY TABLE TO Desarrollo;

-- DESARROLLO

CREATE TABLE DESARROLLO.PROVEEDOR (
  IDPROVEEDOR         NUMBER(3),
  NOMBREPROVEEDOR     VARCHAR2(40),
  NOMBRECONTACTO      VARCHAR2(30),
  DIRECCION           VARCHAR2(60),
  TELEFONO            VARCHAR2(24)
);

CREATE TABLE DESARROLLO.PRODUCTO (
  IDPRODUCTO           NUMBER(3),
  NOMBREPRODUCTO       VARCHAR2(40),
  IDPROVEEDOR          NUMBER(3),
  IDCATEGORIA          NUMBER(3),
  CANTIDADPORUNIDAD    VARCHAR2(20),
  PRECIOUNIDAD         NUMBER(6,2)
);

CREATE TABLE DESARROLLO.CATEGORIA (
  IDCATEGORIA         NUMBER(3),
  NOMBRECATEGORIA     VARCHAR2(40),
  DESCRIPCION         VARCHAR2(100)
);

ALTER TABLE PROVEEDOR
ADD CONSTRAINT PK_PROVEEDOR_IDPROVEEDOR PRIMARY KEY (IDPROVEEDOR);

ALTER TABLE CATEGORIA
ADD CONSTRAINT PK_CATEGORIA_IDCATEGORIA PRIMARY KEY (IDCATEGORIA);

ALTER TABLE PRODUCTO
ADD CONSTRAINT PK_PRODUCTO_IDPRODUCTO PRIMARY KEY (IDPRODUCTO);

ALTER TABLE PRODUCTO
ADD CONSTRAINT FK_PRODUCTO_IDPROVEEDOR FOREIGN KEY (IDPROVEEDOR)
  REFERENCES PROVEEDOR(IDPROVEEDOR);
  
ALTER TABLE PRODUCTO
ADD CONSTRAINT FK_PRODUCTO_IDCATEGORIA FOREIGN KEY (IDCATEGORIA)
  REFERENCES CATEGORIA(IDCATEGORIA);

-- CATEGORIA

CREATE SEQUENCE  SEQ_CATEGORIA
INCREMENT BY 2
MAXVALUE 999
MINVALUE 100
START WITH 100
CYCLE;

INSERT INTO CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL, 'BEBIDAS', 'Las mejores bebidas del mundo');
INSERT INTO CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL, 'GALLETAS', 'Las clasicas de siempre');
INSERT INTO CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL, 'CHOCOLATE', '100% chocolate');
INSERT INTO CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL, 'CARAMELOS', 'Te endulsan la vida');
INSERT INTO CATEGORIA VALUES (SEQ_CATEGORIA.NEXTVAL, 'SALUDABLE', 'Mente sana, cuerpo sano');
  
CREATE INDEX IDX_NOMB_CATE
ON CATEGORIA(NOMBRECATEGORIA DESC);

CREATE SYNONYM S_PRIV_CATE
FOR CATEGORIA;

-- PROVEEDOR

CREATE SEQUENCE SEQ_PROVEEDOR
INCREMENT BY 5
MAXVALUE 999
MINVALUE 100
START WITH 100
NOCYCLE;

INSERT INTO PROVEEDOR VALUES
  (SEQ_PROVEEDOR.NEXTVAL, 'Emilia Clarke', 'Madre de Dragones ', 'Av Rompedora de Cadenas 55' , '555-7788' );
INSERT INTO PROVEEDOR VALUES
  (SEQ_PROVEEDOR.NEXTVAL, 'Dwayne Johnson ', 'The Rock', 'Calle Californa 107' , '333-5555' );
INSERT INTO PROVEEDOR VALUES
  (SEQ_PROVEEDOR.NEXTVAL, 'Sylvester Stallone', 'Rambo', 'Av Miraflores 200' , '888-7158' );
INSERT INTO PROVEEDOR VALUES
  (SEQ_PROVEEDOR.NEXTVAL, 'Arnold Schwarzenegger', 'Terminator', 'Jiron Washington 55 Piso 3' , '666-4400' );
INSERT INTO PROVEEDOR VALUES
  (SEQ_PROVEEDOR.NEXTVAL, 'Kit Harington', 'John Snow', 'Av Stark del Norte 103 Dep 402' , '777-9999' );

CREATE INDEX IDX_NOM_PROV_CONT
ON PROVEEDOR(NOMBREPROVEEDOR ASC, NOMBRECONTACTO ASC);

CREATE SYNONYM S_PRIV_PROV
FOR PROVEEDOR;

-- PRODUCTO

CREATE SEQUENCE SEQ_PRODUCTO
INCREMENT BY 10
MAXVALUE 999
MINVALUE 110
START WITH 110
CYCLE;

INSERT INTO PRODUCTO VALUES
  (SEQ_PRODUCTO.NEXTVAL, 'Bio', 100, 100, '50', 3.5);
INSERT INTO PRODUCTO VALUES
  (SEQ_PRODUCTO.NEXTVAL, 'Soda V', 105, 102, '80', 1.5);
INSERT INTO PRODUCTO VALUES
  (SEQ_PRODUCTO.NEXTVAL, 'Milky', 110, 104, '30', 2.5);
INSERT INTO PRODUCTO VALUES
  (SEQ_PRODUCTO.NEXTVAL, 'Big Ben', 115, 106, '120', 0.5);
INSERT INTO PRODUCTO VALUES
  (SEQ_PRODUCTO.NEXTVAL, 'NutMe', 120, 108, '10', 17.5);


CREATE INDEX IDX_NOMB_PROD
ON PRODUCTO (NOMBREPRODUCTO DESC);

CREATE PUBLIC SYNONYM S_PUBL_PROD
FOR PRODUCTO;


