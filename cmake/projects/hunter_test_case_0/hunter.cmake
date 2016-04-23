# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

# !!! DO NOT PLACE HEADER GUARDS HERE !!!

include(hunter_add_version)
include(hunter_cacheable)
include(hunter_download)
include(hunter_pick_scheme)

hunter_add_version(
    PACKAGE_NAME
    hunter_test_case_0
    VERSION
    1.0.0
    URL
    "https://github.com/hunter-test-cases/hunter_test_case_0/archive/v1.0.0.tar.gz"
    SHA1
    5bc0a2b61a00583891548d051672c0c6e372de03
)

hunter_pick_scheme(DEFAULT url_sha1_cmake)
hunter_cacheable(hunter_test_case_0)
hunter_download(PACKAGE_NAME hunter_test_case_0)
