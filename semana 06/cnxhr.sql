
-- Usuario y esquema HR

-- Crear sinonimo
CREATE SYNONYM oficina FOR hr.locations;

-- Probando el sinonimo
SELECT * FROM oficina;

-- Eliminar sinonimo
DROP SYNONYM oficina;

-- Selecciona todos los diccionarios
SELECT * FROM Dictionary;

-- Muestra informacion de las tablas de los usuarios
SELECT * FROM user_objects
WHERE object_type = 'TABLE';

-- Muestra el nombre de la tabla y su tablespace
SELECT table_name, tablespace_name FROM user_tables;

-- Diferentes tipos de objetos que tenemos
SELECT distinct object_type FROM user_objects;

-- Muestra el tipo de objeto y la cantidad que existe en el usuario
SELECT object_type, COUNT(*) CANTIDAD 
from user_objects
GROUP BY object_type;

-- Ver restricciones creadas en el usuario hr
SELECT * FROM user_constraints;



