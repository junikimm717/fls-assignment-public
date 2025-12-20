#!/bin/sh

set -eu
DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

PART="user" ./dev-container.sh
