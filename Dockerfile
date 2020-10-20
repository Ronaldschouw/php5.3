FROM centos:6.6
LABEL Maintainer="Ronald Schouw <mail@ronalt.nl>" 
WORKDIR /var/www/html
RUN yum install -y \
        gcc \
        php \
        php-devel \
        php-mysql \
        php-pear \
        php-pear-Net-Socket \
        php-pecl-apc \
        php-gd \
        php-gd \
        php-xml \
        php-pgsql \
        httpd
RUN pear install Mail Auth_SASl Net_SMTP
RUN sed -i "s/80/8080/g" /etc/httpd/conf/httpd.conf
RUN echo 'TransferLog /dev/stdout' >> /etc/httpd/conf/httpd.conf && \
    echo 'ErrorLog /dev/stderr' >> /etc/httpd/conf/httpd.conf \
    echo 'CustomLog combined' >> /etc/httpd/conf/httpd.conf
EXPOSE 8080
CMD ["apachectl", "-D", "FOREGROUND"]
