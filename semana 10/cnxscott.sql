
-- Activar consola de salida

SET SERVEROUTPUT ON;

-- Bloques anónimos
DECLARE
  v_empno     NUMBER:= &Nro_Empleado;
  v_empnombre VARCHAR2(50);
BEGIN
  SELECT ename INTO v_empnombre
  FROM emp
  WHERE empno = v_empno;
  dbms_output.put_line('El nombre del empleado es: ' || v_empnombre);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('El # de empleado no existe, intenta nuevamente');
END;

-------------------------------------

SELECT * FROM emp;

-------------------------------------

DECLARE
  v_empno     NUMBER:= &Nro_Empleado;
  v_empnombre VARCHAR2(50);
  v_regemp    emp%rowtype;
BEGIN
  SELECT ename INTO v_empnombre
  FROM emp
  WHERE empno = v_empno;
  
  SELECT * INTO v_regemp
  FROM emp WHERE empno=v_empno;
  
  dbms_output.put_line('El nombre del empleado es: ' || v_regemp.ename);
  dbms_output.put_line('El trabajo del empleado es: ' || v_regemp.job);
  dbms_output.put_line('El salario del empleado es: ' || v_regemp.sal);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('El # de empleado no existe, intenta nuevamente');
END;

-------------------------------------

DECLARE
 v_job        VARCHAR2(12):= '&JOB';
 v_cantidad   NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_cantidad
  FROM emp WHERE job =v_job;
  
  dbms_output.put_line('La cantidad de empleados es : ' || v_cantidad);
  
  IF MOD(v_cantidad, 2) = 0 THEN
    dbms_output.put_line('La cantidad es par');
  ELSE
    dbms_output.put_line('La cantidad es impar');
  END IF;
END;

-------------------------------------

DECLARE
  CURSOR C1 IS
  SELECT ename, sal FROM emp;
  
  v_reg C1%rowtype;
BEGIN
  OPEN C1;
  FETCH C1 INTO v_reg;
  
    LOOP
      dbms_output.put_line(v_reg.ename);
      dbms_output.put_line(v_reg.sal);
      dbms_output.put_line('');
     
       FETCH C1 INTO v_reg;
       EXIT WHEN C1%NOTFOUND;  
     END LOOP;  
  CLOSE C1;  
END;

-------------------------------------

DECLARE
  CURSOR C2(p_letra VARCHAR2) IS
  SELECT ename, sal FROM emp
    WHERE ename LIKE '%'||p_letra||'%';
  
  v_reg C2%rowtype;
  v_letra VARCHAR2(1):='&Letra';
BEGIN
  OPEN C2(v_letra);
  FETCH C2 INTO v_reg;
  
    LOOP
      dbms_output.put_line(v_reg.ename);
      dbms_output.put_line(v_reg.sal);
      dbms_output.put_line('');
     
       FETCH C2 INTO v_reg;
       EXIT WHEN C2%NOTFOUND;  
     END LOOP;
     dbms_output.put_line(C2%rowcount);
  CLOSE C2;  
END;

SELECT * FROM emp
WHERE ename LIKE '%L%'









