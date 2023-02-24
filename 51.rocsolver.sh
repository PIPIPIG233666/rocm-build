#!/bin/bash

set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

mkdir -p $ROCM_BUILD_DIR/rocsolver
cd $ROCM_BUILD_DIR/rocsolver
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/hip/bin/hipcc cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/rocSOLVER

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

