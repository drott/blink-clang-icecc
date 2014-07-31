#!/bin/bash
if [ ! -d src/third_party/llvm-build/Release+Asserts/bin/clang_chromium ]; then
  mkdir src/third_party/llvm-build/Release+Asserts/bin/clang_chromium
  mv src/third_party/llvm-build/Release+Asserts/bin/clang src/third_party/llvm-build/Release+Asserts/bin/clang++ src/third_party/llvm-build/Release+Asserts/bin/clang_chromium/
fi
ln -s /usr/bin/icecc src/third_party/llvm-build/Release+Asserts/bin/clang
ln -s /usr/bin/icecc src/third_party/llvm-build/Release+Asserts/bin/clang++
ICECCVERSIONFILE=$(/usr/lib/icecc/icecc-create-env --clang $(pwd)/src/third_party/llvm-build/Release+Asserts/bin/clang_chromium/clang $(pwd)/src/third_party/llvm-build/Release+Asserts/bin/clang_chromium/clang++ --addfile $(pwd)/src/third_party/llvm-build/Release+Asserts/lib/libFindBadConstructs.so --addfile $(pwd)/src/third_party/llvm-build/Release+Asserts/lib/libstdc++.so.6 | grep creating.*tar\.gz | cut -d' ' -f2)
PLUGIN_PATH=$(tar -tf ${ICECCVERSIONFILE}|grep libFindBadConstructs.so)
STDLIB_PATH=$(tar -tf ${ICECCVERSIONFILE}|grep libstdc)
echo ${PLUGIN_PATH}
echo ${STDLIB_PATH}

echo "export ICECC_VERSION=$(pwd)/${ICECCVERSIONFILE}"
