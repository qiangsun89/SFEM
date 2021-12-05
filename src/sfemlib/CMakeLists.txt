set (core_temp
        temp.cpp
        )
set (core
        ${core_temp}
        )
add_library (core
        ${LIB_TYPE}
        ${core}
        )