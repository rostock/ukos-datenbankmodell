-- Tabelle 'kataster.kreis'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.kreis_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.kreis SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  WHERE id != '00000000-0000-0000-0000-000000000000'
  AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
  AND schluessel NOT IN (SELECT kreis_schluessel FROM kataster.temp_kreis);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.kreis (bezeichnung, schluessel, wkb_geometry)
 SELECT
  kreis_name,
  kreis_schluessel,
  wkb_geometry
   FROM kataster.temp_kreis
    WHERE kreis_schluessel NOT IN (SELECT schluessel FROM kataster.kreis WHERE gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone);

-- vorhandene Datensätze aktualisieren
UPDATE kataster.kreis k SET
 bezeichnung = t.kreis_name,
 wkb_geometry = t.wkb_geometry,
 geaendert_am = timezone('utc-1', now())
  FROM kataster.temp_kreis t
   WHERE k.id !='00000000-0000-0000-0000-000000000000'
   AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND k.schluessel = t.kreis_schluessel AND
   (k.bezeichnung != t.kreis_name
   OR NOT ST_Equals(k.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.kreis;

-- Index auf Geometriespalte erstellen
CREATE INDEX kreis_s ON kataster.kreis USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeindeverband'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeindeverband_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeindeverband gv SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  FROM kataster.kreis k
   WHERE gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel NOT IN (SELECT gemeindeverband_schluessel FROM kataster.temp_gemeindeverband);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeindeverband (id_kreis, bezeichnung, schluessel, wkb_geometry)
 SELECT
  k.id,
  t.gemeindeverband_name,
  substring(t.gemeindeverband_schluessel from 6),
  t.wkb_geometry
   FROM kataster.temp_gemeindeverband t, kataster.kreis k
    WHERE t.gemeindeverband_schluessel NOT IN (SELECT k.schluessel || gv.schluessel FROM kataster.kreis k, kataster.gemeindeverband gv WHERE gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND gv.id_kreis = k.id)
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeindeverband gv SET
 bezeichnung = t.gemeindeverband_name,
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_gemeindeverband t, kataster.kreis k
   WHERE gv.id !='00000000-0000-0000-0000-000000000000'
   AND k.id !='00000000-0000-0000-0000-000000000000'
   AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel = t.gemeindeverband_schluessel AND
   (gv.bezeichnung != t.gemeindeverband_name
   OR NOT ST_Equals(gv.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeindeverband;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeverband_s ON kataster.gemeindeverband USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeinde'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeinde_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeinde g SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  FROM kataster.kreis k, kataster.gemeindeverband gv
   WHERE g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel || g.schluessel NOT IN (SELECT gemeinde_schluessel FROM kataster.temp_gemeinde);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeinde (id_gemeindeverband, bezeichnung, schluessel, wkb_geometry)
 SELECT
  gv.id,
  t.gemeinde_name,
  substring(t.gemeinde_schluessel from 10),
  t.wkb_geometry
   FROM kataster.temp_gemeinde t, kataster.kreis k, kataster.gemeindeverband gv
    WHERE t.gemeinde_schluessel NOT IN (SELECT k.schluessel || gv.schluessel || g.schluessel FROM kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g WHERE g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND g.id_gemeindeverband = gv.id AND gv.id_kreis = k.id)
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeinde g SET
 bezeichnung = t.gemeinde_name,
 geaendert_am = timezone('utc-1', now()),
 wkb_geometry = t.wkb_geometry
  FROM kataster.temp_gemeinde t, kataster.kreis k, kataster.gemeindeverband gv
   WHERE g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel || g.schluessel = t.gemeinde_schluessel AND
   (g.bezeichnung != t.gemeinde_name
   OR NOT ST_Equals(g.wkb_geometry, t.wkb_geometry));

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeinde;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeinde_s ON kataster.gemeinde USING gist(wkb_geometry);



-- Tabelle 'kataster.gemeindeteil'

-- Index auf Geometriespalte löschen
DROP INDEX IF EXISTS kataster.gemeindeteil_s;

-- alte Datensätze entsprechend kennzeichnen
UPDATE kataster.gemeindeteil gt SET
 gueltig_bis = timezone('utc-1', now()),
 geaendert_am = timezone('utc-1', now())
  FROM kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
   WHERE gt.id != '00000000-0000-0000-0000-000000000000'
   AND g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND gt.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gt.id_gemeinde = g.id
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel || g.schluessel || gt.schluessel NOT IN (SELECT gemeinde_schluessel || gemeindeteil_schluessel FROM kataster.temp_gemeindeteil WHERE gemeindeteil_schluessel IS NOT NULL);

-- mit neuen Datensätzen befüllen
INSERT INTO kataster.gemeindeteil (id_gemeinde, bezeichnung, schluessel, wkb_geometry)
 SELECT
  g.id,
  t.gemeindeteil_name,
  t.gemeindeteil_schluessel,
  t.wkb_geometry
   FROM kataster.temp_gemeindeteil t, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
    WHERE t.gemeinde_schluessel || t.gemeindeteil_schluessel NOT IN (SELECT k.schluessel || gv.schluessel || g.schluessel || gt.schluessel FROM kataster.gemeindeteil gt, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g WHERE gt.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone AND gt.id_gemeinde = g.id AND g.id_gemeindeverband = gv.id AND gv.id_kreis = k.id)
    AND substring(t.gemeinde_schluessel from 10) = g.schluessel
    AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND g.id_gemeindeverband = gv.id
    AND substring(t.gemeindeverband_schluessel from 6) = gv.schluessel
    AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND gv.id_kreis = k.id
    AND t.kreis_schluessel = k.schluessel
    AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
    AND t.gemeindeteil_schluessel IS NOT NULL;

-- vorhandene Datensätze aktualisieren
UPDATE kataster.gemeindeteil gt SET
 bezeichnung = t.gemeindeteil_name,
 wkb_geometry = t.wkb_geometry,
 geaendert_am = timezone('utc-1', now())
  FROM kataster.temp_gemeindeteil t, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
   WHERE gt.id != '00000000-0000-0000-0000-000000000000'
   AND g.id != '00000000-0000-0000-0000-000000000000'
   AND gv.id != '00000000-0000-0000-0000-000000000000'
   AND k.id != '00000000-0000-0000-0000-000000000000'
   AND gt.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
   AND gt.id_gemeinde = g.id
   AND g.id_gemeindeverband = gv.id
   AND gv.id_kreis = k.id
   AND k.schluessel || gv.schluessel || g.schluessel || gt.schluessel = t.gemeinde_schluessel || t.gemeindeteil_schluessel AND
   (gt.bezeichnung != t.gemeindeteil_name
   OR NOT ST_Equals(gt.wkb_geometry, t.wkb_geometry))
   AND t.gemeindeteil_schluessel IS NOT NULL;

-- datenbanktechnisch bereinigen
VACUUM FULL ANALYZE kataster.gemeindeteil;

-- Index auf Geometriespalte erstellen
CREATE INDEX gemeindeteil_s ON kataster.gemeindeteil USING gist(wkb_geometry);



-- temporäre Tabellen löschen
DROP TABLE kataster.temp_kreis CASCADE;
DROP TABLE kataster.temp_gemeindeverband CASCADE;
DROP TABLE kataster.temp_gemeinde CASCADE;
DROP TABLE kataster.temp_gemeindeteil CASCADE;