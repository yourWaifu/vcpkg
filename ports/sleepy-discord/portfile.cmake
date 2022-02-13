vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "websocketpp"    USE_WEBSOCKETPP
        "cpr"            USE_CPR
        "voice"          ENABLE_VOICE
        "compression"    USE_ZLIB
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yourWaifu/sleepy-discord
    REF a300cfcf90b3566ef53f11ae59527d8958806cd9
    SHA512 01a2d7d70d8bfe0f2639d9bccc0a06e182414210a250b3344f1917ada8b096975652c84fab899b83dd19e475f7c00f7e6f230d242f3167eea59ddd4dc788427b
    HEAD_REF develop
)

# Handle version data here to prevent issues from doing this twice in parallel
set(SLEEPY_DISCORD_VERSION_HASH a300cfcf90b3566ef53f11ae59527d8958806cd9)
set(SLEEPY_DISCORD_VERSION_BUILD 955)
set(SLEEPY_DISCORD_VERSION_BRANCH "develop")
set(SLEEPY_DISCORD_VERSION_IS_MASTER 0)
set(SLEEPY_DISCORD_VERSION_DESCRIPTION_CONCAT " ")
set(SLEEPY_DISCORD_VERSION_DESCRIPTION "a300cfcf")
configure_file(
    "${SOURCE_PATH}/include/sleepy_discord/version.h.in"
    "${SOURCE_PATH}/include/sleepy_discord/version.h"
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS 
        -DSLEEPY_VCPKG=ON 
        -DAUTO_DOWNLOAD_LIBRARY=OFF 
        -DUSE_BOOST_ASIO=ON
        ${FEATURE_OPTIONS}
)
vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/sleepy-discord)

file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
