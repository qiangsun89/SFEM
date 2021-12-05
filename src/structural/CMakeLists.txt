set (sm_temp
        temp.cpp
        )
set (sm
        ${sm_temp}
        )
add_library(sm
        ${LIB_TYPE}
        ${sm}
        )