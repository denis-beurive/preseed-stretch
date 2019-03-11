#!/bin/bash

# The set -e option instructs bash to immediately exit if any command has a non-zero exit status. 
set -e

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev
sudo apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm
sudo apt-get install -y libncurses5-dev  libncursesw5-dev xz-utils tk-dev

wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar xvf Python-3.6.4.tgz
cd Python-3.6.4
./configure --enable-optimizations
make -j8
sudo make altinstall
echo
echo "SUCCESS !"
echo
echo "You may execute the commands below:"
echo
echo "   - pip3.6 install --user pipenv"
echo "     # Install under ${HOME}/.local/bin/"
echo
echo "   - sudo pip3.6 install --upgrade pip"
echo
echo "   - pip3.6 --version"
echo