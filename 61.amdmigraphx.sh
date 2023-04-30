#!/bin/bash


WORKON_HOME=~/virtenv
source virtualenvwrapper.sh
workon SD-py311
pip3 install https://github.com/RadeonOpenCompute/rbuild/archive/master.tar.gz

set -e

# account for installation folder difference
sed -i 's|#include <rocblas.h>|#include <rocblas/rocblas.h>|g' $ROCM_GIT_DIR/AMDMIGraphX/src/targets/gpu/gemm_impl.cpp
sed -i 's|#include <rocblas.h>|#include <rocblas/rocblas.h>|g' $ROCM_GIT_DIR/AMDMIGraphX/src/targets/gpu/include/migraphx/gpu/rocblas.hpp

cd $ROCM_GIT_DIR/AMDMIGraphX
rbuild build -d depend -B build

cd build
doas make install

START_TIME=`date +%s`

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

