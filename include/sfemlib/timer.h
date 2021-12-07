//***************************************************************************************
//
//! \file timer.h
//!  Simple device user API.
//!
//! \author    qiang sun
//! \version   V1.0.0
//! \date      2021-12-7
//! \copyright BSD 3-Clause License
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
