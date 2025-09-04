FROM php:8.4.4-fpm-bookworm

ARG USER_ID
ARG GROUP_ID
ARG PM2_CONFIG

ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
ENV PM2_CONFIG=${PM2_CONFIG}
ENV NVM_DIR=/home/laravel/.nvm
ENV NODE_VERSION=18.20.2
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV TZ=Europe/Moscow

RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl vim zip unzip supervisor wget \
    libzip-dev libpng-dev libxml2-dev libonig-dev default-mysql-client \
    && pecl install redis \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd zip pdo_mysql mbstring bcmath \
    && docker-php-ext-enable redis \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY docker/${PM2_CONFIG} /home/laravel/pm2.json
COPY docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN addgroup --system --gid ${GROUP_ID} laravel \
    && adduser --system --uid ${USER_ID} --gid ${GROUP_ID} --home /home/laravel laravel \
    && mkdir -p /home/laravel/.nvm \
    && chown -R laravel:laravel /home/laravel /var/www/html

USER laravel
WORKDIR /var/www/html

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm use ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && npm install -g pm2 \
    && pm2 install pm2-logrotate \
    && curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

COPY --chown=laravel:laravel app/composer.* ./
RUN composer install --no-scripts --optimize-autoloader

COPY --chown=laravel:laravel app/package*.json ./
RUN npm ci

COPY --chown=laravel:laravel app/ ./
RUN composer install --optimize-autoloader && npm run build

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["/usr/local/bin/entrypoint.sh"]
