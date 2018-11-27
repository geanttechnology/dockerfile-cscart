
FROM php:fpm-alpine

# Install package imagemagick
RUN apk add --no-cache imagemagick
# Install php-extention mysqli
RUN docker-php-ext-install mysqli
# Install php-extention pdo_mysql
RUN docker-php-ext-install pdo_mysql
# Install php-extention exif
RUN docker-php-ext-install exif
# Install php-extention mbstring
# # php-extention mbstring is enabled in php:fpm-alpine.
# Install php-extention openssl
# # php-extention openssl is enabled in php:fpm-alpine.

# Install php-extention gd
RUN apk add --no-cache --virtual .build-deps-gd libjpeg-turbo-dev libpng-dev;\
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr;\
    docker-php-ext-install gd;\
    apk del .build-deps-gd

# Install php-extention zip
# # php-extention zip is enabled in php:fpm-alpine.
# Install php-extention curl
# # php-extention curl is enabled in php:fpm-alpine.
# Install php-extention phar
# # php-extention phar(phar.so) is loaded in php:fpm-alpine.

# suhosin setup
RUN {   echo 'suhosin.memory_limit = 0';\
        echo 'suhosin.post.max_vars = 3000';\
        echo 'suhosin.get.max_totalname_length = 3000';\
        echo 'suhosin.session.encrypt = Off';\
        echo 'suhosin.session.cryptua = Off';\
        echo 'suhosin.cookie.cryptdocroot = Off';\
        echo 'suhosin.session.cryptdocroot = Off';\
        }   | tee -a /usr/local/etc/php/php.ini*

EXPOSE 9000
CMD ["php-fpm"]
