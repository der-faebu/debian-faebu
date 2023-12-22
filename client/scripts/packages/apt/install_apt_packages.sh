#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

apt update
apt upgrade -y

apt install nala -y

nala install -y $(cat ${SCRIPT_DIR}/packages_primary.list)
nala install -y $(cat ${SCRIPT_DIR}local_root/packages_secondary.list)
