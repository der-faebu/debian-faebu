#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

# add deb http://deb.debian.org/debian/ bookworm main contrib non-free
dpkg --add-architecture i386
nala update
nala install steam-installer
nala install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
