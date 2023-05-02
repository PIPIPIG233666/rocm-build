#!/bin/bash

set -e

cd $ROCM_GIT_DIR/rocprofiler
git reset --hard
git apply $ROCM_PATCH_DIR/33.rocprofile-gcc13.patch

mkdir -p $ROCM_BUILD_DIR/rocprofiler
cd $ROCM_BUILD_DIR/rocprofiler
pushd .

START_TIME=`date +%s`

CXX=clang++ cmake \
    -DPROF_API_HEADER_PATH=$ROCM_GIT_DIR/roctracer/inc/ext/ \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/rocprofiler

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

