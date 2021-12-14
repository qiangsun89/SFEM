/*************************************************************************************
 *
 *         ####         ######  ######  ###      ###
 *       #      #      ##      ##      ## #    # ##
 *        #           ####    ####    ##  #  #  ##
 *          #        ##      ##      ##    #   ##
 *      #      #    ##      ##      ##        ##
 *        ####     ##      ######  ##        ##
 *
 *
 *      SFEM : Statistical Finite Element Code
 *
 *      Copyright (C) 2021   Qiang Sun
 *      All rights reserved.
 *
 *      Redistribution and use in source and binary forms, with or without
 *      modification, are permitted provided that the following conditions are met:
 *
 *      1. Redistributions of source code must retain the above copyright notice, this
 *      list of conditions and the following disclaimer.
 *
 *      2. Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 *
 *      3. Neither the name of the copyright holder nor the names of its
 *      contributors may be used to endorse or promote products derived from
 *      this software without specific prior written permission.
 *
 *      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *      AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *      IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *      DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 *      FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 *      DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 *      SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *      CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 *      OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ***************************************************************************************/
#ifdef _PYTHON_EXTENSION
#include <Python.h>
#endif

//#include "engngm.h"
//#include "oofemcfg.h"
//
//#include "oofemtxtdatareader.h"
//#include "datastream.h"
//#include "util.h"
//#include "error.h"
//#include "logger.h"
//#include "contextioerr.h"
//#include "oofem_terminate.h"

#ifdef __PARALLEL_MODE
#include "dyncombuff.h"
#endif

#ifdef __PETSC_MODULE
#include <petsc.h>
#endif

#ifdef __SLEPC_MODULE
#include <slepceps.h>
#endif

#ifdef _OPENMP
#include <omp.h>
#endif

#ifdef __OOFEG
#include "oofeggraphiccontext.h"
#endif

#ifdef __PARALLEL_MODE
#include "dyncombuff.h"
#endif

#ifdef __PETSC_MODULE
#include <petsc.h>
#endif

#ifdef __SLEPC_MODULE
#include <slepceps.h>
#endif

#ifdef _OPENMP
#include <omp.h>
#endif

#ifdef __OOFEG
#include "oofeggraphiccontext.h"
#endif

#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <new>
#include <sstream>
// For passing PETSc/SLEPc arguments.
#include <fstream>
#include <iterator>
#include <vector>

//#include "classfactory.h"
#include "sfemlib/timer.h"
using namespace sfem;
// debug
//void sfem_debug(EngngModel &emodel);

void sfem_print_help();
void sfem_print_version();
void sfem_print_epilog();

// Finalize PETSc, SLEPc and MPI
void sfem_finalize_modules();

#define LOG_ERR_HEADER "_______________________________________________________"
#define LOG_ERR_TAIL   "_______________________________________________________\a\n"
int main(int argc, char *argv[]){
    // Stack trace on uncaught exceptions;
//    std::set_terminate( exception_handler );

    int adaptiveRestartFlag = 0, restartStep = 0;
    bool parallelFlag = false, renumberFlag = false, debugFlag = false, contextFlag = false, restartFlag = false,
            inputFileFlag = false, outputFileFlag = false, errOutputFileFlag = false;
    std :: stringstream inputFileName, outputFileName, errOutputFileName;
    std :: vector< const char * >modulesArgs;

    int rank = 0;

#ifdef __PARALLEL_MODE
    #ifdef __USE_MPI
    MPI_Init(& argc, & argv);
    MPI_Comm_rank(MPI_COMM_WORLD, & rank);
    sfem_logger.setComm(MPI_COMM_WORLD);
 #endif
#endif

    //
    // check for options
    //
    if ( argc != 1 ) {
        // argv[0] is not read by PETSc and SLEPc.
        modulesArgs.push_back(argv [ 0 ]);
        for ( int i = 1; i < argc; i++ ) {
            if ( ( strcmp(argv [ i ], "-context") == 0 ) || ( strcmp(argv [ i ], "-c") == 0 ) ) {
                contextFlag = true;
            } else if ( strcmp(argv [ i ], "-v") == 0 ) {
                if ( rank == 0 ) {
                    sfem_print_version();
                }

                if ( argc == 2 ) {
#ifdef __USE_MPI
                    MPI_Finalize();
#endif
                    exit(EXIT_SUCCESS);     // exit if only "-v" option
                }
            } else if ( strcmp(argv [ i ], "-f") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    inputFileName << argv [ i ];
                    inputFileFlag = true;
                }
            } else if ( strcmp(argv [ i ], "-r") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    restartFlag = true;
                    restartStep = strtol(argv [ i ], NULL, 10);
                }
            } else if ( strcmp(argv [ i ], "-rn") == 0 ) {
                renumberFlag = true;
            } else if ( strcmp(argv [ i ], "-ar") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    adaptiveRestartFlag = strtol(argv [ i ], NULL, 10);
                }
            } else if ( strcmp(argv [ i ], "-l") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    int level = strtol(argv [ i ], NULL, 10);
//                    sfem_logger.setLogLevel(level);
                }
            } else if ( strcmp(argv [ i ], "-qe") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    errOutputFileFlag = true;
                    errOutputFileName << argv [ i ];
                    i++;
                }
            } else if ( strcmp(argv [ i ], "-qo") == 0 ) {
                if ( i + 1 < argc ) {
                    i++;
                    outputFileFlag = true;
                    outputFileName << argv [ i ];
                }
            } else if ( strcmp(argv [ i ], "-d") == 0 ) {
                debugFlag = true;
            } else if ( strcmp(argv [ i ], "-p") == 0 ) {
#ifdef __PARALLEL_MODE
                parallelFlag = true;
#else
                fprintf(stderr, "\nCan't use -p, not compiled with parallel support\a\n\n");
                exit(EXIT_FAILURE);
#endif
            } else if ( strcmp(argv [i], "-t") == 0) {
#ifdef _OPENMP
                if ( i + 1 < argc ) {
                    i++;
                    int numberOfThreads = strtol(argv [ i ], NULL, 10);
                    omp_set_num_threads (numberOfThreads);
                }
#else
                fprintf(stderr, "\nCan't use -t, not compiled with OpenMP support\a\n\n");
                exit(EXIT_FAILURE);
#endif
            } else { // Arguments not handled by OOFEM is to be passed to PETSc
                modulesArgs.push_back(argv [ i ]);
            }
        }
    } else {
        if ( rank == 0 ) {
            sfem_print_help();
        }

#ifdef __USE_MPI
        MPI_Finalize();
#endif
        exit(EXIT_SUCCESS);
    }

    // check if input file given
    if ( !inputFileFlag ) {
        if ( rank == 0 ) {
            fprintf(stderr, "\nInput file not specified\a\n\n");
        }

#ifdef __USE_MPI
        MPI_Finalize();
#endif
        exit(EXIT_FAILURE);
    }

#if defined ( __PETSC_MODULE ) || defined ( __SLEPC_MODULE )
    int modulesArgc = modulesArgs.size();
    char **modulesArgv = const_cast< char ** >(& modulesArgs [ 0 ]);
#endif

#ifdef __PETSC_MODULE
    PetscInitialize(& modulesArgc, & modulesArgv, PETSC_NULL, PETSC_NULL);
#endif

#ifdef __SLEPC_MODULE
    SlepcInitialize(& modulesArgc, & modulesArgv, PETSC_NULL, PETSC_NULL);
#endif

#ifdef _PYTHON_EXTENSION
    Py_Initialize();
    // Adding . to the system path allows us to run Python functions stored in the working directory.
    PyRun_SimpleString("import sys");
    PyRun_SimpleString("sys.path.append(\".\")");
#endif

#ifdef __PARALLEL_MODE
    if ( parallelFlag ) {
        inputFileName << "." << rank;
        outputFileName << "." << rank;
        errOutputFileName << "." << rank;
    }
#endif
}

#ifndef HOST_TYPE
#define HOST_TYPE "unknown"
#endif

void sfem_print_version()
{
    printf("\n%s (%s, %s)\nof %s on %s\n", SFEM_VERSION, HOST_TYPE, MODULE_LIST, __DATE__, HOST_NAME);
//    oofem_print_epilog();
}
void sfem_print_help()
{
    printf("\nOptions:\n\n");
    printf("  -v  prints oofem version\n");
    printf("  -f  (string) input file name\n");
    printf("  -r  (int) restarts analysis from given step\n");
    printf("  -ar (int) restarts adaptive analysis from given step\n");
    printf("  -l  (int) sets treshold for log messages (Errors=0, Warnings=1,\n");
    printf("            Relevant=2, Info=3, Debug=4)\n");
    printf("  -rn turns on renumbering\n");
    printf("  -qo (string) redirects the standard output stream to given file\n");
    printf("  -qe (string) redirects the standard error stream to given file\n");
    printf("  -c  creates context file for each solution step\n");
    printf("\n");
    sfem_print_epilog();
}
void sfem_print_epilog()
{
    printf("\n%s\n", SFEM_COPYRIGHT);
    printf("This is free software; see the source for copying conditions.  There is NO\n");
    printf("warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n\n");
}

void sfem_finalize_modules()
{
#ifdef __PETSC_MODULE
    PetscFinalize();
#endif

#ifdef __SLEPC_MODULE
    SlepcFinalize();
#endif

#ifdef __USE_MPI
    MPI_Finalize();
#endif

#ifdef _PYTHON_EXTENSION
    Py_Finalize();
#endif
}

