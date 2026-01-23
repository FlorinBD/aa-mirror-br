#!/bin/bash

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

    # --------------------------------------------------
    # Enable ccache (CI-safe, non-interactive)
    # --------------------------------------------------
    if grep -q "^# BR2_CCACHE is not set" .config; then
        sed -i 's/^# BR2_CCACHE is not set/BR2_CCACHE=y/' .config
    fi

    make BR2_EXTERNAL=../external olddefconfig
   # --------------------------------------------------
    # Generate board defconfig
    # --------------------------------------------------
    make BR2_EXTERNAL=../external O=${OUTPUT} gen_${ARG}_defconfig

    cd ${OUTPUT}
    
    # --------------------------------------------------
    # Force ATF rebuild if bl31.elf is missing
    # --------------------------------------------------
    ATF_ELF="${OUTPUT}/images/bl31.elf"
    if [[ ! -f "$ATF_ELF" ]]; then
        echo "bl31.elf missing, forcing ATF rebuild..."
        rm -rf "${OUTPUT}/build/arm-trusted-firmware-"*
    fi
    # --------------------------------------------------
    # Build
    # --------------------------------------------------
    make -j$(nproc --all)
    make -j$(nproc --all)
fi
