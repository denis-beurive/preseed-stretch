#!/bin/bash

# Run "tools/vbox.sh" on the host.

readonly VBOX_VERSION='5.2.26r128414'
readonly VBOX_MAJOR_VERSION='5.2.26'
readonly VBOX_URL='https://download.virtualbox.org/virtualbox/5.2.26'

# ---------------------------------------------------

readonly GUEST_ADDITIONS="VBoxGuestAdditions_${VBOX_MAJOR_VERSION}.iso"
readonly URL="${VBOX_URL}/${GUEST_ADDITIONS}"

wget "${URL}" && \
mkdir iso && \
sudo mount -o loop "${GUEST_ADDITIONS}" ./iso && \
cd iso && \
sudo ./VBoxLinuxAdditions.run && \
cd - && \

echo 
echo "SUCCESS"
echo
echo "Reboot the VM"
echo 
echo "And look at this document: \"Set a shared folder\" at https://github.com/denis-beurive/virtualbox."
echo

