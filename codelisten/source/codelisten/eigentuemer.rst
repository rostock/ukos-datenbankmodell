.. index:: Eigentümer

Eigentümer
==========

.. _eigentuemer_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_base.wld_eigentuemer

.. _eigentuemer_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    id AS "UUID",
    kurztext AS "Code",
    langtext AS "Bezeichnung"
     FROM ukos_base.wld_eigentuemer
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone