#include <circuit.h>
#include <my_memory.h>
#include <ftrace.h>
#include "sdb.h"
#include <readline/readline.h>
#include <readline/history.h>
// #include <ftrace/ftrace.h>

static int is_batch_mode = false;

void init_regex();
void init_wp_pool();

/* We use the `readline' library to provide more flexibility to read from stdin. */
static char* rl_gets() {  
  static char *line_read = NULL;

  if (line_read) {
    free(line_read);
    line_read = NULL;
  }

  line_read = readline("(lq_npc) ");

  if (line_read && *line_read) {
    add_history(line_read);
  }

  return line_read;
}

static int cmd_c(char *args) {
  // 表示要执行的指令的数量,-1表示运行所有的指令,
  // 负数会变为一个很大的数，这样就能运行完所有的指令,-1会变为18446744073709551615
  // 负数会被当作无符号整数处理，所以负数的补码都被认为是无符号的整数了
  cpu_exec(-1);
  return 0;
}

// TODO：这里退出的方式需要修改
static int cmd_q(char *args) {
  // cmd_q 函数只是简单的返回-1,但是并没有实现完整的退出逻辑
  //exit(0); // 使用 exit(0) 退出程序
#ifdef CONFIG_FTRACE
  free_func_name();
#endif
  //nemu_state.state = NEMU_QUIT;
  return -1;
}

static int cmd_si(char *args){
  int step = 1;
  if(args != NULL){
    step = atoi(args);
  }
  cpu_exec(step);
  return 0;
}

static int cmd_info(char *args){
  if(args == NULL){
    printf("请输入要执行的操作r或者w\n");
    return 0;
  }
  char SubCmd = args[0];
  if(SubCmd == 'r'){
    isa_reg_display();
    return 0;
  }else if(SubCmd == 'w'){
    point_display();
    return 0;
  }
  return 0;
}

/**
 * 访问内存
 */
static int cmd_x(char *args){
  /* extract the first argument */
  char *N = strtok(NULL, " ");
  // 获取剩余的字符串，即表达式部分
  char *expr_x = strtok(NULL,"\0");

  if(N == NULL || expr_x == NULL){
    printf("usage : x <size> <addr>\n");
    return 0;
  }
  else{
    int num = atoi(N);
    uint32_t addr = strtoul(expr_x, NULL, 16);
    uint8_t* raddr = (uint8_t*)guest_to_host(addr);
    for(int i = 0;i < num; i++){
      printf("addr: %#x,data: %#02x\n",addr,*raddr);
      addr = addr + 4;
    }
    return 0;
  }
}

static int cmd_p(char *args){
  bool success = false;
  int result = -1;
  result = expr(args,&success);
  printf("%s value is %#x\n",args,result);
  if(success){
    return 0;
  }else{
    return -1;
  }
}

static int cmd_w(char *args){
  bool success = false;
  word_t result = expr(args,&success);
  // printf("%s",args);
  if(success){
    set_point(args,result);
    return 0;
  }else{
    panic("cannot set watchpoint\n");
    return -1;
  }
}

static int cmd_d(char* args){
  char* no = strtok(args," ");
  remove_point(atoi(no));
  return 0;
}

static int cmd_help(char *args);

// handler最后返回一个int类型的数据
static struct {
  const char *name;
  const char *description;
  int (*handler) (char *);
} cmd_table [] = {
  { "help", "Display information about all supported commands", cmd_help },
  { "c", "Continue the execution of the program", cmd_c },
  { "q", "Exit NEMU", cmd_q },

  /* TODO: Add more commands */
  { "si", "单步执行", cmd_si },
  { "info", "打印程序状态", cmd_info},
  { "x", "扫描内存", cmd_x},
  { "p", "表达式的求值", cmd_p},
  { "w", "设置监视点", cmd_w},
  { "d", "删除监视点", cmd_d},

};

#define NR_CMD ARRLEN(cmd_table)

static int cmd_help(char *args) {
  /* extract the first argument */
  char *arg = strtok(NULL, " ");
  int i;

  if (arg == NULL) {
    /* no argument given */
    for (i = 0; i < NR_CMD; i ++) {
      printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
    }
  }
  else {
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(arg, cmd_table[i].name) == 0) {
        printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
        return 0;
      }
    }
    printf("Unknown command '%s'\n", arg);
  }
  return 0;
}

void sdb_set_batch_mode() {
  is_batch_mode = true;
}

void sdb_mainloop() {
  if (is_batch_mode) {
    cmd_c(NULL);
    return;
  }

  for (char *str; (str = rl_gets()) != NULL; ) {
    char *str_end = str + strlen(str);

    /* extract the first token as the command */
    char *cmd = strtok(str, " ");
    if (cmd == NULL) { continue; }

    /* treat the remaining string as the arguments,
     * which may need further parsing
     */
    char *args = cmd + strlen(cmd) + 1;
    if (args >= str_end) {
      args = NULL;
    }

    int i;
    // 与指令表中的指令进行对比
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(cmd, cmd_table[i].name) == 0) {
        if (cmd_table[i].handler(args) < 0) { return; }
        break;
      }
    }

    if (i == NR_CMD) { printf("Unknown command '%s'\n", cmd); }
  }
}

void init_sdb() {
  /* Compile the regular expressions. */
  init_regex();

  /* Initialize the watchpoint pool. */
  init_wp_pool();
}