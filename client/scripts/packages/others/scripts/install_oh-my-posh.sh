#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /home/$username/bin

# Installing fonts

mkdir -p /home/$username/.local/share/fonts
cd $SCRIPT_DIR 
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.local/share/fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.local/share/fonts
chown $username:$username /home/$username/.local/share/fonts*

rm -r FiraCode.zip Meslo.zip