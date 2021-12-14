# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BUILD_SOURCE_DIRS "/home/qiang/software/SFEM;/home/qiang/software/SFEM/cmake-build-debug")
set(CPACK_CMAKE_GENERATOR "Unix Makefiles")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Mikael Öhman <micketeer@gmail.com>")
set(CPACK_DEBIAN_PACKAGE_SECTION "Mathematics")
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS "ON")
set(CPACK_DEBIAN_PACKAGE_VERSION "1.0.0+sid1")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "/home/qiang/software/clion-2020.3.4/bin/cmake/linux/share/cmake-3.17/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "sfem built using CMake")
set(CPACK_GENERATOR "TGZ;DEB")
set(CPACK_INSTALL_CMAKE_PROJECTS "/home/qiang/software/SFEM/cmake-build-debug;sfem;ALL;/")
set(CPACK_INSTALL_PREFIX "/usr/local")
set(CPACK_MODULE_PATH "/home/qiang/software/SFEM/config/cmake/modules;/home/qiang/software/SFEM/cmake/modules/")
set(CPACK_NSIS_DISPLAY_NAME "sfem")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
set(CPACK_NSIS_PACKAGE_NAME "sfem")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OUTPUT_CONFIG_FILE "/home/qiang/software/SFEM/cmake-build-debug/CPackConfig.cmake")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "/home/qiang/software/clion-2020.3.4/bin/cmake/linux/share/cmake-3.17/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Object Oriented Finite Element")
set(CPACK_PACKAGE_EXECUTABLES "sfem")
set(CPACK_PACKAGE_FILE_NAME "sfem_1.0_x86_64")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "sfem")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "sfem")
set(CPACK_PACKAGE_NAME "sfem")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "SFEM development team")
set(CPACK_PACKAGE_VERSION "1.0")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_RESOURCE_FILE_LICENSE "/home/qiang/software/SFEM/COPYING.LGPLv2.1")
set(CPACK_RESOURCE_FILE_README "/home/qiang/software/SFEM/README")
set(CPACK_RESOURCE_FILE_WELCOME "/home/qiang/software/clion-2020.3.4/bin/cmake/linux/share/cmake-3.17/Templates/CPack.GenericWelcome.txt")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_GENERATOR "ZIP")
set(CPACK_SOURCE_IGNORE_FILES "~$;/build/;tags;cscope.*;.*\\.out$;\\.out\\.;/\\..*;\\.kdev4$;do_release;release_filter\\.pl")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "/home/qiang/software/SFEM/cmake-build-debug/CPackSourceConfig.cmake")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "sfem-1.0")
set(CPACK_SYSTEM_NAME "Linux")
set(CPACK_TOPLEVEL_TAG "Linux")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "/home/qiang/software/SFEM/cmake-build-debug/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
