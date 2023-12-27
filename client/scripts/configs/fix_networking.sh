#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi
### 
# remove ifupdown package
# set ifupdown to 'true' in /etc/NetworkManager/NetworkManager.conf
# remove ifupdown package from 'main' section in /etc/NetworkManager/NetworkManager.conf