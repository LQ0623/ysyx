#include <am.h>
#include <nemu.h>

void __am_timer_init() {
}

// AM系统启动时间, 可读出系统启动后的微秒数.
void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uint32_t low_part = inl(RTC_ADDR);
  uint32_t high_part = inl(RTC_ADDR + 4);
  uptime->us = ((uint64_t)high_part) << 32 | low_part;
}

//  AM实时时钟(RTC, Real Time Clock), 可读出当前的年月日时分秒.
void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
