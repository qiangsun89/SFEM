/*
         **********        ************   ************      *                     *
        *          *       *              *                 *  *                * *
           *        *      *              *                 *    *            *   *
             *             *              *                 *      *        *     *
               *           ************   ************      *        *    *       *
                 *         *              *                 *          *          *
      *            *       *              *                 *                     *
        *            *     *              *                 *                     *
         ***********       *              ************      *                     *


               SFEM : Spectral Finite Element Code

                 Copyright (C) 2021 -    Borek Patzak
            https://github.com/qiangsun89/SFEM    e-mail: sunqiang891103@gmail.com


            BSD 3-Clause License

            Copyright (c) 2021, QiangSun
            All rights reserved.

            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are met:

            1. Redistributions of source code must retain the above copyright notice, this
               list of conditions and the following disclaimer.

            2. Redistributions in binary form must reproduce the above copyright notice,
               this list of conditions and the following disclaimer in the documentation
               and/or other materials provided with the distribution.

            3. Neither the name of the copyright holder nor the names of its
               contributors may be used to endorse or promote products derived from
               this software without specific prior written permission.

            THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
            AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
            IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
            DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
            FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
            DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
            SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
            CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
            OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
            OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
//***************************************************************************************
//
//! \file timer.h
//!  Simple device user API.
//!
//! \author    qiang sun
//! \version   V1.0.0
//! \date      2021-12-7
//
//***************************************************************************************

#ifndef SFEM_TIMER_H
#define SFEM_TIMER_H
#include "sfemcfg.h"
#include <chrono>
namespace sfem{
/**
 * Class implementing single timer, providing wall clock and user time capabilities.
 */
class SFEM_EXPORT Timer{
    /// Wall clock time markers.
    std :: chrono :: time_point< std :: chrono :: high_resolution_clock >start_wtime, end_wtime;
    /// User time.
    std :: chrono :: duration< double >start_utime, end_utime;
    /// Accumulated wtime and utime (in seconds) from start.
    std :: chrono :: duration< double >elapsedWTime, elapsedUTime;
    /// Flag indicating whether timer is running.
    bool running;
public:
    Timer();
    void startTimer();
    void stopTimer();
    void pauseTimer();
    void resumeTimer();
    void initTimer();
    bool isRunning() { return running; }

    /// Returns total user time elapsed in seconds
    double getUtime();
    /// Returns total elapsed wall clock time in seconds
    double getWtime();
    /**
 * Converts total seconds into hours, minutes and remaining seconds
 * @param[out] nhrs Number of hours.
 * @param[out] nmin Number of minutes.
 * @param[out] nsec Number of seconds.
 * @param[in] tsec Total time in seconds.
 */
    static void convert2HMS(int &nhrs, int &nmin, int &nsec, double tsec);

    /// Prints receiver state into a string.
    void toString(char *buff);

    void updateElapsedTime();

private:
    /// Platform independent wrapper for user time
    void getUtime(std :: chrono :: duration< double > &answer);
    /// Platform independent wrapper for wall time
    void getTime(std :: chrono :: time_point< std :: chrono :: high_resolution_clock > &answer);
};
/**
 * Timer class, assumed to be an attribute of engineering model, serving stop-watch facility for engineering model.
 * It can handle several timers independently, each corresponding to different solution stage, etc.
 * Each timer is capable to track elapsed wall clock time as well as user time.
 */
    class SFEM_EXPORT EngngModelTimer{
    public:
        /**
         * Enumeration to distinguish different type of timers.
         *
         * EMTT_NetComputationalStepTimer timer (and particularly its wall clock time) should measure only computation itself,
         * no communication, therefore it should be measure of workload (in terms of wall clock time) on particular processors.
         * It also typically not include time needed to solve the system of equations, since this has to be done in parallel,
         * so solution takes the same time on all processors and include unwanted synchronization.
         */
        enum EngngModelTimerType {
            EMTT_AnalysisTimer,
            EMTT_SolutionStepTimer,
            EMTT_NetComputationalStepTimer,
            EMTT_LoadBalancingTimer,
            EMTT_DataTransferTimer,
            EMTT_LastTimer
        };

    protected:
        /// Array of Timer classes.
        Timer timers [ EMTT_LastTimer ];

    public:
        EngngModelTimer() { }
        ~EngngModelTimer() { }

        /**@name Profiling routines. */
        //@{
        void startTimer(EngngModelTimerType t) { timers [ t ].startTimer(); }
        void stopTimer(EngngModelTimerType t) { timers [ t ].stopTimer(); }
        void pauseTimer(EngngModelTimerType t) { timers [ t ].pauseTimer(); }
        void resumeTimer(EngngModelTimerType t) { timers [ t ].resumeTimer(); }
        void initTimer(EngngModelTimerType t) { timers [ t ].initTimer(); }
        //@}

        /**@name Reporting routines. */
        //@{
        /// Returns total user time elapsed.
        double getUtime(EngngModelTimerType t);
        /// Returns elapsed wall clock time.
        double getWtime(EngngModelTimerType t);
        /// Returns pointer to timer determined by EngngModelTimerType.
        const Timer *getTimer(EngngModelTimerType t)  { return timers + t; }
        /// Converts total seconds into hours, mins, and seconds.
        static void convert2HMS(int &nhrs, int &nmin, int &nsec, double tsec);
        /// Printing & formatting.
        void toString(EngngModelTimerType t, char *buff);
        //@}
    };
}
#endif //SFEM_TIMER_H
