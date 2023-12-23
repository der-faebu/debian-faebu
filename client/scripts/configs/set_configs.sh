#!/bin/bash
username=$(id -u -n 1000)

# Making .config and Moving config files and background to Pictures
builddir=$1

echo "${YELLOW} Builddir: $builddir"

cd $builddir

mkdir /home/$username/.config
cp -R $builddir/dotconfig/config_files/* /home/$username/.config/

cp -f $builddir/dotconfig/bash/.bashrc /home/$username/.bashrc
cp -f $builddir/dotconfig/bash/.bash_logout /home/$username/.bash_logout
cp -f $builddir/dotconfig/bash/.bash_aliases /home/$username/.bash_aliases

chown -R $username:$username /home/$username
