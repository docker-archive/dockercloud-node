#!/bin/bash

mkdir -p /etc/dockercloud/agent/
if [ ! -f "/etc/dockercloud/agent/dockercloud-agent.conf" ]; then
    cat > /etc/dockercloud/agent/dockercloud-agent.conf <<EOF
{
    "CertCommonName":"${CERT_COMMON_NAME}",
    "DockerHost":"${DOCKER_HOST_LISTEN}",
    "Host":"${HOST}",
    "Token":"${TOKEN}",
    "UUID":"${UUID}"
}
EOF
fi

echo "Using dockercloud-agent.conf:"
cat /etc/dockercloud/agent/dockercloud-agent.conf

mkdir -p /var/log/dockercloud && touch /var/log/dockercloud/docker.log && tail -F /var/log/dockercloud/docker.log &
exec /usr/bin/dockercloud-agent -stdout "$@"