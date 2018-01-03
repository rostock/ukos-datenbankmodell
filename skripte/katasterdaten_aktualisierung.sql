-- Tabelle 'kataster.kreis'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.kreis_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.kreis SET
 gueltig_bis = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND id NOT IN (SELECT uuid FROM kataster.temp_kreis);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.kreis(id, bezeichnung, schluessel, wkb_geometry)
 SELECT
  uuid,
  kreis_name,
  kreis_schluessel,
  wkb_geometry
   FROM kataster.temp_kreis
    WHERE uuid NOT IN (SELECT id FROM kataster.kreis);

-- vorhandene Datensätze aktualisieren
UPDATE kataster.kreis k SET
 bezeichnung = t.kreis_name,
 schluessel = t.kreis_schluessel,
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_kreis t
   WHERE k.id = t.uuid AND
   (k.bezeichnung != t.kreis_name
   OR k.schluessel != t.kreis_schluessel
   OR NOT ST_Equals(k.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.kreis;

-- Index auf Geometriespalte erstellen
CREATE INDEX kreis_s ON kataster.kreis USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeindeverband'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeindeverband_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeindeverband SET
 gueltig_bis = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND id NOT IN (SELECT uuid FROM kataster.temp_gemeindeverband);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeindeverband(id, id_kreis, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  k.id,
  t.gemeindeverband_name,
  substring(t.gemeindeverband_schluessel from 6),
  t.wkb_geometry
   FROM kataster.temp_gemeindeverband t, kataster.kreis k
    WHERE t.uuid NOT IN (SELECT id FROM kataster.gemeindeverband)
    AND t.kreis_schluessel = k.schluessel;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeindeverband g SET
 id_kreis = k.id,
 bezeichnung = t.gemeindeverband_name,
 schluessel = substring(t.gemeindeverband_schluessel from 6),
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_gemeindeverband t, kataster.kreis k
   WHERE g.id = t.uuid
   AND t.kreis_schluessel = k.schluessel AND
   (g.id_kreis != k.id
   OR g.bezeichnung != t.gemeindeverband_name
   OR g.schluessel != substring(t.gemeindeverband_schluessel from 6)
   OR NOT ST_Equals(g.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeindeverband;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeverband_s ON kataster.gemeindeverband USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeinde'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeinde_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeinde SET
 gueltig_bis = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND id NOT IN (SELECT uuid FROM kataster.temp_gemeinde);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeinde(id, id_gemeindeverband, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  gv.id,
  t.gemeinde_name,
  substring(t.gemeinde_schluessel from 10),
  t.wkb_geometry
   FROM kataster.temp_gemeinde t, kataster.kreis k, kataster.gemeindeverband gv
    WHERE t.uuid NOT IN (SELECT id FROM kataster.gemeinde)
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeinde g SET
 id_gemeindeverband = gv.id,
 bezeichnung = t.gemeinde_name,
 schluessel = substring(t.gemeinde_schluessel from 10),
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_gemeinde t, kataster.kreis k, kataster.gemeindeverband gv
   WHERE g.id = t.uuid
   AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
   AND gv.id_kreis = k.id
   AND t.kreis_schluessel = k.schluessel AND
   (g.id_gemeindeverband != gv.id
   OR g.bezeichnung != t.gemeinde_name
   OR g.schluessel != substring(t.gemeinde_schluessel from 10)
   OR NOT ST_Equals(g.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeinde;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeinde_s ON kataster.gemeinde USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeindeteil'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeindeteil_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeindeteil SET
 gueltig_bis = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND id NOT IN (SELECT uuid FROM kataster.temp_gemeindeteil);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeindeteil(id, id_gemeinde, bezeichnung, schluessel, wkb_geometry)
 SELECT
  t.uuid,
  g.id,
  t.gemeindeteil_name,
  t.gemeindeteil_schluessel,
  t.wkb_geometry
   FROM kataster.temp_gemeindeteil t, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
    WHERE t.uuid NOT IN (SELECT id FROM kataster.gemeindeteil)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeindeteil gt SET
 id_gemeinde = g.id,
 bezeichnung = t.gemeindeteil_name,
 schluessel = t.gemeindeteil_schluessel,
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_gemeindeteil t, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
   WHERE gt.id = t.uuid
   AND substring(t.gemeinde_schluessel from 10) = g.schluessel
   AND g.id_gemeindeverband = gv.id
   AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
   AND gv.id_kreis = k.id
   AND t.kreis_schluessel = k.schluessel AND
   (gt.id_gemeinde != g.id
   OR gt.bezeichnung != t.gemeindeteil_name
   OR gt.schluessel != t.gemeindeteil_schluessel
   OR NOT ST_Equals(gt.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeindeteil;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeteil_s ON kataster.gemeindeteil USING gist(wkb_geometry);



-- temporäre Tabellen löschen
DROP TABLE kataster.temp_kreis CASCADE;
DROP TABLE kataster.temp_gemeindeverband CASCADE;
DROP TABLE kataster.temp_gemeinde CASCADE;
DROP TABLE kataster.temp_gemeindeteil CASCADE;