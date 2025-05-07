-- 1   CREATE
create or replace procedure NouAlumne(p_nom estudiant.nom%type,
                                    p_anyo estudiant.anyo%type,
                                    p_casa estudiant.casa_id%type)
IS
    aux int;
    aux2 int;
BEGIN
    select count(*)
    into aux
    from casa 
    where id = p_casa;
    select max(id)
    into aux2
    from estudiant;
    if aux = 1 THEN
        if p_anyo is not null then
            if p_nom is not null then
                if (p_anyo >= 1 and p_anyo <= 7) then
                    insert into estudiant values(aux2 + 1, p_nom, p_anyo, p_casa);
                    dbms_output.put_line('Correcte. Codi: ' || (aux2 + 1));
                ELSE
                    dbms_output.put_line('Error: El anny ha de ser entre 1 i 7');
                end if;
            ELSE
                dbms_output.put_line('Error: El nom es obligatori');
            end if;
        ELSE
            dbms_output.put_line('Error: any obligatori');
        end if;
    ELSE
        dbms_output.put_line('Error: No hi ha cap casa');
    end if;
END;
/

-- UPDATE
CREATE OR REPLACE PROCEDURE UpdateAlumne(
    p_id estudiant.id%TYPE,
    p_nom estudiant.nom%TYPE,
    p_anyo estudiant.anyo%TYPE,
    p_casa estudiant.casa_id%TYPE
) IS
    existeix INTEGER;
    casa_existeix INTEGER;
BEGIN
    -- Comprovar si l'alumne existeix
    SELECT COUNT(*) INTO existeix FROM estudiant WHERE id = p_id;

    -- Comprovar si la casa existeix
    SELECT COUNT(*) INTO casa_existeix FROM casa WHERE id = p_casa;

    IF existeix = 1 THEN
        IF casa_existeix = 1 THEN
            -- Si l'alumne existeix i la casa existeix, comprovem el nom
            IF p_nom IS NOT NULL THEN
                -- Si el nom no és nul, comprovem que l'any estigui entre 1 i 7
                IF p_anyo BETWEEN 1 AND 7 THEN
                    -- Realitzem l'update
                    UPDATE estudiant
                    SET nom = p_nom, anyo = p_anyo, casa_id = p_casa
                    WHERE id = p_id;
                    DBMS_OUTPUT.put_line('Alumne actualitzat correctament');
                ELSE
                    DBMS_OUTPUT.put_line('Error: L''any ha de ser entre 1 i 7');
                END IF;
            ELSE
                DBMS_OUTPUT.put_line('Error: El nom no pot ser nul');
            END IF;
        ELSE
            DBMS_OUTPUT.put_line('Error: La casa no existeix');
        END IF;
    ELSE
        DBMS_OUTPUT.put_line('Error: No existeix cap alumne amb aquest codi');
    END IF;
END;
/




-- DELETE
CREATE OR REPLACE PROCEDURE DeleteAlumne(p_id estudiant.id%TYPE) IS
    existeix INTEGER;
BEGIN
    -- Comprovem si existeix l'alumne amb el codi donat
    SELECT COUNT(*) INTO existeix FROM estudiant WHERE id = p_id;

    IF existeix = 1 THEN
        -- Si existeix, es pot eliminar
        DELETE FROM estudiant WHERE id = p_id;
        DBMS_OUTPUT.put_line('Alumne eliminat correctament');
    ELSE
        -- Si no existeix, es mostra missatge d'error
        DBMS_OUTPUT.put_line('Error: Alumne no trobat');
    END IF;
END;
/




-- READ
CREATE OR REPLACE PROCEDURE ConsultaAlumne(p_id estudiant.id%TYPE) IS
    v_nom estudiant.nom%TYPE;
    v_anyo estudiant.anyo%TYPE;
    v_casa estudiant.casa_id%TYPE;
    existeix INTEGER;
BEGIN
    SELECT COUNT(*) INTO existeix FROM estudiant WHERE id = p_id;

    IF existeix = 1 THEN
        -- Si existeix l'alumne, obtenim les dades
        SELECT nom, anyo, casa_id INTO v_nom, v_anyo, v_casa
        FROM estudiant
        WHERE id = p_id;

        DBMS_OUTPUT.put_line('--- Dades Alumne ---');
        DBMS_OUTPUT.put_line('Nom: ' || v_nom);
        DBMS_OUTPUT.put_line('Any: ' || v_anyo);
        DBMS_OUTPUT.put_line('Casa ID: ' || v_casa);
    ELSE
        -- Si no existeix, mostrem error
        DBMS_OUTPUT.put_line('Error: No existeix cap alumne amb aquest codi');
    END IF;
END;
/



-- 2
create or replace procedure aprova(p_id estudiant.id%type) IS
    v_nom estudiant.nom%type;
    v_anyo estudiant.anyo%type;

BEGIN
    select e.nom, e.anyo
    into v_nom, v_anyo
    from estudiant e
    where id = p_id;
        if v_anyo < 7 THEN
           update estudiant
           set anyo = anyo + 1
           where id = p_id;
           dbms_output.put_line('Correcte(' || v_nom || ') hauria d''estar a ' || (v_anyo + 1)); 
        ELSE
            dbms_output.put_line('Error: No hay mas años');
        end if;
    exception
        when NO_DATA_FOUND then
            dbms_output.put_line('Error: No hi ha el codi');
end;
/

-- 3
CREATE OR REPLACE PROCEDURE consProfe(p_id profe.id%TYPE) IS
    nom_profe profe.nom%TYPE;
    id_casa   casa.id%TYPE;
    nom_casa  casa.nom%TYPE;
    existeix  INTEGER;

    CURSOR c_clase IS 
        SELECT * FROM classes WHERE profe_id = p_id;
BEGIN
    -- Comprovem si el professor existeix
    SELECT COUNT(*) INTO existeix
    FROM profe
    WHERE id = p_id;

    IF existeix = 0 THEN
        DBMS_OUTPUT.put_line('Error: No existeix cap profe amb aquest codi');
    ELSE
        -- Recuperem dades del professor
        SELECT nom, casa_id INTO nom_profe, id_casa
        FROM profe
        WHERE id = p_id;

        DBMS_OUTPUT.put_line('******************************');
        DBMS_OUTPUT.put_line('****** DADES PROFESSOR/A *****');
        DBMS_OUTPUT.put_line('******************************');
        DBMS_OUTPUT.put_line('Nom Professor/a: ' || nom_profe);

        -- Consultem la casa si en té
        IF id_casa IS NOT NULL THEN
            SELECT nom INTO nom_casa
            FROM casa
            WHERE id = id_casa;
        ELSE
            nom_casa := 'No assignat';
        END IF;

        DBMS_OUTPUT.put_line('Nom Casa: ' || nom_casa);
        DBMS_OUTPUT.put_line('Classes que imparteix:');
        DBMS_OUTPUT.put_line('CODI    NOM');

        FOR x IN c_clase LOOP
            DBMS_OUTPUT.put_line(x.id || '      ' || x.nom);  -- o x.materia si és correcte
        END LOOP;
    END IF;
END;
/

                                  