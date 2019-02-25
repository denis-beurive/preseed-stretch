#!/bin/bash

su -
apt-get install sudo -y
usermod -aG sudo dev
exit 0
echo "Please logout and login"