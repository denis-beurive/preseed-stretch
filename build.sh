#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
export __DIR__="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

. "${__DIR__}/lib/reporting.sh"

readonly ISO="${__DIR__}/data/debian-9.8.0-amd64-netinst.iso"
readonly CUSTOM_ISO="${__DIR__}/custom.iso"
readonly ORIGINAL_ISO="${__DIR__}/iso_original"
readonly NEW_ISO="${__DIR__}/iso_new"
readonly PRESEED_CFG="${__DIR__}/data/preseed.cfg"
readonly ISOLINUX_CFG="${__DIR__}/data/isolinux.cfg"
readonly PROMPT_CFG="${__DIR__}/data/prompt.cfg"
readonly TXT_CFG="${__DIR__}/data/txt.cfg"

cd "${__DIR__}" || error "Cannot change directory to \"${__DIR__}\"."

if [ "${NEW_ISO}" = "/" ]; then
    error "WARNING !!! Please set NEW_ISO !!!"
fi

# ---------------------------------------------------------
# Sanity checks
# ---------------------------------------------------------

if [ -d "${ORIGINAL_ISO}" ]; then
    sudo umount "${ORIGINAL_ISO}"
    sudo rm -ir "${ORIGINAL_ISO}" || error "The directory \"${ORIGINAL_ISO}\" exists. Please remove it."    
fi

if [ -d "${NEW_ISO}" ]; then
    rm -rf "${NEW_ISO}" || error "The directory \"${NEW_ISO}\" exists. Please remove it."   
fi

rm -f "${CUSTOM_ISO}" || error "Cannot remove \"${CUSTOM_ISO}\"."

# ---------------------------------------------------------
# Mount the ISO file
# ---------------------------------------------------------

mkdir "${NEW_ISO}" "${ORIGINAL_ISO}" || error "Cannot create the directories \"${NEW_ISO}\" and \"${ORIGINAL_ISO}\"."

sudo mount -o loop -t iso9660 "${ISO}" "${ORIGINAL_ISO}" || error "Cannot mount the ISO file \"${ISO}\"."

rsync -a -H "${ORIGINAL_ISO}/" "${NEW_ISO}" || error "rsync failed!"

chmod -R u+w "${NEW_ISO}" || error "Cannot change permissions on \"${NEW_ISO}\"."

# ---------------------------------------------------------
# Copy the files.
# ---------------------------------------------------------

readonly ISOLINUX_DIR="${NEW_ISO}/isolinux"
readonly ISOLINUX_TARGET="${ISOLINUX_DIR}/isolinux.cfg"
readonly PROMPT_TARGET="${ISOLINUX_DIR}/prompt.cfg"
readonly TXT_TARGET="${ISOLINUX_DIR}/txt.cfg"
readonly PRESEED_TARGET="${NEW_ISO}/preseed.cfg"

echo "Creating  \"${PRESEED_TARGET}\""
echo "Replacing \"${ISOLINUX_TARGET}\""
echo "Replacing \"${PROMPT_TARGET}\""
echo "Replacing \"${TXT_TARGET}\""

cp "${PRESEED_CFG}" "${PRESEED_TARGET}"   || error "Cannont copy \"${PRESEED_CFG}\" to \"${PRESEED_TARGET}\"."
cp "${ISOLINUX_CFG}" "${ISOLINUX_TARGET}" || error "Cannont copy \"${ISOLINUX_CFG}\" to \"${ISOLINUX_TARGET}\"."
cp "${PROMPT_CFG}" "${PROMPT_TARGET}"     || error "Cannont copy \"${PROMPT_CFG}\" to \"${PROMPT_TARGET}\"."
cp "${TXT_CFG}" "${TXT_TARGET}"           || error "Cannont copy \"${TXT_CFG}\" to \"${TXT_TARGET}\"."

# ---------------------------------------------------------
# Build the ISO file.
# ---------------------------------------------------------

cd "${NEW_ISO}" && md5sum `find -follow -type f` > md5sum.txt
chmod -R u-w "${NEW_ISO}" || error "Cannot change permissions on \"${NEW_ISO}\"."
sudo genisoimage -o "${CUSTOM_ISO}" -r -J -no-emul-boot \
                 -boot-load-size 4 \
                 -boot-info-table \
                 -b isolinux/isolinux.bin \
                 -c isolinux/boot.cat \
                 "${NEW_ISO}" || error "Cannot create the custom ISO!"
cd -

echo
echo "SUCCESS"

