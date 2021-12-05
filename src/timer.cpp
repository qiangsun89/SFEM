//
// Created by qiang on 2021/12/5.
//
#include <cstdio>
#include <cstring>
#include "timer.h"

namespace sfem{
    namespace {
        char outputBuffer[128];

        const char *converToString(std::chrono::duration<long, std::nano> duration) {
            long nanoCounts = duration.count();
            long sec = nanoCounts / 1000000000;
            double usec = (nanoCounts % 1000000000) / 1000000000;
            int hour = sec / 3600;
            int minute = sec / 60 - hour * 60;
            int second = sec - minute * 60 - hour * 3600;

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

    const char *Timer::getTime() const {
        std::time_t now = std::time(nullptr);
        strcpy(outputBuffer, ctime(&now));
        outputBuffer[strlen(outputBuffer) - 1] = '\0';
        return outputBuffer;
    }

    const char *Timer::getInterval() const {
        return converToString(interval_);
    }

    const char *Timer::getDuration() const {
        return converToString(duration_);
    }
}

