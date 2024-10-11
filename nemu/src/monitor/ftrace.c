#include <ftrace.h>


func_name_collation func_name[MAX_FUNC];
TailRecNode *tail_rec_head = NULL; // linklist with head, dynamic allocated
int count_inv;

void init_tail_rec_list() {
	tail_rec_head = (TailRecNode *)malloc(sizeof(TailRecNode));
	tail_rec_head->pc = 0;
	tail_rec_head->next = NULL;
}

void insert_tail_rec(vaddr_t pc, int depth) {
	TailRecNode *node = (TailRecNode *)malloc(sizeof(TailRecNode));
	node->pc = pc;
	node->depth = depth;
	node->next = tail_rec_head->next;
	tail_rec_head->next = node;
}

void remove_tail_rec() {
	TailRecNode *node = tail_rec_head->next;
	tail_rec_head->next = node->next;
	free(node);
}

void init_ftrace(char* elf_file){
    init_tail_rec_list();
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
    printf("0x%x:",addr_inv);
    if(operate == 'c'){
        for(int i = 0;i < count_inv;i++){
            printf("  ");
        }
        printf("call [");
        char* str;
        int i;
        for(i = 0;i < MAX_FUNC;i++){
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
        insert_tail_rec(addr_inv,count_inv-1);
    }else if(operate == 'r'){
        count_inv--;
        for(int i = 0;i < count_inv;i++){
            printf("  ");
        }
        printf("ret [\n");
        char* str;
        str = tail_rec_head->next->name;
        printf("%s]\n",str);
        remove_tail_rec();
    }
}