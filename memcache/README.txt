# run memcache and put local IP for memcache into etc/hosts with parameter -h memcache
docker run --name memcache -d -p 11211:11211 -h memcache memcachebuild 

# memcached.conf will have 
# Specify which IP address to listen on. The default is to listen on all IP addresses
# This parameter is one of the only security measures that memcached has, so make sure
# it's listening on a firewalled interface.
-l memcache