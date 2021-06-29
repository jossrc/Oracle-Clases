
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND sal > 1500;

------------------------------

SELECT * 
FROM emp
WHERE job = 'SALESMAN' OR job = 'MANAGER';

SELECT * 
FROM emp
WHERE (job = 'SALESMAN' OR job = 'MANAGER') AND sal > 1500;

-------------------------------

SELECT SUM(sal) TotalSalary
FROM emp;

SELECT job, SUM(sal) Total, MAX(sal) MaxSalary
FROM emp
GROUP BY job;

--------------------------------

SELECT *
FROM emp
WHERE sal > (
  SELECT sal
  FROM emp
  WHERE ename = 'SCOTT'
);

--------------------------------

-- Insertar datos
INSERT INTO emp
  VALUES (1234,'CURTIS', 'MANAGER', 1111, SYSDATE, 7680, 10, 20);

commit; -- Actualiza y confirma la inserción en sqlplus

SELECT * FROM emp;

--------------------------------

-- Insertando con uso de variables de sustitucion

INSERT INTO dept (deptno, dname, loc) VALUES
  (&deptno, '&dname', '&loc');
  
--------------------------------

-- Creando tabla con consulta
CREATE TABLE TBEmpleSales
AS
  SELECT * FROM emp
  WHERE empno = 0;
  
SELECT * FROM TBEmpleSales;

-- Insertando con consulta
INSERT INTO TBEmpleSales
  (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE job = 'SALESMAN';

--------------------------------

UPDATE emp
SET sal = 2000
WHERE ename = 'CURTIS';

--------------------------------

SELECT * FROM TBEmpleSales;

UPDATE TBEmpleSales
SET comm = (SELECT MAX(comm) FROM emp)
WHERE ename = 'TURNER';

--------------------------------

DELETE FROM emp
WHERE ename = 'CURTIS';

commit;

SELECT * FROM emp;

--------------------------------

DELETE FROM emp;

rollback; -- Deshace la transaccion

--------------------------------

-- Inner join recomendado
SELECT e.ename, d.dname
FROM emp e
JOIN dept d
  ON e.deptno = d.deptno;



