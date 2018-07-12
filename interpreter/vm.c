
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

uint8_t popcnt32(uint32_t r1)  {
    uint32_t temp = r1;
    temp = (temp & 0x55555555) + ((temp >> 1) & 0x55555555);
    temp = (temp & 0x33333333) + ((temp >> 2) & 0x33333333);
    temp = (temp & 0x0f0f0f0f) + ((temp >> 4) & 0x0f0f0f0f);
    temp = (temp & 0x00ff00ff) + ((temp >> 8) & 0x00ff00ff);
    temp = (temp & 0x0000ffff) + ((temp >> 16) & 0x0000ffff);
    return temp;
}

uint8_t popcnt64(uint64_t r1)  {
    uint64_t temp = r1;
    temp = (temp & 0x5555555555555555) + ((temp >> 1) & 0x5555555555555555);
    temp = (temp & 0x3333333333333333) + ((temp >> 2) & 0x3333333333333333);
    temp = (temp & 0x0f0f0f0f0f0f0f0f) + ((temp >> 4) & 0x0f0f0f0f0f0f0f0f);
    temp = (temp & 0x00ff00ff00ff00ff) + ((temp >> 8) & 0x00ff00ff00ff00ff);
    temp = (temp & 0x0000ffff0000ffff) + ((temp >> 16) & 0x0000ffff0000ffff);
    temp = (temp & 0x00000000ffffffff) + ((temp >> 32) & 0x00000000ffffffff);
    return temp;
}

uint8_t clz32(uint32_t r1) {
    if (r1 == 0) return 32;
    uint32_t temp_r1 = r1;
    uint8_t n = 0;
    if ((temp_r1 & 0xffff0000) == 0) {
      n += 16;
      temp_r1 = temp_r1 << 16;
    }
    if ((temp_r1 & 0xff000000) == 0) {
      n += 8;
      temp_r1 = temp_r1 << 8;
    }
    if ((temp_r1 & 0xf0000000) == 0) {
      n += 4;
      temp_r1 = temp_r1 << 4;
    }
    if ((temp_r1 & 0xc0000000) == 0) {
      n += 2;
      temp_r1 = temp_r1 << 2;
    }
    if ((temp_r1 & 0x8000000) == 0) {
      n++;
    }
    return n;
}

uint8_t clz64(uint64_t r1) {
    if (r1 == 0) return 64;
    uint64_t temp_r1 = r1;
    uint8_t n = 0;
    if ((temp_r1 & 0xffffffff00000000) == 0) {
      n += 32;
      temp_r1 = temp_r1 << 32;
    }
    if ((temp_r1 & 0xffff000000000000) == 0) {
      n += 16;
      temp_r1 == temp_r1 << 16;
    }
    if ((temp_r1 & 0xff00000000000000) == 0) {
      n+= 8;
      temp_r1 = temp_r1 << 8;
    }
    if ((temp_r1 & 0xf000000000000000) == 0) {
      n += 4;
      temp_r1 = temp_r1 << 4;
    }
    if ((temp_r1 & 0xc000000000000000) == 0) {
      n += 2;
      temp_r1 = temp_r1 << 2;
    }
    if ((temp_r1 & 0x8000000000000000) == 0) {
      n += 1;
    }
    return n;
}

uint8_t ctz32(uint32_t r1) {
    if (r1 == 0) return 32;
    uint32_t temp_r1 = r1;
    uint8_t n = 0;
    if ((temp_r1 & 0x0000ffff) == 0) {
      n += 16;
      temp_r1 = temp_r1 >> 16;
    }
    if ((temp_r1 & 0x000000ff) == 0) {
      n += 8;
      temp_r1 = temp_r1 >> 8;
    }
    if ((temp_r1 & 0x0000000f) == 0) {
      n += 4;
      temp_r1 = temp_r1 >> 4;
    }
    if ((temp_r1 & 0x00000003) == 0) {
      n += 2;
      temp_r1 = temp_r1 >> 2;
    }
    if ((temp_r1 & 0x00000001) == 0) {
      n += 1;
    }
    return n;
}

uint8_t ctz64(uint64_t r1) {
    if (r1 == 0) return 64;
    uint64_t temp_r1 = r1;
    uint8_t n = 0;
    if (temp_r1 & 0x00000000ffffffff == 0) {
      n += 32;
      temp_r1 = temp_r1 >> 32;
    }
    if (temp_r1 & 0x000000000000ffff == 0) {
      n += 16;
      temp_r1 = temp_r1 >> 16;
    }
    if (temp_r1 & 0x00000000000000ff == 0) {
      n += 8;
      temp_r1 = temp_r1 >> 8;
    }
    if (temp_r1 & 0x000000000000000f == 0) {
      n += 4;
      temp_r1 = temp_r1 >> 4;
    }
    if (temp_r1 & 0x0000000000000003 == 0) {
      n += 2;
      temp_r1 = temp_r1 >> 2;
    }
    if (temp_r1 & 0x0000000000000001 == 0) {
      n += 1;
    }
    return n;
}

int error_code = 0;

uint8_t tmp_mem[16];

void storeN(uint8_t *mem, uint64_t addr, uint64_t n, uint64_t v) {
    for (int i = 0; i < n; i++) {
            mem[addr+i] = v;
            v = v >> 8;
    }
}

// a and b are integer values that represent 8 bytes each
uint8_t *toMemory(uint64_t a, uint64_t b) {
        storeN(tmp_mem, 0, 8, a);
        storeN(tmp_mem, 8, 8, b);
        return tmp_mem;
}

uint64_t loadN(uint8_t *mem, uint64_t addr, uint64_t n) {
        uint64_t res = 0;
        uint64_t exp = 1;
        for (int i = 0; i < n; i++) {
            // printf("Byte %02x\n", mem[addr+i]);
            res += mem[addr+i]*exp;
            exp = exp << 8;
        }
        return res;
}

uint64_t fromMemory1(uint8_t *mem) {
        return loadN(mem, 0, 8);
}

uint64_t fromMemory2(uint8_t *mem) {
        return loadN(mem, 8, 8);
}

uint64_t typeSize(uint64_t ty) {
        if (ty == 0) return 4; // I32
        else if (ty == 1) return 8; // I64
        else if (ty == 2) return 4; // F32
        else if (ty == 3) return 8; // F64
}

void store(uint8_t *mem, uint64_t addr, uint64_t v, uint64_t ty, uint64_t packing) {
        if (packing == 0) storeN(mem, addr, typeSize(ty), v);
        else {
            // Only integers can be packed, also cannot pack I32 to 32-bit?
            assert(ty < 2 && !(ty == 0 && packing == 4));
            storeN(mem, addr, packing, v);
        }
}

void storeX(uint8_t *mem, uint64_t addr, uint64_t v, uint64_t hint) {
        store(mem, addr, v, (hint >> 3)&0x3, hint&0x7);
}

uint64_t load(uint8_t *mem, uint64_t addr, uint64_t ty, uint64_t packing, uint8_t sign_extend) {
        if (packing == 0) return loadN(mem, addr, typeSize(ty));
        else {
            assert(ty < 2 && !(ty == 0 && packing == 4));
            uint64_t res = loadN(mem, addr, packing);
            if (sign_extend) {
                res = res | (0xffffffffffffffff << (8*packing))*(res >> (8*packing-1));
            }
            if (ty == 0) res = res & 0xffffffff;
            else res = res & 0xffffffffffffffff;
            return res;
        }
}
    
uint64_t loadX(uint8_t *mem, uint64_t addr, uint64_t hint) {
        return load(mem, addr, (hint >> 4)&0x3, (hint >> 1)&0x7, (hint&0x1) == 1);
}

struct vm_t {
  uint64_t reg1;
  uint64_t reg2;
  uint64_t reg3;
  uint64_t ireg;
  
  uint8_t *op;
  
  uint64_t stack_ptr;
  uint64_t call_ptr;
  uint64_t pc;
  uint64_t memsize;
  
  uint64_t *globals;
  uint64_t *stack;
  uint64_t *callstack;
  uint64_t *memory;
  uint64_t *calltable;
  uint64_t *calltypes;
  
  uint64_t *inputsize;
  uint8_t **inputname;
  uint8_t **inputdata;

  uint8_t *code;
};

struct vm_t vm;

void init() {
  vm.globals = malloc(sizeof(uint64_t)*1024);
  vm.stack = malloc(sizeof(uint64_t)*1024*1024*10);
  vm.callstack = malloc(sizeof(uint64_t)*1024*1024);
  vm.memory = malloc(sizeof(uint64_t)*1024*1024*100);
  memset(vm.memory, 0, sizeof(uint64_t)*1024*1024*100);
  vm.calltable = malloc(sizeof(uint64_t)*1024*1024);
  vm.calltypes = malloc(sizeof(uint64_t)*1024*1024);
  
  vm.inputsize = malloc(sizeof(uint64_t)*1024);
  vm.inputname = malloc(sizeof(uint64_t*)*1024);
  vm.inputdata = malloc(sizeof(uint64_t*)*1024);

  vm.stack_ptr = 0;
  vm.call_ptr = 0;
  vm.pc = 0;
  vm.memsize = 1024*100*8;

}

uint8_t *readFile(char *name, uint64_t *sz) {
  FILE *f = fopen(name, "rb");
  fseek(f, 0, SEEK_END);
  long fsize = ftell(f);
  fseek(f, 0, SEEK_SET);  //same as rewind(f);
  
  fprintf(stderr, "Loading file %s: size %d\n", name, (int)fsize);

  uint8_t *res = malloc(fsize);
  fread(res, fsize, 1, f);
  fclose(f);
  
  *sz = fsize;
  
  return res;
}

int main(int argc, char **argv) {
  init();
  // Load code from file
  uint64_t sz = 0;
  // vm.code = readFile("decoded.bin", &sz);

  // Load files to input
  for (int i = 1; i < argc; i++) {
     vm.inputname[i-1] = argv[i];
     vm.inputdata[i-1] = readFile(argv[i], &sz);
     vm.inputsize[i-1] = sz;
  }
     vm.inputname[argc-1] = "";
     vm.inputdata[argc-1] = "";
     vm.inputsize[argc-1] = 0;
  
  uint64_t r1;
  uint64_t r2;
  uint64_t r3;
  uint8_t *tmp;
  
  void **jumptable = malloc(sizeof(void*) * 1024 * 1024 * 10);

#include "compiled.c"

  return 0;
}

