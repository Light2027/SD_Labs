FROM debian:jessie

## Run using: docker build --no-cache .

# Define Environment variables
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=test
ENV MYSQL_USER=admin
ENV MYSQL_PASSWORD=admin

# Mandatory Update
RUN apt update

# Install MySQL Server
RUN echo "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections

# RUNs are completely isolated from one another, so use &&
RUN apt -y install mysql-server && \
    service mysql restart && \
    printf "${MYSQL_ROOT_PASSWORD}\nn\ny\ny\ny\n" | mysql_secure_installation

EXPOSE 3306 33060

# Doing the configuration here as this is more convinient to the user and it works.
CMD service mysql restart && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'" || true && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT INSERT ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT CREATE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT DROP ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT SELECT ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysql --password=${MYSQL_ROOT_PASSWORD} -e "GRANT UPDATE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'" && \
    mysqld