
#include <stdlib.h>
#include <stdint.h>

// just a temp defintion
#define EINVAL 1

int inputSize(int);
unsigned char inputName(int, int);
unsigned char inputData(int, int);

void outputSize(int, int);
void outputName(int, int, unsigned char);
void outputData(int, int, unsigned char);

int debugString(char *dta);
int debugBuffer(char *dta, int len);
int debugInt(int c);
int debugSeek(int c);
void debugRead(int c);
int debugReadCount(int c);

// Output to a linked list, not a linear block?
struct piece {
  unsigned char *data;
  int size;
  struct piece *prev;
};

struct system {
  int next_fd;      // the file descriptor for the next file
  int ptr[1024];    /* Pointers to the data blocks for each file descriptor.
    For example if sys->ptr[fd] == 10, then the file data is at sys->file_data[10]
  */
  int pos[1024];    // Location of the file descriptor inside the block
  int closed[1024]; // Keeps track if the file descriptor has been closed

  // These include the input block copied into memory
  struct piece *file_output[1024]; // Linked list of contents of a file, used for output
  unsigned char *file_name[1024];  // File names
  unsigned char *file_data[1024];  // File contents
  int file_size[1024];             // File sizes. Names probably should have some maximum size
  
  int call_record; // File descriptor for call record. Used for generic system calls
};

struct iovec {
  void* iov_base;
  int iov_len;
};

// Global variable that will store our system
struct system *system_ptr;

struct system *getSystem();
void setSystem(struct system *s);

int getNameLength(int ptr) {
  int res = 0;
  while (inputName(ptr, res) != 0) res++;
  return res;
}

int env__getInternalFile(int fd) {
   struct system *s = getSystem();
   return s->ptr[fd];
}

unsigned char *getName(int ptr) {
  int sz = getNameLength(ptr);
  unsigned char *res = malloc(sz+1);
  for (int i = 0; i < sz; i++) res[i] = inputName(ptr, i);
  res[sz] = 0;
  return res;
}

unsigned char *getData(int ptr) {
  int sz = inputSize(ptr);
  unsigned char *res = malloc(sz);
  for (int i = 0; i < sz; i++) res[i] = inputData(ptr, i);
  return res;
}

unsigned char* copyBytes(unsigned char* bytes, int len) {
  unsigned char* res = malloc(len);
  for (int i = 0; i < len; i++) {
    res[i] = bytes[i];
    // debugInt(res[i]);
  }
  return res;
}

int str_eq(unsigned char *s1, unsigned char *s2) {
   while (*s1 == *s2) {
     if (!s1[0] && !s2[0]) return 1;
     s1++;
     s2++;
   }
   return 0;
}

void copyChunk(unsigned char* _source, unsigned char* _destination, int size, int offset) {
  for (int i = 0; i < size; ++i) {
    _destination[i] = _source[offset + i];
  }
}

void addPiece(int idx, unsigned char *bytes, int len) {
  struct piece *p = malloc(sizeof(struct piece));
  struct system *s = getSystem();
  p->prev = s->file_output[idx];
  p->data = copyBytes(bytes, len);
  p->size = len;
  s->file_output[idx] = p;
}

int openFile(unsigned char *name) {
  // No empty names allowed
  if (!name || !name[0]) return -1;
  debugString((char*)name);
  int index = 0;
  struct system *s = getSystem();
  if (!s) return -1;
  while (s->file_name[index]) {
      if (str_eq(s->file_name[index], name)) {
              int fd = s->next_fd;
              s->ptr[fd] = index;
              s->pos[fd] = 0;
              s->closed[fd] = 0;
              s->next_fd++;
              debugInt(fd);
              return fd;
      }
      index++;
  }
  // No such file
  return -1;
}

void initSystem() {
  struct system *s = malloc(sizeof(struct system));
  s->ptr[0] = -1;
  s->ptr[1] = -2;
  s->ptr[2] = -3;
  s->next_fd = 3; // 0:stdin, 1:stdout, 2:stderr
  // Actually we should here have a list of file names?
  // Read input byte by byte, it includes file names and data
  int loc = 0;
  int index = 0;
  int nextLength = getNameLength(index);
  while (nextLength > 0) {
     s->file_output[index] = 0;
     s->file_name[index] = getName(index);
     s->file_size[index] = inputSize(index);
     s->file_data[index] = getData(index);
     index++;
     nextLength = getNameLength(index);
  }
  s->file_name[index] = 0;
  setSystem(s);
  // sys = s;
  unsigned char name[12];
  name[0] = 'r';
  name[1] = 'e';
  name[2] = 'c';
  name[3] = 'o';
  name[4] = 'r';
  name[5] = 'd';
  name[6] = '.';
  name[7] = 'b';
  name[8] = 'i';
  name[9] = 'n';
  name[10] = 0;
  s->call_record = openFile(name);
}

void finalizeSystem() {
  struct system *s = getSystem();
  int index = 0;
  while (s->file_name[index]) {
    // output name
    unsigned char *name = s->file_name[index];
    debugString((char*)name);
    int i = 0;
    while (*name) {
      outputName(index, i, *name);
      name++;
      i++;
    }
    // If there is no output, then output the linear block in case it was changed
    if (!s->file_output[index]) {
      int sz = s->file_size[index];
      outputSize(index, sz);
      debugInt(sz);
      unsigned char *data = s->file_data[index];
      for (int i = 0; i < sz; i++) {
        outputData(index, i, *data);
        data++;
      }
    }
    else {
       // Calculate size
       int sz = 0;
       struct piece *p = s->file_output[index];
       while (p) {
         sz += p->size;
         p = p->prev;
       }
       outputSize(index, sz);
       debugInt(sz);
       p = s->file_output[index];
       while (p) {
         sz -= p->size;
         for (int i = 0; i < p->size; i++) {
           outputData(index, sz+i, p->data[i]);
         }
         p = p->prev;
       }
    }
    index++;
  }
}

void env__internalSync(int fd) {
   finalizeSystem();
}

void env__internalSync2(int index) {
  struct system *s = getSystem();
  s->file_size[index] = inputSize(index);
  s->file_data[index] = getData(index);
  s->file_output[index] = 0;
  debugBuffer((char*)s->file_data[index], s->file_size[index]);
}

// read one byte
int read8(int fd) {
  struct system *s = getSystem();
  int idx = s->ptr[fd];
  int res = s->file_data[idx][s->pos[fd]];
  s->pos[fd]++;
/*  debugString((char*)sys->file_name[idx]);
  debugInt(sys->pos[fd]); */
  return res;
}

uint16_t read16(int fd) {
  uint16_t dummy = 0U;
  dummy |= read8(fd);
  dummy |= read8(fd) << 8U;
  return dummy;
}

uint32_t read32(int fd) {
  uint32_t dummy = 0U;
  dummy |= read16(fd);
  dummy |= read16(fd) << 16U;
  return dummy;
}

uint32_t read64(int fd) {
  uint64_t dummy = 0U;
  dummy |= read32(fd);
  read32(fd);
  // dummy |= (uint64_t)read32(fd) << 32U;
  return dummy;
}

// Ignore the call
void skipCall() {
  struct system *s = getSystem();
  int fd = s->call_record;
  if (fd < 0) return;
  // read args
  int arg_len = read16(fd);
  for (int i = 0; i < arg_len; i++) read64(fd);
  // read memory 8
  int mem8_len = read32(fd);
  for (int i = 0; i < mem8_len; i++) {
    read32(fd);
    read8(fd);
  }
  // read memory 16
  int mem16_len = read32(fd);
  for (int i = 0; i < mem16_len; i++) {
    read32(fd);
    read16(fd);
  }
  // read memory 32
  int mem32_len = read32(fd);
  for (int i = 0; i < mem32_len; i++) {
    read32(fd);
    read32(fd);
  }
  // read returns
  int ret_len = read16(fd);
  for (int i = 0; i < ret_len; i++) read64(fd);
  // Success, position at next system call
}

// Actual handling of calls: first have to drop from stack, so return the number of args
int callArguments() {
  struct system *s = getSystem();
  int fd = s->call_record;
  if (fd < 0) return 0;
  // read args
  int arg_len = read16(fd);
  debugInt(arg_len);
  for (int i = 0; i < arg_len; i++) debugInt(read64(fd));
  return arg_len+1;
}

int callReturns() {
  struct system *s = getSystem();
  int fd = s->call_record;
  if (fd < 0) return 0;
  // read rets
  int rets = read16(fd);
  debugInt(rets);
  return rets;
}

// uint64_t getReturn() {
uint32_t getReturn() {
  struct system *s = getSystem();
  int fd = s->call_record;
  uint32_t x = read64(fd);
  debugInt(x);
  return x;
}

void callMemory() {
  struct system *s = getSystem();
  int fd = s->call_record;
  if (fd < 0) return;
  // read memory 8
  int mem8_len = read32(fd);
  debugInt(mem8_len);
  for (int i = 0; i < mem8_len; i++) {
    int addr = read32(fd);
    int v = read8(fd);
    unsigned char *ptr = (unsigned char*)addr;
    *ptr = (unsigned char)v;
  }
  // read memory 16
  int mem16_len = read32(fd);
  debugInt(mem16_len);
  for (int i = 0; i < mem16_len; i++) {
    int addr = read32(fd)*2;
    int16_t v = read16(fd);
    int16_t *ptr = (int16_t*)addr;
    *ptr = v;
  }
  // read memory 32
  int mem32_len = read32(fd);
  debugInt(mem32_len);
  for (int i = 0; i < mem32_len; i++) {
    int addr = read32(fd)*4;
    int v = read32(fd);
    int *ptr = (int*)addr;
    *ptr = v;
  }
}

// Open file
int env____syscall5(int which, int *varargs) {
  struct system *s = getSystem();
  unsigned char *name = (unsigned char*)varargs[0];
  int flags = varargs[1];
  int mode = varargs[2];
  // No empty names allowed
  if (!name || !name[0]) return -1;
  int index = 0;
  if (!s) return -1;
  while (s->file_name[index]) {
      if (str_eq(s->file_name[index], name)) {
              int fd = s->next_fd;
              s->ptr[fd] = index;
              s->pos[fd] = 0;
              s->closed[fd] = 0;
              s->next_fd++;
              return fd;
      }
      index++;
  }
  // No such file
  return -1;
}

// Seeking
int env____syscall140(int which, int *varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  int offset_high = varargs[1];
  int offset_low = varargs[2];
  int *result = (int*)varargs[3];
  int whence = varargs[4];
  // llseek(stream, offset_low, whence)
  if (whence == 1) {
    s->pos[fd] += offset_low;
  }
  // Maybe this is seeking from end?
  else if (whence == 2) {
    int sz = s->file_size[s->ptr[fd]];
    s->pos[fd] = sz + offset_low;
    debugSeek(offset_low);
  }
  else return -1;
  *result = s->pos[fd];
  if (s->pos[fd] < 0) return -1;
  return 0;
}

unsigned int env__emscripten_memcpy_big(unsigned int dest, unsigned int src, int num) {
  // skipCall();
  unsigned char *src_ptr = (unsigned char*)src;
  unsigned char *dst_ptr = (unsigned char*)dest;
  for (int i = 0; i < num; i++) {
    dst_ptr[i] = src_ptr[i];
  }
  return dest;
}

// Close
int env____syscall6(int which, int *varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  s->closed[fd] = 1;
  return 0;
}

// sysctl
int env____syscall54(int which, int *varargs) {
  return 0;
}

// lock
void env____lock(int which) {
}

void env____unlock(int which) {
}

// Read
int env____syscall3(int which, int *varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  unsigned char *buf = (unsigned char*)varargs[1];
  int count = varargs[2];
  debugInt(3+1000000);
  debugInt(count);
  // read
  int index = s->ptr[fd];
  int pos = s->pos[fd];
  int i;
  for (i = 0; i < count && i+pos < s->file_size[index]; i++) {
    buf[i] = s->file_data[index][pos+i];
    // debugInt(buf[i]);
  }
  s->pos[fd] += i;
  debugInt(i);
  return i;
}

struct stat {
};

// Stat
int env____syscall195(int which, int *varargs) {
  unsigned char *path = (unsigned char*)varargs[0];
  struct stat *stats = (struct stat*)varargs[1];
  // Invent some stats
  debugString((char*)path);
  return -1;
}

// Write
int env____syscall146(int which, int *varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  debugInt(146+1000000);
  unsigned char *buf = (unsigned char*)varargs[1];
  unsigned int *iov = (unsigned int*)varargs[1];
  int iovcnt = varargs[2];
  int ret = 0;
  for (int i = 0; i < iovcnt; i++) {
    unsigned char *buf = (unsigned char*)iov[i*2];
    int len = (int)iov[i*2 + 1];
    debugBuffer((char*)buf, len);
    ret += len;
    if (s->ptr[fd] < 0) continue;
    addPiece(s->ptr[fd], buf, len);
  }
  return ret;
}

// Write
int env____syscall4(int which, int *varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  unsigned char *buf = (unsigned char*)varargs[1];
  int count = varargs[2];
  debugString((char*)buf);
  if (s->ptr[fd] < 0) return count;
  addPiece(s->ptr[fd], buf, count);
  return count;
}

// ioctl
/*
int env____syscall54(int which, int *varargs) {
  skipCall();
  return -1;
}
*/

// dup
// do we need to check for fd validity?
int env____syscall41(int which, int* varargs) {
  struct system *s = getSystem();
  int oldfd = varargs[0];
  if (oldfd > 1023 || oldfd < 0) {
    return -1;
  }
  int i = 0;
  for (i = 0; i < 1024; ++i) {
    if (s->closed[i]) {
      //copy fd
      s->ptr[i] = s->ptr[oldfd];
      s->pos[i] = s->ptr[oldfd];
      s->closed[i] = s->closed[oldfd];
      s->file_size[i] = s->file_size[oldfd];

      for (int j = 0; j < s->file_size[oldfd]; ++j) {
        s->file_data[i][j] = s->file_data[oldfd][j];
        s->file_name[i][j] = s->file_name[oldfd][j];
      }
    }
  }

  // this means there were no free file descriptors
  if (1023 == i) {
    return -1;
  }
  return 0;
}

// dup2
// we don't have interrupts so atomicity of dup2 is of no concern
int env____syscall63(int which, int* varargs) {
  int oldfd = varargs[0];
  int newfd = varargs[1];
  if (oldfd == newfd) {
    return newfd;
  }
  int* varargs_new = &newfd;
  env____syscall41(which, varargs_new);
  return 0;
}

// dup3
int env____syscall330(int which, int* varargs) {
  int oldfd = varargs[0];
  int newfd = varargs[1];
  int flags = varargs[2];
  if (oldfd == newfd) return EINVAL;
  int varargs_new[2];
  varargs_new[0] = oldfd;
  varargs_new[1] = newfd;
  env____syscall63(which, varargs_new);
  return 0;
}

// readv
int env____syscall145(int which, int* varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  struct iovec *iov = (struct iovec*)varargs[1];
  int iovcnt = (int)varargs[2];
  int total_length = 0;
  debugInt(145+1000000);
  debugInt(iovcnt);
  for (int i = 0; i < iovcnt; ++i) {
    int count = iov[i].iov_len;
    debugInt(count);
    int index = s->ptr[fd];
    int pos = s->pos[fd];
    int j;
    uint8_t *buf = (uint8_t *)iov[i].iov_base;
    for (j = 0; j < count && j+pos < s->file_size[index]; j++) {
      buf[j] = s->file_data[index][pos+j];
    }
    s->pos[fd] += j;
    total_length += j;
  }
  return total_length;
}

// preadv
int env____syscall333(int which, int* varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  struct iovec *iov = (struct iovec*)varargs[1];
  int iovcnt = varargs[2];
  int offset = varargs[3];
  int total_length = offset;
  for (int i = 0; i < iovcnt; ++i) {
    int len = iov[i].iov_len;
    total_length += len;
    if (total_length + offset < s->file_size[fd]) {
      copyChunk(s->file_data[s->ptr[fd]], (unsigned char*)iov[i].iov_base, len, total_length - len);
    } else {
      len = total_length - s->file_size[fd];
      copyChunk(s->file_data[s->ptr[fd]], (unsigned char*)iov[i].iov_base, len, total_length - len);
      return total_length;
    }
  }
  return total_length;
}

// pwritev
int env____syscall334(int which, int* varargs) {
  return 0;
}

// pread64
int env____syscall180(int which, int* varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  unsigned char* buf = (unsigned char*)varargs[1];
  int count = varargs[2];
  int offset = varargs[3];

  int i = 0;
  if (offset + count > s->file_size[fd]) count = offset + count - s->file_size[fd];
  for (i = 0; i < count; ++i) {
    buf[i] = s->file_data[s->ptr[fd]][offset + i];
  }

  return i + 1;
}

// pwrite64
int env____syscall181(int which, int* varargs) {
  struct system *s = getSystem();
  int fd = varargs[0];
  unsigned char* buf = (unsigned char*)varargs[1];
  int count = varargs[2];
  int offset = varargs[3];

  int i = 0;
  for (i = 0; i < count; ++i) {
    s->file_data[s->ptr[fd]][offset + i] = buf[i];
  }

  return i + 1;
}

// openat
int env____syscall295(int which, int* varargs) {
  unsigned char* name = (unsigned char*)varargs[0];
  int dirfd = varargs[1];
  const char* pathname = (const char*)varargs[2];
  int flags = varargs[3];
  int mode = varargs[4];
  // No such file
  return -1;
}

// remove xattr
int env____syscall197(int which, int* varargs) {
  return 0;
}

// fadvice64
int env____syscall221(int which, int* varargs) {
  return 0;
}

int env__pthread_mutex_lock(void *ptr) {
  return 0;
}

int env__pthread_mutex_unlock(void *ptr) {
  return 0;
}

int env__pthread_cond_broadcast(void *ptr) {
  return 0;
}

int env__getenv(void *ptr) {
  return 0;
}

int env____cxa_atexit(int a, int b, int c) {
  return 0;
}



