
MYSQL NOTES
# Run mysql without docker compose
# allows users to connect to mysql from remote
docker run --name db -v ./storage/mysql:/var/lib/mysql  -p 3306:3306 -d mysqlbuild

# storage/mysql is pulled into container as /var/lib/mysql. Any changes made to mysql is persisted to local storage/mysql
# idea is that developer don't need to recreate users and setting to start with.


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
