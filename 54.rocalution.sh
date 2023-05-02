#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocalution
cd $ROCM_BUILD_DIR/rocalution
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/hip/bin/hipcc cmake \
    -DHIP_CLANG_PATH=$ROCM_INSTALL_DIR/llvm/bin \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -DSUPPORT_HIP=ON \
    -DROCM_PATH=$ROCM_INSTALL_DIR \
    -G Ninja \
    $ROCM_GIT_DIR/rocALUTION

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

