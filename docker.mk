include .env

.PHONY: up down stop prune shell logs install wait-db import-db composer uli re-index in

default: up

## up : Start up containers.
up:
	@echo "Starting up containers for APP-ELASTICSEARCH..."
	@docker compose pull
	@docker compose up -d --remove-orphans

## import-db : Import database.
import-db:
	@echo "Import db for APP-ELASTICSEARCH..."
	@docker exec -it drupal_app sh -c "./init-drupal.sh"

## composer : Run composer install.
composer:
	@echo "Composer install for APP-ELASTICSEARCH..."
	@docker exec -it drupal_app sh -c "composer install"

## uli : Generate a one-time login link.
uli:
	@echo "Drush uli for APP-ELASTICSEARCH..."
	@docker exec -it drupal_app sh -c "./vendor/bin/drush uli -l http://drupal-elasticsearch.docker.local/"

## reindex : Re-index search-api.
re-index:
	@echo "Drush search-api for APP-ELASTICSEARCH..."
	@docker exec -it drupal_app sh -c "./vendor/bin/drush search-api:index"

## wait-db : Wait for the database container to be ready.
wait-db:
	@echo "Waiting for database container to be ready..."
	@until docker exec drupal_db mysqladmin ping -hlocalhost --silent; do \
		sleep 4; \
	done

## install : Install up containers and import db.
install:
	@echo "Install up containers and import db for APP-ELASTICSEARCH..."
	@$(MAKE) prune
	@$(MAKE) build
	@$(MAKE) up
	@$(MAKE) composer
	@$(MAKE) wait-db

## down : Stop containers.
down: stop

## stop : Stop containers.
stop:
	@echo "Stopping containers for APP-ELASTICSEARCH..."
	@docker compose stop

## prune : Remove containers.
prune:
	@echo "Removing containers for APP-ELASTICSEARCH..."
	@docker compose down -v $(filter-out $@,$(MAKECMDGOALS))

## in : Access container shell.
in:
	@docker exec -it drupal_app bash

## in : Access container shell.
build:
	@echo "Building containers for APP-ELASTICSEARCH..."
	@docker compose build

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
