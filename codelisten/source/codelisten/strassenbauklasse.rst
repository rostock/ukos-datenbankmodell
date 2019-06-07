.. index:: Bauklasse, Belastungsklasse, Oberbau, RStO, Straßenbauklasse

Straßenbauklasse
================

.. _strassenbauklasse_grundlage:

Grundlage
---------

Als Grundlage für die Straßenbauklassen dienen die `Richtlinien für die Standardisierung des Oberbaus von Verkehrsflächen <https://de.wikipedia.org/wiki/Richtlinien_für_die_Standardisierung_des_Oberbaus_von_Verkehrsflächen>`_ (RStO). Hierin wird allerdings seit 2012 von Belastungsklassen gesprochen, die die früheren Bauklassen abgelöst haben. Dennoch wird hier auf die früheren Bauklassen abgestellt.

.. _strassenbauklasse_erlaeuterungen:

Erläuterungen
-------------

Belastungsklassen nach RStO mit Beispielen und den früheren Bauklassen nach RStO zum Vergleich:

================  =====================================================================  ====================================================  =========
Belastungsklasse  dimensionierungsrelevante Beanspruchung (in Mio. äq. 10-t-Achsüberg.)  typisches Beispiel                                    Bauklasse
================  =====================================================================  ====================================================  =========
Bk100             > 32                                                                   Autobahnen, Schnellstraßen                            SV
Bk32              > 10 und ≤ 32                                                          Industriestraßen                                      I
Bk10              > 3,2 und ≤ 10                                                         Hauptgeschäftsstraßen                                 II
Bk3,2             > 1,8 und ≤ 3,2                                                        Verbindungsstraßen                                    III
Bk1,8             > 1,0 und ≤ 1,8                                                        Sammelstraßen, wenig befahrene Hauptgeschäftsstraßen  III
Bk1,0             > 0,3 und ≤ 1,0                                                        Wohnstraßen                                           IV
Bk0,3             ≤ 0,3                                                                  Wohnwege                                              V und VI
================  =====================================================================  ====================================================  =========

.. _strassenbauklasse_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_base.wld_bauklasse

.. _strassenbauklasse_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    id AS "UUID",
    kurztext AS "Code",
    langtext AS "Bezeichnung"
     FROM ukos_base.wld_bauklasse
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone