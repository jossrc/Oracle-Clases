-- PL/SQL
-- BLOQUES

/*
DECLARE

BEGIN

  EXCEPCTION

END;
*/

-- Activar la consola de salida
SET SERVEROUTPUT ON;

-------------------------------

-- Imprimir
BEGIN
  dbms_output.put_line('Hello World');
END;

-------------------------------

DECLARE
-- Declarar variables
  v_num1 NUMBER:=10;
  v_num2 NUMBER:=40;
  v_result_sum NUMBER;
  v_result_subst NUMBER;
  v_result_mult NUMBER;
BEGIN
  v_result_sum:= v_num1 + v_num2;
  v_result_subst:= v_num1 - v_num2;
  v_result_mult:= v_num1 * v_num2;
  -- Imprimir y concatenar
  dbms_output.put_line('La suma es:  ' || v_result_sum);
  dbms_output.put_line('La resta es: ' || v_result_subst);
  dbms_output.put_line('La multiplicacion es: ' || v_result_mult);
END;

-- En division es necesario usar exception
DECLARE
-- Declarar variables
  v_num1 NUMBER:=10;
  v_num2 NUMBER:=40;
  v_result_div NUMBER;
BEGIN
  v_result_div:= v_num1 / v_num2;
  dbms_output.put_line('La division es: ' || v_result_div);
  EXCEPTION
    -- Atrapa excepcion con la division - obligatorio
    WHEN zero_divide THEN
      dbms_output.put_line('Error de divisor 0 (cero)');
END;

-------------------------------

DECLARE
  v_cantidad number;
BEGIN
  SELECT COUNT(*) INTO v_cantidad
  FROM emp;
  
  dbms_output.put_line('La cantidad de empleados es '|| v_cantidad);
END;

-------------------------------

-- Agregando pk para ejemplo
ALTER TABLE dept
ADD CONSTRAINT PKDept
PRIMARY KEY (deptno);

SELECT * FROM dept;

-------------------------------

DECLARE
  -- Establecer tipo segun datos de tipo desconocido
  v_deptno  dept.deptno%type:=10; -- Probando error con llave duplicada
  v_dname   dept.dname%type:='SYSTEM';
  v_loc     dept.loc%type:='LIMA';
BEGIN
  INSERT INTO dept VALUES
    (v_deptno, v_dname, v_loc);
  
  EXCEPTION
  -- Atrapa excepcion con llave duplicada
    WHEN dup_val_on_index THEN
      dbms_output.put_line('No se puede duplicar el N° de Dpto por ser PK');
END;

-------------------------------

rollback; -- Por si te arrepientes de agregar un valor xD

-------------------------------

-- Usar el & permite abrir una ventana para ingresar valores
DECLARE 
  v_deptno  dept.deptno%type:=&num_depto; -- Para numeros - nombre a eleccion
  v_dname   dept.dname%type:='&Nombre_Dpto'; -- Para cadena - nombre a eleccion
  v_loc     dept.loc%type:='&Ubicacion';
BEGIN
  INSERT INTO dept VALUES
    (v_deptno, v_dname, v_loc);
  
  EXCEPTION
    WHEN dup_val_on_index THEN
      dbms_output.put_line('No se puede duplicar el N° de Dpto por ser PK');
END;

-------------------------------

SELECT * FROM emp;

DECLARE
  v_empno  NUMBER:=7777;
  v_ename  VARCHAR2(50);
BEGIN
  SELECT ename INTO v_ename
  FROM emp
  WHERE empno=v_empno;
  
  dbms_output.put_line('El nombre del empleado es ' || v_ename);
  
  EXCEPTION
    -- Atrapa excepcion al no encontrar valor
    WHEN no_data_found THEN
      dbms_output.put_line('No existe dicho nro de empleado');
END;

-------------------------------

-- Simplificar y ahorrar memoria
DECLARE
  v_empno    NUMBER:=7369;
  vr_emp  emp%rowtype; -- Almacenará una fila
BEGIN

  SELECT * INTO vr_emp
  FROM emp
  WHERE empno = v_empno;
  
  dbms_output.put_line('Nombre : '|| vr_emp.ename);
  dbms_output.put_line('Trabajo: '|| vr_emp.job);
  -- Se aplica formato
  dbms_output.put_line('Salario: '|| to_char(vr_emp.sal,'9,999.99')); 

  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('No existe dicho nro de empleado');
END;


-------------------------------

-- Cursores

DECLARE
  CURSOR cemp IS SELECT ename, job FROM emp;
  v_ename VARCHAR2(50);
  v_job VARCHAR2(50);
BEGIN
  OPEN cemp;

  LOOP
    FETCH cemp INTO v_ename, v_job;
    -- finaliza cuando no se encuentra
    EXIT WHEN cemp%notfound;
    
    dbms_output.put_line('Empleado '|| v_ename);
    dbms_output.put_line('Trabajo ' || v_job);
    dbms_output.put_line('--------------------------');  
  END LOOP;
  
  CLOSE cemp;
END;











