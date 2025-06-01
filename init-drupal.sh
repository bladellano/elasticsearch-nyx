#!/bin/bash

# Navega até o diretório HTML
cd /var/www/html

# Executa os comandos do Drush
./vendor/bin/drush sql-drop -y
./vendor/bin/drush sqlc < ./database/dump_2025-05-31_184602.sql
./vendor/bin/drush cr
./vendor/bin/drush uli -l http://drupal-elasticsearch.docker.local/
