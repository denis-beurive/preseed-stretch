# Description

The directory contains scripts that can be used once the installation is over.

The two following scripts should be run first:

* `install_ssh_keys.sh`: this script setups a public SSH key. The public and the private keys are in the [data directory](https://github.com/denis-beurive/preseed-stretch/tree/master/data).
* `install_sudo.sh`: this script installs the `sudo` utility.

To install a script, just grab it over HTTP:

    wget https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/install/<name of the script>

And then execute it.

