#!/bin/bash

set -e

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

username=$(id -un $1)
#----------------------------------------#
# Setup colours #

BLACK="\033[0;30m"        # Black
RED="\033[0;31m"          # Red
GREEN="\033[0;32m"        # Green
YELLOW="\033[0;33m"       # Yellow
BLUE="\033[0;34m"         # Blue
PURPLE="\033[0;35m"       # Purple
CYAN="\033[0;36m"         # Cyan
WHITE="\033[0;37m"        # White

#----------------------------------------#
script_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

username=$(id -u $1)
builddir=$(pwd)

echo "$username"
echo -e "${YELLOW}Installing nala"
bash $script_root/scripts/setup_nala.sh $username

echo -e "${YELLOW}Installing essential programs"
bash $script_root/scripts/apt/install_package_list.sh install primary

echo -e "${YELLOW}Setting up docker"
bash $script_root/scripts/setup_docker.sh $username
