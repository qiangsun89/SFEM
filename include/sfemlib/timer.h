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

#include <chrono>
namespace sfem{
    class Timer{
    private:
        bool running_;
        std::chrono::system_clock::time_point start_;
        std::chrono::duration<long, std::nano> interval_;
        std::chrono::duration<long, std::nano> duration_;
    public:
        Timer(): running_(true),start_(std::chrono::system_clock::now()),
                 interval_(0),duration_(0) {}

        /// If the timer is paused then start the timer.
        void start();

        ///if the timer is running then pause the timer.
        void pause();

        ///Reset the timer
        void reset();

        ///If the timer is running then update the timer.
        void update();

        /// Format "Mon Feb 27 21:06:48 2021"
        static const char *getTime() ;
        const char *getInterval() const ;
        const char *getDuration() const ;
    };
}
#endif //SFEM_TIMER_H
