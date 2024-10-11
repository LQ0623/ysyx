#include <ftrace.h>

func_name_collation func_name[MAX_FUNC];
int count_inv;

void init_ftrace(char* elf_file){
    analysis_elf(func_name,elf_file);
    count_inv = 0;
}

/**
 * operate:
 *      r: ret
 *      c: call
 * addr_inv:
 *      调用函数的地址
 * addr_func:
 *      函数的地址
 */
void ftrace_function(char operate,vaddr_t addr_inv,vaddr_t addr_func){
    printf("0x%x:\n",addr_inv);
    if(operate == 'c'){
        // for(int i = 0;i < count_inv;i++){
        //     printf("  ");
        // }
        printf("call [\n");
        char* str;
        for(int i = 0;i < MAX_FUNC;i++){
            if(func_name[i].addr == addr_func){
                str = func_name[i].name;
                break;
            }
        }
        if(str == NULL){
            panic("解析错误");
        }
        printf("%s@0x%x]\n",str,addr_func);
        count_inv++;
    }else if(operate == 'r'){
        for(int i = 0;i < count_inv;i++){
            printf("  ");
        }
        printf("ret [\n");
        // char* str;
        // for(int i = 0;i < MAX_FUNC;i++){
        //     if(func_name[i].addr == addr_func){
        //         str = func_name[i].name;
        //         break;
        //     }
        // }
        // if(str == NULL){
        //     panic("解析错误");
        // }
        // printf("%s@0x%x]\n");
        count_inv--;
    }
}