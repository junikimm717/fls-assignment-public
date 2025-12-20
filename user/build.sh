#!/usr/bin/env bash

set -euo pipefail

DIR="$(realpath "$(dirname "$0" )" )"

# some convenience variables if you want to use them.
EUDEV_SRC="$SRC/eudev"
CHRONY_SRC="$SRC/chrony"
DHCPCD_SRC="$SRC/dhcpcd"
