#!/bin/bash

set -e

# CMake Warning at src/CMakeLists.txt:257 (message):
# Profiling API header not found.  Disabling roctracer integration.  Use
# -DPROF_API_HEADER_PATH=<path to prof_protocol.h header>
# rerun after running 34.roctracer.sh

cd $ROCM_GIT_DIR/ROCclr
git reset --hard
git apply $ROCM_PATCH_DIR/18.hip-gcc13.patch

mkdir -p $ROCM_BUILD_DIR/hip
cd $ROCM_BUILD_DIR/hip
pushd .

ROCclr_DIR=$ROCM_GIT_DIR/ROCclr
OPENCL_DIR=$ROCM_GIT_DIR/ROCm-OpenCL-Runtime
HIP_DIR=$ROCM_GIT_DIR/HIP

START_TIME=`date +%s`

cmake \
    -DOFFLOAD_ARCH_STR="--offload-arch=$AMDGPU_TARGETS" \
    -DHIP_COMMON_DIR="$HIP_DIR" \
    -DAMD_OPENCL_PATH="$OPENCL_DIR" \
    -DROCCLR_PATH="$ROCCLR_DIR" \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DROCM_PATCH_VERSION=50100 \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -G Ninja \
    $ROCM_GIT_DIR/hipamd

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

