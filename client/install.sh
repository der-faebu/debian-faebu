#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

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

username=$(id -u -n 1000)
script_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -e "${YELLOW}Setting up try/catch"
bash $script_root/scripts/trycatch.sh

echo -e "${YELLOW}Installing apt packages"
bash $script_root/scripts/packages/apt/install_apt_packages.sh

usermod -aG $username libvirt
usermod -aG $username kvm

bash $script_root/scripts/configs/set_configs.sh $script_root

echo -e "${YELLOW}Setting up flatpak."
bash $script_root/scripts/packages/flatpak/setup_flatpak.sh

echo -e "${YELLOW}Installing flatpaks."
bash $script_root/scripts/packages/flatpak/install_flatpak.sh

# Reloading Font
fc-cache -vf

# Use nala
bash $script_root/scripts/configs/usenala.sh

