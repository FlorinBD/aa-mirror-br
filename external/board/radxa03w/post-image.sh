#!/bin/bash

set -u
set -e
set -x

support/scripts/genimage.sh -c $BR2_EXTERNAL_AA_MIRROR_OS_PATH/board/radxa03w/genimage.cfg

