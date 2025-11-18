#!/bin/bash

set -e

BUILD_TYPE=Release

rm -r build-android || true

cmake -GNinja -Bbuild-android \
  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
  -DANDROID_ABI=arm64-v8a \
  -DOPENCL_LIBRARIES=$HOME/opt/opencl/s25/lib/libOpenCL.so \
  -DOPENCL_INCLUDE_DIRS=$HOME/opt/opencl/s25/include \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  .

cmake --build build-android

adb push ./build-android/clblast_bw_test /data/local/tmp
adb shell "/data/local/tmp/clblast_bw_test 4 100 1024 1024 1024"
