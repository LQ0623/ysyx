#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

int printf(const char *fmt, ...) {
  panic("Not implemented");
}

int vsprintf(char *out, const char *fmt, va_list ap) {
  panic("Not implemented");
}

int sprintf(char *out, const char *fmt, ...) {
  //panic("Not implemented");
    va_list args;
    va_start(args, fmt);

    int index = 0;
    int result = 0;

    while (*fmt != '\0') {
        if (*fmt == '%') {
            fmt++;
            switch (*fmt) {
                case 'd': {
                    int i = va_arg(args, int);
                    char buffer[12]; // 足够大以容纳int的最大值（包括负号）
                    int len = sprintf(buffer, "%d", i);
                    for (int i = 0; i < len; i++) {
                        out[index++] = buffer[i];
                    }
                    result += len;
                    break;
                }
                case 's': {
                    char *s = va_arg(args, char*);
                    size_t s_len = strlen(s);
                    for (size_t i = 0; i < s_len; i++) {
                        out[index++] = s[i];
                    }
                    result += s_len;
                    break;
                }
                default:
                        out[index++] = *fmt;
                        result++;
                    	break;
            }
        } else {
                out[index++] = *fmt;
                result++;
        }
        fmt++;
    }

    va_end(args);
    return result;

}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

#endif
