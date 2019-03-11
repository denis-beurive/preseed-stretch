#!/bin/bash

# The set -e option instructs bash to immediately exit if any command has a non-zero exit status. 
set -e

su -
apt-get install sudo -y
usermod -aG sudo dev
exit 0
echo "Please logout and login"