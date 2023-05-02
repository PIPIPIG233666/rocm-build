#!/bin/bash

set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

cd $ROCM_GIT_DIR/llvm-project
git reset --hard
git apply $ROCM_PATCH_DIR/11.rocm-llvm-gcc13-flang.patch
git apply $ROCM_PATCH_DIR/11.rocm-llvm-gcc13-llvm.patch
git apply $ROCM_PATCH_DIR/11.rocm-llvm-gcc13-openmp.patch
git apply $ROCM_PATCH_DIR/11.rocm-llvm-gcc13-openmp2.patch

mkdir -p $ROCM_BUILD_DIR/llvm-amdgpu
cd $ROCM_BUILD_DIR/llvm-amdgpu
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR/llvm/ \
    -DLLVM_ENABLE_ASSERTIONS=1 \
    -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
    -DLLVM_ENABLE_PROJECTS="compiler-rt;lld;clang;flang;llvm" \
    -G Ninja \
    $ROCM_GIT_DIR/llvm-project/llvm

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

