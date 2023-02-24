#!/bin/bash

set -e

if [ ! -d $ROCM_GIT_DIR/ck ; then]
  git clone https://github.com/ROCmSoftwarePlatform/composable_kernel $ROCM_GIT_DIR/ck

mkdir -p $ROCM_BUILD_DIR/ck
cd $ROCM_BUILD_DIR/ck
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/bin/hipcc cmake \
  -D CMAKE_PREFIX_PATH=$ROCM_INSTALL_DIR \
  -D CMAKE_CXX_FLAGS="-O3" \
  -D CMAKE_BUILD_TYPE=Release \
  -D GPU_TARGETS="gfx1030" \
  $ROCM_GIT_DIR/ck

doas make install -j24

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

