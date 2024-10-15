#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

static char HEX_CHARACTERS[] = "0123456789ABCDEF";

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
			/**
			 * width: 指定输出字段的最小宽度
			 * precision: 控制输出的精度。
			 * argc_type: 指定参数的类型。
			 */
			int width =0,precision = -1;
			//char argc_type = 0;
			while(*fmt>='0' && *fmt<='9'){
				width = width * 10 + (*fmt - '0');
				fmt ++;
			}
			if(*fmt == '.'){
				fmt++;
				precision = 0;
				while(*fmt>='0' && *fmt<='9'){
					precision = precision * 10 + (*fmt - '0');
					fmt ++;
				}
			}
			// if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
            //     argc_type = *fmt++;
            // }

			switch(*fmt){
				case 's':{
					char *s = va_arg(args, char*);
					int len = strlen(s);
					if (precision >= 0 && precision < len) {
                        len = precision;
                    }
					if (width > len) {
                        for (int i = 0; i < width - len; i++) {
                            out[index++] = ' '; // 右对齐
                        }
                    }
					strncpy(out + index, s, len);
					index += len;
					break;
				}
				case 'd':{
					int i = va_arg(args, int);
					if(i == 0){
						out[index++] = '0';
					}else {
						if(i < 0){
							out[index++] = '-';
							i = 0 - i;
						}
						int digital;
						char temp[32];
						int count = 0;
						while(i>0){
							digital = i%10;
							temp[count++] = HEX_CHARACTERS[digital];
							i = i/10;
						}
						//count--;	// 对于下标而言，这个count多加了一次
						if (precision >= 0 && precision < count) {
							count = precision - 1;
						}else{
							count--;
						}
						if (width > count) {
							for (int i = 0; i < width - count; i++) {
								out[index++] = ' '; // 右对齐
							}
						}
						while(count>=0){
							out[index++] = temp[count--];
						}
					}
					break;
				}
				case 'c': {
					char temp = (char)va_arg(args,int);
					if (width > 1) {
						for (int i = 0; i < width - 1; i++) {
							out[index++] = ' '; // 右对齐
						}
					}
					out[index++] = temp;
					break;
				}
				case 'x': {
					int x = va_arg(args, int);
					char temp[32]; 
					int count = 0,digital = 0;
					while(x>0){
						digital = x%16;
						temp[count++] = HEX_CHARACTERS[digital];
						x = x/16;
					}
					// 处理宽度和精度
					// count和precision代表的是数字的位数，但是后续需要使用下标，所以需要减1
					if (precision >= 0 && precision < count) {
						count = precision - 1;
					}else{
						count--;
					}
					if (width > count) {
						for (int i = 0; i < width - count; i++) {
							out[index++] = ' '; // 右对齐
						}
					}
					while(count>=0){
						out[index++] = temp[count--];
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
