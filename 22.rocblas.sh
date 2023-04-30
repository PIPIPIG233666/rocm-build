#!/bin/bash

set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

mkdir -p $ROCM_BUILD_DIR/rocblas
cd $ROCM_BUILD_DIR/rocblas
pushd .

START_TIME=`date +%s`

cd $ROCM_GIT_DIR/rocBLAS

CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DROCM_PATH=$ROCM_INSTALL_DIR \
    -DTensile_LOGIC=asm_full \
    -DTensile_ARCHITECTURE=all \
    -DTensile_CODE_OBJECT_VERSION=V3 \
    -DCMAKE_BUILD_TYPE=Release \
    -DTensile_LIBRARY_FORMAT=yaml \
    -DRUN_HEADER_TESTING=OFF \
    -DTensile_COMPILER=hipcc \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -G "Unix Makefiles" \
    $ROCM_GIT_DIR/rocBLAS

make -j24
doas make install -j24

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

