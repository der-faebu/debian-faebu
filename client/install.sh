#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
script_root=$(pwd)

bash $script_root/scripts/trycatch.sh
bash $script_root/scripts/packages/apt/install_apt_packages.sh

usermod -aG $username libvirt
usermod -aG $username kvm

# Making .config and Moving config files and background to Pictures
bash $script_root/scripts/configs/set_configs.sh

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
mkdir -p /home/$username/.local/share/fonts
cd $script_root 
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.local/share/fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.local/share/fonts
chown $username:$username /home/$username/.local/share/fonts*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $script_root
rm -rf Nordzy-cursors

# Use nala
bash $script_root/scripts/configs/usenala.sh
