file(GLOB fluidSource ${sfem_SOURCE_DIR}/src/fluid/*.cpp)
#set (fm_temp
#        temp.cpp
#        )
set (fm_module
        ${fluidSource}
        )
set (fm
        ${fm_module}
        )
add_library (fm
        ${LIB_TYPE}
        ${fm}
        )