FROM rabbitmq:latest
MAINTAINER Andre.Pollard@att.com, stolen from https://github.com/dockerfile/rabbitmq/blob/master/Dockerfile

RUN rabbitmq-plugins enable rabbitmq_management 

COPY ./scripts/post_container_setup.sh /root/post_container_setup.sh
RUN chmod +x /root/post_container_setup.sh

EXPOSE 4369 5671 5672 25672
CMD ["rabbitmq-server"]











