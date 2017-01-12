# local-container-testing

A local approach for developers to run/test/debug their OpenStack code inside Docker containers before pushing to remote. 

## Requirements

  * Docker Engine (version 1.12 and up)


## Docker Compose Up
Will build and spin up associated service dependencies [RabbitMQ, MySQL, Memcach] each inside their own Container. We start a Keystone Container as our proof of concept. Others container can be added later

### Launch
Clone repo and make scripts executable

```
git clone https://github.com/att-comdev/local-container-testing.git
docker-compose -f docker-compose.debug.yml up --build -d
```

Grab the latest keystone code or whatever version you need from github. 
If using another version, update ./keystone/etc configuration file and 
setting appropriately with the correct keystone config files and their settings
```
cd ./keystone/code/keystone
git pull *OR* git clone https://git.openstack.org/openstack/keystone

``` 

Docker Compose Down

```
docker-compose -f docker-compose.debug.yml down
```

### Requirements
- Visual Studio Code (http://code.visualstudio.com/)
- Visual Studio code Plugin for Python Syntacs and Remote Debugging (https://marketplace.visualstudio.com/search?term=python&target=VSCode&sortBy=Relevance)
- Done in Container: Visual Studio Code Python Tools for remote debugging server (https://pypi.python.org/pypi/ptvsd OR pip install ptvsd)
- Add the following lines of code into the top of the module you would like to degug. Note remote has to be same as local, but since we are mounting dir into container it is the same

  For example, keystone controllers.py at: 
  local-container-testing/keystone/code/keystone/keystone/identity/controllers.py
    ```
    import ptvsd
    ptvsd.enable_attach("my_secret", address = ('0.0.0.0', 3001))

    #Enable the below line of code only if you want the application to wait untill the debugger has attached to it
    #ptvsd.wait_for_attach()
    ```
- Set a break point in the controllers.py file as an example, at line 50
    ```
    50 CONF = keystone.conf.CONF
    51 LOG = log.getLogger(__name__)
    ```
- Done: Add python remote debugging section to: LOCAL-CONTAINER-TESTING/.vscode/launch.json
    ```               
          {
                          "name": "Attach (Remote Debug)",
                          "type": "python",
                          "request": "attach",
                          "localRoot": "${workspaceRoot}",
                          "remoteRoot": "/var/lib/keystone",
                          "port": 3001,
                          "secret": "my_secret",
                          "host": "localhost"
          }
    ```


# TODO

* Add other OpenStack Core Services
