-- 1: Sintaxi i programació bàsica
    -- 3. Fes un codi que a partir d’un número que representarà el dia de la setmana el
    -- mostri en format text (1 → Dilluns, 2 → Dimarts...)

DECLARE
    dias INT := 7;
    resultat VARCHAR(20);
BEGIN
    resultat:= CASE dias
                WHEN 1 THEN 'Dilluns'
                WHEN 2 THEN 'Dimarts'
                WHEN 3 THEN 'Dimecres'
                WHEN 4 THEN 'Dijous'
                WHEN 5 THEN 'Divendres'
                WHEN 6 THEN 'Dissabte'
                WHEN 7 THEN 'Diumenge'
                ELSE 'Error la has cagado'
            END;
    dbms_output.put_line(resultat);
END;
/ 

-- 5. Crea la taula de multiplicar del número 3
DECLARE
    x INTEGER;
    resultat INTEGER;
BEGIN
    FOR i IN 0..10 LOOP
    resultat := 3 * i;
    dbms_output.put_line('3 x' || i || ' = ' || resultat);
    END LOOP;
END;

-- 6. mostrar un triangle de 10 files, a la primera fila el valor 1, a la segona fila 12, a
-- la tercera 123...
DECLARE
    texto VARCHAR2(30);
BEGIN
    FOR i in 1..10 LOOP
        texto:= texto || i || ' ';
        dbms_output.put_line(texto);
    END LOOP;
END;

