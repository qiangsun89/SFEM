file(GLOB igaSource ${sfem_SOURCE_DIR}/src/iga/*.cpp)

set (iga_module
        ${igaSource}
        )
set (iga
        ${iga_module}
        )
add_library(iga
        ${LIB_TYPE}
        ${iga}
        )