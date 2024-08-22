#!/bin/bash

set -e
username=$1

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

if [ "$#" != 1 ]; then
  echo "You must use exactly 1 argument: username or user id"
  echo "Usage: $0 <username|user_id>"
  exit 2
fi

script_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ -d "/etc/apt/keyrings" ]; then
  echo "the dir does not exist"
  install -m 0755 -d /etc/apt/keyrings
fi

if [ -f "/etc/apt/keyrings/docker.gpg" ]; then
  echo "The key already exists. Removing..."
  rm /etc/apt/keyrings/docker.gpg
fi

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

nala upgrade -y

bash $script_root/apt/install_package_list.sh remove docker
bash $script_root/apt/install_package_list.sh install docker

usermod -aG docker $username
