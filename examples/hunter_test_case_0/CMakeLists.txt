cmake_minimum_required(VERSION 3.0)

# Emulate HunterGate:
# * https://github.com/hunter-packages/gate
include("../common.cmake")

project(hunter_test_case_0-examples)

hunter_add_package(hunter_test_case_0)
find_package(hunter_test_case_0 CONFIG REQUIRED)

add_executable(foo foo.cpp)
target_link_libraries(foo PUBLIC hunter_test_case_0::hunter_test_case_0)

enable_testing()
add_test(NAME TestFoo COMMAND foo)
