# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

# !!! DO NOT PLACE HEADER GUARDS HERE !!!

include(hunter_add_package)
include(hunter_download)
include(hunter_generate_qt_info)
include(hunter_pick_scheme)
include(hunter_status_debug)

## 5.5 only --
string(COMPARE EQUAL "qtgraphicaleffects" "qtquick1" _is_qtquick1)
string(COMPARE EQUAL "qtgraphicaleffects" "qtwebkit" _is_qtwebkit)
string(COMPARE EQUAL "qtgraphicaleffects" "qtwebkit-examples" _is_qtwebkit_examples)

if(_is_qtquick1 OR _is_qtwebkit OR _is_qtwebkit_examples)
  if(NOT HUNTER_Qt_VERSION MATCHES "^5\\.5\\.")
    return()
  endif()
endif()
## -- end

## 5.6 only --
string(COMPARE EQUAL "qtgraphicaleffects" "qtquickcontrol2" _is_qtquickcontrols2)
string(COMPARE EQUAL "qtgraphicaleffects" "qtwebview" _is_qtwebview)

if(_is_qtquickcontrols2 OR _is_qtwebview)
  if(NOT HUNTER_Qt_VERSION MATCHES "^5\\.6\\.")
    return()
  endif()
endif()
## -- end

hunter_generate_qt_info(
    "qtgraphicaleffects"
    _unused_toskip
    _depends_on
    _unused_nobuild
    "${HUNTER_Qt_VERSION}"
    "${ANDROID}"
    "${WIN32}"
)

foreach(_x ${_depends_on})
  hunter_add_package(Qt COMPONENTS ${_x})
endforeach()

# We should call this function again since hunter_add_package is include-like
# instruction, i.e. will overwrite variable values (foreach's _x will survive)
hunter_generate_qt_info(
    "qtgraphicaleffects"
    _unused_toskip
    _unused_depends_on
    _nobuild
    "${HUNTER_Qt_VERSION}"
    "${ANDROID}"
    "${WIN32}"
)

list(FIND _nobuild "qtgraphicaleffects" _dont_build_it)
if(NOT _dont_build_it EQUAL -1)
  hunter_status_debug(
      "Qt component doesn't install anything and will be skipped: qtgraphicaleffects"
  )
  return()
endif()

string(COMPARE EQUAL "qtgraphicaleffects" "qtdeclarative" _is_qtdeclarative)
if(WIN32 AND _is_qtdeclarative)
  find_program(_python_path NAME "python" PATHS ENV PATH)
  if(NOT _python_path)
    hunter_user_error(
        "Python not found in PATH:\n  $ENV{PATH}\n"
        "Python required for building Qt component (qtdeclarative):\n"
        "  http://doc.qt.io/qt-5/windows-requirements.html"
    )
  endif()
endif()

hunter_pick_scheme(DEFAULT url_sha1_qt)
hunter_download(
    PACKAGE_NAME Qt
    PACKAGE_COMPONENT "qtgraphicaleffects"
    PACKAGE_INTERNAL_DEPS_ID "8"
)
