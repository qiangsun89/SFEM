
# SFEM options. Set to mimic the default "defaults.mk" file.
option(SFEM_USE_MPI "Enable MPI parallel build" OFF)
option(SFEM_USE_METIS "Enable METIS usage" ${SFEM_USE_MPI})
option(SFEM_USE_EXCEPTIONS "Enable the use of exceptions" OFF)
option(SFEM_USE_ZLIB "Enable zlib for compressed data streams." OFF)
option(SFEM_USE_LIBUNWIND "Enable backtrace for errors." OFF)
option(SFEM_USE_LAPACK "Enable LAPACK usage" OFF)
option(SFEM_THREAD_SAFE "Enable thread safety" OFF)
option(SFEM_USE_OPENMP "Enable the OpenMP backend" OFF)
option(SFEM_USE_LEGACY_OPENMP "Enable legacy OpenMP usage" OFF)
option(SFEM_USE_MEMALLOC "Enable the internal MEMALLOC option." ON)
option(SFEM_USE_SUNDIALS "Enable SUNDIALS usage" OFF)
option(SFEM_USE_MESQUITE "Enable MESQUITE usage" OFF)
option(SFEM_USE_SUITESPARSE "Enable SuiteSparse usage" OFF)
option(SFEM_USE_SUPERLU "Enable SuperLU_DIST usage" OFF)
option(SFEM_USE_SUPERLU5 "Use the old SuperLU_DIST 5.1 version" OFF)
option(SFEM_USE_MUMPS "Enable MUMPS usage" OFF)
option(SFEM_USE_STRUMPACK "Enable STRUMPACK usage" OFF)
option(SFEM_USE_GINKGO "Enable Ginkgo usage" OFF)
option(SFEM_USE_AMGX "Enable AmgX usage" OFF)
option(SFEM_USE_GNUTLS "Enable GNUTLS usage" OFF)
option(SFEM_USE_GSLIB "Enable GSLIB usage" OFF)
option(SFEM_USE_NETCDF "Enable NETCDF usage" OFF)
option(SFEM_USE_PETSC "Enable PETSc support." OFF)
option(SFEM_USE_SLEPC "Enable SLEPc support." OFF)
option(SFEM_USE_MPFR "Enable MPFR usage." OFF)
option(SFEM_USE_SIDRE "Enable Axom/Sidre usage" OFF)
option(SFEM_USE_FMS "Enable FMS usage" OFF)
option(SFEM_USE_CONDUIT "Enable Conduit usage" OFF)
option(SFEM_USE_PUMI "Enable PUMI" OFF)
option(SFEM_USE_HIOP "Enable HiOp" OFF)
option(SFEM_USE_CUDA "Enable CUDA" OFF)
option(SFEM_USE_OCCA "Enable OCCA" OFF)
option(SFEM_USE_RAJA "Enable RAJA" OFF)
option(SFEM_USE_CEED "Enable CEED" OFF)
option(SFEM_USE_UMPIRE "Enable Umpire" OFF)
option(SFEM_USE_SIMD "Enable use of SIMD intrinsics" OFF)
option(SFEM_USE_ADIOS2 "Enable ADIOS2" OFF)
option(SFEM_USE_CALIPER "Enable Caliper support" OFF)
option(SFEM_USE_MKL_CPARDISO "Enable MKL CPardiso" OFF)
option(SFEM_USE_BENCHMARK "Enable Google Benchmark" OFF)
option(SFEM_USE_PARELAG "Enable ParELAG" OFF)

######################## Options ######################################
#######################################################################
option (USE_OOFEG "Enable OOFEG" OFF)
option (USE_SHARED_LIB "Build shared library" ON)
option (USE_MFRONT "Build shared library" OFF)

# Parallel stuff
option (USE_PARALLEL "Enable parallel support" OFF)
option (USE_METIS "Enable metis support" OFF)
option (USE_PARMETIS "Enable Parmetis support" OFF)
option (USE_OPENMP "Compile with OpenMP support (for parallel assembly)" OFF)
# Solvers and such
option (USE_DSS "Enable DSS module" OFF) # No reason to use this
option (USE_IML "Enable iml++ solvers" OFF) # or this
option (USE_SPOOLES "Enable SPOOLES-solver" OFF) # or this
option (USE_INTEL_MKLPARDISO "Enable MKLPARDISO solver support" OFF)
option (USE_PARDISO_ORG "Enable PARDISO-project.org solver support" OFF)
option (USE_PETSC "Enable PETSc support (specify PETSC_DIR and/or PETSC_ARCH if needed)" OFF)
option (USE_SLEPC "Enable SLEPc support" OFF)
option (USE_LAPACK "Use LAPACK" OFF)
option (USE_SUPERLU_MT "Use SUPERLU_MT" OFF)
# Other external libraries
option (USE_TRIANGLE "Compile with Triangle bindings" OFF)
option (USE_VTK "Enable VTK (for exporting binary VTU-files)" OFF)
#option (USE_CGAL "CGAL" OFF)
# Internal modules
option (USE_SM "Enable structural mechanics module" ON)
option (USE_EM "Enable electromagnetics module" ON)
option (USE_FM "Enable fluid mechanics module" ON)
option (USE_PFEM "Enable PFEM module" OFF)
option (USE_TM "Enable heat/mass transfer module" ON)
option (USE_CEMHYD "Enable CemHyd support" OFF)
option (USE_T3D "Enable T3D support" OFF)
option (USE_BOOSTPYTHON_BINDINGS "Rather obsolete, use USE_PYBIND_BINDINGS. Enable Python bidings using boost (OOFEM callable from Python)." OFF)
option (USE_PYBIND_BINDINGS "Enable Python Pybind11 bindings (OOFEM callable from Python and vice versa)." OFF)
option (USE_PYTHON_EXTENSION "Enable Python extension for exposing C++ code to python. Uses Python.h library." OFF)
option (USE_HDF5 "HDF5 support" OFF)
# use sfem math library
option (USE_sfemMath "Enable sfemMath usage" ON)
#option (USE_sfemMath "Enable sfemMath usage" OFF)
# add clang definition.
OPTION(USE_CLANG "use clang building the project" ON)
option (USE_IGA "Enable isogeometric analysis usage" ON)
# Optional overrides for autodetected MPIEXEC and MPIEXEC_NUMPROC_FLAG
# set(SFEM_MPIEXEC "mpirun" CACHE STRING "Command for running MPI tests")
# set(SFEM_MPIEXEC_NP "-np" CACHE STRING
#     "Flag for setting the number of MPI tasks")

set(SFEM_MPI_NP 4 CACHE STRING "Number of processes used for MPI tests")

# Allow a user to disable testing, examples, and/or miniapps at CONFIGURE TIME
# if they don't want/need them (e.g. if SFEM is "just a dependency" and all they
# need is the library, building all that stuff adds unnecessary overhead). Note
# that the examples or miniapps can always be built using the targets 'examples'
# or 'miniapps', respectively.
option(SFEM_ENABLE_TESTING "Enable the ctest framework for testing" ON)
option(SFEM_ENABLE_EXAMPLES "Build all of the examples" OFF)
option(SFEM_ENABLE_MINIAPPS "Build all of the miniapps" OFF)
option(SFEM_ENABLE_GOOGLE_BENCHMARKS "Build all of the Google benchmarks" OFF)

# Setting CXX/MPICXX on the command line or in user.cmake will overwrite the
# autodetected C++ compiler.
# set(CXX g++)
# set(MPICXX mpicxx)

set(CMAKE_C_COMPILER_DIR "/usr/local/bin/clang" CACHE PATH "Path to CMAKE_C_COMPILER_DIR")
set(CMAKE_CXX_COMPILER_DIR "/usr/local/bin/clang++" CACHE PATH "Path to CMAKE_CXX_COMPILER_DIR")

# Set the target CUDA architecture
set(CUDA_ARCH "sm_60" CACHE STRING "Target CUDA architecture.")

# Set the target HIP architecture
set(HIP_ARCH "gfx900" CACHE STRING "Target HIP architecture.")

set(SFEM_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# The *_DIR paths below will be the first place searched for the corresponding
# headers and library. If these fail, then standard cmake search is performed.
# Note: if the variables are already in the cache, they are not overwritten.

set(HYPRE_DIR "${SFEM_DIR}/../hypre/src/hypre" CACHE PATH
    "Path to the hypre library.")
# If hypre was compiled to depend on BLAS and LAPACK:
# set(HYPRE_REQUIRED_PACKAGES "BLAS" "LAPACK" CACHE STRING
#     "Packages that HYPRE depends on.")
if (SFEM_USE_CUDA)
   # This is only necessary when hypre is built with cuda:
   set(HYPRE_REQUIRED_LIBRARIES "-lcusparse" "-lcurand" CACHE STRING
       "Libraries that HYPRE depends on.")
endif()
set(Eigen_DIR "/home/qiang/software/eigen-install/include/eigen3" CACHE PATH "Path to the Eigen3 library.")
set(METIS_DIR "${SFEM_DIR}/../metis-4.0" CACHE PATH "Path to the METIS library.")

set(LIBUNWIND_DIR "" CACHE PATH "Path to Libunwind.")

# For sundials_nvecmpiplusx and nvecparallel remember to build with MPI_ENABLE=ON
# and modify cmake variables for hypre for sundials
set(SUNDIALS_DIR "${SFEM_DIR}/../sundials-5.0.0/instdir" CACHE PATH
    "Path to the SUNDIALS library.")
# The following may be necessary, if SUNDIALS was built with KLU:
# set(SUNDIALS_REQUIRED_PACKAGES "SuiteSparse/KLU/AMD/BTF/COLAMD/config"
#     CACHE STRING "Additional packages required by SUNDIALS.")

set(MESQUITE_DIR "${SFEM_DIR}/../mesquite-2.99" CACHE PATH
    "Path to the Mesquite library.")

set(SuiteSparse_DIR "${SFEM_DIR}/../SuiteSparse" CACHE PATH
    "Path to the SuiteSparse library.")
set(SuiteSparse_REQUIRED_PACKAGES "BLAS" "METIS"
    CACHE STRING "Additional packages required by SuiteSparse.")

set(ParMETIS_DIR "${SFEM_DIR}/../parmetis-4.0.3" CACHE PATH
    "Path to the ParMETIS library.")
set(ParMETIS_REQUIRED_PACKAGES "METIS" CACHE STRING
    "Additional packages required by ParMETIS.")

set(SuperLUDist_DIR "${SFEM_DIR}/../SuperLU_DIST_6.3.1" CACHE PATH
    "Path to the SuperLU_DIST library.")
# SuperLU_DIST may also depend on "OpenMP", depending on how it was compiled.
set(SuperLUDist_REQUIRED_PACKAGES "MPI" "BLAS" "ParMETIS" CACHE STRING
    "Additional packages required by SuperLU_DIST.")

set(MUMPS_DIR "${SFEM_DIR}/../MUMPS_5.2.0" CACHE PATH
    "Path to the MUMPS library.")
# Packages required by MUMPS, depending on how it was compiled.
set(MUMPS_REQUIRED_PACKAGES "MPI" "BLAS" "METIS" "ScaLAPACK" CACHE STRING
    "Additional packages required by MUMPS.")
# If the MPI package does not find all required Fortran libraries:
# set(MUMPS_REQUIRED_LIBRARIES "gfortran" "mpi_mpifh" CACHE STRING
#     "Additional libraries required by MUMPS.")

set(STRUMPACK_DIR "${SFEM_DIR}/../STRUMPACK-build" CACHE PATH
    "Path to the STRUMPACK library.")
# STRUMPACK may also depend on "OpenMP", depending on how it was compiled.
# Starting with v2.2.0 of STRUMPACK, ParMETIS and Scotch are optional.
set(STRUMPACK_REQUIRED_PACKAGES "MPI" "MPI_Fortran" "ParMETIS" "METIS"
    "ScaLAPACK" "Scotch/ptscotch/ptscotcherr/scotch/scotcherr" CACHE STRING
    "Additional packages required by STRUMPACK.")
# If the MPI package does not find all required Fortran libraries:
# set(STRUMPACK_REQUIRED_LIBRARIES "gfortran" "mpi_mpifh" CACHE STRING
#     "Additional libraries required by STRUMPACK.")

# The Scotch library, required by STRUMPACK <= v2.1.0, optional in STRUMPACK >=
# v2.2.0.
set(Scotch_DIR "${SFEM_DIR}/../scotch_6.0.4" CACHE PATH
    "Path to the Scotch and PT-Scotch libraries.")
set(Scotch_REQUIRED_PACKAGES "Threads" CACHE STRING
    "Additional packages required by Scotch.")
# Tell the "Threads" package/module to prefer pthreads.
set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(Threads_LIB_VARS CMAKE_THREAD_LIBS_INIT)

# The ScaLAPACK library, required by STRUMPACK
set(ScaLAPACK_DIR "${SFEM_DIR}/../scalapack-2.0.2/lib/cmake/scalapack-2.0.2"
    CACHE PATH "Path to the configuration file scalapack-config.cmake")
set(ScaLAPACK_TARGET_NAMES scalapack)
# set(ScaLAPACK_TARGET_FORCE)
# set(ScaLAPACK_IMPORT_CONFIG DEBUG)

set(Ginkgo_DIR "${SFEM_DIR}/../ginkgo" CACHE PATH "Path to the Ginkgo library.")

set(AMGX_DIR "${SFEM_DIR}/../amgx" CACHE PATH "Path to AmgX")

set(GNUTLS_DIR "" CACHE PATH "Path to the GnuTLS library.")

set(GSLIB_DIR "" CACHE PATH "Path to the GSLIB library.")

set(NETCDF_DIR "" CACHE PATH "Path to the NetCDF library.")
set(NetCDF_REQUIRED_PACKAGES "HDF5/C/HL" CACHE STRING
    "Additional packages required by NetCDF.")

set(PETSC_DIR "${SFEM_DIR}/../petsc" CACHE PATH
    "Path to the PETSc main directory.")
set(PETSC_ARCH "arch-linux2-c-debug" CACHE STRING "PETSc build architecture.")

set(SLEPC_DIR "${SFEM_DIR}/../slepc" CACHE PATH
    "Path to the SLEPc main directory.")
set(SLEPC_ARCH "arch-linux2-c-debug" CACHE STRING "SLEPC build architecture.")

set(MPFR_DIR "" CACHE PATH "Path to the MPFR library.")

set(FMS_DIR "${SFEM_DIR}/../fms" CACHE PATH
    "Path to the FMS library.")
# If FMS is built with Conduit:
# set(FMS_REQUIRED_PACKAGES "Conduit/relay" CACHE STRING
#     "Additional packages required by FMS.")

set(CONDUIT_DIR "${SFEM_DIR}/../conduit" CACHE PATH
    "Path to the Conduit library.")

set(AXOM_DIR "${SFEM_DIR}/../axom" CACHE PATH "Path to the Axom library.")
# May need to add "Boost" as requirement.
set(Axom_REQUIRED_PACKAGES "Conduit/relay/blueprint" CACHE STRING
    "Additional packages required by Axom.")

set(PUMI_DIR "${SFEM_DIR}/../pumi-2.1.0" CACHE STRING
    "Directory where PUMI is installed")

set(HIOP_DIR "${SFEM_DIR}/../hiop/install" CACHE STRING
    "Directory where HiOp is installed")
set(HIOP_REQUIRED_PACKAGES "BLAS" "LAPACK" CACHE STRING
    "Packages that HiOp depends on.")

set(MKL_CPARDISO_DIR "" CACHE STRING "MKL installation path.")
set(MKL_MPI_WRAPPER_LIB "mkl_blacs_mpich_lp64" CACHE STRING "MKL MPI wrapper library")
set(MKL_LIBRARY_DIR "" CACHE STRING "Custom library subdirectory")

set(OCCA_DIR "${SFEM_DIR}/../occa" CACHE PATH "Path to OCCA")
set(RAJA_DIR "${SFEM_DIR}/../raja" CACHE PATH "Path to RAJA")
set(CEED_DIR "${SFEM_DIR}/../libCEED" CACHE PATH "Path to libCEED")
set(UMPIRE_DIR "${SFEM_DIR}/../umpire" CACHE PATH "Path to Umpire")
set(CALIPER_DIR "${SFEM_DIR}/../caliper" CACHE PATH "Path to Caliper")
set(BENCHMARK_DIR "${SFEM_DIR}/../google-benchmark" CACHE PATH
    "Path to Google Benchmark")

# Provide paths, since ParELAG is dependent on SFEM and SFEM needs to be
# compiled (or at least cmake needs to succeed) before compiling ParELAG.
set(PARELAG_DIR "${SFEM_DIR}/../parelag" CACHE PATH "Path to ParELAG")
set(PARELAG_INCLUDE_DIRS "${PARELAG_DIR}/src;${PARELAG_DIR}/build/src" CACHE
    STRING "Path to ParELAG headers.")
set(PARELAG_LIBRARIES "${PARELAG_DIR}/build/src/libParELAG.a" CACHE STRING
    "The ParELAG library.")

set(BLAS_INCLUDE_DIRS "" CACHE STRING "Path to BLAS headers.")
set(BLAS_LIBRARIES "" CACHE STRING "The BLAS library.")
set(LAPACK_INCLUDE_DIRS "" CACHE STRING "Path to LAPACK headers.")
set(LAPACK_LIBRARIES "" CACHE STRING "The LAPACK library.")

# Some useful variables:
set(CMAKE_SKIP_PREPROCESSED_SOURCE_RULES ON) # Skip *.i rules
set(CMAKE_SKIP_ASSEMBLY_SOURCE_RULES  ON)    # Skip *.s rules
# set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "Verbose makefiles.")

######################## Custom paths #################################
set (SLEPC_DIR CACHE PATH "Manual SLEPc directory")
set (X11_DIR CACHE PATH "Manual X11 directory (OOFEG)")
set (TINYXML2_DIR CACHE PATH "Manual TinyXML-2 directory (CEMHYD only)")
#set (PETSC_DIR CACHE PATH "Manual PETSc directory")
set (PETSC_ARCH CACHE STRING "Manual PETSc arch name (e.g. linux-gnu-cxx-opt)")
set (MPI_DIR CACHE PATH "Manual MPI directory")
set (VTK_DIR CACHE PATH "Manual VTK directory (For binary VTU export)")
set (LAPACK_DIR CACHE PATH "Manual LAPACK directory")
set (SUPERLU_MT_DIR CACHE PATH "Manual SuperLU_MT directory")
set (SPOOLES_DIR CACHE PATH "Manual SPOOLES directory")
set (ELIXIR_DIR CACHE PATH "Manual Elixir directory (OOFEG only)")
set (CKIT_DIR CACHE PATH "Manual CKit directory (OOFEG only)")
set (METIS_DIR CACHE PATH "Manual Metis directory (Load balancing)")
set (PARMETIS_DIR CACHE PATH "Manual ParMetis directory (Load balancing)")
#intel mkl pardiso
set (INTEL_MKL_PARDISO_DIR CACHE PATH "Manual mkl pardiso directory (sparse direct solver)")
#pardiso-project.org
set (PARDISO_ORG_DIR CACHE PATH "Manual pardiso-project.org directory (sparse direct solver)")
#set (BOOST_DIR CACHE PATH "Manual Boost directory")
set (PYBIND_DIR CACHE PATH "Manual pybind11 directory")