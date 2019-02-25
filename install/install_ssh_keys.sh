#!/bin/bash

cd "${HOME}"
mkdir .ssh
chmod 0700 .ssh
cd .ssh
wget https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/data/vbox.pub.key
cat vbox.pub.key > authorized_keys2 
chmod 0444 authorized_keys2 
cd "${HOME}"

