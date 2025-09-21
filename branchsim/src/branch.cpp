#include <branch.h>
#include <common.h>
#include <cassert>
#include <cstring>

#define BITMASK(bits) ((1ull << (bits)) - 1)
#define BITS(x, hi, lo) (((x) >> (lo)) & BITMASK((hi) - (lo) + 1)) // similar to x[hi:lo] in verilog
#define SEXT(x, len) ({ struct { int64_t n : len; } __x = { .n = x }; (uint64_t)__x.n; })

bool BranchPredictor::parse_inst(uint32_t pc, uint32_t i, uint32_t* dest)
{
    int opcode = BITS(i, 6, 0);
    int func3 = BITS(i, 14, 12);
    int64_t immB = ((SEXT((int64_t)BITS(i, 31, 31), 1) << 11) | BITS(i, 7, 7) << 10 | BITS(i, 30 , 25) << 4 | BITS(i , 11 , 8)) << 1;

    int64_t immJ = ((SEXT((int64_t)BITS(i, 31, 31), 1) << 19) | BITS(i, 19, 12) << 11 | BITS(i, 20 , 20) << 10 | BITS(i , 30 , 21)) << 1;
    int64_t immI = SEXT((int64_t)BITS(i, 31, 20), 12);
    switch (opcode)
    {
        case 0b1100111: //jalr
            *dest = 0;
            break;
        case 0b1101111: //jal
            *dest = pc + immJ;
            break;
        case 0b1100011: //b type
            *dest = pc + immB;
            break;
        default:
            return false;
    }
    return true;
}

int BranchPredictor::getIndex(uint32_t pc)
{
    return (pc>>N())&((1<<M())-1); // pc 低两位忽略
}

int BranchPredictor::getTag(uint32_t pc)
{
    return pc>>(M()+N())&((1<<(32-N()-M()))-1);
}

bool BranchPredictor::findBTB(uint32_t pc)
{
    int index = getIndex(pc);
    int tag = getTag(pc);
    if(btb[index].tag == tag){
        return true;
    }
    else{
        return false;
    }
}

void BranchPredictor::updateBTB(uint32_t pc, uint32_t target)
{
    int index = getIndex(pc);
    int tag = getTag(pc);
    if(findBTB(pc)) return;
    btb[index].tag = tag;
    btb[index].target = target;
}

void BranchPredictor::statistic()
{
    log("count           = %lu\n", count);
    log("correct count   = %lu\n", correctCnt);
    log("incorrect count = %lu\n", mispredCnt);
    log("accuracy        = %.2f%%\n", 100.0 * correctCnt / count);
    printf("count           = %lu\n", count);
    printf("correct count   = %lu\n", correctCnt);
    printf("incorrect count = %lu\n", mispredCnt);
    printf("accuracy        = %.2f%%\n", 100.0 * correctCnt / count);
}