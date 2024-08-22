#!/bin/bash

set -e
username=$1
# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

apt update && apt upgrade -y
apt install -y nala 

username=$(id -un $1)
# Configure bash to use nala wrapper instead of apt
usenala="/home/$username/.use-nala"
rusenala="/root/.use-nala"
ubashrc="/home/$username/.bashrc"
rbashrc="/root/.bashrc"
if [ ! -f "$usenala" ]; then
cat << \EOF > "$usenala"
apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}
EOF
cat << EOF >> "$ubashrc"
if [ -f "$usenala" ]; then
        . "$usenala"
fi
EOF
fi

if [ ! -f "$rusenala" ]; then
cat << \EOF > "$rusenala"
apt() {
  command nala "$@"
}
EOF
cat << EOF >> "$rbashrc"
if [ -f "$rusenala" ]; then
        . "$rusenala"
fi
EOF
fi
