/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <common.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./monitor/sdb/sdb.h"

void init_monitor(int, char *[]);
void am_init_monitor();
void engine_start();
int is_exit_status_bad();

int main(int argc, char *argv[]) {
  /* Initialize the monitor. */
#ifdef CONFIG_TARGET_AM
  am_init_monitor();
#else
  init_monitor(argc, argv);
#endif

  /* Start engine. */
  engine_start();

  FILE *file = fopen("./input.txt", "r");
  if (!file) {
    panic("Failed to open file");
    return 1;
  }

  char line[65536];
  while (fgets(line, sizeof(line), file)) {
    // 去掉换行符
    line[strcspn(line, "\n")] = 0;

    // 分割字符串并处理表达式
    char *result = strtok(line, " ");
    char *e = strtok(line,"\0");
    bool success;
    int eval_result = expr(e,&success);
    if(atoi(result) != eval_result){
      panic("Cal Error");
    }
  }


  return is_exit_status_bad();
}
