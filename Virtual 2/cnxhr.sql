
SET SERVEROUTPUT ON;

/*
 01. Elaborar una funci�n FN_ULTI_CARA_EMAI_EMPL que al ingresar el c�digo de empleado de la 
     tabla EMPLOYEES me retorne el �ltimo car�cter del email de empleado aplicando el formato 
     para que aparezcan 4 arrobas a la izquierda y 4 a la derecha. En caso no existiese, usando 
     excepciones retorne un mensaje �C�digo de empleado no existe� mediante el gestor 
     NO_DATA_FOUND.
*/

CREATE OR REPLACE FUNCTION FN_ULTI_CARA_EMAIL_EMPL(
  code_emp IN NUMBER
)
RETURN VARCHAR2
 IS last_email_char VARCHAR2(100);
    number_at NUMBER:= 4;
BEGIN  
  SELECT SUBSTR(e.email,-1,1) INTO last_email_char 
  FROM employees e
  WHERE e.employee_id = code_emp;
  
  last_email_char := RPAD( last_email_char, LENGTH(last_email_char) + number_at, '@');
  last_email_char := LPAD(last_email_char, LENGTH(last_email_char) + number_at ,'@');
  
  RETURN last_email_char; 
  
EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.put_line('C�digo de empleado no existe');

  RETURN last_email_char; 

END FN_ULTI_CARA_EMAIL_EMPL;

DECLARE
  code_emp NUMBER:=101;
  last_email_char_modified VARCHAR(100);
BEGIN
  last_email_char_modified:= FN_ULTI_CARA_EMAIL_EMPL(code_emp);
  
  dbms_output.put_line('Ultimo caracter email ' || last_email_char_modified);
END;

/*
 02. Elaborar una funci�n FN_SUTO_SALA_EMPL_OFIC que al ingresar el oficio de empleado de la 
     tabla EMPLOYEES me retorne la sumatorio total del salario de los empleados de dicho oficio. 
     En caso no exista ning�n empleado con dicho oficio generar una Excepci�n que lance el 
     mensaje �No existe empleados con dicho oficio�.
*/

CREATE OR REPLACE FUNCTION FN_SUTO_SALA_EMPL_OFIC (
  job_emp IN VARCHAR2
)
RETURN NUMBER
  IS total_sum_salaries NUMBER;
BEGIN
  SELECT SUM(e.salary) INTO total_sum_salaries
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  WHERE j.job_title = job_emp
  GROUP BY j.job_title;
  
  RETURN total_sum_salaries;

EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('No existe empleados con dicho oficio');

  RETURN total_sum_salaries;
      
END FN_SUTO_SALA_EMPL_OFIC;


DECLARE
  job_emp VARCHAR2(35):='Programmer';
  total_sum_salaries NUMBER;
BEGIN
  total_sum_salaries:= FN_SUTO_SALA_EMPL_OFIC(job_emp);
  
  dbms_output.put_line('Suma total de salarios : ' || total_sum_salaries);
END;

/*
 03. Elaborar un Procedimiento Almacenado SP_REGI_OFIC que realice una inserci�n de registros 
     a la tabla JOBS. Usando excepciones predefinidas muestre el mensaje �Ya existe un oficio con 
     el c�digo ingresado� a trav�s del gestor DUP_VAL_ON_INDEX y muestre el n�mero y mensaje 
     de error de las funciones SQLCODE y SQLERRM a trav�s del gestor OTHERS
*/

CREATE OR REPLACE PROCEDURE SP_REGI_OFIC (
 v_job_id     jobs.job_id%type,
 v_job_title  jobs.job_title%type,
 v_min_salary jobs.min_salary%type,
 v_max_salary jobs.max_salary%type
)
AS
BEGIN
  INSERT INTO jobs VALUES
    (v_job_id, v_job_title, v_min_salary, v_max_salary);
  
  dbms_output.put_line('Nuevo oficio registrado');
  COMMIT;
  
  EXCEPTION
    WHEN dup_val_on_index THEN
      dbms_output.put_line('Ya existe un oficio con el c�digo ingresado');
    WHEN others THEN
      dbms_output.put_line('Codigo de error  :' || sqlcode);
      dbms_output.put_line('Mensaje de error :' || sqlerrm);
END;

SELECT * FROM jobs;
EXECUTE SP_REGI_OFIC('AV_TEST1', 'Probando 01', 3500, 8000);
EXECUTE SP_REGI_OFIC('AV_TEST2', 'Probando 02', 4500, 9000);
EXECUTE SP_REGI_OFIC('AV_TEST2', 'Probando 03', 4800, 8500);

/*
 04. Elaborar un Procedimiento Almacenado SP_LIST_EMPL_OFIC_DEPA que reciba el oficio y el 
     departamento y luego muestre el c�digo, el nombre y el apellido concatenado, el correo, la 
     fecha de contrataci�n y el salario de todos los empleados (tabla EMPLOYEES). En caso no 
     exista el oficio o el departamento, usando excepciones definidas por el usuario env�e los 
     siguientes mensajes �No existe el oficio y el departamento�, �El oficio no existe� y �El 
     departamento no existe�.
*/

CREATE OR REPLACE PROCEDURE SP_LIST_EMPL_OFIC_DEPA (
  v_job_title        jobs.job_title%type,
  v_department_name  departments.department_name%type
)
IS
  exception1 EXCEPTION;
  exception2 EXCEPTION;
  exception3 EXCEPTION;
  count1 NUMBER;
  count2 NUMBER;
BEGIN

  SELECT COUNT(*) INTO count1 
  FROM jobs WHERE job_title = v_job_title;
  
  SELECT COUNT(*) INTO count2 
  FROM departments WHERE department_name = v_department_name;

  IF count1 = 0 AND count2 = 0 THEN
    RAISE exception1;
  ELSE IF count1 = 0 THEN
    RAISE exception2;
  ELSE IF count2 = 0 THEN
    RAISE exception3;
  ELSE
    DECLARE
      CURSOR emp_list IS
      SELECT e.employee_id,
             e.first_name || ' ' || e.last_name,
             e.email,
             e.hire_date,
             e.salary
      FROM employees e
      JOIN jobs j
        ON e.job_id = j.job_id
      JOIN departments d
        ON e.department_id = d.department_id
      WHERE j.job_title = v_job_title AND 
            d.department_name = v_department_name;
     
      v_emp_id     employees.employee_id%type;
      v_full_name  VARCHAR(50);
      v_email      employees.email%type;
      v_hire_date  employees.hire_date%type;
      v_salary     employees.salary%type;
    BEGIN
      OPEN emp_list;
      
      LOOP
        FETCH emp_list INTO 
          v_emp_id, v_full_name, v_email, v_hire_date, v_salary;
        EXIT WHEN emp_list%notfound;
        
        dbms_output.put_line('Empleado ID       : ' || v_emp_id);
        dbms_output.put_line('--Nombre completo : ' || v_full_name);
        dbms_output.put_line('--Email           : ' || v_email);
        dbms_output.put_line('--Fecha contrato  : ' || v_hire_date);
        dbms_output.put_line('--Salario         : ' || v_salary);
        dbms_output.put_line('');
        dbms_output.put_line('------------------------------------');
        dbms_output.put_line('');

      END LOOP;
      
      CLOSE emp_list;

    END;
   END IF;
   END IF; 
   END IF;

   EXCEPTION
     WHEN exception1 THEN
       dbms_output.put_line('No existe el oficio y el departamento');
     WHEN exception2 THEN
       dbms_output.put_line('El oficio no existe');
     WHEN exception3 THEN
       dbms_output.put_line('El departamento no existe');
END;

EXECUTE SP_LIST_EMPL_OFIC_DEPA('Programmerx', 'ITx');
EXECUTE SP_LIST_EMPL_OFIC_DEPA('Programmerx', 'IT');
EXECUTE SP_LIST_EMPL_OFIC_DEPA('Programmer', 'ITx');

EXECUTE SP_LIST_EMPL_OFIC_DEPA('Programmer', 'IT');

/*

ESTE NO FUNCIONA XD

CREATE OR REPLACE PROCEDURE SP_LIST_EMPL_OFIC_DEPA (
  v_job_title        jobs.job_title%type,
  v_department_name  departments.department_name%type
)
IS
  exception1 EXCEPTION;
  exception2 EXCEPTION;
  exception3 EXCEPTION;
  count1 NUMBER;
  count2 NUMBER;
BEGIN

  SELECT COUNT(*) INTO count1 
  FROM jobs WHERE job_title = v_job_title;
  
  SELECT COUNT(*) INTO count2 
  FROM departments WHERE department_name = v_department_name;

  IF count1 = 0 AND count2 = 0 THEN
    RAISE exception1;
  ELSE IF count1 = 0 THEN
    RAISE exception2;
  ELSE IF count2 = 0 THEN
    RAISE exception3;
  ELSE
    SELECT e.employee_id as CODIGO,
           e.first_name || ' ' || e.last_name as NOMBRE_COMPLETO,
           e.email as EMAIL,
           e.hire_date as FECHA_CONTRATACION,
           e.salary as SALARIO
    FROM employees e
    JOIN jobs j
      ON e.job_id = j.job_id
    JOIN departments d
      ON e.department_id = d.department_id
    WHERE j.job_title = v_job_title AND 
          d.department_name = v_department_name;
   END IF;
   END IF; 
   END IF;

   EXCEPTION
     WHEN exception1 THEN
       dbms_output.put_line('No existe el oficio y el departamento');
     WHEN exception2 THEN
       dbms_output.put_line('El oficio no existe');
     WHEN exception3 THEN
       dbms_output.put_line('El departamento no existe');
END;
*/
























