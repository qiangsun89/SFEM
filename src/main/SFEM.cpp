#include <chrono>
#include <iostream>
#include "sfemlib/timer.h"

using namespace sfem;
int main()
{
    Timer time_;
    time_.update();
    // 以下为5分钟表达
    std::chrono::minutes minute1{5}; // 5个1分钟
    std::chrono::duration<int, std::ratio<5*60, 1>> minute2{1}; // 1个5分钟
    std::chrono::duration<double, std::ratio<2*60, 1>> minute3{2.5}; // 2.5个2分钟

    std::cout <<  "minutes1 duration has " << minute1.count() << " ticks\n"
              <<  "minutes2 duration has " << minute2.count() << " ticks\n"
              <<  "minutes3 duration has " << minute3.count() << " ticks\n";

    // 一下为12小时表达
    std::chrono::hours hours1{12}; // 12个1小时
    std::chrono::duration<double, std::ratio<60*60*24, 1>> hours2{0.5}; // 0.5个1天

    std::cout <<  "hours1 duration has " << hours1.count() << " ticks\n"
              <<  "hours2 duration has " << hours2.count() << " ticks\n";

    // 使用 std::chrono::duration_cast<T> 将分钟间隔转化成标准秒间隔
    std::cout <<  "minutes1 duration has " <<
              std::chrono::duration_cast<std::chrono::seconds>(minute1).count() << " seconds\n";
    std::chrono::duration<int, std::ratio<60*60*24> > one_day(1);
    time_.update();
    // 根据时钟得到现在时间
    std::chrono::system_clock::time_point today = std::chrono::system_clock::now();
    std::time_t time_t_today = std::chrono::system_clock::to_time_t(today);
    std::cout <<  "now time stamp is " << time_t_today << std::endl;
    std::cout <<  "now time is " << ctime(&time_t_today) << std::endl;
    std::cout<<"========="<<std::endl;
    std::cout<<time_.getTime()<<std::endl;
    // 看看明天的时间
    std::chrono::system_clock::time_point tomorrow = today + one_day;
    std::time_t time_t_tomorrow = std::chrono::system_clock::to_time_t(tomorrow);
    std::cout <<  "tomorrow time stamp is " << time_t_tomorrow << std::endl;
    std::cout <<  "tomorrow time is " << ctime(&time_t_tomorrow) << std::endl;


    // 计算下个小时时间
    std::chrono::system_clock::time_point next_hour = today + std::chrono::hours(1);
    std::time_t time_t_next_hour = std::chrono::system_clock::to_time_t(next_hour);
    std::chrono::system_clock::time_point next_hour2 = std::chrono::system_clock::from_time_t(time_t_next_hour);

    std::time_t time_t_next_hour2 = std::chrono::system_clock::to_time_t(next_hour2);
    std::cout <<  "tomorrow time stamp is " << time_t_next_hour2 << std::endl;
    std::cout <<  "tomorrow time is " << ctime(&time_t_next_hour2) << std::endl;

    return 0;
}