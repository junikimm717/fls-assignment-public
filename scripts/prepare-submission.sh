#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"
DIST=$(realpath "$DIR/../dist")

NAME="submission-$(docker run alpine arch).tar.gz"

DIRTY="$(git status --porcelain)"

if [ -n "$DIRTY" ]; then
  echo "=============================================="
  echo "WARNING: Your working tree has uncommitted files"
  echo "=============================================="
  echo
  echo "The following changes WILL NOT be included:"
  echo
  echo "$DIRTY"
  echo
  echo "This submission will ONLY include committed files."
  echo
  echo "Fix options:"
  echo "  1. git add + git commit your changes"
  echo "  2. git stash them"
  echo "  3. re-run with --allow-dirty (not recommended)"
  echo
fi

mkdir -p "$DIST"
git archive HEAD --format=tar.gz -o "$DIST/$NAME"

echo "Created a submission at $DIST/$NAME"
