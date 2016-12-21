
#!/bin/bash

rm -rf mysql/storage-old/mysql

# keep one version of the last mysql used
mv -f mysql/storage/mysql mysql/storage-old/mysql

# copy in a blank mysql db structure with keystone database already set
cp -R mysql/storage-fresh/mysql mysql/storage/mysql