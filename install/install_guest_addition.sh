#!/bin/bash

# ---------------------------------------------------
# CONFIURATION:
#
# This configuration has been generated.
#
# Run "tools/vbox.sh" on the host.
# ---------------------------------------------------

readonly VBOX_VERSION='5.2.26r128414'
readonly VBOX_MAJOR_VERSION='5.2.26'
readonly VBOX_URL='https://download.virtualbox.org/virtualbox/5.2.26'

# ---------------------------------------------------
# End of configuration
# ---------------------------------------------------

function prompt_continue {

    if [ $# -gt 0 ]; then
        declare question="${1}"
    else 
        declare question="Do you wish to continue? (Y/N) "
    fi

    while true; do
        read -p "${question}" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y or N. ";;
        esac
    done
}

echo "This script will install the Guest Addition for Virtual Box version ${VBOX_VERSION}"
echo
echo "Is it OK ? Did you run the script \"vbox.sh\" on the host ?"
echo 

prompt_continue

echo

# ---------------------------------------------------
# Install the kernel headers
# ---------------------------------------------------

readonly HEADERS=$(apt-cache show linux-headers-$(uname -r) | egrep '^Package: ' | head -1 | sed 's/^Package: //')

if [ -z "${HEADERS}" ]; then
    echo "Cannot find the package that contains the kernel headers!"
    exit 1
fi

sudo apt-get install "${HEADERS}"

# ---------------------------------------------------
# Install the guest addition
# ---------------------------------------------------

readonly GUEST_ADDITIONS="VBoxGuestAdditions_${VBOX_MAJOR_VERSION}.iso"
readonly URL="${VBOX_URL}/${GUEST_ADDITIONS}"

wget "${URL}" && \
mkdir iso && \
sudo mount -o loop "${GUEST_ADDITIONS}" ./iso && \
cd iso && \
sudo ./VBoxLinuxAdditions.run && \
cd - && \
sudo umount iso

echo 
echo "SUCCESS"
echo
echo "Reboot the VM"
echo 
echo "Then look at this document:"
echo
echo "https://github.com/denis-beurive/virtualbox#install-the-guest-addition"
echo

