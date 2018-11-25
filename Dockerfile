FROM bitnami/php-fpm:7.1
LABEL maintainer "Absolvent <admin@absolvent.pl>"

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install software-properties-common build-essential git  && \
    apt-get -y install autoconf && \
    apt-get -y install nginx && \
    apt-get -y install supervisor && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive && \
    pecl channel-update pecl.php.net && \
    pecl install mongodb && \
    echo "extension=mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`

RUN DEBIAN_FRONTEND=noninteractive && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    chmod a+x composer.phar && \
    mv composer.phar /usr/bin/composer

RUN mkdir -p /scripts

ADD ./config/supervisord.conf /etc/supervisord.conf
COPY ./config/nginx /etc/nginx
COPY ./config/php-fpm.d /opt/bitnami/php/etc/php-fpm.d
COPY --chown=www-data:www-data ./scripts/ /scripts
COPY --chown=www-data:www-data help/help.md /help.md
COPY --chown=www-data:www-data ./example-data/public   /app/public
RUN chmod -R 777 /scripts

HEALTHCHECK --interval=30s --timeout=5s --retries=10 CMD "/scripts/healthcheck.sh"

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["/scripts/cmd.sh"]
