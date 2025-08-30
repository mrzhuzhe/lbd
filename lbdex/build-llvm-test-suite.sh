#!/usr/bin/env bash

# Please set your LLVM_DIR
LLVM_DIR=../temp_llvm

# Cpu0 set the other installed DIRs here
LLVM_SRC_DIR=${LLVM_DIR}/
LLVM_TEST_SUITE_DIR=${LLVM_SRC_DIR}/llvm-test-suite
LLVM_DEBUG_DIR=${LLVM_DIR}/debug

# ref.
# https://llvm.org/docs/TestSuiteGuide.html
# https://github.com/mollybuild/RISCV-Measurement/blob/master/Build-RISCV-LLVM-and-run-testsuite.md

### Prerequisites
# On Ubuntu,
# sudo apt-get install tcl tk tcl-dev tk-dev
# On macos,
# brew install tcl-tk
# ${LLVM_DEBUG_DIR}/build: build with clang and compiler-rt, -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" --> ref. https://github.com/Jonathan2251/lbd/blob/master/lbdex/install_llvm/build-llvm.sh

build() {
  cmake -DCMAKE_C_COMPILER=$(pwd)/../debug/build/bin/clang -C../test-suite/cmake/caches/O3.cmake -DCMAKE_C_FLAGS=-fPIE -DCMAKE_CXX_FLAGS=-fPIE ../test-suite
  make
}


cd ${LLVM_TEST_SUITE_DIR}
build
