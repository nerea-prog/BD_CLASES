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




-- 22. Crea un procediment que permeti eliminar les dades d’un pokemon. Aquest
-- procediment rebrà com a paràmetre d’entrada el número de pokedex.

CREATE OR REPLACE PROCEDURE problema22(
    p_numero_pokedex IN NUMBER
)
IS
    v_existeix NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existeix
    FROM POKEMON
    WHERE NUMERO_POKEDEX = p_numero_pokedex;


    IF v_existeix = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No s''ha trobat cap Pokémon amb aquest número de Pokédex.');
    ELSE
        DELETE FROM ESTADISTICAS_BASE WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DELETE FROM POKEMON_TIPO WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DELETE FROM EVOLUCIONA_DE WHERE POKEMON_ORIGEN = p_numero_pokedex;
        DELETE FROM EVOLUCIONA_DE WHERE POKEMON_EVOLUCIONADO = p_numero_pokedex;
        DELETE FROM POKEMON WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DBMS_OUTPUT.PUT_LINE('Pokémon i tots els registres relacionats eliminats correctament.');
    END IF;
END;
/

-- 23. Amplia el procediment anterior de forma que es faci abans de la eliminació una
-- comprovació de si el pokemon existeix o no. Si no existeix hauria de mostrar un
-- missatge per pantalla informat que no existeix cap pokemon amb el codi
-- introduït, mentre que si existeix, hauria de mostrar les dades del pokemon
-- eliminat. Es pot realitzar aquest exercici mitjançant una crida al procediment fet
-- a l’exercici 14 o 15.

CREATE OR REPLACE PROCEDURE problema23(
    p_numero_pokedex IN NUMBER
)
IS
    v_existeix int;
    v_numero_pokedex pokemon.numero_pokedex%type;
    v_nombre pokemon.nombre%type;
    v_peso pokemon.peso%type;
    v_altura pokemon.altura%type;
BEGIN
    SELECT COUNT(*) INTO v_existeix
    FROM POKEMON
    WHERE NUMERO_POKEDEX = p_numero_pokedex;

    IF v_existeix = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No s''ha trobat cap Pokémon amb aquest número de Pokédex.');
    ELSE
        SELECT p.numero_pokedex, p.nombre, p.peso, p.altura
        into v_numero_pokedex, v_nombre, v_peso, v_altura
        from pokemon p
        WHERE p.numero_pokedex = p_numero_pokedex;
        DELETE FROM ESTADISTICAS_BASE WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DELETE FROM POKEMON_TIPO WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DELETE FROM EVOLUCIONA_DE WHERE POKEMON_ORIGEN = p_numero_pokedex;
        DELETE FROM EVOLUCIONA_DE WHERE POKEMON_EVOLUCIONADO = p_numero_pokedex;
        DELETE FROM POKEMON WHERE NUMERO_POKEDEX = p_numero_pokedex;
        DBMS_OUTPUT.PUT_LINE('******** Pokémon eliminat *********');
        DBMS_OUTPUT.PUT_LINE('Numero pokedex: ' || v_numero_pokedex);
        DBMS_OUTPUT.PUT_LINE('Nom: ' || v_nombre);
        DBMS_OUTPUT.PUT_LINE('Pes: ' || v_peso);
        DBMS_OUTPUT.PUT_LINE('Altura: ' || v_altura);

    END IF;
END;
/


-- 24. Crea un procediment que permeti donar d’alta un nou pokemon. Aquest
-- procediment rebrà com a paràmetres d’entrada el número de pokedex, nom, pes
-- i alçada

create or replace procedure ejercici24(
    p_numero_pokedex pokemon.numero_pokedex%type, 
    p_nombre pokemon.nombre%type, 
    p_peso pokemon.peso%type,
    p_altura pokemon.numero_pokedex%type
    )
IS
    existe int;
BEGIN
    SELECT COUNT(*)
    into existe
    from pokemon
    where p_numero_pokedex = numero_pokedex;
    IF existe = 0 then
        IF p_nombre is not NULL then
            IF p_peso is not null THEN
                if p_altura is not null THEN
                    INSERT into pokemon values(p_numero_pokedex, p_nombre, p_peso, p_altura);
                    dbms_output.put_line('Pokemon creado');
                else
                    dbms_output.put_line('Error: Se tiene que definir una altura');
                end if;
            ELSE
                dbms_output.put_line('Error: Se tiene que definir un peso');
            end if;
        ELSE
            dbms_output.put_line('Error: Se tiene que definir un nombre');
        end if;
    ELSE
        dbms_output.put_line('Error: El pokemon ya existe');
    end if;
end;
/

-- 25. Amplia el procediment anterior de forma que no rebi com a paràmetre el número
-- de pokedex, sinó que el propi procediment obtingui l’últim codi assignat i li
-- assigni al nou pokemon l’últim +1. Si el procediment ha finalitzat correctament,
-- hauria de mostrar el codi assignat (ex: S’ha donat d’alta el pokemon i se li ha
-- assignat el codi: XXXX)
create or replace procedure ejercici25(
    p_nombre pokemon.nombre%type, 
    p_peso pokemon.peso%type,
    p_altura pokemon.numero_pokedex%type
    )
IS
    existe int;
    aux int;
BEGIN
    SELECT COUNT(*)
    into existe
    from pokemon
    where aux = numero_pokedex;
    select max(numero_pokedex)
    into aux
    from pokemon;
    aux:=aux + 1;
    IF existe = 0 then
        IF p_nombre is not NULL then
            IF p_peso is not null THEN
                if p_altura is not null THEN
                    INSERT into pokemon values(aux, p_nombre, p_peso, p_altura);
                    dbms_output.put_line('Pokemon creado');
                else
                    dbms_output.put_line('Error: Se tiene que definir una altura');
                end if;
            ELSE
                dbms_output.put_line('Error: Se tiene que definir un peso');
            end if;
        ELSE
            dbms_output.put_line('Error: Se tiene que definir un nombre');
        end if;
    ELSE
        dbms_output.put_line('Error: El pokemon ya existe');
    end if;
end;
/

-- 26. Amplia el procediment anterior de forma que rebi com a paràmetres d’entrada el
-- tipus de pokemon. El procediment hauria de comprovar que existeixi el tipus i el
-- projecte. Si és així fer l’alta de pokemon i si no, mostrar l’error corresponent .

CREATE OR REPLACE PROCEDURE ejercici25(
    p_nombre pokemon.nombre%TYPE, 
    p_peso pokemon.peso%TYPE,
    p_altura pokemon.altura%TYPE, -- Asumimos que p_altura es un campo de altura del Pokémon
    p_id_tipo pokemon.id_tipo%TYPE  -- Parámetro para el id_tipo del Pokémon
)
IS
    existe INT;
    aux INT;
    tipo_existe INT;
BEGIN
    -- Verificar si el Pokémon ya existe por el número de Pokédex
    SELECT COUNT(*)
    INTO existe
    FROM pokemon
    WHERE numero_pokedex = p_altura;  -- Verificamos si ya existe un Pokémon con este número de Pokédex
    
    -- Obtener el siguiente número del Pokédex si no existe
    SELECT MAX(numero_pokedex)
    INTO aux
    FROM pokemon;
    aux := aux + 1;

    -- Comprobar si el tipo de Pokémon existe en la tabla pokemon_tipo
    SELECT COUNT(*)
    INTO tipo_existe
    FROM pokemon_tipo
    WHERE id_tipo = p_id_tipo;

    -- Validación de los parámetros
    IF existe = 0 THEN
        IF p_nombre IS NOT NULL THEN
            IF p_peso IS NOT NULL THEN
                IF p_altura IS NOT NULL THEN
                    -- Si el tipo existe, insertar Pokémon
                    IF tipo_existe = 1 THEN
                        INSERT INTO pokemon (numero_pokedex, nombre, peso, altura)
                        VALUES (aux, p_nombre, p_peso, p_altura);
                        DBMS_OUTPUT.PUT_LINE('Pokémon creado con éxito');
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('Error: El tipo de Pokémon no existe');
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Error: Se tiene que definir una altura');
                END IF;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Error: Se tiene que definir un peso');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Se tiene que definir un nombre');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: El Pokémon ya existe');
    END IF;
END;
/

-- 27
CREATE OR REPLACE PROCEDURE modificar_atac_pokemon(
    p_numero_pokedex IN NUMBER,
    p_nou_atac IN NUMBER
) IS
    v_atac_actual NUMBER;
    v_atac_maxim NUMBER;
BEGIN
    -- Verificamos si existe el Pokémon con el número de Pokedex
    BEGIN
        SELECT ataque INTO v_atac_actual
        FROM estadisticas_base
        WHERE numero_pokedex = p_numero_pokedex;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: No se encontró el Pokémon con el número de Pokedex ' || p_numero_pokedex);
            RETURN;
    END;

    v_atac_maxim := v_atac_actual * 1.15;

    IF p_nou_atac >= v_atac_actual AND p_nou_atac <= v_atac_maxim THEN
        UPDATE estadisticas_base
        SET ataque = p_nou_atac
        WHERE numero_pokedex = p_numero_pokedex;

        DBMS_OUTPUT.PUT_LINE('El ataque ha sido actualizado correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: El nuevo ataque debe ser al menos ' || v_atac_actual || ' y como máximo ' || v_atac_maxim);
    END IF;
END;
/



-- 29. Crea un procediment que mostri per a cada tipus de pokemon el nombre de
-- pokemons que són d’aquest tipus.

create or replace procedure problema29
is
    cursor cursorcito is select *
    from tipo;
    pokemon_total int;
begin
    for x in cursorcito loop
        select count(*)
        into pokemon_total
        from pokemon p
        join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
        where pt.id_tipo = x.id_tipo;
        DBMS_OUTPUT.PUT_LINE('Tipo pokemon: ' || x.nombre || ' nombre de pokemons: ' || pokemon_total);
    end loop;
end;
/


-- 30. Crea un procediment que rebi un tipus de pokemon i mostri per pantalla el
-- nom de tots els pokèmon que siguin d’aquest tipus.

create or replace procedure problema30(
    p_tipo pokemon_tipo.id_tipo%type
)
is
    cursor cursorcito is
        select *
        from pokemon p
        join pokemon_tipo pt on pt.numero_pokedex = p.numero_pokedex
        where pt.id_tipo = p_tipo; 
begin
    for x in cursorcito loop
        dbms_output.put_line('De tipo ' || x.id_tipo || ' es: ' || x.nombre);
    end loop;
end;
/
CREATE OR REPLACE PROCEDURE problema30(
    p_tipo pokemon_tipo.id_tipo%TYPE
) IS
    -- Definició del cursor amb el JOIN entre taules
    CURSOR cursorcito IS
        SELECT p.nombre, pt.id_tipo
        FROM pokemon p
        JOIN pokemon_tipo pt ON pt.numero_pokedex = p.numero_pokedex
        WHERE pt.id_tipo = p_tipo;
BEGIN
    -- Iterar sobre els resultats del cursor
    FOR x IN cursorcito LOOP
        DBMS_OUTPUT.PUT_LINE('De tipo ' || x.id_tipo || ' es: ' || x.nombre);
    END LOOP;
END;
/


-- 31
CREATE OR REPLACE PROCEDURE mostra_pokemon_per_nom(
    p_subcadena IN VARCHAR2
) IS
    CURSOR cursorcito IS
        SELECT *
        FROM pokemon p
        WHERE p.nombre LIKE '%' || p_subcadena || '%';
    
    v_count INTEGER := 0;
BEGIN
    FOR x IN cursorcito LOOP
        DBMS_OUTPUT.PUT_LINE(x.nombre);
        v_count := v_count + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total de pokemon visualitzats: ' || v_count);
END;
/



-- 32
CREATE OR REPLACE PROCEDURE mostra_3_pokemon_mes_atac IS
    CURSOR cursorcito IS
        SELECT p.nombre
        FROM pokemon p
        JOIN estadisticas_base e ON p.numero_pokedex = e.numero_pokedex
        FETCH FIRST 3 ROWS ONLY;  -- Per versions d'Oracle 12c o posteriors
BEGIN
    FOR x IN cursorcito LOOP
        DBMS_OUTPUT.PUT_LINE('Pokémon: ' || x.nombre);
    END LOOP;
END;
/

