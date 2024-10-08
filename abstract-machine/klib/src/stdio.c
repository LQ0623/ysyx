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

	while(*fmt){
		if(*fmt != '%'){
			out[index++] = *fmt;
		}else{
			fmt++;
			switch(*fmt){
				case 's':{
					char *s = va_arg(args, char*);
					strcpy(out + index, s);
					index += strlen(s) - 1;
					break;
				}
				case 'd':{
					int i = va_arg(args, int);
					if(i == 0){
						out[index++] = '0';
					}else {
						if(i < 0){
							out[index++] = '-';
							i = i * (-1);
						}
						int digital;
						char temp[32];
						int count = 0;
						while(i>0){
							digital = i%10;
							temp[count++] = digital + '0';
							i = i/10;
						}
						count--;	// 对于下标而言，这个count多加了一次
						while(count>=0){
							out[index++] = temp[count--];
						}
					}
					break;
				}
				default:{
					out[index++] = *fmt;
					break;
				}
					
			}
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
