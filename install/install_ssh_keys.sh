#!/bin/bash

# The set -e option instructs bash to immediately exit if any command has a non-zero exit status. 
set -e

cd "${HOME}"
mkdir .ssh
chmod 0700 .ssh
cd .ssh
wget https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/data/vbox.pub.key
cat vbox.pub.key > authorized_keys
chmod 0444 authorized_keys
cd "${HOME}"

