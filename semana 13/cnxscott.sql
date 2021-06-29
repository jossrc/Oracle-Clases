-- Configurar la salida
SET SERVEROUTPUT ON;

-- Creación de Paquetes

/* Contenedor de objetos (Procedimientos y Funciones)

--------------------------------

-- Estructura
1.- Encabezado del paquete o especificaciones: CREATE PACKAGE
    Aquí se crea los procedimientos o funciones con sus parámetros

2.- Cuerpo del paquete: CREATE PACKAGE BODY
    Aquí se escribe o edita el cuerpo del procedimiento o función. La lógica
    
*/

SELECT * FROM Bonus;
-- Paquete
-- Encabezado del paquete

CREATE OR REPLACE PACKAGE pkgBonus IS

  PROCEDURE usp_ingresaBonus (
    p_ename bonus.ename%type, 
    p_job bonus.job%type, 
    p_sal number, 
    p_comm number
  );
  
  PROCEDURE usp_eliminaBonus (
    p_ename bonus.ename%type
  );
  
  FUNCTION fn_obtenerSalario (
    p_ename bonus.ename%type
  ) RETURN number;

END pkgBonus;
-- Cuerpo del Paquete
CREATE OR REPLACE PACKAGE BODY pkgBonus IS

  PROCEDURE usp_ingresaBonus (
    p_ename bonus.ename%type, 
    p_job bonus.job%type, 
    p_sal number, 
    p_comm number
  ) IS
  BEGIN
    INSERT INTO bonus VALUES
      (p_ename, p_job, p_sal, p_comm);
  EXCEPTION
    WHEN dup_val_on_index THEN
      dbms_output.put_line('Dato Repetido');
  END usp_ingresaBonus;

  -------------------------------------------

  PROCEDURE usp_eliminaBonus (
    p_ename bonus.ename%type
  ) IS
    v_job VARCHAR2(30);
  BEGIN
    SELECT job INTO v_job 
    FROM bonus
    WHERE ename = p_ename;
  
    DELETE FROM bonus
    WHERE ename = p_ename;  
  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('Dato no existe');
  END usp_eliminaBonus;
  
  -------------------------------------------

  FUNCTION fn_obtenerSalario (
    p_ename bonus.ename%type
  ) RETURN number IS
    v_retornar NUMBER;
  BEGIN
    SELECT sal INTO v_retornar
    FROM bonus
    WHERE ename = p_ename;
    
    RETURN v_retornar;
  END fn_obtenerSalario;  

END pkgBonus;

---- Ejecutando el Package ----

BEGIN
  pkgbonus.usp_ingresaBonus('Coco', 'Analista', '2500', '150');
END;

-------

BEGIN
  dbms_output.put_line(pkgbonus.fn_obtenerSalario('Coco'));
END;

-------

BEGIN
  pkgbonus.usp_eliminaBonus('Coco');
END;

-------------------------------------------

SELECT * FROM salgrade;

