.. index:: Straße

Straße
======

.. _strasse_datenbanktabelle:

Datenbanktabelle
----------------

strassennetz.strasse

.. _strasse_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste-strasse

   SELECT
    k.bezeichnung AS "Kreis",
    k.schluessel || gv.schluessel || g.schluessel AS "Regionalschlüssel",
    g.bezeichnung AS "Gemeinde",
    s.schluessel AS "Straßenschlüssel",
    s.bezeichnung AS "Straße"
     FROM strassennetz.strasse s, kataster.kreis k, kataster.gemeindeverband gv, kataster.gemeinde g
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