#ifndef __COMMOM_H__
#define __COMMOM_H__
#include <macro.h>

#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#include <assert.h>
#include <stdlib.h>


typedef uint32_t word_t;
#define FMT_WORD "0x%08x"

typedef word_t vaddr_t;
typedef word_t paddr_t;

#include <debug.h>

#endif