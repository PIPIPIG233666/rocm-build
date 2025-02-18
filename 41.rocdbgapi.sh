#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocdbgapi
cd $ROCM_BUILD_DIR/rocdbgapi
pushd .

START_TIME=`date +%s`

CC=/opt/rocm/llvm/bin/clang cmake \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -G Ninja \
    $ROCM_GIT_DIR/ROCdbgapi

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

