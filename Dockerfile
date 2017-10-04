FROM ubuntu:xenial
MAINTAINER quick.es@gmail.com
RUN apt-get update
RUN apt-get install -y apache2 wget \
  php php-mysql php-ldap php-xmlrpc curl php-curl php-gd \
  libapache2-mod-php php-mbstring php-imap php-apcu php-xml
WORKDIR /var/www/html
COPY start.sh /opt/
RUN a2enmod rewrite \
  && service apache2 stop \
  && chmod +x /opt/start.sh \
  && usermod -u 1000 www-data
CMD /opt/start.sh
EXPOSE 80
