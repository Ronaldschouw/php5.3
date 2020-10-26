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
        postgresql \
        rsync \
        httpd
RUN pear install Mail Auth_SASl Net_SMTP
RUN sed -i "s/80/8080/g" /etc/httpd/conf/httpd.conf 
RUN sed -i "s/run\/httpd.pid/tmp\/httpd.pid/g" /etc/httpd/conf/httpd.conf 
RUN find /etc/httpd/conf/httpd.conf -type f -exec sed -ri ' \
    s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
    s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
' '{}' ';'
EXPOSE 8080
CMD ["apachectl", "-D", "FOREGROUND"]
