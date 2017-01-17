## local-container-testing
```
A local approach for developers to run/test/debug their OpenStack 
code inside Docker containers before pushing to remote. 
```

### Scope
```
Ability to pull keystone code into a docker container but will first launch associated 
supporting services such as (RabbitMQ, MySQL and Memcache) into their own containers.  
We are starting with Keystone, others container can be added later
```

### *Requirements*
```
Docker Engine (version 1.12 and up)
```

### Clone Repo and select desired keystone version
```
git clone https://github.com/att-comdev/local-container-testing.git
cd local-container-testing/keystone/code
git clone https://github.com/openstack/keystone.git #on master here
git checkout -b stable/mitaka
```

### Install Visual Studio Code
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
          ...        
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

### Launch services with docker-compose up
```
cd local-container-testing
docker-compose -f docker-compose.debug.yml up --build -d
# Note: this will wait at the breakpoint set in the code
```

## Enable Visual Studio Code Debugging 
```
  Left Icon looking like a bug
  Click the Debug drop down green arrow, select 'Attach (Remote Debug)'
  Should see debugging variables populate and be able to step through the 
  code in the debugger
```


### Shutdown services with docker-compose down
```
cd local-container-testing
docker-compose -f docker-compose.debug.yml down
```


#### Test Openstack with Openstack client
```
openstack --os-auth-url http://keystone:35357/v3 \
  --os-project-domain-name default --os-user-domain-name default \
  --os-password admin_password \
  --os-project-name admin --os-username admin token issue
```


## TODO

* Add other OpenStack Core Services
