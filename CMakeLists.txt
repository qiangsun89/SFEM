cmake_minimum_required(VERSION 3.12 FATAL_ERROR)
include (CheckSymbolExists)
include (CheckCXXSymbolExists)
include (CheckIncludeFiles)
include (CheckIncludeFileCXX)
include (CheckCXXSourceCompiles)
include (GenerateExportHeader)
include (ProcessorCount)
# print custom message depending on the operating system
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "Configuring on/for Linux")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    message(STATUS "Configuring on/for macOS")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    message(STATUS "Configuring on/for Windows")
elseif(CMAKE_SYSTEM_NAME STREQUAL "AIX")
    message(STATUS "Configuring on/for IBM AIX")
else()
    message(STATUS "Configuring on/for ${CMAKE_SYSTEM_NAME}")
endif()
# Use ccache if available. Needs to be performed early for it to work with cmake.
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

set(USER_CONFIG "${CMAKE_CURRENT_SOURCE_DIR}/config/user.cmake" CACHE PATH
        "Path to optional user configuration file.")

project(sfem LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# CMake needs to know where to find things
set(SFEM_CMAKE_PATH ${PROJECT_SOURCE_DIR}/config)
set(CMAKE_MODULE_PATH ${SFEM_CMAKE_PATH}/cmake/modules)

# Load user settings before the defaults - this way the defaults will not
# overwrite the user set options. If the user has not set all options, we still
# have the defaults.
message(STATUS "(optional) USER_CONFIG = ${USER_CONFIG}")
include("${USER_CONFIG}" OPTIONAL)
include("${CMAKE_CURRENT_SOURCE_DIR}/config/defaults.cmake")

IF(USE_CLANG)
    add_definitions("-DUSE_CLANG")
endif(USE_CLANG)

if (USE_CLANG)
    message(STATUS "the  compiler is clang")
    SET (CMAKE_C_COMPILER             ${CMAKE_C_COMPILER_DIR})
    SET (CMAKE_C_FLAGS                "-Wall -std=c99")
    SET (CMAKE_C_FLAGS_DEBUG          "-g")
    SET (CMAKE_C_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
    SET (CMAKE_C_FLAGS_RELEASE        "-O4 -DNDEBUG")
    SET (CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g")

    SET (CMAKE_CXX_COMPILER             ${CMAKE_CXX_COMPILER_DIR})
    SET (CMAKE_CXX_FLAGS                "-Wall")
    SET (CMAKE_CXX_FLAGS_DEBUG          "-g")
    SET (CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
    SET (CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
    SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")
endif ()

#set(${PROJECT_NAME}_VERSION 1.0.0)
set (sfem_VERSION_MAJOR 1)
set (sfem_VERSION_MINOR 0)
set (sfem_VERSION_PATCH 0)
set (sfem_COPYRIGHT "Copyright (C) 2021 Qiang Sun")
set (sfem_EMAIL "sunqiang891103@gmail.com")

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

# Default is debug build
if (NOT CMAKE_BUILD_TYPE)
    set (CMAKE_BUILD_TYPE Debug)
endif ()

if (MSVC)
    add_definitions (-D_USE_MATH_DEFINES)
    set (CMAKE_REQUIRED_DEFINITIONS "-D_USE_MATH_DEFINES")
    # I'm not sure we should block these warnings or not:
    # C4800 Conversion from int to bool performance warning (we should probably be using bool in most of these places though).
    # C4127 Conditional expression is constant: Most of these uses are intentional (debugging code etc.)
    # C4267 size_t to int conversion. Most of these are indices, but many places can be replaced by a for-each loop as well.
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W4 -wd4786 -wd4100 -wd4996 -wd4706 -wd4512 -wd4251 -wd4800")
else ()
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -fPIC")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -fPIC")
endif ()

set (CMAKE_CXX_FLAGS_DEBUG "-DDEBUG ${CMAKE_CXX_FLAGS_DEBUG}")
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set (CMAKE_CXX_FLAGS_DEBUG "-O0 -Wsuggest-override ${CMAKE_CXX_FLAGS_DEBUG}")
endif()
set (CMAKE_CXX_FLAGS_PROFILING "${CMAKE_CXX_FLAGS_PROFILING} -O2 -pg")

if (USE_PARALLEL)
    add_definitions (-D__PARALLEL_MODE)
    set (USE_MPI ON)
endif ()

# Enable coverage testing
if (CMAKE_COMPILER_IS_GNUCC)
    option(ENABLE_COVERAGE "Enable coverage reporting for gcc/clang" FALSE)

    if (ENABLE_COVERAGE)
        add_compile_options(--coverage -O0)
        list (APPEND EXT_LIBS --coverage)
    endif()
endif ()

######################## Internal libraries ###########################
# I believe the subdirs should be used when including instead.
# 3rd party library
include_directories( ${Eigen_DIR} )
include_directories ("${sfem_SOURCE_DIR}/include")
include_directories ("${sfem_BINARY_DIR}")

# Is there really any reason not to compile all of them? Some has cross dependencies.
list (APPEND LIBS $<TARGET_OBJECTS:core>)

if (USE_FM)
    include_directories ("${sfem_SOURCE_DIR}/include/fluid")
    add_definitions (-D__FM_MODULE)
    list (APPEND LIBS $<TARGET_OBJECTS:fm>)
    list (APPEND MODULE_LIST "fm")
    if (USE_PFEM)
        add_definitions (-D__PFEM_MODULE)
    endif ()
endif ()

if (USE_TM)
    include_directories ("${sfem_SOURCE_DIR}/include/transport")
    add_definitions (-D__TM_MODULE)
    list (APPEND LIBS $<TARGET_OBJECTS:tm>)
    list (APPEND MODULE_LIST "tm")
    if (USE_CEMHYD)
        add_definitions (-D__CEMHYD_MODULE)
        set (USE_TINYXML ON)
    endif ()
endif ()

if (USE_SM)
    include_directories ("${sfem_SOURCE_DIR}/include/structural")
    add_definitions (-D__SM_MODULE)
    list (APPEND LIBS $<TARGET_OBJECTS:sm>)
    list (APPEND MODULE_LIST "sm")

    if (NOT MSVC AND NOT MINGW)
        find_library (DL_LIB dl)
        list (APPEND EXT_LIBS ${DL_LIB})
    endif ()
endif ()

if(USE_sfemMath)
    include_directories ("${sfem_SOURCE_DIR}/include/sfemMath/sfemBlas")
    add_definitions (-D__SFEM_MATH_MODULE)
    list (APPEND LIBS $<TARGET_OBJECTS:smath>)
    list (APPEND MODULE_LIST "smath")
endif()

if (USE_EM)
    include_directories ("${sfem_SOURCE_DIR}/include/electromagnetics")
    add_definitions (-D__EM_MODULE)
    list (APPEND LIBS $<TARGET_OBJECTS:em>)
    list (APPEND MODULE_LIST "em")

    if (NOT MSVC AND NOT MINGW)
        find_library (DL_LIB dl)
        list (APPEND EXT_LIBS ${DL_LIB})
    endif ()
endif ()

if (USE_OPENMP)
    include (FindOpenMP)
    if (OPENMP_FOUND)
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
        list (APPEND MODULE_LIST "openmp")
    endif ()
endif ()

if (USE_OOFEG)
    add_definitions (-D__OOFEG)

    # Necessary X11 stuff;
    if (X11_DIR)
        set (CMAKE_LIBRARY_DIR ${X11_DIR})
        find_package (X11 REQUIRED PATHS ${X11_DIR})
        find_library (XAW_LIB Xaw PATHS ${X11_DIR})
    else ()
        find_package (X11 REQUIRED)
        find_library (XAW_LIB Xaw)
    endif ()

    # Krysls libraries:
    find_library (ELIXIR_LIB elixir PATH "${ELIXIR_DIR}/src")
    find_library (ESI_LIB esi PATH "${ELIXIR_DIR}/src")
    if (${ELIXIR_LIB} STREQUAL "ELIXIR_LIB-NOTFOUND")
        message (FATAL_ERROR "Elixir library not found (required for OOFEG)")
    endif ()
    find_library (CKIT_LIB ckit PATH "${CKIT_DIR}/src")
    if (${CKIT_LIB} STREQUAL "CKIT_LIB-NOTFOUND")
        message (FATAL_ERROR "Ckit library not found (required for OOFEG)")
    endif ()
    include_directories ("${ELIXIR_DIR}/include")
    include_directories ("${CKIT_DIR}/include")

    list (APPEND EXT_LIBS ${ESI_LIB} ${ELIXIR_LIB} ${CKIT_LIB} ${X11_LIBRARIES} ${X11_Xmu_LIB} ${X11_Xt_LIB} ${XAW_LIB})
    list (APPEND MODULE_LIST "oofeg")
endif ()

######################## External libraries ###########################
if (USE_BOOST)
    set (CMAKE_LIBRARY_DIR ${BOOST_DIR})
    find_package (BOOST REQUIRED)
    list (APPEND EXT_LIBS ${BOOST_LIBRARIES})
    if (BOOST_DIR)
    	include_directories ("${BOOST_DIR}")
    	list (APPEND MODULE_LIST "BOOST")
     endif ()
    add_definitions (-D__BOOST_MODULE)
endif ()

if (USE_LAPACK)
    set (CMAKE_LIBRARY_DIR ${LAPACK_DIR})
    find_package (LAPACK REQUIRED)
    list (APPEND EXT_LIBS ${LAPACK_LIBRARIES})
    list (APPEND MODULE_LIST "LAPACK")
    add_definitions (-D__LAPACK_MODULE)
endif ()

if (USE_SUPERLU_MT)
    set (CMAKE_LIBRARY_DIR ${SUPERLU_MT_DIR})
    #find_package (SuperLU REQUIRED)
    find_package(BLAS REQUIRED)
    find_library (SUPERLU_MT_LIB superlu_mt_OPENMP PATH "${SUPERLU_MT_DIR}/lib")
    list (APPEND EXT_LIBS ${SUPERLU_MT_LIB} ${BLAS_LIBRARIES})
    #set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BLAS_LINKER_FLAGS}")
    list (APPEND MODULE_LIST "SuperLU_MT")
    include_directories("${SUPERLU_MT_DIR}")
    set (CMAKE_REQUIRED_INCLUDES "${SUPERLU_MT_DIR}")
    add_definitions (-D__SuperLU_MT_MODULE)
    check_include_file_cxx ("${SUPERLU_MT_DIR}/include/slu_mt_ddefs.h" HAVE_SUPERLU_MT_DDEFS_H)
    if (NOT HAVE_SUPERLU_MT_DDEFS_H)
        message (FATAL_ERROR "Necessary SUPERLU_MT headers not found; refer to CMakeLists.txt for details")
    endif ()
endif ()

if (USE_VTK)
    set (CMAKE_LIBRARY_DIR ${VTK_DIR})
    find_package (VTK REQUIRED NO_MODULE)
    include (${VTK_USE_FILE}) # Sets necessary includes_directories
    add_definitions (-D__VTK_MODULE)
    list (APPEND EXT_LIBS ${VTK_LIBRARIES})
    list (APPEND MODULE_LIST "VTK")
endif ()

if (USE_PARMETIS)
    if (PARMETIS_DIR)
        find_library (PARMETIS_LIB parmetis PATH "${PARMETIS_DIR}/lib")
        include_directories ("${PARMETIS_DIR}/include")
    else ()
        find_library (PARMETIS_LIB parmetis)
    endif ()
    if (${PARMETIS_LIB} STREQUAL "PARMETIS_LIB-NOTFOUND")
        message (FATAL_ERROR "Parmetis library not found")
    endif ()
    list (APPEND EXT_LIBS ${PARMETIS_LIB})
    list (APPEND MODULE_LIST "parmetis")
    set (USE_MPI ON)
    set (USE_METIS ON)
endif ()

if (USE_METIS)
    if (METIS_DIR)
        find_library (METIS_LIB metis PATH "${METIS_DIR}/lib")
        include_directories ("${METIS_DIR}/include")
    else ()
        find_library (METIS_LIB metis)
    endif ()
    if (${METIS_LIB} STREQUAL "METIS_LIB-NOTFOUND")
        message (FATAL_ERROR "Metis library not found")
    endif ()
    list (APPEND EXT_LIBS ${METIS_LIB})
    list (APPEND MODULE_LIST "metis")
endif ()

if (USE_PARDISO_ORG)
    if (PARDISO_ORG_DIR)
        find_library (PARDISO_ORG_LIB pardiso PATH "${PARDISO_ORG_DIR}")
    else ()
        find_library (PARDISO_ORG_LIB pardiso)
    endif ()
    if (${PARDISO_ORG_LIB} STREQUAL "PARDISO_ORG_LIB-NOTFOUND")
        message (FATAL_ERROR "Pardiso library not found")
    endif ()
    list (APPEND EXT_LIBS ${PARDISO_ORG_LIB} blas lapack gfortran pthread)
    set (CMAKE_CXX_COMPILE_FLAGS "${CMAKE_CXX_COMPILES_FLAGS} -fopenmp")
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fopenmp" )
    list (APPEND MODULE_LIST "pardiso-project.org")
endif ()

if (USE_INTEL_MKL_PARDISO)
    # Find the actual libraries:
    list(APPEND MKL_LIBS "mkl_core" "mkl_gf_lp64" "mkl_gnu_thread" "pthread")
    foreach (f ${MKL_LIBS})
        if (INTEL_MKL_PARDISO_DIR)
            find_library (${f}_LIB ${f} PATH "${INTEL_MKL_PARDISO_DIR}/mkl/lib/intel64/" DOC "MKLPARDISO (library)")
            include_directories ("${INTEL_MKL_PARDISO_DIR}/mkl/include")
        else ()
            find_library (${f}_LIB ${f} HINTS "/opt/intel/composerxe/mkl/lib/intel64/" DOC "MKLPARDISO (library)")
            include_directories ("/opt/intel/composerxe/mkl/include")
        endif ()
        if (${${f}_LIB} STREQUAL "${f}_LIB-NOTFOUND")
            message (FATAL_ERROR "MKLPARDISO library not found")
        endif ()
        list (APPEND EXT_LIBS ${${f}_LIB})
    endforeach ()
    #list (APPEND EXT_LIBS ${MKLPARDISO_LIB})
    list (APPEND MODULE_LIST "MKLPARDISO")
endif ()


if (USE_SLEPC)
    set (USE_PETSC ON)
endif ()


if (USE_PETSC)
    if (NOT "${PETSC_DIR}")
        # setting defaults for typical linux environments:
        #file (GLOB paths "/usr/lib/petscdir/*.*.*")
        #list (GET paths 0 PETSC_DIR)
        #message ("***************** PETSC_DIR: ${PETSC_DIR}")
    endif ()
    if (NOT "${PETSC_ARCH}")
        #file (GLOB children RELATIVE ${PETSC_DIR} "${PETSC_DIR}/*")
        #list (GET children 0 PETSC_ARCH)
        #message ("***************** PETSC_ARCH: ${PETSC_ARCH}")
    endif ()
    find_package (PETSc)
    # find_package(PETSc COMPONENTS CXX)
    include_directories (${PETSC_INCLUDES})
    list (APPEND EXT_LIBS ${PETSC_LIBRARIES})
    list (APPEND MODULE_LIST "PETSc")
    set (USE_MPI ON)
    add_definitions (-D__PETSC_MODULE)
endif ()

if (USE_SLEPC)
    if (SLEPC_DIR)
        find_library (SLEPC_LIBS slepc PATH "${SLEPC_DIR}/${PETSC_ARCH}/lib")
        include_directories ("${SLEPC_DIR}/include")
        include_directories ("${SLEPC_DIR}/${PETSC_ARCH}/include")
    else ()
        find_library (SLEPC_LIBS slepc)
    endif ()
    if (${SLEPC_LIBS} STREQUAL "SLEPC_LIBS-NOTFOUND")
        message (FATAL_ERROR "SLEPc library not found")
    endif ()
    list (APPEND EXT_LIBS ${SLEPC_LIBS})
    list (APPEND MODULE_LIST "slepc")
    set (USE_PETSC ON)
    add_definitions (-D__SLEPC_MODULE)
endif ()


if (USE_MPI)
    if (MPI_DIR)
        include_directories ("${MPI_DIR}/include")
        find_library (MPI_LIBRARY NAMES mpi PATHS ${MPI_DIR}/lib64 ${MPI_DIR}/lib)
        find_library (MPI_CXX_LIBRARY NAMES mpi_cxx PATHS ${MPI_DIR}/lib64 ${MPI_DIR}/lib)
        list (APPEND EXT_LIBS ${MPI_LIBRARY})
        if (MPI_CXX_LIBRARY)
            list (APPEND EXT_LIBS ${MPI_CXX_LIBRARY})
        endif ()
    else ()
        include (FindMPI)
        find_package (MPI REQUIRED)
        set (CMAKE_CXX_COMPILE_FLAGS ${CMAKE_CXX_COMPILES_FLAGS} ${MPI_COMPILE_FLAGS})
        set (CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} ${MPI_LINK_FLAGS})
        add_definitions (-DMPICH_IGNORE_CXX_SEEK)
        include_directories (${MPI_INCLUDE_PATH})
        list (APPEND EXT_LIBS ${MPI_LIBRARIES})
    endif (MPI_DIR)
    list (APPEND MODULE_LIST "MPI")
    # Compile and link flags?
endif ()

if (USE_T3D)
    add_definitions (-D__T3D)
    include_directories ("${oofem_SOURCE_DIR}/src/oofemlib/T3d/src")
    check_include_file_cxx ("${oofem_SOURCE_DIR}/src/oofemlib/T3d/src/t3d.h" HAVE_T3D_H)
    if ((NOT HAVE_T3D_H))
        message (FATAL_ERROR "Necessary T3D headers not found")
    endif ()
    set (MODULE_LIST ${MODULE_LIST} "T3D")
    add_definitions(-DT3D_OOFEM)
endif ()

if (USE_TRIANGLE)
    find_library (TRIANGLE_LIB triangle DOC "Triangle (library)")
    if (${TRIANGLE_LIB} STREQUAL "TRIANGLE_LIB-NOTFOUND")
        message (FATAL_ERROR "Triangle library not found")
    endif ()
    add_definitions (-D__TRIANGLE_MODULE)
    list (APPEND EXT_LIBS ${TRIANGLE_LIB})
    list (APPEND MODULE_LIST "Triangle")
endif ()

if (USE_HDF5)
    find_package(HDF5 REQUIRED "CXX")
    include_directories(${HDF5_INCLUDE_DIRS})
    list (APPEND EXT_LIBS ${HDF5_LIBRARIES} ${HDF5_HL_LIBRARIES})
endif ()

if (USE_TINYXML)
    if (TINYXML2_DIR)
        include_directories (${TINYXML2_DIR})
        find_library (TINYXML2_LIB NAMES tinyxml2 HINTS ${TINYXML2_DIR} NO_DEFAULT_PATH)
    else ()
        find_library (TINYXML2_LIB NAMES tinyxml2 )
    endif ()
    if (${TINYXML2_LIB} STREQUAL "TINYXML2_LIB-NOTFOUND")
        message (FATAL_ERROR "TinyXML2 library not found")
    endif ()
    list (APPEND EXT_LIBS ${TINYXML2_LIB})
    list (APPEND MODULE_LIST "TinyXML-2")
endif ()

if (USE_IML)
    include_directories ("${oofem_SOURCE_DIR}")
    set (CMAKE_REQUIRED_INCLUDES "${oofem_SOURCE_DIR}")
    check_include_file_cxx ("iml/cg.h" HAVE_IML_CG_H)
    check_include_file_cxx ("iml/gmres.h" HAVE_IML_GMRES_H)
    if ((NOT HAVE_IML_CG_H) OR (NOT HAVE_IML_GMRES_H))
        message (FATAL_ERROR "Necessary IML++ headers not found")
    endif ()
    list (APPEND MODULE_LIST "IML++")
endif ()

if (USE_SPOOLES)
    if (SPOOLES_DIR)
        find_library (SPOOLES_LIB spooles DOC "SPOOLES library" PATH "${SPOOLES_DIR}/lib")
        include_directories ("${SPOOLES_DIR}/include")
    else ()
        find_library (SPOOLES_LIB spooles DOC "SPOOLES library")
    endif ()
    if (${SPOOLES_LIB} STREQUAL "SPOOLES_LIB-NOTFOUND")
        message (FATAL_ERROR "SPOOLES not found")
    endif ()
    list (APPEND EXT_LIBS ${SPOOLES_LIB})
    list (APPEND MODULE_LIST "SPOOLES")
endif ()

if (USE_PYTHON_EXTENSION OR USE_BOOSTPYTHON_BINDINGS)
    # PythonLibs in cmake is bugged, have to try and rely on PythonInterp to get the suitable major and minor versions.
    #set (CMAKE_LIBRARY_DIR ${PYTHON_DIR})
    #Print if set up manually
    message(STATUS "PYTHON_LIBRARY = ${Python_LIBRARIES}")
    message(STATUS "PYTHON_EXECUTABLE = ${Python_EXECUTABLE}")
    message(STATUS "PYTHON_INCLUDE_DIR = ${Python_INCLUDE_DIR}")
    find_package(PythonInterp "3" REQUIRED)
    find_package(PythonLibs "${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}" REQUIRED)
    include_directories (${Python_INCLUDE_DIRS})
    list (APPEND EXT_LIBS ${Python_LIBRARIES})
    list (APPEND MODULE_LIST "Python")
    if(USE_PYTHON_EXTENSION)
        add_definitions(-D_PYTHON_EXTENSION)
    endif ()

    if(USE_BOOSTPYTHON_BINDINGS)
        # require boost_python also for python stuff by itself
        find_package(Boost COMPONENTS "python-py${Python_VERSION_MAJOR}${Python_VERSION_MINOR}" REQUIRED)
        include_directories (${Boost_INCLUDE_DIRS})
        list (APPEND EXT_LIBS ${Boost_LIBRARIES})
        add_definitions(-D_BOOSTPYTHON_BINDINGS)
    endif ()
endif ()


if(WIN32)
    set(PYTHON_MODULE_EXTENSION ".pyd")
else()
    set(PYTHON_MODULE_EXTENSION ".so")
endif()


if (USE_PYBIND_BINDINGS)
    #build pybind11 bindings
    find_package(Python COMPONENTS Interpreter Development)
    #find_package(pybind11 CONFIG)
    add_git_submodule(extern/pybind11)
    if (PYBIND_DIR)
        message(STATUS "PYBIND_DIR = ${PYBIND_DIR}")
        include_directories (${PYBIND_DIR})#Need also to manually set it up since it can be anywhere
    endif ()
    include_directories (${pybind11_INCLUDE_DIR} ${Python_INCLUDE_DIRS})
    list (APPEND EXT_LIBS ${Python_LIBRARIES})
    pybind11_add_module(sfempy THIN_LTO ${sfem_SOURCE_DIR}/bindings/python/SFEM.cpp ${PYBIND11_HEADERS})
    target_link_libraries(sfempy PRIVATE libsfem)
    set_target_properties (sfempy PROPERTIES SUFFIX "${PYTHON_MODULE_EXTENSION}")

    # Make sure pytest is found or produce a fatal error
    if(NOT PYTEST_FOUND)
        execute_process(COMMAND ${Python_EXECUTABLE} -c "import pytest; print(pytest.__version__)"
                RESULT_VARIABLE pytest_not_found OUTPUT_VARIABLE pytest_version ERROR_QUIET)
        if(pytest_not_found)
            message(FATAL_ERROR "Running the tests requires pytest. Please install it manually"
                    " (try: ${Python_EXECUTABLE} -m pip install pytest)")
        endif()
        set(PYBIND11_PYTEST_FOUND TRUE CACHE INTERNAL "")
        add_definitions(-D_PYBIND_BINDINGS)
    endif()
    set (USE_SHARED_LIB ON)
endif()

######################## Configuration ################################
site_name (HOST_NAME)
set (HOST_TYPE "${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}") # This should be renamed TARGET_TYPE.
set (BUILDNAME "SFEM(${MODULE_LIST})-${HOST_TYPE}-${HOST_NAME}")
string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%d %H:%M:%S")
message("Build timestamp is ${BUILD_TIMESTAMP}")
check_include_file_cxx ("execinfo.h" HAVE_EXECINFO_H)
check_cxx_symbol_exists ("cbrt" "cmath" HAVE_CBRT)
check_cxx_symbol_exists ("isnan" "cmath" HAVE_ISNAN)
if (USE_SHARED_LIB)
    set (SFEM_EXPORT_HEADER "#include \"sfem_export.h\"")
    # For consistant library on linux and windows platforms.
    #add_compiler_export_flags (LIBSFEM_EXPORT_CFLAGS)
else ()
    set (SFEM_EXPORT_HEADER "#define SFEM_EXPORT\n#define SFEM_NO_EXPORT")
endif ()
configure_file (
        "${sfem_SOURCE_DIR}/src/sfemcfg.h.in"
        "${sfem_BINARY_DIR}/sfemcfg.h"
)


######################## Targets ######################################
# Subtargets
set (LIB_TYPE OBJECT)
add_subdirectory ("${sfem_SOURCE_DIR}/src/sfemlib")
#if (USE_DSS)
#    add_subdirectory ("${sfem_SOURCE_DIR}/src/dss")
#endif ()
if (USE_SM)
    add_subdirectory ("${sfem_SOURCE_DIR}/src/structural")
endif ()
if (USE_TM)
    add_subdirectory ("${sfem_SOURCE_DIR}/src/transport")
endif ()
if (USE_FM)
    add_subdirectory ("${sfem_SOURCE_DIR}/src/fluid")
endif ()
if (USE_EM)
    add_subdirectory ("${sfem_SOURCE_DIR}/src/electromagnetics")
endif ()
if (USE_sfemMath)
    add_subdirectory ("${sfem_SOURCE_DIR}/src/sfemMath/sfemBlas")
endif ()
set (sfempy)
if (USE_BOOSTPYTHON_BINDINGS)
    set (sfempy ${sfem_SOURCE_DIR}/bindings/Deprecated/python/sfemlib.cpp)
endif ()

# Main targets
if (USE_SHARED_LIB)
    add_library (libsfem
            SHARED
            ${sfempy}
            ${LIBS}
            )
    target_link_libraries (libsfem ${EXT_LIBS})
    set_target_properties (libsfem PROPERTIES OUTPUT_NAME sfem)
    if (NOT "${LIBSFEM_EXPORT_CFLAGS}" STREQUAL "")
        set_target_properties (libsfem PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
    endif ()
    install (TARGETS libsfem DESTINATION lib)

    # This should be set automatically, but I think TARGET:objs confuses cmake:
    set_target_properties (core PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
    if (USE_FM)
        set_target_properties (fm PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
        if (NOT "${LIBSFEM_EXPORT_CFLAGS}" STREQUAL "")
            set_target_properties (fm PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
        endif ()
    endif()
    if (USE_SM)
        set_target_properties (sm PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
        if (NOT "${LIBSFEM_EXPORT_CFLAGS}" STREQUAL "")
            set_target_properties (sm PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
        endif ()
    endif()
    if (USE_TM)
        set_target_properties (tm PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
        if (NOT "${LIBOOFEM_EXPORT_CFLAGS}" STREQUAL "")
            set_target_properties (tm PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
        endif ()
    endif()

    if (USE_EM)
        set_target_properties (em PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
        if (NOT "${LIBOOFEM_EXPORT_CFLAGS}" STREQUAL "")
            set_target_properties (em PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
        endif ()
    endif()

    if (USE_sfemMath)
        set_target_properties (smath PROPERTIES COMPILE_DEFINITIONS "libsfem_EXPORTS")
        if (NOT "${LIBOOFEM_EXPORT_CFLAGS}" STREQUAL "")
            set_target_properties (smath PROPERTIES COMPILE_FLAGS ${LIBSFEM_EXPORT_CFLAGS})
        endif ()
    endif ()

    generate_export_header (libsfem
            BASE_NAME SFEM
            )
endif ()

# SFEM target
if (USE_SHARED_LIB) # Prefer dynamic lib if available.
    add_executable (sfem ${sfem_SOURCE_DIR}/src/main/SFEM.cpp)
    target_link_libraries (sfem libsfem)
else ()
    add_executable (sfem ${sfem_SOURCE_DIR}/src/main/SFEM.cpp ${LIBS})
    target_link_libraries (sfem ${EXT_LIBS})
endif ()

# let the preprocessor know about the system name
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    target_compile_definitions(sfem PUBLIC "IS_LINUX")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    target_compile_definitions(sfem PUBLIC "IS_MACOS")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_compile_definitions(sfem PUBLIC "IS_WINDOWS")
endif()
# let the preprocessor know about the compiler vendor
if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
    target_compile_definitions(sfem PUBLIC "IS_INTEL_CXX_COMPILER")
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    target_compile_definitions(sfem PUBLIC "IS_GNU_CXX_COMPILER")
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES PGI)
    target_compile_definitions(sfem PUBLIC "IS_PGI_CXX_COMPILER")
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES XL)
    target_compile_definitions(sfem PUBLIC "IS_XL_CXX_COMPILER")
endif()
# let the preprocessor know about the size of void *
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    target_compile_definitions(sfem PUBLIC "IS_64_BIT_ARCH")
    message(STATUS "Target is 64 bits")
else()
    target_compile_definitions(sfem PUBLIC "IS_32_BIT_ARCH")
    message(STATUS "Target is 32 bits")
endif()

# let the preprocessor know about the host processor architecture
if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "i386")
    message(STATUS "i386 architecture detected")
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "i686")
    message(STATUS "i686 architecture detected")
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "x86_64")
    message(STATUS "x86_64 architecture detected")
else()
    message(STATUS "host processor architecture is unknown")
endif()

target_compile_definitions(sfem
        PUBLIC "ARCHITECTURE=${CMAKE_HOST_SYSTEM_PROCESSOR}"
        )

install (TARGETS sfem DESTINATION bin)

# CppCheck target (not built by default)
add_custom_target(cppcheck)
set_target_properties(cppcheck PROPERTIES EXCLUDE_FROM_ALL TRUE)
add_custom_command(TARGET cppcheck
        COMMAND cppcheck "--xml" "--template=gcc" "--enable=all"
        "-I${sfem_BINARY_DIR}/"
        "-I${sfem_SOURCE_DIR}/src/sfemlib/"
        "-I${sfem_SOURCE_DIR}/src/sm/"
        "-I${sfem_SOURCE_DIR}/src/fm/"
        "-I${sfem_SOURCE_DIR}/src/tm/"
        "-DDEBUG"
        ${sfem_SOURCE_DIR}/src/sfemlib/
        ${sfem_SOURCE_DIR}/src/sm/
        ${sfem_SOURCE_DIR}/src/fm/
        ${sfem_SOURCE_DIR}/src/tm/
        ${sfem_SOURCE_DIR}/src/main/
        "2>"
        "cppcheck.xml"
        COMMENT "Running cppcheck on entire source"
        )

######################## Documentation ################################
find_package (Doxygen)
if (DOXYGEN_FOUND)
    set (DOXYGEN_INPUT ${sfem_BINARY_DIR}/doxygen.cfg)
    set (DOXYGEN_OUTPUT ${sfem_BINARY_DIR}/docs/api/)
    file (MAKE_DIRECTORY ${DOXYGEN_OUTPUT})

    configure_file (
            "${sfem_SOURCE_DIR}/docs/refman/footer.html.in"
            "${sfem_BINARY_DIR}/footer.html")
    configure_file (
            "${sfem_SOURCE_DIR}/docs/refman/doxygen.cfg.in"
            "${sfem_BINARY_DIR}/doxygen.cfg")

    add_custom_target (
            doc
            COMMAND ${CMAKE_COMMAND} -E echo_append "Building API Documentation..."
            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
            COMMAND ${CMAKE_COMMAND} -E echo "Done."
            WORKING_DIRECTORY ${sfem_BINARY_DIR}
            DEPENDS)

endif (DOXYGEN_FOUND)


configure_file (
        "${sfem_SOURCE_DIR}/docs/include.tex.in"
        "${sfem_BINARY_DIR}")

add_custom_target (
        elementlibmanual
        COMMAND pdflatex elementlibmanual --output=${sfem_BINARY_DIR}/docs/
        COMMAND pdflatex elementlibmanual --output=${sfem_BINARY_DIR}/docs/
        WORKING_DIRECTORY ${sfem_SOURCE_DIR}/docs/elementlibmanual/
)

######################## Packing ######################################
### versions
set (CPACK_PACKAGE_VERSION_MAJOR ${sfem_VERSION_MAJOR})
set (CPACK_PACKAGE_VERSION_MINOR ${sfem_VERSION_MINOR})
set (CPACK_PACKAGE_VERSION_PATCH ${sfem_VERSION_PATCH})
set (CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}")

### general settings
set (CPACK_PACKAGE_NAME "sfem")
set (CPACK_PACKAGE_VENDOR "SFEM development team")
set (CPACK_PACKAGE_DESCRIPTION_SUMMARY "Object Oriented Finite Element")
#set (CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/README")
set (CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README")
set (CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/COPYING.LGPLv2.1")
set (CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
set (CPACK_PACKAGE_EXECUTABLES "sfem")
set (CPACK_PACKAGE_FILE_NAME ${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}_${CMAKE_SYSTEM_PROCESSOR})

### default generators
if (WIN32)
    set(CPACK_GENERATOR "ZIP")
else ()
    set (CPACK_GENERATOR "TGZ;DEB")
endif ()

### source package (type "make source_package" to produce a zip)
set (CPACK_SOURCE_GENERATOR "ZIP")
set (CPACK_SOURCE_PACKAGE_FILE_NAME "sfem-${CPACK_PACKAGE_VERSION}")
set (CPACK_SOURCE_IGNORE_FILES "~$;/build/;tags;cscope.*;.*\\\\.out$;\\\\.out\\\\.;/\\\\..*;\\\\.kdev4$;do_release;release_filter\\\\.pl") # Note: All hidden files are ignored

### deb package options
set (CPACK_DEBIAN_PACKAGE_MAINTAINER "Mikael Öhman <micketeer@gmail.com>")
set (CPACK_DEBIAN_PACKAGE_SECTION "Mathematics")
# autogenerate dependency information
set (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)

set(CPACK_DEBIAN_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION}.${CPACK_PACKAGE_VERSION_PATCH}+sid1")

include (CPack)