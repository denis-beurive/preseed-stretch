#!/bin/bash

su -
apt-get install sudo -y
usermod -aG sudo dev
