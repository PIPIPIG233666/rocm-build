#!/bin/bash

set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

mkdir -p $ROCM_BUILD_DIR/rocfft
cd $ROCM_BUILD_DIR/rocfft
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/hip/bin/hipcc cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/rocFFT

    # -DCMAKE_INSTALL_PREFIX=rocfft-install \
ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

