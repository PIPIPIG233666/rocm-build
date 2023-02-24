#!/bin/bash

set -e

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
    -G Ninja \
    $ROCM_GIT_DIR/hipamd

    # -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR/hip/install \
ninja
doas ninja install

# ?
doas ln -sf /opt/rocm/hip/lib/**.so** /opt/rocm/lib/

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

