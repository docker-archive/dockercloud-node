FROM ubuntu:trusty

RUN apt-get update && \
	apt-get install -yq iptables apt-transport-https ca-certificates

ENV DIND_COMMIT=b8bed8832b77a478360ae946a69dab5e922b194e
ADD https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind /usr/local/bin/dind
RUN chmod +x /usr/local/bin/dind
VOLUME /var/lib/docker

ENV DOCKER_VERSION=1.11.2-cs7 NGROK_VERSION=1.7 GPG_KEY_ID=A87A2270 GPG_KEY_PACKAGE_ID=A87A2270 REPO=https://repo.cloud.docker.com/ubuntu/ CERT_COMMON_NAME=*.node.dockerapp.io DOCKER_HOST=unix:///var/run/docker.sock DOCKER_HOST_LISTEN=tcp://0.0.0.0:2375 HOST=https://cloud.docker.com/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys $GPG_KEY_PACKAGE_ID
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys $GPG_KEY_ID
RUN echo deb [arch=amd64] $REPO dockercloud main > /etc/apt/sources.list.d/dockercloud.list
RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y dockercloud-agent
ADD https://files.cloud.docker.com/packages/docker/docker-$DOCKER_VERSION.tgz /tmp/
ADD https://files.cloud.docker.com/packages/ngrok/ngrok-$NGROK_VERSION.tgz /tmp/
RUN mkdir -p /usr/lib/dockercloud/ && \
	tar zxf /tmp/docker-$DOCKER_VERSION.tgz -C /usr/bin/ --strip-components 1 && \
	tar zxf /tmp/ngrok-$NGROK_VERSION.tgz -C /usr/lib/dockercloud/ --strip-components 1
ADD run.sh /

EXPOSE 2375
ENTRYPOINT ["/usr/local/bin/dind", "/run.sh"]