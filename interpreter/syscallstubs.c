
#ifndef SYSCALL_STUBS
#define SYSCALL_STUBS

#define STUB_GENERATOR(_x1) \
  int env____syscall##_x1(int which, int *varargs) {return 0;}
#define STUB_LIST \
  X(29, "pause") \
  X(34, "nice") \
  X(35, "sync") \
  X(42, "pipe") \
  X(51, "acct") \
  X(66, "setsid") \
  X(75, "setrlimit") \
  X(96, "getpriority") \
  X(97, "setpriority") \
  X(104, "setitimer") \
  X(114, "wait4") \
  X(118, "fsync") \
  X(121, "setdomainname") \
  X(125, "mprotect") \
  X(148, "fdatasync") \
  X(150, "mlock") \
  X(151, "munlock") \
  X(152, "mlockall") \
  X(153, "munlockall") \
  X(163, "mremap") \
  X(199, "getuid32") \
  X(200, "getgid32") \
  X(201, "geteuid32") \
  X(202, "getgid32") \
  X(203, "setreuid32") \
  X(204, "setregid32") \
  X(213, "setuid32") \
  X(214, "getuid32") \
  X(218, "mincore") \
  X(219, "madvise") \
  X(265, "clock_nanosleep") \
  X(272, "fadvise64") \
  X(299, "futimesat") \
  X(303, "linkat") \
  X(308, "pselect") \
  X(331, "pipe2")
#define X(_x1, _x2) STUB_GENERATOR(_x1)
STUB_LIST
#undef X
#undef STUB_LIST
#undef STUB_GENERATOR

// not sure how we would want to handle skipped sys calls so i added these here
// until we decide
#define SKIP_GENERATOR(_x1) ;
#define SKIP_LIST \
  X(20, "getpid") \
  X(55, "setpgid") \
  X(64, "getpid") \
  X(65, "getpgrp") \
  X(77, "getrusage") \
  X(102, "socketcall") \
  X(122, "uname") \
  X(132, "getpgid") \
  X(147, "getsid") \
  X(191, "ugetrlimit") \
  X(195, "stat64") \
  X(196, "fstat64") \
  X(197, "fstat64") \
  X(205, "getgroups32") \
  X(208, "setresuid32") \
  X(210, "setresguid32") \
  X(209, "getresuid") \
  X(211, "getresgid") \
  X(268, "statfs64") \
  X(269, "fstatfs64") \
  X(300, "fstatat") \
  X(320, "utimensat") \
  X(340, "prlimit64")
#define X(_x1, _x2) SKIP_GENERATOR(_x1)
SKIP_LIST
#undef X
#undef SKIP_LIST
#undef SKIP_GENERATOR

#endif
