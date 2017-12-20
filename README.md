# *UkoS*-Datenbankmodell

Datenbankmodell für *UkoS*, das *Umsetzungsprojekt kommunale Straßendaten Mecklenburg-Vorpommern*

## Voraussetzungen

*   [*Python*](https://www.python.org)
*   [*Virtualenv*](https://virtualenv.pypa.io)
*   [*PostgreSQL*](https://www.postgresql.org)
*   [*PostGIS*](http://postgis.net)

## Installation

1.  neue virtuelle *Python*-Umgebung anlegen, zum Beispiel:

        virtualenv /usr/local/ukos-datenbankmodell/virtualenv

1.  Projekt klonen:

        git clone https://github.com/rostock/ukos-datenbankmodell /usr/local/ukos-datenbankmodell/ukos-datenbankmodell

1.  virtuelle *Python*-Umgebung aktivieren:

        source /usr/local/ukos-datenbankmodell/virtualenv/bin/activate

1.  benötigte *Python*-Module installieren via [*pip*](https://pip.pypa.io), dem Paketverwaltungsprogramm für *Python*-Pakete:

        pip install -r requirements.txt

## Konfiguration

1.  Konfigurationsdatei für das Datenbankmigrationswerkzeug [*Alembic*](http://alembic.zzzcomputing.com) erstellen auf Basis der entsprechenden Vorlage:

        cp /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/alembic.template /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/alembic.ini

1.  Konfigurationsdatei bearbeiten (dabei vor allem den Datenbankverbindungsparameter `sqlalchemy.url`)

## Initialisierung

1.  neue, leere, um *PostGIS* erweiterte *PostgreSQL*-Datenbank erstellen gemäß des Datenbankverbindungsparameters in `/usr/local/ukos-datenbankmodell/ukos-datenbankmodell/alembic.ini`
1.  virtuelle *Python*-Umgebung aktivieren:

        source /usr/local/ukos-datenbankmodell/virtualenv/bin/activate

1.  aktuelle Datenbankmodell-Revision auf Datenbank anwenden:

        alembic upgrade head
