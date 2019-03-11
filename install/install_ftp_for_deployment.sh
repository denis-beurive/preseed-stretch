#!/bin/bash

# The set -e option instructs bash to immediately exit if any command has a non-zero exit status. 
set -e

readonly PROJECT_NAME="your_project"
readonly PROJECT_USER="user"
readonly PROJECT_DIR="/home/${PROJECT_USER}/projects/${PROJECT_NAME}"

# Install the binary

sudo apt update
sudo apt install vsftpd
if [ ! -f /etc/vsftpd.conf.orig ]; then
    sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
fi
sudo rm -f /etc/vsftpd.conf

# Set up the environment

if [ ! -d "${PROJECT_DIR}" ]; then
    sudo mkdir -p "${PROJECT_DIR}"
    sudo chown "${PROJECT_USER}":"${PROJECT_USER}" "${PROJECT_DIR}"
    sudo chmod 0700 "${PROJECT_DIR}"
fi

wget "https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/install/vsftpd.conf" -O "/tmp/vsftpd.conf"
sudo mv "/tmp/vsftpd.conf" "/etc/vsftpd.conf"
sudo systemctl restart vsftpd && echo "OK"

echo
echo "Command to test that the FTP server is running"
echo 
cat <<EOS

FTP_HOST=hostname
FTP_USER=ftpuser
FTP_PASS=ftppassword

touch test
(
   echo "
       open \${FTP_HOST}
       user \${FTP_USER} \${FTP_PASS}
       binary
       put test
       close
   "
) | ftp -dvin

EOS

