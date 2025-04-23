-- 2/4/25
-- Practica.Mirar si es igual, mayor o menor
declare
    x int;
    y int;
begin
    x:=6;
    y:=6;
    if x=y then
        dbms_output.put_line('son iguales');
    elsif x>y then
        dbms_output.put_line (x || 'es mas grande');
    else
        dbms_output.put_line(y || 'es mas grande')
    end if;
end;
/

-- Teoria. Case
DECLARE
    nota INTEGER:=7;
    nota VARCHAR2(20);
BEGIN
    resultat.= case nota
                when 5 then 'Suficient'
                WHEN 6 THEN 'Bé'
                WHEN 7 THEN 'Notable'
                WHEN 8 THEN 'Notable'
                WHEN 9 THEN 'Excel·lent'
                WHEN 10 THEN 'Matriculat'
                ELSE 'No assolit'
            END;
        dbms_output.put_line(resultat);
END;


-- Teoria. While
DECLARE
    x INTEGER;
BEGIN
    X:=0;
    WHILE (x<=10) LOOP
        dbms_output.put_line(x);
        x:=x+1;
    END LOOP;
END;

-- Teoria. For
BEGIN
    FOR i IN 0..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;

-- Teoria. For inverso
BEGIN
    FOR i IN REVERSE 0..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;


-- Teoria. Bucle infinito

DECLARE
    x INTEGER;
BEGIN
    x:=0;
    LOOP
        dbms_output.put_line(x);
        x:=x+1;
        EXIT WHEN x=10;
    END LOOP;
END;

-- 5. Crea la taula de multiplicar del número 3. TEORIA GUARDAR MODULO
CREATE procedure prolema5 IS
    x INTEGER;
    resultat INTEGER;
BEGIN
    FOR i IN 0..10 LOOP
    resultat := 3 * i;
    dbms_output.put_line('3 x' || i || ' = ' || resultat);
    END LOOP;
END;

-- Eliminar procedimiento
DROP procedure problema5;

-- Remplazar
CREATE or REPLACE procedure prolema5 IS
    x INTEGER;
    resultat INTEGER;
BEGIN
    FOR i IN 0..10 LOOP
    resultat := 3 * i;
    dbms_output.put_line('3 x' || i || ' = ' || resultat);
    END LOOP;
END;


CREATE TABLE persona(
    id INTEGER primary key,
    nom VARCHAR2(50) NOT NULL,
    sou FLOAT CHECK(sou>=1200)
);
 
 
INSERT INTO persona VALUES(1, 'Jordi', 1500);
 
 
/************ Donar d'alta persona **********/
 
CREATE OR REPLACE PROCEDURE alta_persona(
                                p_id INTEGER,
                                p_nom VARCHAR2,
                                p_sou FLOAT
                            )
IS
BEGIN
    IF (p_nom IS NOT NULL) THEN
        IF (p_sou>=1200) THEN
            INSERT INTO persona VALUES(p_id, p_nom, p_sou);
            DBMS_OUTPUT.put_line('S''ha donat d''alta la persona');
        ELSE
            DBMS_OUTPUT.put_line('Error: El sou ha de ser almenys de 1200');
        END IF;
    ELSE
        DBMS_OUTPUT.put_line('Error: El nom és obligatori');
    END IF;
END;
/
 
EXECUTE alta_persona(2, 'Pere', 2000);
 
EXECUTE alta_persona(3, 'Alba', 1000);
 
 
EXECUTE alta_persona(3, NULL, 2000);


-- //
CREATE OR REPLACE PROCEDURE consulta_persona(
                                p_id integer
                            )

IS
    x INTEGER;
    t VARCHAR2(50);
    z FLOAT;
    aux := existe_persona(p_id)
BEGIN
    select count(*) into aux from persona where id_p=id
    if (aux > 0) then
        select id, nom, sou
        into x, y, z
        from persona
        where id = p_id
        dbms_output.put_line('************************')
        dbms_output.put_line('******* PERSONA ********')
        dbms_output.put_line('ID: ' || x)
        dbms_output.put_line('Nom: ' || y)
        dbms_output.put_line('Sou: ' || z)
    else
        dbms_output.put_line('Error')

-- //

CREATE OR REPLACE FUNCTION existe_persona(p_id integer)
                                return integer

IS
    aux integer;
BEGIN
    select count(*) into aux from persona where id = p_id
    return aux;
END;
/

-- //