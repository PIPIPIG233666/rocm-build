#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocm-device-libs
cd $ROCM_BUILD_DIR/rocm-device-libs
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/ROCm-Device-Libs

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

