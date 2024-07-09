#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

username=$(id -u -n 1000)

builddir=$1

echo "${YELLOW} Builddir: $builddir"

cd $builddir

mkdir /home/$username/.config
cp -R $builddir/dotconfig/config_files/* /home/$username/.config/

cp -f $builddir/dotconfig/bash/.bashrc /home/$username/.bashrc
cp -f $builddir/dotconfig/bash/.bash_logout /home/$username/.bash_logout
cp -f $builddir/dotconfig/bash/.bash_aliases /home/$username/.bash_aliases
cp -f $builddir/dotconfig/vim/.vimrc /home/$username/.vimrc


usermod -aG libvirt $username
usermod -aG kvm $username

chown -R $username:$username /home/$username
source /home/$username/.bashrc
