SET SERVEROUTPUT ON;

/*

Escribir un bloque PL/SQL que reciba una cadena y visualice el Id de empleado
(EMPLOYEE_ID), nombre y apellido de empleado concatenado (FIRST_NAME Y LAST_NAME),
el nombre del Departamento (DEPARTMENT_NAME) y el salario del empleado (SALARY)
de todos los empleados (EMP) cuyo nombre de empleado (FIRST_NAME) inicie con la 
cadena especificada (usar variable sustitución “&”). Al finalizar visualizar el 
total de filas y el máximo salario. En caso no exista ningún empleado con dicha
cadena generar una Excepción que lance el mensaje “Empleado no Existe” en consola. 
(Utilizar un CURSOR y variables tipo ROWTYPE)

*/

/* PREGUNTA 01 by Jose Robles */

DECLARE
  CURSOR cur_emp(cadenax employees.first_name%type) IS
  SELECT e.employee_id, e.first_name || ' ' || e.last_name full_name,
         d.department_name, e.salary
  FROM employees  e
  JOIN departments d
    ON e.department_id = d.department_id
  WHERE first_name LIKE cadenax ||'%';
  
  v_row_emp cur_emp%rowtype;
  v_cadena employees.first_name%type := '&CADENA';
  v_max_salario NUMBER := 0;
BEGIN
  OPEN cur_emp(v_cadena);
  
  LOOP
    FETCH cur_emp INTO v_row_emp;
    EXIT WHEN cur_emp%NOTFOUND;
    
    IF v_row_emp.salary > v_max_salario THEN
      v_max_salario := v_row_emp.salary;
    END IF;
    
    dbms_output.put_line('Código            : '|| v_row_emp.employee_id);
    dbms_output.put_line('Nombre y Apellido : '|| v_row_emp.full_name);
    dbms_output.put_line('Departamento      : '|| v_row_emp.department_name);
    dbms_output.put_line('Salario           : '|| v_row_emp.salary);
    dbms_output.put_line('');    
  END LOOP;
  
  dbms_output.put_line('------------------------------------------');
  dbms_output.put_line('Total de Empleados : '||cur_emp%rowcount);
  dbms_output.put_line('Maximo salario     : '||v_max_salario);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('Empleado no Existe');
END;

/*
Crear un Stored Procedure SP_LIST_EMP_X_RANG_FEIN que liste los empleados (EMPLOYEES) 
cuya fecha de ingreso (HIRE_DATE) se encuentre entre una FECHA INICIAL y una 
FECHA FINAL en base a los parámetros ingresados. Los campos por mostrar 
son: EMPLOYEE_ID, LAST_NAME, HIRE_DATE y JOB_TITLE.

Probar el Stored Procedure ingresando: 
SP_LIST_EMP_X_RANG_FEIN (
  TO_DATE ('01/01/1997','DD/MM/YYYY'), 
  TO_DATE ('31/01/1997', 'DD/MM/YYYY')
);
*/

/* PREGUNTA 02 by Jose Robles */

CREATE OR REPLACE PROCEDURE SP_LIST_EMP_X_RANG_FEIN (v_fech1 DATE, v_fech2 DATE)
IS
BEGIN
  DECLARE CURSOR cemp_fech IS  
  SELECT e.employee_id, e.last_name, 
         e.hire_date, j.job_title
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  WHERE e.hire_date BETWEEN v_fech1 AND v_fech2;
  
  reg_emp cemp_fech%rowtype;
  
  BEGIN
    OPEN cemp_fech;
    
    LOOP
      FETCH cemp_fech INTO reg_emp;
      EXIT WHEN cemp_fech%NOTFOUND;
      
      dbms_output.put_line('EMPLOYEE_ID : '|| reg_emp.employee_id);
      dbms_output.put_line('LAST_NAME   : '|| reg_emp.last_name);
      dbms_output.put_line('HIRE_DATE   : '|| reg_emp.hire_date);
      dbms_output.put_line('JOB_TITLE   : '|| reg_emp.job_title);
      dbms_output.put_line(''); 
    END LOOP;    
    CLOSE cemp_fech;  
  END;  
END;

BEGIN
  SP_LIST_EMP_X_RANG_FEIN(TO_DATE('01/01/1997','DD/MM/YYYY'),TO_DATE('31/01/1997', 'DD/MM/YYYY'));
END;

/*
Crear un Stored Procedure SP_LIST_EMP_X_DPTO que liste los empleados (EMPLOYEES) 
de un determinado departamento (DEPARTMENTS) y la ciudad donde trabaja (LOCATIONS) 
en base a los parámetros ingresados. 
Los campos por mostrar son: LAST_NAME con HIRE_DATE concatenado, DEPARTMENT_NAME y CITY.

Nota: Probar el Stored Procedure.
EXECUTE SP_LIST_EMP_X_DPTO (90,1700);
*/

/* PREGUNTA 03 by Jose Robles */

CREATE OR REPLACE PROCEDURE SP_LIST_EMP_X_DPTO (
  v_dpto_id departments.department_id%type,
  v_loc_id locations.location_id%type
)
IS
BEGIN
  DECLARE CURSOR cemp_dpto IS  
  SELECT e.last_name || ' - ' || e.hire_date lastn_hired,
         d.department_name, l.city
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  WHERE d.department_id = v_dpto_id AND
        l.location_id = v_loc_id;
  
  reg_emp cemp_dpto%rowtype;
  
  BEGIN
    OPEN cemp_dpto;
    
    LOOP
      FETCH cemp_dpto INTO reg_emp;
      EXIT WHEN cemp_dpto%NOTFOUND;
      
      dbms_output.put_line('LAST_NAME + HIRE_DATE : '|| reg_emp.lastn_hired );
      dbms_output.put_line('DEPARTMENT_NAME       : '|| reg_emp.department_name);
      dbms_output.put_line('CITY                  : '|| reg_emp.city);
      dbms_output.put_line(''); 
    END LOOP;    
    CLOSE cemp_dpto;  
  END;  
END;

BEGIN
  SP_LIST_EMP_X_DPTO(90,1700);
END;

/*
Cree y ejecute el paquete PKG_DEPARTMENT que contenga los siguientes stored procedure:
a. Procedimiento almacenado USP_INSERT_DEP: 
   Ingresa todos los campos de la tabla empleado (DEPARTMENTS). 
   Si el departamento a ingresar ya existe enviar un mensaje en consola 
   a través de una excepción “DEPARTAMENTO YA EXISTE”
   
b. Procedimiento almacenado USP_DELETE_DEP: 
   Elimina un departamento a través de la columna DEPARTMENT_ID. 
   Si se requiere eliminar un departamento y este no existe, enviar un 
   mensaje en consola a través de una excepción 
   “DEPARTAMENTO NO EXISTE O YA FUE ELIMINADO”.
   
c. Procedimiento almacenado USP_UPDATE_DEP: 
   Actualiza un departamento a través de DEPARTMENT_ID. 
   Si se requiere actualizar un departamento y este no existe enviar un
   mensaje en consola a través de una excepción “DEPARTAMENTO NO EXISTE”. 

 Nota: Ingrese, actualice y elimine datos utilizando el package,
 verifique las excepciones.

*/

/* PREGUNTA 04 by Jose Robles */

CREATE OR REPLACE PACKAGE PKG_DEPARTMENT IS

  PROCEDURE USP_INSERT_DEP (
    p_dpto_id departments.department_id%type,
    p_dpto_name departments.department_name%type,
    p_mang_id departments.department_id%type,
    p_loc_id departments.location_id%type
  );
  
  PROCEDURE USP_DELETE_DEP (
    p_dpto_id departments.department_id%type
  );
  
  PROCEDURE USP_UPDATE_DEP (
    p_dpto_id departments.department_id%type,
    p_dpto_name departments.department_name%type,
    p_mang_id departments.manager_id%type,
    p_loc_id departments.location_id%type
  );

END PKG_DEPARTMENT;

CREATE OR REPLACE PACKAGE BODY PKG_DEPARTMENT IS

  PROCEDURE USP_INSERT_DEP (
    p_dpto_id departments.department_id%type,
    p_dpto_name departments.department_name%type,
    p_mang_id departments.department_id%type,
    p_loc_id departments.location_id%type
  ) IS
  BEGIN
    INSERT INTO departments VALUES
      (p_dpto_id, p_dpto_name, p_mang_id, p_loc_id);
  EXCEPTION
    WHEN dup_val_on_index THEN
      dbms_output.put_line('DEPARTAMENTO YA EXISTE');
  END USP_INSERT_DEP;
  
  PROCEDURE USP_DELETE_DEP (
    p_dpto_id departments.department_id%type
  ) IS
    v_existe_dpto_id departments.department_id%type;  
  BEGIN
    SELECT department_id INTO v_existe_dpto_id FROM departments
    WHERE department_id = p_dpto_id;
  
    DELETE FROM departments
    WHERE department_id = p_dpto_id;
  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('DEPARTAMENTO NO EXISTE O YA FUE ELIMINADO');
  END USP_DELETE_DEP;
  
  PROCEDURE USP_UPDATE_DEP (
    p_dpto_id departments.department_id%type,
    p_dpto_name departments.department_name%type,
    p_mang_id departments.manager_id%type,
    p_loc_id departments.location_id%type
  ) IS
    v_existe_dpto_id departments.department_id%type;
  BEGIN  
    SELECT department_id INTO v_existe_dpto_id FROM departments
    WHERE department_id = p_dpto_id;
  
    UPDATE departments
      SET department_name = p_dpto_name,
          manager_id = p_mang_id,
          location_id = p_loc_id
    WHERE department_id = p_dpto_id;  
  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('DEPARTAMENTO NO EXISTE');
  END USP_UPDATE_DEP;      
END PKG_DEPARTMENT;

BEGIN
  pkg_department.usp_insert_dep(280,'DEP ROBLES',200, 1700);
END;

BEGIN
  pkg_department.usp_update_dep(280,'ROBLES ACTUALIZADO', 200, 1700);
END;

BEGIN
  pkg_department.usp_update_dep(290,'ROBLES ACTUALIZADO', 200, 1700);
END;

BEGIN
  pkg_department.usp_delete_dep(280);
END;










