.. index:: Deckschicht

Deckschicht
===========

.. _deckschicht_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_base.wld_deckschicht

.. _deckschicht_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    id AS "UUID",
    langtext AS "Bezeichnung"
     FROM ukos_base.wld_deckschicht
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone