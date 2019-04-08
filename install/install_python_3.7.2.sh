#!/bin/bash

# Turn on "strict mode".
# - See http://redsymbol.net/articles/unofficial-bash-strict-mode/.
# - See https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#The-Set-Builtin
#
# -e: exit immediately if a pipeline, which may consist of a single simple command, a list,
#     or a compound command returns a non-zero status. 
# -u: treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as
#     an error when performing parameter expansion. An error message will be written to the
#     standard error, and a non-interactive shell will exit.
# -o pipefail: if set, the return value of a pipeline is the value of the last (rightmost)
#              command to exit with a non-zero status, or zero if all commands in the pipeline
#              exit successfully.
set -eu -o pipefail

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev
sudo apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm
sudo apt-get install -y libncurses5-dev  libncursesw5-dev xz-utils tk-dev

# libffi-dev is already installed on Debian 9.
# But, on Ubuntu, you must install ot.
sudo apt-get install -y libffi-dev

wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
tar zxvf Python-3.7.2.tgz
cd Python-3.7.2
./configure --enable-optimizations --enable-shared
make -j8
sudo make altinstall
echo
echo "SUCCESS !"
echo
echo "You may execute the commands below:"
echo
echo "   - pip3.7 install --user pipenv"
echo "     # Install under ${HOME}/.local/bin/"
echo
echo "   - sudo pip3.7 install --upgrade pip"
echo
echo "   - pip3.7 --version"
echo
echo "Or, you may also execute:"
echo 
echo "    - pipenv install --python 3.7.2"
echo 