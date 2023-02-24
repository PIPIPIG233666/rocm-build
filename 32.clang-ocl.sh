#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/clang-ocl
cd $ROCM_BUILD_DIR/clang-ocl
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -G Ninja \
    $ROCM_GIT_DIR/clang-ocl

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

