#include <memory/mtrace.h>

char file_path[] = "../mtrace.log"; 

void init_mtrace_log(){
    FILE *file = fopen(file_path, "w");
    if(file == NULL){
        panic("打开或创建文件时出错");
    }

    fclose(file);
}

void mtrace_log_write(paddr_t addr, int len, char operate,word_t data){
    FILE *file = fopen(file_path, "a+");
    if(file == NULL){
        panic("打开文件时出错");
    }
    
    if(operate == 'r'){
        fprintf(file, "This has read addr : 0x%x  len : %d\n", addr, len);
    }else if(operate == 'w'){
        fprintf(file, "This has write addr : 0x%x  len : %d,the data is %x\n", addr, len, data);
    }
    fclose(file);
}