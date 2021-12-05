//
// Created by qiang on 2021/12/5.
//

#ifndef SFEM_TIMER_H
#define SFEM_TIMER_H

#include <chrono>
namespace sfem{
    class Timer{
    public:
        Timer(): running_(true),start_(std::chrono::system_clock::now()),
                 interval_(0),duration_(0) {}

        /// If the timer is paused then start the timer, else do nothing.
        void start();

        ///if the timer is running then pause the timer, else do nothing.
        void pause();

        ///Reset the timer
        void reset();

        ///If the timer is running then update the timer, else do nothing.
        void update();

        /// Format "Mon Feb 27 21:06:48 2021"
        const char *getTime() const ;
        const char *getInterval() const ;
        const char *getDuration() const ;

    private:
        bool running_;
        std::chrono::system_clock::time_point start_;
        std::chrono::duration<long, std::nano> interval_;
        std::chrono::duration<long, std::nano> duration_;
    };
}
#endif //SFEM_TIMER_H
