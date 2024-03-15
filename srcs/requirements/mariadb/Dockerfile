FROM alpine:3.15.6

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils 

# Create repos if not existing + Change repos owners/groups
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Installing mariadb tables in /var/lib/mysql
RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

# Copy and Execute script file
COPY ./config.sh /tmp/config.sh
RUN chmod +x /tmp/config.sh
ENTRYPOINT ["/tmp/config.sh"]
