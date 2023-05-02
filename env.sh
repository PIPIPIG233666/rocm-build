#!/bin/bash

export ROCM_INSTALL_DIR=/opt/rocm
export ROCM_PATH=$ROCM_INSTALL_DIR
export ROCM_MAJOR_VERSION=5
export ROCM_MINOR_VERSION=5
export ROCM_PATCH_VERSION=0
export ROCM_LIBPATCH_VERSION=50500
export ROCM_GIT_DIR=/home/pppig/ROCm
export ROCM_BUILD_DIR=/home/pppig/rocm-build/build
export ROCM_PATCH_DIR=/home/pppig/rocm-build/patch
export AMDGPU_TARGETS="gfx1030"
export PATH=$ROCM_INSTALL_DIR/bin:$ROCM_INSTALL_DIR/llvm/bin:$ROCM_INSTALL_DIR/hip/bin:$PATH
export HIP_CLANG_PATH=$ROCM_INSTALL_DIR/llvm/bin

