if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  message(FATAL_ERROR "scintilla only supports dynamic linkage")
endif()
if(VCPKG_CRT_LINKAGE STREQUAL "static")
  message(FATAL_ERROR "scintilla only supports dynamic crt")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO torch/torch7
    REF dde9e56fb61eee040d7f3dba2331c6d6c095aee8
    SHA512 ef813e6f583f26019da362be1e5d9886ecf3306a2b41e5f7a73d432872eacd2745e0cf26bfcc691452f87611e02e302c54f07b2f3a3288744535e57d154a73db
    HEAD_REF master
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/debug.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/lib/TH
    PREFER_NINJA
    OPTIONS
        -DWITH_OPENMP=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/torch-th RENAME copyright)
