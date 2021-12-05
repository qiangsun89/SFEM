set (fm_temp
        temp.cpp
        )
set (fm
        ${fm_temp}
        )
add_library (fm
        ${LIB_TYPE}
        ${fm}
        )