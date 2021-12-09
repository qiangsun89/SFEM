file(GLOB eletroSource ${sfem_SOURCE_DIR}/src/electromagnetics/*.cpp)
#set (fm_temp
#        temp.cpp
#        )
set (em_module
        ${eletroSource}
        )
set (em
        ${em_module}
        )
add_library (em
        ${LIB_TYPE}
        ${em}
        )