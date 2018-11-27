
# dockerfile-cscart-shoppingcart

Dockerfile for [CS-Cart Shoppingcart](https://www.cs-cart.com/cscart.html).

Mount CS-Cart source tree under /var/www/html.
Here is a sample code.

~~~
version: '3.1'

services:

  cscart-fpm: 
    image: alkaased/php-cscart:fpm-alpine
    volumes:
      - ./${APPD:-app}:/var/www/html
    networks:
      - overlay
    depends_on:
      - mysql-cscart

  mysql-cscart:
   image: mysql:5
   restart: always
#      ports:
#        - 3306:3306
   environment:
     MYSQL_DATABASE: cscart
     MYSQL_USER: username
     MYSQL_USER: username
     MYSQL_PASSWORD: password
     MYSQL_RANDOM_ROOT_PASSWORD: '1'
   networks:
     - overlay

  nginx: 
     image: nginx:stable-alpine
     volumes:
       - ./nginx/conf.d:/etc/nginx/conf.d
       - ./nginx/CA:/etc/nginx/CA
       - ./${APPD:-app}:/var/www/html
     ports: 
       - 80:80
       - 443:443
     networks:
       - overlay
     depends_on:
       - cscart-fpm
 
networks:
  overlay:
~~~
