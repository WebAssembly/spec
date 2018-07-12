
#include <stdint.h>

extern uint64_t *getStack();
extern uint32_t getStackDepth();
extern void setStack(uint64_t *);

// all stuff should be in our saved stack, so we don't have to worry about that
void merkleizeLoad(uint32_t pc) {
    // perhaps here we should test if we are actually merkleizing it
    // or perhaps we have a top level function that is called for each instruction (probably won't be good, would have to store bytecode somewhere: perhaps give as arg)
    // because can be unaligned, we need two memory loads
    merkleizeCode(pc);
    uint32_t loc = popStack(); // these all will add merkle proofs. they will also generate intermediate states
    uint64_t cell1 = getMemory(loc - loc&0x7);
    uint64_t cell2 = getMemory(loc - loc&0x7 + 8);
    uint64_t res = performLoad(cell1, cell2);
    pushStack(res);
}

