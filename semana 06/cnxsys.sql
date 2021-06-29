-- Muestra la información de los tablespace
SELECT * FROM dba_tablespaces;

-- Muestra todos los usuarios
SELECT * FROM dba_users;

-- Muestra la ubicacion del controlfile
SELECT * FROM v$controlfile;

-- Muestra informacion y ubicacion de los datafile
SELECT * FROM v$datafile;

-- Muestra los tipos de segmentos, tablespace y cantidad
SELECT segment_type, tablespace_name, COUNT(*) CANTIDAD
FROM dba_segments
GROUP BY segment_type, tablespace_name;

-- CREANDO USUARIO SCOTT
alter session set "_ORACLE_SCRIPT"=true;

create user scott identified by scott;

grant connect,resource to scott;
grant create any table to scott;

alter user scott account unlock 
default tablespace users
temporary tablespace temp
profile default;

Alter user scott quota 10M on users;

