# local-container-testing
Please see [release notes](https://github.com/att-comdev/halcyon-vagrant-kubernetes/releases) for current and planned features.

A local approach for developers to run/test/debug their OpenStack code inside Docker containers before pushing to remote. 

## Requirements

  * Docker Engine (version 1.12 and up)


## Manual Build Run
A manual build that will spin up associated service dependencies [RabbitMQ, MySQL, Memcach] each inside their own Container. We start a Keystone Container as our proof of concept. Others container can be added later

### Launch
```
# clone repo and make scripts executable
git clone https://github.com/att-comdev/local-container-testing.git
chmod +X launch.sh reset_db.sh clean.sh

# reset mysql database with skeleton mysql. Currently keystone database created
./reset_db.sh

# launch script to build images, run containers. First run will take significant more time than repeted runs as parts of the build will get cached
./launch.sh
```
 
### Clean Up
./clean.sh


 
## Docker-Compose Build Run

```
* COMMING SOON
```

## Manual Build Test

```
* COMMING SOON
```

## Docker-Compose Build Test

```
* COMMING SOON
```

## Manual Build Debug

```
* COMMING SOON
```
## Docker-Compose Build Debug

```
* COMMING SOON
```


# TODO

* Add other OpenStack Core Services