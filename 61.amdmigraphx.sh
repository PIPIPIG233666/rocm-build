#!/bin/bash

WORKON_HOME=~/virtenv
source virtualenvwrapper.sh
workon SD-py311
pip3 install https://github.com/RadeonOpenCompute/rbuild/archive/master.tar.gz
# install onnx package for unit tests
pip3 install onnx numpy typing pytest packaging CppHeaderParser

# pin version of protobuf in Python for onnx runtime unit tests
pip3 install protobuf

set -e

# account for installation folder difference
# not needed after 5.5 df2e7635
# sed -i 's|#include <rocblas.h>|#include <rocblas/rocblas.h>|g' $ROCM_GIT_DIR/AMDMIGraphX/src/targets/gpu/gemm_impl.cpp
# sed -i 's|#include <rocblas.h>|#include <rocblas/rocblas.h>|g' $ROCM_GIT_DIR/AMDMIGraphX/src/targets/gpu/include/migraphx/gpu/rocblas.hpp


cd $ROCM_GIT_DIR/AMDMIGraphX
git reset --hard
git apply /home/pppig/rocm-build/patch/61.amdmigraphx-gcc13.patch
rbuild build -d depend -B build --cc=/opt/rocm/llvm/bin/clang --cxx=/opt/rocm/llvm/bin/clang++

cd build
doas make install

START_TIME=`date +%s`

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

