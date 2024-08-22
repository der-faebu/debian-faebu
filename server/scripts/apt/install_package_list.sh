#!/bin/bash
set -e
# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./$(basename "$0")" 2>&1
  exit 1
fi

if [ "$#" -lt 2 ]; then
  echo "You must use 2 arguments:"
  echo "Usage: $0 <install|remove> <package_list>"
fi

ACTION=$1
LIST=$2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -e "${YELLOW}Installing $LIST packages"
apt $ACTION -y $(cat ${SCRIPT_DIR}/packages/$ACTION/$LIST.list) 