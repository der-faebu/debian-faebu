#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

wget https://dl.thorium.rocks/debian/dists/stable/thorium.list
mv thorium.list /etc/apt/sources.list.d/
nala update
nala install thorium-browser -y