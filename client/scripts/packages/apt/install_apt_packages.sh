#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

local_root=$(pwd)

apt update
apt upgrade -y

apt install nala -y

nala install -y $(cat ${local_root}/packages_primary.list)
nala install -y $(cat ${local_root}local_root/packages_secondary.list)
