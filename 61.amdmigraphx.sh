#!/bin/bash

set -e

CXX=$ROCM_INSTALL_DIR/llvm/bin/clang++ \
  doas cmake -P $ROCM_GIT_DIR/AMDMIGraphX/install_deps.cmake --prefix /usr/local

mkdir -p $ROCM_BUILD_DIR/amdmigraphx
cd $ROCM_BUILD_DIR/amdmigraphx
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/llvm/bin/clang++ cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/AMDMIGraphX

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

