file(GLOB blasSource ${sfem_SOURCE_DIR}/src/sfemMath/sfemBlas/*.cpp)
#set(sfemBlas
#        blas0.cpp
#        blas1_d.cpp)
set(sfemBlas
        ${blasSource})

set(smath
        ${sfemBlas})

add_library (smath
        ${LIB_TYPE}
        ${smath}
        )