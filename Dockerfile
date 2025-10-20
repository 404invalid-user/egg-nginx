FROM alpine:latest
RUN apk update && apk upgrade
RUN apk --no-cache add curl ca-certificates nginx 
RUN apk --no-cache add php82 php82-xml php82-exif php82-fpm php82-session php82-soap php82-openssl php82-gmp php82-pdo_odbc php82-json php82-dom php82-pdo php82-zip php82-mysqli php82-sqlite3 php82-pdo_pgsql php82-bcmath php82-gd php82-odbc php82-pdo_mysql php82-pdo_sqlite php82-gettext php82-xmlreader php82-bz2 php82-iconv php82-pdo_dblib php82-curl php82-ctype php82-phar php82-fileinfo php82-mbstring php82-tokenizer php82-simplexml
COPY --from=composer:latest  /usr/bin/composer /usr/bin/composer
RUN ln -s /usr/bin/php82 /usr/bin/php
RUN ln -s /usr/sbin/php-fpm82 /usr/bin/php-fpm

RUN adduser -D -h /home/container container
USER container
ENV USER=container
ENV HOME=/home/container
ENV PATH="/usr/sbin:/usr/bin:$PATH"

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
