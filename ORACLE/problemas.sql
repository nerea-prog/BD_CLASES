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


-- 20. 
CREATE OR REPLACE PROCEDURE fitxa_pokemon(p_numero int)
IS
    p_numero_pokedex INT;
    p_nombre VARCHAR2(30);
    p_peso FLOAT;
    p_altura FLOAT;
    contador INT;
BEGIN
    select count(*)
    into contador
    from pokemon
    where numero_pokedex = p_numero;
    IF contador > 0 THEN
        IF p_numero > 0 THEN
            select numero_pokedex, nombre, peso, altura
            into p_numero_pokedex, p_nombre, p_peso, p_altura
            from pokemon
            where numero_pokedex = p_numero;
            DBMS_OUTPUT.PUT_LINE('--- FITXA DEL POKEMON ---');
            DBMS_OUTPUT.PUT_LINE('Número Pokédex: ' || p_numero_pokedex);
            DBMS_OUTPUT.PUT_LINE('Nombre: ' || p_nombre);
            DBMS_OUTPUT.PUT_LINE('Peso: ' || p_peso || ' kg');
            DBMS_OUTPUT.PUT_LINE('Altura: ' || p_altura || ' cm');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El pokemon no existe');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No hay pokemons');
    END IF;
END;
/

-- 21.
CREATE OR REPLACE PROCEDURE fitxa_pokemon(p_numero int)
IS
    p_numero_pokedex pokemon.numero_pokedex%type;
    p_nombre pokemon.nombre%type;
    p_peso pokemon.peso%type;
    p_altura pokemon.altura%type;
    eb_ps estadisticas_base.ps%type;
    eb_numero_pokedex estadisticas_base.numero_pokedex%type;
    eb_ataque estadisticas_base.ataque%type;
    eb_defensa estadisticas_base.defensa%type;
    eb_especial estadisticas_base.especial%type;
    eb_velocidad estadisticas_base.velocidad%type;
BEGIN
    select p.numero_pokedex, p.nombre, p.peso, p.altura,
    eb.numero_pokedex, eb.ps, eb.ataque, eb.defensa, eb.especial, eb.velocidad
    into p_numero_pokedex, p_nombre, p_peso, p_altura,
    eb_numero_pokedex, eb_ps, eb_ataque, eb_defensa, eb_especial, eb_velocidad
    from pokemon p
    join estadisticas_base eb on  p.numero_pokedex = eb.numero_pokedex
    where p.numero_pokedex = p_numero;

    DBMS_OUTPUT.PUT_LINE('--- FITXA DEL POKEMON ---');
    DBMS_OUTPUT.PUT_LINE('Número Pokédex: ' || p_numero_pokedex);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || p_nombre);
    DBMS_OUTPUT.PUT_LINE('Peso: ' || p_peso || ' kg');
    DBMS_OUTPUT.PUT_LINE('Altura: ' || p_altura || ' cm');
    DBMS_OUTPUT.PUT_LINE('Ps: ' || eb_ps);
    DBMS_OUTPUT.PUT_LINE('Ataque: ' || eb_ataque);
    DBMS_OUTPUT.PUT_LINE('Defensa: ' || eb_defensa);
    DBMS_OUTPUT.PUT_LINE('Especial: ' || eb_especial);
    DBMS_OUTPUT.PUT_LINE('Velocidad: ' || eb_velocidad);
EXCEPTION
    when no_data_found then
    dbms_output.put_line('Error: No existeix el codi');
END;
/

-- 28. Crea un procediment que mostri les dades de tots els pokemon
-- ordenats alfabèticament per nom

CREATE OR REPLACE PROCEDURE problema28
IS
    cursor cursorcito is select * from pokemon order by nombre;
BEGIN
    for aux in cursorcito LOOP
        dbms_output.put_line('--- POKEMON ---');
        dbms_output.put_line('Numero de pokedex ' || aux.numero_pokedex);
        dbms_output.put_line('Nombre del pokemon: ' || aux.nombre);
        dbms_output.put_line('Peso: ' || aux.peso || ' kg');
        dbms_output.put_line('Altura: ' || aux.altura || ' cm');
    end LOOP;
end;
/