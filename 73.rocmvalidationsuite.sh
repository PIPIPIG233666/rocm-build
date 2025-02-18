#!/bin/bash

set -e

cd $ROCM_GIT_DIR/ROCmValidationSuite
git reset --hard
git apply $ROCM_PATCH_DIR/73.rocmvalidationsuite-gcc13.patch

mkdir -p $ROCM_BUILD_DIR/rocmvalidationsuite
cd $ROCM_BUILD_DIR/rocmvalidationsuite
pushd .

START_TIME=`date +%s`

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    $ROCM_GIT_DIR/ROCmValidationSuite

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

