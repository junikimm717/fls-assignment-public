#!/bin/sh

set -eu
DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

PART="image" ./dev-container.sh
