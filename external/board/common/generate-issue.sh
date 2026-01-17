#!/bin/sh

BUILDROOT_DIR="$(realpath "$BR2_EXTERNAL_AA_MIRROR_OS_PATH/..")"
git config --global --add safe.directory "$BUILDROOT_DIR"
BUILDROOT_COMMIT=$(git -C "$BUILDROOT_DIR" log -n1 --pretty=format:%h HEAD)

cat <<EOF > "$TARGET_DIR/etc/issue"
Welcome to aa-mirror


                              __                                         
.---.-.---.-.______.--------.|__|.----.----.-----.----.______.----.-----.
|  _  |  _  |______|        ||  ||   _|   _|  _  |   _|______|   _|__ --|
|___._|___._|      |__|__|__||__||__| |__| |_____|__|        |__| |_____|
                                                                         
                                                                                                                                                                                                                                                                             
                                                                    
https://github.com/FlorinBD/aa-mirror-rs
build date: $(date +%Y-%m-%d), br# $BUILDROOT_COMMIT

EOF
