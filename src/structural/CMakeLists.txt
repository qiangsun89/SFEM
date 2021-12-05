file(GLOB structuralSource ${sfem_SOURCE_DIR}/src/structural/*.cpp)
#set (sm_temp
#        temp.cpp
#        )
#set (sm
#        ${sm_temp}
#        )
#message("structuralSource=${structuralSource}")
set (sm_module
        ${structuralSource}
        )
set (sm
        ${sm_module}
        )
add_library(sm
        ${LIB_TYPE}
        ${sm}
        )