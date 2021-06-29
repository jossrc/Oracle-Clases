
SELECT 1234.67890 Numero,
       round(1234.67890, 2) Numero_Redondeado,
       trunc(1234.67890, 2) Numero_Truncado
FROM DUAL; -- Tabla del sistema

SELECT 1234.67890 Numero,
       round(1234.67890, 0) Numero_Redondeado,
       trunc(1234.67890, 0) Numero_Truncado,
       mod(5, 2) Residuo,
       power(3,3) Potencia,
       sqrt(4) Raiz_Cuadrada,
       round(sqrt(2), 4) Raiz_Cuadrada_Redondeada
FROM DUAL;

-- Funciones de Texto
SELECT LOWER('CIBERTEC') Minuscula,
       UPPER('cibertec') Mayuscula,
       INITCAP('the scap') TitleCase
FROM dual;

SELECT RTRIM('Peru      ') SIN_ESPACIOS_DERECHA,
       LTRIM('      Peru') SIN_ESPACIOS_IZQUIERDA,
       TRIM('   Peru    ') SIN_ESPACIOS_AMBOS_LADOS,
       LENGTH('      AVBEGFGS') LONGITUD_CON_ESPEACIOS,
       LENGTH('AVBEGFGS') LONGITUD
FROM dual;

-- Suprimiendo letra de los costados
SELECT ename,TRIM('R' from ename) new_Ename ,sal
FROM emp;

-- Obtener datos desde una posicion
SELECT ename, 
       substr(ename,3,1) TerceraLetra,
       substr(ename, -2, 1) PenultimaLetra       
FROM emp;

-- Reemplaza un caracter por otro
SELECT ename,
       REPLACE(ename, 'L', 'X') new_ename
FROM emp;

-- Rellenar
SELECT ename,
       LPAD(ename, 15, '-') RellenoTexto,
       RPAD(ename, 15, '-') RellenoTexto,
       sal,
       LPAD(sal, 12, '*') NewSal
FROM emp;

-- Reverso
SELECT ename,
       REVERSE(ename) Reverso
FROM emp;

SELECT INSTR('Lo que tengo yo', 't')
FROM dual;

-- Reemplazar valores nulos
SELECT sal, comm, 
       nvl(comm, 10) comm1,
       nvl2(comm, 500, 100) comm2, -- si es nulo es 100 en caso que no sera 500,
       job,
       nullif(job, 'PRESIDENT') newJOB -- si es president es null
FROM emp;

SELECT sysdate fecha_actual,
       add_months(sysdate, 6) agregar_meses
FROM dual;

SELECT ename,
       hiredate,
       months_between(sysdate, hiredate) meses_entre
FROM emp;

SELECT systimestamp hora_actual
FROM dual;

SELECT next_day(sysdate, 'Jueves') proximo_dia, -- Cuando es el proximo jueves
       last_day(sysdate) ultimo_dia_del_mes,
       extract(year from sysdate) anio,
       extract(month from sysdate) mes
FROM dual;

SELECT sysdate, to_char(sysdate, 'Day DD, Month, "de" yyyy')
FROM dual;










