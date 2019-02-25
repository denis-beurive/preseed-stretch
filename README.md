# Description

This repository presents the procedure used to build a custom ISO file that performs a fully unattended installation of Debian Stretch Minimal ([netinst](https://www.debian.org/CD/netinst/)).

# Prerequisites

Standard Debian Stretch Minimal (netinst) ISO file: [debian-9.8.0-amd64-netinst.iso](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.8.0-amd64-netinst.iso)

# Procedure

Edit the file "`build.sh`" and set the variables listed below:

* **ISO**: the path to the original (downloaded) ISO file.
* **CUSTOM_ISO**: the path to the custom ISO file that will be created.

Then run the script "`build.sh`".

# Users

User "dev":

* **user**: `dev`
* **password**: `dev`

User "root":

* **user**: `root`
* **password**: `admin`

> See the [preseed file](data/preseed.cfg).

# First connection

    ssh -v -o PreferredAuthentications=password -o PubkeyAuthentication=no -p <ssh port> dev@<host>

* `<ssh port>` is the port used by the SSH server (usually 22).
* `<host>` is the host that runs the SSH server.

Example:

    ssh -v -o PreferredAuthentications=password -o PubkeyAuthentication=no -p 1122 dev@localhost

# SSH configuration

    wget https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/install/install_ssh_keys.sh
    chmod +x install_ssh_keys.sh
    ./install_ssh_keys.sh

The SSH keys are:

* [Public key](https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/data/vbox.pub.key).
* [Private Key](https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/data/vbox.key).

Example of configuration for the file `~/.ssh/config`:

    host debian-host
        HostName localhost
        user dev
        Port 1122
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/vbox.key
        IdentitiesOnly yes

Then you can run `ssh debian-host`.

# links

## List of all Debian distributions

[https://www.debian.org/releases/](https://www.debian.org/releases/)

## List of preseed files for all distributions

    https://www.debian.org/releases/<distribution name>/example-preseed.txt

Replace "`<distribution name>`" by the name of the distribution (ex: "`jessie`", "`stretch`"...).

## General information about preseeding

[https://www.debian.org/releases/stable/amd64/apbs02.html.en](https://www.debian.org/releases/stable/amd64/apbs02.html.en)

Please note that this document is not very accurate. However, we get useful information:

> For the other preseeding methods you need to tell the installer what file to use when you boot it. This is normally done by passing the kernel a boot parameter, either manually at boot time or by editing the bootloader configuration file (e.g. syslinux.cfg) and adding the parameter to the end of the append line(s) for the kernel.

> If you do specify the preconfiguration file in the bootloader configuration, **you might change the configuration so you don't need to hit enter to boot the installer. For syslinux this means setting the timeout to 1 in syslinux.cfg**.

> Note that preseed/url can be shortened to just url, preseed/file to just file and preseed/file/checksum to just preseed-md5 when they are passed as boot parameters.

## Disable CD/DVD scan

[https://unix.stackexchange.com/questions/409212/preseed-directive-to-skip-another-cd-dvd-scanning](https://unix.stackexchange.com/questions/409212/preseed-directive-to-skip-another-cd-dvd-scanning)

Please note that the configuration parameters to disable the scan are not in the preseed examples.

## Generic procedure for building a preseed distribution.

[http://debian-facile.org/doc:install:preseed](http://debian-facile.org/doc:install:preseed)

This document helped me a lot.

## General information

List of timezones: [https://en.wikipedia.org/wiki/List_of_tz_database_time_zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_)

Keyboard configuration for french users: [https://medspx.fr/blog/Debian/preseed_snippets/](https://medspx.fr/blog/Debian/preseed_snippets/)



