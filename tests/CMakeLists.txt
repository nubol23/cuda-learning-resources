cmake_minimum_required(VERSION 3.13)
project(tests)

find_package(CUDA 9.0 REQUIRED)

if ($ENV{CLION_IDE})
    include_directories("/usr/local/cuda/include")
endif ()

set(CMAKE_CXX_STANDARD 11)

add_executable(
        tests main.cpp
        test_cuda.cu)