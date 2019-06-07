.. index:: Klasse, Klassifizierung, Straßenkategorie, Straßenkategorisierung, Straßenklasse, Straßenklassifizierung

Straßenklassifizierung
======================

.. _strassenklassifizierung_begrifflichkeit:

Begrifflichkeit
----------------

Ein Synonym für die Straßenklassifizierung (mit dem Resultat Straßenklassen) ist die Straßenkategorisierung (mit dem Resultat Straßenkategorien).

.. _strassenklassifizierung_grundlage:

Grundlage
---------

Als Grundlage für die Straßenklassifizierung dienen die `Richtlinien für integrierte Netzgestaltung <https://de.wikipedia.org/wiki/Richtlinien_für_integrierte_Netzgestaltung>`_ (RIN), die 2008 die seit 1988 gültigen `Richtlinien für die Anlage von Straßen – Netzgestaltung <https://de.wikipedia.org/wiki/Richtlinien_für_die_Anlage_von_Straßen_–_Netzgestaltung>`_ (RAS-N) ablösten. Da UkoS nicht nur (inner-)städtische bzw. (inner-)örtliche Straßen und Wege umfasst, sind gerade *nicht* die seit 2006 gültigen `Richtlinien für die Anlage von Stadtstraßen <https://de.wikipedia.org/wiki/Richtlinien_für_die_Anlage_von_Stadtstraßen>`_ (RASt) als Grundlage für die Straßenklassifizierung heranzuziehen.

.. _strassenklassifizierung_erlaeuterungen:

Erläuterungen
-------------

In den RIN wird nach den zwei Verbindungsbedeutungen *Verbindungsfunktionsstufe* und *Kategorie der Verkehrswege* differenziert. 

Bei der *Verbindungsfunktionsstufe* unterscheidet man sechs Gruppen:

* 0 – kontinental – Verbindung zwischen Metropolregionen
* I – großräumig – Verbindung von Oberzentren zu Metropolregionen und zwischen Oberzentren
* II – überregional – Verbindung von Mittelzentren zu Oberzentren und zwischen Mittelzentren
* III – regional – Verbindung von Grundzentren zu Mittelzentren und zwischen Grundzentren
* IV – nahräumig – Verbindung von Gemeinden zu Gemeindeteilen
* V – kleinräumig – Verbindung von Grundstücken zu Gemeinden/Gemeindeteilen

Bei den *Kategorien der Verkehrswege* wird in fünf Teilbereiche unterschieden:

* AS – Autobahnen – außerhalb und innerhalb bebauter Gebiete
* LS – Landstraßen – außerhalb bebauter Gebiete
* VS – anbaufreie Hauptverkehrsstraßen – im Vorfeld und innerhalb bebauter Gebiete, anbaufrei, Hauptverkehrsstraße
* HS – angebaute Hauptverkehrsstraßen – innerhalb bebauter Gebiete, angebaut, Hauptverkehrsstraße
* ES – Erschließungsstraßen – innerhalb bebauter Gebiete, angebaut, Erschließungsstraße

.. _strassenklassifizierung_datenbanktabelle:

Datenbanktabelle
----------------

.. code-block:: postgresql

   ukos_base.wld_strassenklassifizierung

.. _strassenklassifizierung_codeliste:

Codeliste
---------

.. sqltable::
   :class: codeliste

   SELECT
    id AS "UUID",
    kurztext AS "Code",
    langtext AS "Bezeichnung"
     FROM ukos_base.wld_klassifizierung
      WHERE id != '00000000-0000-0000-0000-000000000000'
      AND gueltig_bis = '2100-01-01 02:00:00+01'::timestamp with time zone