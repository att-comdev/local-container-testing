FROM ubuntu:16.04
MAINTAINER andre.pollard@att.com

RUN apt-get update -qq && \
    apt-get install -y  memcached python-memcache

# copy in memcache configuration 
COPY ./memcached.conf /etc/memcached.conf

EXPOSE 11211

# Default Memcached run command arguments
CMD ["-u", "memcache", "-m", "64"]

# Set the user to run Memcached daemon
USER memcache

# Set the entrypoint to memcached binary
ENTRYPOINT memcached





