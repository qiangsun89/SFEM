//***************************************************************************************
//
//! \file timer.cpp
//! This code get the system time.
//!
//! \author    qiang sun
//! \version   V1.0.0
//! \date      2021-12-07
//! \copyright BSD 3-Clause License
//
//***************************************************************************************
#include <cstdio>
#include <cstring>
#include "sfemlib/timer.h"

namespace sfem{
    namespace {
        char outputBuffer[128];

        const char *converToString(std::chrono::duration<long, std::nano> duration) {
            /// how many time periods are contained in the specified time interval object
            long Counts_ = duration.count();
            long seconds = Counts_ / 1000000000;
            double usec = (Counts_ % 1000000000) / 1000000000;
            int hour = seconds / 3600;
            int minute = seconds / 60 - hour * 60;
            int second = seconds - minute * 60 - hour * 3600;

            if (hour) {
                sprintf(outputBuffer, "%d hours %d minutes %d seconds", hour, minute, second);
            } else if (minute) {
                sprintf(outputBuffer, "%d minutes %d seconds", minute, second);
            } else {
                sprintf(outputBuffer, "%.6lf second", second + usec);
            }
            return outputBuffer;
        }
    }

    void Timer::start() {
        if (!running_) {
            running_ = true;
            start_ = std::chrono::system_clock::now();
        }
    }

    void Timer::pause() {
        auto now = std::chrono::system_clock::now();
        interval_ = now - start_;
        duration_ += interval_;
        running_ = false;
    }

    void Timer::reset() {
        running_ = true;
        start_ = std::chrono::system_clock::now();
        duration_ = std::chrono::duration<long, std::nano>::zero();
    }

    void Timer::update() {
        if (running_) {
            auto now = std::chrono::system_clock::now();
            interval_ = now - start_;
            duration_ += interval_;
            start_ = now;
        }
    }

    const char *Timer::getTime() {
        std::chrono::system_clock::time_point now_ = std::chrono::system_clock::now();
        std::time_t time_t_now_ = std::chrono::system_clock::to_time_t(now_);
        return ctime(&time_t_now_);
    }

    const char *Timer::getInterval() const {
        return converToString(interval_);
    }

    const char *Timer::getDuration() const {
        return converToString(duration_);
    }
}

