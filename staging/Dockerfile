FROM ubuntu:trusty

RUN apt-get update && \
	apt-get install -yq iptables apt-transport-https ca-certificates

ENV DIND_COMMIT=b8bed8832b77a478360ae946a69dab5e922b194e
ADD https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind /usr/local/bin/dind
RUN chmod +x /usr/local/bin/dind
VOLUME /var/lib/docker

ENV DOCKER_VERSION=1.9.1-cs2 GPG_KEY_ID=A87A2270 GPG_KEY_PACKAGE_ID=90E64D7C REPO=http://repo-test.cloud.docker.com.s3.amazonaws.com/ubuntu/ CERT_COMMON_NAME=*.node.tutum.us DOCKER_HOST=unix:///var/run/docker.sock DOCKER_HOST_LISTEN=tcp://0.0.0.0:2375 HOST=https://cloud-stage.docker.com/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys $GPG_KEY_PACKAGE_ID
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys $GPG_KEY_ID
RUN echo deb [arch=amd64] $REPO dockercloud main > /etc/apt/sources.list.d/dockercloud.list
RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y dockercloud-agent
ADD https://packages.docker.com/1.9/builds/linux/amd64/docker-$DOCKER_VERSION /usr/lib/dockercloud/docker
RUN chmod +x /usr/lib/dockercloud/docker && ln -s /usr/lib/dockercloud/docker /usr/bin/docker
ADD run.sh /

EXPOSE 2375
ENTRYPOINT ["/usr/local/bin/dind", "/run.sh"]