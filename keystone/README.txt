Manual run

docker run --name keystone --link mysql --link memcache  --link memcache -v ./keystone/ 
--env-file ./environment.cfg -d -p 35357:35357 -p 5000:5000 keystonebuild /bin/bash     keystone-manage db_sync






