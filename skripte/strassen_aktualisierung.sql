-- Tabelle 'ukos_okstra.strasse'

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_okstra.strasse SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND nachrichtlich IS FALSE
  AND length(schluessel) = 5
  AND id NOT IN (SELECT uuid FROM ukos_okstra.temp_strasse);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_okstra.strasse (id, id_gemeinde, bezeichnung, schluessel, kennung)
 SELECT
  t.uuid,
  g.id,
  t.strasse_name,
  t.strasse_schluessel,
  CASE
   WHEN t.kennung IS NULL OR (t.kennung IS NOT NULL AND t.kennung = '') THEN NULL
   ELSE t.kennung
  END
   FROM ukos_okstra.temp_strasse t, ukos_kataster.gemeinde g, ukos_kataster.gemeindeverband gv, ukos_kataster.kreis k
    WHERE t.uuid NOT IN (SELECT id FROM ukos_okstra.strasse WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
     ON CONFLICT DO NOTHING;

-- vorhandene Datensätze aktualisieren
UPDATE ukos_okstra.strasse s SET
 bezeichnung = t.strasse_name,
 schluessel = t.strasse_schluessel,
 kennung = CASE
            WHEN t.kennung IS NULL OR (t.kennung IS NOT NULL AND t.kennung = '') THEN NULL
            ELSE t.kennung
           END,
 geaendert_am = timezone('utc-1', now())
  FROM ukos_okstra.temp_strasse t
   WHERE s.id !='00000000-0000-0000-0000-000000000000'
   AND s.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND s.nachrichtlich IS FALSE
   AND s.id = t.uuid AND
   (s.bezeichnung != t.strasse_name
   OR s.schluessel != t.strasse_schluessel
   OR COALESCE(s.kennung, '') != COALESCE(t.kennung, ''));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_okstra.strasse;



-- temporäre Tabelle löschen
DROP TABLE ukos_okstra.temp_strasse CASCADE;
