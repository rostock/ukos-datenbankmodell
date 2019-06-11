.. index:: Amt, amtsfreie Kommune, Gemeindeverband, gemeindeverbandsfreie Kommune

Gemeindeverband
===============

.. _gemeindeverband_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_kataster.gemeindeverband

.. _gemeindeverband_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    gv.id AS "UUID",
    k.bezeichnung AS "Kreis",
    k.schluessel || gv.schluessel AS "Schlüssel",
    gv.bezeichnung AS "Gemeindeverband"
     FROM ukos_kataster.kreis k, ukos_kataster.gemeindeverband gv
      WHERE gv.id != '00000000-0000-0000-0000-000000000000'
      AND k.id != '00000000-0000-0000-0000-000000000000'
      AND gv.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND k.gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone
      AND gv.id_kreis = k.id