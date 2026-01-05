#!/usr/bin/env bash
set -euo pipefail

DIR="$(realpath "$(dirname "$0")")"
cd "$DIR"

IMAGE="ghcr.io/junikimm717/fls-grading/dev"
CONTAINER="test-builder-lfs"

# ------------------------------------------------------------
# pull image (do not build locally — grader pulls)
# ------------------------------------------------------------
docker pull "$IMAGE"

# ------------------------------------------------------------
# paths
# ------------------------------------------------------------
WORKSPACE_HOST="$(realpath "$DIR/..")"
DIST_HOST="$WORKSPACE_HOST/dist"

mkdir -p "$DIST_HOST"

# ------------------------------------------------------------
# clean up any previous container
# ------------------------------------------------------------
docker rm -f "$CONTAINER" >/dev/null 2>&1 || true

# ------------------------------------------------------------
# create hardened builder container
# ------------------------------------------------------------
docker create \
  --name "$CONTAINER" \
  --read-only \
  --network none \
  --tty \
  --memory 8g \
  --pids-limit 512 \
  --cpus 8 \
  -v "$WORKSPACE_HOST:/workspace:ro" \
  --tmpfs /tmp:rw,exec,size=4g \
  --tmpfs /dist:rw,exec,size=10g \
  --tmpfs /writable_src:rw,exec,size=6g \
  -e DIST=/dist \
  -e SRC=/writable_src \
  "$IMAGE" \
  /usr/bin/tini -- sleep infinity

docker start "$CONTAINER"

# ------------------------------------------------------------
# run build (exactly matches grader exec)
# ------------------------------------------------------------
echo "[*] running build-all-stages.sh"

docker exec \
  "$CONTAINER" \
  sh -c 'rsync -a --delete /src/ /writable_src/ && exec /build-all-stages.sh'

# ------------------------------------------------------------
# stream artifact out (NO docker cp)
# ------------------------------------------------------------
echo "[*] streaming bootable.img"

TMP_OUT="$(mktemp)"
docker exec "$CONTAINER" sh -c 'exec cat /dist/bootable.img' >"$TMP_OUT"

# size guard (220 MB, matches grader)
MAX_BYTES=$((220 * 1024 * 1024))
ACTUAL_BYTES="$(wc -c < "$TMP_OUT")"

if (( ACTUAL_BYTES > MAX_BYTES )); then
  echo "error: bootable.img too large (${ACTUAL_BYTES} bytes)" >&2
  rm -f "$TMP_OUT"
  exit 1
fi

mv "$TMP_OUT" "$DIST_HOST/bootable.img"

echo "[✓] bootable.img written to dist/bootable.img"

# ------------------------------------------------------------
# cleanup
# ------------------------------------------------------------
docker rm -f "$CONTAINER" >/dev/null
