# Usar una imagen base de Apache y PHP
FROM php:apache

# Instalar nano y la extensión mysqli
RUN apt-get update && \
    apt-get install -y nano && \
    docker-php-ext-install mysqli

# Copiar archivos al directorio de documentos de Apache
COPY ./public-html/ /var/www/html/

# Cambiar el propietario de los archivos copiados
RUN chown -R www-data:www-data /var/www/html/

# Cambiar los permisos de los archivos copiados
RUN chmod -R 755 /var/www/html/

