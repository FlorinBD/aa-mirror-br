#!/bin/bash

# -------------------------------
# Compute hash of external packages for cache key
# -------------------------------
compute_package_hash() {
    BUILDROOT_DIR="$(pwd)/buildroot"
    if [[ -d "$BUILDROOT_DIR/package" ]]; then
        # Hash all files in package/ recursively
        find "$BUILDROOT_DIR/package" -type f -exec sha256sum {} + | sort | sha256sum | awk '{print $1}'
    else
        echo "nopkg"
    fi
}

if [ -z "$1" ]; then
    echo "Error: No argument provided."
    echo "Usage: $0 <board/shell>"
    exit 1
fi

ARG=$1

if [ "$ARG" = "shell" ]; then
    echo "Entering interactive shell..."
    exec /bin/bash # Replace the current script process with a bash shell
else
    # make the configs dir writable
    sudo chmod a+w external/configs
    # merge defconfig for specified board
    external/scripts/defconfig_merger.sh ${ARG}

    BUILDROOT_DIR=/app/buildroot
    OUTPUT=${BUILDROOT_DIR}/output/${ARG}
    mkdir -p ${OUTPUT}
    cd ${BUILDROOT_DIR}
    #./utils/update-rust 1.91.0 #needed by adb_client 2.1.19
    make BR2_EXTERNAL=../external/ O=${OUTPUT} gen_${ARG}_defconfig
    cd ${OUTPUT}
    make -j$(nproc --all)
fi
