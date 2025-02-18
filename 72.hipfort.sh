#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/hipfort
cd $ROCM_BUILD_DIR/hipfort
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/hip/bin/hipcc cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Unix Makefiles" \
    $ROCM_GIT_DIR/hipfort

make -j24
doas make -j24 install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

