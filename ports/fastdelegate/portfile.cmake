#header-only library
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Claxon/FastDelegate
    REF v1.0.0
    SHA512 9161ac29340ecf9ac10188efe78eb7ba45532dee7ca247c31eb236836db559b9750c536f45f95cbc2baf242cd174486148a272351324064a740662f5fd03a5ef
    HEAD_REF master
)

# Use FastDelegate's own build process, skipping examples and tests
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMAKE_INSTALL_DIR:STRING=cmake
)
vcpkg_install_cmake()

# Move CMake config files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)

# Delete redundant directories
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/share/doc)

# Put the licence file where vcpkg expects it
file(COPY ${SOURCE_PATH}/license.txt ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/fastdelegate)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/fastdelegate/license.txt ${CURRENT_PACKAGES_DIR}/share/fastdelegate/copyright)
file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/FastDelegate)

#if(VCPKG_USE_HEAD_VERSION)
#    file(READ "${CURRENT_PACKAGES_DIR}/share/fastdelegate/FastDelegate-config.cmake" _contents)
#    string(REPLACE "\${FastDelegate_SOURCE_DIR}" "\${FastDelegate_CMAKE_DIR}/../.." _contents "${_contents}")
#    file(WRITE "${CURRENT_PACKAGES_DIR}/share/fastdelegate/FastDelegateConfig.cmake" "${_contents}\nset(FastDelegate_INCLUDE_DIRS \"\${FastDelegate_INCLUDE_DIRS}\")\n")
#    # Note: adding this extra setting for RAPIDJSON_INCLUDE_DIRS maintains compatibility with previous fastdelegate versions
#endif()
