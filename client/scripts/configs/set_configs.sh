#!/bin/bash
username=$(id -u -n 1000)

# Making .config and Moving config files and background to Pictures
builddir=$1

echo "${YELLOW} Builddir: $builddir"

cd $builddir

mkdir /home/$username/.config
cp -R $builddir/dotconfig/config_files/* /home/$username/.config/

cp $builddir/.bashrc /home/$username/.bashrc
cp $builddir/.bash_logout /home/$username/.bash_logout
cp $builddir/.bash_aliases /home/$username/.bash_aliases

chown -R $username:$username /home/$username
