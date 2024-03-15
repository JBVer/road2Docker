#!/bin/sh

# Set up MARIADB, create DB, User & Privileges:

	# Create tfile
	tfile=`mktemp`

	# Verify if tfile exists: '[' is same as 'test' command
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	# While EOF, cat within tfile
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PWD' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PWD' WITH GRANT OPTION;
CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' identified by '$MYSQL_USER_PWD';
CREATE USER '$MYSQL_USER'@'localhost' identified by '$MYSQL_USER_PWD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Setup mariadb with tfile
/usr/bin/mysqld --user=mysql --bootstrap --skip-name-resolve --skip-networking=0 < $tfile
rm -f $tfile

# Allow remote connections (modif mariadb-server.cnf file): skip-networking tells MDB to run without any TCP/IP networking options
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# Run mysqld
exec /usr/bin/mysqld --user=mysql --skip-name-resolve 

# Flags : 
# --skip-name-resolve: only IP addresses are used for connections. Host names are not resolved
# --bootstrap: use to execute SQL scripts (before any privileges or table exist)
