-- Ver tablas creadas
SELECT * FROM tab;

CREATE TABLE employees (
  employee_id    NUMBER,
  last_name      VARCHAR2(25) NOT NULL,
  salary         NUMBER(8,2),
  comission_pct  NUMBER(4,2),
  hiredate       DATE  CONSTRAINT nnHiredate NOT NULL
);

-- Agregando constraint para el unique
ALTER TABLE employees
ADD CONSTRAINT UQLastName UNIQUE (last_name);

-- Agregando llave primaria
ALTER TABLE employees
ADD CONSTRAINT PKEmployee PRIMARY KEY (employee_id);

----------------------------------------------------

-- Otra forma de agregar llave primaria
CREATE TABLE dept (
  deptID   NUMBER,
  dname    VARCHAR2(50) CONSTRAINT NNDname NOT NULL,
  CONSTRAINT PKDept PRIMARY KEY (deptID)
);

----------------------------------------------------

ALTER TABLE employees
ADD (deptId number);

-- Agregando una llave foranea
ALTER TABLE employees
ADD CONSTRAINT FKEmployeesDept FOREIGN KEY (deptId) REFERENCES dept(deptId);

----------------------------------------------------

-- Usando check para agregar restriccion
ALTER TABLE employees
ADD CONSTRAINT CKSalary CHECK (salary >=  1500);

-- Desactivar un constraint
ALTER TABLE employees
DISABLE CONSTRAINT CKSalary;

-- Activar un constraint
ALTER TABLE employees
ENABLE CONSTRAINT CKSalary;

----------------------------------------------------

-- Muestra todos los constraints asociados
SELECT * FROM user_constraints;

-- Muestra los constraints de manera mas simple
SELECT * FROM user_cons_columns;

----------------------------------------------------

-- Crea un indice
CREATE INDEX idxDeptID
ON employees(deptId);

-- Muestra los indices creados
SELECT * FROM user_indexes;

-- Borrar un indice
DROP INDEX idxDeptID;

----------------------------------------------------

-- Crear secuencia
CREATE SEQUENCE sqNumerador
INCREMENT BY 1
START WITH 10
NOCACHE
NOCYCLE;

-- Mostrar secuencias existentes
SELECT * FROM user_sequences;

----------------------------------------------------

CREATE TABLE ticket (
  nroTicket   number,
  fecTciket   date
);

-- Usando la secuencia
INSERT INTO ticket VALUES
  (sqNumerador.nextval, sysdate);

SELECT * FROM ticket;

-- Mostrar el ultimo valor del secuenciador
SELECT sqNumerador.currval from dual;


-- Falta Asignar privilegios a otro esquema
-- SELECT * FROM hr.departments;