FROM nginx:stable-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel

RUN sed -i "s/user www-data/user laravel/g" /etc/nginx/nginx.conf

ADD ./nginx/default.prod.conf /etc/nginx/conf.d/default.conf
ADD ./nginx/laravel.test.pem /etc/nginx/certs/laravel.test.pem
ADD ./nginx/laravel.test-key.pem /etc/nginx/certs/laravel.test-key.pem

RUN mkdir -p /var/www/html
