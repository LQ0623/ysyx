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
  
  while(*fmt != '\0'){
  	if(*fmt == '%'){
  		fmt++;
  		switch(*fmt){
  			
  			case 's':
  				char *s = va_arg(args, char*);
  				for(size_t i = 0;i < strlen(s);i++){
  					out[index++] = s[i];
  				}
  				break;
  			default:
  				out[index++] = *fmt;
  				
  		}
  	} else{
  		out[index++] = *fmt;
  	}
  	fmt++;
  }
  
  va_end(args);
  return 0;

}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

#endif
