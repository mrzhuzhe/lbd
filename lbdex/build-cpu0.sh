#!/usr/bin/env bash
LLVM_DIR=../llvm-project/debug
CUR_DIR=/home/sanszhu/code/code/lbd/lbdex
LLVM_TEST_DIR=../temp_llvm/test
if ! test -d ${LLVM_TEST_DIR}; then
  mkdir ${LLVM_TEST_DIR}
  cd ${LLVM_TEST_DIR}
  cp -r ../debug/* .
# ln clang is must since Cpu0 asm boot.cpp and start.h need building clang on 
# llvm/Cpu0.
  # ln -s ${LLVM_DIR}/clang clang
  # ln -s ${LLVM_DIR}/llvm llvm
  cd ${CUR_DIR}
  cp -rf llvm/modify/llvm/* ${LLVM_TEST_DIR}/llvm/.
  cp -rf Cpu0 ${LLVM_TEST_DIR}/llvm/lib/Target/.
  cp -rf regression-test/Cpu0 ${LLVM_TEST_DIR}/llvm/test/CodeGen/.
  OS=`uname -s`
  echo "OS =" ${OS}
  cd ${LLVM_TEST_DIR}
  rm -rf build
  mkdir build
  cd build
# clang has better diagnosis in report error message
  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
  -DLLVM_TARGETS_TO_BUILD=Cpu0 -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_OPTIMIZED_TABLEGEN=On \
  -DLLVM_PARALLEL_COMPILE_JOBS=4 -DLLVM_PARALLEL_LINK_JOBS=1 -G "Unix Makefiles" ../llvm 
  time make -j4
  # popd
else
  echo "${LLVM_TEST_DIR} has existed already"
  cd ${CUR_DIR}
  cp -rf llvm/modify/llvm/* ${LLVM_TEST_DIR}/llvm/.
  cp -rf Cpu0 ${LLVM_TEST_DIR}/llvm/lib/Target/.
  cp -rf regression-test/Cpu0 ${LLVM_TEST_DIR}/llvm/test/CodeGen/.
  OS=`uname -s`
  echo "OS =" ${OS}
  cd ${LLVM_TEST_DIR}
  rm -rf build
  mkdir build
  cd build
# clang has better diagnosis in report error message
  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
  -DLLVM_TARGETS_TO_BUILD=Cpu0 -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_OPTIMIZED_TABLEGEN=On \
  -DLLVM_PARALLEL_COMPILE_JOBS=4 -DLLVM_PARALLEL_LINK_JOBS=1 -G "Unix Makefiles" ../llvm 
  time make -j4
fi

