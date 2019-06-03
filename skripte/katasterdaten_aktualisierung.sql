-- Tabelle 'ukos_kataster.kreis'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS ukos_kataster.kreis_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_kataster.kreis SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND id NOT IN (SELECT uuid FROM ukos_kataster.temp_kreis);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_kataster.kreis (id, bezeichnung, schluessel, wkb_geometry)
 SELECT
  uuid,
  kreis_name,
  kreis_schluessel,
  wkb_geometry
   FROM ukos_kataster.temp_kreis
    WHERE uuid NOT IN (SELECT id FROM ukos_kataster.kreis WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone);

-- vorhandene Datensätze aktualisieren
UPDATE ukos_kataster.kreis k SET
 bezeichnung = t.kreis_name,
 schluessel = t.kreis_schluessel,
 wkb_geometry = t.wkb_geometry,
 geaendert_am = timezone('utc-1', now())
  FROM ukos_kataster.temp_kreis t
   WHERE k.id !='00000000-0000-0000-0000-000000000000'
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND k.id = t.uuid AND
   (k.bezeichnung != t.kreis_name
   OR k.schluessel != t.kreis_schluessel
   OR NOT ST_Equals(k.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_kataster.kreis;

-- Index auf Geometriespalte erstellen
CREATE INDEX kreis_s ON ukos_kataster.kreis USING gist(wkb_geometry);



-- Tabelle 'ukos_kataster.gemeindeverband'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS ukos_kataster.gemeindeverband_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_kataster.gemeindeverband SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND id NOT IN (SELECT uuid FROM ukos_kataster.temp_gemeindeverband);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_kataster.gemeindeverband (id, id_kreis, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  k.id,
  t.gemeindeverband_name,
  substring(t.gemeindeverband_schluessel from 6),
  t.wkb_geometry
   FROM ukos_kataster.temp_gemeindeverband t, ukos_kataster.kreis k
    WHERE t.uuid NOT IN (SELECT id FROM ukos_kataster.gemeindeverband WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone)
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE ukos_kataster.gemeindeverband gv SET
 id_kreis = k.id,
 bezeichnung = t.gemeindeverband_name,
 schluessel = substring(t.gemeindeverband_schluessel from 6),
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM ukos_kataster.temp_gemeindeverband t, ukos_kataster.kreis k
   WHERE gv.id !='00000000-0000-0000-0000-000000000000'
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.id = t.uuid
   AND t.kreis_schluessel = k.schluessel
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND
   (gv.id_kreis != k.id
   OR gv.bezeichnung != t.gemeindeverband_name
   OR gv.schluessel != substring(t.gemeindeverband_schluessel from 6)
   OR NOT ST_Equals(gv.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_kataster.gemeindeverband;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeverband_s ON ukos_kataster.gemeindeverband USING gist(wkb_geometry);



-- Tabelle 'ukos_kataster.gemeinde'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS ukos_kataster.gemeinde_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_kataster.gemeinde SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND id NOT IN (SELECT uuid FROM ukos_kataster.temp_gemeinde);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_kataster.gemeinde (id, id_gemeindeverband, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  gv.id,
  t.gemeinde_name,
  substring(t.gemeinde_schluessel from 10),
  t.wkb_geometry
   FROM ukos_kataster.temp_gemeinde t, ukos_kataster.gemeindeverband gv, ukos_kataster.kreis k
    WHERE t.uuid NOT IN (SELECT id FROM ukos_kataster.gemeinde WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone)
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE ukos_kataster.gemeinde g SET
 id_gemeindeverband = gv.id,
 bezeichnung = t.gemeinde_name,
 schluessel = substring(t.gemeinde_schluessel from 10),
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM ukos_kataster.temp_gemeinde t,  ukos_kataster.gemeindeverband gv, ukos_kataster.kreis k
   WHERE g.id !='00000000-0000-0000-0000-000000000000'
   AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND g.id = t.uuid
   AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.id_kreis = k.id
   AND t.kreis_schluessel = k.schluessel
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND
   (g.id_gemeindeverband != gv.id
   OR g.bezeichnung != t.gemeinde_name
   OR g.schluessel != substring(t.gemeinde_schluessel from 10)
   OR NOT ST_Equals(g.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_kataster.gemeinde;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeinde_s ON ukos_kataster.gemeinde USING gist(wkb_geometry);



-- Tabelle 'ukos_kataster.gemeindeteil'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS ukos_kataster.gemeindeteil_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE ukos_kataster.gemeindeteil SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND id NOT IN (SELECT uuid FROM ukos_kataster.temp_gemeindeteil);

-- mit neuen Datensätzen befüllen
INSERT INTO ukos_kataster.gemeindeteil (id, id_gemeinde, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  g.id,
  t.gemeindeteil_name,
  t.gemeindeteil_schluessel,
  t.wkb_geometry
   FROM ukos_kataster.temp_gemeindeteil t, ukos_kataster.gemeinde g, ukos_kataster.gemeindeverband gv, ukos_kataster.kreis k
    WHERE t.uuid NOT IN (SELECT id FROM ukos_kataster.gemeindeteil WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE ukos_kataster.gemeindeteil gt SET
 id_gemeinde = g.id,
 bezeichnung = t.gemeindeteil_name,
 schluessel = t.gemeindeteil_schluessel,
 wkb_geometry = t.wkb_geometry,
 geaendert_am = timezone('utc-1', now())
  FROM ukos_kataster.temp_gemeindeteil t, ukos_kataster.gemeinde g, ukos_kataster.gemeindeverband gv, ukos_kataster.kreis k
   WHERE gt.id !='00000000-0000-0000-0000-000000000000'
   AND gt.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gt.id = t.uuid
   AND substring(t.gemeinde_schluessel from 10) = g.schluessel
   AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND g.id_gemeindeverband = gv.id
   AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.id_kreis = k.id
   AND t.kreis_schluessel = k.schluessel
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND
   (gt.id_gemeinde != g.id
   OR gt.bezeichnung != t.gemeindeteil_name
   OR gt.schluessel != t.gemeindeteil_schluessel
   OR NOT ST_Equals(gt.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE ukos_kataster.gemeindeteil;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeteil_s ON ukos_kataster.gemeindeteil USING gist(wkb_geometry);



-- temporäre Tabellen löschen
DROP TABLE ukos_kataster.temp_kreis CASCADE;
DROP TABLE ukos_kataster.temp_gemeindeverband CASCADE;
DROP TABLE ukos_kataster.temp_gemeinde CASCADE;
DROP TABLE ukos_kataster.temp_gemeindeteil CASCADE;
