-- Tabelle 'strassennetz.strasse'

-- alte Datensätze entsprechend kennzeichnen
UPDATE strassennetz.strasse s SET
 gueltig_bis = timezone('utc-1', now())
  FROM kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
   WHERE s.id != '00000000-0000-0000-0000-000000000000'
   AND g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND s.nachrichtlich IS FALSE
   AND s.id_gemeinde = g.id
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || g.schluessel || s.schluessel || s.bezeichnung NOT IN (SELECT kreis_schluessel || substring(gemeinde_schluessel from 10) || strasse_schluessel || strasse_name FROM strassennetz.temp_strasse);

-- mit neuen Datensätzen befüllen
INSERT INTO strassennetz.strasse(id_gemeinde, bezeichnung, schluessel)
 SELECT
  g.id,
  t.strasse_name,
  t.strasse_schluessel
   FROM strassennetz.temp_strasse t, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
    WHERE t.kreis_schluessel || substring(t.gemeinde_schluessel from 10) || t.strasse_schluessel || t.strasse_name NOT IN (SELECT k.schluessel || g.schluessel || s.schluessel || s.bezeichnung FROM strassennetz.strasse s, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g WHERE s.nachrichtlich IS FALSE AND s.id_gemeinde = g.id AND g.id_gemeindeverband = gv.id AND gv.id_kreis = k.id)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel;

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE strassennetz.strasse;



-- temporäre Tabelle löschen
DROP TABLE strassennetz.temp_strasse CASCADE;