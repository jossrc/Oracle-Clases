-- Activar la salida de consola
SET SERVEROUTPUT ON;

-- Habilitar permisos de numeros con punto decimal
ALTER SESSION SET nls_numeric_characters='.,';

-- Crear función que halle el porcentaje de un valor
CREATE OR REPLACE FUNCTION fnBono(p_monto NUMBER, p_porcentaje NUMBER)
RETURN NUMBER
IS
  v_montoBono NUMBER;
  v_valorPorcentaje NUMBER;
BEGIN
  v_valorPorcentaje := p_porcentaje/100;
  v_montoBono := p_monto*v_valorPorcentaje;
  RETURN v_montoBono;
END fnBono;

----------------------------

BEGIN
  dbms_output.put_line(fnbono(3250,2.5));
END;

----------------------------

SELECT ename, sal, fnBono(sal, 5.5) BONO from emp;

----------------------------

CREATE OR REPLACE FUNCTION fnStatus(p_sueldo NUMERIC)
  RETURN VARCHAR2
AS
  v_status VARCHAR2(50);
BEGIN
  IF p_sueldo > 6000 THEN
     v_status := 'Oneroso';
  ELSIF p_sueldo > 3000 THEN
     v_status := 'Regular';
  ELSE
     v_status := 'Normal';
  END IF;

  RETURN v_status;
END fnStatus;

----------------------------

BEGIN
  dbms_output.put_line(fnStatus(3400));
END;

----------------------------

SELECT ename, sal, fnStatus(sal) STATUS
FROM emp;

----------------------------

CREATE OR REPLACE FUNCTION fnNumeroARomano(p_numero NUMBER)
  RETURN VARCHAR2
AS
  v_roma VARCHAR2(20);
BEGIN
  IF p_numero<=3000 THEN
    v_roma := TO_CHAR(p_numero,'RN');
  ELSE
    v_roma := 'En construcción';
  END IF;
  RETURN v_roma;
END fnNumeroARomano;

BEGIN
  dbms_output.put_line(fnNumeroARomano(1999));
END;

