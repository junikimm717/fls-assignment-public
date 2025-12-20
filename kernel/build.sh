#!/usr/bin/env bash

set -euo pipefail

DIR="$(realpath "$(dirname "$0" )" )"

# some convenience variables
KERNEL_SRC="$SRC/kernel"
