cmake_minimum_required(VERSION 3.10.0)

project(api LANGUAGES CXX C)

add_library(
        NativeApi

        SHARED

        ../native/ffi_api_in_c.c
        ../native/ffi_api_in_cpp.cpp
)