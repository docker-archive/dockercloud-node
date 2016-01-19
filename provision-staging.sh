#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -q
sudo apt-get install -yq curl
curl -Ls http://files.cloud.docker.com.s3.amazonaws.com/scripts/install-agent.sh | sudo -H EPO=repo-test.cloud.docker.com.s3.amazonaws.com GPG_KEY_PACKAGE_ID=90E64D7C HOST=https://cloud-stage.docker.com/ sh