FROM php:8.2-apache

# Instala extensões necessárias para o Drupal
RUN apt-get update && apt-get install -y \
		  ruby-dev \
      rubygems \
      imagemagick \
      graphviz \
      memcached \
      libmemcached-tools \
      libmemcached-dev \
      libjpeg62-turbo-dev \
      libmcrypt-dev \
      libxml2-dev \
      libxslt1-dev \
      default-mysql-client \
      sudo \
      git \
      vim \
      nano \
      zip \
      wget \
      htop \
      iputils-ping \
      dnsutils \
      linux-libc-dev \
      libyaml-dev \
      libpng-dev \
      zlib1g-dev \
      libzip-dev \
      libicu-dev \
      libpq-dev \
      bash-completion \
      libldap2-dev \
      libssl-dev \
      libonig-dev \
	&& docker-php-ext-configure gd --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev \
        && docker-php-ext-install zip

# Install php extensions + added mysqli install
RUN docker-php-ext-install opcache pdo pdo_mysql && docker-php-ext-install mysqli

# Installation of Composer
RUN cd /usr/src && curl -sS http://getcomposer.org/installer | php
RUN cd /usr/src && mv composer.phar /usr/bin/composer

# Custom Opcache
RUN ( \
  echo "opcache.memory_consumption=128"; \
  echo "opcache.interned_strings_buffer=8"; \
  echo "opcache.max_accelerated_files=20000"; \
  echo "opcache.revalidate_freq=5"; \
  echo "opcache.fast_shutdown=1"; \
  echo "opcache.enable_cli=1"; \
  ) >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# Copia o arquivo de configuração do Apache para o contêiner
COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf

# Copy init-drupal.sh script into the container
COPY ./init-drupal.sh /var/www/html/
RUN cd /var/www/html && chmod +x ./init-drupal.sh

# Ativa o módulo de reescrita do Apache
RUN a2enmod rewrite
