-- Altera la session para habilitar script
alter session set "_ORACLE_SCRIPT"=true;

-- Crear usuario
create user casino identified by 123
default tablespace users
temporary tablespace temp
profile default;

-- Asignando privilegios
grant connect, resource to casino;
grant create any table to casino;

-- Asignando cuota al sobre en el tablespace
alter user casino quota 10M on users;
