FROM nginx:alpine

MAINTAINER Yannic Wilkening

RUN apk add --no-cache git openssh && \
	mkdir /root/.ssh && \
	touch /root/.ssh/known_hosts && \
	chmod 600 /root/.ssh/known_hosts

ADD ./id_rsa /root/.ssh/

RUN chmod 600 /root/.ssh/id_rsa && \
	ssh-keyscan iot.iavtech.net >> /root/.ssh/known_hosts && \
	git clone git@iot.iavtech.net:smartParking && \
	rm -rf /root/.ssh/id_rsa && \
	cp -r ./smartParking/01_Crossbar/web/* /usr/share/nginx/html && \
	rm -rf ./smartParking && \
	apk del git openssh

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80