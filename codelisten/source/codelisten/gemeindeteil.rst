.. index:: Gemeindeteil, Ortsteil

Gemeindeteil
============

.. _gemeindeteil_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_kataster.gemeindeteil

.. _gemeindeteil_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    gt.id AS "UUID",
    k.bezeichnung AS "Kreis",
    k.schluessel || gv.schluessel || g.schluessel AS "Regionalschlüssel",
    g.bezeichnung AS "Gemeinde",
    gt.schluessel AS "Gemeindeteilschlüssel",
    gt.bezeichnung AS "Gemeindeteil"
     FROM ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g, ukos_kataster.gemeindeteil gt
      WHERE gt.id != '00000000-0000-0000-0000-000000000000'
      AND g.id != '00000000-0000-0000-0000-000000000000'
      AND gv.id != '00000000-0000-0000-0000-000000000000'
      AND k.id != '00000000-0000-0000-0000-000000000000'
      AND gt.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND gt.id_gemeinde = g.id
      AND g.id_gemeindeverband = gv.id
      AND gv.id_kreis = k.id