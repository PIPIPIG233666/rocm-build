#!/bin/bash

set -e

cd $ROCM_GIT_DIR/ROCm-OpenCL-Runtime
git reset --hard
git apply $ROCM_PATCH_DIR/31.rocm-opencl-runtime-gcc13.patch

mkdir -p $ROCM_BUILD_DIR/rocm-opencl-runtime
cd $ROCM_BUILD_DIR/rocm-opencl-runtime
pushd .

START_TIME=`date +%s`

cmake \
    -DUSE_COMGR_LIBRARY=ON \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -Dhsa-runtime64_DIR=$ROCM_INSTALL_DIR/lib/cmake/hsa-runtime64 \
    -G Ninja \
    $ROCM_GIT_DIR/ROCm-OpenCL-Runtime

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

