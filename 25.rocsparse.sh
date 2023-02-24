#!/bin/bash

set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

mkdir -p $ROCM_BUILD_DIR/rocsparse
cd $ROCM_BUILD_DIR/rocsparse
pushd .

START_TIME=`date +%s`

FC=gfortran CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DHIP_CLANG_INCLUDE_PATH=$ROCM_INSTALL_DIR/llvm/include \
    -DBUILD_CLIENTS_SAMPLES=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DROCM_PATH=$ROCM_INSTALL_DIR \
    -G Ninja \
    $ROCM_GIT_DIR/rocSPARSE

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

