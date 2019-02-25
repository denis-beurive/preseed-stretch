#!/bin/bash

# Get the exact version of Virtual Box, installed on the host.
# Return The exact version of Virtual Box, installed on the host.

function get_version {
    echo "$(VBoxManage --version)"
}

# Get the major version of Virtual Box, installed on the host.
# Return The major version of Virtual Box, installed on the host.

function get_major_version {
    echo "$(VBoxManage --version | sed 's/^\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*$/\1/')"
}

# Get the version of the extension pack to install on the host.
# The extension pack activates the RDP connexion.
# Return The version of the extension pack to install on the host.

function get_pack_version {
    echo "$(VBoxManage --version | sed 's/^\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\)r\(.*\)$/\1-\2/')"
}

# Return the number of extension packs installed on the host.
# Return The number of extension packs installed on the host.

function get_extensions_count {
    echo "$(VBoxManage list extpacks | head -n 1 | sed 's/^Extension Packs: \([0-9][0-9]*\)$/\1/')"
}

# Return the URL where all the Virtual Box components can be downloaded.
# Return The URL where all the Virtual Box components can be downloaded.

function get_download_url {
    declare major_version=$(get_major_version)
    echo "https://download.virtualbox.org/virtualbox/${major_version}"
}

echo "readonly VBOX_VERSION=$(get_version)"
echo "readonly VBOX_MAJOR_VERSION=$(get_major_version)"
echo "readonly VBOX_URL=$(get_download_url)"
