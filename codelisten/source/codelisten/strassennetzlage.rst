.. index:: Straßennetzlage

Straßennetzlage
===============

.. _strassennetzlage_datenbanktabelle:

Datenbanktabelle
----------------

ukos_base.wld_strassennetzlage

.. _strassennetzlage_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    kurztext AS "Kurztext",
    langtext AS "Langtext"
     FROM ukos_base.wld_strassennetzlage
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone