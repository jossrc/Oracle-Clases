

/* PREGUNTA 01 by Jose Robles*/

-- a

INSERT INTO barco VALUES
  ('B99','BARCO ROBLES', '27/05/99', '3', '120');
  
-- b

UPDATE empleado
  SET habbasico_emp = habbasico_emp + habbasico_emp*0.12
WHERE
  codigo_emp = 'E01';

-- c

DELETE FROM barco
  WHERE codigo_bar = 'B99';
  
/* PREGUNTA 02 by Jose Robles */

-- a

SELECT RPAD(LPAD(SUBSTR(apepaterno_emp, -1, 1), 3, '*'),5,'*') PreguntaA
FROM empleado
WHERE MOD(LENGTH(apepaterno_emp), 2) <> 0;

-- b

SELECT REGEXP_REPLACE(TRIM(to_char(sysdate, '"Hoy es" Day"," DD "de" Month "del" yyyy')), '   ') PreguntaB
FROM dual;

-- c

SELECT '"'||NEXT_DAY(sysdate, 'Miércoles') ||' - QUE LA FUERZA NOS ACOMPAÑE"' PreguntaC
FROM dual;

/* PREGUNTA 03 by Jose Robles */

SET SERVEROUTPUT ON;

DECLARE
  v_nombre_bar barco.nombre_bar%type := '&NOMBRE_BAR';
  v_canti_emp NUMBER;
BEGIN
  
  SELECT COUNT(*) INTO v_canti_emp
  FROM empleado e
  JOIN barco b
    ON e.codigo_bar = b.codigo_bar
  WHERE b.nombre_bar = v_nombre_bar;
  
  IF v_canti_emp > 1 THEN
    dbms_output.put_line('El barco tiene muchos empleados');
  ELSE
    dbms_output.put_line('El barco tiene un solo empleado');
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Barco no existe');
END;

/* PREGUNTA 04 by Jose Robles */

DECLARE
  CURSOR cur_esp(cadenax especie.nombre_esp%type) IS
  SELECT codigo_esp, nombre_esp FROM especie
    WHERE nombre_esp LIKE cadenax||'%';
    
  v_regi cur_esp%rowtype;
  v_cadena especie.nombre_esp%type := '&CADENA';
BEGIN
  OPEN cur_esp(v_cadena);
  
    LOOP
      FETCH cur_esp INTO v_regi;
      EXIT WHEN cur_esp%NOTFOUND;
      
      dbms_output.put_line('Código: '|| v_regi.codigo_esp);
      dbms_output.put_line('Especie: '|| v_regi.nombre_esp);
      dbms_output.put_line(''); 
         
    END LOOP;

    dbms_output.put_line('------------------------------------------');
    dbms_output.put_line('Total de Especies Mostradas: '||cur_esp%rowcount);
  CLOSE cur_esp;
END;
