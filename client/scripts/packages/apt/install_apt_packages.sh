#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

apt update
apt upgrade -y

apt install nala -y

nala install -y $(cat ./packages_primary.list)
nala install -y $(cat ./packages_secondary.list)
