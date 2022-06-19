#!/bin/bash

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp -f $script_dir/xrt_setup.sh $target/etc/profile.d
cd $BUILD_ROOT/${PYNQ_BOARD}/petalinux_project
petalinux-build -c zocl
sudo rsync -av --keep-dirlinks $BUILD_ROOT/${PYNQ_BOARD}/petalinux_project/build/tmp/sysroots-components/*/zocl/usr $target
sudo rsync -av --keep-dirlinks $BUILD_ROOT/${PYNQ_BOARD}/petalinux_project/build/tmp/sysroots-components/*/zocl/lib $target
