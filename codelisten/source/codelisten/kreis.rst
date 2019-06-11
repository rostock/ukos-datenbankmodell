.. index:: Kreis, kreisfreie Stadt, Landkreis

Kreis
=====

.. _kreis_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_kataster.kreis

.. _kreis_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    id AS "UUID",
    schluessel AS "Schlüssel",
    bezeichnung AS "Kreis"
     FROM ukos_kataster.kreis
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone