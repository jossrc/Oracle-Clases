
SELECT * FROM tab;

SELECT * FROM departments;

-- Crear tabla copia usando select
CREATE TABLE TBEspecial30
AS
  SELECT * FROM employees
  WHERE department_id = 30;
  
-------------------------------------

-- Usando la tabla creada
SELECT * FROM TBEspecial30;

-- Agregar un nuevo campo a la tabla
ALTER TABLE TBEspecial30
ADD (address VARCHAR2(50));

-- Visualizar campos de una tabla
DESCRIBE TBEspecial30;

-- Renombrar nombre de la tabla
RENAME TBEspecial30 TO TBEmpleadosDep30;

-------------------------------------

SELECT * FROM tab;

-- Agregar comentario (descripcion) a una tabla
COMMENT ON TABLE TBEmpleadosDep30 IS 'Tabla de empleados del departamento 30';

-- Muestra informacion completa de todas las tablas (no recomendado)
SELECT * FROM all_objects;

-- Muestra informacion basica de las tablas
SELECT * FROM user_tables;

-- Muestra los comentarios de las tablas
SELECT * FROM user_tab_comments;

-------------------------------------









