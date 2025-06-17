#!/bin/bash

# Navega até o diretório HTML
cd /var/www/html

# Executa os comandos do Drush
./vendor/bin/drush sql-drop -y
./vendor/bin/drush sqlc < ./database/dump_2025-06-17_083226.sql
./vendor/bin/drush updb -y
./vendor/bin/drush cim -y
./vendor/bin/drush cr
./vendor/bin/drush uli -l http://drupal-elasticsearch.docker.local/
