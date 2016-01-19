#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -q
sudo apt-get install -yq curl
curl -Ls https://get.cloud.docker.com/ | sudo -H sh