-- 1. Declara 2 variables numèriques anomenades x, y i asigna un valor inicial.
-- Mostra per pantalla quina és més gran i quina més petita o si són iguals

DECLARE
    x int;
    y int;
BEGIN
    x := 9;
    y := 0;
    IF x > y THEN
        DBMS_OUTPUT.PUT_LINE(x || ' es més gran que ' || y);
    ELSE
        DBMS_OUTPUT.PUT_LINE(y || ' es mes gran que ' || x);
    END IF;
END;
/

-- 2. Declara 3 variables numèriques i mostra per pantalla quina té el valor més
-- gran, el més petit i el del mig. Pots suposar que no hi ha valors repetits

SET SERVEROUTPUT ON;

DECLARE
  num1 NUMBER := 10;
  num2 NUMBER := 20;
  num3 NUMBER := 30;
BEGIN
  -- Comparar per trobar el més gran, el més petit i el del mig
  IF num1 > num2 AND num1 > num3 THEN
    DBMS_OUTPUT.PUT_LINE('El valor més gran és: ' || num1);
    IF num2 < num3 THEN
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num2);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num3);
    ELSE
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num3);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num2);
    END IF;
  ELSIF num2 > num1 AND num2 > num3 THEN
    DBMS_OUTPUT.PUT_LINE('El valor més gran és: ' || num2);
    IF num1 < num3 THEN
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num1);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num3);
    ELSE
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num3);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num1);
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('El valor més gran és: ' || num3);
    IF num1 < num2 THEN
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num1);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num2);
    ELSE
      DBMS_OUTPUT.PUT_LINE('El valor més petit és: ' || num2);
      DBMS_OUTPUT.PUT_LINE('El valor del mig és: ' || num1);
    END IF;
  END IF;
END;
/
 -- 3. Fes un codi que a partir d’un número que representarà el dia de la setmana el
-- mostri en format text (1 → Dilluns, 2 → Dimarts...)
DECLARE
    resultat VARCHAR2(30);
    dia int:= 7;
BEGIN
    resultat:=case dia
                    when 1 then 'dilluns'
                    when 2 then 'dimarts'
                    when 3 then 'dimecres'
                    when 4 then 'dijous'
                    when 5 then 'divendres'
                    when 6 then 'dissabte'
                    when 7 then 'diumenge'
                end;
    DBMS_OUTPUT.PUT_LINE(resultat);
END;
/


-- 4. Mostra per pantalla els números de l’1 al 10 en ordre invers, és a dir com un
-- conte enrrere
DECLARE
    i int;
BEGIN
    i := 10;
    while i > 0 loop
        DBMS_OUTPUT.PUT_LINE(i);
        i := i - 1;
    end loop;
end;
/

-- 5. Crea la taula de multiplicar del número 3
declare
    numero int;
BEGIN
    numero := 3;
    for i in 1..10 loop
        DBMS_OUTPUT.PUT_LINE(numero || ' x ' || i || ' = ' || numero*i);
    end loop;
END;
/

-- 6. mostrar un triangle de 10 files, a la primera fila el valor 1, a la segona fila 12, a
-- la tercera 123...
SET SERVEROUTPUT ON;

DECLARE
  i NUMBER; -- Variable per controlar les files
  j NUMBER; -- Variable per controlar els números dins de cada fila
BEGIN
  -- Bucle per cada fila (10 files)
  FOR i IN 1..10 LOOP
    -- Bucle per imprimir els números de la fila (1, 12, 123, ...)
    FOR j IN 1..i LOOP
      -- Imprimeix cada número de la fila
      DBMS_OUTPUT.PUT(j);
    END LOOP;
    -- Salt de línia després de cada fila
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
END;
/

-- PROCEDIMENTS I FUNCIONS

-- 7. Crea un procediment que rebi dos números i mostri per pantalla la seva suma
create or replace procedure ejercici7(num1 int, num2 int)
is
resultat int;
BEGIN
resultat := num1 + num2;
DBMS_OUTPUT.PUT_LINE(resultat);
END;
/

-- 8. Crear un procediment anomenat escriu que rebi una cadena de caràcters i la
-- mostri per pantalla. Aquest procediment ens servirà a partir d’aquest
-- moment com a variant de la funció DBMS_OUTPUT.PUT_LINE

create or replace procedure escriu(p_cadena VARCHAR2) is
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_cadena);
end;
/

-- 9. Crea un procediment que rebi una cadena de caràcters i mostri per pantalla
-- el número de caràcters que té i mostri per pantalla la cadena rebuda però en
-- majúscules i en minúscules
create or replace procedure ejercici9 (p_cadena VARCHAR2) is
BEGIN
    DBMS_OUTPUT.PUT_LINE('Numero de caracters: ' || length(p_cadena));
    DBMS_OUTPUT.PUT_LINE('Cadena en mayuscules: ' || upper(p_cadena));
    DBMS_OUTPUT.PUT_LINE('Cadena en minuscules' || lower(p_cadena));
END;
/

-- 10. Crea un procediment que rebi una cadena de caràcters i mostri per pantalla
-- en quina posició es troba el primer espai en blanc (si no n’hi ha cap o si la
-- cadena és buida informarà d’aquest fet).

create or replace procedure ejercici10(p_cadena VARCHAR2) is
pos int;
BEGIN
    pos := instr(p_cadena, ' ');
    IF pos = 0 then
        DBMS_OUTPUT.PUT_LINE('No hi ha cap espai');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Espai a la posicio: ' || pos);
    end if;
end;
/

-- 11. Crea un procediment que rebi una cadena de caràcters i la visualitzi al revés.
-- Fes servir el bucle FOR.

create or replace procedure ejercici11(p_cadena VARCHAR2) is
BEGIN 
    for i in reverse 1..length(p_cadena) loop
        DBMS_OUTPUT.PUT(substr(p_cadena, i, 1));
    end loop;
    DBMS_OUTPUT.PUT_LINE(' ');
end;
/ 

-- 12. Crea una funció que rebi una data que serà una data de naixement i retorni
-- els anys que tindria la persona.
create or replace function ejercici12(p_data date) return int is
  edat int;
BEGIN
  edat := trunc(months_between(sysdate, p_data) / 12);
  return edat;
END;
/
-- Prova
declare
BEGIN
  DBMS_OUTPUT.PUT_LINE('edat: ' || ejercici12(to_date('18-01-2006', 'DD-MM-YYYY')));
end;
/

-- 13. Crea un procediment que rebi un número i mostri per pantalla la taula de
-- multiplicar d’aquest número

create or replace procedure ejercici13(p_num int) is
BEGIN
  for i in 1..10 loop
    DBMS_OUTPUT.PUT_LINE(p_num || ' X ' || i || ' = ' || p_num*i);
  end loop;
end;
/


-- 14. Crea una funció que rebi un número i retorni el seu factorial. (exemple 5! = 5 *
-- 4 * 3 * 2 * 1)

create or replace function ejercici14(p_num int) return int is
resultat int;
BEGIN
  resultat := 1;
  if p_num < 1 then
    return null;
  end if;
  for i in 1..p_num loop
    resultat := resultat*i;
  end loop;
  return resultat;
end;
/
-- Prova
declare
BEGIN
  DBMS_OUTPUT.PUT_LINE('Factorial de 5: ' || ejercici14(0));
end;
/

-- 15. Fes una funció que rebi dos dates per paràmetre i retorni el nombre d’anys
-- sencers entre elles.

create or replace function ejercici15(p_data1 date, p_data2 date) return int is
edat int;
BEGIN
  edat := trunc(months_between(p_data1, p_data2) / 12);
  return abs(edat);
end;
/
-- Prova
declare
BEGIN
  DBMS_OUTPUT.PUT_LINE('Diferencia de años: ' || 
  ejercici15(to_date('10-10-2010', 'DD-MM-YYYY'),
  to_date('10-10-2025', 'DD-MM-YYYY')));
END;
/

-- 16. Fes una funció que utilitzant la funció anterior, mostri el nombre de triennis
-- que hi ha entre dos dates rebudes per paràmetre.
create or replace function ejercici16(p_data1 date, p_data2 date) return int is
resultat int;
BEGIN
  resultat := ejercici15(p_data1, p_data2);
  return trunc(resultat / 3);
end;
/
-- Prova
declare
BEGIN
  DBMS_OUTPUT.PUT_LINE('Diferencia de años: ' || 
  ejercici16(to_date('10-10-2010', 'DD-MM-YYYY'),
  to_date('10-10-2025', 'DD-MM-YYYY')));
END;
/

-- 17. Fes un procediment que rebi una cadena de caràcters que representarà el
-- nom dMostra el nom de TOTS els planetes i el número de personatges
-- que hi han nascut. Atenció, observa que volem el nom de TOTS els
-- planetes, encara que no hi hagi nascut cap personatge (2 punts)’una
-- persona (per exemple, Jordi Quesada). El procediment ha de mostrar per
-- pantalla el mateix nom però en format J. Quesada. Si la cadena no conté cap
-- espai en blanc o és buida haurà de mostrar per pantalla l’error.

create or replace procedure ejercici17(p_nom VARCHAR2) is
nom varchar2(30);
cognom varchar2(30);
pos int;
BEGIN
  pos := instr(p_nom, ' ');
  if pos = 0 or p_nom is null then
    DBMS_OUTPUT.PUT_LINE('Error: El nom ha de ser o tenir un espai');
  ELSE
    nom := substr(p_nom, 1, pos - 1);
    cognom := substr(p_nom, pos + 1);
    DBMS_OUTPUT.PUT_LINE(upper(substr(nom, 1, 1)) || '. ' || cognom);
  end if;
end;
/

-- 18. Fes una funció que rebi una cadena de caràcters i retorni la mateixa cadena
-- però només les lletres, és a dir, sense números o altres símbols (nota: els
-- codis ASCII de les lletres són del 65 al 90 i del 97 al 122)

create or replace function ejercici18(p_cadena VARCHAR2) return varchar2 is
resultat varchar2(4000);
c char(1);
BEGIN
  for i in 1..length(p_cadena) loop
    c := substr(p_cadena, i, 1);
    if ASCII(c) between 65 and 90 or ASCII(c) between 97 and 122 then
      resultat:= resultat || c;
    end if;
  end loop;
  return resultat;
end;
/

-- prova
BEGIN
  DBMS_OUTPUT.PUT_LINE(ejercici18('Hola!Que(tal)'));
end;
/

-- 19. Fes un procediment que rebi dos números per paràmetre. El primer
-- representarà un import i el segon la quantitat lliurada. El procediment hauria
-- de mostrar per pantalla l’import a retornar al client desglosat en les diferents
-- monedes i bitllets existents. Per exemple si l’import és 15 i la quantitat
-- lliurada és de 100, el procediment hauria de mostrar:
-- Import a retornar: 85
-- Bitllets de 50: 1
-- Bitllets de 20: 1
-- Bitllets de 10: 1
-- Bitllets de 5: 1

create or replace procedure ejercici19(import int, lliurat int) is
canvi int;
tipus int;
quantitat int;
begin;
  canvi := lliurat - import;
  if canvi <= 0 then
    DBMS_OUTPUT.PUT_LINE('Error: Pagament incomplet');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Import a retornar: ' || canvi);
    for tipus in (50, 20, 10, 5) loop
      quantitat:= trunc(canvi/tipus);
      if quantitat > 0 then
        DBMS_OUTPUT.PUT_LINE('Billets de ' || tipus || ': ' || quantitat);
        canvi:=canvi -(quantitat*tipus);
      end if;
    end loop;
  end if;
end;
/