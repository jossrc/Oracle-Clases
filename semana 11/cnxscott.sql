SET SERVEROUTPUT ON;

-- Procedimientos Almacenados

CREATE OR REPLACE PROCEDURE uspDemo1(p_mensaje IN VARCHAR2)
AS
BEGIN
  dbms_output.put_line(p_mensaje);
END;

-------
-- F2
EXECUTE uspDemo1('Bienvenidos');

------------------------------

-- Dentro de un bloque

BEGIN
  uspDemo1('Otra forma de ejecución');
END;

------------------------------
-- Parametro por defecto
CREATE OR REPLACE PROCEDURE uspDemo1(p_mensaje IN VARCHAR2 DEFAULT 'Hola')
AS
BEGIN
  dbms_output.put_line(p_mensaje);
END;

EXECUTE uspDemo1();
EXECUTE uspDemo1('Chao');

------------------------------

-- Ejercicios

CREATE OR REPLACE PROCEDURE usp_num_par_impar(v_num IN NUMBER)
AS
BEGIN
  IF (MOD(v_num, 2) = 0) THEN
    dbms_output.put_line(v_num || ' es par');
  ELSE
    dbms_output.put_line(v_num || ' es impar');
  END IF;
END;

EXECUTE usp_num_par_impar(-3);

------------------------------

CREATE OR REPLACE PROCEDURE uspregdpto(p_deptno NUMBER, p_dname VARCHAR2,p_loc VARCHAR2)
AS
BEGIN
  INSERT INTO dept VALUES
    (p_deptno, p_dname, p_loc);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
     dbms_output.put_line('Nro de departamento ya existe');
END;

EXECUTE uspregdpto(10, 'Servicios', 'Bogotá');

------------------------------

-- IS igual a AS
CREATE OR REPLACE PROCEDURE uspcursoremp(pjob IN VARCHAR2)
IS
BEGIN
  DECLARE CURSOR cemp IS 
    SELECT ename, job, sal 
    FROM emp WHERE job = UPPER(pjob);  
  reg cemp%rowtype;
  nohay EXCEPTION;
  v_can NUMBER;  
  BEGIN
  
    SELECT COUNT(*) INTO v_can FROM emp WHERE job = UPPER(pjob);
    
    IF v_can = 0 THEN
      RAISE nohay;
    END IF;
    
    OPEN cemp;
    LOOP
      FETCH cemp INTO reg;
      EXIT WHEN cemp%notfound;
      dbms_output.put_line('Empleado '|| reg.ename);
      dbms_output.put_line('Trabajo '|| reg.job);
      dbms_output.put_line('Salario '|| reg.sal);
      dbms_output.put_line('------------------');
    END LOOP;
    CLOSE cemp;
    
    EXCEPTION
      WHEN nohay THEN
        dbms_output.put_line('No hay empleados de ese trabajo');    
  END;
END;


BEGIN
  uspcursoremp('PRESIDENT');
END;






