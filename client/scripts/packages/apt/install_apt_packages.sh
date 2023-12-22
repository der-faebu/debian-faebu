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

echo -e "${YELLOW}Installing primary packages"
nala install -y $(cat ${SCRIPT_DIR}/packages_primary.list) --no-fix-broken
echo -e "${YELLOW}Installing secondary packages"
nala install -y $(cat ${SCRIPT_DIR}/packages_secondary.list) --no-fix-broken
