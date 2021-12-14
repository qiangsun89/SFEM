/*************************************************************************************
 *
 *        #######       ######  ######  ###      ###
 *       #      #      ##      ##      ## #    # ##
 *        #           ####    ####    ##  #  #  ##
 *          #        ##      ##      ##    #   ##
 *      #      #    ##      ##      ##        ##
 *      #######    ##      ######  ##        ##
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

#ifndef SFEM_LOGGER_H
#define SFEM_LOGGER_H

#include <cstdio>
#include <string>

#ifdef __PARALLEL_MODE
#include <mpi.h>
#endif

// MSVC doesn't properly implement C99. (might need to wrap __func__ behind a macro to support all platforms correctly(?))
#ifdef _MSC_VER
# define __func__ __FUNCTION__
#endif

#include "sfemcfg.h"

namespace sfem {

/**
 * Logger class used by SFEM to print information during analysis.
 * Prints warnings and errors into a separate stream from normal output.
 */
    class SFEM_EXPORT Logger {
    public:
        /// Type defining basic log levels.
        enum logLevelType {
            LOG_LEVEL_FORCED = -1,
            LOG_LEVEL_FATAL = 0, LOG_LEVEL_ERROR = 0,
            LOG_LEVEL_WARNING = 1,
            LOG_LEVEL_RELEVANT = 2,
            LOG_LEVEL_INFO = 3,
            LOG_LEVEL_ALL = 4, LOG_LEVEL_DEBUG = 4
        };
    protected:
        /// Stream used for logging.
        FILE *logStream, *errStream;
        /// flag indicating whether to close mylogStream.
        bool closeFlag, errCloseFlag;
        /// Current log level, messages with higher level are not reported.
        logLevelType logLevel;
        /// Counter of all warning and error messages.
        int numberOfWrn, numberOfErr;
#ifdef __PARALLEL_MODE
        /// Parallell comm
        MPI_Comm comm;
#endif
    public:
        Logger(logLevelType level);

        ~Logger();

        /// Redirects log output to given file name (with path).
        void appendLogTo(const std::string &fname);

        /// Redirects error output to given file name (with path).
        void appendErrorTo(const std::string &fname);

        /// Redirects log output to given stream.
        void appendLogTo(FILE *stream);

        /// Redirects error output to given stream.
        void appendErrorTo(FILE *stream);

#ifdef __PARALLEL_MODE
        /// Parallell comm
        void setComm(MPI_Comm comm);
#endif

        /// Writes the normal log message.
        void writeLogMsg(logLevelType level, const char *format, ...);

        /// Writes extended log message with file and line info.
        void writeELogMsg(logLevelType level, const char *_func, const char *_file, int _line, const char *format, ...);

        /// Flushes the log stream.
        void flush() {
            fflush(logStream);
            fflush(errStream);
        }

        /// Sets log level to given one. Only log messages with level less or equal given threshold will be printed.
        void setLogLevel(logLevelType level) { logLevel = level; }

        /// Sets log level to given one. Only log messages with level less or equal given threshold will be printed.
        void setLogLevel(int level);

        /// Increment error count by one
        void incrementErrorCounter() { numberOfErr++; }

        /// Prints number of errors and warning logged.
        void printStatistics();

    protected:
        const char *giveLevelName(logLevelType l) const;


    };
    extern SFEM_EXPORT Logger sfem_logger;
/**
* Log reporting macros
*/
//@{
#define SFEM_LOG_FATAL(...) sfem_logger.writeELogMsg(Logger :: LOG_LEVEL_FATAL, __func__, __FILE__, __LINE__, __VA_ARGS__)
#define SFEM_LOG_ERROR(...) sfem_logger.writeELogMsg(Logger :: LOG_LEVEL_ERROR, __func__, __FILE__, __LINE__, __VA_ARGS__)
#define SFEM_LOG_WARNING(...) sfem_logger.writeELogMsg(Logger :: LOG_LEVEL_WARNING,  __func__, __FILE__, __LINE__, __VA_ARGS__)

#define SFEM_LOG_FORCED(...) sfem_logger.writeLogMsg(Logger :: LOG_LEVEL_FORCED, __VA_ARGS__)
#define SFEM_LOG_RELEVANT(...) sfem_logger.writeLogMsg(Logger :: LOG_LEVEL_RELEVANT, __VA_ARGS__)
#define SFEM_LOG_INFO(...) sfem_logger.writeLogMsg(Logger :: LOG_LEVEL_INFO, __VA_ARGS__)
#define SFEM_LOG_DEBUG(...) sfem_logger.writeLogMsg(Logger :: LOG_LEVEL_DEBUG, __VA_ARGS__)
//@}
#endif //SFEM_LOGGER_H
