.. index:: Gemeinde, Kommune

Gemeinde
========

.. _gemeinde_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_kataster.gemeinde

.. _gemeinde_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    g.id AS "UUID",
    k.bezeichnung AS "Kreis",
    k.schluessel || gv.schluessel || g.schluessel AS "Regionalschlüssel",
    g.bezeichnung AS "Gemeinde"
     FROM ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv, ukos_kataster.gemeinde g
      WHERE g.id != '00000000-0000-0000-0000-000000000000'
      AND gv.id != '00000000-0000-0000-0000-000000000000'
      AND k.id != '00000000-0000-0000-0000-000000000000'
      AND g.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND g.id_gemeindeverband = gv.id
      AND gv.id_kreis = k.id