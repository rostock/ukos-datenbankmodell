# *UkoS*-Datenbankmodell

Datenbankmodell für *UkoS*, das *Umsetzungsprojekt kommunale Straßendaten Mecklenburg-Vorpommern*

Die aktuellen Codelisten werden gehostet bei der Hanse- und Universitätsstadt Rostock unter https://geo.sv.rostock.de/ukos-codelisten. Bei Ergänzungs- und/oder Änderungswünschen zu den Codelisten nutzen Sie bitte die [Issues](https://github.com/rostock/ukos-datenbankmodell/issues) dieses Repositories.

## Voraussetzungen

*   [*Python*](https://www.python.org)
*   [*Virtualenv*](https://virtualenv.pypa.io)
*   [*pip*](http://pip.pypa.io)
*   [*PostgreSQL*](https://www.postgresql.org) mit den Erweiterungen [*hstore*](https://www.postgresql.org/docs/current/hstore.html), [*PostGIS*](http://postgis.net) (inklusive Topolgie) und [*uuid-ossp*](https://www.postgresql.org/docs/current/static/uuid-ossp.html)

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
1.  Konfigurationsdatei für die mit [*Sphinx*](http://www.sphinx-doc.org) erzeugten Codelisten erstellen auf Basis der entsprechenden Vorlage:

        cp /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/codelisten/source/conf.template /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/codelisten/source/conf.py

1.  Konfigurationsdatei bearbeiten (dabei vor allem den Datenbankverbindungsparameter `sqltable_connection_string`)

## Initialisierung

1.  neue, leere, um *PostGIS* erweiterte *PostgreSQL*-Datenbank erstellen gemäß des Datenbankverbindungsparameters in `/usr/local/ukos-datenbankmodell/ukos-datenbankmodell/alembic.ini`
1.  virtuelle *Python*-Umgebung aktivieren:

        source /usr/local/ukos-datenbankmodell/virtualenv/bin/activate

1.  aktuelle Datenbankmodell-Revision auf Datenbank anwenden:

        alembic upgrade head

1.  Codelisten-Webseiten bauen:

        cd codelisten
        rm -r build/* && make html

## Deployment der Codelisten (am Beispiel des [*Apache HTTP Servers*](https://httpd.apache.org))

1.  Konfigurationsdatei des *Apache HTTP Servers* öffnen und in etwa folgenden Inhalt einfügen:
    
        Alias /ukos-codelisten /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/codelisten/build/html

        <Directory /usr/local/ukos-datenbankmodell/ukos-datenbankmodell/codelisten/build/html>
            Order deny,allow
            Require all granted
        </Directory>
