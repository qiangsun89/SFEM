set (tm_temp
        temp.cpp
        )
set (tm
        ${tm_temp}
        )
add_library (tm
        ${LIB_TYPE}
        ${tm}
        )