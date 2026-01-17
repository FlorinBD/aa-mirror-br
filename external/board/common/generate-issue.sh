#!/bin/sh

BUILDROOT_DIR="$(realpath "$BR2_EXTERNAL_AA_MIRROR_OS_PATH/..")"
git config --global --add safe.directory "$BUILDROOT_DIR"
BUILDROOT_COMMIT=$(git -C "$BUILDROOT_DIR" log -n1 --pretty=format:%h HEAD)

cat <<EOF > "$TARGET_DIR/etc/issue"
Welcome to aa-proxy

                             _
  __ _  __ _       _ __ ___ (_)_ __ _ __ ___  _ __      _ __ ___ 
 / _` |/ _` |_____| '_ ` _ \| | '__| '__/ _ \| '__|____| '__/ __|
| (_| | (_| |_____| | | | | | | |  | | | (_) | | |_____| |  \__ \
 \__,_|\__,_|     |_| |_| |_|_|_|  |_|  \___/|_|       |_|  |___/

https://github.com/aa-proxy/aa-proxy-rs
build date: $(date +%Y-%m-%d), br# $BUILDROOT_COMMIT

EOF
