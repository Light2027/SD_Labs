FROM debian:jessie

# Mandatory Update
RUN apt update

# Install and configure Apache2
RUN apt install -y apache2
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && service apache2 restart

# Install PHP
RUN apt install -y php5 libapache2-mod-php5 php5-mcrypt php5-mysql unzip

# Set the working directory + volume
WORKDIR /var/www/html
COPY wordpress-5.8.2.zip .
VOLUME /var/www/html

# Install Wordpress
RUN unzip -q wordpress-5.8.2.zip -d . && \
    cd wordpress && \
    cp -a * .. && \
    cd .. && \
    rm -r wordpress-5.8.2.zip && \
    rm -r wordpress && \
    rm index.html && \
    chown www-data:www-data -R /var/www/html/

EXPOSE 80

CMD . /etc/apache2/envvars && apache2 && tail -f /dev/null