
MYSQL NOTES
# Run mysql without docker compose
# note the -h mysql inthe command will create a /etc/hosts entry with ip of container. 
# allows users to connect to mysql from remote
docker run --name mysql -v ./storage/mysql:/var/lib/mysql -h mysql  -p 3306:3306 -d mysqlbuild

# storage/mysql is pulled into container as /var/lib/mysql. Any changes made to mysql is persisted to local storage/mysql
# idea is that developer don't need to recreate users and setting to start with.

# storage-fresh is fresh install of database files. To use copy storage-fresh into storage then run docker
# this will start with only a blank keystone database


# database was configured for root and keystone 
MariaDB [(none)]> grant all privileges on keystone.* to 'keystone'@'localhost' identified by 'keystone_password';
Query OK, 0 rows affected (0.01 sec)

MariaDB [(none)]> grant all privileges on keystone.* to 'keystone'@'%' identified by 'keystone_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all privileges on *.* to 'root'@'localhost' identified by 'root_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all privileges on *.* to 'root'@'%' identified by 'root_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> flush privileges;


# test connect to mysql in container from localhost. [using docker for mac]
mysql -u root -p -h 127.0.0.1


TODO:
set mysql root password from cfg file plus
mysql_secure_installation