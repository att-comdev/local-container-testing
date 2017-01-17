RABBITMQ NOTES

# run rabbitmq
docker build -t rabbitbuild .
docker run --name rabbit -d -p 5672:5672 -p 15672:15672 -v ~/debugger/debug-keystone/rabbitmq/data:/data/mnesia rabbitbuild

TODO:
build from scratch, using community version

