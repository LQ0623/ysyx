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
  // 解析...中的参数
  va_start(args, fmt);
  
  int index = 0;

  while(*fmt != '\0'){
  	if(*fmt == '%'){
  		fmt++;
  		switch(*fmt){
  			case 's':{
				char *s = va_arg(args, char*);
				strcpy(out + index, s);
				index += strlen(s);
				break;
			}
  			case 'd':{
  				int i = va_arg(args, int);
  				int tmp;
  				while(i>0){
  					tmp = i%10;
  					out[index++] = tmp + '0';
  					i = i/10;
  				}
  				break;
			}
  			default:{
  				out[index++] = *fmt;
				break;
			}
  				
  		}
  	} else{
  		out[index++] = *fmt;
  	}
  	fmt++;
  }
  out[index] = '\0';
  va_end(args);
  return index;

}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

#endif
