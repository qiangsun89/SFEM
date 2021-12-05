file(GLOB sfemlibSource ${sfem_SOURCE_DIR}/src/sfemlib/*.cpp)
#set (core_temp
#        temp.cpp
#        )
#set (core
#        ${core_temp}
#        )

set (core_module
        ${sfemlibSource}
        )
set (core
        ${core_module}
        )
add_library (core
        ${LIB_TYPE}
        ${core}
        )