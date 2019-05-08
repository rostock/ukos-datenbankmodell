-- Tabelle 'ukos_okstra.strasse'

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_okstra.strasse s SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  FROM ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g
   WHERE s.id != '00000000-0000-0000-0000-000000000000'
   AND g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND s.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND s.nachrichtlich IS FALSE
   AND s.id_gemeinde = g.id
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND length(s.schluessel) = 5
   AND k.schluessel || gv.schluessel || g.schluessel || s.schluessel NOT IN (SELECT gemeinde_schluessel || strasse_schluessel FROM ukos_okstra.temp_strasse);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_okstra.strasse (id_gemeinde, bezeichnung, schluessel, kennung)
 SELECT
  g.id,
  t.strasse_name,
  t.strasse_schluessel,
  CASE
   WHEN t.kennung IS NULL OR (t.kennung IS NOT NULL AND t.kennung = '') THEN NULL
   ELSE t.kennung
  END
   FROM ukos_okstra.temp_strasse t, ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g
    WHERE t.gemeinde_schluessel || t.strasse_schluessel NOT IN (SELECT k.schluessel || gv.schluessel || g.schluessel || s.schluessel FROM ukos_okstra.strasse s, ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g WHERE s.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND s.nachrichtlich IS FALSE AND s.id_gemeinde = g.id AND g.id_gemeindeverband = gv.id AND gv.id_kreis = k.id)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE ukos_okstra.strasse s SET
 bezeichnung = t.strasse_name,
 kennung = CASE
            WHEN t.kennung IS NULL OR (t.kennung IS NOT NULL AND t.kennung = '') THEN NULL
            ELSE t.kennung
           END,
 geaendert_am = timezone('utc-1', now())
  FROM ukos_okstra.temp_strasse t, ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g
   WHERE s.id != '00000000-0000-0000-0000-000000000000'
   AND g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND s.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND s.nachrichtlich IS FALSE
   AND s.id_gemeinde = g.id
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel || g.schluessel || s.schluessel = t.gemeinde_schluessel || t.strasse_schluessel AND
   (s.bezeichnung != t.strasse_name OR
   COALESCE(s.kennung, '') != COALESCE(t.kennung, ''));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_okstra.strasse;



-- temporäre Tabelle löschen
DROP TABLE ukos_okstra.temp_strasse CASCADE;