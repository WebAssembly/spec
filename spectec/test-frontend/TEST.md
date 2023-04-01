# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l)
watsup 0.3 generator
== Parsing...
== Elaboration...
[elab 2-aux.watsup:5.10-5.19] (valtype)  :  (valtype)
[elab 2-aux.watsup:5.11-5.18] valtype  :  (valtype)
[elab 2-aux.watsup:6.10-6.15] (I32)  :  (valtype)
[elab 2-aux.watsup:6.11-6.14] I32  :  (valtype)
[notation 2-aux.watsup:6.11-6.14] {}  :  {}
[elab 2-aux.watsup:6.18-6.20] 32  :  nat
[elab 2-aux.watsup:7.10-7.15] (I64)  :  (valtype)
[elab 2-aux.watsup:7.11-7.14] I64  :  (valtype)
[notation 2-aux.watsup:7.11-7.14] {}  :  {}
[elab 2-aux.watsup:7.18-7.20] 64  :  nat
[elab 2-aux.watsup:8.10-8.15] (F32)  :  (valtype)
[elab 2-aux.watsup:8.11-8.14] F32  :  (valtype)
[notation 2-aux.watsup:8.11-8.14] {}  :  {}
[elab 2-aux.watsup:8.18-8.20] 32  :  nat
[elab 2-aux.watsup:9.10-9.15] (F64)  :  (valtype)
[elab 2-aux.watsup:9.11-9.14] F64  :  (valtype)
[notation 2-aux.watsup:9.11-9.14] {}  :  {}
[elab 2-aux.watsup:9.18-9.20] 64  :  nat
[elab 2-aux.watsup:10.10-10.16] (V128)  :  (valtype)
[elab 2-aux.watsup:10.11-10.15] V128  :  (valtype)
[notation 2-aux.watsup:10.11-10.15] {}  :  {}
[elab 2-aux.watsup:10.19-10.22] 128  :  nat
[elab 2-aux.watsup:15.22-15.34] (n_3_ATOM_y)  :  (n)
[elab 2-aux.watsup:15.23-15.33] n_3_ATOM_y  :  (n)
[elab 2-aux.watsup:16.22-16.34] (n_3_ATOM_y)  :  (n)
[elab 2-aux.watsup:16.23-16.33] n_3_ATOM_y  :  (n)
[elab 2-aux.watsup:16.37-16.38] 0  :  nat
[elab 2-aux.watsup:18.14-18.20] (n, n)  :  (n, n)
[elab 2-aux.watsup:18.15-18.16] n  :  n
[elab 2-aux.watsup:18.18-18.19] n  :  n
[elab 2-aux.watsup:19.14-19.24] (n_1, n_2)  :  (n, n)
[elab 2-aux.watsup:19.15-19.18] n_1  :  n
[elab 2-aux.watsup:19.20-19.23] n_2  :  n
[elab 2-aux.watsup:19.27-19.39] n_1 + n_2  :  nat
[elab 2-aux.watsup:19.29-19.32] n_1  :  nat
[elab 2-aux.watsup:19.35-19.38] n_2  :  nat
[notation 3-typing.watsup:23.3-23.23] {} |- `[n_1 .. n_2] : k  :  {} |- limits : nat
[notation 3-typing.watsup:23.3-23.5] {}  :  {}
[notation 3-typing.watsup:23.6-23.23] `[n_1 .. n_2] : k  :  limits : nat
[notation 3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  limits
[elab 3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  limits
[notation 3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  `[u32 .. u32]
[notation 3-typing.watsup:23.8-23.18] n_1 .. n_2  :  u32 .. u32
[notation 3-typing.watsup:23.8-23.11] n_1  :  u32
[elab 3-typing.watsup:23.8-23.11] n_1  :  u32
[notation 3-typing.watsup:23.15-23.18] n_2  :  u32
[elab 3-typing.watsup:23.15-23.18] n_2  :  u32
[notation 3-typing.watsup:23.22-23.23] k  :  nat
[elab 3-typing.watsup:23.22-23.23] k  :  nat
[elab 3-typing.watsup:24.9-24.24] n_1 <= n_2 <= k  :  bool
[elab 3-typing.watsup:24.9-24.12] n_1  :  nat
[elab 3-typing.watsup:24.16-24.19] n_2  :  nat
[elab 3-typing.watsup:24.16-24.24] n_2 <= k  :  bool
[elab 3-typing.watsup:24.16-24.19] n_2  :  nat
[elab 3-typing.watsup:24.23-24.24] k  :  nat
[notation 3-typing.watsup:27.3-27.13] {} |- ft : OK  :  {} |- functype : OK
[notation 3-typing.watsup:27.3-27.5] {}  :  {}
[notation 3-typing.watsup:27.6-27.13] ft : OK  :  functype : OK
[notation 3-typing.watsup:27.6-27.8] ft  :  functype
[elab 3-typing.watsup:27.6-27.8] ft  :  functype
[notation 3-typing.watsup:27.11-27.13] OK  :  OK
[notation 3-typing.watsup:30.3-30.13] {} |- gt : OK  :  {} |- globaltype : OK
[notation 3-typing.watsup:30.3-30.5] {}  :  {}
[notation 3-typing.watsup:30.6-30.13] gt : OK  :  globaltype : OK
[notation 3-typing.watsup:30.6-30.8] gt  :  globaltype
[elab 3-typing.watsup:30.6-30.8] gt  :  globaltype
[notation 3-typing.watsup:30.11-30.13] OK  :  OK
[notation 3-typing.watsup:33.3-33.17] {} |- {lim rt} : OK  :  {} |- tabletype : OK
[notation 3-typing.watsup:33.3-33.5] {}  :  {}
[notation 3-typing.watsup:33.6-33.17] {lim rt} : OK  :  tabletype : OK
[notation 3-typing.watsup:33.6-33.12] {lim rt}  :  tabletype
[elab 3-typing.watsup:33.6-33.12] {lim rt}  :  tabletype
[notation 3-typing.watsup:33.6-33.12] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:33.6-33.9] lim  :  limits
[elab 3-typing.watsup:33.6-33.9] lim  :  limits
[notation 3-typing.watsup:33.6-33.12] {rt}  :  {reftype}
[notation 3-typing.watsup:33.10-33.12] rt  :  reftype
[elab 3-typing.watsup:33.10-33.12] rt  :  reftype
[notation 3-typing.watsup:33.6-33.12] {}  :  {}
[notation 3-typing.watsup:33.15-33.17] OK  :  OK
[notation 3-typing.watsup:34.17-34.35] {} |- lim : 2 ^ 32 - 1  :  {} |- limits : nat
[notation 3-typing.watsup:34.17-34.19] {}  :  {}
[notation 3-typing.watsup:34.20-34.35] lim : 2 ^ 32 - 1  :  limits : nat
[notation 3-typing.watsup:34.20-34.23] lim  :  limits
[elab 3-typing.watsup:34.20-34.23] lim  :  limits
[notation 3-typing.watsup:34.26-34.35] 2 ^ 32 - 1  :  nat
[elab 3-typing.watsup:34.26-34.35] 2 ^ 32 - 1  :  nat
[elab 3-typing.watsup:34.28-34.32] 2 ^ 32  :  nat
[elab 3-typing.watsup:34.28-34.29] 2  :  nat
[elab 3-typing.watsup:34.30-34.32] 32  :  nat
[elab 3-typing.watsup:34.33-34.34] 1  :  nat
[notation 3-typing.watsup:37.3-37.17] {} |- {lim I8} : OK  :  {} |- memtype : OK
[notation 3-typing.watsup:37.3-37.5] {}  :  {}
[notation 3-typing.watsup:37.6-37.17] {lim I8} : OK  :  memtype : OK
[notation 3-typing.watsup:37.6-37.12] {lim I8}  :  memtype
[elab 3-typing.watsup:37.6-37.12] {lim I8}  :  memtype
[notation 3-typing.watsup:37.6-37.12] {lim I8}  :  {limits I8}
[notation 3-typing.watsup:37.6-37.9] lim  :  limits
[elab 3-typing.watsup:37.6-37.9] lim  :  limits
[notation 3-typing.watsup:37.6-37.12] {I8}  :  {I8}
[notation 3-typing.watsup:37.10-37.12] I8  :  I8
[notation 3-typing.watsup:37.6-37.12] {}  :  {}
[notation 3-typing.watsup:37.15-37.17] OK  :  OK
[notation 3-typing.watsup:38.17-38.33] {} |- lim : 2 ^ 16  :  {} |- limits : nat
[notation 3-typing.watsup:38.17-38.19] {}  :  {}
[notation 3-typing.watsup:38.20-38.33] lim : 2 ^ 16  :  limits : nat
[notation 3-typing.watsup:38.20-38.23] lim  :  limits
[elab 3-typing.watsup:38.20-38.23] lim  :  limits
[notation 3-typing.watsup:38.26-38.33] 2 ^ 16  :  nat
[elab 3-typing.watsup:38.26-38.33] 2 ^ 16  :  nat
[elab 3-typing.watsup:38.28-38.29] 2  :  nat
[elab 3-typing.watsup:38.30-38.32] 16  :  nat
[notation 3-typing.watsup:42.3-42.24] {} |- {FUNC functype} : OK  :  {} |- externtype : OK
[notation 3-typing.watsup:42.3-42.5] {}  :  {}
[notation 3-typing.watsup:42.6-42.24] {FUNC functype} : OK  :  externtype : OK
[notation 3-typing.watsup:42.6-42.19] {FUNC functype}  :  externtype
[elab 3-typing.watsup:42.6-42.19] {FUNC functype}  :  externtype
[notation 3-typing.watsup:42.6-42.19] {functype}  :  {functype}
[notation 3-typing.watsup:42.11-42.19] functype  :  functype
[elab 3-typing.watsup:42.11-42.19] functype  :  functype
[notation 3-typing.watsup:42.6-42.19] {}  :  {}
[notation 3-typing.watsup:42.22-42.24] OK  :  OK
[notation 3-typing.watsup:43.19-43.35] {} |- functype : OK  :  {} |- functype : OK
[notation 3-typing.watsup:43.19-43.21] {}  :  {}
[notation 3-typing.watsup:43.22-43.35] functype : OK  :  functype : OK
[notation 3-typing.watsup:43.22-43.30] functype  :  functype
[elab 3-typing.watsup:43.22-43.30] functype  :  functype
[notation 3-typing.watsup:43.33-43.35] OK  :  OK
[notation 3-typing.watsup:46.3-46.28] {} |- {GLOBAL globaltype} : OK  :  {} |- externtype : OK
[notation 3-typing.watsup:46.3-46.5] {}  :  {}
[notation 3-typing.watsup:46.6-46.28] {GLOBAL globaltype} : OK  :  externtype : OK
[notation 3-typing.watsup:46.6-46.23] {GLOBAL globaltype}  :  externtype
[elab 3-typing.watsup:46.6-46.23] {GLOBAL globaltype}  :  externtype
[notation 3-typing.watsup:46.6-46.23] {globaltype}  :  {globaltype}
[notation 3-typing.watsup:46.13-46.23] globaltype  :  globaltype
[elab 3-typing.watsup:46.13-46.23] globaltype  :  globaltype
[notation 3-typing.watsup:46.6-46.23] {}  :  {}
[notation 3-typing.watsup:46.26-46.28] OK  :  OK
[notation 3-typing.watsup:47.21-47.39] {} |- globaltype : OK  :  {} |- globaltype : OK
[notation 3-typing.watsup:47.21-47.23] {}  :  {}
[notation 3-typing.watsup:47.24-47.39] globaltype : OK  :  globaltype : OK
[notation 3-typing.watsup:47.24-47.34] globaltype  :  globaltype
[elab 3-typing.watsup:47.24-47.34] globaltype  :  globaltype
[notation 3-typing.watsup:47.37-47.39] OK  :  OK
[notation 3-typing.watsup:50.3-50.26] {} |- {TABLE tabletype} : OK  :  {} |- externtype : OK
[notation 3-typing.watsup:50.3-50.5] {}  :  {}
[notation 3-typing.watsup:50.6-50.26] {TABLE tabletype} : OK  :  externtype : OK
[notation 3-typing.watsup:50.6-50.21] {TABLE tabletype}  :  externtype
[elab 3-typing.watsup:50.6-50.21] {TABLE tabletype}  :  externtype
[notation 3-typing.watsup:50.6-50.21] {tabletype}  :  {tabletype}
[notation 3-typing.watsup:50.12-50.21] tabletype  :  tabletype
[elab 3-typing.watsup:50.12-50.21] tabletype  :  tabletype
[notation 3-typing.watsup:50.6-50.21] {}  :  {}
[notation 3-typing.watsup:50.24-50.26] OK  :  OK
[notation 3-typing.watsup:51.20-51.37] {} |- tabletype : OK  :  {} |- tabletype : OK
[notation 3-typing.watsup:51.20-51.22] {}  :  {}
[notation 3-typing.watsup:51.23-51.37] tabletype : OK  :  tabletype : OK
[notation 3-typing.watsup:51.23-51.32] tabletype  :  tabletype
[elab 3-typing.watsup:51.23-51.32] tabletype  :  tabletype
[notation 3-typing.watsup:51.35-51.37] OK  :  OK
[notation 3-typing.watsup:54.3-54.25] {} |- {MEMORY memtype} : OK  :  {} |- externtype : OK
[notation 3-typing.watsup:54.3-54.5] {}  :  {}
[notation 3-typing.watsup:54.6-54.25] {MEMORY memtype} : OK  :  externtype : OK
[notation 3-typing.watsup:54.6-54.20] {MEMORY memtype}  :  externtype
[elab 3-typing.watsup:54.6-54.20] {MEMORY memtype}  :  externtype
[notation 3-typing.watsup:54.6-54.20] {memtype}  :  {memtype}
[notation 3-typing.watsup:54.13-54.20] memtype  :  memtype
[elab 3-typing.watsup:54.13-54.20] memtype  :  memtype
[notation 3-typing.watsup:54.6-54.20] {}  :  {}
[notation 3-typing.watsup:54.23-54.25] OK  :  OK
[notation 3-typing.watsup:55.18-55.33] {} |- memtype : OK  :  {} |- memtype : OK
[notation 3-typing.watsup:55.18-55.20] {}  :  {}
[notation 3-typing.watsup:55.21-55.33] memtype : OK  :  memtype : OK
[notation 3-typing.watsup:55.21-55.28] memtype  :  memtype
[elab 3-typing.watsup:55.21-55.28] memtype  :  memtype
[notation 3-typing.watsup:55.31-55.33] OK  :  OK
[notation 3-typing.watsup:65.3-65.12] {} |- t <: t  :  {} |- valtype <: valtype
[notation 3-typing.watsup:65.3-65.5] {}  :  {}
[notation 3-typing.watsup:65.6-65.12] t <: t  :  valtype <: valtype
[notation 3-typing.watsup:65.6-65.7] t  :  valtype
[elab 3-typing.watsup:65.6-65.7] t  :  valtype
[notation 3-typing.watsup:65.11-65.12] t  :  valtype
[elab 3-typing.watsup:65.11-65.12] t  :  valtype
[notation 3-typing.watsup:68.3-68.14] {} |- BOT <: t  :  {} |- valtype <: valtype
[notation 3-typing.watsup:68.3-68.5] {}  :  {}
[notation 3-typing.watsup:68.6-68.14] BOT <: t  :  valtype <: valtype
[notation 3-typing.watsup:68.6-68.9] BOT  :  valtype
[elab 3-typing.watsup:68.6-68.9] BOT  :  valtype
[notation 3-typing.watsup:68.6-68.9] {}  :  {}
[notation 3-typing.watsup:68.13-68.14] t  :  valtype
[elab 3-typing.watsup:68.13-68.14] t  :  valtype
[notation 3-typing.watsup:71.3-71.18] {} |- t_1* <: t_2*  :  {} |- valtype* <: valtype*
[notation 3-typing.watsup:71.3-71.5] {}  :  {}
[notation 3-typing.watsup:71.6-71.18] t_1* <: t_2*  :  valtype* <: valtype*
[notation 3-typing.watsup:71.6-71.10] t_1*  :  valtype*
[notation 3-typing.watsup:71.6-71.9] t_1  :  valtype
[elab 3-typing.watsup:71.6-71.9] t_1  :  valtype
[notation 3-typing.watsup:71.14-71.18] t_2*  :  valtype*
[notation 3-typing.watsup:71.14-71.17] t_2  :  valtype
[elab 3-typing.watsup:71.14-71.17] t_2  :  valtype
[notation 3-typing.watsup:72.20-72.33] {} |- t_1 <: t_2  :  {} |- valtype <: valtype
[notation 3-typing.watsup:72.20-72.22] {}  :  {}
[notation 3-typing.watsup:72.23-72.33] t_1 <: t_2  :  valtype <: valtype
[notation 3-typing.watsup:72.23-72.26] t_1  :  valtype
[elab 3-typing.watsup:72.23-72.26] t_1  :  valtype
[notation 3-typing.watsup:72.30-72.33] t_2  :  valtype
[elab 3-typing.watsup:72.30-72.33] t_2  :  valtype
[notation 3-typing.watsup:84.3-84.40] {} |- `[n_11 .. n_12] <: `[n_21 .. n_22]  :  {} |- limits <: limits
[notation 3-typing.watsup:84.3-84.5] {}  :  {}
[notation 3-typing.watsup:84.6-84.40] `[n_11 .. n_12] <: `[n_21 .. n_22]  :  limits <: limits
[notation 3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  limits
[elab 3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  limits
[notation 3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  `[u32 .. u32]
[notation 3-typing.watsup:84.8-84.20] n_11 .. n_12  :  u32 .. u32
[notation 3-typing.watsup:84.8-84.12] n_11  :  u32
[elab 3-typing.watsup:84.8-84.12] n_11  :  u32
[notation 3-typing.watsup:84.16-84.20] n_12  :  u32
[elab 3-typing.watsup:84.16-84.20] n_12  :  u32
[notation 3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  limits
[elab 3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  limits
[notation 3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  `[u32 .. u32]
[notation 3-typing.watsup:84.27-84.39] n_21 .. n_22  :  u32 .. u32
[notation 3-typing.watsup:84.27-84.31] n_21  :  u32
[elab 3-typing.watsup:84.27-84.31] n_21  :  u32
[notation 3-typing.watsup:84.35-84.39] n_22  :  u32
[elab 3-typing.watsup:84.35-84.39] n_22  :  u32
[elab 3-typing.watsup:85.9-85.21] n_11 >= n_21  :  bool
[elab 3-typing.watsup:85.9-85.13] n_11  :  nat
[elab 3-typing.watsup:85.17-85.21] n_21  :  nat
[elab 3-typing.watsup:86.9-86.21] n_12 <= n_22  :  bool
[elab 3-typing.watsup:86.9-86.13] n_12  :  nat
[elab 3-typing.watsup:86.17-86.21] n_22  :  nat
[notation 3-typing.watsup:89.3-89.14] {} |- ft <: ft  :  {} |- functype <: functype
[notation 3-typing.watsup:89.3-89.5] {}  :  {}
[notation 3-typing.watsup:89.6-89.14] ft <: ft  :  functype <: functype
[notation 3-typing.watsup:89.6-89.8] ft  :  functype
[elab 3-typing.watsup:89.6-89.8] ft  :  functype
[notation 3-typing.watsup:89.12-89.14] ft  :  functype
[elab 3-typing.watsup:89.12-89.14] ft  :  functype
[notation 3-typing.watsup:92.3-92.14] {} |- gt <: gt  :  {} |- globaltype <: globaltype
[notation 3-typing.watsup:92.3-92.5] {}  :  {}
[notation 3-typing.watsup:92.6-92.14] gt <: gt  :  globaltype <: globaltype
[notation 3-typing.watsup:92.6-92.8] gt  :  globaltype
[elab 3-typing.watsup:92.6-92.8] gt  :  globaltype
[notation 3-typing.watsup:92.12-92.14] gt  :  globaltype
[elab 3-typing.watsup:92.12-92.14] gt  :  globaltype
[notation 3-typing.watsup:95.3-95.26] {} |- {lim_1 rt} <: {lim_2 rt}  :  {} |- tabletype <: tabletype
[notation 3-typing.watsup:95.3-95.5] {}  :  {}
[notation 3-typing.watsup:95.6-95.26] {lim_1 rt} <: {lim_2 rt}  :  tabletype <: tabletype
[notation 3-typing.watsup:95.6-95.14] {lim_1 rt}  :  tabletype
[elab 3-typing.watsup:95.6-95.14] {lim_1 rt}  :  tabletype
[notation 3-typing.watsup:95.6-95.14] {lim_1 rt}  :  {limits reftype}
[notation 3-typing.watsup:95.6-95.11] lim_1  :  limits
[elab 3-typing.watsup:95.6-95.11] lim_1  :  limits
[notation 3-typing.watsup:95.6-95.14] {rt}  :  {reftype}
[notation 3-typing.watsup:95.12-95.14] rt  :  reftype
[elab 3-typing.watsup:95.12-95.14] rt  :  reftype
[notation 3-typing.watsup:95.6-95.14] {}  :  {}
[notation 3-typing.watsup:95.18-95.26] {lim_2 rt}  :  tabletype
[elab 3-typing.watsup:95.18-95.26] {lim_2 rt}  :  tabletype
[notation 3-typing.watsup:95.18-95.26] {lim_2 rt}  :  {limits reftype}
[notation 3-typing.watsup:95.18-95.23] lim_2  :  limits
[elab 3-typing.watsup:95.18-95.23] lim_2  :  limits
[notation 3-typing.watsup:95.18-95.26] {rt}  :  {reftype}
[notation 3-typing.watsup:95.24-95.26] rt  :  reftype
[elab 3-typing.watsup:95.24-95.26] rt  :  reftype
[notation 3-typing.watsup:95.18-95.26] {}  :  {}
[notation 3-typing.watsup:96.18-96.35] {} |- lim_1 <: lim_2  :  {} |- limits <: limits
[notation 3-typing.watsup:96.18-96.20] {}  :  {}
[notation 3-typing.watsup:96.21-96.35] lim_1 <: lim_2  :  limits <: limits
[notation 3-typing.watsup:96.21-96.26] lim_1  :  limits
[elab 3-typing.watsup:96.21-96.26] lim_1  :  limits
[notation 3-typing.watsup:96.30-96.35] lim_2  :  limits
[elab 3-typing.watsup:96.30-96.35] lim_2  :  limits
[notation 3-typing.watsup:99.3-99.26] {} |- {lim_1 I8} <: {lim_2 I8}  :  {} |- memtype <: memtype
[notation 3-typing.watsup:99.3-99.5] {}  :  {}
[notation 3-typing.watsup:99.6-99.26] {lim_1 I8} <: {lim_2 I8}  :  memtype <: memtype
[notation 3-typing.watsup:99.6-99.14] {lim_1 I8}  :  memtype
[elab 3-typing.watsup:99.6-99.14] {lim_1 I8}  :  memtype
[notation 3-typing.watsup:99.6-99.14] {lim_1 I8}  :  {limits I8}
[notation 3-typing.watsup:99.6-99.11] lim_1  :  limits
[elab 3-typing.watsup:99.6-99.11] lim_1  :  limits
[notation 3-typing.watsup:99.6-99.14] {I8}  :  {I8}
[notation 3-typing.watsup:99.12-99.14] I8  :  I8
[notation 3-typing.watsup:99.6-99.14] {}  :  {}
[notation 3-typing.watsup:99.18-99.26] {lim_2 I8}  :  memtype
[elab 3-typing.watsup:99.18-99.26] {lim_2 I8}  :  memtype
[notation 3-typing.watsup:99.18-99.26] {lim_2 I8}  :  {limits I8}
[notation 3-typing.watsup:99.18-99.23] lim_2  :  limits
[elab 3-typing.watsup:99.18-99.23] lim_2  :  limits
[notation 3-typing.watsup:99.18-99.26] {I8}  :  {I8}
[notation 3-typing.watsup:99.24-99.26] I8  :  I8
[notation 3-typing.watsup:99.18-99.26] {}  :  {}
[notation 3-typing.watsup:100.18-100.35] {} |- lim_1 <: lim_2  :  {} |- limits <: limits
[notation 3-typing.watsup:100.18-100.20] {}  :  {}
[notation 3-typing.watsup:100.21-100.35] lim_1 <: lim_2  :  limits <: limits
[notation 3-typing.watsup:100.21-100.26] lim_1  :  limits
[elab 3-typing.watsup:100.21-100.26] lim_1  :  limits
[notation 3-typing.watsup:100.30-100.35] lim_2  :  limits
[elab 3-typing.watsup:100.30-100.35] lim_2  :  limits
[notation 3-typing.watsup:104.3-104.28] {} |- {FUNC ft_1} <: {FUNC ft_2}  :  {} |- externtype <: externtype
[notation 3-typing.watsup:104.3-104.5] {}  :  {}
[notation 3-typing.watsup:104.6-104.28] {FUNC ft_1} <: {FUNC ft_2}  :  externtype <: externtype
[notation 3-typing.watsup:104.6-104.15] {FUNC ft_1}  :  externtype
[elab 3-typing.watsup:104.6-104.15] {FUNC ft_1}  :  externtype
[notation 3-typing.watsup:104.6-104.15] {ft_1}  :  {functype}
[notation 3-typing.watsup:104.11-104.15] ft_1  :  functype
[elab 3-typing.watsup:104.11-104.15] ft_1  :  functype
[notation 3-typing.watsup:104.6-104.15] {}  :  {}
[notation 3-typing.watsup:104.19-104.28] {FUNC ft_2}  :  externtype
[elab 3-typing.watsup:104.19-104.28] {FUNC ft_2}  :  externtype
[notation 3-typing.watsup:104.19-104.28] {ft_2}  :  {functype}
[notation 3-typing.watsup:104.24-104.28] ft_2  :  functype
[elab 3-typing.watsup:104.24-104.28] ft_2  :  functype
[notation 3-typing.watsup:104.19-104.28] {}  :  {}
[notation 3-typing.watsup:105.20-105.35] {} |- ft_1 <: ft_2  :  {} |- functype <: functype
[notation 3-typing.watsup:105.20-105.22] {}  :  {}
[notation 3-typing.watsup:105.23-105.35] ft_1 <: ft_2  :  functype <: functype
[notation 3-typing.watsup:105.23-105.27] ft_1  :  functype
[elab 3-typing.watsup:105.23-105.27] ft_1  :  functype
[notation 3-typing.watsup:105.31-105.35] ft_2  :  functype
[elab 3-typing.watsup:105.31-105.35] ft_2  :  functype
[notation 3-typing.watsup:108.3-108.32] {} |- {GLOBAL gt_1} <: {GLOBAL gt_2}  :  {} |- externtype <: externtype
[notation 3-typing.watsup:108.3-108.5] {}  :  {}
[notation 3-typing.watsup:108.6-108.32] {GLOBAL gt_1} <: {GLOBAL gt_2}  :  externtype <: externtype
[notation 3-typing.watsup:108.6-108.17] {GLOBAL gt_1}  :  externtype
[elab 3-typing.watsup:108.6-108.17] {GLOBAL gt_1}  :  externtype
[notation 3-typing.watsup:108.6-108.17] {gt_1}  :  {globaltype}
[notation 3-typing.watsup:108.13-108.17] gt_1  :  globaltype
[elab 3-typing.watsup:108.13-108.17] gt_1  :  globaltype
[notation 3-typing.watsup:108.6-108.17] {}  :  {}
[notation 3-typing.watsup:108.21-108.32] {GLOBAL gt_2}  :  externtype
[elab 3-typing.watsup:108.21-108.32] {GLOBAL gt_2}  :  externtype
[notation 3-typing.watsup:108.21-108.32] {gt_2}  :  {globaltype}
[notation 3-typing.watsup:108.28-108.32] gt_2  :  globaltype
[elab 3-typing.watsup:108.28-108.32] gt_2  :  globaltype
[notation 3-typing.watsup:108.21-108.32] {}  :  {}
[notation 3-typing.watsup:109.22-109.37] {} |- gt_1 <: gt_2  :  {} |- globaltype <: globaltype
[notation 3-typing.watsup:109.22-109.24] {}  :  {}
[notation 3-typing.watsup:109.25-109.37] gt_1 <: gt_2  :  globaltype <: globaltype
[notation 3-typing.watsup:109.25-109.29] gt_1  :  globaltype
[elab 3-typing.watsup:109.25-109.29] gt_1  :  globaltype
[notation 3-typing.watsup:109.33-109.37] gt_2  :  globaltype
[elab 3-typing.watsup:109.33-109.37] gt_2  :  globaltype
[notation 3-typing.watsup:112.3-112.30] {} |- {TABLE tt_1} <: {TABLE tt_2}  :  {} |- externtype <: externtype
[notation 3-typing.watsup:112.3-112.5] {}  :  {}
[notation 3-typing.watsup:112.6-112.30] {TABLE tt_1} <: {TABLE tt_2}  :  externtype <: externtype
[notation 3-typing.watsup:112.6-112.16] {TABLE tt_1}  :  externtype
[elab 3-typing.watsup:112.6-112.16] {TABLE tt_1}  :  externtype
[notation 3-typing.watsup:112.6-112.16] {tt_1}  :  {tabletype}
[notation 3-typing.watsup:112.12-112.16] tt_1  :  tabletype
[elab 3-typing.watsup:112.12-112.16] tt_1  :  tabletype
[notation 3-typing.watsup:112.6-112.16] {}  :  {}
[notation 3-typing.watsup:112.20-112.30] {TABLE tt_2}  :  externtype
[elab 3-typing.watsup:112.20-112.30] {TABLE tt_2}  :  externtype
[notation 3-typing.watsup:112.20-112.30] {tt_2}  :  {tabletype}
[notation 3-typing.watsup:112.26-112.30] tt_2  :  tabletype
[elab 3-typing.watsup:112.26-112.30] tt_2  :  tabletype
[notation 3-typing.watsup:112.20-112.30] {}  :  {}
[notation 3-typing.watsup:113.21-113.36] {} |- tt_1 <: tt_2  :  {} |- tabletype <: tabletype
[notation 3-typing.watsup:113.21-113.23] {}  :  {}
[notation 3-typing.watsup:113.24-113.36] tt_1 <: tt_2  :  tabletype <: tabletype
[notation 3-typing.watsup:113.24-113.28] tt_1  :  tabletype
[elab 3-typing.watsup:113.24-113.28] tt_1  :  tabletype
[notation 3-typing.watsup:113.32-113.36] tt_2  :  tabletype
[elab 3-typing.watsup:113.32-113.36] tt_2  :  tabletype
[notation 3-typing.watsup:116.3-116.32] {} |- {MEMORY mt_1} <: {MEMORY mt_2}  :  {} |- externtype <: externtype
[notation 3-typing.watsup:116.3-116.5] {}  :  {}
[notation 3-typing.watsup:116.6-116.32] {MEMORY mt_1} <: {MEMORY mt_2}  :  externtype <: externtype
[notation 3-typing.watsup:116.6-116.17] {MEMORY mt_1}  :  externtype
[elab 3-typing.watsup:116.6-116.17] {MEMORY mt_1}  :  externtype
[notation 3-typing.watsup:116.6-116.17] {mt_1}  :  {memtype}
[notation 3-typing.watsup:116.13-116.17] mt_1  :  memtype
[elab 3-typing.watsup:116.13-116.17] mt_1  :  memtype
[notation 3-typing.watsup:116.6-116.17] {}  :  {}
[notation 3-typing.watsup:116.21-116.32] {MEMORY mt_2}  :  externtype
[elab 3-typing.watsup:116.21-116.32] {MEMORY mt_2}  :  externtype
[notation 3-typing.watsup:116.21-116.32] {mt_2}  :  {memtype}
[notation 3-typing.watsup:116.28-116.32] mt_2  :  memtype
[elab 3-typing.watsup:116.28-116.32] mt_2  :  memtype
[notation 3-typing.watsup:116.21-116.32] {}  :  {}
[notation 3-typing.watsup:117.19-117.34] {} |- mt_1 <: mt_2  :  {} |- memtype <: memtype
[notation 3-typing.watsup:117.19-117.21] {}  :  {}
[notation 3-typing.watsup:117.22-117.34] mt_1 <: mt_2  :  memtype <: memtype
[notation 3-typing.watsup:117.22-117.26] mt_1  :  memtype
[elab 3-typing.watsup:117.22-117.26] mt_1  :  memtype
[notation 3-typing.watsup:117.30-117.34] mt_2  :  memtype
[elab 3-typing.watsup:117.30-117.34] mt_2  :  memtype
[notation 3-typing.watsup:129.3-129.19] C |- instr* : t*  :  context |- expr : resulttype
[notation 3-typing.watsup:129.3-129.4] C  :  context
[elab 3-typing.watsup:129.3-129.4] C  :  context
[notation 3-typing.watsup:129.8-129.19] instr* : t*  :  expr : resulttype
[notation 3-typing.watsup:129.8-129.14] instr*  :  expr
[elab 3-typing.watsup:129.8-129.14] instr*  :  expr
[elab 3-typing.watsup:129.8-129.13] instr  :  instr
[notation 3-typing.watsup:129.17-129.19] t*  :  resulttype
[elab 3-typing.watsup:129.17-129.19] t*  :  resulttype
[elab 3-typing.watsup:129.17-129.18] t  :  valtype
[notation 3-typing.watsup:130.19-130.46] C |- instr* : epsilon -> t*  :  context |- instr* : functype
[notation 3-typing.watsup:130.19-130.20] C  :  context
[elab 3-typing.watsup:130.19-130.20] C  :  context
[notation 3-typing.watsup:130.24-130.46] instr* : epsilon -> t*  :  instr* : functype
[notation 3-typing.watsup:130.24-130.30] instr*  :  instr*
[notation 3-typing.watsup:130.24-130.29] instr  :  instr
[elab 3-typing.watsup:130.24-130.29] instr  :  instr
[notation 3-typing.watsup:130.33-130.46] epsilon -> t*  :  functype
[elab 3-typing.watsup:130.33-130.46] epsilon -> t*  :  functype
[notation 3-typing.watsup:130.33-130.46] epsilon -> t*  :  resulttype -> resulttype
[notation 3-typing.watsup:130.33-130.40] epsilon  :  resulttype
[elab 3-typing.watsup:130.33-130.40] epsilon  :  resulttype
[notation 3-typing.watsup:130.44-130.46] t*  :  resulttype
[elab 3-typing.watsup:130.44-130.46] t*  :  resulttype
[elab 3-typing.watsup:130.44-130.45] t  :  valtype
[notation 3-typing.watsup:134.3-134.36] C |- epsilon : epsilon -> epsilon  :  context |- instr* : functype
[notation 3-typing.watsup:134.3-134.4] C  :  context
[elab 3-typing.watsup:134.3-134.4] C  :  context
[notation 3-typing.watsup:134.8-134.36] epsilon : epsilon -> epsilon  :  instr* : functype
[notation 3-typing.watsup:134.8-134.15] epsilon  :  instr*
[niteration 3-typing.watsup:134.8-134.15]   :  instr*
[notation 3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  functype
[elab 3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  functype
[notation 3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:134.18-134.25] epsilon  :  resulttype
[elab 3-typing.watsup:134.18-134.25] epsilon  :  resulttype
[notation 3-typing.watsup:134.29-134.36] epsilon  :  resulttype
[elab 3-typing.watsup:134.29-134.36] epsilon  :  resulttype
[notation 3-typing.watsup:137.3-137.39] C |- {instr_1 instr_2*} : t_1* -> t_3*  :  context |- instr* : functype
[notation 3-typing.watsup:137.3-137.4] C  :  context
[elab 3-typing.watsup:137.3-137.4] C  :  context
[notation 3-typing.watsup:137.8-137.39] {instr_1 instr_2*} : t_1* -> t_3*  :  instr* : functype
[notation 3-typing.watsup:137.8-137.24] {instr_1 instr_2*}  :  instr*
[niteration 3-typing.watsup:137.8-137.24] instr_1 instr_2*  :  instr*
[notation 3-typing.watsup:137.8-137.15] instr_1  :  instr*
[notation 3-typing.watsup:137.8-137.15] instr_1  :  instr
[elab 3-typing.watsup:137.8-137.15] instr_1  :  instr
[niteration 3-typing.watsup:137.8-137.24] instr_2*  :  instr*
[notation 3-typing.watsup:137.16-137.24] instr_2*  :  instr*
[notation 3-typing.watsup:137.16-137.23] instr_2  :  instr
[elab 3-typing.watsup:137.16-137.23] instr_2  :  instr
[niteration 3-typing.watsup:137.8-137.24]   :  instr*
[notation 3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  functype
[elab 3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  functype
[notation 3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  resulttype -> resulttype
[notation 3-typing.watsup:137.27-137.31] t_1*  :  resulttype
[elab 3-typing.watsup:137.27-137.31] t_1*  :  resulttype
[elab 3-typing.watsup:137.27-137.30] t_1  :  valtype
[notation 3-typing.watsup:137.35-137.39] t_3*  :  resulttype
[elab 3-typing.watsup:137.35-137.39] t_3*  :  resulttype
[elab 3-typing.watsup:137.35-137.38] t_3  :  valtype
[notation 3-typing.watsup:138.16-138.43] C |- instr_1 : t_1* -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:138.16-138.17] C  :  context
[elab 3-typing.watsup:138.16-138.17] C  :  context
[notation 3-typing.watsup:138.21-138.43] instr_1 : t_1* -> t_2*  :  instr : functype
[notation 3-typing.watsup:138.21-138.28] instr_1  :  instr
[elab 3-typing.watsup:138.21-138.28] instr_1  :  instr
[notation 3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:138.31-138.35] t_1*  :  resulttype
[elab 3-typing.watsup:138.31-138.35] t_1*  :  resulttype
[elab 3-typing.watsup:138.31-138.34] t_1  :  valtype
[notation 3-typing.watsup:138.39-138.43] t_2*  :  resulttype
[elab 3-typing.watsup:138.39-138.43] t_2*  :  resulttype
[elab 3-typing.watsup:138.39-138.42] t_2  :  valtype
[notation 3-typing.watsup:139.19-139.46] C |- instr_2 : t_2* -> t_3*  :  context |- instr* : functype
[notation 3-typing.watsup:139.19-139.20] C  :  context
[elab 3-typing.watsup:139.19-139.20] C  :  context
[notation 3-typing.watsup:139.24-139.46] instr_2 : t_2* -> t_3*  :  instr* : functype
[notation 3-typing.watsup:139.24-139.31] instr_2  :  instr*
[notation 3-typing.watsup:139.24-139.31] instr_2  :  instr
[elab 3-typing.watsup:139.24-139.31] instr_2  :  instr
[notation 3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  functype
[elab 3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  functype
[notation 3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  resulttype -> resulttype
[notation 3-typing.watsup:139.34-139.38] t_2*  :  resulttype
[elab 3-typing.watsup:139.34-139.38] t_2*  :  resulttype
[elab 3-typing.watsup:139.34-139.37] t_2  :  valtype
[notation 3-typing.watsup:139.42-139.46] t_3*  :  resulttype
[elab 3-typing.watsup:139.42-139.46] t_3*  :  resulttype
[elab 3-typing.watsup:139.42-139.45] t_3  :  valtype
[notation 3-typing.watsup:142.3-142.30] C |- instr* : t'_1 -> t'_2*  :  context |- instr* : functype
[notation 3-typing.watsup:142.3-142.4] C  :  context
[elab 3-typing.watsup:142.3-142.4] C  :  context
[notation 3-typing.watsup:142.8-142.30] instr* : t'_1 -> t'_2*  :  instr* : functype
[notation 3-typing.watsup:142.8-142.14] instr*  :  instr*
[notation 3-typing.watsup:142.8-142.13] instr  :  instr
[elab 3-typing.watsup:142.8-142.13] instr  :  instr
[notation 3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  functype
[elab 3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  functype
[notation 3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:142.17-142.21] t'_1  :  resulttype
[elab 3-typing.watsup:142.17-142.21] t'_1  :  resulttype
[notation 3-typing.watsup:142.25-142.30] t'_2*  :  resulttype
[elab 3-typing.watsup:142.25-142.30] t'_2*  :  resulttype
[elab 3-typing.watsup:142.25-142.29] t'_2  :  valtype
[notation 3-typing.watsup:143.19-143.45] C |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation 3-typing.watsup:143.19-143.20] C  :  context
[elab 3-typing.watsup:143.19-143.20] C  :  context
[notation 3-typing.watsup:143.24-143.45] instr* : t_1* -> t_2*  :  instr* : functype
[notation 3-typing.watsup:143.24-143.30] instr*  :  instr*
[notation 3-typing.watsup:143.24-143.29] instr  :  instr
[elab 3-typing.watsup:143.24-143.29] instr  :  instr
[notation 3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:143.33-143.37] t_1*  :  resulttype
[elab 3-typing.watsup:143.33-143.37] t_1*  :  resulttype
[elab 3-typing.watsup:143.33-143.36] t_1  :  valtype
[notation 3-typing.watsup:143.41-143.45] t_2*  :  resulttype
[elab 3-typing.watsup:143.41-143.45] t_2*  :  resulttype
[elab 3-typing.watsup:143.41-143.44] t_2  :  valtype
[notation 3-typing.watsup:145.18-145.34] {} |- t'_1* <: t_1*  :  {} |- valtype* <: valtype*
[notation 3-typing.watsup:145.18-145.20] {}  :  {}
[notation 3-typing.watsup:145.21-145.34] t'_1* <: t_1*  :  valtype* <: valtype*
[notation 3-typing.watsup:145.21-145.26] t'_1*  :  valtype*
[notation 3-typing.watsup:145.21-145.25] t'_1  :  valtype
[elab 3-typing.watsup:145.21-145.25] t'_1  :  valtype
[notation 3-typing.watsup:145.30-145.34] t_1*  :  valtype*
[notation 3-typing.watsup:145.30-145.33] t_1  :  valtype
[elab 3-typing.watsup:145.30-145.33] t_1  :  valtype
[notation 3-typing.watsup:146.22-146.38] {} |- t_2* <: t'_2*  :  {} |- valtype* <: valtype*
[notation 3-typing.watsup:146.22-146.24] {}  :  {}
[notation 3-typing.watsup:146.25-146.38] t_2* <: t'_2*  :  valtype* <: valtype*
[notation 3-typing.watsup:146.25-146.29] t_2*  :  valtype*
[notation 3-typing.watsup:146.25-146.28] t_2  :  valtype
[elab 3-typing.watsup:146.25-146.28] t_2  :  valtype
[notation 3-typing.watsup:146.33-146.38] t'_2*  :  valtype*
[notation 3-typing.watsup:146.33-146.37] t'_2  :  valtype
[elab 3-typing.watsup:146.33-146.37] t'_2  :  valtype
[notation 3-typing.watsup:149.3-149.35] C |- instr* : {t* t_1*} -> {t* t_2*}  :  context |- instr* : functype
[notation 3-typing.watsup:149.3-149.4] C  :  context
[elab 3-typing.watsup:149.3-149.4] C  :  context
[notation 3-typing.watsup:149.8-149.35] instr* : {t* t_1*} -> {t* t_2*}  :  instr* : functype
[notation 3-typing.watsup:149.8-149.14] instr*  :  instr*
[notation 3-typing.watsup:149.8-149.13] instr  :  instr
[elab 3-typing.watsup:149.8-149.13] instr  :  instr
[notation 3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  functype
[elab 3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  functype
[notation 3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  resulttype -> resulttype
[notation 3-typing.watsup:149.17-149.24] {t* t_1*}  :  resulttype
[elab 3-typing.watsup:149.17-149.24] {t* t_1*}  :  resulttype
[elab 3-typing.watsup:149.17-149.19] t*  :  resulttype
[elab 3-typing.watsup:149.17-149.18] t  :  valtype
[elab 3-typing.watsup:149.20-149.24] t_1*  :  resulttype
[elab 3-typing.watsup:149.20-149.23] t_1  :  valtype
[notation 3-typing.watsup:149.28-149.35] {t* t_2*}  :  resulttype
[elab 3-typing.watsup:149.28-149.35] {t* t_2*}  :  resulttype
[elab 3-typing.watsup:149.28-149.30] t*  :  resulttype
[elab 3-typing.watsup:149.28-149.29] t  :  valtype
[elab 3-typing.watsup:149.31-149.35] t_2*  :  resulttype
[elab 3-typing.watsup:149.31-149.34] t_2  :  valtype
[notation 3-typing.watsup:150.19-150.45] C |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation 3-typing.watsup:150.19-150.20] C  :  context
[elab 3-typing.watsup:150.19-150.20] C  :  context
[notation 3-typing.watsup:150.24-150.45] instr* : t_1* -> t_2*  :  instr* : functype
[notation 3-typing.watsup:150.24-150.30] instr*  :  instr*
[notation 3-typing.watsup:150.24-150.29] instr  :  instr
[elab 3-typing.watsup:150.24-150.29] instr  :  instr
[notation 3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:150.33-150.37] t_1*  :  resulttype
[elab 3-typing.watsup:150.33-150.37] t_1*  :  resulttype
[elab 3-typing.watsup:150.33-150.36] t_1  :  valtype
[notation 3-typing.watsup:150.41-150.45] t_2*  :  resulttype
[elab 3-typing.watsup:150.41-150.45] t_2*  :  resulttype
[elab 3-typing.watsup:150.41-150.44] t_2  :  valtype
[notation 3-typing.watsup:154.3-154.34] C |- UNREACHABLE : t_1* -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:154.3-154.4] C  :  context
[elab 3-typing.watsup:154.3-154.4] C  :  context
[notation 3-typing.watsup:154.8-154.34] UNREACHABLE : t_1* -> t_2*  :  instr : functype
[notation 3-typing.watsup:154.8-154.19] UNREACHABLE  :  instr
[elab 3-typing.watsup:154.8-154.19] UNREACHABLE  :  instr
[notation 3-typing.watsup:154.8-154.19] {}  :  {}
[notation 3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:154.22-154.26] t_1*  :  resulttype
[elab 3-typing.watsup:154.22-154.26] t_1*  :  resulttype
[elab 3-typing.watsup:154.22-154.25] t_1  :  valtype
[notation 3-typing.watsup:154.30-154.34] t_2*  :  resulttype
[elab 3-typing.watsup:154.30-154.34] t_2*  :  resulttype
[elab 3-typing.watsup:154.30-154.33] t_2  :  valtype
[notation 3-typing.watsup:157.3-157.32] C |- NOP : epsilon -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:157.3-157.4] C  :  context
[elab 3-typing.watsup:157.3-157.4] C  :  context
[notation 3-typing.watsup:157.8-157.32] NOP : epsilon -> epsilon  :  instr : functype
[notation 3-typing.watsup:157.8-157.11] NOP  :  instr
[elab 3-typing.watsup:157.8-157.11] NOP  :  instr
[notation 3-typing.watsup:157.8-157.11] {}  :  {}
[notation 3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  functype
[elab 3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  functype
[notation 3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:157.14-157.21] epsilon  :  resulttype
[elab 3-typing.watsup:157.14-157.21] epsilon  :  resulttype
[notation 3-typing.watsup:157.25-157.32] epsilon  :  resulttype
[elab 3-typing.watsup:157.25-157.32] epsilon  :  resulttype
[notation 3-typing.watsup:160.3-160.27] C |- DROP : t -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:160.3-160.4] C  :  context
[elab 3-typing.watsup:160.3-160.4] C  :  context
[notation 3-typing.watsup:160.8-160.27] DROP : t -> epsilon  :  instr : functype
[notation 3-typing.watsup:160.8-160.12] DROP  :  instr
[elab 3-typing.watsup:160.8-160.12] DROP  :  instr
[notation 3-typing.watsup:160.8-160.12] {}  :  {}
[notation 3-typing.watsup:160.15-160.27] t -> epsilon  :  functype
[elab 3-typing.watsup:160.15-160.27] t -> epsilon  :  functype
[notation 3-typing.watsup:160.15-160.27] t -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:160.15-160.16] t  :  resulttype
[elab 3-typing.watsup:160.15-160.16] t  :  resulttype
[notation 3-typing.watsup:160.20-160.27] epsilon  :  resulttype
[elab 3-typing.watsup:160.20-160.27] epsilon  :  resulttype
[notation 3-typing.watsup:164.3-164.31] C |- {SELECT t} : {t t I32} -> t  :  context |- instr : functype
[notation 3-typing.watsup:164.3-164.4] C  :  context
[elab 3-typing.watsup:164.3-164.4] C  :  context
[notation 3-typing.watsup:164.8-164.31] {SELECT t} : {t t I32} -> t  :  instr : functype
[notation 3-typing.watsup:164.8-164.16] {SELECT t}  :  instr
[elab 3-typing.watsup:164.8-164.16] {SELECT t}  :  instr
[notation 3-typing.watsup:164.8-164.16] {t}  :  {valtype?}
[notation 3-typing.watsup:164.8-164.16] {t}  :  valtype?
[elab 3-typing.watsup:164.15-164.16] t  :  valtype?
[notation 3-typing.watsup:164.19-164.31] {t t I32} -> t  :  functype
[elab 3-typing.watsup:164.19-164.31] {t t I32} -> t  :  functype
[notation 3-typing.watsup:164.19-164.31] {t t I32} -> t  :  resulttype -> resulttype
[notation 3-typing.watsup:164.19-164.26] {t t I32}  :  resulttype
[elab 3-typing.watsup:164.19-164.26] {t t I32}  :  resulttype
[elab 3-typing.watsup:164.19-164.20] t  :  resulttype
[elab 3-typing.watsup:164.21-164.22] t  :  resulttype
[elab 3-typing.watsup:164.23-164.26] I32  :  resulttype
[notation 3-typing.watsup:164.23-164.26] {}  :  {}
[notation 3-typing.watsup:164.30-164.31] t  :  resulttype
[elab 3-typing.watsup:164.30-164.31] t  :  resulttype
[notation 3-typing.watsup:167.3-167.29] C |- SELECT : {t t I32} -> t  :  context |- instr : functype
[notation 3-typing.watsup:167.3-167.4] C  :  context
[elab 3-typing.watsup:167.3-167.4] C  :  context
[notation 3-typing.watsup:167.8-167.29] SELECT : {t t I32} -> t  :  instr : functype
[notation 3-typing.watsup:167.8-167.14] SELECT  :  instr
[elab 3-typing.watsup:167.8-167.14] SELECT  :  instr
[notation 3-typing.watsup:167.8-167.14] {}  :  {valtype?}
[notation 3-typing.watsup:167.8-167.14] {}  :  valtype?
[niteration 3-typing.watsup:167.8-167.14]   :  valtype?
[notation 3-typing.watsup:167.17-167.29] {t t I32} -> t  :  functype
[elab 3-typing.watsup:167.17-167.29] {t t I32} -> t  :  functype
[notation 3-typing.watsup:167.17-167.29] {t t I32} -> t  :  resulttype -> resulttype
[notation 3-typing.watsup:167.17-167.24] {t t I32}  :  resulttype
[elab 3-typing.watsup:167.17-167.24] {t t I32}  :  resulttype
[elab 3-typing.watsup:167.17-167.18] t  :  resulttype
[elab 3-typing.watsup:167.19-167.20] t  :  resulttype
[elab 3-typing.watsup:167.21-167.24] I32  :  resulttype
[notation 3-typing.watsup:167.21-167.24] {}  :  {}
[notation 3-typing.watsup:167.28-167.29] t  :  resulttype
[elab 3-typing.watsup:167.28-167.29] t  :  resulttype
[notation 3-typing.watsup:168.19-168.29] {} |- t <: t'  :  {} |- valtype <: valtype
[notation 3-typing.watsup:168.19-168.21] {}  :  {}
[notation 3-typing.watsup:168.22-168.29] t <: t'  :  valtype <: valtype
[notation 3-typing.watsup:168.22-168.23] t  :  valtype
[elab 3-typing.watsup:168.22-168.23] t  :  valtype
[notation 3-typing.watsup:168.27-168.29] t'  :  valtype
[elab 3-typing.watsup:168.27-168.29] t'  :  valtype
[elab 3-typing.watsup:169.9-169.37] t' = numtype \/ t' = vectype  :  bool
[elab 3-typing.watsup:169.9-169.21] t' = numtype  :  bool
[elab 3-typing.watsup:169.9-169.11] t'  :  valtype
[elab 3-typing.watsup:169.14-169.21] numtype  :  valtype
[elab 3-typing.watsup:169.25-169.37] t' = vectype  :  bool
[elab 3-typing.watsup:169.25-169.27] t'  :  valtype
[elab 3-typing.watsup:169.30-169.37] vectype  :  valtype
[notation 3-typing.watsup:175.3-175.15] C |- ft : ft  :  context |- blocktype : functype
[notation 3-typing.watsup:175.3-175.4] C  :  context
[elab 3-typing.watsup:175.3-175.4] C  :  context
[notation 3-typing.watsup:175.8-175.15] ft : ft  :  blocktype : functype
[notation 3-typing.watsup:175.8-175.10] ft  :  blocktype
[elab 3-typing.watsup:175.8-175.10] ft  :  blocktype
[notation 3-typing.watsup:175.13-175.15] ft  :  functype
[elab 3-typing.watsup:175.13-175.15] ft  :  functype
[notation 3-typing.watsup:176.19-176.29] {} |- ft : OK  :  {} |- functype : OK
[notation 3-typing.watsup:176.19-176.21] {}  :  {}
[notation 3-typing.watsup:176.22-176.29] ft : OK  :  functype : OK
[notation 3-typing.watsup:176.22-176.24] ft  :  functype
[elab 3-typing.watsup:176.22-176.24] ft  :  functype
[notation 3-typing.watsup:176.27-176.29] OK  :  OK
[notation 3-typing.watsup:179.3-179.38] C |- {BLOCK bt instr*} : t_1* -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:179.3-179.4] C  :  context
[elab 3-typing.watsup:179.3-179.4] C  :  context
[notation 3-typing.watsup:179.8-179.38] {BLOCK bt instr*} : t_1* -> t_2*  :  instr : functype
[notation 3-typing.watsup:179.8-179.23] {BLOCK bt instr*}  :  instr
[elab 3-typing.watsup:179.8-179.23] {BLOCK bt instr*}  :  instr
[notation 3-typing.watsup:179.8-179.23] {bt instr*}  :  {blocktype instr*}
[notation 3-typing.watsup:179.14-179.16] bt  :  blocktype
[elab 3-typing.watsup:179.14-179.16] bt  :  blocktype
[notation 3-typing.watsup:179.8-179.23] {instr*}  :  {instr*}
[notation 3-typing.watsup:179.8-179.23] {instr*}  :  instr*
[elab 3-typing.watsup:179.17-179.23] instr*  :  instr*
[elab 3-typing.watsup:179.17-179.22] instr  :  instr
[notation 3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:179.26-179.30] t_1*  :  resulttype
[elab 3-typing.watsup:179.26-179.30] t_1*  :  resulttype
[elab 3-typing.watsup:179.26-179.29] t_1  :  valtype
[notation 3-typing.watsup:179.34-179.38] t_2*  :  resulttype
[elab 3-typing.watsup:179.34-179.38] t_2*  :  resulttype
[elab 3-typing.watsup:179.34-179.37] t_2  :  valtype
[notation 3-typing.watsup:180.20-180.42] C |- bt : t_1* -> t_2*  :  context |- blocktype : functype
[notation 3-typing.watsup:180.20-180.21] C  :  context
[elab 3-typing.watsup:180.20-180.21] C  :  context
[notation 3-typing.watsup:180.25-180.42] bt : t_1* -> t_2*  :  blocktype : functype
[notation 3-typing.watsup:180.25-180.27] bt  :  blocktype
[elab 3-typing.watsup:180.25-180.27] bt  :  blocktype
[notation 3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:180.30-180.34] t_1*  :  resulttype
[elab 3-typing.watsup:180.30-180.34] t_1*  :  resulttype
[elab 3-typing.watsup:180.30-180.33] t_1  :  valtype
[notation 3-typing.watsup:180.38-180.42] t_2*  :  resulttype
[elab 3-typing.watsup:180.38-180.42] t_2*  :  resulttype
[elab 3-typing.watsup:180.38-180.41] t_2  :  valtype
[notation 3-typing.watsup:181.19-181.57] C, {LABEL t_2*} |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation 3-typing.watsup:181.19-181.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:181.19-181.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:181.19-181.20] C  :  context
[elab 3-typing.watsup:181.28-181.32] {LABEL t_2*}  :  context
[notation 3-typing.watsup:181.28-181.32] t_2*  :  resulttype*
[notation 3-typing.watsup:181.28-181.31] t_2  :  resulttype
[elab 3-typing.watsup:181.28-181.31] t_2  :  resulttype
[notation 3-typing.watsup:181.36-181.57] instr* : t_1* -> t_2*  :  instr* : functype
[notation 3-typing.watsup:181.36-181.42] instr*  :  instr*
[notation 3-typing.watsup:181.36-181.41] instr  :  instr
[elab 3-typing.watsup:181.36-181.41] instr  :  instr
[notation 3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:181.45-181.49] t_1*  :  resulttype
[elab 3-typing.watsup:181.45-181.49] t_1*  :  resulttype
[elab 3-typing.watsup:181.45-181.48] t_1  :  valtype
[notation 3-typing.watsup:181.53-181.57] t_2*  :  resulttype
[elab 3-typing.watsup:181.53-181.57] t_2*  :  resulttype
[elab 3-typing.watsup:181.53-181.56] t_2  :  valtype
[notation 3-typing.watsup:184.3-184.37] C |- {LOOP bt instr*} : t_1* -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:184.3-184.4] C  :  context
[elab 3-typing.watsup:184.3-184.4] C  :  context
[notation 3-typing.watsup:184.8-184.37] {LOOP bt instr*} : t_1* -> t_2*  :  instr : functype
[notation 3-typing.watsup:184.8-184.22] {LOOP bt instr*}  :  instr
[elab 3-typing.watsup:184.8-184.22] {LOOP bt instr*}  :  instr
[notation 3-typing.watsup:184.8-184.22] {bt instr*}  :  {blocktype instr*}
[notation 3-typing.watsup:184.13-184.15] bt  :  blocktype
[elab 3-typing.watsup:184.13-184.15] bt  :  blocktype
[notation 3-typing.watsup:184.8-184.22] {instr*}  :  {instr*}
[notation 3-typing.watsup:184.8-184.22] {instr*}  :  instr*
[elab 3-typing.watsup:184.16-184.22] instr*  :  instr*
[elab 3-typing.watsup:184.16-184.21] instr  :  instr
[notation 3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:184.25-184.29] t_1*  :  resulttype
[elab 3-typing.watsup:184.25-184.29] t_1*  :  resulttype
[elab 3-typing.watsup:184.25-184.28] t_1  :  valtype
[notation 3-typing.watsup:184.33-184.37] t_2*  :  resulttype
[elab 3-typing.watsup:184.33-184.37] t_2*  :  resulttype
[elab 3-typing.watsup:184.33-184.36] t_2  :  valtype
[notation 3-typing.watsup:185.20-185.42] C |- bt : t_1* -> t_2*  :  context |- blocktype : functype
[notation 3-typing.watsup:185.20-185.21] C  :  context
[elab 3-typing.watsup:185.20-185.21] C  :  context
[notation 3-typing.watsup:185.25-185.42] bt : t_1* -> t_2*  :  blocktype : functype
[notation 3-typing.watsup:185.25-185.27] bt  :  blocktype
[elab 3-typing.watsup:185.25-185.27] bt  :  blocktype
[notation 3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:185.30-185.34] t_1*  :  resulttype
[elab 3-typing.watsup:185.30-185.34] t_1*  :  resulttype
[elab 3-typing.watsup:185.30-185.33] t_1  :  valtype
[notation 3-typing.watsup:185.38-185.42] t_2*  :  resulttype
[elab 3-typing.watsup:185.38-185.42] t_2*  :  resulttype
[elab 3-typing.watsup:185.38-185.41] t_2  :  valtype
[notation 3-typing.watsup:186.19-186.56] C, {LABEL t_1*} |- instr* : t_1* -> t_2  :  context |- instr* : functype
[notation 3-typing.watsup:186.19-186.32] C, {LABEL t_1*}  :  context
[elab 3-typing.watsup:186.19-186.32] C, {LABEL t_1*}  :  context
[elab 3-typing.watsup:186.19-186.20] C  :  context
[elab 3-typing.watsup:186.28-186.32] {LABEL t_1*}  :  context
[notation 3-typing.watsup:186.28-186.32] t_1*  :  resulttype*
[notation 3-typing.watsup:186.28-186.31] t_1  :  resulttype
[elab 3-typing.watsup:186.28-186.31] t_1  :  resulttype
[notation 3-typing.watsup:186.36-186.56] instr* : t_1* -> t_2  :  instr* : functype
[notation 3-typing.watsup:186.36-186.42] instr*  :  instr*
[notation 3-typing.watsup:186.36-186.41] instr  :  instr
[elab 3-typing.watsup:186.36-186.41] instr  :  instr
[notation 3-typing.watsup:186.45-186.56] t_1* -> t_2  :  functype
[elab 3-typing.watsup:186.45-186.56] t_1* -> t_2  :  functype
[notation 3-typing.watsup:186.45-186.56] t_1* -> t_2  :  resulttype -> resulttype
[notation 3-typing.watsup:186.45-186.49] t_1*  :  resulttype
[elab 3-typing.watsup:186.45-186.49] t_1*  :  resulttype
[elab 3-typing.watsup:186.45-186.48] t_1  :  valtype
[notation 3-typing.watsup:186.53-186.56] t_2  :  resulttype
[elab 3-typing.watsup:186.53-186.56] t_2  :  resulttype
[notation 3-typing.watsup:189.3-189.50] C |- {IF bt instr_1* ELSE instr_2*} : t_1* -> t_2  :  context |- instr : functype
[notation 3-typing.watsup:189.3-189.4] C  :  context
[elab 3-typing.watsup:189.3-189.4] C  :  context
[notation 3-typing.watsup:189.8-189.50] {IF bt instr_1* ELSE instr_2*} : t_1* -> t_2  :  instr : functype
[notation 3-typing.watsup:189.8-189.36] {IF bt instr_1* ELSE instr_2*}  :  instr
[elab 3-typing.watsup:189.8-189.36] {IF bt instr_1* ELSE instr_2*}  :  instr
[notation 3-typing.watsup:189.8-189.36] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation 3-typing.watsup:189.11-189.13] bt  :  blocktype
[elab 3-typing.watsup:189.11-189.13] bt  :  blocktype
[notation 3-typing.watsup:189.8-189.36] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation 3-typing.watsup:189.14-189.22] instr_1*  :  instr*
[notation 3-typing.watsup:189.14-189.21] instr_1  :  instr
[elab 3-typing.watsup:189.14-189.21] instr_1  :  instr
[notation 3-typing.watsup:189.8-189.36] {ELSE instr_2*}  :  {ELSE instr*}
[notation 3-typing.watsup:189.23-189.27] ELSE  :  ELSE
[notation 3-typing.watsup:189.8-189.36] {instr_2*}  :  {instr*}
[notation 3-typing.watsup:189.8-189.36] {instr_2*}  :  instr*
[elab 3-typing.watsup:189.28-189.36] instr_2*  :  instr*
[elab 3-typing.watsup:189.28-189.35] instr_2  :  instr
[notation 3-typing.watsup:189.39-189.50] t_1* -> t_2  :  functype
[elab 3-typing.watsup:189.39-189.50] t_1* -> t_2  :  functype
[notation 3-typing.watsup:189.39-189.50] t_1* -> t_2  :  resulttype -> resulttype
[notation 3-typing.watsup:189.39-189.43] t_1*  :  resulttype
[elab 3-typing.watsup:189.39-189.43] t_1*  :  resulttype
[elab 3-typing.watsup:189.39-189.42] t_1  :  valtype
[notation 3-typing.watsup:189.47-189.50] t_2  :  resulttype
[elab 3-typing.watsup:189.47-189.50] t_2  :  resulttype
[notation 3-typing.watsup:190.20-190.41] C |- bt : t_1* -> t_2  :  context |- blocktype : functype
[notation 3-typing.watsup:190.20-190.21] C  :  context
[elab 3-typing.watsup:190.20-190.21] C  :  context
[notation 3-typing.watsup:190.25-190.41] bt : t_1* -> t_2  :  blocktype : functype
[notation 3-typing.watsup:190.25-190.27] bt  :  blocktype
[elab 3-typing.watsup:190.25-190.27] bt  :  blocktype
[notation 3-typing.watsup:190.30-190.41] t_1* -> t_2  :  functype
[elab 3-typing.watsup:190.30-190.41] t_1* -> t_2  :  functype
[notation 3-typing.watsup:190.30-190.41] t_1* -> t_2  :  resulttype -> resulttype
[notation 3-typing.watsup:190.30-190.34] t_1*  :  resulttype
[elab 3-typing.watsup:190.30-190.34] t_1*  :  resulttype
[elab 3-typing.watsup:190.30-190.33] t_1  :  valtype
[notation 3-typing.watsup:190.38-190.41] t_2  :  resulttype
[elab 3-typing.watsup:190.38-190.41] t_2  :  resulttype
[notation 3-typing.watsup:191.19-191.59] C, {LABEL t_2*} |- instr_1* : t_1* -> t_2*  :  context |- instr* : functype
[notation 3-typing.watsup:191.19-191.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:191.19-191.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:191.19-191.20] C  :  context
[elab 3-typing.watsup:191.28-191.32] {LABEL t_2*}  :  context
[notation 3-typing.watsup:191.28-191.32] t_2*  :  resulttype*
[notation 3-typing.watsup:191.28-191.31] t_2  :  resulttype
[elab 3-typing.watsup:191.28-191.31] t_2  :  resulttype
[notation 3-typing.watsup:191.36-191.59] instr_1* : t_1* -> t_2*  :  instr* : functype
[notation 3-typing.watsup:191.36-191.44] instr_1*  :  instr*
[notation 3-typing.watsup:191.36-191.43] instr_1  :  instr
[elab 3-typing.watsup:191.36-191.43] instr_1  :  instr
[notation 3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:191.47-191.51] t_1*  :  resulttype
[elab 3-typing.watsup:191.47-191.51] t_1*  :  resulttype
[elab 3-typing.watsup:191.47-191.50] t_1  :  valtype
[notation 3-typing.watsup:191.55-191.59] t_2*  :  resulttype
[elab 3-typing.watsup:191.55-191.59] t_2*  :  resulttype
[elab 3-typing.watsup:191.55-191.58] t_2  :  valtype
[notation 3-typing.watsup:192.19-192.59] C, {LABEL t_2*} |- instr_2* : t_1* -> t_2*  :  context |- instr* : functype
[notation 3-typing.watsup:192.19-192.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:192.19-192.32] C, {LABEL t_2*}  :  context
[elab 3-typing.watsup:192.19-192.20] C  :  context
[elab 3-typing.watsup:192.28-192.32] {LABEL t_2*}  :  context
[notation 3-typing.watsup:192.28-192.32] t_2*  :  resulttype*
[notation 3-typing.watsup:192.28-192.31] t_2  :  resulttype
[elab 3-typing.watsup:192.28-192.31] t_2  :  resulttype
[notation 3-typing.watsup:192.36-192.59] instr_2* : t_1* -> t_2*  :  instr* : functype
[notation 3-typing.watsup:192.36-192.44] instr_2*  :  instr*
[notation 3-typing.watsup:192.36-192.43] instr_2  :  instr
[elab 3-typing.watsup:192.36-192.43] instr_2  :  instr
[notation 3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:192.47-192.51] t_1*  :  resulttype
[elab 3-typing.watsup:192.47-192.51] t_1*  :  resulttype
[elab 3-typing.watsup:192.47-192.50] t_1  :  valtype
[notation 3-typing.watsup:192.55-192.59] t_2*  :  resulttype
[elab 3-typing.watsup:192.55-192.59] t_2*  :  resulttype
[elab 3-typing.watsup:192.55-192.58] t_2  :  valtype
[notation 3-typing.watsup:196.3-196.30] C |- {BR l} : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:196.3-196.4] C  :  context
[elab 3-typing.watsup:196.3-196.4] C  :  context
[notation 3-typing.watsup:196.8-196.30] {BR l} : {t_1* t*} -> t_2*  :  instr : functype
[notation 3-typing.watsup:196.8-196.12] {BR l}  :  instr
[elab 3-typing.watsup:196.8-196.12] {BR l}  :  instr
[notation 3-typing.watsup:196.8-196.12] {l}  :  {labelidx}
[notation 3-typing.watsup:196.11-196.12] l  :  labelidx
[elab 3-typing.watsup:196.11-196.12] l  :  labelidx
[notation 3-typing.watsup:196.8-196.12] {}  :  {}
[notation 3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  functype
[elab 3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  functype
[notation 3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:196.15-196.22] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:196.15-196.22] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:196.15-196.19] t_1*  :  resulttype
[elab 3-typing.watsup:196.15-196.18] t_1  :  valtype
[elab 3-typing.watsup:196.20-196.22] t*  :  resulttype
[elab 3-typing.watsup:196.20-196.21] t  :  valtype
[notation 3-typing.watsup:196.26-196.30] t_2*  :  resulttype
[elab 3-typing.watsup:196.26-196.30] t_2*  :  resulttype
[elab 3-typing.watsup:196.26-196.29] t_2  :  valtype
[elab 3-typing.watsup:197.9-197.24] C.LABEL[l] = t*  :  bool
[elab 3-typing.watsup:197.9-197.19] C.LABEL[l]  :  resulttype
[elab 3-typing.watsup:197.9-197.16] C.LABEL  :  resulttype*
[elab 3-typing.watsup:197.9-197.10] C  :  context
[elab 3-typing.watsup:197.17-197.18] l  :  nat
[elab 3-typing.watsup:197.22-197.24] t*  :  resulttype
[elab 3-typing.watsup:197.22-197.23] t  :  valtype
[notation 3-typing.watsup:200.3-200.30] C |- {BR_IF l} : {t* I32} -> t*  :  context |- instr : functype
[notation 3-typing.watsup:200.3-200.4] C  :  context
[elab 3-typing.watsup:200.3-200.4] C  :  context
[notation 3-typing.watsup:200.8-200.30] {BR_IF l} : {t* I32} -> t*  :  instr : functype
[notation 3-typing.watsup:200.8-200.15] {BR_IF l}  :  instr
[elab 3-typing.watsup:200.8-200.15] {BR_IF l}  :  instr
[notation 3-typing.watsup:200.8-200.15] {l}  :  {labelidx}
[notation 3-typing.watsup:200.14-200.15] l  :  labelidx
[elab 3-typing.watsup:200.14-200.15] l  :  labelidx
[notation 3-typing.watsup:200.8-200.15] {}  :  {}
[notation 3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  functype
[elab 3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  functype
[notation 3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  resulttype -> resulttype
[notation 3-typing.watsup:200.18-200.24] {t* I32}  :  resulttype
[elab 3-typing.watsup:200.18-200.24] {t* I32}  :  resulttype
[elab 3-typing.watsup:200.18-200.20] t*  :  resulttype
[elab 3-typing.watsup:200.18-200.19] t  :  valtype
[elab 3-typing.watsup:200.21-200.24] I32  :  resulttype
[notation 3-typing.watsup:200.21-200.24] {}  :  {}
[notation 3-typing.watsup:200.28-200.30] t*  :  resulttype
[elab 3-typing.watsup:200.28-200.30] t*  :  resulttype
[elab 3-typing.watsup:200.28-200.29] t  :  valtype
[elab 3-typing.watsup:201.9-201.24] C.LABEL[l] = t*  :  bool
[elab 3-typing.watsup:201.9-201.19] C.LABEL[l]  :  resulttype
[elab 3-typing.watsup:201.9-201.16] C.LABEL  :  resulttype*
[elab 3-typing.watsup:201.9-201.10] C  :  context
[elab 3-typing.watsup:201.17-201.18] l  :  nat
[elab 3-typing.watsup:201.22-201.24] t*  :  resulttype
[elab 3-typing.watsup:201.22-201.23] t  :  valtype
[notation 3-typing.watsup:204.3-204.40] C |- {BR_TABLE l* l'} : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:204.3-204.4] C  :  context
[elab 3-typing.watsup:204.3-204.4] C  :  context
[notation 3-typing.watsup:204.8-204.40] {BR_TABLE l* l'} : {t_1* t*} -> t_2*  :  instr : functype
[notation 3-typing.watsup:204.8-204.22] {BR_TABLE l* l'}  :  instr
[elab 3-typing.watsup:204.8-204.22] {BR_TABLE l* l'}  :  instr
[notation 3-typing.watsup:204.8-204.22] {l* l'}  :  {labelidx* labelidx}
[notation 3-typing.watsup:204.17-204.19] l*  :  labelidx*
[notation 3-typing.watsup:204.17-204.18] l  :  labelidx
[elab 3-typing.watsup:204.17-204.18] l  :  labelidx
[notation 3-typing.watsup:204.8-204.22] {l'}  :  {labelidx}
[notation 3-typing.watsup:204.20-204.22] l'  :  labelidx
[elab 3-typing.watsup:204.20-204.22] l'  :  labelidx
[notation 3-typing.watsup:204.8-204.22] {}  :  {}
[notation 3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  functype
[elab 3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  functype
[notation 3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:204.25-204.32] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:204.25-204.32] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:204.25-204.29] t_1*  :  resulttype
[elab 3-typing.watsup:204.25-204.28] t_1  :  valtype
[elab 3-typing.watsup:204.30-204.32] t*  :  resulttype
[elab 3-typing.watsup:204.30-204.31] t  :  valtype
[notation 3-typing.watsup:204.36-204.40] t_2*  :  resulttype
[elab 3-typing.watsup:204.36-204.40] t_2*  :  resulttype
[elab 3-typing.watsup:204.36-204.39] t_2  :  valtype
[notation 3-typing.watsup:205.23-205.42] {} |- t* <: C.LABEL[l]  :  {} |- valtype* <: valtype*
[notation 3-typing.watsup:205.23-205.25] {}  :  {}
[notation 3-typing.watsup:205.26-205.42] t* <: C.LABEL[l]  :  valtype* <: valtype*
[notation 3-typing.watsup:205.26-205.28] t*  :  valtype*
[notation 3-typing.watsup:205.26-205.27] t  :  valtype
[elab 3-typing.watsup:205.26-205.27] t  :  valtype
[notation 3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype*
[notation 3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype
[elab 3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype
[elab 3-typing.watsup:205.32-205.39] C.LABEL  :  resulttype*
[elab 3-typing.watsup:205.32-205.33] C  :  context
[elab 3-typing.watsup:205.40-205.41] l  :  nat
[notation 3-typing.watsup:206.22-206.42] {} |- t* <: C.LABEL[l']  :  {} |- valtype* <: valtype*
[notation 3-typing.watsup:206.22-206.24] {}  :  {}
[notation 3-typing.watsup:206.25-206.42] t* <: C.LABEL[l']  :  valtype* <: valtype*
[notation 3-typing.watsup:206.25-206.27] t*  :  valtype*
[notation 3-typing.watsup:206.25-206.26] t  :  valtype
[elab 3-typing.watsup:206.25-206.26] t  :  valtype
[notation 3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype*
[notation 3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype
[elab 3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype
[elab 3-typing.watsup:206.31-206.38] C.LABEL  :  resulttype*
[elab 3-typing.watsup:206.31-206.32] C  :  context
[elab 3-typing.watsup:206.39-206.41] l'  :  nat
[notation 3-typing.watsup:209.3-209.32] C |- RETURN : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:209.3-209.4] C  :  context
[elab 3-typing.watsup:209.3-209.4] C  :  context
[notation 3-typing.watsup:209.8-209.32] RETURN : {t_1* t*} -> t_2*  :  instr : functype
[notation 3-typing.watsup:209.8-209.14] RETURN  :  instr
[elab 3-typing.watsup:209.8-209.14] RETURN  :  instr
[notation 3-typing.watsup:209.8-209.14] {}  :  {}
[notation 3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  functype
[elab 3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  functype
[notation 3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:209.17-209.24] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:209.17-209.24] {t_1* t*}  :  resulttype
[elab 3-typing.watsup:209.17-209.21] t_1*  :  resulttype
[elab 3-typing.watsup:209.17-209.20] t_1  :  valtype
[elab 3-typing.watsup:209.22-209.24] t*  :  resulttype
[elab 3-typing.watsup:209.22-209.23] t  :  valtype
[notation 3-typing.watsup:209.28-209.32] t_2*  :  resulttype
[elab 3-typing.watsup:209.28-209.32] t_2*  :  resulttype
[elab 3-typing.watsup:209.28-209.31] t_2  :  valtype
[elab 3-typing.watsup:210.9-210.24] C.RETURN = (t*)  :  bool
[elab 3-typing.watsup:210.9-210.17] C.RETURN  :  resulttype?
[elab 3-typing.watsup:210.9-210.10] C  :  context
[elab 3-typing.watsup:210.20-210.24] (t*)  :  resulttype?
[elab 3-typing.watsup:210.21-210.23] t*  :  resulttype
[elab 3-typing.watsup:210.21-210.22] t  :  valtype
[notation 3-typing.watsup:213.3-213.29] C |- {CALL x} : t_1* -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:213.3-213.4] C  :  context
[elab 3-typing.watsup:213.3-213.4] C  :  context
[notation 3-typing.watsup:213.8-213.29] {CALL x} : t_1* -> t_2*  :  instr : functype
[notation 3-typing.watsup:213.8-213.14] {CALL x}  :  instr
[elab 3-typing.watsup:213.8-213.14] {CALL x}  :  instr
[notation 3-typing.watsup:213.8-213.14] {x}  :  {funcidx}
[notation 3-typing.watsup:213.13-213.14] x  :  funcidx
[elab 3-typing.watsup:213.13-213.14] x  :  funcidx
[notation 3-typing.watsup:213.8-213.14] {}  :  {}
[notation 3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  functype
[elab 3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:213.17-213.21] t_1*  :  resulttype
[elab 3-typing.watsup:213.17-213.21] t_1*  :  resulttype
[elab 3-typing.watsup:213.17-213.20] t_1  :  valtype
[notation 3-typing.watsup:213.25-213.29] t_2*  :  resulttype
[elab 3-typing.watsup:213.25-213.29] t_2*  :  resulttype
[elab 3-typing.watsup:213.25-213.28] t_2  :  valtype
[elab 3-typing.watsup:214.9-214.33] C.FUNC[x] = t_1* -> t_2*  :  bool
[elab 3-typing.watsup:214.9-214.18] C.FUNC[x]  :  functype
[elab 3-typing.watsup:214.9-214.15] C.FUNC  :  functype*
[elab 3-typing.watsup:214.9-214.10] C  :  context
[elab 3-typing.watsup:214.16-214.17] x  :  nat
[elab 3-typing.watsup:214.21-214.33] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:214.21-214.33] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:214.21-214.25] t_1*  :  resulttype
[elab 3-typing.watsup:214.21-214.25] t_1*  :  resulttype
[elab 3-typing.watsup:214.21-214.24] t_1  :  valtype
[notation 3-typing.watsup:214.29-214.33] t_2*  :  resulttype
[elab 3-typing.watsup:214.29-214.33] t_2*  :  resulttype
[elab 3-typing.watsup:214.29-214.32] t_2  :  valtype
[notation 3-typing.watsup:217.3-217.45] C |- {CALL_INDIRECT x ft} : {t_1* I32} -> t_2*  :  context |- instr : functype
[notation 3-typing.watsup:217.3-217.4] C  :  context
[elab 3-typing.watsup:217.3-217.4] C  :  context
[notation 3-typing.watsup:217.8-217.45] {CALL_INDIRECT x ft} : {t_1* I32} -> t_2*  :  instr : functype
[notation 3-typing.watsup:217.8-217.26] {CALL_INDIRECT x ft}  :  instr
[elab 3-typing.watsup:217.8-217.26] {CALL_INDIRECT x ft}  :  instr
[notation 3-typing.watsup:217.8-217.26] {x ft}  :  {tableidx functype}
[notation 3-typing.watsup:217.22-217.23] x  :  tableidx
[elab 3-typing.watsup:217.22-217.23] x  :  tableidx
[notation 3-typing.watsup:217.8-217.26] {ft}  :  {functype}
[notation 3-typing.watsup:217.24-217.26] ft  :  functype
[elab 3-typing.watsup:217.24-217.26] ft  :  functype
[notation 3-typing.watsup:217.8-217.26] {}  :  {}
[notation 3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  functype
[elab 3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  functype
[notation 3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:217.29-217.37] {t_1* I32}  :  resulttype
[elab 3-typing.watsup:217.29-217.37] {t_1* I32}  :  resulttype
[elab 3-typing.watsup:217.29-217.33] t_1*  :  resulttype
[elab 3-typing.watsup:217.29-217.32] t_1  :  valtype
[elab 3-typing.watsup:217.34-217.37] I32  :  resulttype
[notation 3-typing.watsup:217.34-217.37] {}  :  {}
[notation 3-typing.watsup:217.41-217.45] t_2*  :  resulttype
[elab 3-typing.watsup:217.41-217.45] t_2*  :  resulttype
[elab 3-typing.watsup:217.41-217.44] t_2  :  valtype
[elab 3-typing.watsup:218.9-218.33] C.TABLE[x] = {lim FUNCREF}  :  bool
[elab 3-typing.watsup:218.9-218.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:218.9-218.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:218.9-218.10] C  :  context
[elab 3-typing.watsup:218.17-218.18] x  :  nat
[elab 3-typing.watsup:218.22-218.33] {lim FUNCREF}  :  tabletype
[notation 3-typing.watsup:218.22-218.33] {lim FUNCREF}  :  {limits reftype}
[notation 3-typing.watsup:218.22-218.25] lim  :  limits
[elab 3-typing.watsup:218.22-218.25] lim  :  limits
[notation 3-typing.watsup:218.22-218.33] {FUNCREF}  :  {reftype}
[notation 3-typing.watsup:218.26-218.33] FUNCREF  :  reftype
[elab 3-typing.watsup:218.26-218.33] FUNCREF  :  reftype
[notation 3-typing.watsup:218.26-218.33] {}  :  {}
[notation 3-typing.watsup:218.22-218.33] {}  :  {}
[elab 3-typing.watsup:219.9-219.26] ft = t_1* -> t_2*  :  bool
[elab 3-typing.watsup:219.9-219.11] ft  :  functype
[elab 3-typing.watsup:219.14-219.26] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:219.14-219.26] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:219.14-219.18] t_1*  :  resulttype
[elab 3-typing.watsup:219.14-219.18] t_1*  :  resulttype
[elab 3-typing.watsup:219.14-219.17] t_1  :  valtype
[notation 3-typing.watsup:219.22-219.26] t_2*  :  resulttype
[elab 3-typing.watsup:219.22-219.26] t_2*  :  resulttype
[elab 3-typing.watsup:219.22-219.25] t_2  :  valtype
[notation 3-typing.watsup:223.3-223.37] C |- {CONST nt c_nt} : epsilon -> nt  :  context |- instr : functype
[notation 3-typing.watsup:223.3-223.4] C  :  context
[elab 3-typing.watsup:223.3-223.4] C  :  context
[notation 3-typing.watsup:223.8-223.37] {CONST nt c_nt} : epsilon -> nt  :  instr : functype
[notation 3-typing.watsup:223.8-223.21] {CONST nt c_nt}  :  instr
[elab 3-typing.watsup:223.8-223.21] {CONST nt c_nt}  :  instr
[notation 3-typing.watsup:223.8-223.21] {nt c_nt}  :  {numtype c_numtype}
[notation 3-typing.watsup:223.14-223.16] nt  :  numtype
[elab 3-typing.watsup:223.14-223.16] nt  :  numtype
[notation 3-typing.watsup:223.8-223.21] {c_nt}  :  {c_numtype}
[notation 3-typing.watsup:223.17-223.21] c_nt  :  c_numtype
[elab 3-typing.watsup:223.17-223.21] c_nt  :  c_numtype
[notation 3-typing.watsup:223.8-223.21] {}  :  {}
[notation 3-typing.watsup:223.24-223.37] epsilon -> nt  :  functype
[elab 3-typing.watsup:223.24-223.37] epsilon -> nt  :  functype
[notation 3-typing.watsup:223.24-223.37] epsilon -> nt  :  resulttype -> resulttype
[notation 3-typing.watsup:223.24-223.31] epsilon  :  resulttype
[elab 3-typing.watsup:223.24-223.31] epsilon  :  resulttype
[notation 3-typing.watsup:223.35-223.37] nt  :  resulttype
[elab 3-typing.watsup:223.35-223.37] nt  :  resulttype
[notation 3-typing.watsup:226.3-226.31] C |- {UNOP nt unop} : nt -> nt  :  context |- instr : functype
[notation 3-typing.watsup:226.3-226.4] C  :  context
[elab 3-typing.watsup:226.3-226.4] C  :  context
[notation 3-typing.watsup:226.8-226.31] {UNOP nt unop} : nt -> nt  :  instr : functype
[notation 3-typing.watsup:226.8-226.20] {UNOP nt unop}  :  instr
[elab 3-typing.watsup:226.8-226.20] {UNOP nt unop}  :  instr
[notation 3-typing.watsup:226.8-226.20] {nt unop}  :  {numtype unop_numtype}
[notation 3-typing.watsup:226.13-226.15] nt  :  numtype
[elab 3-typing.watsup:226.13-226.15] nt  :  numtype
[notation 3-typing.watsup:226.8-226.20] {unop}  :  {unop_numtype}
[notation 3-typing.watsup:226.16-226.20] unop  :  unop_numtype
[elab 3-typing.watsup:226.16-226.20] unop  :  unop_numtype
[notation 3-typing.watsup:226.8-226.20] {}  :  {}
[notation 3-typing.watsup:226.23-226.31] nt -> nt  :  functype
[elab 3-typing.watsup:226.23-226.31] nt -> nt  :  functype
[notation 3-typing.watsup:226.23-226.31] nt -> nt  :  resulttype -> resulttype
[notation 3-typing.watsup:226.23-226.25] nt  :  resulttype
[elab 3-typing.watsup:226.23-226.25] nt  :  resulttype
[notation 3-typing.watsup:226.29-226.31] nt  :  resulttype
[elab 3-typing.watsup:226.29-226.31] nt  :  resulttype
[notation 3-typing.watsup:229.3-229.36] C |- {BINOP nt binop} : {nt nt} -> nt  :  context |- instr : functype
[notation 3-typing.watsup:229.3-229.4] C  :  context
[elab 3-typing.watsup:229.3-229.4] C  :  context
[notation 3-typing.watsup:229.8-229.36] {BINOP nt binop} : {nt nt} -> nt  :  instr : functype
[notation 3-typing.watsup:229.8-229.22] {BINOP nt binop}  :  instr
[elab 3-typing.watsup:229.8-229.22] {BINOP nt binop}  :  instr
[notation 3-typing.watsup:229.8-229.22] {nt binop}  :  {numtype binop_numtype}
[notation 3-typing.watsup:229.14-229.16] nt  :  numtype
[elab 3-typing.watsup:229.14-229.16] nt  :  numtype
[notation 3-typing.watsup:229.8-229.22] {binop}  :  {binop_numtype}
[notation 3-typing.watsup:229.17-229.22] binop  :  binop_numtype
[elab 3-typing.watsup:229.17-229.22] binop  :  binop_numtype
[notation 3-typing.watsup:229.8-229.22] {}  :  {}
[notation 3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  functype
[elab 3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  functype
[notation 3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  resulttype -> resulttype
[notation 3-typing.watsup:229.25-229.30] {nt nt}  :  resulttype
[elab 3-typing.watsup:229.25-229.30] {nt nt}  :  resulttype
[elab 3-typing.watsup:229.25-229.27] nt  :  resulttype
[elab 3-typing.watsup:229.28-229.30] nt  :  resulttype
[notation 3-typing.watsup:229.34-229.36] nt  :  resulttype
[elab 3-typing.watsup:229.34-229.36] nt  :  resulttype
[notation 3-typing.watsup:232.3-232.36] C |- {TESTOP nt testop} : nt -> I32  :  context |- instr : functype
[notation 3-typing.watsup:232.3-232.4] C  :  context
[elab 3-typing.watsup:232.3-232.4] C  :  context
[notation 3-typing.watsup:232.8-232.36] {TESTOP nt testop} : nt -> I32  :  instr : functype
[notation 3-typing.watsup:232.8-232.24] {TESTOP nt testop}  :  instr
[elab 3-typing.watsup:232.8-232.24] {TESTOP nt testop}  :  instr
[notation 3-typing.watsup:232.8-232.24] {nt testop}  :  {numtype testop_numtype}
[notation 3-typing.watsup:232.15-232.17] nt  :  numtype
[elab 3-typing.watsup:232.15-232.17] nt  :  numtype
[notation 3-typing.watsup:232.8-232.24] {testop}  :  {testop_numtype}
[notation 3-typing.watsup:232.18-232.24] testop  :  testop_numtype
[elab 3-typing.watsup:232.18-232.24] testop  :  testop_numtype
[notation 3-typing.watsup:232.8-232.24] {}  :  {}
[notation 3-typing.watsup:232.27-232.36] nt -> I32  :  functype
[elab 3-typing.watsup:232.27-232.36] nt -> I32  :  functype
[notation 3-typing.watsup:232.27-232.36] nt -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:232.27-232.29] nt  :  resulttype
[elab 3-typing.watsup:232.27-232.29] nt  :  resulttype
[notation 3-typing.watsup:232.33-232.36] I32  :  resulttype
[elab 3-typing.watsup:232.33-232.36] I32  :  resulttype
[notation 3-typing.watsup:232.33-232.36] {}  :  {}
[notation 3-typing.watsup:235.3-235.37] C |- {RELOP nt relop} : {nt nt} -> I32  :  context |- instr : functype
[notation 3-typing.watsup:235.3-235.4] C  :  context
[elab 3-typing.watsup:235.3-235.4] C  :  context
[notation 3-typing.watsup:235.8-235.37] {RELOP nt relop} : {nt nt} -> I32  :  instr : functype
[notation 3-typing.watsup:235.8-235.22] {RELOP nt relop}  :  instr
[elab 3-typing.watsup:235.8-235.22] {RELOP nt relop}  :  instr
[notation 3-typing.watsup:235.8-235.22] {nt relop}  :  {numtype relop_numtype}
[notation 3-typing.watsup:235.14-235.16] nt  :  numtype
[elab 3-typing.watsup:235.14-235.16] nt  :  numtype
[notation 3-typing.watsup:235.8-235.22] {relop}  :  {relop_numtype}
[notation 3-typing.watsup:235.17-235.22] relop  :  relop_numtype
[elab 3-typing.watsup:235.17-235.22] relop  :  relop_numtype
[notation 3-typing.watsup:235.8-235.22] {}  :  {}
[notation 3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  functype
[elab 3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  functype
[notation 3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:235.25-235.30] {nt nt}  :  resulttype
[elab 3-typing.watsup:235.25-235.30] {nt nt}  :  resulttype
[elab 3-typing.watsup:235.25-235.27] nt  :  resulttype
[elab 3-typing.watsup:235.28-235.30] nt  :  resulttype
[notation 3-typing.watsup:235.34-235.37] I32  :  resulttype
[elab 3-typing.watsup:235.34-235.37] I32  :  resulttype
[notation 3-typing.watsup:235.34-235.37] {}  :  {}
[notation 3-typing.watsup:239.3-239.30] C |- {EXTEND nt n} : nt -> nt  :  context |- instr : functype
[notation 3-typing.watsup:239.3-239.4] C  :  context
[elab 3-typing.watsup:239.3-239.4] C  :  context
[notation 3-typing.watsup:239.8-239.30] {EXTEND nt n} : nt -> nt  :  instr : functype
[notation 3-typing.watsup:239.8-239.19] {EXTEND nt n}  :  instr
[elab 3-typing.watsup:239.8-239.19] {EXTEND nt n}  :  instr
[notation 3-typing.watsup:239.8-239.19] {nt n}  :  {numtype n}
[notation 3-typing.watsup:239.15-239.17] nt  :  numtype
[elab 3-typing.watsup:239.15-239.17] nt  :  numtype
[notation 3-typing.watsup:239.8-239.19] {n}  :  {n}
[notation 3-typing.watsup:239.18-239.19] n  :  n
[elab 3-typing.watsup:239.18-239.19] n  :  n
[notation 3-typing.watsup:239.8-239.19] {}  :  {}
[notation 3-typing.watsup:239.22-239.30] nt -> nt  :  functype
[elab 3-typing.watsup:239.22-239.30] nt -> nt  :  functype
[notation 3-typing.watsup:239.22-239.30] nt -> nt  :  resulttype -> resulttype
[notation 3-typing.watsup:239.22-239.24] nt  :  resulttype
[elab 3-typing.watsup:239.22-239.24] nt  :  resulttype
[notation 3-typing.watsup:239.28-239.30] nt  :  resulttype
[elab 3-typing.watsup:239.28-239.30] nt  :  resulttype
[elab 3-typing.watsup:240.9-240.23] n <= $size(nt)  :  bool
[elab 3-typing.watsup:240.9-240.10] n  :  nat
[elab 3-typing.watsup:240.14-240.23] $size(nt)  :  nat
[elab 3-typing.watsup:240.19-240.23] (nt)  :  (valtype)
[elab 3-typing.watsup:240.20-240.22] nt  :  (valtype)
[notation 3-typing.watsup:243.3-243.50] C |- {CVTOP nt_1 REINTERPRET nt_2} : nt_2 -> nt_1  :  context |- instr : functype
[notation 3-typing.watsup:243.3-243.4] C  :  context
[elab 3-typing.watsup:243.3-243.4] C  :  context
[notation 3-typing.watsup:243.8-243.50] {CVTOP nt_1 REINTERPRET nt_2} : nt_2 -> nt_1  :  instr : functype
[notation 3-typing.watsup:243.8-243.35] {CVTOP nt_1 REINTERPRET nt_2}  :  instr
[elab 3-typing.watsup:243.8-243.35] {CVTOP nt_1 REINTERPRET nt_2}  :  instr
[notation 3-typing.watsup:243.8-243.35] {nt_1 REINTERPRET nt_2}  :  {numtype cvtop numtype sx?}
[notation 3-typing.watsup:243.14-243.18] nt_1  :  numtype
[elab 3-typing.watsup:243.14-243.18] nt_1  :  numtype
[notation 3-typing.watsup:243.8-243.35] {REINTERPRET nt_2}  :  {cvtop numtype sx?}
[notation 3-typing.watsup:243.19-243.30] REINTERPRET  :  cvtop
[elab 3-typing.watsup:243.19-243.30] REINTERPRET  :  cvtop
[notation 3-typing.watsup:243.19-243.30] {}  :  {}
[notation 3-typing.watsup:243.8-243.35] {nt_2}  :  {numtype sx?}
[notation 3-typing.watsup:243.31-243.35] nt_2  :  numtype
[elab 3-typing.watsup:243.31-243.35] nt_2  :  numtype
[notation 3-typing.watsup:243.8-243.35] {}  :  {sx?}
[notation 3-typing.watsup:243.8-243.35] {}  :  sx?
[niteration 3-typing.watsup:243.8-243.35]   :  sx?
[notation 3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  functype
[elab 3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  functype
[notation 3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  resulttype -> resulttype
[notation 3-typing.watsup:243.38-243.42] nt_2  :  resulttype
[elab 3-typing.watsup:243.38-243.42] nt_2  :  resulttype
[notation 3-typing.watsup:243.46-243.50] nt_1  :  resulttype
[elab 3-typing.watsup:243.46-243.50] nt_1  :  resulttype
[elab 3-typing.watsup:244.9-244.22] nt_1 =/= nt_2  :  bool
[elab 3-typing.watsup:244.9-244.13] nt_1  :  numtype
[elab 3-typing.watsup:244.18-244.22] nt_2  :  numtype
[elab 3-typing.watsup:245.9-245.34] $size(nt_1) = $size(nt_2)  :  bool
[elab 3-typing.watsup:245.9-245.20] $size(nt_1)  :  nat
[elab 3-typing.watsup:245.14-245.20] (nt_1)  :  (valtype)
[elab 3-typing.watsup:245.15-245.19] nt_1  :  (valtype)
[elab 3-typing.watsup:245.23-245.34] $size(nt_2)  :  nat
[elab 3-typing.watsup:245.28-245.34] (nt_2)  :  (valtype)
[elab 3-typing.watsup:245.29-245.33] nt_2  :  (valtype)
[notation 3-typing.watsup:248.3-248.50] C |- {CVTOP in_1 CONVERT in_2 sx?} : in_2 -> in_1  :  context |- instr : functype
[notation 3-typing.watsup:248.3-248.4] C  :  context
[elab 3-typing.watsup:248.3-248.4] C  :  context
[notation 3-typing.watsup:248.8-248.50] {CVTOP in_1 CONVERT in_2 sx?} : in_2 -> in_1  :  instr : functype
[notation 3-typing.watsup:248.8-248.35] {CVTOP in_1 CONVERT in_2 sx?}  :  instr
[elab 3-typing.watsup:248.8-248.35] {CVTOP in_1 CONVERT in_2 sx?}  :  instr
[notation 3-typing.watsup:248.8-248.35] {in_1 CONVERT in_2 sx?}  :  {numtype cvtop numtype sx?}
[notation 3-typing.watsup:248.14-248.18] in_1  :  numtype
[elab 3-typing.watsup:248.14-248.18] in_1  :  numtype
[notation 3-typing.watsup:248.8-248.35] {CONVERT in_2 sx?}  :  {cvtop numtype sx?}
[notation 3-typing.watsup:248.19-248.26] CONVERT  :  cvtop
[elab 3-typing.watsup:248.19-248.26] CONVERT  :  cvtop
[notation 3-typing.watsup:248.19-248.26] {}  :  {}
[notation 3-typing.watsup:248.8-248.35] {in_2 sx?}  :  {numtype sx?}
[notation 3-typing.watsup:248.27-248.31] in_2  :  numtype
[elab 3-typing.watsup:248.27-248.31] in_2  :  numtype
[notation 3-typing.watsup:248.8-248.35] {sx?}  :  {sx?}
[notation 3-typing.watsup:248.8-248.35] {sx?}  :  sx?
[elab 3-typing.watsup:248.32-248.35] sx?  :  sx?
[elab 3-typing.watsup:248.32-248.34] sx  :  sx
[notation 3-typing.watsup:248.38-248.50] in_2 -> in_1  :  functype
[elab 3-typing.watsup:248.38-248.50] in_2 -> in_1  :  functype
[notation 3-typing.watsup:248.38-248.50] in_2 -> in_1  :  resulttype -> resulttype
[notation 3-typing.watsup:248.38-248.42] in_2  :  resulttype
[elab 3-typing.watsup:248.38-248.42] in_2  :  resulttype
[notation 3-typing.watsup:248.46-248.50] in_1  :  resulttype
[elab 3-typing.watsup:248.46-248.50] in_1  :  resulttype
[elab 3-typing.watsup:249.9-249.22] in_1 =/= in_2  :  bool
[elab 3-typing.watsup:249.9-249.13] in_1  :  in
[elab 3-typing.watsup:249.18-249.22] in_2  :  in
[elab 3-typing.watsup:250.9-250.52] sx? = epsilon <=> $size(in_1) > $size(in_2)  :  bool
[elab 3-typing.watsup:250.9-250.22] sx? = epsilon  :  bool
[elab 3-typing.watsup:250.9-250.12] sx?  :  sx?
[elab 3-typing.watsup:250.9-250.11] sx  :  sx
[elab 3-typing.watsup:250.15-250.22] epsilon  :  sx?
[elab 3-typing.watsup:250.27-250.52] $size(in_1) > $size(in_2)  :  bool
[elab 3-typing.watsup:250.27-250.38] $size(in_1)  :  nat
[elab 3-typing.watsup:250.32-250.38] (in_1)  :  (valtype)
[elab 3-typing.watsup:250.33-250.37] in_1  :  (valtype)
[elab 3-typing.watsup:250.41-250.52] $size(in_2)  :  nat
[elab 3-typing.watsup:250.46-250.52] (in_2)  :  (valtype)
[elab 3-typing.watsup:250.47-250.51] in_2  :  (valtype)
[notation 3-typing.watsup:253.3-253.46] C |- {CVTOP fn_1 CONVERT fn_2} : fn_2 -> fn_1  :  context |- instr : functype
[notation 3-typing.watsup:253.3-253.4] C  :  context
[elab 3-typing.watsup:253.3-253.4] C  :  context
[notation 3-typing.watsup:253.8-253.46] {CVTOP fn_1 CONVERT fn_2} : fn_2 -> fn_1  :  instr : functype
[notation 3-typing.watsup:253.8-253.31] {CVTOP fn_1 CONVERT fn_2}  :  instr
[elab 3-typing.watsup:253.8-253.31] {CVTOP fn_1 CONVERT fn_2}  :  instr
[notation 3-typing.watsup:253.8-253.31] {fn_1 CONVERT fn_2}  :  {numtype cvtop numtype sx?}
[notation 3-typing.watsup:253.14-253.18] fn_1  :  numtype
[elab 3-typing.watsup:253.14-253.18] fn_1  :  numtype
[notation 3-typing.watsup:253.8-253.31] {CONVERT fn_2}  :  {cvtop numtype sx?}
[notation 3-typing.watsup:253.19-253.26] CONVERT  :  cvtop
[elab 3-typing.watsup:253.19-253.26] CONVERT  :  cvtop
[notation 3-typing.watsup:253.19-253.26] {}  :  {}
[notation 3-typing.watsup:253.8-253.31] {fn_2}  :  {numtype sx?}
[notation 3-typing.watsup:253.27-253.31] fn_2  :  numtype
[elab 3-typing.watsup:253.27-253.31] fn_2  :  numtype
[notation 3-typing.watsup:253.8-253.31] {}  :  {sx?}
[notation 3-typing.watsup:253.8-253.31] {}  :  sx?
[niteration 3-typing.watsup:253.8-253.31]   :  sx?
[notation 3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  functype
[elab 3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  functype
[notation 3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  resulttype -> resulttype
[notation 3-typing.watsup:253.34-253.38] fn_2  :  resulttype
[elab 3-typing.watsup:253.34-253.38] fn_2  :  resulttype
[notation 3-typing.watsup:253.42-253.46] fn_1  :  resulttype
[elab 3-typing.watsup:253.42-253.46] fn_1  :  resulttype
[elab 3-typing.watsup:254.9-254.22] fn_1 =/= fn_2  :  bool
[elab 3-typing.watsup:254.9-254.13] fn_1  :  fn
[elab 3-typing.watsup:254.18-254.22] fn_2  :  fn
[notation 3-typing.watsup:258.3-258.35] C |- {REF.NULL rt} : epsilon -> rt  :  context |- instr : functype
[notation 3-typing.watsup:258.3-258.4] C  :  context
[elab 3-typing.watsup:258.3-258.4] C  :  context
[notation 3-typing.watsup:258.8-258.35] {REF.NULL rt} : epsilon -> rt  :  instr : functype
[notation 3-typing.watsup:258.8-258.19] {REF.NULL rt}  :  instr
[elab 3-typing.watsup:258.8-258.19] {REF.NULL rt}  :  instr
[notation 3-typing.watsup:258.8-258.19] {rt}  :  {reftype}
[notation 3-typing.watsup:258.17-258.19] rt  :  reftype
[elab 3-typing.watsup:258.17-258.19] rt  :  reftype
[notation 3-typing.watsup:258.8-258.19] {}  :  {}
[notation 3-typing.watsup:258.22-258.35] epsilon -> rt  :  functype
[elab 3-typing.watsup:258.22-258.35] epsilon -> rt  :  functype
[notation 3-typing.watsup:258.22-258.35] epsilon -> rt  :  resulttype -> resulttype
[notation 3-typing.watsup:258.22-258.29] epsilon  :  resulttype
[elab 3-typing.watsup:258.22-258.29] epsilon  :  resulttype
[notation 3-typing.watsup:258.33-258.35] rt  :  resulttype
[elab 3-typing.watsup:258.33-258.35] rt  :  resulttype
[notation 3-typing.watsup:261.3-261.39] C |- {REF.FUNC x} : epsilon -> FUNCREF  :  context |- instr : functype
[notation 3-typing.watsup:261.3-261.4] C  :  context
[elab 3-typing.watsup:261.3-261.4] C  :  context
[notation 3-typing.watsup:261.8-261.39] {REF.FUNC x} : epsilon -> FUNCREF  :  instr : functype
[notation 3-typing.watsup:261.8-261.18] {REF.FUNC x}  :  instr
[elab 3-typing.watsup:261.8-261.18] {REF.FUNC x}  :  instr
[notation 3-typing.watsup:261.8-261.18] {x}  :  {funcidx}
[notation 3-typing.watsup:261.17-261.18] x  :  funcidx
[elab 3-typing.watsup:261.17-261.18] x  :  funcidx
[notation 3-typing.watsup:261.8-261.18] {}  :  {}
[notation 3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  functype
[elab 3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  functype
[notation 3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  resulttype -> resulttype
[notation 3-typing.watsup:261.21-261.28] epsilon  :  resulttype
[elab 3-typing.watsup:261.21-261.28] epsilon  :  resulttype
[notation 3-typing.watsup:261.32-261.39] FUNCREF  :  resulttype
[elab 3-typing.watsup:261.32-261.39] FUNCREF  :  resulttype
[notation 3-typing.watsup:261.32-261.39] {}  :  {}
[elab 3-typing.watsup:262.9-262.23] C.FUNC[x] = ft  :  bool
[elab 3-typing.watsup:262.9-262.18] C.FUNC[x]  :  functype
[elab 3-typing.watsup:262.9-262.15] C.FUNC  :  functype*
[elab 3-typing.watsup:262.9-262.10] C  :  context
[elab 3-typing.watsup:262.16-262.17] x  :  nat
[elab 3-typing.watsup:262.21-262.23] ft  :  functype
[notation 3-typing.watsup:265.3-265.31] C |- REF.IS_NULL : rt -> I32  :  context |- instr : functype
[notation 3-typing.watsup:265.3-265.4] C  :  context
[elab 3-typing.watsup:265.3-265.4] C  :  context
[notation 3-typing.watsup:265.8-265.31] REF.IS_NULL : rt -> I32  :  instr : functype
[notation 3-typing.watsup:265.8-265.19] REF.IS_NULL  :  instr
[elab 3-typing.watsup:265.8-265.19] REF.IS_NULL  :  instr
[notation 3-typing.watsup:265.8-265.19] {}  :  {}
[notation 3-typing.watsup:265.22-265.31] rt -> I32  :  functype
[elab 3-typing.watsup:265.22-265.31] rt -> I32  :  functype
[notation 3-typing.watsup:265.22-265.31] rt -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:265.22-265.24] rt  :  resulttype
[elab 3-typing.watsup:265.22-265.24] rt  :  resulttype
[notation 3-typing.watsup:265.28-265.31] I32  :  resulttype
[elab 3-typing.watsup:265.28-265.31] I32  :  resulttype
[notation 3-typing.watsup:265.28-265.31] {}  :  {}
[notation 3-typing.watsup:269.3-269.34] C |- {LOCAL.GET x} : epsilon -> t  :  context |- instr : functype
[notation 3-typing.watsup:269.3-269.4] C  :  context
[elab 3-typing.watsup:269.3-269.4] C  :  context
[notation 3-typing.watsup:269.8-269.34] {LOCAL.GET x} : epsilon -> t  :  instr : functype
[notation 3-typing.watsup:269.8-269.19] {LOCAL.GET x}  :  instr
[elab 3-typing.watsup:269.8-269.19] {LOCAL.GET x}  :  instr
[notation 3-typing.watsup:269.8-269.19] {x}  :  {localidx}
[notation 3-typing.watsup:269.18-269.19] x  :  localidx
[elab 3-typing.watsup:269.18-269.19] x  :  localidx
[notation 3-typing.watsup:269.8-269.19] {}  :  {}
[notation 3-typing.watsup:269.22-269.34] epsilon -> t  :  functype
[elab 3-typing.watsup:269.22-269.34] epsilon -> t  :  functype
[notation 3-typing.watsup:269.22-269.34] epsilon -> t  :  resulttype -> resulttype
[notation 3-typing.watsup:269.22-269.29] epsilon  :  resulttype
[elab 3-typing.watsup:269.22-269.29] epsilon  :  resulttype
[notation 3-typing.watsup:269.33-269.34] t  :  resulttype
[elab 3-typing.watsup:269.33-269.34] t  :  resulttype
[elab 3-typing.watsup:270.9-270.23] C.LOCAL[x] = t  :  bool
[elab 3-typing.watsup:270.9-270.19] C.LOCAL[x]  :  valtype
[elab 3-typing.watsup:270.9-270.16] C.LOCAL  :  valtype*
[elab 3-typing.watsup:270.9-270.10] C  :  context
[elab 3-typing.watsup:270.17-270.18] x  :  nat
[elab 3-typing.watsup:270.22-270.23] t  :  valtype
[notation 3-typing.watsup:273.3-273.34] C |- {LOCAL.SET x} : t -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:273.3-273.4] C  :  context
[elab 3-typing.watsup:273.3-273.4] C  :  context
[notation 3-typing.watsup:273.8-273.34] {LOCAL.SET x} : t -> epsilon  :  instr : functype
[notation 3-typing.watsup:273.8-273.19] {LOCAL.SET x}  :  instr
[elab 3-typing.watsup:273.8-273.19] {LOCAL.SET x}  :  instr
[notation 3-typing.watsup:273.8-273.19] {x}  :  {localidx}
[notation 3-typing.watsup:273.18-273.19] x  :  localidx
[elab 3-typing.watsup:273.18-273.19] x  :  localidx
[notation 3-typing.watsup:273.8-273.19] {}  :  {}
[notation 3-typing.watsup:273.22-273.34] t -> epsilon  :  functype
[elab 3-typing.watsup:273.22-273.34] t -> epsilon  :  functype
[notation 3-typing.watsup:273.22-273.34] t -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:273.22-273.23] t  :  resulttype
[elab 3-typing.watsup:273.22-273.23] t  :  resulttype
[notation 3-typing.watsup:273.27-273.34] epsilon  :  resulttype
[elab 3-typing.watsup:273.27-273.34] epsilon  :  resulttype
[elab 3-typing.watsup:274.9-274.23] C.LOCAL[x] = t  :  bool
[elab 3-typing.watsup:274.9-274.19] C.LOCAL[x]  :  valtype
[elab 3-typing.watsup:274.9-274.16] C.LOCAL  :  valtype*
[elab 3-typing.watsup:274.9-274.10] C  :  context
[elab 3-typing.watsup:274.17-274.18] x  :  nat
[elab 3-typing.watsup:274.22-274.23] t  :  valtype
[notation 3-typing.watsup:277.3-277.28] C |- {LOCAL.TEE x} : t -> t  :  context |- instr : functype
[notation 3-typing.watsup:277.3-277.4] C  :  context
[elab 3-typing.watsup:277.3-277.4] C  :  context
[notation 3-typing.watsup:277.8-277.28] {LOCAL.TEE x} : t -> t  :  instr : functype
[notation 3-typing.watsup:277.8-277.19] {LOCAL.TEE x}  :  instr
[elab 3-typing.watsup:277.8-277.19] {LOCAL.TEE x}  :  instr
[notation 3-typing.watsup:277.8-277.19] {x}  :  {localidx}
[notation 3-typing.watsup:277.18-277.19] x  :  localidx
[elab 3-typing.watsup:277.18-277.19] x  :  localidx
[notation 3-typing.watsup:277.8-277.19] {}  :  {}
[notation 3-typing.watsup:277.22-277.28] t -> t  :  functype
[elab 3-typing.watsup:277.22-277.28] t -> t  :  functype
[notation 3-typing.watsup:277.22-277.28] t -> t  :  resulttype -> resulttype
[notation 3-typing.watsup:277.22-277.23] t  :  resulttype
[elab 3-typing.watsup:277.22-277.23] t  :  resulttype
[notation 3-typing.watsup:277.27-277.28] t  :  resulttype
[elab 3-typing.watsup:277.27-277.28] t  :  resulttype
[elab 3-typing.watsup:278.9-278.23] C.LOCAL[x] = t  :  bool
[elab 3-typing.watsup:278.9-278.19] C.LOCAL[x]  :  valtype
[elab 3-typing.watsup:278.9-278.16] C.LOCAL  :  valtype*
[elab 3-typing.watsup:278.9-278.10] C  :  context
[elab 3-typing.watsup:278.17-278.18] x  :  nat
[elab 3-typing.watsup:278.22-278.23] t  :  valtype
[notation 3-typing.watsup:282.3-282.35] C |- {GLOBAL.GET x} : epsilon -> t  :  context |- instr : functype
[notation 3-typing.watsup:282.3-282.4] C  :  context
[elab 3-typing.watsup:282.3-282.4] C  :  context
[notation 3-typing.watsup:282.8-282.35] {GLOBAL.GET x} : epsilon -> t  :  instr : functype
[notation 3-typing.watsup:282.8-282.20] {GLOBAL.GET x}  :  instr
[elab 3-typing.watsup:282.8-282.20] {GLOBAL.GET x}  :  instr
[notation 3-typing.watsup:282.8-282.20] {x}  :  {globalidx}
[notation 3-typing.watsup:282.19-282.20] x  :  globalidx
[elab 3-typing.watsup:282.19-282.20] x  :  globalidx
[notation 3-typing.watsup:282.8-282.20] {}  :  {}
[notation 3-typing.watsup:282.23-282.35] epsilon -> t  :  functype
[elab 3-typing.watsup:282.23-282.35] epsilon -> t  :  functype
[notation 3-typing.watsup:282.23-282.35] epsilon -> t  :  resulttype -> resulttype
[notation 3-typing.watsup:282.23-282.30] epsilon  :  resulttype
[elab 3-typing.watsup:282.23-282.30] epsilon  :  resulttype
[notation 3-typing.watsup:282.34-282.35] t  :  resulttype
[elab 3-typing.watsup:282.34-282.35] t  :  resulttype
[elab 3-typing.watsup:283.9-283.29] C.GLOBAL[x] = {MUT? t}  :  bool
[elab 3-typing.watsup:283.9-283.20] C.GLOBAL[x]  :  globaltype
[elab 3-typing.watsup:283.9-283.17] C.GLOBAL  :  globaltype*
[elab 3-typing.watsup:283.9-283.10] C  :  context
[elab 3-typing.watsup:283.18-283.19] x  :  nat
[elab 3-typing.watsup:283.23-283.29] {MUT? t}  :  globaltype
[notation 3-typing.watsup:283.23-283.29] {MUT? t}  :  {MUT? valtype}
[notation 3-typing.watsup:283.23-283.27] MUT?  :  MUT?
[notation 3-typing.watsup:283.23-283.26] MUT  :  MUT
[notation 3-typing.watsup:283.23-283.29] {t}  :  {valtype}
[notation 3-typing.watsup:283.28-283.29] t  :  valtype
[elab 3-typing.watsup:283.28-283.29] t  :  valtype
[notation 3-typing.watsup:283.23-283.29] {}  :  {}
[notation 3-typing.watsup:286.3-286.35] C |- {GLOBAL.SET x} : t -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:286.3-286.4] C  :  context
[elab 3-typing.watsup:286.3-286.4] C  :  context
[notation 3-typing.watsup:286.8-286.35] {GLOBAL.SET x} : t -> epsilon  :  instr : functype
[notation 3-typing.watsup:286.8-286.20] {GLOBAL.SET x}  :  instr
[elab 3-typing.watsup:286.8-286.20] {GLOBAL.SET x}  :  instr
[notation 3-typing.watsup:286.8-286.20] {x}  :  {globalidx}
[notation 3-typing.watsup:286.19-286.20] x  :  globalidx
[elab 3-typing.watsup:286.19-286.20] x  :  globalidx
[notation 3-typing.watsup:286.8-286.20] {}  :  {}
[notation 3-typing.watsup:286.23-286.35] t -> epsilon  :  functype
[elab 3-typing.watsup:286.23-286.35] t -> epsilon  :  functype
[notation 3-typing.watsup:286.23-286.35] t -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:286.23-286.24] t  :  resulttype
[elab 3-typing.watsup:286.23-286.24] t  :  resulttype
[notation 3-typing.watsup:286.28-286.35] epsilon  :  resulttype
[elab 3-typing.watsup:286.28-286.35] epsilon  :  resulttype
[elab 3-typing.watsup:287.9-287.28] C.GLOBAL[x] = {MUT t}  :  bool
[elab 3-typing.watsup:287.9-287.20] C.GLOBAL[x]  :  globaltype
[elab 3-typing.watsup:287.9-287.17] C.GLOBAL  :  globaltype*
[elab 3-typing.watsup:287.9-287.10] C  :  context
[elab 3-typing.watsup:287.18-287.19] x  :  nat
[elab 3-typing.watsup:287.23-287.28] {MUT t}  :  globaltype
[notation 3-typing.watsup:287.23-287.28] {MUT t}  :  {MUT? valtype}
[notation 3-typing.watsup:287.23-287.26] MUT  :  MUT?
[notation 3-typing.watsup:287.23-287.26] MUT  :  MUT
[notation 3-typing.watsup:287.23-287.28] {t}  :  {valtype}
[notation 3-typing.watsup:287.27-287.28] t  :  valtype
[elab 3-typing.watsup:287.27-287.28] t  :  valtype
[notation 3-typing.watsup:287.23-287.28] {}  :  {}
[notation 3-typing.watsup:291.3-291.31] C |- {TABLE.GET x} : I32 -> rt  :  context |- instr : functype
[notation 3-typing.watsup:291.3-291.4] C  :  context
[elab 3-typing.watsup:291.3-291.4] C  :  context
[notation 3-typing.watsup:291.8-291.31] {TABLE.GET x} : I32 -> rt  :  instr : functype
[notation 3-typing.watsup:291.8-291.19] {TABLE.GET x}  :  instr
[elab 3-typing.watsup:291.8-291.19] {TABLE.GET x}  :  instr
[notation 3-typing.watsup:291.8-291.19] {x}  :  {tableidx}
[notation 3-typing.watsup:291.18-291.19] x  :  tableidx
[elab 3-typing.watsup:291.18-291.19] x  :  tableidx
[notation 3-typing.watsup:291.8-291.19] {}  :  {}
[notation 3-typing.watsup:291.22-291.31] I32 -> rt  :  functype
[elab 3-typing.watsup:291.22-291.31] I32 -> rt  :  functype
[notation 3-typing.watsup:291.22-291.31] I32 -> rt  :  resulttype -> resulttype
[notation 3-typing.watsup:291.22-291.25] I32  :  resulttype
[elab 3-typing.watsup:291.22-291.25] I32  :  resulttype
[notation 3-typing.watsup:291.22-291.25] {}  :  {}
[notation 3-typing.watsup:291.29-291.31] rt  :  resulttype
[elab 3-typing.watsup:291.29-291.31] rt  :  resulttype
[elab 3-typing.watsup:292.9-292.28] C.TABLE[x] = {lim rt}  :  bool
[elab 3-typing.watsup:292.9-292.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:292.9-292.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:292.9-292.10] C  :  context
[elab 3-typing.watsup:292.17-292.18] x  :  nat
[elab 3-typing.watsup:292.22-292.28] {lim rt}  :  tabletype
[notation 3-typing.watsup:292.22-292.28] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:292.22-292.25] lim  :  limits
[elab 3-typing.watsup:292.22-292.25] lim  :  limits
[notation 3-typing.watsup:292.22-292.28] {rt}  :  {reftype}
[notation 3-typing.watsup:292.26-292.28] rt  :  reftype
[elab 3-typing.watsup:292.26-292.28] rt  :  reftype
[notation 3-typing.watsup:292.22-292.28] {}  :  {}
[notation 3-typing.watsup:295.3-295.39] C |- {TABLE.SET x} : {I32 rt} -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:295.3-295.4] C  :  context
[elab 3-typing.watsup:295.3-295.4] C  :  context
[notation 3-typing.watsup:295.8-295.39] {TABLE.SET x} : {I32 rt} -> epsilon  :  instr : functype
[notation 3-typing.watsup:295.8-295.19] {TABLE.SET x}  :  instr
[elab 3-typing.watsup:295.8-295.19] {TABLE.SET x}  :  instr
[notation 3-typing.watsup:295.8-295.19] {x}  :  {tableidx}
[notation 3-typing.watsup:295.18-295.19] x  :  tableidx
[elab 3-typing.watsup:295.18-295.19] x  :  tableidx
[notation 3-typing.watsup:295.8-295.19] {}  :  {}
[notation 3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  functype
[elab 3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  functype
[notation 3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:295.22-295.28] {I32 rt}  :  resulttype
[elab 3-typing.watsup:295.22-295.28] {I32 rt}  :  resulttype
[elab 3-typing.watsup:295.22-295.25] I32  :  resulttype
[notation 3-typing.watsup:295.22-295.25] {}  :  {}
[elab 3-typing.watsup:295.26-295.28] rt  :  resulttype
[notation 3-typing.watsup:295.32-295.39] epsilon  :  resulttype
[elab 3-typing.watsup:295.32-295.39] epsilon  :  resulttype
[elab 3-typing.watsup:296.9-296.28] C.TABLE[x] = {lim rt}  :  bool
[elab 3-typing.watsup:296.9-296.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:296.9-296.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:296.9-296.10] C  :  context
[elab 3-typing.watsup:296.17-296.18] x  :  nat
[elab 3-typing.watsup:296.22-296.28] {lim rt}  :  tabletype
[notation 3-typing.watsup:296.22-296.28] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:296.22-296.25] lim  :  limits
[elab 3-typing.watsup:296.22-296.25] lim  :  limits
[notation 3-typing.watsup:296.22-296.28] {rt}  :  {reftype}
[notation 3-typing.watsup:296.26-296.28] rt  :  reftype
[elab 3-typing.watsup:296.26-296.28] rt  :  reftype
[notation 3-typing.watsup:296.22-296.28] {}  :  {}
[notation 3-typing.watsup:299.3-299.37] C |- {TABLE.SIZE x} : epsilon -> I32  :  context |- instr : functype
[notation 3-typing.watsup:299.3-299.4] C  :  context
[elab 3-typing.watsup:299.3-299.4] C  :  context
[notation 3-typing.watsup:299.8-299.37] {TABLE.SIZE x} : epsilon -> I32  :  instr : functype
[notation 3-typing.watsup:299.8-299.20] {TABLE.SIZE x}  :  instr
[elab 3-typing.watsup:299.8-299.20] {TABLE.SIZE x}  :  instr
[notation 3-typing.watsup:299.8-299.20] {x}  :  {tableidx}
[notation 3-typing.watsup:299.19-299.20] x  :  tableidx
[elab 3-typing.watsup:299.19-299.20] x  :  tableidx
[notation 3-typing.watsup:299.8-299.20] {}  :  {}
[notation 3-typing.watsup:299.23-299.37] epsilon -> I32  :  functype
[elab 3-typing.watsup:299.23-299.37] epsilon -> I32  :  functype
[notation 3-typing.watsup:299.23-299.37] epsilon -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:299.23-299.30] epsilon  :  resulttype
[elab 3-typing.watsup:299.23-299.30] epsilon  :  resulttype
[notation 3-typing.watsup:299.34-299.37] I32  :  resulttype
[elab 3-typing.watsup:299.34-299.37] I32  :  resulttype
[notation 3-typing.watsup:299.34-299.37] {}  :  {}
[elab 3-typing.watsup:300.9-300.24] C.TABLE[x] = tt  :  bool
[elab 3-typing.watsup:300.9-300.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:300.9-300.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:300.9-300.10] C  :  context
[elab 3-typing.watsup:300.17-300.18] x  :  nat
[elab 3-typing.watsup:300.22-300.24] tt  :  tabletype
[notation 3-typing.watsup:303.3-303.36] C |- {TABLE.GROW x} : {rt I32} -> I32  :  context |- instr : functype
[notation 3-typing.watsup:303.3-303.4] C  :  context
[elab 3-typing.watsup:303.3-303.4] C  :  context
[notation 3-typing.watsup:303.8-303.36] {TABLE.GROW x} : {rt I32} -> I32  :  instr : functype
[notation 3-typing.watsup:303.8-303.20] {TABLE.GROW x}  :  instr
[elab 3-typing.watsup:303.8-303.20] {TABLE.GROW x}  :  instr
[notation 3-typing.watsup:303.8-303.20] {x}  :  {tableidx}
[notation 3-typing.watsup:303.19-303.20] x  :  tableidx
[elab 3-typing.watsup:303.19-303.20] x  :  tableidx
[notation 3-typing.watsup:303.8-303.20] {}  :  {}
[notation 3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  functype
[elab 3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  functype
[notation 3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:303.23-303.29] {rt I32}  :  resulttype
[elab 3-typing.watsup:303.23-303.29] {rt I32}  :  resulttype
[elab 3-typing.watsup:303.23-303.25] rt  :  resulttype
[elab 3-typing.watsup:303.26-303.29] I32  :  resulttype
[notation 3-typing.watsup:303.26-303.29] {}  :  {}
[notation 3-typing.watsup:303.33-303.36] I32  :  resulttype
[elab 3-typing.watsup:303.33-303.36] I32  :  resulttype
[notation 3-typing.watsup:303.33-303.36] {}  :  {}
[elab 3-typing.watsup:304.9-304.28] C.TABLE[x] = {lim rt}  :  bool
[elab 3-typing.watsup:304.9-304.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:304.9-304.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:304.9-304.10] C  :  context
[elab 3-typing.watsup:304.17-304.18] x  :  nat
[elab 3-typing.watsup:304.22-304.28] {lim rt}  :  tabletype
[notation 3-typing.watsup:304.22-304.28] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:304.22-304.25] lim  :  limits
[elab 3-typing.watsup:304.22-304.25] lim  :  limits
[notation 3-typing.watsup:304.22-304.28] {rt}  :  {reftype}
[notation 3-typing.watsup:304.26-304.28] rt  :  reftype
[elab 3-typing.watsup:304.26-304.28] rt  :  reftype
[notation 3-typing.watsup:304.22-304.28] {}  :  {}
[notation 3-typing.watsup:307.3-307.44] C |- {TABLE.FILL x} : {I32 rt I32} -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:307.3-307.4] C  :  context
[elab 3-typing.watsup:307.3-307.4] C  :  context
[notation 3-typing.watsup:307.8-307.44] {TABLE.FILL x} : {I32 rt I32} -> epsilon  :  instr : functype
[notation 3-typing.watsup:307.8-307.20] {TABLE.FILL x}  :  instr
[elab 3-typing.watsup:307.8-307.20] {TABLE.FILL x}  :  instr
[notation 3-typing.watsup:307.8-307.20] {x}  :  {tableidx}
[notation 3-typing.watsup:307.19-307.20] x  :  tableidx
[elab 3-typing.watsup:307.19-307.20] x  :  tableidx
[notation 3-typing.watsup:307.8-307.20] {}  :  {}
[notation 3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  functype
[elab 3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  functype
[notation 3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:307.23-307.33] {I32 rt I32}  :  resulttype
[elab 3-typing.watsup:307.23-307.33] {I32 rt I32}  :  resulttype
[elab 3-typing.watsup:307.23-307.26] I32  :  resulttype
[notation 3-typing.watsup:307.23-307.26] {}  :  {}
[elab 3-typing.watsup:307.27-307.29] rt  :  resulttype
[elab 3-typing.watsup:307.30-307.33] I32  :  resulttype
[notation 3-typing.watsup:307.30-307.33] {}  :  {}
[notation 3-typing.watsup:307.37-307.44] epsilon  :  resulttype
[elab 3-typing.watsup:307.37-307.44] epsilon  :  resulttype
[elab 3-typing.watsup:308.9-308.28] C.TABLE[x] = {lim rt}  :  bool
[elab 3-typing.watsup:308.9-308.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:308.9-308.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:308.9-308.10] C  :  context
[elab 3-typing.watsup:308.17-308.18] x  :  nat
[elab 3-typing.watsup:308.22-308.28] {lim rt}  :  tabletype
[notation 3-typing.watsup:308.22-308.28] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:308.22-308.25] lim  :  limits
[elab 3-typing.watsup:308.22-308.25] lim  :  limits
[notation 3-typing.watsup:308.22-308.28] {rt}  :  {reftype}
[notation 3-typing.watsup:308.26-308.28] rt  :  reftype
[elab 3-typing.watsup:308.26-308.28] rt  :  reftype
[notation 3-typing.watsup:308.22-308.28] {}  :  {}
[notation 3-typing.watsup:311.3-311.51] C |- {TABLE.COPY x_1 x_2} : {I32 I32 I32} -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:311.3-311.4] C  :  context
[elab 3-typing.watsup:311.3-311.4] C  :  context
[notation 3-typing.watsup:311.8-311.51] {TABLE.COPY x_1 x_2} : {I32 I32 I32} -> epsilon  :  instr : functype
[notation 3-typing.watsup:311.8-311.26] {TABLE.COPY x_1 x_2}  :  instr
[elab 3-typing.watsup:311.8-311.26] {TABLE.COPY x_1 x_2}  :  instr
[notation 3-typing.watsup:311.8-311.26] {x_1 x_2}  :  {tableidx tableidx}
[notation 3-typing.watsup:311.19-311.22] x_1  :  tableidx
[elab 3-typing.watsup:311.19-311.22] x_1  :  tableidx
[notation 3-typing.watsup:311.8-311.26] {x_2}  :  {tableidx}
[notation 3-typing.watsup:311.23-311.26] x_2  :  tableidx
[elab 3-typing.watsup:311.23-311.26] x_2  :  tableidx
[notation 3-typing.watsup:311.8-311.26] {}  :  {}
[notation 3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  functype
[elab 3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  functype
[notation 3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:311.29-311.40] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:311.29-311.40] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:311.29-311.32] I32  :  resulttype
[notation 3-typing.watsup:311.29-311.32] {}  :  {}
[elab 3-typing.watsup:311.33-311.36] I32  :  resulttype
[notation 3-typing.watsup:311.33-311.36] {}  :  {}
[elab 3-typing.watsup:311.37-311.40] I32  :  resulttype
[notation 3-typing.watsup:311.37-311.40] {}  :  {}
[notation 3-typing.watsup:311.44-311.51] epsilon  :  resulttype
[elab 3-typing.watsup:311.44-311.51] epsilon  :  resulttype
[elab 3-typing.watsup:312.9-312.32] C.TABLE[x_1] = {lim_1 rt}  :  bool
[elab 3-typing.watsup:312.9-312.21] C.TABLE[x_1]  :  tabletype
[elab 3-typing.watsup:312.9-312.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:312.9-312.10] C  :  context
[elab 3-typing.watsup:312.17-312.20] x_1  :  nat
[elab 3-typing.watsup:312.24-312.32] {lim_1 rt}  :  tabletype
[notation 3-typing.watsup:312.24-312.32] {lim_1 rt}  :  {limits reftype}
[notation 3-typing.watsup:312.24-312.29] lim_1  :  limits
[elab 3-typing.watsup:312.24-312.29] lim_1  :  limits
[notation 3-typing.watsup:312.24-312.32] {rt}  :  {reftype}
[notation 3-typing.watsup:312.30-312.32] rt  :  reftype
[elab 3-typing.watsup:312.30-312.32] rt  :  reftype
[notation 3-typing.watsup:312.24-312.32] {}  :  {}
[elab 3-typing.watsup:313.9-313.32] C.TABLE[x_2] = {lim_2 rt}  :  bool
[elab 3-typing.watsup:313.9-313.21] C.TABLE[x_2]  :  tabletype
[elab 3-typing.watsup:313.9-313.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:313.9-313.10] C  :  context
[elab 3-typing.watsup:313.17-313.20] x_2  :  nat
[elab 3-typing.watsup:313.24-313.32] {lim_2 rt}  :  tabletype
[notation 3-typing.watsup:313.24-313.32] {lim_2 rt}  :  {limits reftype}
[notation 3-typing.watsup:313.24-313.29] lim_2  :  limits
[elab 3-typing.watsup:313.24-313.29] lim_2  :  limits
[notation 3-typing.watsup:313.24-313.32] {rt}  :  {reftype}
[notation 3-typing.watsup:313.30-313.32] rt  :  reftype
[elab 3-typing.watsup:313.30-313.32] rt  :  reftype
[notation 3-typing.watsup:313.24-313.32] {}  :  {}
[notation 3-typing.watsup:316.3-316.51] C |- {TABLE.INIT x_1 x_2} : {I32 I32 I32} -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:316.3-316.4] C  :  context
[elab 3-typing.watsup:316.3-316.4] C  :  context
[notation 3-typing.watsup:316.8-316.51] {TABLE.INIT x_1 x_2} : {I32 I32 I32} -> epsilon  :  instr : functype
[notation 3-typing.watsup:316.8-316.26] {TABLE.INIT x_1 x_2}  :  instr
[elab 3-typing.watsup:316.8-316.26] {TABLE.INIT x_1 x_2}  :  instr
[notation 3-typing.watsup:316.8-316.26] {x_1 x_2}  :  {tableidx elemidx}
[notation 3-typing.watsup:316.19-316.22] x_1  :  tableidx
[elab 3-typing.watsup:316.19-316.22] x_1  :  tableidx
[notation 3-typing.watsup:316.8-316.26] {x_2}  :  {elemidx}
[notation 3-typing.watsup:316.23-316.26] x_2  :  elemidx
[elab 3-typing.watsup:316.23-316.26] x_2  :  elemidx
[notation 3-typing.watsup:316.8-316.26] {}  :  {}
[notation 3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  functype
[elab 3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  functype
[notation 3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:316.29-316.40] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:316.29-316.40] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:316.29-316.32] I32  :  resulttype
[notation 3-typing.watsup:316.29-316.32] {}  :  {}
[elab 3-typing.watsup:316.33-316.36] I32  :  resulttype
[notation 3-typing.watsup:316.33-316.36] {}  :  {}
[elab 3-typing.watsup:316.37-316.40] I32  :  resulttype
[notation 3-typing.watsup:316.37-316.40] {}  :  {}
[notation 3-typing.watsup:316.44-316.51] epsilon  :  resulttype
[elab 3-typing.watsup:316.44-316.51] epsilon  :  resulttype
[elab 3-typing.watsup:317.9-317.30] C.TABLE[x_1] = {lim rt}  :  bool
[elab 3-typing.watsup:317.9-317.21] C.TABLE[x_1]  :  tabletype
[elab 3-typing.watsup:317.9-317.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:317.9-317.10] C  :  context
[elab 3-typing.watsup:317.17-317.20] x_1  :  nat
[elab 3-typing.watsup:317.24-317.30] {lim rt}  :  tabletype
[notation 3-typing.watsup:317.24-317.30] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:317.24-317.27] lim  :  limits
[elab 3-typing.watsup:317.24-317.27] lim  :  limits
[notation 3-typing.watsup:317.24-317.30] {rt}  :  {reftype}
[notation 3-typing.watsup:317.28-317.30] rt  :  reftype
[elab 3-typing.watsup:317.28-317.30] rt  :  reftype
[notation 3-typing.watsup:317.24-317.30] {}  :  {}
[elab 3-typing.watsup:318.9-318.25] C.ELEM[x_2] = rt  :  bool
[elab 3-typing.watsup:318.9-318.20] C.ELEM[x_2]  :  elemtype
[elab 3-typing.watsup:318.9-318.15] C.ELEM  :  elemtype*
[elab 3-typing.watsup:318.9-318.10] C  :  context
[elab 3-typing.watsup:318.16-318.19] x_2  :  nat
[elab 3-typing.watsup:318.23-318.25] rt  :  elemtype
[notation 3-typing.watsup:321.3-321.40] C |- {ELEM.DROP x} : epsilon -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:321.3-321.4] C  :  context
[elab 3-typing.watsup:321.3-321.4] C  :  context
[notation 3-typing.watsup:321.8-321.40] {ELEM.DROP x} : epsilon -> epsilon  :  instr : functype
[notation 3-typing.watsup:321.8-321.19] {ELEM.DROP x}  :  instr
[elab 3-typing.watsup:321.8-321.19] {ELEM.DROP x}  :  instr
[notation 3-typing.watsup:321.8-321.19] {x}  :  {elemidx}
[notation 3-typing.watsup:321.18-321.19] x  :  elemidx
[elab 3-typing.watsup:321.18-321.19] x  :  elemidx
[notation 3-typing.watsup:321.8-321.19] {}  :  {}
[notation 3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  functype
[elab 3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  functype
[notation 3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:321.22-321.29] epsilon  :  resulttype
[elab 3-typing.watsup:321.22-321.29] epsilon  :  resulttype
[notation 3-typing.watsup:321.33-321.40] epsilon  :  resulttype
[elab 3-typing.watsup:321.33-321.40] epsilon  :  resulttype
[elab 3-typing.watsup:322.9-322.23] C.ELEM[x] = rt  :  bool
[elab 3-typing.watsup:322.9-322.18] C.ELEM[x]  :  elemtype
[elab 3-typing.watsup:322.9-322.15] C.ELEM  :  elemtype*
[elab 3-typing.watsup:322.9-322.10] C  :  context
[elab 3-typing.watsup:322.16-322.17] x  :  nat
[elab 3-typing.watsup:322.21-322.23] rt  :  elemtype
[notation 3-typing.watsup:326.3-326.36] C |- MEMORY.SIZE : epsilon -> I32  :  context |- instr : functype
[notation 3-typing.watsup:326.3-326.4] C  :  context
[elab 3-typing.watsup:326.3-326.4] C  :  context
[notation 3-typing.watsup:326.8-326.36] MEMORY.SIZE : epsilon -> I32  :  instr : functype
[notation 3-typing.watsup:326.8-326.19] MEMORY.SIZE  :  instr
[elab 3-typing.watsup:326.8-326.19] MEMORY.SIZE  :  instr
[notation 3-typing.watsup:326.8-326.19] {}  :  {}
[notation 3-typing.watsup:326.22-326.36] epsilon -> I32  :  functype
[elab 3-typing.watsup:326.22-326.36] epsilon -> I32  :  functype
[notation 3-typing.watsup:326.22-326.36] epsilon -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:326.22-326.29] epsilon  :  resulttype
[elab 3-typing.watsup:326.22-326.29] epsilon  :  resulttype
[notation 3-typing.watsup:326.33-326.36] I32  :  resulttype
[elab 3-typing.watsup:326.33-326.36] I32  :  resulttype
[notation 3-typing.watsup:326.33-326.36] {}  :  {}
[elab 3-typing.watsup:327.9-327.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:327.9-327.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:327.9-327.14] C.MEM  :  memtype*
[elab 3-typing.watsup:327.9-327.10] C  :  context
[elab 3-typing.watsup:327.15-327.16] 0  :  nat
[elab 3-typing.watsup:327.20-327.22] mt  :  memtype
[notation 3-typing.watsup:330.3-330.32] C |- MEMORY.GROW : I32 -> I32  :  context |- instr : functype
[notation 3-typing.watsup:330.3-330.4] C  :  context
[elab 3-typing.watsup:330.3-330.4] C  :  context
[notation 3-typing.watsup:330.8-330.32] MEMORY.GROW : I32 -> I32  :  instr : functype
[notation 3-typing.watsup:330.8-330.19] MEMORY.GROW  :  instr
[elab 3-typing.watsup:330.8-330.19] MEMORY.GROW  :  instr
[notation 3-typing.watsup:330.8-330.19] {}  :  {}
[notation 3-typing.watsup:330.22-330.32] I32 -> I32  :  functype
[elab 3-typing.watsup:330.22-330.32] I32 -> I32  :  functype
[notation 3-typing.watsup:330.22-330.32] I32 -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:330.22-330.25] I32  :  resulttype
[elab 3-typing.watsup:330.22-330.25] I32  :  resulttype
[notation 3-typing.watsup:330.22-330.25] {}  :  {}
[notation 3-typing.watsup:330.29-330.32] I32  :  resulttype
[elab 3-typing.watsup:330.29-330.32] I32  :  resulttype
[notation 3-typing.watsup:330.29-330.32] {}  :  {}
[elab 3-typing.watsup:331.9-331.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:331.9-331.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:331.9-331.14] C.MEM  :  memtype*
[elab 3-typing.watsup:331.9-331.10] C  :  context
[elab 3-typing.watsup:331.15-331.16] 0  :  nat
[elab 3-typing.watsup:331.20-331.22] mt  :  memtype
[notation 3-typing.watsup:334.3-334.40] C |- MEMORY.FILL : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation 3-typing.watsup:334.3-334.4] C  :  context
[elab 3-typing.watsup:334.3-334.4] C  :  context
[notation 3-typing.watsup:334.8-334.40] MEMORY.FILL : {I32 I32 I32} -> I32  :  instr : functype
[notation 3-typing.watsup:334.8-334.19] MEMORY.FILL  :  instr
[elab 3-typing.watsup:334.8-334.19] MEMORY.FILL  :  instr
[notation 3-typing.watsup:334.8-334.19] {}  :  {}
[notation 3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  functype
[elab 3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  functype
[notation 3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:334.22-334.33] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:334.22-334.33] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:334.22-334.25] I32  :  resulttype
[notation 3-typing.watsup:334.22-334.25] {}  :  {}
[elab 3-typing.watsup:334.26-334.29] I32  :  resulttype
[notation 3-typing.watsup:334.26-334.29] {}  :  {}
[elab 3-typing.watsup:334.30-334.33] I32  :  resulttype
[notation 3-typing.watsup:334.30-334.33] {}  :  {}
[notation 3-typing.watsup:334.37-334.40] I32  :  resulttype
[elab 3-typing.watsup:334.37-334.40] I32  :  resulttype
[notation 3-typing.watsup:334.37-334.40] {}  :  {}
[elab 3-typing.watsup:335.9-335.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:335.9-335.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:335.9-335.14] C.MEM  :  memtype*
[elab 3-typing.watsup:335.9-335.10] C  :  context
[elab 3-typing.watsup:335.15-335.16] 0  :  nat
[elab 3-typing.watsup:335.20-335.22] mt  :  memtype
[notation 3-typing.watsup:338.3-338.40] C |- MEMORY.COPY : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation 3-typing.watsup:338.3-338.4] C  :  context
[elab 3-typing.watsup:338.3-338.4] C  :  context
[notation 3-typing.watsup:338.8-338.40] MEMORY.COPY : {I32 I32 I32} -> I32  :  instr : functype
[notation 3-typing.watsup:338.8-338.19] MEMORY.COPY  :  instr
[elab 3-typing.watsup:338.8-338.19] MEMORY.COPY  :  instr
[notation 3-typing.watsup:338.8-338.19] {}  :  {}
[notation 3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  functype
[elab 3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  functype
[notation 3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:338.22-338.33] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:338.22-338.33] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:338.22-338.25] I32  :  resulttype
[notation 3-typing.watsup:338.22-338.25] {}  :  {}
[elab 3-typing.watsup:338.26-338.29] I32  :  resulttype
[notation 3-typing.watsup:338.26-338.29] {}  :  {}
[elab 3-typing.watsup:338.30-338.33] I32  :  resulttype
[notation 3-typing.watsup:338.30-338.33] {}  :  {}
[notation 3-typing.watsup:338.37-338.40] I32  :  resulttype
[elab 3-typing.watsup:338.37-338.40] I32  :  resulttype
[notation 3-typing.watsup:338.37-338.40] {}  :  {}
[elab 3-typing.watsup:339.9-339.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:339.9-339.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:339.9-339.14] C.MEM  :  memtype*
[elab 3-typing.watsup:339.9-339.10] C  :  context
[elab 3-typing.watsup:339.15-339.16] 0  :  nat
[elab 3-typing.watsup:339.20-339.22] mt  :  memtype
[notation 3-typing.watsup:342.3-342.42] C |- {MEMORY.INIT x} : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation 3-typing.watsup:342.3-342.4] C  :  context
[elab 3-typing.watsup:342.3-342.4] C  :  context
[notation 3-typing.watsup:342.8-342.42] {MEMORY.INIT x} : {I32 I32 I32} -> I32  :  instr : functype
[notation 3-typing.watsup:342.8-342.21] {MEMORY.INIT x}  :  instr
[elab 3-typing.watsup:342.8-342.21] {MEMORY.INIT x}  :  instr
[notation 3-typing.watsup:342.8-342.21] {x}  :  {dataidx}
[notation 3-typing.watsup:342.20-342.21] x  :  dataidx
[elab 3-typing.watsup:342.20-342.21] x  :  dataidx
[notation 3-typing.watsup:342.8-342.21] {}  :  {}
[notation 3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  functype
[elab 3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  functype
[notation 3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation 3-typing.watsup:342.24-342.35] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:342.24-342.35] {I32 I32 I32}  :  resulttype
[elab 3-typing.watsup:342.24-342.27] I32  :  resulttype
[notation 3-typing.watsup:342.24-342.27] {}  :  {}
[elab 3-typing.watsup:342.28-342.31] I32  :  resulttype
[notation 3-typing.watsup:342.28-342.31] {}  :  {}
[elab 3-typing.watsup:342.32-342.35] I32  :  resulttype
[notation 3-typing.watsup:342.32-342.35] {}  :  {}
[notation 3-typing.watsup:342.39-342.42] I32  :  resulttype
[elab 3-typing.watsup:342.39-342.42] I32  :  resulttype
[notation 3-typing.watsup:342.39-342.42] {}  :  {}
[elab 3-typing.watsup:343.9-343.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:343.9-343.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:343.9-343.14] C.MEM  :  memtype*
[elab 3-typing.watsup:343.9-343.10] C  :  context
[elab 3-typing.watsup:343.15-343.16] 0  :  nat
[elab 3-typing.watsup:343.20-343.22] mt  :  memtype
[elab 3-typing.watsup:344.9-344.23] C.DATA[x] = OK  :  bool
[elab 3-typing.watsup:344.9-344.18] C.DATA[x]  :  datatype
[elab 3-typing.watsup:344.9-344.15] C.DATA  :  datatype*
[elab 3-typing.watsup:344.9-344.10] C  :  context
[elab 3-typing.watsup:344.16-344.17] x  :  nat
[elab 3-typing.watsup:344.21-344.23] OK  :  datatype
[notation 3-typing.watsup:344.21-344.23] OK  :  OK
[notation 3-typing.watsup:347.3-347.40] C |- {DATA.DROP x} : epsilon -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:347.3-347.4] C  :  context
[elab 3-typing.watsup:347.3-347.4] C  :  context
[notation 3-typing.watsup:347.8-347.40] {DATA.DROP x} : epsilon -> epsilon  :  instr : functype
[notation 3-typing.watsup:347.8-347.19] {DATA.DROP x}  :  instr
[elab 3-typing.watsup:347.8-347.19] {DATA.DROP x}  :  instr
[notation 3-typing.watsup:347.8-347.19] {x}  :  {dataidx}
[notation 3-typing.watsup:347.18-347.19] x  :  dataidx
[elab 3-typing.watsup:347.18-347.19] x  :  dataidx
[notation 3-typing.watsup:347.8-347.19] {}  :  {}
[notation 3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  functype
[elab 3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  functype
[notation 3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:347.22-347.29] epsilon  :  resulttype
[elab 3-typing.watsup:347.22-347.29] epsilon  :  resulttype
[notation 3-typing.watsup:347.33-347.40] epsilon  :  resulttype
[elab 3-typing.watsup:347.33-347.40] epsilon  :  resulttype
[elab 3-typing.watsup:348.9-348.23] C.DATA[x] = OK  :  bool
[elab 3-typing.watsup:348.9-348.18] C.DATA[x]  :  datatype
[elab 3-typing.watsup:348.9-348.15] C.DATA  :  datatype*
[elab 3-typing.watsup:348.9-348.10] C  :  context
[elab 3-typing.watsup:348.16-348.17] x  :  nat
[elab 3-typing.watsup:348.21-348.23] OK  :  datatype
[notation 3-typing.watsup:348.21-348.23] OK  :  OK
[notation 3-typing.watsup:351.3-351.43] C |- {LOAD nt ({n sx})? n_A n_O} : I32 -> nt  :  context |- instr : functype
[notation 3-typing.watsup:351.3-351.4] C  :  context
[elab 3-typing.watsup:351.3-351.4] C  :  context
[notation 3-typing.watsup:351.8-351.43] {LOAD nt ({n sx})? n_A n_O} : I32 -> nt  :  instr : functype
[notation 3-typing.watsup:351.8-351.31] {LOAD nt ({n sx})? n_A n_O}  :  instr
[elab 3-typing.watsup:351.8-351.31] {LOAD nt ({n sx})? n_A n_O}  :  instr
[notation 3-typing.watsup:351.8-351.31] {nt ({n sx})? n_A n_O}  :  {numtype ({n sx})? nat nat}
[notation 3-typing.watsup:351.13-351.15] nt  :  numtype
[elab 3-typing.watsup:351.13-351.15] nt  :  numtype
[notation 3-typing.watsup:351.8-351.31] {({n sx})? n_A n_O}  :  {({n sx})? nat nat}
[notation 3-typing.watsup:351.16-351.23] ({n sx})?  :  ({n sx})?
[notation 3-typing.watsup:351.16-351.22] ({n sx})  :  ({n sx})
[notation 3-typing.watsup:351.17-351.21] {n sx}  :  ({n sx})
[notation 3-typing.watsup:351.17-351.21] {n sx}  :  {n sx}
[notation 3-typing.watsup:351.17-351.18] n  :  n
[elab 3-typing.watsup:351.17-351.18] n  :  n
[notation 3-typing.watsup:351.17-351.21] {sx}  :  {sx}
[notation 3-typing.watsup:351.19-351.21] sx  :  sx
[elab 3-typing.watsup:351.19-351.21] sx  :  sx
[notation 3-typing.watsup:351.17-351.21] {}  :  {}
[notation 3-typing.watsup:351.8-351.31] {n_A n_O}  :  {nat nat}
[notation 3-typing.watsup:351.24-351.27] n_A  :  nat
[elab 3-typing.watsup:351.24-351.27] n_A  :  nat
[notation 3-typing.watsup:351.8-351.31] {n_O}  :  {nat}
[notation 3-typing.watsup:351.28-351.31] n_O  :  nat
[elab 3-typing.watsup:351.28-351.31] n_O  :  nat
[notation 3-typing.watsup:351.8-351.31] {}  :  {}
[notation 3-typing.watsup:351.34-351.43] I32 -> nt  :  functype
[elab 3-typing.watsup:351.34-351.43] I32 -> nt  :  functype
[notation 3-typing.watsup:351.34-351.43] I32 -> nt  :  resulttype -> resulttype
[notation 3-typing.watsup:351.34-351.37] I32  :  resulttype
[elab 3-typing.watsup:351.34-351.37] I32  :  resulttype
[notation 3-typing.watsup:351.34-351.37] {}  :  {}
[notation 3-typing.watsup:351.41-351.43] nt  :  resulttype
[elab 3-typing.watsup:351.41-351.43] nt  :  resulttype
[elab 3-typing.watsup:352.9-352.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:352.9-352.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:352.9-352.14] C.MEM  :  memtype*
[elab 3-typing.watsup:352.9-352.10] C  :  context
[elab 3-typing.watsup:352.15-352.16] 0  :  nat
[elab 3-typing.watsup:352.20-352.22] mt  :  memtype
[elab 3-typing.watsup:353.9-353.33] 2 ^ (n_A) <= $size(t) / 8  :  bool
[elab 3-typing.watsup:353.11-353.18] 2 ^ (n_A)  :  nat
[elab 3-typing.watsup:353.11-353.12] 2  :  nat
[elab 3-typing.watsup:353.13-353.18] (n_A)  :  nat
[elab 3-typing.watsup:353.14-353.17] n_A  :  nat
[elab 3-typing.watsup:353.22-353.32] $size(t) / 8  :  nat
[elab 3-typing.watsup:353.22-353.30] $size(t)  :  nat
[elab 3-typing.watsup:353.27-353.30] (t)  :  (valtype)
[elab 3-typing.watsup:353.28-353.29] t  :  (valtype)
[elab 3-typing.watsup:353.31-353.32] 8  :  nat
[elab 3-typing.watsup:354.9-354.39] 2 ^ (n_A) <= n / 8 < $size(t) / 8  :  bool
[elab 3-typing.watsup:354.11-354.18] 2 ^ (n_A)  :  nat
[elab 3-typing.watsup:354.11-354.12] 2  :  nat
[elab 3-typing.watsup:354.13-354.18] (n_A)  :  nat
[elab 3-typing.watsup:354.14-354.17] n_A  :  nat
[elab 3-typing.watsup:354.22-354.25] n / 8  :  nat
[elab 3-typing.watsup:354.22-354.23] n  :  nat
[elab 3-typing.watsup:354.24-354.25] 8  :  nat
[elab 3-typing.watsup:354.22-354.38] n / 8 < $size(t) / 8  :  bool
[elab 3-typing.watsup:354.22-354.25] n / 8  :  nat
[elab 3-typing.watsup:354.22-354.23] n  :  nat
[elab 3-typing.watsup:354.24-354.25] 8  :  nat
[elab 3-typing.watsup:354.28-354.38] $size(t) / 8  :  nat
[elab 3-typing.watsup:354.28-354.36] $size(t)  :  nat
[elab 3-typing.watsup:354.33-354.36] (t)  :  (valtype)
[elab 3-typing.watsup:354.34-354.35] t  :  (valtype)
[elab 3-typing.watsup:354.37-354.38] 8  :  nat
[elab 3-typing.watsup:355.9-355.32] n? = epsilon \/ nt = in  :  bool
[elab 3-typing.watsup:355.9-355.21] n? = epsilon  :  bool
[elab 3-typing.watsup:355.9-355.11] n?  :  n?
[elab 3-typing.watsup:355.9-355.10] n  :  n
[elab 3-typing.watsup:355.14-355.21] epsilon  :  n?
[elab 3-typing.watsup:355.25-355.32] nt = in  :  bool
[elab 3-typing.watsup:355.25-355.27] nt  :  numtype
[elab 3-typing.watsup:355.30-355.32] in  :  numtype
[notation 3-typing.watsup:358.3-358.47] C |- {STORE nt n? n_A n_O} : {I32 nt} -> epsilon  :  context |- instr : functype
[notation 3-typing.watsup:358.3-358.4] C  :  context
[elab 3-typing.watsup:358.3-358.4] C  :  context
[notation 3-typing.watsup:358.8-358.47] {STORE nt n? n_A n_O} : {I32 nt} -> epsilon  :  instr : functype
[notation 3-typing.watsup:358.8-358.27] {STORE nt n? n_A n_O}  :  instr
[elab 3-typing.watsup:358.8-358.27] {STORE nt n? n_A n_O}  :  instr
[notation 3-typing.watsup:358.8-358.27] {nt n? n_A n_O}  :  {numtype n? nat nat}
[notation 3-typing.watsup:358.14-358.16] nt  :  numtype
[elab 3-typing.watsup:358.14-358.16] nt  :  numtype
[notation 3-typing.watsup:358.8-358.27] {n? n_A n_O}  :  {n? nat nat}
[notation 3-typing.watsup:358.17-358.19] n?  :  n?
[notation 3-typing.watsup:358.17-358.18] n  :  n
[elab 3-typing.watsup:358.17-358.18] n  :  n
[notation 3-typing.watsup:358.8-358.27] {n_A n_O}  :  {nat nat}
[notation 3-typing.watsup:358.20-358.23] n_A  :  nat
[elab 3-typing.watsup:358.20-358.23] n_A  :  nat
[notation 3-typing.watsup:358.8-358.27] {n_O}  :  {nat}
[notation 3-typing.watsup:358.24-358.27] n_O  :  nat
[elab 3-typing.watsup:358.24-358.27] n_O  :  nat
[notation 3-typing.watsup:358.8-358.27] {}  :  {}
[notation 3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  functype
[elab 3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  functype
[notation 3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:358.30-358.36] {I32 nt}  :  resulttype
[elab 3-typing.watsup:358.30-358.36] {I32 nt}  :  resulttype
[elab 3-typing.watsup:358.30-358.33] I32  :  resulttype
[notation 3-typing.watsup:358.30-358.33] {}  :  {}
[elab 3-typing.watsup:358.34-358.36] nt  :  resulttype
[notation 3-typing.watsup:358.40-358.47] epsilon  :  resulttype
[elab 3-typing.watsup:358.40-358.47] epsilon  :  resulttype
[elab 3-typing.watsup:359.9-359.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:359.9-359.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:359.9-359.14] C.MEM  :  memtype*
[elab 3-typing.watsup:359.9-359.10] C  :  context
[elab 3-typing.watsup:359.15-359.16] 0  :  nat
[elab 3-typing.watsup:359.20-359.22] mt  :  memtype
[elab 3-typing.watsup:360.9-360.33] 2 ^ (n_A) <= $size(t) / 8  :  bool
[elab 3-typing.watsup:360.11-360.18] 2 ^ (n_A)  :  nat
[elab 3-typing.watsup:360.11-360.12] 2  :  nat
[elab 3-typing.watsup:360.13-360.18] (n_A)  :  nat
[elab 3-typing.watsup:360.14-360.17] n_A  :  nat
[elab 3-typing.watsup:360.22-360.32] $size(t) / 8  :  nat
[elab 3-typing.watsup:360.22-360.30] $size(t)  :  nat
[elab 3-typing.watsup:360.27-360.30] (t)  :  (valtype)
[elab 3-typing.watsup:360.28-360.29] t  :  (valtype)
[elab 3-typing.watsup:360.31-360.32] 8  :  nat
[elab 3-typing.watsup:361.9-361.39] 2 ^ (n_A) <= n / 8 < $size(t) / 8  :  bool
[elab 3-typing.watsup:361.11-361.18] 2 ^ (n_A)  :  nat
[elab 3-typing.watsup:361.11-361.12] 2  :  nat
[elab 3-typing.watsup:361.13-361.18] (n_A)  :  nat
[elab 3-typing.watsup:361.14-361.17] n_A  :  nat
[elab 3-typing.watsup:361.22-361.25] n / 8  :  nat
[elab 3-typing.watsup:361.22-361.23] n  :  nat
[elab 3-typing.watsup:361.24-361.25] 8  :  nat
[elab 3-typing.watsup:361.22-361.38] n / 8 < $size(t) / 8  :  bool
[elab 3-typing.watsup:361.22-361.25] n / 8  :  nat
[elab 3-typing.watsup:361.22-361.23] n  :  nat
[elab 3-typing.watsup:361.24-361.25] 8  :  nat
[elab 3-typing.watsup:361.28-361.38] $size(t) / 8  :  nat
[elab 3-typing.watsup:361.28-361.36] $size(t)  :  nat
[elab 3-typing.watsup:361.33-361.36] (t)  :  (valtype)
[elab 3-typing.watsup:361.34-361.35] t  :  (valtype)
[elab 3-typing.watsup:361.37-361.38] 8  :  nat
[elab 3-typing.watsup:362.9-362.32] n? = epsilon \/ nt = in  :  bool
[elab 3-typing.watsup:362.9-362.21] n? = epsilon  :  bool
[elab 3-typing.watsup:362.9-362.11] n?  :  n?
[elab 3-typing.watsup:362.9-362.10] n  :  n
[elab 3-typing.watsup:362.14-362.21] epsilon  :  n?
[elab 3-typing.watsup:362.25-362.32] nt = in  :  bool
[elab 3-typing.watsup:362.25-362.27] nt  :  numtype
[elab 3-typing.watsup:362.30-362.32] in  :  numtype
[notation 3-typing.watsup:372.3-372.26] C |- {({CONST nt c}) CONST}  :  context |- {instr CONST}
[notation 3-typing.watsup:372.3-372.4] C  :  context
[elab 3-typing.watsup:372.3-372.4] C  :  context
[notation 3-typing.watsup:372.8-372.26] {({CONST nt c}) CONST}  :  {instr CONST}
[notation 3-typing.watsup:372.9-372.19] {CONST nt c}  :  instr
[elab 3-typing.watsup:372.9-372.19] {CONST nt c}  :  instr
[notation 3-typing.watsup:372.9-372.19] {nt c}  :  {numtype c_numtype}
[notation 3-typing.watsup:372.15-372.17] nt  :  numtype
[elab 3-typing.watsup:372.15-372.17] nt  :  numtype
[notation 3-typing.watsup:372.9-372.19] {c}  :  {c_numtype}
[notation 3-typing.watsup:372.18-372.19] c  :  c_numtype
[elab 3-typing.watsup:372.18-372.19] c  :  c_numtype
[notation 3-typing.watsup:372.9-372.19] {}  :  {}
[notation 3-typing.watsup:372.8-372.26] {CONST}  :  {CONST}
[notation 3-typing.watsup:372.21-372.26] CONST  :  CONST
[notation 3-typing.watsup:372.8-372.26] {}  :  {}
[notation 3-typing.watsup:375.3-375.27] C |- {({REF.NULL rt}) CONST}  :  context |- {instr CONST}
[notation 3-typing.watsup:375.3-375.4] C  :  context
[elab 3-typing.watsup:375.3-375.4] C  :  context
[notation 3-typing.watsup:375.8-375.27] {({REF.NULL rt}) CONST}  :  {instr CONST}
[notation 3-typing.watsup:375.9-375.20] {REF.NULL rt}  :  instr
[elab 3-typing.watsup:375.9-375.20] {REF.NULL rt}  :  instr
[notation 3-typing.watsup:375.9-375.20] {rt}  :  {reftype}
[notation 3-typing.watsup:375.18-375.20] rt  :  reftype
[elab 3-typing.watsup:375.18-375.20] rt  :  reftype
[notation 3-typing.watsup:375.9-375.20] {}  :  {}
[notation 3-typing.watsup:375.8-375.27] {CONST}  :  {CONST}
[notation 3-typing.watsup:375.22-375.27] CONST  :  CONST
[notation 3-typing.watsup:375.8-375.27] {}  :  {}
[notation 3-typing.watsup:378.3-378.26] C |- {({REF.FUNC x}) CONST}  :  context |- {instr CONST}
[notation 3-typing.watsup:378.3-378.4] C  :  context
[elab 3-typing.watsup:378.3-378.4] C  :  context
[notation 3-typing.watsup:378.8-378.26] {({REF.FUNC x}) CONST}  :  {instr CONST}
[notation 3-typing.watsup:378.9-378.19] {REF.FUNC x}  :  instr
[elab 3-typing.watsup:378.9-378.19] {REF.FUNC x}  :  instr
[notation 3-typing.watsup:378.9-378.19] {x}  :  {funcidx}
[notation 3-typing.watsup:378.18-378.19] x  :  funcidx
[elab 3-typing.watsup:378.18-378.19] x  :  funcidx
[notation 3-typing.watsup:378.9-378.19] {}  :  {}
[notation 3-typing.watsup:378.8-378.26] {CONST}  :  {CONST}
[notation 3-typing.watsup:378.21-378.26] CONST  :  CONST
[notation 3-typing.watsup:378.8-378.26] {}  :  {}
[notation 3-typing.watsup:381.3-381.28] C |- {({GLOBAL.GET x}) CONST}  :  context |- {instr CONST}
[notation 3-typing.watsup:381.3-381.4] C  :  context
[elab 3-typing.watsup:381.3-381.4] C  :  context
[notation 3-typing.watsup:381.8-381.28] {({GLOBAL.GET x}) CONST}  :  {instr CONST}
[notation 3-typing.watsup:381.9-381.21] {GLOBAL.GET x}  :  instr
[elab 3-typing.watsup:381.9-381.21] {GLOBAL.GET x}  :  instr
[notation 3-typing.watsup:381.9-381.21] {x}  :  {globalidx}
[notation 3-typing.watsup:381.20-381.21] x  :  globalidx
[elab 3-typing.watsup:381.20-381.21] x  :  globalidx
[notation 3-typing.watsup:381.9-381.21] {}  :  {}
[notation 3-typing.watsup:381.8-381.28] {CONST}  :  {CONST}
[notation 3-typing.watsup:381.23-381.28] CONST  :  CONST
[notation 3-typing.watsup:381.8-381.28] {}  :  {}
[elab 3-typing.watsup:382.9-382.32] C.GLOBAL[x] = {epsilon t}  :  bool
[elab 3-typing.watsup:382.9-382.20] C.GLOBAL[x]  :  globaltype
[elab 3-typing.watsup:382.9-382.17] C.GLOBAL  :  globaltype*
[elab 3-typing.watsup:382.9-382.10] C  :  context
[elab 3-typing.watsup:382.18-382.19] x  :  nat
[elab 3-typing.watsup:382.23-382.32] {epsilon t}  :  globaltype
[notation 3-typing.watsup:382.23-382.32] {epsilon t}  :  {MUT? valtype}
[notation 3-typing.watsup:382.23-382.30] epsilon  :  MUT?
[niteration 3-typing.watsup:382.23-382.30]   :  MUT?
[notation 3-typing.watsup:382.23-382.32] {t}  :  {valtype}
[notation 3-typing.watsup:382.31-382.32] t  :  valtype
[elab 3-typing.watsup:382.31-382.32] t  :  valtype
[notation 3-typing.watsup:382.23-382.32] {}  :  {}
[notation 3-typing.watsup:385.18-385.35] C |- {instr* CONST}  :  context |- {expr CONST}
[notation 3-typing.watsup:385.18-385.19] C  :  context
[elab 3-typing.watsup:385.18-385.19] C  :  context
[notation 3-typing.watsup:385.23-385.35] {instr* CONST}  :  {expr CONST}
[notation 3-typing.watsup:385.23-385.29] instr*  :  expr
[elab 3-typing.watsup:385.23-385.29] instr*  :  expr
[elab 3-typing.watsup:385.23-385.28] instr  :  instr
[notation 3-typing.watsup:385.23-385.35] {CONST}  :  {CONST}
[notation 3-typing.watsup:385.30-385.35] CONST  :  CONST
[notation 3-typing.watsup:385.23-385.35] {}  :  {}
[notation 3-typing.watsup:386.20-386.36] C |- {instr CONST}  :  context |- {instr CONST}
[notation 3-typing.watsup:386.20-386.21] C  :  context
[elab 3-typing.watsup:386.20-386.21] C  :  context
[notation 3-typing.watsup:386.25-386.36] {instr CONST}  :  {instr CONST}
[notation 3-typing.watsup:386.25-386.30] instr  :  instr
[elab 3-typing.watsup:386.25-386.30] instr  :  instr
[notation 3-typing.watsup:386.25-386.36] {CONST}  :  {CONST}
[notation 3-typing.watsup:386.31-386.36] CONST  :  CONST
[notation 3-typing.watsup:386.25-386.36] {}  :  {}
[notation 3-typing.watsup:390.3-390.22] C |- expr : {t CONST}  :  context |- expr : {valtype CONST}
[notation 3-typing.watsup:390.3-390.4] C  :  context
[elab 3-typing.watsup:390.3-390.4] C  :  context
[notation 3-typing.watsup:390.8-390.22] expr : {t CONST}  :  expr : {valtype CONST}
[notation 3-typing.watsup:390.8-390.12] expr  :  expr
[elab 3-typing.watsup:390.8-390.12] expr  :  expr
[notation 3-typing.watsup:390.15-390.22] {t CONST}  :  {valtype CONST}
[notation 3-typing.watsup:390.15-390.16] t  :  valtype
[elab 3-typing.watsup:390.15-390.16] t  :  valtype
[notation 3-typing.watsup:390.15-390.22] {CONST}  :  {CONST}
[notation 3-typing.watsup:390.17-390.22] CONST  :  CONST
[notation 3-typing.watsup:390.15-390.22] {}  :  {}
[notation 3-typing.watsup:391.15-391.28] C |- expr : t  :  context |- expr : resulttype
[notation 3-typing.watsup:391.15-391.16] C  :  context
[elab 3-typing.watsup:391.15-391.16] C  :  context
[notation 3-typing.watsup:391.20-391.28] expr : t  :  expr : resulttype
[notation 3-typing.watsup:391.20-391.24] expr  :  expr
[elab 3-typing.watsup:391.20-391.24] expr  :  expr
[notation 3-typing.watsup:391.27-391.28] t  :  resulttype
[elab 3-typing.watsup:391.27-391.28] t  :  resulttype
[notation 3-typing.watsup:392.18-392.33] C |- {expr CONST}  :  context |- {expr CONST}
[notation 3-typing.watsup:392.18-392.19] C  :  context
[elab 3-typing.watsup:392.18-392.19] C  :  context
[notation 3-typing.watsup:392.23-392.33] {expr CONST}  :  {expr CONST}
[notation 3-typing.watsup:392.23-392.27] expr  :  expr
[elab 3-typing.watsup:392.23-392.27] expr  :  expr
[notation 3-typing.watsup:392.23-392.33] {CONST}  :  {CONST}
[notation 3-typing.watsup:392.28-392.33] CONST  :  CONST
[notation 3-typing.watsup:392.23-392.33] {}  :  {}
[notation 3-typing.watsup:409.3-409.28] C |- {FUNC ft t* expr} : ft  :  context |- func : functype
[notation 3-typing.watsup:409.3-409.4] C  :  context
[elab 3-typing.watsup:409.3-409.4] C  :  context
[notation 3-typing.watsup:409.8-409.28] {FUNC ft t* expr} : ft  :  func : functype
[notation 3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  func
[elab 3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  func
[notation 3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  {FUNC functype valtype* expr}
[notation 3-typing.watsup:409.8-409.12] FUNC  :  FUNC
[notation 3-typing.watsup:409.8-409.23] {ft t* expr}  :  {functype valtype* expr}
[notation 3-typing.watsup:409.13-409.15] ft  :  functype
[elab 3-typing.watsup:409.13-409.15] ft  :  functype
[notation 3-typing.watsup:409.8-409.23] {t* expr}  :  {valtype* expr}
[notation 3-typing.watsup:409.16-409.18] t*  :  valtype*
[notation 3-typing.watsup:409.16-409.17] t  :  valtype
[elab 3-typing.watsup:409.16-409.17] t  :  valtype
[notation 3-typing.watsup:409.8-409.23] {expr}  :  {expr}
[notation 3-typing.watsup:409.19-409.23] expr  :  expr
[elab 3-typing.watsup:409.19-409.23] expr  :  expr
[notation 3-typing.watsup:409.8-409.23] {}  :  {}
[notation 3-typing.watsup:409.26-409.28] ft  :  functype
[elab 3-typing.watsup:409.26-409.28] ft  :  functype
[elab 3-typing.watsup:410.9-410.26] ft = t_1* -> t_2*  :  bool
[elab 3-typing.watsup:410.9-410.11] ft  :  functype
[elab 3-typing.watsup:410.14-410.26] t_1* -> t_2*  :  functype
[notation 3-typing.watsup:410.14-410.26] t_1* -> t_2*  :  resulttype -> resulttype
[notation 3-typing.watsup:410.14-410.18] t_1*  :  resulttype
[elab 3-typing.watsup:410.14-410.18] t_1*  :  resulttype
[elab 3-typing.watsup:410.14-410.17] t_1  :  valtype
[notation 3-typing.watsup:410.22-410.26] t_2*  :  resulttype
[elab 3-typing.watsup:410.22-410.26] t_2*  :  resulttype
[elab 3-typing.watsup:410.22-410.25] t_2  :  valtype
[notation 3-typing.watsup:411.19-411.29] {} |- ft : OK  :  {} |- functype : OK
[notation 3-typing.watsup:411.19-411.21] {}  :  {}
[notation 3-typing.watsup:411.22-411.29] ft : OK  :  functype : OK
[notation 3-typing.watsup:411.22-411.24] ft  :  functype
[elab 3-typing.watsup:411.22-411.24] ft  :  functype
[notation 3-typing.watsup:411.27-411.29] OK  :  OK
[notation 3-typing.watsup:412.15-412.75] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)} |- expr : t_2*  :  context |- expr : resulttype
[notation 3-typing.watsup:412.15-412.60] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)}  :  context
[elab 3-typing.watsup:412.15-412.60] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)}  :  context
[elab 3-typing.watsup:412.15-412.45] C, {LOCAL t_1* t*}, {LABEL (t_2*)}  :  context
[elab 3-typing.watsup:412.15-412.31] C, {LOCAL t_1* t*}  :  context
[elab 3-typing.watsup:412.15-412.16] C  :  context
[elab 3-typing.watsup:412.18-412.31] {LOCAL {t_1* t*}}  :  context
[notation 3-typing.watsup:412.18-412.31] {t_1* t*}  :  valtype*
[niteration 3-typing.watsup:412.18-412.31] t_1* t*  :  valtype*
[notation 3-typing.watsup:412.24-412.28] t_1*  :  valtype*
[notation 3-typing.watsup:412.24-412.27] t_1  :  valtype
[elab 3-typing.watsup:412.24-412.27] t_1  :  valtype
[niteration 3-typing.watsup:412.18-412.31] t*  :  valtype*
[notation 3-typing.watsup:412.29-412.31] t*  :  valtype*
[notation 3-typing.watsup:412.29-412.30] t  :  valtype
[elab 3-typing.watsup:412.29-412.30] t  :  valtype
[niteration 3-typing.watsup:412.18-412.31]   :  valtype*
[elab 3-typing.watsup:412.39-412.45] {LABEL (t_2*)}  :  context
[notation 3-typing.watsup:412.39-412.45] (t_2*)  :  resulttype*
[notation 3-typing.watsup:412.40-412.44] t_2*  :  resulttype
[elab 3-typing.watsup:412.40-412.44] t_2*  :  resulttype
[elab 3-typing.watsup:412.40-412.43] t_2  :  valtype
[elab 3-typing.watsup:412.54-412.60] {RETURN (t_2*)}  :  context
[notation 3-typing.watsup:412.54-412.60] (t_2*)  :  resulttype?
[notation 3-typing.watsup:412.55-412.59] t_2*  :  resulttype
[elab 3-typing.watsup:412.55-412.59] t_2*  :  resulttype
[elab 3-typing.watsup:412.55-412.58] t_2  :  valtype
[notation 3-typing.watsup:412.64-412.75] expr : t_2*  :  expr : resulttype
[notation 3-typing.watsup:412.64-412.68] expr  :  expr
[elab 3-typing.watsup:412.64-412.68] expr  :  expr
[notation 3-typing.watsup:412.71-412.75] t_2*  :  resulttype
[elab 3-typing.watsup:412.71-412.75] t_2*  :  resulttype
[elab 3-typing.watsup:412.71-412.74] t_2  :  valtype
[notation 3-typing.watsup:415.3-415.27] C |- {GLOBAL gt expr} : gt  :  context |- global : globaltype
[notation 3-typing.watsup:415.3-415.4] C  :  context
[elab 3-typing.watsup:415.3-415.4] C  :  context
[notation 3-typing.watsup:415.8-415.27] {GLOBAL gt expr} : gt  :  global : globaltype
[notation 3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  global
[elab 3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  global
[notation 3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  {GLOBAL globaltype expr}
[notation 3-typing.watsup:415.8-415.14] GLOBAL  :  GLOBAL
[notation 3-typing.watsup:415.8-415.22] {gt expr}  :  {globaltype expr}
[notation 3-typing.watsup:415.15-415.17] gt  :  globaltype
[elab 3-typing.watsup:415.15-415.17] gt  :  globaltype
[notation 3-typing.watsup:415.8-415.22] {expr}  :  {expr}
[notation 3-typing.watsup:415.18-415.22] expr  :  expr
[elab 3-typing.watsup:415.18-415.22] expr  :  expr
[notation 3-typing.watsup:415.8-415.22] {}  :  {}
[notation 3-typing.watsup:415.25-415.27] gt  :  globaltype
[elab 3-typing.watsup:415.25-415.27] gt  :  globaltype
[notation 3-typing.watsup:416.21-416.31] {} |- gt : OK  :  {} |- globaltype : OK
[notation 3-typing.watsup:416.21-416.23] {}  :  {}
[notation 3-typing.watsup:416.24-416.31] gt : OK  :  globaltype : OK
[notation 3-typing.watsup:416.24-416.26] gt  :  globaltype
[elab 3-typing.watsup:416.24-416.26] gt  :  globaltype
[notation 3-typing.watsup:416.29-416.31] OK  :  OK
[elab 3-typing.watsup:417.9-417.20] gt = {MUT? t}  :  bool
[elab 3-typing.watsup:417.9-417.11] gt  :  globaltype
[elab 3-typing.watsup:417.14-417.20] {MUT? t}  :  globaltype
[notation 3-typing.watsup:417.14-417.20] {MUT? t}  :  {MUT? valtype}
[notation 3-typing.watsup:417.14-417.18] MUT?  :  MUT?
[notation 3-typing.watsup:417.14-417.17] MUT  :  MUT
[notation 3-typing.watsup:417.14-417.20] {t}  :  {valtype}
[notation 3-typing.watsup:417.19-417.20] t  :  valtype
[elab 3-typing.watsup:417.19-417.20] t  :  valtype
[notation 3-typing.watsup:417.14-417.20] {}  :  {}
[notation 3-typing.watsup:418.21-418.40] C |- expr : {t CONST}  :  context |- expr : {valtype CONST}
[notation 3-typing.watsup:418.21-418.22] C  :  context
[elab 3-typing.watsup:418.21-418.22] C  :  context
[notation 3-typing.watsup:418.26-418.40] expr : {t CONST}  :  expr : {valtype CONST}
[notation 3-typing.watsup:418.26-418.30] expr  :  expr
[elab 3-typing.watsup:418.26-418.30] expr  :  expr
[notation 3-typing.watsup:418.33-418.40] {t CONST}  :  {valtype CONST}
[notation 3-typing.watsup:418.33-418.34] t  :  valtype
[elab 3-typing.watsup:418.33-418.34] t  :  valtype
[notation 3-typing.watsup:418.33-418.40] {CONST}  :  {CONST}
[notation 3-typing.watsup:418.35-418.40] CONST  :  CONST
[notation 3-typing.watsup:418.33-418.40] {}  :  {}
[notation 3-typing.watsup:421.3-421.21] C |- {TABLE tt} : tt  :  context |- table : tabletype
[notation 3-typing.watsup:421.3-421.4] C  :  context
[elab 3-typing.watsup:421.3-421.4] C  :  context
[notation 3-typing.watsup:421.8-421.21] {TABLE tt} : tt  :  table : tabletype
[notation 3-typing.watsup:421.8-421.16] {TABLE tt}  :  table
[elab 3-typing.watsup:421.8-421.16] {TABLE tt}  :  table
[notation 3-typing.watsup:421.8-421.16] {TABLE tt}  :  {TABLE tabletype}
[notation 3-typing.watsup:421.8-421.13] TABLE  :  TABLE
[notation 3-typing.watsup:421.8-421.16] {tt}  :  {tabletype}
[notation 3-typing.watsup:421.14-421.16] tt  :  tabletype
[elab 3-typing.watsup:421.14-421.16] tt  :  tabletype
[notation 3-typing.watsup:421.8-421.16] {}  :  {}
[notation 3-typing.watsup:421.19-421.21] tt  :  tabletype
[elab 3-typing.watsup:421.19-421.21] tt  :  tabletype
[notation 3-typing.watsup:422.20-422.30] {} |- tt : OK  :  {} |- tabletype : OK
[notation 3-typing.watsup:422.20-422.22] {}  :  {}
[notation 3-typing.watsup:422.23-422.30] tt : OK  :  tabletype : OK
[notation 3-typing.watsup:422.23-422.25] tt  :  tabletype
[elab 3-typing.watsup:422.23-422.25] tt  :  tabletype
[notation 3-typing.watsup:422.28-422.30] OK  :  OK
[notation 3-typing.watsup:425.3-425.22] C |- {MEMORY mt} : mt  :  context |- mem : memtype
[notation 3-typing.watsup:425.3-425.4] C  :  context
[elab 3-typing.watsup:425.3-425.4] C  :  context
[notation 3-typing.watsup:425.8-425.22] {MEMORY mt} : mt  :  mem : memtype
[notation 3-typing.watsup:425.8-425.17] {MEMORY mt}  :  mem
[elab 3-typing.watsup:425.8-425.17] {MEMORY mt}  :  mem
[notation 3-typing.watsup:425.8-425.17] {MEMORY mt}  :  {MEMORY memtype}
[notation 3-typing.watsup:425.8-425.14] MEMORY  :  MEMORY
[notation 3-typing.watsup:425.8-425.17] {mt}  :  {memtype}
[notation 3-typing.watsup:425.15-425.17] mt  :  memtype
[elab 3-typing.watsup:425.15-425.17] mt  :  memtype
[notation 3-typing.watsup:425.8-425.17] {}  :  {}
[notation 3-typing.watsup:425.20-425.22] mt  :  memtype
[elab 3-typing.watsup:425.20-425.22] mt  :  memtype
[notation 3-typing.watsup:426.18-426.28] {} |- mt : OK  :  {} |- memtype : OK
[notation 3-typing.watsup:426.18-426.20] {}  :  {}
[notation 3-typing.watsup:426.21-426.28] mt : OK  :  memtype : OK
[notation 3-typing.watsup:426.21-426.23] mt  :  memtype
[elab 3-typing.watsup:426.21-426.23] mt  :  memtype
[notation 3-typing.watsup:426.26-426.28] OK  :  OK
[notation 3-typing.watsup:429.3-429.36] C |- {ELEM rt expr* elemmode?} : rt  :  context |- elem : reftype
[notation 3-typing.watsup:429.3-429.4] C  :  context
[elab 3-typing.watsup:429.3-429.4] C  :  context
[notation 3-typing.watsup:429.8-429.36] {ELEM rt expr* elemmode?} : rt  :  elem : reftype
[notation 3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  elem
[elab 3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  elem
[notation 3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  {ELEM reftype expr* elemmode?}
[notation 3-typing.watsup:429.8-429.12] ELEM  :  ELEM
[notation 3-typing.watsup:429.8-429.31] {rt expr* elemmode?}  :  {reftype expr* elemmode?}
[notation 3-typing.watsup:429.13-429.15] rt  :  reftype
[elab 3-typing.watsup:429.13-429.15] rt  :  reftype
[notation 3-typing.watsup:429.8-429.31] {expr* elemmode?}  :  {expr* elemmode?}
[notation 3-typing.watsup:429.16-429.21] expr*  :  expr*
[notation 3-typing.watsup:429.16-429.20] expr  :  expr
[elab 3-typing.watsup:429.16-429.20] expr  :  expr
[notation 3-typing.watsup:429.8-429.31] {elemmode?}  :  {elemmode?}
[notation 3-typing.watsup:429.8-429.31] {elemmode?}  :  elemmode?
[elab 3-typing.watsup:429.22-429.31] elemmode?  :  elemmode?
[elab 3-typing.watsup:429.22-429.30] elemmode  :  elemmode
[notation 3-typing.watsup:429.34-429.36] rt  :  reftype
[elab 3-typing.watsup:429.34-429.36] rt  :  reftype
[notation 3-typing.watsup:430.16-430.30] C |- expr : rt  :  context |- expr : resulttype
[notation 3-typing.watsup:430.16-430.17] C  :  context
[elab 3-typing.watsup:430.16-430.17] C  :  context
[notation 3-typing.watsup:430.21-430.30] expr : rt  :  expr : resulttype
[notation 3-typing.watsup:430.21-430.25] expr  :  expr
[elab 3-typing.watsup:430.21-430.25] expr  :  expr
[notation 3-typing.watsup:430.28-430.30] rt  :  resulttype
[elab 3-typing.watsup:430.28-430.30] rt  :  resulttype
[notation 3-typing.watsup:431.20-431.38] C |- elemmode : rt  :  context |- elemmode : reftype
[notation 3-typing.watsup:431.20-431.21] C  :  context
[elab 3-typing.watsup:431.20-431.21] C  :  context
[notation 3-typing.watsup:431.25-431.38] elemmode : rt  :  elemmode : reftype
[notation 3-typing.watsup:431.25-431.33] elemmode  :  elemmode
[elab 3-typing.watsup:431.25-431.33] elemmode  :  elemmode
[notation 3-typing.watsup:431.36-431.38] rt  :  reftype
[elab 3-typing.watsup:431.36-431.38] rt  :  reftype
[notation 3-typing.watsup:435.3-435.31] C |- {DATA b** datamode?} : OK  :  context |- data : OK
[notation 3-typing.watsup:435.3-435.4] C  :  context
[elab 3-typing.watsup:435.3-435.4] C  :  context
[notation 3-typing.watsup:435.8-435.31] {DATA b** datamode?} : OK  :  data : OK
[notation 3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  data
[elab 3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  data
[notation 3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  {DATA (byte*)* datamode?}
[notation 3-typing.watsup:435.8-435.12] DATA  :  DATA
[notation 3-typing.watsup:435.8-435.26] {b** datamode?}  :  {(byte*)* datamode?}
[notation 3-typing.watsup:435.13-435.16] b**  :  (byte*)*
[notation 3-typing.watsup:435.13-435.15] b*  :  (byte*)
[notation 3-typing.watsup:435.13-435.15] b*  :  byte*
[notation 3-typing.watsup:435.13-435.14] b  :  byte
[elab 3-typing.watsup:435.13-435.14] b  :  byte
[notation 3-typing.watsup:435.8-435.26] {datamode?}  :  {datamode?}
[notation 3-typing.watsup:435.8-435.26] {datamode?}  :  datamode?
[elab 3-typing.watsup:435.17-435.26] datamode?  :  datamode?
[elab 3-typing.watsup:435.17-435.25] datamode  :  datamode
[notation 3-typing.watsup:435.29-435.31] OK  :  OK
[notation 3-typing.watsup:436.20-436.38] C |- datamode : OK  :  context |- datamode : OK
[notation 3-typing.watsup:436.20-436.21] C  :  context
[elab 3-typing.watsup:436.20-436.21] C  :  context
[notation 3-typing.watsup:436.25-436.38] datamode : OK  :  datamode : OK
[notation 3-typing.watsup:436.25-436.33] datamode  :  datamode
[elab 3-typing.watsup:436.25-436.33] datamode  :  datamode
[notation 3-typing.watsup:436.36-436.38] OK  :  OK
[notation 3-typing.watsup:439.3-439.25] C |- {TABLE x expr} : rt  :  context |- elemmode : reftype
[notation 3-typing.watsup:439.3-439.4] C  :  context
[elab 3-typing.watsup:439.3-439.4] C  :  context
[notation 3-typing.watsup:439.8-439.25] {TABLE x expr} : rt  :  elemmode : reftype
[notation 3-typing.watsup:439.8-439.20] {TABLE x expr}  :  elemmode
[elab 3-typing.watsup:439.8-439.20] {TABLE x expr}  :  elemmode
[notation 3-typing.watsup:439.8-439.20] {x expr}  :  {tableidx expr}
[notation 3-typing.watsup:439.14-439.15] x  :  tableidx
[elab 3-typing.watsup:439.14-439.15] x  :  tableidx
[notation 3-typing.watsup:439.8-439.20] {expr}  :  {expr}
[notation 3-typing.watsup:439.16-439.20] expr  :  expr
[elab 3-typing.watsup:439.16-439.20] expr  :  expr
[notation 3-typing.watsup:439.8-439.20] {}  :  {}
[notation 3-typing.watsup:439.23-439.25] rt  :  reftype
[elab 3-typing.watsup:439.23-439.25] rt  :  reftype
[elab 3-typing.watsup:440.9-440.28] C.TABLE[x] = {lim rt}  :  bool
[elab 3-typing.watsup:440.9-440.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:440.9-440.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:440.9-440.10] C  :  context
[elab 3-typing.watsup:440.17-440.18] x  :  nat
[elab 3-typing.watsup:440.22-440.28] {lim rt}  :  tabletype
[notation 3-typing.watsup:440.22-440.28] {lim rt}  :  {limits reftype}
[notation 3-typing.watsup:440.22-440.25] lim  :  limits
[elab 3-typing.watsup:440.22-440.25] lim  :  limits
[notation 3-typing.watsup:440.22-440.28] {rt}  :  {reftype}
[notation 3-typing.watsup:440.26-440.28] rt  :  reftype
[elab 3-typing.watsup:440.26-440.28] rt  :  reftype
[notation 3-typing.watsup:440.22-440.28] {}  :  {}
[notation 3-typing.watsup:441.22-441.43] C |- expr : {I32 CONST}  :  context |- expr : {valtype CONST}
[notation 3-typing.watsup:441.22-441.23] C  :  context
[elab 3-typing.watsup:441.22-441.23] C  :  context
[notation 3-typing.watsup:441.27-441.43] expr : {I32 CONST}  :  expr : {valtype CONST}
[notation 3-typing.watsup:441.27-441.31] expr  :  expr
[elab 3-typing.watsup:441.27-441.31] expr  :  expr
[notation 3-typing.watsup:441.34-441.43] {I32 CONST}  :  {valtype CONST}
[notation 3-typing.watsup:441.34-441.37] I32  :  valtype
[elab 3-typing.watsup:441.34-441.37] I32  :  valtype
[notation 3-typing.watsup:441.34-441.37] {}  :  {}
[notation 3-typing.watsup:441.34-441.43] {CONST}  :  {CONST}
[notation 3-typing.watsup:441.38-441.43] CONST  :  CONST
[notation 3-typing.watsup:441.34-441.43] {}  :  {}
[notation 3-typing.watsup:444.3-444.20] C |- DECLARE : rt  :  context |- elemmode : reftype
[notation 3-typing.watsup:444.3-444.4] C  :  context
[elab 3-typing.watsup:444.3-444.4] C  :  context
[notation 3-typing.watsup:444.8-444.20] DECLARE : rt  :  elemmode : reftype
[notation 3-typing.watsup:444.8-444.15] DECLARE  :  elemmode
[elab 3-typing.watsup:444.8-444.15] DECLARE  :  elemmode
[notation 3-typing.watsup:444.8-444.15] {}  :  {}
[notation 3-typing.watsup:444.18-444.20] rt  :  reftype
[elab 3-typing.watsup:444.18-444.20] rt  :  reftype
[notation 3-typing.watsup:447.3-447.26] C |- {MEMORY 0 expr} : OK  :  context |- datamode : OK
[notation 3-typing.watsup:447.3-447.4] C  :  context
[elab 3-typing.watsup:447.3-447.4] C  :  context
[notation 3-typing.watsup:447.8-447.26] {MEMORY 0 expr} : OK  :  datamode : OK
[notation 3-typing.watsup:447.8-447.21] {MEMORY 0 expr}  :  datamode
[elab 3-typing.watsup:447.8-447.21] {MEMORY 0 expr}  :  datamode
[notation 3-typing.watsup:447.8-447.21] {0 expr}  :  {memidx expr}
[notation 3-typing.watsup:447.15-447.16] 0  :  memidx
[elab 3-typing.watsup:447.15-447.16] 0  :  memidx
[notation 3-typing.watsup:447.8-447.21] {expr}  :  {expr}
[notation 3-typing.watsup:447.17-447.21] expr  :  expr
[elab 3-typing.watsup:447.17-447.21] expr  :  expr
[notation 3-typing.watsup:447.8-447.21] {}  :  {}
[notation 3-typing.watsup:447.24-447.26] OK  :  OK
[elab 3-typing.watsup:448.9-448.22] C.MEM[0] = mt  :  bool
[elab 3-typing.watsup:448.9-448.17] C.MEM[0]  :  memtype
[elab 3-typing.watsup:448.9-448.14] C.MEM  :  memtype*
[elab 3-typing.watsup:448.9-448.10] C  :  context
[elab 3-typing.watsup:448.15-448.16] 0  :  nat
[elab 3-typing.watsup:448.20-448.22] mt  :  memtype
[notation 3-typing.watsup:449.22-449.43] C |- expr : {I32 CONST}  :  context |- expr : {valtype CONST}
[notation 3-typing.watsup:449.22-449.23] C  :  context
[elab 3-typing.watsup:449.22-449.23] C  :  context
[notation 3-typing.watsup:449.27-449.43] expr : {I32 CONST}  :  expr : {valtype CONST}
[notation 3-typing.watsup:449.27-449.31] expr  :  expr
[elab 3-typing.watsup:449.27-449.31] expr  :  expr
[notation 3-typing.watsup:449.34-449.43] {I32 CONST}  :  {valtype CONST}
[notation 3-typing.watsup:449.34-449.37] I32  :  valtype
[elab 3-typing.watsup:449.34-449.37] I32  :  valtype
[notation 3-typing.watsup:449.34-449.37] {}  :  {}
[notation 3-typing.watsup:449.34-449.43] {CONST}  :  {CONST}
[notation 3-typing.watsup:449.38-449.43] CONST  :  CONST
[notation 3-typing.watsup:449.34-449.43] {}  :  {}
[notation 3-typing.watsup:452.3-452.20] C |- {START x} : OK  :  context |- start : OK
[notation 3-typing.watsup:452.3-452.4] C  :  context
[elab 3-typing.watsup:452.3-452.4] C  :  context
[notation 3-typing.watsup:452.8-452.20] {START x} : OK  :  start : OK
[notation 3-typing.watsup:452.8-452.15] {START x}  :  start
[elab 3-typing.watsup:452.8-452.15] {START x}  :  start
[notation 3-typing.watsup:452.8-452.15] {START x}  :  {START funcidx}
[notation 3-typing.watsup:452.8-452.13] START  :  START
[notation 3-typing.watsup:452.8-452.15] {x}  :  {funcidx}
[notation 3-typing.watsup:452.14-452.15] x  :  funcidx
[elab 3-typing.watsup:452.14-452.15] x  :  funcidx
[notation 3-typing.watsup:452.8-452.15] {}  :  {}
[notation 3-typing.watsup:452.18-452.20] OK  :  OK
[elab 3-typing.watsup:453.9-453.39] C.FUNC[x] = epsilon -> epsilon  :  bool
[elab 3-typing.watsup:453.9-453.18] C.FUNC[x]  :  functype
[elab 3-typing.watsup:453.9-453.15] C.FUNC  :  functype*
[elab 3-typing.watsup:453.9-453.10] C  :  context
[elab 3-typing.watsup:453.16-453.17] x  :  nat
[elab 3-typing.watsup:453.21-453.39] epsilon -> epsilon  :  functype
[notation 3-typing.watsup:453.21-453.39] epsilon -> epsilon  :  resulttype -> resulttype
[notation 3-typing.watsup:453.21-453.28] epsilon  :  resulttype
[elab 3-typing.watsup:453.21-453.28] epsilon  :  resulttype
[notation 3-typing.watsup:453.32-453.39] epsilon  :  resulttype
[elab 3-typing.watsup:453.32-453.39] epsilon  :  resulttype
[notation 3-typing.watsup:461.3-461.36] C |- {IMPORT name_1 name_2 xt} : xt  :  context |- import : externtype
[notation 3-typing.watsup:461.3-461.4] C  :  context
[elab 3-typing.watsup:461.3-461.4] C  :  context
[notation 3-typing.watsup:461.8-461.36] {IMPORT name_1 name_2 xt} : xt  :  import : externtype
[notation 3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  import
[elab 3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  import
[notation 3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  {IMPORT name name externtype}
[notation 3-typing.watsup:461.8-461.14] IMPORT  :  IMPORT
[notation 3-typing.watsup:461.8-461.31] {name_1 name_2 xt}  :  {name name externtype}
[notation 3-typing.watsup:461.15-461.21] name_1  :  name
[elab 3-typing.watsup:461.15-461.21] name_1  :  name
[notation 3-typing.watsup:461.8-461.31] {name_2 xt}  :  {name externtype}
[notation 3-typing.watsup:461.22-461.28] name_2  :  name
[elab 3-typing.watsup:461.22-461.28] name_2  :  name
[notation 3-typing.watsup:461.8-461.31] {xt}  :  {externtype}
[notation 3-typing.watsup:461.29-461.31] xt  :  externtype
[elab 3-typing.watsup:461.29-461.31] xt  :  externtype
[notation 3-typing.watsup:461.8-461.31] {}  :  {}
[notation 3-typing.watsup:461.34-461.36] xt  :  externtype
[elab 3-typing.watsup:461.34-461.36] xt  :  externtype
[notation 3-typing.watsup:462.21-462.31] {} |- xt : OK  :  {} |- externtype : OK
[notation 3-typing.watsup:462.21-462.23] {}  :  {}
[notation 3-typing.watsup:462.24-462.31] xt : OK  :  externtype : OK
[notation 3-typing.watsup:462.24-462.26] xt  :  externtype
[elab 3-typing.watsup:462.24-462.26] xt  :  externtype
[notation 3-typing.watsup:462.29-462.31] OK  :  OK
[notation 3-typing.watsup:465.3-465.34] C |- {EXPORT name externuse} : xt  :  context |- export : externtype
[notation 3-typing.watsup:465.3-465.4] C  :  context
[elab 3-typing.watsup:465.3-465.4] C  :  context
[notation 3-typing.watsup:465.8-465.34] {EXPORT name externuse} : xt  :  export : externtype
[notation 3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  export
[elab 3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  export
[notation 3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  {EXPORT name externuse}
[notation 3-typing.watsup:465.8-465.14] EXPORT  :  EXPORT
[notation 3-typing.watsup:465.8-465.29] {name externuse}  :  {name externuse}
[notation 3-typing.watsup:465.15-465.19] name  :  name
[elab 3-typing.watsup:465.15-465.19] name  :  name
[notation 3-typing.watsup:465.8-465.29] {externuse}  :  {externuse}
[notation 3-typing.watsup:465.20-465.29] externuse  :  externuse
[elab 3-typing.watsup:465.20-465.29] externuse  :  externuse
[notation 3-typing.watsup:465.8-465.29] {}  :  {}
[notation 3-typing.watsup:465.32-465.34] xt  :  externtype
[elab 3-typing.watsup:465.32-465.34] xt  :  externtype
[notation 3-typing.watsup:466.20-466.39] C |- externuse : xt  :  context |- externuse : externtype
[notation 3-typing.watsup:466.20-466.21] C  :  context
[elab 3-typing.watsup:466.20-466.21] C  :  context
[notation 3-typing.watsup:466.25-466.39] externuse : xt  :  externuse : externtype
[notation 3-typing.watsup:466.25-466.34] externuse  :  externuse
[elab 3-typing.watsup:466.25-466.34] externuse  :  externuse
[notation 3-typing.watsup:466.37-466.39] xt  :  externtype
[elab 3-typing.watsup:466.37-466.39] xt  :  externtype
[notation 3-typing.watsup:469.3-469.24] C |- {FUNC x} : {FUNC ft}  :  context |- externuse : externtype
[notation 3-typing.watsup:469.3-469.4] C  :  context
[elab 3-typing.watsup:469.3-469.4] C  :  context
[notation 3-typing.watsup:469.8-469.24] {FUNC x} : {FUNC ft}  :  externuse : externtype
[notation 3-typing.watsup:469.8-469.14] {FUNC x}  :  externuse
[elab 3-typing.watsup:469.8-469.14] {FUNC x}  :  externuse
[notation 3-typing.watsup:469.8-469.14] {x}  :  {funcidx}
[notation 3-typing.watsup:469.13-469.14] x  :  funcidx
[elab 3-typing.watsup:469.13-469.14] x  :  funcidx
[notation 3-typing.watsup:469.8-469.14] {}  :  {}
[notation 3-typing.watsup:469.17-469.24] {FUNC ft}  :  externtype
[elab 3-typing.watsup:469.17-469.24] {FUNC ft}  :  externtype
[notation 3-typing.watsup:469.17-469.24] {ft}  :  {functype}
[notation 3-typing.watsup:469.22-469.24] ft  :  functype
[elab 3-typing.watsup:469.22-469.24] ft  :  functype
[notation 3-typing.watsup:469.17-469.24] {}  :  {}
[elab 3-typing.watsup:470.9-470.23] C.FUNC[x] = ft  :  bool
[elab 3-typing.watsup:470.9-470.18] C.FUNC[x]  :  functype
[elab 3-typing.watsup:470.9-470.15] C.FUNC  :  functype*
[elab 3-typing.watsup:470.9-470.10] C  :  context
[elab 3-typing.watsup:470.16-470.17] x  :  nat
[elab 3-typing.watsup:470.21-470.23] ft  :  functype
[notation 3-typing.watsup:473.3-473.28] C |- {GLOBAL x} : {GLOBAL gt}  :  context |- externuse : externtype
[notation 3-typing.watsup:473.3-473.4] C  :  context
[elab 3-typing.watsup:473.3-473.4] C  :  context
[notation 3-typing.watsup:473.8-473.28] {GLOBAL x} : {GLOBAL gt}  :  externuse : externtype
[notation 3-typing.watsup:473.8-473.16] {GLOBAL x}  :  externuse
[elab 3-typing.watsup:473.8-473.16] {GLOBAL x}  :  externuse
[notation 3-typing.watsup:473.8-473.16] {x}  :  {globalidx}
[notation 3-typing.watsup:473.15-473.16] x  :  globalidx
[elab 3-typing.watsup:473.15-473.16] x  :  globalidx
[notation 3-typing.watsup:473.8-473.16] {}  :  {}
[notation 3-typing.watsup:473.19-473.28] {GLOBAL gt}  :  externtype
[elab 3-typing.watsup:473.19-473.28] {GLOBAL gt}  :  externtype
[notation 3-typing.watsup:473.19-473.28] {gt}  :  {globaltype}
[notation 3-typing.watsup:473.26-473.28] gt  :  globaltype
[elab 3-typing.watsup:473.26-473.28] gt  :  globaltype
[notation 3-typing.watsup:473.19-473.28] {}  :  {}
[elab 3-typing.watsup:474.9-474.25] C.GLOBAL[x] = gt  :  bool
[elab 3-typing.watsup:474.9-474.20] C.GLOBAL[x]  :  globaltype
[elab 3-typing.watsup:474.9-474.17] C.GLOBAL  :  globaltype*
[elab 3-typing.watsup:474.9-474.10] C  :  context
[elab 3-typing.watsup:474.18-474.19] x  :  nat
[elab 3-typing.watsup:474.23-474.25] gt  :  globaltype
[notation 3-typing.watsup:477.3-477.26] C |- {TABLE x} : {TABLE tt}  :  context |- externuse : externtype
[notation 3-typing.watsup:477.3-477.4] C  :  context
[elab 3-typing.watsup:477.3-477.4] C  :  context
[notation 3-typing.watsup:477.8-477.26] {TABLE x} : {TABLE tt}  :  externuse : externtype
[notation 3-typing.watsup:477.8-477.15] {TABLE x}  :  externuse
[elab 3-typing.watsup:477.8-477.15] {TABLE x}  :  externuse
[notation 3-typing.watsup:477.8-477.15] {x}  :  {tableidx}
[notation 3-typing.watsup:477.14-477.15] x  :  tableidx
[elab 3-typing.watsup:477.14-477.15] x  :  tableidx
[notation 3-typing.watsup:477.8-477.15] {}  :  {}
[notation 3-typing.watsup:477.18-477.26] {TABLE tt}  :  externtype
[elab 3-typing.watsup:477.18-477.26] {TABLE tt}  :  externtype
[notation 3-typing.watsup:477.18-477.26] {tt}  :  {tabletype}
[notation 3-typing.watsup:477.24-477.26] tt  :  tabletype
[elab 3-typing.watsup:477.24-477.26] tt  :  tabletype
[notation 3-typing.watsup:477.18-477.26] {}  :  {}
[elab 3-typing.watsup:478.9-478.24] C.TABLE[x] = tt  :  bool
[elab 3-typing.watsup:478.9-478.19] C.TABLE[x]  :  tabletype
[elab 3-typing.watsup:478.9-478.16] C.TABLE  :  tabletype*
[elab 3-typing.watsup:478.9-478.10] C  :  context
[elab 3-typing.watsup:478.17-478.18] x  :  nat
[elab 3-typing.watsup:478.22-478.24] tt  :  tabletype
[notation 3-typing.watsup:481.3-481.28] C |- {MEMORY x} : {MEMORY mt}  :  context |- externuse : externtype
[notation 3-typing.watsup:481.3-481.4] C  :  context
[elab 3-typing.watsup:481.3-481.4] C  :  context
[notation 3-typing.watsup:481.8-481.28] {MEMORY x} : {MEMORY mt}  :  externuse : externtype
[notation 3-typing.watsup:481.8-481.16] {MEMORY x}  :  externuse
[elab 3-typing.watsup:481.8-481.16] {MEMORY x}  :  externuse
[notation 3-typing.watsup:481.8-481.16] {x}  :  {memidx}
[notation 3-typing.watsup:481.15-481.16] x  :  memidx
[elab 3-typing.watsup:481.15-481.16] x  :  memidx
[notation 3-typing.watsup:481.8-481.16] {}  :  {}
[notation 3-typing.watsup:481.19-481.28] {MEMORY mt}  :  externtype
[elab 3-typing.watsup:481.19-481.28] {MEMORY mt}  :  externtype
[notation 3-typing.watsup:481.19-481.28] {mt}  :  {memtype}
[notation 3-typing.watsup:481.26-481.28] mt  :  memtype
[elab 3-typing.watsup:481.26-481.28] mt  :  memtype
[notation 3-typing.watsup:481.19-481.28] {}  :  {}
[elab 3-typing.watsup:482.9-482.22] C.MEM[x] = mt  :  bool
[elab 3-typing.watsup:482.9-482.17] C.MEM[x]  :  memtype
[elab 3-typing.watsup:482.9-482.14] C.MEM  :  memtype*
[elab 3-typing.watsup:482.9-482.10] C  :  context
[elab 3-typing.watsup:482.15-482.16] x  :  nat
[elab 3-typing.watsup:482.20-482.22] mt  :  memtype
[notation 3-typing.watsup:488.3-488.79] {} |- {MODULE import* func* global* table* mem* elem* data^n start* export*} : OK  :  {} |- module : OK
[notation 3-typing.watsup:488.3-488.5] {}  :  {}
[notation 3-typing.watsup:488.6-488.79] {MODULE import* func* global* table* mem* elem* data^n start* export*} : OK  :  module : OK
[notation 3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  module
[elab 3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  module
[notation 3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  {MODULE import* func* global* table* mem* elem* data* start* export*}
[notation 3-typing.watsup:488.6-488.12] MODULE  :  MODULE
[notation 3-typing.watsup:488.6-488.74] {import* func* global* table* mem* elem* data^n start* export*}  :  {import* func* global* table* mem* elem* data* start* export*}
[notation 3-typing.watsup:488.13-488.20] import*  :  import*
[notation 3-typing.watsup:488.13-488.19] import  :  import
[elab 3-typing.watsup:488.13-488.19] import  :  import
[notation 3-typing.watsup:488.6-488.74] {func* global* table* mem* elem* data^n start* export*}  :  {func* global* table* mem* elem* data* start* export*}
[notation 3-typing.watsup:488.21-488.26] func*  :  func*
[notation 3-typing.watsup:488.21-488.25] func  :  func
[elab 3-typing.watsup:488.21-488.25] func  :  func
[notation 3-typing.watsup:488.6-488.74] {global* table* mem* elem* data^n start* export*}  :  {global* table* mem* elem* data* start* export*}
[notation 3-typing.watsup:488.27-488.34] global*  :  global*
[notation 3-typing.watsup:488.27-488.33] global  :  global
[elab 3-typing.watsup:488.27-488.33] global  :  global
[notation 3-typing.watsup:488.6-488.74] {table* mem* elem* data^n start* export*}  :  {table* mem* elem* data* start* export*}
[notation 3-typing.watsup:488.35-488.41] table*  :  table*
[notation 3-typing.watsup:488.35-488.40] table  :  table
[elab 3-typing.watsup:488.35-488.40] table  :  table
[notation 3-typing.watsup:488.6-488.74] {mem* elem* data^n start* export*}  :  {mem* elem* data* start* export*}
[notation 3-typing.watsup:488.42-488.46] mem*  :  mem*
[notation 3-typing.watsup:488.42-488.45] mem  :  mem
[elab 3-typing.watsup:488.42-488.45] mem  :  mem
[notation 3-typing.watsup:488.6-488.74] {elem* data^n start* export*}  :  {elem* data* start* export*}
[notation 3-typing.watsup:488.47-488.52] elem*  :  elem*
[notation 3-typing.watsup:488.47-488.51] elem  :  elem
[elab 3-typing.watsup:488.47-488.51] elem  :  elem
[notation 3-typing.watsup:488.6-488.74] {data^n start* export*}  :  {data* start* export*}
[notation 3-typing.watsup:488.53-488.59] data^n  :  data*
[notation 3-typing.watsup:488.53-488.57] data  :  data
[elab 3-typing.watsup:488.53-488.57] data  :  data
[elab 3-typing.watsup:488.58-488.59] n  :  nat
[notation 3-typing.watsup:488.6-488.74] {start* export*}  :  {start* export*}
[notation 3-typing.watsup:488.60-488.66] start*  :  start*
[notation 3-typing.watsup:488.60-488.65] start  :  start
[elab 3-typing.watsup:488.60-488.65] start  :  start
[notation 3-typing.watsup:488.6-488.74] {export*}  :  {export*}
[notation 3-typing.watsup:488.6-488.74] {export*}  :  export*
[elab 3-typing.watsup:488.67-488.74] export*  :  export*
[elab 3-typing.watsup:488.67-488.73] export  :  export
[notation 3-typing.watsup:488.77-488.79] OK  :  OK
[notation 3-typing.watsup:489.16-489.30] C |- func : ft  :  context |- func : functype
[notation 3-typing.watsup:489.16-489.17] C  :  context
[elab 3-typing.watsup:489.16-489.17] C  :  context
[notation 3-typing.watsup:489.21-489.30] func : ft  :  func : functype
[notation 3-typing.watsup:489.21-489.25] func  :  func
[elab 3-typing.watsup:489.21-489.25] func  :  func
[notation 3-typing.watsup:489.28-489.30] ft  :  functype
[elab 3-typing.watsup:489.28-489.30] ft  :  functype
[notation 3-typing.watsup:490.18-490.34] C |- global : gt  :  context |- global : globaltype
[notation 3-typing.watsup:490.18-490.19] C  :  context
[elab 3-typing.watsup:490.18-490.19] C  :  context
[notation 3-typing.watsup:490.23-490.34] global : gt  :  global : globaltype
[notation 3-typing.watsup:490.23-490.29] global  :  global
[elab 3-typing.watsup:490.23-490.29] global  :  global
[notation 3-typing.watsup:490.32-490.34] gt  :  globaltype
[elab 3-typing.watsup:490.32-490.34] gt  :  globaltype
[notation 3-typing.watsup:491.17-491.32] C |- table : tt  :  context |- table : tabletype
[notation 3-typing.watsup:491.17-491.18] C  :  context
[elab 3-typing.watsup:491.17-491.18] C  :  context
[notation 3-typing.watsup:491.22-491.32] table : tt  :  table : tabletype
[notation 3-typing.watsup:491.22-491.27] table  :  table
[elab 3-typing.watsup:491.22-491.27] table  :  table
[notation 3-typing.watsup:491.30-491.32] tt  :  tabletype
[elab 3-typing.watsup:491.30-491.32] tt  :  tabletype
[notation 3-typing.watsup:492.15-492.28] C |- mem : mt  :  context |- mem : memtype
[notation 3-typing.watsup:492.15-492.16] C  :  context
[elab 3-typing.watsup:492.15-492.16] C  :  context
[notation 3-typing.watsup:492.20-492.28] mem : mt  :  mem : memtype
[notation 3-typing.watsup:492.20-492.23] mem  :  mem
[elab 3-typing.watsup:492.20-492.23] mem  :  mem
[notation 3-typing.watsup:492.26-492.28] mt  :  memtype
[elab 3-typing.watsup:492.26-492.28] mt  :  memtype
[notation 3-typing.watsup:493.16-493.30] C |- elem : rt  :  context |- elem : reftype
[notation 3-typing.watsup:493.16-493.17] C  :  context
[elab 3-typing.watsup:493.16-493.17] C  :  context
[notation 3-typing.watsup:493.21-493.30] elem : rt  :  elem : reftype
[notation 3-typing.watsup:493.21-493.25] elem  :  elem
[elab 3-typing.watsup:493.21-493.25] elem  :  elem
[notation 3-typing.watsup:493.28-493.30] rt  :  reftype
[elab 3-typing.watsup:493.28-493.30] rt  :  reftype
[notation 3-typing.watsup:494.16-494.30] C |- data : OK  :  context |- data : OK
[notation 3-typing.watsup:494.16-494.17] C  :  context
[elab 3-typing.watsup:494.16-494.17] C  :  context
[notation 3-typing.watsup:494.21-494.30] data : OK  :  data : OK
[notation 3-typing.watsup:494.21-494.25] data  :  data
[elab 3-typing.watsup:494.21-494.25] data  :  data
[notation 3-typing.watsup:494.28-494.30] OK  :  OK
[elab 3-typing.watsup:494.32-494.33] n  :  nat
[notation 3-typing.watsup:495.17-495.32] C |- start : OK  :  context |- start : OK
[notation 3-typing.watsup:495.17-495.18] C  :  context
[elab 3-typing.watsup:495.17-495.18] C  :  context
[notation 3-typing.watsup:495.22-495.32] start : OK  :  start : OK
[notation 3-typing.watsup:495.22-495.27] start  :  start
[elab 3-typing.watsup:495.22-495.27] start  :  start
[notation 3-typing.watsup:495.30-495.32] OK  :  OK
[elab 3-typing.watsup:497.9-497.76] C = {FUNC ft*, GLOBAL gt*, TABLE tt*, MEM mt*, ELEM rt*, DATA OK^n}  :  bool
[elab 3-typing.watsup:497.9-497.10] C  :  context
[elab 3-typing.watsup:497.13-497.76] {FUNC ft*, GLOBAL gt*, TABLE tt*, MEM mt*, ELEM rt*, DATA OK^n}  :  context
[notation 3-typing.watsup:497.19-497.22] ft*  :  functype*
[notation 3-typing.watsup:497.19-497.21] ft  :  functype
[elab 3-typing.watsup:497.19-497.21] ft  :  functype
[notation 3-typing.watsup:497.31-497.34] gt*  :  globaltype*
[notation 3-typing.watsup:497.31-497.33] gt  :  globaltype
[elab 3-typing.watsup:497.31-497.33] gt  :  globaltype
[notation 3-typing.watsup:497.42-497.45] tt*  :  tabletype*
[notation 3-typing.watsup:497.42-497.44] tt  :  tabletype
[elab 3-typing.watsup:497.42-497.44] tt  :  tabletype
[notation 3-typing.watsup:497.51-497.54] mt*  :  memtype*
[notation 3-typing.watsup:497.51-497.53] mt  :  memtype
[elab 3-typing.watsup:497.51-497.53] mt  :  memtype
[notation 3-typing.watsup:497.61-497.64] rt*  :  elemtype*
[notation 3-typing.watsup:497.61-497.63] rt  :  elemtype
[elab 3-typing.watsup:497.61-497.63] rt  :  elemtype
[notation 3-typing.watsup:497.71-497.75] OK^n  :  datatype*
[notation 3-typing.watsup:497.71-497.73] OK  :  datatype
[elab 3-typing.watsup:497.71-497.73] OK  :  datatype
[notation 3-typing.watsup:497.71-497.73] OK  :  OK
[elab 3-typing.watsup:497.74-497.75] n  :  nat
[elab 3-typing.watsup:498.9-498.20] |mem*| <= 1  :  bool
[elab 3-typing.watsup:498.9-498.15] |mem*|  :  nat
[elab 3-typing.watsup:498.10-498.14] mem*  :  mem*
[elab 3-typing.watsup:498.10-498.13] mem  :  mem
[elab 3-typing.watsup:498.19-498.20] 1  :  nat
[elab 3-typing.watsup:499.9-499.22] |start*| <= 1  :  bool
[elab 3-typing.watsup:499.9-499.17] |start*|  :  nat
[elab 3-typing.watsup:499.10-499.16] start*  :  start*
[elab 3-typing.watsup:499.10-499.15] start  :  start
[elab 3-typing.watsup:499.21-499.22] 1  :  nat
[elab 3-typing.watsup:494.32-494.33] n  :  nat
[elab 4-runtime.watsup:44.14-44.23] (valtype)  :  (valtype)
[elab 4-runtime.watsup:44.15-44.22] valtype  :  (valtype)
[elab 4-runtime.watsup:45.14-45.19] (I32)  :  (valtype)
[elab 4-runtime.watsup:45.15-45.18] I32  :  (valtype)
[notation 4-runtime.watsup:45.15-45.18] {}  :  {}
[elab 4-runtime.watsup:45.22-45.35] ({CONST I32 0})  :  val
[elab 4-runtime.watsup:45.23-45.34] {CONST I32 0}  :  val
[notation 4-runtime.watsup:45.23-45.34] {I32 0}  :  {numtype c_numtype}
[notation 4-runtime.watsup:45.29-45.32] I32  :  numtype
[elab 4-runtime.watsup:45.29-45.32] I32  :  numtype
[notation 4-runtime.watsup:45.29-45.32] {}  :  {}
[notation 4-runtime.watsup:45.23-45.34] {0}  :  {c_numtype}
[notation 4-runtime.watsup:45.33-45.34] 0  :  c_numtype
[elab 4-runtime.watsup:45.33-45.34] 0  :  c_numtype
[notation 4-runtime.watsup:45.23-45.34] {}  :  {}
[elab 4-runtime.watsup:46.14-46.19] (I64)  :  (valtype)
[elab 4-runtime.watsup:46.15-46.18] I64  :  (valtype)
[notation 4-runtime.watsup:46.15-46.18] {}  :  {}
[elab 4-runtime.watsup:46.22-46.35] ({CONST I64 0})  :  val
[elab 4-runtime.watsup:46.23-46.34] {CONST I64 0}  :  val
[notation 4-runtime.watsup:46.23-46.34] {I64 0}  :  {numtype c_numtype}
[notation 4-runtime.watsup:46.29-46.32] I64  :  numtype
[elab 4-runtime.watsup:46.29-46.32] I64  :  numtype
[notation 4-runtime.watsup:46.29-46.32] {}  :  {}
[notation 4-runtime.watsup:46.23-46.34] {0}  :  {c_numtype}
[notation 4-runtime.watsup:46.33-46.34] 0  :  c_numtype
[elab 4-runtime.watsup:46.33-46.34] 0  :  c_numtype
[notation 4-runtime.watsup:46.23-46.34] {}  :  {}
[elab 4-runtime.watsup:47.14-47.19] (F32)  :  (valtype)
[elab 4-runtime.watsup:47.15-47.18] F32  :  (valtype)
[notation 4-runtime.watsup:47.15-47.18] {}  :  {}
[elab 4-runtime.watsup:47.22-47.35] ({CONST F32 0})  :  val
[elab 4-runtime.watsup:47.23-47.34] {CONST F32 0}  :  val
[notation 4-runtime.watsup:47.23-47.34] {F32 0}  :  {numtype c_numtype}
[notation 4-runtime.watsup:47.29-47.32] F32  :  numtype
[elab 4-runtime.watsup:47.29-47.32] F32  :  numtype
[notation 4-runtime.watsup:47.29-47.32] {}  :  {}
[notation 4-runtime.watsup:47.23-47.34] {0}  :  {c_numtype}
[notation 4-runtime.watsup:47.33-47.34] 0  :  c_numtype
[elab 4-runtime.watsup:47.33-47.34] 0  :  c_numtype
[notation 4-runtime.watsup:47.23-47.34] {}  :  {}
[elab 4-runtime.watsup:48.14-48.19] (F64)  :  (valtype)
[elab 4-runtime.watsup:48.15-48.18] F64  :  (valtype)
[notation 4-runtime.watsup:48.15-48.18] {}  :  {}
[elab 4-runtime.watsup:48.22-48.35] ({CONST F64 0})  :  val
[elab 4-runtime.watsup:48.23-48.34] {CONST F64 0}  :  val
[notation 4-runtime.watsup:48.23-48.34] {F64 0}  :  {numtype c_numtype}
[notation 4-runtime.watsup:48.29-48.32] F64  :  numtype
[elab 4-runtime.watsup:48.29-48.32] F64  :  numtype
[notation 4-runtime.watsup:48.29-48.32] {}  :  {}
[notation 4-runtime.watsup:48.23-48.34] {0}  :  {c_numtype}
[notation 4-runtime.watsup:48.33-48.34] 0  :  c_numtype
[elab 4-runtime.watsup:48.33-48.34] 0  :  c_numtype
[notation 4-runtime.watsup:48.23-48.34] {}  :  {}
[elab 4-runtime.watsup:49.14-49.18] (rt)  :  (valtype)
[elab 4-runtime.watsup:49.15-49.17] rt  :  (valtype)
[elab 4-runtime.watsup:49.21-49.34] ({REF.NULL rt})  :  val
[elab 4-runtime.watsup:49.22-49.33] {REF.NULL rt}  :  val
[notation 4-runtime.watsup:49.22-49.33] {rt}  :  {reftype}
[notation 4-runtime.watsup:49.31-49.33] rt  :  reftype
[elab 4-runtime.watsup:49.31-49.33] rt  :  reftype
[notation 4-runtime.watsup:49.22-49.33] {}  :  {}
[elab 4-runtime.watsup:98.14-98.21] (state)  :  (state)
[elab 4-runtime.watsup:98.15-98.20] state  :  (state)
[elab 4-runtime.watsup:99.14-99.22] ((s ; f))  :  (state)
[elab 4-runtime.watsup:99.15-99.21] (s ; f)  :  (state)
[elab 4-runtime.watsup:99.16-99.20] s ; f  :  (state)
[notation 4-runtime.watsup:99.16-99.20] s ; f  :  store ; frame
[notation 4-runtime.watsup:99.16-99.17] s  :  store
[elab 4-runtime.watsup:99.16-99.17] s  :  store
[notation 4-runtime.watsup:99.19-99.20] f  :  frame
[elab 4-runtime.watsup:99.19-99.20] f  :  frame
[elab 4-runtime.watsup:99.25-99.38] f.MODULE.FUNC  :  funcaddr*
[elab 4-runtime.watsup:99.25-99.33] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:99.25-99.26] f  :  frame
[elab 4-runtime.watsup:101.14-101.21] (state)  :  (state)
[elab 4-runtime.watsup:101.15-101.20] state  :  (state)
[elab 4-runtime.watsup:102.14-102.22] ((s ; f))  :  (state)
[elab 4-runtime.watsup:102.15-102.21] (s ; f)  :  (state)
[elab 4-runtime.watsup:102.16-102.20] s ; f  :  (state)
[notation 4-runtime.watsup:102.16-102.20] s ; f  :  store ; frame
[notation 4-runtime.watsup:102.16-102.17] s  :  store
[elab 4-runtime.watsup:102.16-102.17] s  :  store
[notation 4-runtime.watsup:102.19-102.20] f  :  frame
[elab 4-runtime.watsup:102.19-102.20] f  :  frame
[elab 4-runtime.watsup:102.25-102.31] s.FUNC  :  funcinst*
[elab 4-runtime.watsup:102.25-102.26] s  :  store
[elab 4-runtime.watsup:104.10-104.26] (state, funcidx)  :  (state, funcidx)
[elab 4-runtime.watsup:104.11-104.16] state  :  state
[elab 4-runtime.watsup:104.18-104.25] funcidx  :  funcidx
[elab 4-runtime.watsup:105.10-105.21] ((s ; f), x)  :  (state, funcidx)
[elab 4-runtime.watsup:105.11-105.17] (s ; f)  :  state
[elab 4-runtime.watsup:105.12-105.16] s ; f  :  state
[notation 4-runtime.watsup:105.12-105.16] s ; f  :  store ; frame
[notation 4-runtime.watsup:105.12-105.13] s  :  store
[elab 4-runtime.watsup:105.12-105.13] s  :  store
[notation 4-runtime.watsup:105.15-105.16] f  :  frame
[elab 4-runtime.watsup:105.15-105.16] f  :  frame
[elab 4-runtime.watsup:105.19-105.20] x  :  funcidx
[elab 4-runtime.watsup:105.24-105.48] s.FUNC[f.MODULE.FUNC[x]]  :  funcinst
[elab 4-runtime.watsup:105.24-105.30] s.FUNC  :  funcinst*
[elab 4-runtime.watsup:105.24-105.25] s  :  store
[elab 4-runtime.watsup:105.31-105.47] f.MODULE.FUNC[x]  :  nat
[elab 4-runtime.watsup:105.31-105.44] f.MODULE.FUNC  :  funcaddr*
[elab 4-runtime.watsup:105.31-105.39] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:105.31-105.32] f  :  frame
[elab 4-runtime.watsup:105.45-105.46] x  :  nat
[elab 4-runtime.watsup:107.11-107.28] (state, localidx)  :  (state, localidx)
[elab 4-runtime.watsup:107.12-107.17] state  :  state
[elab 4-runtime.watsup:107.19-107.27] localidx  :  localidx
[elab 4-runtime.watsup:108.11-108.22] ((s ; f), x)  :  (state, localidx)
[elab 4-runtime.watsup:108.12-108.18] (s ; f)  :  state
[elab 4-runtime.watsup:108.13-108.17] s ; f  :  state
[notation 4-runtime.watsup:108.13-108.17] s ; f  :  store ; frame
[notation 4-runtime.watsup:108.13-108.14] s  :  store
[elab 4-runtime.watsup:108.13-108.14] s  :  store
[notation 4-runtime.watsup:108.16-108.17] f  :  frame
[elab 4-runtime.watsup:108.16-108.17] f  :  frame
[elab 4-runtime.watsup:108.20-108.21] x  :  localidx
[elab 4-runtime.watsup:108.25-108.35] f.LOCAL[x]  :  val
[elab 4-runtime.watsup:108.25-108.32] f.LOCAL  :  val*
[elab 4-runtime.watsup:108.25-108.26] f  :  frame
[elab 4-runtime.watsup:108.33-108.34] x  :  nat
[elab 4-runtime.watsup:110.12-110.30] (state, globalidx)  :  (state, globalidx)
[elab 4-runtime.watsup:110.13-110.18] state  :  state
[elab 4-runtime.watsup:110.20-110.29] globalidx  :  globalidx
[elab 4-runtime.watsup:111.12-111.23] ((s ; f), x)  :  (state, globalidx)
[elab 4-runtime.watsup:111.13-111.19] (s ; f)  :  state
[elab 4-runtime.watsup:111.14-111.18] s ; f  :  state
[notation 4-runtime.watsup:111.14-111.18] s ; f  :  store ; frame
[notation 4-runtime.watsup:111.14-111.15] s  :  store
[elab 4-runtime.watsup:111.14-111.15] s  :  store
[notation 4-runtime.watsup:111.17-111.18] f  :  frame
[elab 4-runtime.watsup:111.17-111.18] f  :  frame
[elab 4-runtime.watsup:111.21-111.22] x  :  globalidx
[elab 4-runtime.watsup:111.26-111.54] s.GLOBAL[f.MODULE.GLOBAL[x]]  :  globalinst
[elab 4-runtime.watsup:111.26-111.34] s.GLOBAL  :  globalinst*
[elab 4-runtime.watsup:111.26-111.27] s  :  store
[elab 4-runtime.watsup:111.35-111.53] f.MODULE.GLOBAL[x]  :  nat
[elab 4-runtime.watsup:111.35-111.50] f.MODULE.GLOBAL  :  globaladdr*
[elab 4-runtime.watsup:111.35-111.43] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:111.35-111.36] f  :  frame
[elab 4-runtime.watsup:111.51-111.52] x  :  nat
[elab 4-runtime.watsup:113.11-113.28] (state, tableidx)  :  (state, tableidx)
[elab 4-runtime.watsup:113.12-113.17] state  :  state
[elab 4-runtime.watsup:113.19-113.27] tableidx  :  tableidx
[elab 4-runtime.watsup:114.11-114.22] ((s ; f), x)  :  (state, tableidx)
[elab 4-runtime.watsup:114.12-114.18] (s ; f)  :  state
[elab 4-runtime.watsup:114.13-114.17] s ; f  :  state
[notation 4-runtime.watsup:114.13-114.17] s ; f  :  store ; frame
[notation 4-runtime.watsup:114.13-114.14] s  :  store
[elab 4-runtime.watsup:114.13-114.14] s  :  store
[notation 4-runtime.watsup:114.16-114.17] f  :  frame
[elab 4-runtime.watsup:114.16-114.17] f  :  frame
[elab 4-runtime.watsup:114.20-114.21] x  :  tableidx
[elab 4-runtime.watsup:114.25-114.51] s.TABLE[f.MODULE.TABLE[x]]  :  tableinst
[elab 4-runtime.watsup:114.25-114.32] s.TABLE  :  tableinst*
[elab 4-runtime.watsup:114.25-114.26] s  :  store
[elab 4-runtime.watsup:114.33-114.50] f.MODULE.TABLE[x]  :  nat
[elab 4-runtime.watsup:114.33-114.47] f.MODULE.TABLE  :  tableaddr*
[elab 4-runtime.watsup:114.33-114.41] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:114.33-114.34] f  :  frame
[elab 4-runtime.watsup:114.48-114.49] x  :  nat
[elab 4-runtime.watsup:116.10-116.27] (state, tableidx)  :  (state, tableidx)
[elab 4-runtime.watsup:116.11-116.16] state  :  state
[elab 4-runtime.watsup:116.18-116.26] tableidx  :  tableidx
[elab 4-runtime.watsup:117.10-117.21] ((s ; f), x)  :  (state, tableidx)
[elab 4-runtime.watsup:117.11-117.17] (s ; f)  :  state
[elab 4-runtime.watsup:117.12-117.16] s ; f  :  state
[notation 4-runtime.watsup:117.12-117.16] s ; f  :  store ; frame
[notation 4-runtime.watsup:117.12-117.13] s  :  store
[elab 4-runtime.watsup:117.12-117.13] s  :  store
[notation 4-runtime.watsup:117.15-117.16] f  :  frame
[elab 4-runtime.watsup:117.15-117.16] f  :  frame
[elab 4-runtime.watsup:117.19-117.20] x  :  tableidx
[elab 4-runtime.watsup:117.24-117.48] s.ELEM[f.MODULE.ELEM[x]]  :  eleminst
[elab 4-runtime.watsup:117.24-117.30] s.ELEM  :  eleminst*
[elab 4-runtime.watsup:117.24-117.25] s  :  store
[elab 4-runtime.watsup:117.31-117.47] f.MODULE.ELEM[x]  :  nat
[elab 4-runtime.watsup:117.31-117.44] f.MODULE.ELEM  :  elemaddr*
[elab 4-runtime.watsup:117.31-117.39] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:117.31-117.32] f  :  frame
[elab 4-runtime.watsup:117.45-117.46] x  :  nat
[elab 4-runtime.watsup:119.16-119.38] (state, localidx, val)  :  (state, localidx, val)
[elab 4-runtime.watsup:119.17-119.22] state  :  state
[elab 4-runtime.watsup:119.24-119.32] localidx  :  localidx
[elab 4-runtime.watsup:119.34-119.37] val  :  val
[elab 4-runtime.watsup:120.16-120.30] ((s ; f), x, v)  :  (state, localidx, val)
[elab 4-runtime.watsup:120.17-120.23] (s ; f)  :  state
[elab 4-runtime.watsup:120.18-120.22] s ; f  :  state
[notation 4-runtime.watsup:120.18-120.22] s ; f  :  store ; frame
[notation 4-runtime.watsup:120.18-120.19] s  :  store
[elab 4-runtime.watsup:120.18-120.19] s  :  store
[notation 4-runtime.watsup:120.21-120.22] f  :  frame
[elab 4-runtime.watsup:120.21-120.22] f  :  frame
[elab 4-runtime.watsup:120.25-120.26] x  :  localidx
[elab 4-runtime.watsup:120.28-120.29] v  :  val
[elab 4-runtime.watsup:120.33-120.50] s ; f[LOCAL[x] = v]  :  state
[notation 4-runtime.watsup:120.33-120.50] s ; f[LOCAL[x] = v]  :  store ; frame
[notation 4-runtime.watsup:120.33-120.34] s  :  store
[elab 4-runtime.watsup:120.33-120.34] s  :  store
[notation 4-runtime.watsup:120.36-120.50] f[LOCAL[x] = v]  :  frame
[elab 4-runtime.watsup:120.36-120.50] f[LOCAL[x] = v]  :  frame
[elab 4-runtime.watsup:120.36-120.37] f  :  frame
[elab 4-runtime.watsup:120.45-120.46] x  :  nat
[elab 4-runtime.watsup:120.48-120.49] v  :  val
[elab 4-runtime.watsup:122.17-122.40] (state, globalidx, val)  :  (state, globalidx, val)
[elab 4-runtime.watsup:122.18-122.23] state  :  state
[elab 4-runtime.watsup:122.25-122.34] globalidx  :  globalidx
[elab 4-runtime.watsup:122.36-122.39] val  :  val
[elab 4-runtime.watsup:123.17-123.31] ((s ; f), x, v)  :  (state, globalidx, val)
[elab 4-runtime.watsup:123.18-123.24] (s ; f)  :  state
[elab 4-runtime.watsup:123.19-123.23] s ; f  :  state
[notation 4-runtime.watsup:123.19-123.23] s ; f  :  store ; frame
[notation 4-runtime.watsup:123.19-123.20] s  :  store
[elab 4-runtime.watsup:123.19-123.20] s  :  store
[notation 4-runtime.watsup:123.22-123.23] f  :  frame
[elab 4-runtime.watsup:123.22-123.23] f  :  frame
[elab 4-runtime.watsup:123.26-123.27] x  :  globalidx
[elab 4-runtime.watsup:123.29-123.30] v  :  val
[elab 4-runtime.watsup:123.34-123.69] s[GLOBAL[f.MODULE.GLOBAL[x]] = v] ; f  :  state
[notation 4-runtime.watsup:123.34-123.69] s[GLOBAL[f.MODULE.GLOBAL[x]] = v] ; f  :  store ; frame
[notation 4-runtime.watsup:123.34-123.66] s[GLOBAL[f.MODULE.GLOBAL[x]] = v]  :  store
[elab 4-runtime.watsup:123.34-123.66] s[GLOBAL[f.MODULE.GLOBAL[x]] = v]  :  store
[elab 4-runtime.watsup:123.34-123.35] s  :  store
[elab 4-runtime.watsup:123.44-123.62] f.MODULE.GLOBAL[x]  :  nat
[elab 4-runtime.watsup:123.44-123.59] f.MODULE.GLOBAL  :  globaladdr*
[elab 4-runtime.watsup:123.44-123.52] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:123.44-123.45] f  :  frame
[elab 4-runtime.watsup:123.60-123.61] x  :  nat
[elab 4-runtime.watsup:123.64-123.65] v  :  globalinst
[notation 4-runtime.watsup:123.68-123.69] f  :  frame
[elab 4-runtime.watsup:123.68-123.69] f  :  frame
[elab 4-runtime.watsup:125.16-125.41] (state, tableidx, n, ref)  :  (state, tableidx, n, ref)
[elab 4-runtime.watsup:125.17-125.22] state  :  state
[elab 4-runtime.watsup:125.24-125.32] tableidx  :  tableidx
[elab 4-runtime.watsup:125.34-125.35] n  :  n
[elab 4-runtime.watsup:125.37-125.40] ref  :  ref
[elab 4-runtime.watsup:126.16-126.33] ((s ; f), x, i, r)  :  (state, tableidx, n, ref)
[elab 4-runtime.watsup:126.17-126.23] (s ; f)  :  state
[elab 4-runtime.watsup:126.18-126.22] s ; f  :  state
[notation 4-runtime.watsup:126.18-126.22] s ; f  :  store ; frame
[notation 4-runtime.watsup:126.18-126.19] s  :  store
[elab 4-runtime.watsup:126.18-126.19] s  :  store
[notation 4-runtime.watsup:126.21-126.22] f  :  frame
[elab 4-runtime.watsup:126.21-126.22] f  :  frame
[elab 4-runtime.watsup:126.25-126.26] x  :  tableidx
[elab 4-runtime.watsup:126.28-126.29] i  :  n
[elab 4-runtime.watsup:126.31-126.32] r  :  ref
[elab 4-runtime.watsup:126.36-126.72] s[TABLE[f.MODULE.TABLE[x]][i] = r] ; f  :  state
[notation 4-runtime.watsup:126.36-126.72] s[TABLE[f.MODULE.TABLE[x]][i] = r] ; f  :  store ; frame
[notation 4-runtime.watsup:126.36-126.69] s[TABLE[f.MODULE.TABLE[x]][i] = r]  :  store
[elab 4-runtime.watsup:126.36-126.69] s[TABLE[f.MODULE.TABLE[x]][i] = r]  :  store
[elab 4-runtime.watsup:126.36-126.37] s  :  store
[elab 4-runtime.watsup:126.45-126.62] f.MODULE.TABLE[x]  :  nat
[elab 4-runtime.watsup:126.45-126.59] f.MODULE.TABLE  :  tableaddr*
[elab 4-runtime.watsup:126.45-126.53] f.MODULE  :  moduleinst
[elab 4-runtime.watsup:126.45-126.46] f  :  frame
[elab 4-runtime.watsup:126.60-126.61] x  :  nat
[elab 4-runtime.watsup:126.64-126.65] i  :  nat
[elab 4-runtime.watsup:126.67-126.68] r  :  ref
[notation 4-runtime.watsup:126.71-126.72] f  :  frame
[elab 4-runtime.watsup:126.71-126.72] f  :  frame
[notation 5-reduction.watsup:9.3-9.28] z ; instr* ~> z ; instr'*  :  config ~> config
[notation 5-reduction.watsup:9.3-9.12] z ; instr*  :  config
[elab 5-reduction.watsup:9.3-9.12] z ; instr*  :  config
[notation 5-reduction.watsup:9.3-9.12] z ; instr*  :  state ; admininstr*
[notation 5-reduction.watsup:9.3-9.4] z  :  state
[elab 5-reduction.watsup:9.3-9.4] z  :  state
[notation 5-reduction.watsup:9.6-9.12] instr*  :  admininstr*
[notation 5-reduction.watsup:9.6-9.11] instr  :  admininstr
[elab 5-reduction.watsup:9.6-9.11] instr  :  admininstr
[notation 5-reduction.watsup:9.18-9.28] z ; instr'*  :  config
[elab 5-reduction.watsup:9.18-9.28] z ; instr'*  :  config
[notation 5-reduction.watsup:9.18-9.28] z ; instr'*  :  state ; admininstr*
[notation 5-reduction.watsup:9.18-9.19] z  :  state
[elab 5-reduction.watsup:9.18-9.19] z  :  state
[notation 5-reduction.watsup:9.21-9.28] instr'*  :  admininstr*
[notation 5-reduction.watsup:9.21-9.27] instr'  :  admininstr
[elab 5-reduction.watsup:9.21-9.27] instr'  :  admininstr
[notation 5-reduction.watsup:10.17-10.34] instr* ~> instr'*  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:10.17-10.23] instr*  :  admininstr*
[notation 5-reduction.watsup:10.17-10.22] instr  :  admininstr
[elab 5-reduction.watsup:10.17-10.22] instr  :  admininstr
[notation 5-reduction.watsup:10.27-10.34] instr'*  :  admininstr*
[notation 5-reduction.watsup:10.27-10.33] instr'  :  admininstr
[elab 5-reduction.watsup:10.27-10.33] instr'  :  admininstr
[notation 5-reduction.watsup:13.3-13.28] z ; instr* ~> z ; instr'*  :  config ~> config
[notation 5-reduction.watsup:13.3-13.12] z ; instr*  :  config
[elab 5-reduction.watsup:13.3-13.12] z ; instr*  :  config
[notation 5-reduction.watsup:13.3-13.12] z ; instr*  :  state ; admininstr*
[notation 5-reduction.watsup:13.3-13.4] z  :  state
[elab 5-reduction.watsup:13.3-13.4] z  :  state
[notation 5-reduction.watsup:13.6-13.12] instr*  :  admininstr*
[notation 5-reduction.watsup:13.6-13.11] instr  :  admininstr
[elab 5-reduction.watsup:13.6-13.11] instr  :  admininstr
[notation 5-reduction.watsup:13.18-13.28] z ; instr'*  :  config
[elab 5-reduction.watsup:13.18-13.28] z ; instr'*  :  config
[notation 5-reduction.watsup:13.18-13.28] z ; instr'*  :  state ; admininstr*
[notation 5-reduction.watsup:13.18-13.19] z  :  state
[elab 5-reduction.watsup:13.18-13.19] z  :  state
[notation 5-reduction.watsup:13.21-13.28] instr'*  :  admininstr*
[notation 5-reduction.watsup:13.21-13.27] instr'  :  admininstr
[elab 5-reduction.watsup:13.21-13.27] instr'  :  admininstr
[notation 5-reduction.watsup:14.17-14.37] z ; instr* ~> instr'*  :  config ~> admininstr*
[notation 5-reduction.watsup:14.17-14.26] z ; instr*  :  config
[elab 5-reduction.watsup:14.17-14.26] z ; instr*  :  config
[notation 5-reduction.watsup:14.17-14.26] z ; instr*  :  state ; admininstr*
[notation 5-reduction.watsup:14.17-14.18] z  :  state
[elab 5-reduction.watsup:14.17-14.18] z  :  state
[notation 5-reduction.watsup:14.20-14.26] instr*  :  admininstr*
[notation 5-reduction.watsup:14.20-14.25] instr  :  admininstr
[elab 5-reduction.watsup:14.20-14.25] instr  :  admininstr
[notation 5-reduction.watsup:14.30-14.37] instr'*  :  admininstr*
[notation 5-reduction.watsup:14.30-14.36] instr'  :  admininstr
[elab 5-reduction.watsup:14.30-14.36] instr'  :  admininstr
[notation 5-reduction.watsup:17.3-17.29] z ; instr* ~> z' ; instr'*  :  config ~> config
[notation 5-reduction.watsup:17.3-17.12] z ; instr*  :  config
[elab 5-reduction.watsup:17.3-17.12] z ; instr*  :  config
[notation 5-reduction.watsup:17.3-17.12] z ; instr*  :  state ; admininstr*
[notation 5-reduction.watsup:17.3-17.4] z  :  state
[elab 5-reduction.watsup:17.3-17.4] z  :  state
[notation 5-reduction.watsup:17.6-17.12] instr*  :  admininstr*
[notation 5-reduction.watsup:17.6-17.11] instr  :  admininstr
[elab 5-reduction.watsup:17.6-17.11] instr  :  admininstr
[notation 5-reduction.watsup:17.18-17.29] z' ; instr'*  :  config
[elab 5-reduction.watsup:17.18-17.29] z' ; instr'*  :  config
[notation 5-reduction.watsup:17.18-17.29] z' ; instr'*  :  state ; admininstr*
[notation 5-reduction.watsup:17.18-17.20] z'  :  state
[elab 5-reduction.watsup:17.18-17.20] z'  :  state
[notation 5-reduction.watsup:17.22-17.29] instr'*  :  admininstr*
[notation 5-reduction.watsup:17.22-17.28] instr'  :  admininstr
[elab 5-reduction.watsup:17.22-17.28] instr'  :  admininstr
[notation 5-reduction.watsup:18.18-18.42] z ; instr* ~> z' ; instr'*  :  config ~> config
[notation 5-reduction.watsup:18.18-18.27] z ; instr*  :  config
[elab 5-reduction.watsup:18.18-18.27] z ; instr*  :  config
[notation 5-reduction.watsup:18.18-18.27] z ; instr*  :  state ; admininstr*
[notation 5-reduction.watsup:18.18-18.19] z  :  state
[elab 5-reduction.watsup:18.18-18.19] z  :  state
[notation 5-reduction.watsup:18.21-18.27] instr*  :  admininstr*
[notation 5-reduction.watsup:18.21-18.26] instr  :  admininstr
[elab 5-reduction.watsup:18.21-18.26] instr  :  admininstr
[notation 5-reduction.watsup:18.31-18.42] z' ; instr'*  :  config
[elab 5-reduction.watsup:18.31-18.42] z' ; instr'*  :  config
[notation 5-reduction.watsup:18.31-18.42] z' ; instr'*  :  state ; admininstr*
[notation 5-reduction.watsup:18.31-18.33] z'  :  state
[elab 5-reduction.watsup:18.31-18.33] z'  :  state
[notation 5-reduction.watsup:18.35-18.42] instr'*  :  admininstr*
[notation 5-reduction.watsup:18.35-18.41] instr'  :  admininstr
[elab 5-reduction.watsup:18.35-18.41] instr'  :  admininstr
[notation 5-reduction.watsup:22.3-22.35] {val REF.IS_NULL} ~> ({CONST I32 1})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:22.3-22.18] {val REF.IS_NULL}  :  admininstr*
[niteration 5-reduction.watsup:22.3-22.18] val REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:22.3-22.6] val  :  admininstr*
[notation 5-reduction.watsup:22.3-22.6] val  :  admininstr
[elab 5-reduction.watsup:22.3-22.6] val  :  admininstr
[niteration 5-reduction.watsup:22.3-22.18] REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr
[elab 5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr
[notation 5-reduction.watsup:22.7-22.18] {}  :  {}
[niteration 5-reduction.watsup:22.3-22.18]   :  admininstr*
[notation 5-reduction.watsup:22.22-22.35] ({CONST I32 1})  :  admininstr*
[notation 5-reduction.watsup:22.23-22.34] {CONST I32 1}  :  admininstr
[elab 5-reduction.watsup:22.23-22.34] {CONST I32 1}  :  admininstr
[notation 5-reduction.watsup:22.23-22.34] {I32 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:22.29-22.32] I32  :  numtype
[elab 5-reduction.watsup:22.29-22.32] I32  :  numtype
[notation 5-reduction.watsup:22.29-22.32] {}  :  {}
[notation 5-reduction.watsup:22.23-22.34] {1}  :  {c_numtype}
[notation 5-reduction.watsup:22.33-22.34] 1  :  c_numtype
[elab 5-reduction.watsup:22.33-22.34] 1  :  c_numtype
[notation 5-reduction.watsup:22.23-22.34] {}  :  {}
[elab 5-reduction.watsup:23.9-23.26] val = {REF.NULL rt}  :  bool
[elab 5-reduction.watsup:23.9-23.12] val  :  val
[elab 5-reduction.watsup:23.15-23.26] {REF.NULL rt}  :  val
[notation 5-reduction.watsup:23.15-23.26] {rt}  :  {reftype}
[notation 5-reduction.watsup:23.24-23.26] rt  :  reftype
[elab 5-reduction.watsup:23.24-23.26] rt  :  reftype
[notation 5-reduction.watsup:23.15-23.26] {}  :  {}
[notation 5-reduction.watsup:26.3-26.35] {val REF.IS_NULL} ~> ({CONST I32 0})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:26.3-26.18] {val REF.IS_NULL}  :  admininstr*
[niteration 5-reduction.watsup:26.3-26.18] val REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:26.3-26.6] val  :  admininstr*
[notation 5-reduction.watsup:26.3-26.6] val  :  admininstr
[elab 5-reduction.watsup:26.3-26.6] val  :  admininstr
[niteration 5-reduction.watsup:26.3-26.18] REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr*
[notation 5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr
[elab 5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr
[notation 5-reduction.watsup:26.7-26.18] {}  :  {}
[niteration 5-reduction.watsup:26.3-26.18]   :  admininstr*
[notation 5-reduction.watsup:26.22-26.35] ({CONST I32 0})  :  admininstr*
[notation 5-reduction.watsup:26.23-26.34] {CONST I32 0}  :  admininstr
[elab 5-reduction.watsup:26.23-26.34] {CONST I32 0}  :  admininstr
[notation 5-reduction.watsup:26.23-26.34] {I32 0}  :  {numtype c_numtype}
[notation 5-reduction.watsup:26.29-26.32] I32  :  numtype
[elab 5-reduction.watsup:26.29-26.32] I32  :  numtype
[notation 5-reduction.watsup:26.29-26.32] {}  :  {}
[notation 5-reduction.watsup:26.23-26.34] {0}  :  {c_numtype}
[notation 5-reduction.watsup:26.33-26.34] 0  :  c_numtype
[elab 5-reduction.watsup:26.33-26.34] 0  :  c_numtype
[notation 5-reduction.watsup:26.23-26.34] {}  :  {}
[notation 5-reduction.watsup:30.3-30.24] UNREACHABLE ~> TRAP  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr*
[notation 5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr
[elab 5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr
[notation 5-reduction.watsup:30.3-30.14] {}  :  {}
[notation 5-reduction.watsup:30.20-30.24] TRAP  :  admininstr*
[notation 5-reduction.watsup:30.20-30.24] TRAP  :  admininstr
[elab 5-reduction.watsup:30.20-30.24] TRAP  :  admininstr
[notation 5-reduction.watsup:30.20-30.24] {}  :  {}
[notation 5-reduction.watsup:33.3-33.19] NOP ~> epsilon  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:33.3-33.6] NOP  :  admininstr*
[notation 5-reduction.watsup:33.3-33.6] NOP  :  admininstr
[elab 5-reduction.watsup:33.3-33.6] NOP  :  admininstr
[notation 5-reduction.watsup:33.3-33.6] {}  :  {}
[notation 5-reduction.watsup:33.12-33.19] epsilon  :  admininstr*
[niteration 5-reduction.watsup:33.12-33.19]   :  admininstr*
[notation 5-reduction.watsup:36.3-36.24] {val DROP} ~> epsilon  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:36.3-36.11] {val DROP}  :  admininstr*
[niteration 5-reduction.watsup:36.3-36.11] val DROP  :  admininstr*
[notation 5-reduction.watsup:36.3-36.6] val  :  admininstr*
[notation 5-reduction.watsup:36.3-36.6] val  :  admininstr
[elab 5-reduction.watsup:36.3-36.6] val  :  admininstr
[niteration 5-reduction.watsup:36.3-36.11] DROP  :  admininstr*
[notation 5-reduction.watsup:36.7-36.11] DROP  :  admininstr*
[notation 5-reduction.watsup:36.7-36.11] DROP  :  admininstr
[elab 5-reduction.watsup:36.7-36.11] DROP  :  admininstr
[notation 5-reduction.watsup:36.7-36.11] {}  :  {}
[niteration 5-reduction.watsup:36.3-36.11]   :  admininstr*
[notation 5-reduction.watsup:36.17-36.24] epsilon  :  admininstr*
[niteration 5-reduction.watsup:36.17-36.24]   :  admininstr*
[notation 5-reduction.watsup:39.3-39.51] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_1  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:39.3-39.40] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})}  :  admininstr*
[niteration 5-reduction.watsup:39.3-39.40] val_1 val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:39.3-39.8] val_1  :  admininstr*
[notation 5-reduction.watsup:39.3-39.8] val_1  :  admininstr
[elab 5-reduction.watsup:39.3-39.8] val_1  :  admininstr
[niteration 5-reduction.watsup:39.3-39.40] val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:39.9-39.14] val_2  :  admininstr*
[notation 5-reduction.watsup:39.9-39.14] val_2  :  admininstr
[elab 5-reduction.watsup:39.9-39.14] val_2  :  admininstr
[niteration 5-reduction.watsup:39.3-39.40] ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:39.15-39.28] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:39.15-39.28] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:39.16-39.27] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:39.16-39.27] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:39.16-39.27] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:39.22-39.25] I32  :  numtype
[elab 5-reduction.watsup:39.22-39.25] I32  :  numtype
[notation 5-reduction.watsup:39.22-39.25] {}  :  {}
[notation 5-reduction.watsup:39.16-39.27] {c}  :  {c_numtype}
[notation 5-reduction.watsup:39.26-39.27] c  :  c_numtype
[elab 5-reduction.watsup:39.26-39.27] c  :  c_numtype
[notation 5-reduction.watsup:39.16-39.27] {}  :  {}
[niteration 5-reduction.watsup:39.3-39.40] ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:39.29-39.40] ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:39.29-39.40] ({SELECT t?})  :  admininstr
[notation 5-reduction.watsup:39.30-39.39] {SELECT t?}  :  admininstr
[elab 5-reduction.watsup:39.30-39.39] {SELECT t?}  :  admininstr
[notation 5-reduction.watsup:39.30-39.39] {t?}  :  {valtype?}
[notation 5-reduction.watsup:39.30-39.39] {t?}  :  valtype?
[elab 5-reduction.watsup:39.37-39.39] t?  :  valtype?
[elab 5-reduction.watsup:39.37-39.38] t  :  valtype
[niteration 5-reduction.watsup:39.3-39.40]   :  admininstr*
[notation 5-reduction.watsup:39.46-39.51] val_1  :  admininstr*
[notation 5-reduction.watsup:39.46-39.51] val_1  :  admininstr
[elab 5-reduction.watsup:39.46-39.51] val_1  :  admininstr
[elab 5-reduction.watsup:40.9-40.16] c =/= 0  :  bool
[elab 5-reduction.watsup:40.9-40.10] c  :  c_numtype
[elab 5-reduction.watsup:40.15-40.16] 0  :  c_numtype
[notation 5-reduction.watsup:43.3-43.51] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_2  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:43.3-43.40] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})}  :  admininstr*
[niteration 5-reduction.watsup:43.3-43.40] val_1 val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:43.3-43.8] val_1  :  admininstr*
[notation 5-reduction.watsup:43.3-43.8] val_1  :  admininstr
[elab 5-reduction.watsup:43.3-43.8] val_1  :  admininstr
[niteration 5-reduction.watsup:43.3-43.40] val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:43.9-43.14] val_2  :  admininstr*
[notation 5-reduction.watsup:43.9-43.14] val_2  :  admininstr
[elab 5-reduction.watsup:43.9-43.14] val_2  :  admininstr
[niteration 5-reduction.watsup:43.3-43.40] ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:43.15-43.28] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:43.15-43.28] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:43.16-43.27] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:43.16-43.27] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:43.16-43.27] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:43.22-43.25] I32  :  numtype
[elab 5-reduction.watsup:43.22-43.25] I32  :  numtype
[notation 5-reduction.watsup:43.22-43.25] {}  :  {}
[notation 5-reduction.watsup:43.16-43.27] {c}  :  {c_numtype}
[notation 5-reduction.watsup:43.26-43.27] c  :  c_numtype
[elab 5-reduction.watsup:43.26-43.27] c  :  c_numtype
[notation 5-reduction.watsup:43.16-43.27] {}  :  {}
[niteration 5-reduction.watsup:43.3-43.40] ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:43.29-43.40] ({SELECT t?})  :  admininstr*
[notation 5-reduction.watsup:43.29-43.40] ({SELECT t?})  :  admininstr
[notation 5-reduction.watsup:43.30-43.39] {SELECT t?}  :  admininstr
[elab 5-reduction.watsup:43.30-43.39] {SELECT t?}  :  admininstr
[notation 5-reduction.watsup:43.30-43.39] {t?}  :  {valtype?}
[notation 5-reduction.watsup:43.30-43.39] {t?}  :  valtype?
[elab 5-reduction.watsup:43.37-43.39] t?  :  valtype?
[elab 5-reduction.watsup:43.37-43.38] t  :  valtype
[niteration 5-reduction.watsup:43.3-43.40]   :  admininstr*
[notation 5-reduction.watsup:43.46-43.51] val_2  :  admininstr*
[notation 5-reduction.watsup:43.46-43.51] val_2  :  admininstr
[elab 5-reduction.watsup:43.46-43.51] val_2  :  admininstr
[elab 5-reduction.watsup:44.9-44.14] c = 0  :  bool
[elab 5-reduction.watsup:44.9-44.10] c  :  c_numtype
[elab 5-reduction.watsup:44.13-44.14] 0  :  c_numtype
[notation 5-reduction.watsup:47.3-47.47] {val ({LOCAL.TEE x})} ~> {val val ({LOCAL.SET x})}  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:47.3-47.20] {val ({LOCAL.TEE x})}  :  admininstr*
[niteration 5-reduction.watsup:47.3-47.20] val ({LOCAL.TEE x})  :  admininstr*
[notation 5-reduction.watsup:47.3-47.6] val  :  admininstr*
[notation 5-reduction.watsup:47.3-47.6] val  :  admininstr
[elab 5-reduction.watsup:47.3-47.6] val  :  admininstr
[niteration 5-reduction.watsup:47.3-47.20] ({LOCAL.TEE x})  :  admininstr*
[notation 5-reduction.watsup:47.7-47.20] ({LOCAL.TEE x})  :  admininstr*
[notation 5-reduction.watsup:47.7-47.20] ({LOCAL.TEE x})  :  admininstr
[notation 5-reduction.watsup:47.8-47.19] {LOCAL.TEE x}  :  admininstr
[elab 5-reduction.watsup:47.8-47.19] {LOCAL.TEE x}  :  admininstr
[notation 5-reduction.watsup:47.8-47.19] {x}  :  {localidx}
[notation 5-reduction.watsup:47.18-47.19] x  :  localidx
[elab 5-reduction.watsup:47.18-47.19] x  :  localidx
[notation 5-reduction.watsup:47.8-47.19] {}  :  {}
[niteration 5-reduction.watsup:47.3-47.20]   :  admininstr*
[notation 5-reduction.watsup:47.26-47.47] {val val ({LOCAL.SET x})}  :  admininstr*
[niteration 5-reduction.watsup:47.26-47.47] val val ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:47.26-47.29] val  :  admininstr*
[notation 5-reduction.watsup:47.26-47.29] val  :  admininstr
[elab 5-reduction.watsup:47.26-47.29] val  :  admininstr
[niteration 5-reduction.watsup:47.26-47.47] val ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:47.30-47.33] val  :  admininstr*
[notation 5-reduction.watsup:47.30-47.33] val  :  admininstr
[elab 5-reduction.watsup:47.30-47.33] val  :  admininstr
[niteration 5-reduction.watsup:47.26-47.47] ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:47.34-47.47] ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:47.34-47.47] ({LOCAL.SET x})  :  admininstr
[notation 5-reduction.watsup:47.35-47.46] {LOCAL.SET x}  :  admininstr
[elab 5-reduction.watsup:47.35-47.46] {LOCAL.SET x}  :  admininstr
[notation 5-reduction.watsup:47.35-47.46] {x}  :  {localidx}
[notation 5-reduction.watsup:47.45-47.46] x  :  localidx
[elab 5-reduction.watsup:47.45-47.46] x  :  localidx
[notation 5-reduction.watsup:47.35-47.46] {}  :  {}
[niteration 5-reduction.watsup:47.26-47.47]   :  admininstr*
[notation 5-reduction.watsup:50.3-50.66] {val^k ({BLOCK bt instr*})} ~> ({LABEL_ n `{epsilon} val^k instr*})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:50.3-50.26] {val^k ({BLOCK bt instr*})}  :  admininstr*
[niteration 5-reduction.watsup:50.3-50.26] val^k ({BLOCK bt instr*})  :  admininstr*
[notation 5-reduction.watsup:50.3-50.8] val^k  :  admininstr*
[notation 5-reduction.watsup:50.3-50.6] val  :  admininstr
[elab 5-reduction.watsup:50.3-50.6] val  :  admininstr
[elab 5-reduction.watsup:50.7-50.8] k  :  nat
[niteration 5-reduction.watsup:50.3-50.26] ({BLOCK bt instr*})  :  admininstr*
[notation 5-reduction.watsup:50.9-50.26] ({BLOCK bt instr*})  :  admininstr*
[notation 5-reduction.watsup:50.9-50.26] ({BLOCK bt instr*})  :  admininstr
[notation 5-reduction.watsup:50.10-50.25] {BLOCK bt instr*}  :  admininstr
[elab 5-reduction.watsup:50.10-50.25] {BLOCK bt instr*}  :  admininstr
[notation 5-reduction.watsup:50.10-50.25] {bt instr*}  :  {blocktype instr*}
[notation 5-reduction.watsup:50.16-50.18] bt  :  blocktype
[elab 5-reduction.watsup:50.16-50.18] bt  :  blocktype
[notation 5-reduction.watsup:50.10-50.25] {instr*}  :  {instr*}
[notation 5-reduction.watsup:50.10-50.25] {instr*}  :  instr*
[elab 5-reduction.watsup:50.19-50.25] instr*  :  instr*
[elab 5-reduction.watsup:50.19-50.24] instr  :  instr
[niteration 5-reduction.watsup:50.3-50.26]   :  admininstr*
[notation 5-reduction.watsup:50.32-50.66] ({LABEL_ n `{epsilon} val^k instr*})  :  admininstr*
[notation 5-reduction.watsup:50.33-50.65] {LABEL_ n `{epsilon} val^k instr*}  :  admininstr
[elab 5-reduction.watsup:50.33-50.65] {LABEL_ n `{epsilon} val^k instr*}  :  admininstr
[notation 5-reduction.watsup:50.33-50.65] {n `{epsilon} val^k instr*}  :  {n `{instr*} admininstr*}
[notation 5-reduction.watsup:50.40-50.41] n  :  n
[elab 5-reduction.watsup:50.40-50.41] n  :  n
[notation 5-reduction.watsup:50.33-50.65] {`{epsilon} val^k instr*}  :  {`{instr*} admininstr*}
[notation 5-reduction.watsup:50.42-50.52] `{epsilon}  :  `{instr*}
[notation 5-reduction.watsup:50.44-50.51] epsilon  :  instr*
[niteration 5-reduction.watsup:50.44-50.51]   :  instr*
[notation 5-reduction.watsup:50.33-50.65] {val^k instr*}  :  {admininstr*}
[notation 5-reduction.watsup:50.33-50.65] {val^k instr*}  :  admininstr*
[niteration 5-reduction.watsup:50.33-50.65] val^k instr*  :  admininstr*
[notation 5-reduction.watsup:50.53-50.58] val^k  :  admininstr*
[notation 5-reduction.watsup:50.53-50.56] val  :  admininstr
[elab 5-reduction.watsup:50.53-50.56] val  :  admininstr
[elab 5-reduction.watsup:50.57-50.58] k  :  nat
[niteration 5-reduction.watsup:50.33-50.65] instr*  :  admininstr*
[notation 5-reduction.watsup:50.59-50.65] instr*  :  admininstr*
[notation 5-reduction.watsup:50.59-50.64] instr  :  admininstr
[elab 5-reduction.watsup:50.59-50.64] instr  :  admininstr
[niteration 5-reduction.watsup:50.33-50.65]   :  admininstr*
[elab 5-reduction.watsup:51.9-51.28] bt = t_1^k -> t_2^n  :  bool
[elab 5-reduction.watsup:51.9-51.11] bt  :  blocktype
[elab 5-reduction.watsup:51.14-51.28] t_1^k -> t_2^n  :  blocktype
[notation 5-reduction.watsup:51.14-51.28] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation 5-reduction.watsup:51.14-51.19] t_1^k  :  resulttype
[elab 5-reduction.watsup:51.14-51.19] t_1^k  :  resulttype
[elab 5-reduction.watsup:51.14-51.17] t_1  :  valtype
[elab 5-reduction.watsup:51.18-51.19] k  :  nat
[notation 5-reduction.watsup:51.23-51.28] t_2^n  :  resulttype
[elab 5-reduction.watsup:51.23-51.28] t_2^n  :  resulttype
[elab 5-reduction.watsup:51.23-51.26] t_2  :  valtype
[elab 5-reduction.watsup:51.27-51.28] n  :  nat
[elab 5-reduction.watsup:51.18-51.19] k  :  nat
[elab 5-reduction.watsup:51.27-51.28] n  :  nat
[elab 5-reduction.watsup:50.57-50.58] k  :  nat
[notation 5-reduction.watsup:54.3-54.72] {val^k ({LOOP bt instr*})} ~> ({LABEL_ n `{{LOOP bt instr*}} val^k instr*})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:54.3-54.25] {val^k ({LOOP bt instr*})}  :  admininstr*
[niteration 5-reduction.watsup:54.3-54.25] val^k ({LOOP bt instr*})  :  admininstr*
[notation 5-reduction.watsup:54.3-54.8] val^k  :  admininstr*
[notation 5-reduction.watsup:54.3-54.6] val  :  admininstr
[elab 5-reduction.watsup:54.3-54.6] val  :  admininstr
[elab 5-reduction.watsup:54.7-54.8] k  :  nat
[niteration 5-reduction.watsup:54.3-54.25] ({LOOP bt instr*})  :  admininstr*
[notation 5-reduction.watsup:54.9-54.25] ({LOOP bt instr*})  :  admininstr*
[notation 5-reduction.watsup:54.9-54.25] ({LOOP bt instr*})  :  admininstr
[notation 5-reduction.watsup:54.10-54.24] {LOOP bt instr*}  :  admininstr
[elab 5-reduction.watsup:54.10-54.24] {LOOP bt instr*}  :  admininstr
[notation 5-reduction.watsup:54.10-54.24] {bt instr*}  :  {blocktype instr*}
[notation 5-reduction.watsup:54.15-54.17] bt  :  blocktype
[elab 5-reduction.watsup:54.15-54.17] bt  :  blocktype
[notation 5-reduction.watsup:54.10-54.24] {instr*}  :  {instr*}
[notation 5-reduction.watsup:54.10-54.24] {instr*}  :  instr*
[elab 5-reduction.watsup:54.18-54.24] instr*  :  instr*
[elab 5-reduction.watsup:54.18-54.23] instr  :  instr
[niteration 5-reduction.watsup:54.3-54.25]   :  admininstr*
[notation 5-reduction.watsup:54.31-54.72] ({LABEL_ n `{{LOOP bt instr*}} val^k instr*})  :  admininstr*
[notation 5-reduction.watsup:54.32-54.71] {LABEL_ n `{{LOOP bt instr*}} val^k instr*}  :  admininstr
[elab 5-reduction.watsup:54.32-54.71] {LABEL_ n `{{LOOP bt instr*}} val^k instr*}  :  admininstr
[notation 5-reduction.watsup:54.32-54.71] {n `{{LOOP bt instr*}} val^k instr*}  :  {n `{instr*} admininstr*}
[notation 5-reduction.watsup:54.39-54.40] n  :  n
[elab 5-reduction.watsup:54.39-54.40] n  :  n
[notation 5-reduction.watsup:54.32-54.71] {`{{LOOP bt instr*}} val^k instr*}  :  {`{instr*} admininstr*}
[notation 5-reduction.watsup:54.41-54.58] `{{LOOP bt instr*}}  :  `{instr*}
[notation 5-reduction.watsup:54.43-54.57] {LOOP bt instr*}  :  instr*
[niteration 5-reduction.watsup:54.43-54.57] LOOP bt instr*  :  instr*
[notation 5-reduction.watsup:54.43-54.57] {bt instr*}  :  {blocktype instr*}
[notation 5-reduction.watsup:54.48-54.50] bt  :  blocktype
[elab 5-reduction.watsup:54.48-54.50] bt  :  blocktype
[notation 5-reduction.watsup:54.43-54.57] {instr*}  :  {instr*}
[notation 5-reduction.watsup:54.43-54.57] {instr*}  :  instr*
[elab 5-reduction.watsup:54.51-54.57] instr*  :  instr*
[elab 5-reduction.watsup:54.51-54.56] instr  :  instr
[notation 5-reduction.watsup:54.32-54.71] {val^k instr*}  :  {admininstr*}
[notation 5-reduction.watsup:54.32-54.71] {val^k instr*}  :  admininstr*
[niteration 5-reduction.watsup:54.32-54.71] val^k instr*  :  admininstr*
[notation 5-reduction.watsup:54.59-54.64] val^k  :  admininstr*
[notation 5-reduction.watsup:54.59-54.62] val  :  admininstr
[elab 5-reduction.watsup:54.59-54.62] val  :  admininstr
[elab 5-reduction.watsup:54.63-54.64] k  :  nat
[niteration 5-reduction.watsup:54.32-54.71] instr*  :  admininstr*
[notation 5-reduction.watsup:54.65-54.71] instr*  :  admininstr*
[notation 5-reduction.watsup:54.65-54.70] instr  :  admininstr
[elab 5-reduction.watsup:54.65-54.70] instr  :  admininstr
[niteration 5-reduction.watsup:54.32-54.71]   :  admininstr*
[elab 5-reduction.watsup:55.9-55.28] bt = t_1^k -> t_2^n  :  bool
[elab 5-reduction.watsup:55.9-55.11] bt  :  blocktype
[elab 5-reduction.watsup:55.14-55.28] t_1^k -> t_2^n  :  blocktype
[notation 5-reduction.watsup:55.14-55.28] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation 5-reduction.watsup:55.14-55.19] t_1^k  :  resulttype
[elab 5-reduction.watsup:55.14-55.19] t_1^k  :  resulttype
[elab 5-reduction.watsup:55.14-55.17] t_1  :  valtype
[elab 5-reduction.watsup:55.18-55.19] k  :  nat
[notation 5-reduction.watsup:55.23-55.28] t_2^n  :  resulttype
[elab 5-reduction.watsup:55.23-55.28] t_2^n  :  resulttype
[elab 5-reduction.watsup:55.23-55.26] t_2  :  valtype
[elab 5-reduction.watsup:55.27-55.28] n  :  nat
[elab 5-reduction.watsup:55.18-55.19] k  :  nat
[elab 5-reduction.watsup:55.27-55.28] n  :  nat
[elab 5-reduction.watsup:54.63-54.64] k  :  nat
[notation 5-reduction.watsup:58.3-58.72] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_1*})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:58.3-58.47] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})}  :  admininstr*
[niteration 5-reduction.watsup:58.3-58.47] ({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:58.3-58.16] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:58.3-58.16] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:58.4-58.15] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:58.4-58.15] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:58.4-58.15] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:58.10-58.13] I32  :  numtype
[elab 5-reduction.watsup:58.10-58.13] I32  :  numtype
[notation 5-reduction.watsup:58.10-58.13] {}  :  {}
[notation 5-reduction.watsup:58.4-58.15] {c}  :  {c_numtype}
[notation 5-reduction.watsup:58.14-58.15] c  :  c_numtype
[elab 5-reduction.watsup:58.14-58.15] c  :  c_numtype
[notation 5-reduction.watsup:58.4-58.15] {}  :  {}
[niteration 5-reduction.watsup:58.3-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:58.17-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:58.17-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr
[notation 5-reduction.watsup:58.18-58.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[elab 5-reduction.watsup:58.18-58.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[notation 5-reduction.watsup:58.18-58.46] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation 5-reduction.watsup:58.21-58.23] bt  :  blocktype
[elab 5-reduction.watsup:58.21-58.23] bt  :  blocktype
[notation 5-reduction.watsup:58.18-58.46] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation 5-reduction.watsup:58.24-58.32] instr_1*  :  instr*
[notation 5-reduction.watsup:58.24-58.31] instr_1  :  instr
[elab 5-reduction.watsup:58.24-58.31] instr_1  :  instr
[notation 5-reduction.watsup:58.18-58.46] {ELSE instr_2*}  :  {ELSE instr*}
[notation 5-reduction.watsup:58.33-58.37] ELSE  :  ELSE
[notation 5-reduction.watsup:58.18-58.46] {instr_2*}  :  {instr*}
[notation 5-reduction.watsup:58.18-58.46] {instr_2*}  :  instr*
[elab 5-reduction.watsup:58.38-58.46] instr_2*  :  instr*
[elab 5-reduction.watsup:58.38-58.45] instr_2  :  instr
[niteration 5-reduction.watsup:58.3-58.47]   :  admininstr*
[notation 5-reduction.watsup:58.53-58.72] ({BLOCK bt instr_1*})  :  admininstr*
[notation 5-reduction.watsup:58.54-58.71] {BLOCK bt instr_1*}  :  admininstr
[elab 5-reduction.watsup:58.54-58.71] {BLOCK bt instr_1*}  :  admininstr
[notation 5-reduction.watsup:58.54-58.71] {bt instr_1*}  :  {blocktype instr*}
[notation 5-reduction.watsup:58.60-58.62] bt  :  blocktype
[elab 5-reduction.watsup:58.60-58.62] bt  :  blocktype
[notation 5-reduction.watsup:58.54-58.71] {instr_1*}  :  {instr*}
[notation 5-reduction.watsup:58.54-58.71] {instr_1*}  :  instr*
[elab 5-reduction.watsup:58.63-58.71] instr_1*  :  instr*
[elab 5-reduction.watsup:58.63-58.70] instr_1  :  instr
[elab 5-reduction.watsup:59.9-59.16] c =/= 0  :  bool
[elab 5-reduction.watsup:59.9-59.10] c  :  c_numtype
[elab 5-reduction.watsup:59.15-59.16] 0  :  c_numtype
[notation 5-reduction.watsup:62.3-62.72] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_2*})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:62.3-62.47] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})}  :  admininstr*
[niteration 5-reduction.watsup:62.3-62.47] ({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:62.3-62.16] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:62.3-62.16] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:62.4-62.15] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:62.4-62.15] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:62.4-62.15] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:62.10-62.13] I32  :  numtype
[elab 5-reduction.watsup:62.10-62.13] I32  :  numtype
[notation 5-reduction.watsup:62.10-62.13] {}  :  {}
[notation 5-reduction.watsup:62.4-62.15] {c}  :  {c_numtype}
[notation 5-reduction.watsup:62.14-62.15] c  :  c_numtype
[elab 5-reduction.watsup:62.14-62.15] c  :  c_numtype
[notation 5-reduction.watsup:62.4-62.15] {}  :  {}
[niteration 5-reduction.watsup:62.3-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:62.17-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation 5-reduction.watsup:62.17-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr
[notation 5-reduction.watsup:62.18-62.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[elab 5-reduction.watsup:62.18-62.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[notation 5-reduction.watsup:62.18-62.46] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation 5-reduction.watsup:62.21-62.23] bt  :  blocktype
[elab 5-reduction.watsup:62.21-62.23] bt  :  blocktype
[notation 5-reduction.watsup:62.18-62.46] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation 5-reduction.watsup:62.24-62.32] instr_1*  :  instr*
[notation 5-reduction.watsup:62.24-62.31] instr_1  :  instr
[elab 5-reduction.watsup:62.24-62.31] instr_1  :  instr
[notation 5-reduction.watsup:62.18-62.46] {ELSE instr_2*}  :  {ELSE instr*}
[notation 5-reduction.watsup:62.33-62.37] ELSE  :  ELSE
[notation 5-reduction.watsup:62.18-62.46] {instr_2*}  :  {instr*}
[notation 5-reduction.watsup:62.18-62.46] {instr_2*}  :  instr*
[elab 5-reduction.watsup:62.38-62.46] instr_2*  :  instr*
[elab 5-reduction.watsup:62.38-62.45] instr_2  :  instr
[niteration 5-reduction.watsup:62.3-62.47]   :  admininstr*
[notation 5-reduction.watsup:62.53-62.72] ({BLOCK bt instr_2*})  :  admininstr*
[notation 5-reduction.watsup:62.54-62.71] {BLOCK bt instr_2*}  :  admininstr
[elab 5-reduction.watsup:62.54-62.71] {BLOCK bt instr_2*}  :  admininstr
[notation 5-reduction.watsup:62.54-62.71] {bt instr_2*}  :  {blocktype instr*}
[notation 5-reduction.watsup:62.60-62.62] bt  :  blocktype
[elab 5-reduction.watsup:62.60-62.62] bt  :  blocktype
[notation 5-reduction.watsup:62.54-62.71] {instr_2*}  :  {instr*}
[notation 5-reduction.watsup:62.54-62.71] {instr_2*}  :  instr*
[elab 5-reduction.watsup:62.63-62.71] instr_2*  :  instr*
[elab 5-reduction.watsup:62.63-62.70] instr_2  :  instr
[elab 5-reduction.watsup:63.9-63.14] c = 0  :  bool
[elab 5-reduction.watsup:63.9-63.10] c  :  c_numtype
[elab 5-reduction.watsup:63.13-63.14] 0  :  c_numtype
[notation 5-reduction.watsup:67.3-67.69] ({LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}) ~> {val^n instr'*}  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:67.3-67.50] ({LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*})  :  admininstr*
[notation 5-reduction.watsup:67.4-67.49] {LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}  :  admininstr
[elab 5-reduction.watsup:67.4-67.49] {LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}  :  admininstr
[notation 5-reduction.watsup:67.4-67.49] {n `{instr'*} val'* val^n ({BR 0}) instr*}  :  {n `{instr*} admininstr*}
[notation 5-reduction.watsup:67.11-67.12] n  :  n
[elab 5-reduction.watsup:67.11-67.12] n  :  n
[notation 5-reduction.watsup:67.4-67.49] {`{instr'*} val'* val^n ({BR 0}) instr*}  :  {`{instr*} admininstr*}
[notation 5-reduction.watsup:67.13-67.23] `{instr'*}  :  `{instr*}
[notation 5-reduction.watsup:67.15-67.22] instr'*  :  instr*
[notation 5-reduction.watsup:67.15-67.21] instr'  :  instr
[elab 5-reduction.watsup:67.15-67.21] instr'  :  instr
[notation 5-reduction.watsup:67.4-67.49] {val'* val^n ({BR 0}) instr*}  :  {admininstr*}
[notation 5-reduction.watsup:67.4-67.49] {val'* val^n ({BR 0}) instr*}  :  admininstr*
[niteration 5-reduction.watsup:67.4-67.49] val'* val^n ({BR 0}) instr*  :  admininstr*
[notation 5-reduction.watsup:67.24-67.29] val'*  :  admininstr*
[notation 5-reduction.watsup:67.24-67.28] val'  :  admininstr
[elab 5-reduction.watsup:67.24-67.28] val'  :  admininstr
[niteration 5-reduction.watsup:67.4-67.49] val^n ({BR 0}) instr*  :  admininstr*
[notation 5-reduction.watsup:67.30-67.35] val^n  :  admininstr*
[notation 5-reduction.watsup:67.30-67.33] val  :  admininstr
[elab 5-reduction.watsup:67.30-67.33] val  :  admininstr
[elab 5-reduction.watsup:67.34-67.35] n  :  nat
[niteration 5-reduction.watsup:67.4-67.49] ({BR 0}) instr*  :  admininstr*
[notation 5-reduction.watsup:67.36-67.42] ({BR 0})  :  admininstr*
[notation 5-reduction.watsup:67.36-67.42] ({BR 0})  :  admininstr
[notation 5-reduction.watsup:67.37-67.41] {BR 0}  :  admininstr
[elab 5-reduction.watsup:67.37-67.41] {BR 0}  :  admininstr
[notation 5-reduction.watsup:67.37-67.41] {0}  :  {labelidx}
[notation 5-reduction.watsup:67.40-67.41] 0  :  labelidx
[elab 5-reduction.watsup:67.40-67.41] 0  :  labelidx
[notation 5-reduction.watsup:67.37-67.41] {}  :  {}
[niteration 5-reduction.watsup:67.4-67.49] instr*  :  admininstr*
[notation 5-reduction.watsup:67.43-67.49] instr*  :  admininstr*
[notation 5-reduction.watsup:67.43-67.48] instr  :  admininstr
[elab 5-reduction.watsup:67.43-67.48] instr  :  admininstr
[niteration 5-reduction.watsup:67.4-67.49]   :  admininstr*
[notation 5-reduction.watsup:67.56-67.69] {val^n instr'*}  :  admininstr*
[niteration 5-reduction.watsup:67.56-67.69] val^n instr'*  :  admininstr*
[notation 5-reduction.watsup:67.56-67.61] val^n  :  admininstr*
[notation 5-reduction.watsup:67.56-67.59] val  :  admininstr
[elab 5-reduction.watsup:67.56-67.59] val  :  admininstr
[elab 5-reduction.watsup:67.60-67.61] n  :  nat
[niteration 5-reduction.watsup:67.56-67.69] instr'*  :  admininstr*
[notation 5-reduction.watsup:67.62-67.69] instr'*  :  admininstr*
[notation 5-reduction.watsup:67.62-67.68] instr'  :  admininstr
[elab 5-reduction.watsup:67.62-67.68] instr'  :  admininstr
[niteration 5-reduction.watsup:67.56-67.69]   :  admininstr*
[elab 5-reduction.watsup:67.60-67.61] n  :  nat
[notation 5-reduction.watsup:70.3-70.65] ({LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}) ~> {val* ({BR l})}  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:70.3-70.48] ({LABEL_ n `{instr'*} val* ({BR l + 1}) instr*})  :  admininstr*
[notation 5-reduction.watsup:70.4-70.47] {LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}  :  admininstr
[elab 5-reduction.watsup:70.4-70.47] {LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}  :  admininstr
[notation 5-reduction.watsup:70.4-70.47] {n `{instr'*} val* ({BR l + 1}) instr*}  :  {n `{instr*} admininstr*}
[notation 5-reduction.watsup:70.11-70.12] n  :  n
[elab 5-reduction.watsup:70.11-70.12] n  :  n
[notation 5-reduction.watsup:70.4-70.47] {`{instr'*} val* ({BR l + 1}) instr*}  :  {`{instr*} admininstr*}
[notation 5-reduction.watsup:70.13-70.23] `{instr'*}  :  `{instr*}
[notation 5-reduction.watsup:70.15-70.22] instr'*  :  instr*
[notation 5-reduction.watsup:70.15-70.21] instr'  :  instr
[elab 5-reduction.watsup:70.15-70.21] instr'  :  instr
[notation 5-reduction.watsup:70.4-70.47] {val* ({BR l + 1}) instr*}  :  {admininstr*}
[notation 5-reduction.watsup:70.4-70.47] {val* ({BR l + 1}) instr*}  :  admininstr*
[niteration 5-reduction.watsup:70.4-70.47] val* ({BR l + 1}) instr*  :  admininstr*
[notation 5-reduction.watsup:70.24-70.28] val*  :  admininstr*
[notation 5-reduction.watsup:70.24-70.27] val  :  admininstr
[elab 5-reduction.watsup:70.24-70.27] val  :  admininstr
[niteration 5-reduction.watsup:70.4-70.47] ({BR l + 1}) instr*  :  admininstr*
[notation 5-reduction.watsup:70.29-70.40] ({BR l + 1})  :  admininstr*
[notation 5-reduction.watsup:70.29-70.40] ({BR l + 1})  :  admininstr
[notation 5-reduction.watsup:70.30-70.39] {BR l + 1}  :  admininstr
[elab 5-reduction.watsup:70.30-70.39] {BR l + 1}  :  admininstr
[notation 5-reduction.watsup:70.30-70.39] {l + 1}  :  {labelidx}
[notation 5-reduction.watsup:70.33-70.39] l + 1  :  labelidx
[elab 5-reduction.watsup:70.33-70.39] l + 1  :  labelidx
[elab 5-reduction.watsup:70.35-70.36] l  :  nat
[elab 5-reduction.watsup:70.37-70.38] 1  :  nat
[notation 5-reduction.watsup:70.30-70.39] {}  :  {}
[niteration 5-reduction.watsup:70.4-70.47] instr*  :  admininstr*
[notation 5-reduction.watsup:70.41-70.47] instr*  :  admininstr*
[notation 5-reduction.watsup:70.41-70.46] instr  :  admininstr
[elab 5-reduction.watsup:70.41-70.46] instr  :  admininstr
[niteration 5-reduction.watsup:70.4-70.47]   :  admininstr*
[notation 5-reduction.watsup:70.54-70.65] {val* ({BR l})}  :  admininstr*
[niteration 5-reduction.watsup:70.54-70.65] val* ({BR l})  :  admininstr*
[notation 5-reduction.watsup:70.54-70.58] val*  :  admininstr*
[notation 5-reduction.watsup:70.54-70.57] val  :  admininstr
[elab 5-reduction.watsup:70.54-70.57] val  :  admininstr
[niteration 5-reduction.watsup:70.54-70.65] ({BR l})  :  admininstr*
[notation 5-reduction.watsup:70.59-70.65] ({BR l})  :  admininstr*
[notation 5-reduction.watsup:70.59-70.65] ({BR l})  :  admininstr
[notation 5-reduction.watsup:70.60-70.64] {BR l}  :  admininstr
[elab 5-reduction.watsup:70.60-70.64] {BR l}  :  admininstr
[notation 5-reduction.watsup:70.60-70.64] {l}  :  {labelidx}
[notation 5-reduction.watsup:70.63-70.64] l  :  labelidx
[elab 5-reduction.watsup:70.63-70.64] l  :  labelidx
[notation 5-reduction.watsup:70.60-70.64] {}  :  {}
[niteration 5-reduction.watsup:70.54-70.65]   :  admininstr*
[notation 5-reduction.watsup:74.3-74.38] {({CONST I32 c}) ({BR_IF l})} ~> ({BR l})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:74.3-74.26] {({CONST I32 c}) ({BR_IF l})}  :  admininstr*
[niteration 5-reduction.watsup:74.3-74.26] ({CONST I32 c}) ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:74.3-74.16] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:74.3-74.16] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:74.4-74.15] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:74.4-74.15] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:74.4-74.15] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:74.10-74.13] I32  :  numtype
[elab 5-reduction.watsup:74.10-74.13] I32  :  numtype
[notation 5-reduction.watsup:74.10-74.13] {}  :  {}
[notation 5-reduction.watsup:74.4-74.15] {c}  :  {c_numtype}
[notation 5-reduction.watsup:74.14-74.15] c  :  c_numtype
[elab 5-reduction.watsup:74.14-74.15] c  :  c_numtype
[notation 5-reduction.watsup:74.4-74.15] {}  :  {}
[niteration 5-reduction.watsup:74.3-74.26] ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:74.17-74.26] ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:74.17-74.26] ({BR_IF l})  :  admininstr
[notation 5-reduction.watsup:74.18-74.25] {BR_IF l}  :  admininstr
[elab 5-reduction.watsup:74.18-74.25] {BR_IF l}  :  admininstr
[notation 5-reduction.watsup:74.18-74.25] {l}  :  {labelidx}
[notation 5-reduction.watsup:74.24-74.25] l  :  labelidx
[elab 5-reduction.watsup:74.24-74.25] l  :  labelidx
[notation 5-reduction.watsup:74.18-74.25] {}  :  {}
[niteration 5-reduction.watsup:74.3-74.26]   :  admininstr*
[notation 5-reduction.watsup:74.32-74.38] ({BR l})  :  admininstr*
[notation 5-reduction.watsup:74.33-74.37] {BR l}  :  admininstr
[elab 5-reduction.watsup:74.33-74.37] {BR l}  :  admininstr
[notation 5-reduction.watsup:74.33-74.37] {l}  :  {labelidx}
[notation 5-reduction.watsup:74.36-74.37] l  :  labelidx
[elab 5-reduction.watsup:74.36-74.37] l  :  labelidx
[notation 5-reduction.watsup:74.33-74.37] {}  :  {}
[elab 5-reduction.watsup:75.9-75.16] c =/= 0  :  bool
[elab 5-reduction.watsup:75.9-75.10] c  :  c_numtype
[elab 5-reduction.watsup:75.15-75.16] 0  :  c_numtype
[notation 5-reduction.watsup:78.3-78.39] {({CONST I32 c}) ({BR_IF l})} ~> epsilon  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:78.3-78.26] {({CONST I32 c}) ({BR_IF l})}  :  admininstr*
[niteration 5-reduction.watsup:78.3-78.26] ({CONST I32 c}) ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:78.3-78.16] ({CONST I32 c})  :  admininstr*
[notation 5-reduction.watsup:78.3-78.16] ({CONST I32 c})  :  admininstr
[notation 5-reduction.watsup:78.4-78.15] {CONST I32 c}  :  admininstr
[elab 5-reduction.watsup:78.4-78.15] {CONST I32 c}  :  admininstr
[notation 5-reduction.watsup:78.4-78.15] {I32 c}  :  {numtype c_numtype}
[notation 5-reduction.watsup:78.10-78.13] I32  :  numtype
[elab 5-reduction.watsup:78.10-78.13] I32  :  numtype
[notation 5-reduction.watsup:78.10-78.13] {}  :  {}
[notation 5-reduction.watsup:78.4-78.15] {c}  :  {c_numtype}
[notation 5-reduction.watsup:78.14-78.15] c  :  c_numtype
[elab 5-reduction.watsup:78.14-78.15] c  :  c_numtype
[notation 5-reduction.watsup:78.4-78.15] {}  :  {}
[niteration 5-reduction.watsup:78.3-78.26] ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:78.17-78.26] ({BR_IF l})  :  admininstr*
[notation 5-reduction.watsup:78.17-78.26] ({BR_IF l})  :  admininstr
[notation 5-reduction.watsup:78.18-78.25] {BR_IF l}  :  admininstr
[elab 5-reduction.watsup:78.18-78.25] {BR_IF l}  :  admininstr
[notation 5-reduction.watsup:78.18-78.25] {l}  :  {labelidx}
[notation 5-reduction.watsup:78.24-78.25] l  :  labelidx
[elab 5-reduction.watsup:78.24-78.25] l  :  labelidx
[notation 5-reduction.watsup:78.18-78.25] {}  :  {}
[niteration 5-reduction.watsup:78.3-78.26]   :  admininstr*
[notation 5-reduction.watsup:78.32-78.39] epsilon  :  admininstr*
[niteration 5-reduction.watsup:78.32-78.39]   :  admininstr*
[elab 5-reduction.watsup:79.9-79.14] c = 0  :  bool
[elab 5-reduction.watsup:79.9-79.10] c  :  c_numtype
[elab 5-reduction.watsup:79.13-79.14] 0  :  c_numtype
[notation 5-reduction.watsup:83.3-83.49] {({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l*[i]})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:83.3-83.33] {({CONST I32 i}) ({BR_TABLE l* l'})}  :  admininstr*
[niteration 5-reduction.watsup:83.3-83.33] ({CONST I32 i}) ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:83.3-83.16] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:83.3-83.16] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:83.4-83.15] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:83.4-83.15] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:83.4-83.15] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:83.10-83.13] I32  :  numtype
[elab 5-reduction.watsup:83.10-83.13] I32  :  numtype
[notation 5-reduction.watsup:83.10-83.13] {}  :  {}
[notation 5-reduction.watsup:83.4-83.15] {i}  :  {c_numtype}
[notation 5-reduction.watsup:83.14-83.15] i  :  c_numtype
[elab 5-reduction.watsup:83.14-83.15] i  :  c_numtype
[notation 5-reduction.watsup:83.4-83.15] {}  :  {}
[niteration 5-reduction.watsup:83.3-83.33] ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:83.17-83.33] ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:83.17-83.33] ({BR_TABLE l* l'})  :  admininstr
[notation 5-reduction.watsup:83.18-83.32] {BR_TABLE l* l'}  :  admininstr
[elab 5-reduction.watsup:83.18-83.32] {BR_TABLE l* l'}  :  admininstr
[notation 5-reduction.watsup:83.18-83.32] {l* l'}  :  {labelidx* labelidx}
[notation 5-reduction.watsup:83.27-83.29] l*  :  labelidx*
[notation 5-reduction.watsup:83.27-83.28] l  :  labelidx
[elab 5-reduction.watsup:83.27-83.28] l  :  labelidx
[notation 5-reduction.watsup:83.18-83.32] {l'}  :  {labelidx}
[notation 5-reduction.watsup:83.30-83.32] l'  :  labelidx
[elab 5-reduction.watsup:83.30-83.32] l'  :  labelidx
[notation 5-reduction.watsup:83.18-83.32] {}  :  {}
[niteration 5-reduction.watsup:83.3-83.33]   :  admininstr*
[notation 5-reduction.watsup:83.39-83.49] ({BR l*[i]})  :  admininstr*
[notation 5-reduction.watsup:83.40-83.48] {BR l*[i]}  :  admininstr
[elab 5-reduction.watsup:83.40-83.48] {BR l*[i]}  :  admininstr
[notation 5-reduction.watsup:83.40-83.48] {l*[i]}  :  {labelidx}
[notation 5-reduction.watsup:83.43-83.48] l*[i]  :  labelidx
[elab 5-reduction.watsup:83.43-83.48] l*[i]  :  labelidx
[elab 5-reduction.watsup:83.43-83.45] l*  :  labelidx*
[elab 5-reduction.watsup:83.43-83.44] l  :  labelidx
[elab 5-reduction.watsup:83.46-83.47] i  :  nat
[notation 5-reduction.watsup:83.40-83.48] {}  :  {}
[elab 5-reduction.watsup:84.9-84.17] i < |l*|  :  bool
[elab 5-reduction.watsup:84.9-84.10] i  :  nat
[elab 5-reduction.watsup:84.13-84.17] |l*|  :  nat
[elab 5-reduction.watsup:84.14-84.16] l*  :  labelidx*
[elab 5-reduction.watsup:84.14-84.15] l  :  labelidx
[notation 5-reduction.watsup:87.3-87.46] {({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l'})  :  admininstr* ~> admininstr*
[notation 5-reduction.watsup:87.3-87.33] {({CONST I32 i}) ({BR_TABLE l* l'})}  :  admininstr*
[niteration 5-reduction.watsup:87.3-87.33] ({CONST I32 i}) ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:87.3-87.16] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:87.3-87.16] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:87.4-87.15] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:87.4-87.15] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:87.4-87.15] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:87.10-87.13] I32  :  numtype
[elab 5-reduction.watsup:87.10-87.13] I32  :  numtype
[notation 5-reduction.watsup:87.10-87.13] {}  :  {}
[notation 5-reduction.watsup:87.4-87.15] {i}  :  {c_numtype}
[notation 5-reduction.watsup:87.14-87.15] i  :  c_numtype
[elab 5-reduction.watsup:87.14-87.15] i  :  c_numtype
[notation 5-reduction.watsup:87.4-87.15] {}  :  {}
[niteration 5-reduction.watsup:87.3-87.33] ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:87.17-87.33] ({BR_TABLE l* l'})  :  admininstr*
[notation 5-reduction.watsup:87.17-87.33] ({BR_TABLE l* l'})  :  admininstr
[notation 5-reduction.watsup:87.18-87.32] {BR_TABLE l* l'}  :  admininstr
[elab 5-reduction.watsup:87.18-87.32] {BR_TABLE l* l'}  :  admininstr
[notation 5-reduction.watsup:87.18-87.32] {l* l'}  :  {labelidx* labelidx}
[notation 5-reduction.watsup:87.27-87.29] l*  :  labelidx*
[notation 5-reduction.watsup:87.27-87.28] l  :  labelidx
[elab 5-reduction.watsup:87.27-87.28] l  :  labelidx
[notation 5-reduction.watsup:87.18-87.32] {l'}  :  {labelidx}
[notation 5-reduction.watsup:87.30-87.32] l'  :  labelidx
[elab 5-reduction.watsup:87.30-87.32] l'  :  labelidx
[notation 5-reduction.watsup:87.18-87.32] {}  :  {}
[niteration 5-reduction.watsup:87.3-87.33]   :  admininstr*
[notation 5-reduction.watsup:87.39-87.46] ({BR l'})  :  admininstr*
[notation 5-reduction.watsup:87.40-87.45] {BR l'}  :  admininstr
[elab 5-reduction.watsup:87.40-87.45] {BR l'}  :  admininstr
[notation 5-reduction.watsup:87.40-87.45] {l'}  :  {labelidx}
[notation 5-reduction.watsup:87.43-87.45] l'  :  labelidx
[elab 5-reduction.watsup:87.43-87.45] l'  :  labelidx
[notation 5-reduction.watsup:87.40-87.45] {}  :  {}
[elab 5-reduction.watsup:88.9-88.18] i >= |l*|  :  bool
[elab 5-reduction.watsup:88.9-88.10] i  :  nat
[elab 5-reduction.watsup:88.14-88.18] |l*|  :  nat
[elab 5-reduction.watsup:88.15-88.17] l*  :  labelidx*
[elab 5-reduction.watsup:88.15-88.16] l  :  labelidx
[notation 5-reduction.watsup:91.3-91.53] z ; ({REF.FUNC x}) ~> ({REF.FUNC_ADDR $funcaddr(z)[x]})  :  config ~> admininstr*
[notation 5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  config
[elab 5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  config
[notation 5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  state ; admininstr*
[notation 5-reduction.watsup:91.3-91.4] z  :  state
[elab 5-reduction.watsup:91.3-91.4] z  :  state
[notation 5-reduction.watsup:91.6-91.18] ({REF.FUNC x})  :  admininstr*
[notation 5-reduction.watsup:91.7-91.17] {REF.FUNC x}  :  admininstr
[elab 5-reduction.watsup:91.7-91.17] {REF.FUNC x}  :  admininstr
[notation 5-reduction.watsup:91.7-91.17] {x}  :  {funcidx}
[notation 5-reduction.watsup:91.16-91.17] x  :  funcidx
[elab 5-reduction.watsup:91.16-91.17] x  :  funcidx
[notation 5-reduction.watsup:91.7-91.17] {}  :  {}
[notation 5-reduction.watsup:91.22-91.53] ({REF.FUNC_ADDR $funcaddr(z)[x]})  :  admininstr*
[notation 5-reduction.watsup:91.23-91.52] {REF.FUNC_ADDR $funcaddr(z)[x]}  :  admininstr
[elab 5-reduction.watsup:91.23-91.52] {REF.FUNC_ADDR $funcaddr(z)[x]}  :  admininstr
[notation 5-reduction.watsup:91.23-91.52] {$funcaddr(z)[x]}  :  {funcaddr}
[notation 5-reduction.watsup:91.37-91.52] $funcaddr(z)[x]  :  funcaddr
[elab 5-reduction.watsup:91.37-91.52] $funcaddr(z)[x]  :  funcaddr
[elab 5-reduction.watsup:91.37-91.49] $funcaddr(z)  :  funcaddr*
[elab 5-reduction.watsup:91.46-91.49] (z)  :  (state)
[elab 5-reduction.watsup:91.47-91.48] z  :  (state)
[elab 5-reduction.watsup:91.50-91.51] x  :  nat
[notation 5-reduction.watsup:91.23-91.52] {}  :  {}
[notation 5-reduction.watsup:94.3-94.35] z ; ({LOCAL.GET x}) ~> $local(z, x)  :  config ~> admininstr*
[notation 5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  config
[elab 5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  config
[notation 5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  state ; admininstr*
[notation 5-reduction.watsup:94.3-94.4] z  :  state
[elab 5-reduction.watsup:94.3-94.4] z  :  state
[notation 5-reduction.watsup:94.6-94.19] ({LOCAL.GET x})  :  admininstr*
[notation 5-reduction.watsup:94.7-94.18] {LOCAL.GET x}  :  admininstr
[elab 5-reduction.watsup:94.7-94.18] {LOCAL.GET x}  :  admininstr
[notation 5-reduction.watsup:94.7-94.18] {x}  :  {localidx}
[notation 5-reduction.watsup:94.17-94.18] x  :  localidx
[elab 5-reduction.watsup:94.17-94.18] x  :  localidx
[notation 5-reduction.watsup:94.7-94.18] {}  :  {}
[notation 5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr*
[notation 5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr
[elab 5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr
[elab 5-reduction.watsup:94.29-94.35] (z, x)  :  (state, localidx)
[elab 5-reduction.watsup:94.30-94.31] z  :  state
[elab 5-reduction.watsup:94.33-94.34] x  :  localidx
[notation 5-reduction.watsup:97.3-97.37] z ; ({GLOBAL.GET x}) ~> $global(z, x)  :  config ~> admininstr*
[notation 5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  config
[elab 5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  config
[notation 5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  state ; admininstr*
[notation 5-reduction.watsup:97.3-97.4] z  :  state
[elab 5-reduction.watsup:97.3-97.4] z  :  state
[notation 5-reduction.watsup:97.6-97.20] ({GLOBAL.GET x})  :  admininstr*
[notation 5-reduction.watsup:97.7-97.19] {GLOBAL.GET x}  :  admininstr
[elab 5-reduction.watsup:97.7-97.19] {GLOBAL.GET x}  :  admininstr
[notation 5-reduction.watsup:97.7-97.19] {x}  :  {globalidx}
[notation 5-reduction.watsup:97.18-97.19] x  :  globalidx
[elab 5-reduction.watsup:97.18-97.19] x  :  globalidx
[notation 5-reduction.watsup:97.7-97.19] {}  :  {}
[notation 5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr*
[notation 5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr
[elab 5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr
[elab 5-reduction.watsup:97.31-97.37] (z, x)  :  (state, globalidx)
[elab 5-reduction.watsup:97.32-97.33] z  :  state
[elab 5-reduction.watsup:97.35-97.36] x  :  globalidx
[notation 5-reduction.watsup:100.3-100.41] z ; {({CONST I32 i}) ({TABLE.GET x})} ~> TRAP  :  config ~> admininstr*
[notation 5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[elab 5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[notation 5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:100.3-100.4] z  :  state
[elab 5-reduction.watsup:100.3-100.4] z  :  state
[notation 5-reduction.watsup:100.6-100.33] {({CONST I32 i}) ({TABLE.GET x})}  :  admininstr*
[niteration 5-reduction.watsup:100.6-100.33] ({CONST I32 i}) ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:100.6-100.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:100.6-100.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:100.7-100.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:100.7-100.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:100.7-100.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:100.13-100.16] I32  :  numtype
[elab 5-reduction.watsup:100.13-100.16] I32  :  numtype
[notation 5-reduction.watsup:100.13-100.16] {}  :  {}
[notation 5-reduction.watsup:100.7-100.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:100.17-100.18] i  :  c_numtype
[elab 5-reduction.watsup:100.17-100.18] i  :  c_numtype
[notation 5-reduction.watsup:100.7-100.18] {}  :  {}
[niteration 5-reduction.watsup:100.6-100.33] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:100.20-100.33] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:100.20-100.33] ({TABLE.GET x})  :  admininstr
[notation 5-reduction.watsup:100.21-100.32] {TABLE.GET x}  :  admininstr
[elab 5-reduction.watsup:100.21-100.32] {TABLE.GET x}  :  admininstr
[notation 5-reduction.watsup:100.21-100.32] {x}  :  {tableidx}
[notation 5-reduction.watsup:100.31-100.32] x  :  tableidx
[elab 5-reduction.watsup:100.31-100.32] x  :  tableidx
[notation 5-reduction.watsup:100.21-100.32] {}  :  {}
[niteration 5-reduction.watsup:100.6-100.33]   :  admininstr*
[notation 5-reduction.watsup:100.37-100.41] TRAP  :  admininstr*
[notation 5-reduction.watsup:100.37-100.41] TRAP  :  admininstr
[elab 5-reduction.watsup:100.37-100.41] TRAP  :  admininstr
[notation 5-reduction.watsup:100.37-100.41] {}  :  {}
[elab 5-reduction.watsup:101.9-101.28] i >= |$table(z, x)|  :  bool
[elab 5-reduction.watsup:101.9-101.10] i  :  nat
[elab 5-reduction.watsup:101.14-101.28] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:101.15-101.27] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:101.21-101.27] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:101.22-101.23] z  :  state
[elab 5-reduction.watsup:101.25-101.26] x  :  tableidx
[notation 5-reduction.watsup:104.3-104.51] z ; {({CONST I32 i}) ({TABLE.GET x})} ~> $table(z, x)[i]  :  config ~> admininstr*
[notation 5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[elab 5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[notation 5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:104.3-104.4] z  :  state
[elab 5-reduction.watsup:104.3-104.4] z  :  state
[notation 5-reduction.watsup:104.6-104.33] {({CONST I32 i}) ({TABLE.GET x})}  :  admininstr*
[niteration 5-reduction.watsup:104.6-104.33] ({CONST I32 i}) ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:104.6-104.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:104.6-104.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:104.7-104.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:104.7-104.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:104.7-104.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:104.13-104.16] I32  :  numtype
[elab 5-reduction.watsup:104.13-104.16] I32  :  numtype
[notation 5-reduction.watsup:104.13-104.16] {}  :  {}
[notation 5-reduction.watsup:104.7-104.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:104.17-104.18] i  :  c_numtype
[elab 5-reduction.watsup:104.17-104.18] i  :  c_numtype
[notation 5-reduction.watsup:104.7-104.18] {}  :  {}
[niteration 5-reduction.watsup:104.6-104.33] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:104.20-104.33] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:104.20-104.33] ({TABLE.GET x})  :  admininstr
[notation 5-reduction.watsup:104.21-104.32] {TABLE.GET x}  :  admininstr
[elab 5-reduction.watsup:104.21-104.32] {TABLE.GET x}  :  admininstr
[notation 5-reduction.watsup:104.21-104.32] {x}  :  {tableidx}
[notation 5-reduction.watsup:104.31-104.32] x  :  tableidx
[elab 5-reduction.watsup:104.31-104.32] x  :  tableidx
[notation 5-reduction.watsup:104.21-104.32] {}  :  {}
[niteration 5-reduction.watsup:104.6-104.33]   :  admininstr*
[notation 5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr*
[notation 5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr
[elab 5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr
[elab 5-reduction.watsup:104.37-104.48] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:104.43-104.48] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:104.44-104.45] z  :  state
[elab 5-reduction.watsup:104.46-104.47] x  :  tableidx
[elab 5-reduction.watsup:104.49-104.50] i  :  nat
[elab 5-reduction.watsup:105.9-105.27] i < |$table(z, x)|  :  bool
[elab 5-reduction.watsup:105.9-105.10] i  :  nat
[elab 5-reduction.watsup:105.13-105.27] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:105.14-105.26] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:105.20-105.26] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:105.21-105.22] z  :  state
[elab 5-reduction.watsup:105.24-105.25] x  :  tableidx
[notation 5-reduction.watsup:108.3-108.37] z ; ({TABLE.SIZE x}) ~> ({CONST I32 n})  :  config ~> admininstr*
[notation 5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  config
[elab 5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  config
[notation 5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  state ; admininstr*
[notation 5-reduction.watsup:108.3-108.4] z  :  state
[elab 5-reduction.watsup:108.3-108.4] z  :  state
[notation 5-reduction.watsup:108.6-108.20] ({TABLE.SIZE x})  :  admininstr*
[notation 5-reduction.watsup:108.7-108.19] {TABLE.SIZE x}  :  admininstr
[elab 5-reduction.watsup:108.7-108.19] {TABLE.SIZE x}  :  admininstr
[notation 5-reduction.watsup:108.7-108.19] {x}  :  {tableidx}
[notation 5-reduction.watsup:108.18-108.19] x  :  tableidx
[elab 5-reduction.watsup:108.18-108.19] x  :  tableidx
[notation 5-reduction.watsup:108.7-108.19] {}  :  {}
[notation 5-reduction.watsup:108.24-108.37] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:108.25-108.36] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:108.25-108.36] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:108.25-108.36] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:108.31-108.34] I32  :  numtype
[elab 5-reduction.watsup:108.31-108.34] I32  :  numtype
[notation 5-reduction.watsup:108.31-108.34] {}  :  {}
[notation 5-reduction.watsup:108.25-108.36] {n}  :  {c_numtype}
[notation 5-reduction.watsup:108.35-108.36] n  :  c_numtype
[elab 5-reduction.watsup:108.35-108.36] n  :  c_numtype
[notation 5-reduction.watsup:108.25-108.36] {}  :  {}
[elab 5-reduction.watsup:109.9-109.27] |$table(z, x)| = n  :  bool
[elab 5-reduction.watsup:109.9-109.23] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:109.10-109.22] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:109.16-109.22] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:109.17-109.18] z  :  state
[elab 5-reduction.watsup:109.20-109.21] x  :  tableidx
[elab 5-reduction.watsup:109.26-109.27] n  :  nat
[notation 5-reduction.watsup:112.3-112.60] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})} ~> TRAP  :  config ~> admininstr*
[notation 5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config
[elab 5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config
[notation 5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation 5-reduction.watsup:112.3-112.4] z  :  state
[elab 5-reduction.watsup:112.3-112.4] z  :  state
[notation 5-reduction.watsup:112.6-112.52] {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  admininstr*
[niteration 5-reduction.watsup:112.6-112.52] ({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:112.6-112.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:112.6-112.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:112.7-112.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:112.7-112.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:112.7-112.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:112.13-112.16] I32  :  numtype
[elab 5-reduction.watsup:112.13-112.16] I32  :  numtype
[notation 5-reduction.watsup:112.13-112.16] {}  :  {}
[notation 5-reduction.watsup:112.7-112.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:112.17-112.18] i  :  c_numtype
[elab 5-reduction.watsup:112.17-112.18] i  :  c_numtype
[notation 5-reduction.watsup:112.7-112.18] {}  :  {}
[niteration 5-reduction.watsup:112.6-112.52] val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:112.20-112.23] val  :  admininstr*
[notation 5-reduction.watsup:112.20-112.23] val  :  admininstr
[elab 5-reduction.watsup:112.20-112.23] val  :  admininstr
[niteration 5-reduction.watsup:112.6-112.52] ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:112.24-112.37] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:112.24-112.37] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:112.25-112.36] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:112.25-112.36] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:112.25-112.36] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:112.31-112.34] I32  :  numtype
[elab 5-reduction.watsup:112.31-112.34] I32  :  numtype
[notation 5-reduction.watsup:112.31-112.34] {}  :  {}
[notation 5-reduction.watsup:112.25-112.36] {n}  :  {c_numtype}
[notation 5-reduction.watsup:112.35-112.36] n  :  c_numtype
[elab 5-reduction.watsup:112.35-112.36] n  :  c_numtype
[notation 5-reduction.watsup:112.25-112.36] {}  :  {}
[niteration 5-reduction.watsup:112.6-112.52] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:112.38-112.52] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:112.38-112.52] ({TABLE.FILL x})  :  admininstr
[notation 5-reduction.watsup:112.39-112.51] {TABLE.FILL x}  :  admininstr
[elab 5-reduction.watsup:112.39-112.51] {TABLE.FILL x}  :  admininstr
[notation 5-reduction.watsup:112.39-112.51] {x}  :  {tableidx}
[notation 5-reduction.watsup:112.50-112.51] x  :  tableidx
[elab 5-reduction.watsup:112.50-112.51] x  :  tableidx
[notation 5-reduction.watsup:112.39-112.51] {}  :  {}
[niteration 5-reduction.watsup:112.6-112.52]   :  admininstr*
[notation 5-reduction.watsup:112.56-112.60] TRAP  :  admininstr*
[notation 5-reduction.watsup:112.56-112.60] TRAP  :  admininstr
[elab 5-reduction.watsup:112.56-112.60] TRAP  :  admininstr
[notation 5-reduction.watsup:112.56-112.60] {}  :  {}
[elab 5-reduction.watsup:113.9-113.34] i + n > |$table(z, x)|  :  bool
[elab 5-reduction.watsup:113.9-113.17] i + n  :  nat
[elab 5-reduction.watsup:113.11-113.12] i  :  nat
[elab 5-reduction.watsup:113.15-113.16] n  :  nat
[elab 5-reduction.watsup:113.20-113.34] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:113.21-113.33] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:113.27-113.33] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:113.28-113.29] z  :  state
[elab 5-reduction.watsup:113.31-113.32] x  :  tableidx
[notation 5-reduction.watsup:115.3-115.63] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})} ~> epsilon  :  config ~> admininstr*
[notation 5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  config
[elab 5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  config
[notation 5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation 5-reduction.watsup:115.3-115.4] z  :  state
[elab 5-reduction.watsup:115.3-115.4] z  :  state
[notation 5-reduction.watsup:115.6-115.52] {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  admininstr*
[niteration 5-reduction.watsup:115.6-115.52] ({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:115.6-115.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:115.6-115.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:115.7-115.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:115.7-115.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:115.7-115.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:115.13-115.16] I32  :  numtype
[elab 5-reduction.watsup:115.13-115.16] I32  :  numtype
[notation 5-reduction.watsup:115.13-115.16] {}  :  {}
[notation 5-reduction.watsup:115.7-115.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:115.17-115.18] i  :  c_numtype
[elab 5-reduction.watsup:115.17-115.18] i  :  c_numtype
[notation 5-reduction.watsup:115.7-115.18] {}  :  {}
[niteration 5-reduction.watsup:115.6-115.52] val ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:115.20-115.23] val  :  admininstr*
[notation 5-reduction.watsup:115.20-115.23] val  :  admininstr
[elab 5-reduction.watsup:115.20-115.23] val  :  admininstr
[niteration 5-reduction.watsup:115.6-115.52] ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:115.24-115.37] ({CONST I32 0})  :  admininstr*
[notation 5-reduction.watsup:115.24-115.37] ({CONST I32 0})  :  admininstr
[notation 5-reduction.watsup:115.25-115.36] {CONST I32 0}  :  admininstr
[elab 5-reduction.watsup:115.25-115.36] {CONST I32 0}  :  admininstr
[notation 5-reduction.watsup:115.25-115.36] {I32 0}  :  {numtype c_numtype}
[notation 5-reduction.watsup:115.31-115.34] I32  :  numtype
[elab 5-reduction.watsup:115.31-115.34] I32  :  numtype
[notation 5-reduction.watsup:115.31-115.34] {}  :  {}
[notation 5-reduction.watsup:115.25-115.36] {0}  :  {c_numtype}
[notation 5-reduction.watsup:115.35-115.36] 0  :  c_numtype
[elab 5-reduction.watsup:115.35-115.36] 0  :  c_numtype
[notation 5-reduction.watsup:115.25-115.36] {}  :  {}
[niteration 5-reduction.watsup:115.6-115.52] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:115.38-115.52] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:115.38-115.52] ({TABLE.FILL x})  :  admininstr
[notation 5-reduction.watsup:115.39-115.51] {TABLE.FILL x}  :  admininstr
[elab 5-reduction.watsup:115.39-115.51] {TABLE.FILL x}  :  admininstr
[notation 5-reduction.watsup:115.39-115.51] {x}  :  {tableidx}
[notation 5-reduction.watsup:115.50-115.51] x  :  tableidx
[elab 5-reduction.watsup:115.50-115.51] x  :  tableidx
[notation 5-reduction.watsup:115.39-115.51] {}  :  {}
[niteration 5-reduction.watsup:115.6-115.52]   :  admininstr*
[notation 5-reduction.watsup:115.56-115.63] epsilon  :  admininstr*
[niteration 5-reduction.watsup:115.56-115.63]   :  admininstr*
[notation 5-reduction.watsup:118.3-119.89] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})} ~> {({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config ~> admininstr*
[notation 5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  config
[elab 5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  config
[notation 5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation 5-reduction.watsup:118.3-118.4] z  :  state
[elab 5-reduction.watsup:118.3-118.4] z  :  state
[notation 5-reduction.watsup:118.6-118.57] {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  admininstr*
[niteration 5-reduction.watsup:118.6-118.57] ({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:118.6-118.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:118.6-118.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:118.7-118.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:118.7-118.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:118.7-118.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:118.13-118.16] I32  :  numtype
[elab 5-reduction.watsup:118.13-118.16] I32  :  numtype
[notation 5-reduction.watsup:118.13-118.16] {}  :  {}
[notation 5-reduction.watsup:118.7-118.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:118.17-118.18] i  :  c_numtype
[elab 5-reduction.watsup:118.17-118.18] i  :  c_numtype
[notation 5-reduction.watsup:118.7-118.18] {}  :  {}
[niteration 5-reduction.watsup:118.6-118.57] val ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:118.20-118.23] val  :  admininstr*
[notation 5-reduction.watsup:118.20-118.23] val  :  admininstr
[elab 5-reduction.watsup:118.20-118.23] val  :  admininstr
[niteration 5-reduction.watsup:118.6-118.57] ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:118.24-118.42] ({CONST I32 n + 1})  :  admininstr*
[notation 5-reduction.watsup:118.24-118.42] ({CONST I32 n + 1})  :  admininstr
[notation 5-reduction.watsup:118.25-118.41] {CONST I32 n + 1}  :  admininstr
[elab 5-reduction.watsup:118.25-118.41] {CONST I32 n + 1}  :  admininstr
[notation 5-reduction.watsup:118.25-118.41] {I32 n + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:118.31-118.34] I32  :  numtype
[elab 5-reduction.watsup:118.31-118.34] I32  :  numtype
[notation 5-reduction.watsup:118.31-118.34] {}  :  {}
[notation 5-reduction.watsup:118.25-118.41] {n + 1}  :  {c_numtype}
[notation 5-reduction.watsup:118.35-118.41] n + 1  :  c_numtype
[elab 5-reduction.watsup:118.35-118.41] n + 1  :  c_numtype
[elab 5-reduction.watsup:118.37-118.38] n  :  nat
[elab 5-reduction.watsup:118.39-118.40] 1  :  nat
[notation 5-reduction.watsup:118.25-118.41] {}  :  {}
[niteration 5-reduction.watsup:118.6-118.57] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:118.43-118.57] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:118.43-118.57] ({TABLE.FILL x})  :  admininstr
[notation 5-reduction.watsup:118.44-118.56] {TABLE.FILL x}  :  admininstr
[elab 5-reduction.watsup:118.44-118.56] {TABLE.FILL x}  :  admininstr
[notation 5-reduction.watsup:118.44-118.56] {x}  :  {tableidx}
[notation 5-reduction.watsup:118.55-118.56] x  :  tableidx
[elab 5-reduction.watsup:118.55-118.56] x  :  tableidx
[notation 5-reduction.watsup:118.44-118.56] {}  :  {}
[niteration 5-reduction.watsup:118.6-118.57]   :  admininstr*
[notation 5-reduction.watsup:119.6-119.89] {({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  admininstr*
[niteration 5-reduction.watsup:119.6-119.89] ({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.6-119.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:119.6-119.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:119.7-119.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:119.7-119.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:119.7-119.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:119.13-119.16] I32  :  numtype
[elab 5-reduction.watsup:119.13-119.16] I32  :  numtype
[notation 5-reduction.watsup:119.13-119.16] {}  :  {}
[notation 5-reduction.watsup:119.7-119.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:119.17-119.18] i  :  c_numtype
[elab 5-reduction.watsup:119.17-119.18] i  :  c_numtype
[notation 5-reduction.watsup:119.7-119.18] {}  :  {}
[niteration 5-reduction.watsup:119.6-119.89] val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.20-119.23] val  :  admininstr*
[notation 5-reduction.watsup:119.20-119.23] val  :  admininstr
[elab 5-reduction.watsup:119.20-119.23] val  :  admininstr
[niteration 5-reduction.watsup:119.6-119.89] ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.24-119.37] ({TABLE.SET x})  :  admininstr*
[notation 5-reduction.watsup:119.24-119.37] ({TABLE.SET x})  :  admininstr
[notation 5-reduction.watsup:119.25-119.36] {TABLE.SET x}  :  admininstr
[elab 5-reduction.watsup:119.25-119.36] {TABLE.SET x}  :  admininstr
[notation 5-reduction.watsup:119.25-119.36] {x}  :  {tableidx}
[notation 5-reduction.watsup:119.35-119.36] x  :  tableidx
[elab 5-reduction.watsup:119.35-119.36] x  :  tableidx
[notation 5-reduction.watsup:119.25-119.36] {}  :  {}
[niteration 5-reduction.watsup:119.6-119.89] ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.38-119.56] ({CONST I32 i + 1})  :  admininstr*
[notation 5-reduction.watsup:119.38-119.56] ({CONST I32 i + 1})  :  admininstr
[notation 5-reduction.watsup:119.39-119.55] {CONST I32 i + 1}  :  admininstr
[elab 5-reduction.watsup:119.39-119.55] {CONST I32 i + 1}  :  admininstr
[notation 5-reduction.watsup:119.39-119.55] {I32 i + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:119.45-119.48] I32  :  numtype
[elab 5-reduction.watsup:119.45-119.48] I32  :  numtype
[notation 5-reduction.watsup:119.45-119.48] {}  :  {}
[notation 5-reduction.watsup:119.39-119.55] {i + 1}  :  {c_numtype}
[notation 5-reduction.watsup:119.49-119.55] i + 1  :  c_numtype
[elab 5-reduction.watsup:119.49-119.55] i + 1  :  c_numtype
[elab 5-reduction.watsup:119.51-119.52] i  :  nat
[elab 5-reduction.watsup:119.53-119.54] 1  :  nat
[notation 5-reduction.watsup:119.39-119.55] {}  :  {}
[niteration 5-reduction.watsup:119.6-119.89] val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.57-119.60] val  :  admininstr*
[notation 5-reduction.watsup:119.57-119.60] val  :  admininstr
[elab 5-reduction.watsup:119.57-119.60] val  :  admininstr
[niteration 5-reduction.watsup:119.6-119.89] ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.61-119.74] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:119.61-119.74] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:119.62-119.73] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:119.62-119.73] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:119.62-119.73] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:119.68-119.71] I32  :  numtype
[elab 5-reduction.watsup:119.68-119.71] I32  :  numtype
[notation 5-reduction.watsup:119.68-119.71] {}  :  {}
[notation 5-reduction.watsup:119.62-119.73] {n}  :  {c_numtype}
[notation 5-reduction.watsup:119.72-119.73] n  :  c_numtype
[elab 5-reduction.watsup:119.72-119.73] n  :  c_numtype
[notation 5-reduction.watsup:119.62-119.73] {}  :  {}
[niteration 5-reduction.watsup:119.6-119.89] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.75-119.89] ({TABLE.FILL x})  :  admininstr*
[notation 5-reduction.watsup:119.75-119.89] ({TABLE.FILL x})  :  admininstr
[notation 5-reduction.watsup:119.76-119.88] {TABLE.FILL x}  :  admininstr
[elab 5-reduction.watsup:119.76-119.88] {TABLE.FILL x}  :  admininstr
[notation 5-reduction.watsup:119.76-119.88] {x}  :  {tableidx}
[notation 5-reduction.watsup:119.87-119.88] x  :  tableidx
[elab 5-reduction.watsup:119.87-119.88] x  :  tableidx
[notation 5-reduction.watsup:119.76-119.88] {}  :  {}
[niteration 5-reduction.watsup:119.6-119.89]   :  admininstr*
[notation 5-reduction.watsup:123.3-123.72] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})} ~> TRAP  :  config ~> admininstr*
[notation 5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config
[elab 5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config
[notation 5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:123.3-123.4] z  :  state
[elab 5-reduction.watsup:123.3-123.4] z  :  state
[notation 5-reduction.watsup:123.6-123.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:123.6-123.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:123.6-123.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:123.6-123.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:123.7-123.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:123.7-123.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:123.7-123.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:123.13-123.16] I32  :  numtype
[elab 5-reduction.watsup:123.13-123.16] I32  :  numtype
[notation 5-reduction.watsup:123.13-123.16] {}  :  {}
[notation 5-reduction.watsup:123.7-123.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:123.17-123.18] j  :  c_numtype
[elab 5-reduction.watsup:123.17-123.18] j  :  c_numtype
[notation 5-reduction.watsup:123.7-123.18] {}  :  {}
[niteration 5-reduction.watsup:123.6-123.64] ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:123.20-123.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:123.20-123.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:123.21-123.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:123.21-123.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:123.21-123.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:123.27-123.30] I32  :  numtype
[elab 5-reduction.watsup:123.27-123.30] I32  :  numtype
[notation 5-reduction.watsup:123.27-123.30] {}  :  {}
[notation 5-reduction.watsup:123.21-123.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:123.31-123.32] i  :  c_numtype
[elab 5-reduction.watsup:123.31-123.32] i  :  c_numtype
[notation 5-reduction.watsup:123.21-123.32] {}  :  {}
[niteration 5-reduction.watsup:123.6-123.64] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:123.34-123.47] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:123.34-123.47] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:123.35-123.46] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:123.35-123.46] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:123.35-123.46] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:123.41-123.44] I32  :  numtype
[elab 5-reduction.watsup:123.41-123.44] I32  :  numtype
[notation 5-reduction.watsup:123.41-123.44] {}  :  {}
[notation 5-reduction.watsup:123.35-123.46] {n}  :  {c_numtype}
[notation 5-reduction.watsup:123.45-123.46] n  :  c_numtype
[elab 5-reduction.watsup:123.45-123.46] n  :  c_numtype
[notation 5-reduction.watsup:123.35-123.46] {}  :  {}
[niteration 5-reduction.watsup:123.6-123.64] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:123.48-123.64] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:123.48-123.64] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:123.49-123.63] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:123.49-123.63] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:123.49-123.63] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:123.60-123.61] x  :  tableidx
[elab 5-reduction.watsup:123.60-123.61] x  :  tableidx
[notation 5-reduction.watsup:123.49-123.63] {y}  :  {tableidx}
[notation 5-reduction.watsup:123.62-123.63] y  :  tableidx
[elab 5-reduction.watsup:123.62-123.63] y  :  tableidx
[notation 5-reduction.watsup:123.49-123.63] {}  :  {}
[niteration 5-reduction.watsup:123.6-123.64]   :  admininstr*
[notation 5-reduction.watsup:123.68-123.72] TRAP  :  admininstr*
[notation 5-reduction.watsup:123.68-123.72] TRAP  :  admininstr
[elab 5-reduction.watsup:123.68-123.72] TRAP  :  admininstr
[notation 5-reduction.watsup:123.68-123.72] {}  :  {}
[elab 5-reduction.watsup:124.9-124.63] i + n > |$table(z, y)| \/ j + n > |$table(z, x)|  :  bool
[elab 5-reduction.watsup:124.9-124.34] i + n > |$table(z, y)|  :  bool
[elab 5-reduction.watsup:124.9-124.17] i + n  :  nat
[elab 5-reduction.watsup:124.11-124.12] i  :  nat
[elab 5-reduction.watsup:124.15-124.16] n  :  nat
[elab 5-reduction.watsup:124.20-124.34] |$table(z, y)|  :  nat
[elab 5-reduction.watsup:124.21-124.33] $table(z, y)  :  tableinst
[elab 5-reduction.watsup:124.27-124.33] (z, y)  :  (state, tableidx)
[elab 5-reduction.watsup:124.28-124.29] z  :  state
[elab 5-reduction.watsup:124.31-124.32] y  :  tableidx
[elab 5-reduction.watsup:124.38-124.63] j + n > |$table(z, x)|  :  bool
[elab 5-reduction.watsup:124.38-124.46] j + n  :  nat
[elab 5-reduction.watsup:124.40-124.41] j  :  nat
[elab 5-reduction.watsup:124.44-124.45] n  :  nat
[elab 5-reduction.watsup:124.49-124.63] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:124.50-124.62] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:124.56-124.62] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:124.57-124.58] z  :  state
[elab 5-reduction.watsup:124.60-124.61] x  :  tableidx
[notation 5-reduction.watsup:126.3-126.75] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})} ~> epsilon  :  config ~> admininstr*
[notation 5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  config
[elab 5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  config
[notation 5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:126.3-126.4] z  :  state
[elab 5-reduction.watsup:126.3-126.4] z  :  state
[notation 5-reduction.watsup:126.6-126.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:126.6-126.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:126.6-126.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:126.6-126.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:126.7-126.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:126.7-126.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:126.7-126.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:126.13-126.16] I32  :  numtype
[elab 5-reduction.watsup:126.13-126.16] I32  :  numtype
[notation 5-reduction.watsup:126.13-126.16] {}  :  {}
[notation 5-reduction.watsup:126.7-126.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:126.17-126.18] j  :  c_numtype
[elab 5-reduction.watsup:126.17-126.18] j  :  c_numtype
[notation 5-reduction.watsup:126.7-126.18] {}  :  {}
[niteration 5-reduction.watsup:126.6-126.64] ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:126.20-126.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:126.20-126.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:126.21-126.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:126.21-126.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:126.21-126.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:126.27-126.30] I32  :  numtype
[elab 5-reduction.watsup:126.27-126.30] I32  :  numtype
[notation 5-reduction.watsup:126.27-126.30] {}  :  {}
[notation 5-reduction.watsup:126.21-126.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:126.31-126.32] i  :  c_numtype
[elab 5-reduction.watsup:126.31-126.32] i  :  c_numtype
[notation 5-reduction.watsup:126.21-126.32] {}  :  {}
[niteration 5-reduction.watsup:126.6-126.64] ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:126.34-126.47] ({CONST I32 0})  :  admininstr*
[notation 5-reduction.watsup:126.34-126.47] ({CONST I32 0})  :  admininstr
[notation 5-reduction.watsup:126.35-126.46] {CONST I32 0}  :  admininstr
[elab 5-reduction.watsup:126.35-126.46] {CONST I32 0}  :  admininstr
[notation 5-reduction.watsup:126.35-126.46] {I32 0}  :  {numtype c_numtype}
[notation 5-reduction.watsup:126.41-126.44] I32  :  numtype
[elab 5-reduction.watsup:126.41-126.44] I32  :  numtype
[notation 5-reduction.watsup:126.41-126.44] {}  :  {}
[notation 5-reduction.watsup:126.35-126.46] {0}  :  {c_numtype}
[notation 5-reduction.watsup:126.45-126.46] 0  :  c_numtype
[elab 5-reduction.watsup:126.45-126.46] 0  :  c_numtype
[notation 5-reduction.watsup:126.35-126.46] {}  :  {}
[niteration 5-reduction.watsup:126.6-126.64] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:126.48-126.64] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:126.48-126.64] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:126.49-126.63] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:126.49-126.63] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:126.49-126.63] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:126.60-126.61] x  :  tableidx
[elab 5-reduction.watsup:126.60-126.61] x  :  tableidx
[notation 5-reduction.watsup:126.49-126.63] {y}  :  {tableidx}
[notation 5-reduction.watsup:126.62-126.63] y  :  tableidx
[elab 5-reduction.watsup:126.62-126.63] y  :  tableidx
[notation 5-reduction.watsup:126.49-126.63] {}  :  {}
[niteration 5-reduction.watsup:126.6-126.64]   :  admininstr*
[notation 5-reduction.watsup:126.68-126.75] epsilon  :  admininstr*
[niteration 5-reduction.watsup:126.68-126.75]   :  admininstr*
[notation 5-reduction.watsup:129.3-131.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config ~> admininstr*
[notation 5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[elab 5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[notation 5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:129.3-129.4] z  :  state
[elab 5-reduction.watsup:129.3-129.4] z  :  state
[notation 5-reduction.watsup:129.6-129.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:129.6-129.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:129.6-129.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:129.6-129.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:129.7-129.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:129.7-129.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:129.7-129.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:129.13-129.16] I32  :  numtype
[elab 5-reduction.watsup:129.13-129.16] I32  :  numtype
[notation 5-reduction.watsup:129.13-129.16] {}  :  {}
[notation 5-reduction.watsup:129.7-129.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:129.17-129.18] j  :  c_numtype
[elab 5-reduction.watsup:129.17-129.18] j  :  c_numtype
[notation 5-reduction.watsup:129.7-129.18] {}  :  {}
[niteration 5-reduction.watsup:129.6-129.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:129.20-129.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:129.20-129.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:129.21-129.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:129.21-129.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:129.21-129.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:129.27-129.30] I32  :  numtype
[elab 5-reduction.watsup:129.27-129.30] I32  :  numtype
[notation 5-reduction.watsup:129.27-129.30] {}  :  {}
[notation 5-reduction.watsup:129.21-129.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:129.31-129.32] i  :  c_numtype
[elab 5-reduction.watsup:129.31-129.32] i  :  c_numtype
[notation 5-reduction.watsup:129.21-129.32] {}  :  {}
[niteration 5-reduction.watsup:129.6-129.69] ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:129.34-129.52] ({CONST I32 n + 1})  :  admininstr*
[notation 5-reduction.watsup:129.34-129.52] ({CONST I32 n + 1})  :  admininstr
[notation 5-reduction.watsup:129.35-129.51] {CONST I32 n + 1}  :  admininstr
[elab 5-reduction.watsup:129.35-129.51] {CONST I32 n + 1}  :  admininstr
[notation 5-reduction.watsup:129.35-129.51] {I32 n + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:129.41-129.44] I32  :  numtype
[elab 5-reduction.watsup:129.41-129.44] I32  :  numtype
[notation 5-reduction.watsup:129.41-129.44] {}  :  {}
[notation 5-reduction.watsup:129.35-129.51] {n + 1}  :  {c_numtype}
[notation 5-reduction.watsup:129.45-129.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:129.45-129.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:129.47-129.48] n  :  nat
[elab 5-reduction.watsup:129.49-129.50] 1  :  nat
[notation 5-reduction.watsup:129.35-129.51] {}  :  {}
[niteration 5-reduction.watsup:129.6-129.69] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:129.53-129.69] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:129.53-129.69] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:129.54-129.68] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:129.54-129.68] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:129.54-129.68] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:129.65-129.66] x  :  tableidx
[elab 5-reduction.watsup:129.65-129.66] x  :  tableidx
[notation 5-reduction.watsup:129.54-129.68] {y}  :  {tableidx}
[notation 5-reduction.watsup:129.67-129.68] y  :  tableidx
[elab 5-reduction.watsup:129.67-129.68] y  :  tableidx
[notation 5-reduction.watsup:129.54-129.68] {}  :  {}
[niteration 5-reduction.watsup:129.6-129.69]   :  admininstr*
[notation 5-reduction.watsup:130.6-131.74] {({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:130.6-131.74] ({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:130.6-130.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:130.6-130.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:130.7-130.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:130.7-130.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:130.7-130.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:130.13-130.16] I32  :  numtype
[elab 5-reduction.watsup:130.13-130.16] I32  :  numtype
[notation 5-reduction.watsup:130.13-130.16] {}  :  {}
[notation 5-reduction.watsup:130.7-130.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:130.17-130.18] j  :  c_numtype
[elab 5-reduction.watsup:130.17-130.18] j  :  c_numtype
[notation 5-reduction.watsup:130.7-130.18] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:130.20-130.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:130.20-130.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:130.21-130.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:130.21-130.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:130.21-130.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:130.27-130.30] I32  :  numtype
[elab 5-reduction.watsup:130.27-130.30] I32  :  numtype
[notation 5-reduction.watsup:130.27-130.30] {}  :  {}
[notation 5-reduction.watsup:130.21-130.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:130.31-130.32] i  :  c_numtype
[elab 5-reduction.watsup:130.31-130.32] i  :  c_numtype
[notation 5-reduction.watsup:130.21-130.32] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:130.34-130.47] ({TABLE.GET y})  :  admininstr*
[notation 5-reduction.watsup:130.34-130.47] ({TABLE.GET y})  :  admininstr
[notation 5-reduction.watsup:130.35-130.46] {TABLE.GET y}  :  admininstr
[elab 5-reduction.watsup:130.35-130.46] {TABLE.GET y}  :  admininstr
[notation 5-reduction.watsup:130.35-130.46] {y}  :  {tableidx}
[notation 5-reduction.watsup:130.45-130.46] y  :  tableidx
[elab 5-reduction.watsup:130.45-130.46] y  :  tableidx
[notation 5-reduction.watsup:130.35-130.46] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:130.48-130.61] ({TABLE.SET x})  :  admininstr*
[notation 5-reduction.watsup:130.48-130.61] ({TABLE.SET x})  :  admininstr
[notation 5-reduction.watsup:130.49-130.60] {TABLE.SET x}  :  admininstr
[elab 5-reduction.watsup:130.49-130.60] {TABLE.SET x}  :  admininstr
[notation 5-reduction.watsup:130.49-130.60] {x}  :  {tableidx}
[notation 5-reduction.watsup:130.59-130.60] x  :  tableidx
[elab 5-reduction.watsup:130.59-130.60] x  :  tableidx
[notation 5-reduction.watsup:130.49-130.60] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:131.6-131.24] ({CONST I32 j + 1})  :  admininstr*
[notation 5-reduction.watsup:131.6-131.24] ({CONST I32 j + 1})  :  admininstr
[notation 5-reduction.watsup:131.7-131.23] {CONST I32 j + 1}  :  admininstr
[elab 5-reduction.watsup:131.7-131.23] {CONST I32 j + 1}  :  admininstr
[notation 5-reduction.watsup:131.7-131.23] {I32 j + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:131.13-131.16] I32  :  numtype
[elab 5-reduction.watsup:131.13-131.16] I32  :  numtype
[notation 5-reduction.watsup:131.13-131.16] {}  :  {}
[notation 5-reduction.watsup:131.7-131.23] {j + 1}  :  {c_numtype}
[notation 5-reduction.watsup:131.17-131.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:131.17-131.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:131.19-131.20] j  :  nat
[elab 5-reduction.watsup:131.21-131.22] 1  :  nat
[notation 5-reduction.watsup:131.7-131.23] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:131.25-131.43] ({CONST I32 i + 1})  :  admininstr*
[notation 5-reduction.watsup:131.25-131.43] ({CONST I32 i + 1})  :  admininstr
[notation 5-reduction.watsup:131.26-131.42] {CONST I32 i + 1}  :  admininstr
[elab 5-reduction.watsup:131.26-131.42] {CONST I32 i + 1}  :  admininstr
[notation 5-reduction.watsup:131.26-131.42] {I32 i + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:131.32-131.35] I32  :  numtype
[elab 5-reduction.watsup:131.32-131.35] I32  :  numtype
[notation 5-reduction.watsup:131.32-131.35] {}  :  {}
[notation 5-reduction.watsup:131.26-131.42] {i + 1}  :  {c_numtype}
[notation 5-reduction.watsup:131.36-131.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:131.36-131.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:131.38-131.39] i  :  nat
[elab 5-reduction.watsup:131.40-131.41] 1  :  nat
[notation 5-reduction.watsup:131.26-131.42] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:131.44-131.57] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:131.44-131.57] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:131.45-131.56] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:131.45-131.56] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:131.45-131.56] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:131.51-131.54] I32  :  numtype
[elab 5-reduction.watsup:131.51-131.54] I32  :  numtype
[notation 5-reduction.watsup:131.51-131.54] {}  :  {}
[notation 5-reduction.watsup:131.45-131.56] {n}  :  {c_numtype}
[notation 5-reduction.watsup:131.55-131.56] n  :  c_numtype
[elab 5-reduction.watsup:131.55-131.56] n  :  c_numtype
[notation 5-reduction.watsup:131.45-131.56] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:131.58-131.74] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:131.58-131.74] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:131.59-131.73] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:131.59-131.73] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:131.59-131.73] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:131.70-131.71] x  :  tableidx
[elab 5-reduction.watsup:131.70-131.71] x  :  tableidx
[notation 5-reduction.watsup:131.59-131.73] {y}  :  {tableidx}
[notation 5-reduction.watsup:131.72-131.73] y  :  tableidx
[elab 5-reduction.watsup:131.72-131.73] y  :  tableidx
[notation 5-reduction.watsup:131.59-131.73] {}  :  {}
[niteration 5-reduction.watsup:130.6-131.74]   :  admininstr*
[elab 5-reduction.watsup:133.9-133.15] j <= i  :  bool
[elab 5-reduction.watsup:133.9-133.10] j  :  nat
[elab 5-reduction.watsup:133.14-133.15] i  :  nat
[notation 5-reduction.watsup:135.3-137.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config ~> admininstr*
[notation 5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[elab 5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[notation 5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:135.3-135.4] z  :  state
[elab 5-reduction.watsup:135.3-135.4] z  :  state
[notation 5-reduction.watsup:135.6-135.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:135.6-135.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:135.6-135.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:135.6-135.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:135.7-135.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:135.7-135.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:135.7-135.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:135.13-135.16] I32  :  numtype
[elab 5-reduction.watsup:135.13-135.16] I32  :  numtype
[notation 5-reduction.watsup:135.13-135.16] {}  :  {}
[notation 5-reduction.watsup:135.7-135.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:135.17-135.18] j  :  c_numtype
[elab 5-reduction.watsup:135.17-135.18] j  :  c_numtype
[notation 5-reduction.watsup:135.7-135.18] {}  :  {}
[niteration 5-reduction.watsup:135.6-135.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:135.20-135.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:135.20-135.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:135.21-135.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:135.21-135.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:135.21-135.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:135.27-135.30] I32  :  numtype
[elab 5-reduction.watsup:135.27-135.30] I32  :  numtype
[notation 5-reduction.watsup:135.27-135.30] {}  :  {}
[notation 5-reduction.watsup:135.21-135.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:135.31-135.32] i  :  c_numtype
[elab 5-reduction.watsup:135.31-135.32] i  :  c_numtype
[notation 5-reduction.watsup:135.21-135.32] {}  :  {}
[niteration 5-reduction.watsup:135.6-135.69] ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:135.34-135.52] ({CONST I32 n + 1})  :  admininstr*
[notation 5-reduction.watsup:135.34-135.52] ({CONST I32 n + 1})  :  admininstr
[notation 5-reduction.watsup:135.35-135.51] {CONST I32 n + 1}  :  admininstr
[elab 5-reduction.watsup:135.35-135.51] {CONST I32 n + 1}  :  admininstr
[notation 5-reduction.watsup:135.35-135.51] {I32 n + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:135.41-135.44] I32  :  numtype
[elab 5-reduction.watsup:135.41-135.44] I32  :  numtype
[notation 5-reduction.watsup:135.41-135.44] {}  :  {}
[notation 5-reduction.watsup:135.35-135.51] {n + 1}  :  {c_numtype}
[notation 5-reduction.watsup:135.45-135.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:135.45-135.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:135.47-135.48] n  :  nat
[elab 5-reduction.watsup:135.49-135.50] 1  :  nat
[notation 5-reduction.watsup:135.35-135.51] {}  :  {}
[niteration 5-reduction.watsup:135.6-135.69] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:135.53-135.69] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:135.53-135.69] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:135.54-135.68] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:135.54-135.68] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:135.54-135.68] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:135.65-135.66] x  :  tableidx
[elab 5-reduction.watsup:135.65-135.66] x  :  tableidx
[notation 5-reduction.watsup:135.54-135.68] {y}  :  {tableidx}
[notation 5-reduction.watsup:135.67-135.68] y  :  tableidx
[elab 5-reduction.watsup:135.67-135.68] y  :  tableidx
[notation 5-reduction.watsup:135.54-135.68] {}  :  {}
[niteration 5-reduction.watsup:135.6-135.69]   :  admininstr*
[notation 5-reduction.watsup:136.6-137.74] {({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration 5-reduction.watsup:136.6-137.74] ({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:136.6-136.24] ({CONST I32 j + n})  :  admininstr*
[notation 5-reduction.watsup:136.6-136.24] ({CONST I32 j + n})  :  admininstr
[notation 5-reduction.watsup:136.7-136.23] {CONST I32 j + n}  :  admininstr
[elab 5-reduction.watsup:136.7-136.23] {CONST I32 j + n}  :  admininstr
[notation 5-reduction.watsup:136.7-136.23] {I32 j + n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:136.13-136.16] I32  :  numtype
[elab 5-reduction.watsup:136.13-136.16] I32  :  numtype
[notation 5-reduction.watsup:136.13-136.16] {}  :  {}
[notation 5-reduction.watsup:136.7-136.23] {j + n}  :  {c_numtype}
[notation 5-reduction.watsup:136.17-136.23] j + n  :  c_numtype
[elab 5-reduction.watsup:136.17-136.23] j + n  :  c_numtype
[elab 5-reduction.watsup:136.19-136.20] j  :  nat
[elab 5-reduction.watsup:136.21-136.22] n  :  nat
[notation 5-reduction.watsup:136.7-136.23] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:136.25-136.43] ({CONST I32 i + n})  :  admininstr*
[notation 5-reduction.watsup:136.25-136.43] ({CONST I32 i + n})  :  admininstr
[notation 5-reduction.watsup:136.26-136.42] {CONST I32 i + n}  :  admininstr
[elab 5-reduction.watsup:136.26-136.42] {CONST I32 i + n}  :  admininstr
[notation 5-reduction.watsup:136.26-136.42] {I32 i + n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:136.32-136.35] I32  :  numtype
[elab 5-reduction.watsup:136.32-136.35] I32  :  numtype
[notation 5-reduction.watsup:136.32-136.35] {}  :  {}
[notation 5-reduction.watsup:136.26-136.42] {i + n}  :  {c_numtype}
[notation 5-reduction.watsup:136.36-136.42] i + n  :  c_numtype
[elab 5-reduction.watsup:136.36-136.42] i + n  :  c_numtype
[elab 5-reduction.watsup:136.38-136.39] i  :  nat
[elab 5-reduction.watsup:136.40-136.41] n  :  nat
[notation 5-reduction.watsup:136.26-136.42] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:136.44-136.57] ({TABLE.GET y})  :  admininstr*
[notation 5-reduction.watsup:136.44-136.57] ({TABLE.GET y})  :  admininstr
[notation 5-reduction.watsup:136.45-136.56] {TABLE.GET y}  :  admininstr
[elab 5-reduction.watsup:136.45-136.56] {TABLE.GET y}  :  admininstr
[notation 5-reduction.watsup:136.45-136.56] {y}  :  {tableidx}
[notation 5-reduction.watsup:136.55-136.56] y  :  tableidx
[elab 5-reduction.watsup:136.55-136.56] y  :  tableidx
[notation 5-reduction.watsup:136.45-136.56] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:136.58-136.71] ({TABLE.SET x})  :  admininstr*
[notation 5-reduction.watsup:136.58-136.71] ({TABLE.SET x})  :  admininstr
[notation 5-reduction.watsup:136.59-136.70] {TABLE.SET x}  :  admininstr
[elab 5-reduction.watsup:136.59-136.70] {TABLE.SET x}  :  admininstr
[notation 5-reduction.watsup:136.59-136.70] {x}  :  {tableidx}
[notation 5-reduction.watsup:136.69-136.70] x  :  tableidx
[elab 5-reduction.watsup:136.69-136.70] x  :  tableidx
[notation 5-reduction.watsup:136.59-136.70] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:137.6-137.24] ({CONST I32 j + 1})  :  admininstr*
[notation 5-reduction.watsup:137.6-137.24] ({CONST I32 j + 1})  :  admininstr
[notation 5-reduction.watsup:137.7-137.23] {CONST I32 j + 1}  :  admininstr
[elab 5-reduction.watsup:137.7-137.23] {CONST I32 j + 1}  :  admininstr
[notation 5-reduction.watsup:137.7-137.23] {I32 j + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:137.13-137.16] I32  :  numtype
[elab 5-reduction.watsup:137.13-137.16] I32  :  numtype
[notation 5-reduction.watsup:137.13-137.16] {}  :  {}
[notation 5-reduction.watsup:137.7-137.23] {j + 1}  :  {c_numtype}
[notation 5-reduction.watsup:137.17-137.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:137.17-137.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:137.19-137.20] j  :  nat
[elab 5-reduction.watsup:137.21-137.22] 1  :  nat
[notation 5-reduction.watsup:137.7-137.23] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:137.25-137.43] ({CONST I32 i + 1})  :  admininstr*
[notation 5-reduction.watsup:137.25-137.43] ({CONST I32 i + 1})  :  admininstr
[notation 5-reduction.watsup:137.26-137.42] {CONST I32 i + 1}  :  admininstr
[elab 5-reduction.watsup:137.26-137.42] {CONST I32 i + 1}  :  admininstr
[notation 5-reduction.watsup:137.26-137.42] {I32 i + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:137.32-137.35] I32  :  numtype
[elab 5-reduction.watsup:137.32-137.35] I32  :  numtype
[notation 5-reduction.watsup:137.32-137.35] {}  :  {}
[notation 5-reduction.watsup:137.26-137.42] {i + 1}  :  {c_numtype}
[notation 5-reduction.watsup:137.36-137.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:137.36-137.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:137.38-137.39] i  :  nat
[elab 5-reduction.watsup:137.40-137.41] 1  :  nat
[notation 5-reduction.watsup:137.26-137.42] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:137.44-137.57] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:137.44-137.57] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:137.45-137.56] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:137.45-137.56] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:137.45-137.56] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:137.51-137.54] I32  :  numtype
[elab 5-reduction.watsup:137.51-137.54] I32  :  numtype
[notation 5-reduction.watsup:137.51-137.54] {}  :  {}
[notation 5-reduction.watsup:137.45-137.56] {n}  :  {c_numtype}
[notation 5-reduction.watsup:137.55-137.56] n  :  c_numtype
[elab 5-reduction.watsup:137.55-137.56] n  :  c_numtype
[notation 5-reduction.watsup:137.45-137.56] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:137.58-137.74] ({TABLE.COPY x y})  :  admininstr*
[notation 5-reduction.watsup:137.58-137.74] ({TABLE.COPY x y})  :  admininstr
[notation 5-reduction.watsup:137.59-137.73] {TABLE.COPY x y}  :  admininstr
[elab 5-reduction.watsup:137.59-137.73] {TABLE.COPY x y}  :  admininstr
[notation 5-reduction.watsup:137.59-137.73] {x y}  :  {tableidx tableidx}
[notation 5-reduction.watsup:137.70-137.71] x  :  tableidx
[elab 5-reduction.watsup:137.70-137.71] x  :  tableidx
[notation 5-reduction.watsup:137.59-137.73] {y}  :  {tableidx}
[notation 5-reduction.watsup:137.72-137.73] y  :  tableidx
[elab 5-reduction.watsup:137.72-137.73] y  :  tableidx
[notation 5-reduction.watsup:137.59-137.73] {}  :  {}
[niteration 5-reduction.watsup:136.6-137.74]   :  admininstr*
[elab 5-reduction.watsup:139.9-139.14] j > i  :  bool
[elab 5-reduction.watsup:139.9-139.10] j  :  nat
[elab 5-reduction.watsup:139.13-139.14] i  :  nat
[notation 5-reduction.watsup:142.3-142.72] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})} ~> TRAP  :  config ~> admininstr*
[notation 5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config
[elab 5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config
[notation 5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:142.3-142.4] z  :  state
[elab 5-reduction.watsup:142.3-142.4] z  :  state
[notation 5-reduction.watsup:142.6-142.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  admininstr*
[niteration 5-reduction.watsup:142.6-142.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:142.6-142.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:142.6-142.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:142.7-142.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:142.7-142.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:142.7-142.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:142.13-142.16] I32  :  numtype
[elab 5-reduction.watsup:142.13-142.16] I32  :  numtype
[notation 5-reduction.watsup:142.13-142.16] {}  :  {}
[notation 5-reduction.watsup:142.7-142.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:142.17-142.18] j  :  c_numtype
[elab 5-reduction.watsup:142.17-142.18] j  :  c_numtype
[notation 5-reduction.watsup:142.7-142.18] {}  :  {}
[niteration 5-reduction.watsup:142.6-142.64] ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:142.20-142.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:142.20-142.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:142.21-142.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:142.21-142.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:142.21-142.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:142.27-142.30] I32  :  numtype
[elab 5-reduction.watsup:142.27-142.30] I32  :  numtype
[notation 5-reduction.watsup:142.27-142.30] {}  :  {}
[notation 5-reduction.watsup:142.21-142.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:142.31-142.32] i  :  c_numtype
[elab 5-reduction.watsup:142.31-142.32] i  :  c_numtype
[notation 5-reduction.watsup:142.21-142.32] {}  :  {}
[niteration 5-reduction.watsup:142.6-142.64] ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:142.34-142.47] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:142.34-142.47] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:142.35-142.46] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:142.35-142.46] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:142.35-142.46] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:142.41-142.44] I32  :  numtype
[elab 5-reduction.watsup:142.41-142.44] I32  :  numtype
[notation 5-reduction.watsup:142.41-142.44] {}  :  {}
[notation 5-reduction.watsup:142.35-142.46] {n}  :  {c_numtype}
[notation 5-reduction.watsup:142.45-142.46] n  :  c_numtype
[elab 5-reduction.watsup:142.45-142.46] n  :  c_numtype
[notation 5-reduction.watsup:142.35-142.46] {}  :  {}
[niteration 5-reduction.watsup:142.6-142.64] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:142.48-142.64] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:142.48-142.64] ({TABLE.INIT x y})  :  admininstr
[notation 5-reduction.watsup:142.49-142.63] {TABLE.INIT x y}  :  admininstr
[elab 5-reduction.watsup:142.49-142.63] {TABLE.INIT x y}  :  admininstr
[notation 5-reduction.watsup:142.49-142.63] {x y}  :  {tableidx elemidx}
[notation 5-reduction.watsup:142.60-142.61] x  :  tableidx
[elab 5-reduction.watsup:142.60-142.61] x  :  tableidx
[notation 5-reduction.watsup:142.49-142.63] {y}  :  {elemidx}
[notation 5-reduction.watsup:142.62-142.63] y  :  elemidx
[elab 5-reduction.watsup:142.62-142.63] y  :  elemidx
[notation 5-reduction.watsup:142.49-142.63] {}  :  {}
[niteration 5-reduction.watsup:142.6-142.64]   :  admininstr*
[notation 5-reduction.watsup:142.68-142.72] TRAP  :  admininstr*
[notation 5-reduction.watsup:142.68-142.72] TRAP  :  admininstr
[elab 5-reduction.watsup:142.68-142.72] TRAP  :  admininstr
[notation 5-reduction.watsup:142.68-142.72] {}  :  {}
[elab 5-reduction.watsup:143.9-143.62] i + n > |$elem(z, y)| \/ j + n > |$table(z, x)|  :  bool
[elab 5-reduction.watsup:143.9-143.33] i + n > |$elem(z, y)|  :  bool
[elab 5-reduction.watsup:143.9-143.17] i + n  :  nat
[elab 5-reduction.watsup:143.11-143.12] i  :  nat
[elab 5-reduction.watsup:143.15-143.16] n  :  nat
[elab 5-reduction.watsup:143.20-143.33] |$elem(z, y)|  :  nat
[elab 5-reduction.watsup:143.21-143.32] $elem(z, y)  :  eleminst
[elab 5-reduction.watsup:143.26-143.32] (z, y)  :  (state, tableidx)
[elab 5-reduction.watsup:143.27-143.28] z  :  state
[elab 5-reduction.watsup:143.30-143.31] y  :  tableidx
[elab 5-reduction.watsup:143.37-143.62] j + n > |$table(z, x)|  :  bool
[elab 5-reduction.watsup:143.37-143.45] j + n  :  nat
[elab 5-reduction.watsup:143.39-143.40] j  :  nat
[elab 5-reduction.watsup:143.43-143.44] n  :  nat
[elab 5-reduction.watsup:143.48-143.62] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:143.49-143.61] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:143.55-143.61] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:143.56-143.57] z  :  state
[elab 5-reduction.watsup:143.59-143.60] x  :  tableidx
[notation 5-reduction.watsup:145.3-145.75] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})} ~> epsilon  :  config ~> admininstr*
[notation 5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  config
[elab 5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  config
[notation 5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:145.3-145.4] z  :  state
[elab 5-reduction.watsup:145.3-145.4] z  :  state
[notation 5-reduction.watsup:145.6-145.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  admininstr*
[niteration 5-reduction.watsup:145.6-145.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:145.6-145.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:145.6-145.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:145.7-145.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:145.7-145.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:145.7-145.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:145.13-145.16] I32  :  numtype
[elab 5-reduction.watsup:145.13-145.16] I32  :  numtype
[notation 5-reduction.watsup:145.13-145.16] {}  :  {}
[notation 5-reduction.watsup:145.7-145.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:145.17-145.18] j  :  c_numtype
[elab 5-reduction.watsup:145.17-145.18] j  :  c_numtype
[notation 5-reduction.watsup:145.7-145.18] {}  :  {}
[niteration 5-reduction.watsup:145.6-145.64] ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:145.20-145.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:145.20-145.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:145.21-145.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:145.21-145.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:145.21-145.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:145.27-145.30] I32  :  numtype
[elab 5-reduction.watsup:145.27-145.30] I32  :  numtype
[notation 5-reduction.watsup:145.27-145.30] {}  :  {}
[notation 5-reduction.watsup:145.21-145.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:145.31-145.32] i  :  c_numtype
[elab 5-reduction.watsup:145.31-145.32] i  :  c_numtype
[notation 5-reduction.watsup:145.21-145.32] {}  :  {}
[niteration 5-reduction.watsup:145.6-145.64] ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:145.34-145.47] ({CONST I32 0})  :  admininstr*
[notation 5-reduction.watsup:145.34-145.47] ({CONST I32 0})  :  admininstr
[notation 5-reduction.watsup:145.35-145.46] {CONST I32 0}  :  admininstr
[elab 5-reduction.watsup:145.35-145.46] {CONST I32 0}  :  admininstr
[notation 5-reduction.watsup:145.35-145.46] {I32 0}  :  {numtype c_numtype}
[notation 5-reduction.watsup:145.41-145.44] I32  :  numtype
[elab 5-reduction.watsup:145.41-145.44] I32  :  numtype
[notation 5-reduction.watsup:145.41-145.44] {}  :  {}
[notation 5-reduction.watsup:145.35-145.46] {0}  :  {c_numtype}
[notation 5-reduction.watsup:145.45-145.46] 0  :  c_numtype
[elab 5-reduction.watsup:145.45-145.46] 0  :  c_numtype
[notation 5-reduction.watsup:145.35-145.46] {}  :  {}
[niteration 5-reduction.watsup:145.6-145.64] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:145.48-145.64] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:145.48-145.64] ({TABLE.INIT x y})  :  admininstr
[notation 5-reduction.watsup:145.49-145.63] {TABLE.INIT x y}  :  admininstr
[elab 5-reduction.watsup:145.49-145.63] {TABLE.INIT x y}  :  admininstr
[notation 5-reduction.watsup:145.49-145.63] {x y}  :  {tableidx elemidx}
[notation 5-reduction.watsup:145.60-145.61] x  :  tableidx
[elab 5-reduction.watsup:145.60-145.61] x  :  tableidx
[notation 5-reduction.watsup:145.49-145.63] {y}  :  {elemidx}
[notation 5-reduction.watsup:145.62-145.63] y  :  elemidx
[elab 5-reduction.watsup:145.62-145.63] y  :  elemidx
[notation 5-reduction.watsup:145.49-145.63] {}  :  {}
[niteration 5-reduction.watsup:145.6-145.64]   :  admininstr*
[notation 5-reduction.watsup:145.68-145.75] epsilon  :  admininstr*
[niteration 5-reduction.watsup:145.68-145.75]   :  admininstr*
[notation 5-reduction.watsup:148.3-150.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})} ~> {({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config ~> admininstr*
[notation 5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  config
[elab 5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  config
[notation 5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation 5-reduction.watsup:148.3-148.4] z  :  state
[elab 5-reduction.watsup:148.3-148.4] z  :  state
[notation 5-reduction.watsup:148.6-148.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  admininstr*
[niteration 5-reduction.watsup:148.6-148.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:148.6-148.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:148.6-148.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:148.7-148.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:148.7-148.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:148.7-148.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:148.13-148.16] I32  :  numtype
[elab 5-reduction.watsup:148.13-148.16] I32  :  numtype
[notation 5-reduction.watsup:148.13-148.16] {}  :  {}
[notation 5-reduction.watsup:148.7-148.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:148.17-148.18] j  :  c_numtype
[elab 5-reduction.watsup:148.17-148.18] j  :  c_numtype
[notation 5-reduction.watsup:148.7-148.18] {}  :  {}
[niteration 5-reduction.watsup:148.6-148.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:148.20-148.33] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:148.20-148.33] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:148.21-148.32] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:148.21-148.32] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:148.21-148.32] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:148.27-148.30] I32  :  numtype
[elab 5-reduction.watsup:148.27-148.30] I32  :  numtype
[notation 5-reduction.watsup:148.27-148.30] {}  :  {}
[notation 5-reduction.watsup:148.21-148.32] {i}  :  {c_numtype}
[notation 5-reduction.watsup:148.31-148.32] i  :  c_numtype
[elab 5-reduction.watsup:148.31-148.32] i  :  c_numtype
[notation 5-reduction.watsup:148.21-148.32] {}  :  {}
[niteration 5-reduction.watsup:148.6-148.69] ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:148.34-148.52] ({CONST I32 n + 1})  :  admininstr*
[notation 5-reduction.watsup:148.34-148.52] ({CONST I32 n + 1})  :  admininstr
[notation 5-reduction.watsup:148.35-148.51] {CONST I32 n + 1}  :  admininstr
[elab 5-reduction.watsup:148.35-148.51] {CONST I32 n + 1}  :  admininstr
[notation 5-reduction.watsup:148.35-148.51] {I32 n + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:148.41-148.44] I32  :  numtype
[elab 5-reduction.watsup:148.41-148.44] I32  :  numtype
[notation 5-reduction.watsup:148.41-148.44] {}  :  {}
[notation 5-reduction.watsup:148.35-148.51] {n + 1}  :  {c_numtype}
[notation 5-reduction.watsup:148.45-148.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:148.45-148.51] n + 1  :  c_numtype
[elab 5-reduction.watsup:148.47-148.48] n  :  nat
[elab 5-reduction.watsup:148.49-148.50] 1  :  nat
[notation 5-reduction.watsup:148.35-148.51] {}  :  {}
[niteration 5-reduction.watsup:148.6-148.69] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:148.53-148.69] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:148.53-148.69] ({TABLE.INIT x y})  :  admininstr
[notation 5-reduction.watsup:148.54-148.68] {TABLE.INIT x y}  :  admininstr
[elab 5-reduction.watsup:148.54-148.68] {TABLE.INIT x y}  :  admininstr
[notation 5-reduction.watsup:148.54-148.68] {x y}  :  {tableidx elemidx}
[notation 5-reduction.watsup:148.65-148.66] x  :  tableidx
[elab 5-reduction.watsup:148.65-148.66] x  :  tableidx
[notation 5-reduction.watsup:148.54-148.68] {y}  :  {elemidx}
[notation 5-reduction.watsup:148.67-148.68] y  :  elemidx
[elab 5-reduction.watsup:148.67-148.68] y  :  elemidx
[notation 5-reduction.watsup:148.54-148.68] {}  :  {}
[niteration 5-reduction.watsup:148.6-148.69]   :  admininstr*
[notation 5-reduction.watsup:149.6-150.74] {({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  admininstr*
[niteration 5-reduction.watsup:149.6-150.74] ({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:149.6-149.19] ({CONST I32 j})  :  admininstr*
[notation 5-reduction.watsup:149.6-149.19] ({CONST I32 j})  :  admininstr
[notation 5-reduction.watsup:149.7-149.18] {CONST I32 j}  :  admininstr
[elab 5-reduction.watsup:149.7-149.18] {CONST I32 j}  :  admininstr
[notation 5-reduction.watsup:149.7-149.18] {I32 j}  :  {numtype c_numtype}
[notation 5-reduction.watsup:149.13-149.16] I32  :  numtype
[elab 5-reduction.watsup:149.13-149.16] I32  :  numtype
[notation 5-reduction.watsup:149.13-149.16] {}  :  {}
[notation 5-reduction.watsup:149.7-149.18] {j}  :  {c_numtype}
[notation 5-reduction.watsup:149.17-149.18] j  :  c_numtype
[elab 5-reduction.watsup:149.17-149.18] j  :  c_numtype
[notation 5-reduction.watsup:149.7-149.18] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74] $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr*
[notation 5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr
[elab 5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr
[elab 5-reduction.watsup:149.20-149.30] $elem(z, y)  :  eleminst
[elab 5-reduction.watsup:149.25-149.30] (z, y)  :  (state, tableidx)
[elab 5-reduction.watsup:149.26-149.27] z  :  state
[elab 5-reduction.watsup:149.28-149.29] y  :  tableidx
[elab 5-reduction.watsup:149.31-149.32] i  :  nat
[niteration 5-reduction.watsup:149.6-150.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:149.34-149.47] ({TABLE.SET x})  :  admininstr*
[notation 5-reduction.watsup:149.34-149.47] ({TABLE.SET x})  :  admininstr
[notation 5-reduction.watsup:149.35-149.46] {TABLE.SET x}  :  admininstr
[elab 5-reduction.watsup:149.35-149.46] {TABLE.SET x}  :  admininstr
[notation 5-reduction.watsup:149.35-149.46] {x}  :  {tableidx}
[notation 5-reduction.watsup:149.45-149.46] x  :  tableidx
[elab 5-reduction.watsup:149.45-149.46] x  :  tableidx
[notation 5-reduction.watsup:149.35-149.46] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:150.6-150.24] ({CONST I32 j + 1})  :  admininstr*
[notation 5-reduction.watsup:150.6-150.24] ({CONST I32 j + 1})  :  admininstr
[notation 5-reduction.watsup:150.7-150.23] {CONST I32 j + 1}  :  admininstr
[elab 5-reduction.watsup:150.7-150.23] {CONST I32 j + 1}  :  admininstr
[notation 5-reduction.watsup:150.7-150.23] {I32 j + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:150.13-150.16] I32  :  numtype
[elab 5-reduction.watsup:150.13-150.16] I32  :  numtype
[notation 5-reduction.watsup:150.13-150.16] {}  :  {}
[notation 5-reduction.watsup:150.7-150.23] {j + 1}  :  {c_numtype}
[notation 5-reduction.watsup:150.17-150.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:150.17-150.23] j + 1  :  c_numtype
[elab 5-reduction.watsup:150.19-150.20] j  :  nat
[elab 5-reduction.watsup:150.21-150.22] 1  :  nat
[notation 5-reduction.watsup:150.7-150.23] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:150.25-150.43] ({CONST I32 i + 1})  :  admininstr*
[notation 5-reduction.watsup:150.25-150.43] ({CONST I32 i + 1})  :  admininstr
[notation 5-reduction.watsup:150.26-150.42] {CONST I32 i + 1}  :  admininstr
[elab 5-reduction.watsup:150.26-150.42] {CONST I32 i + 1}  :  admininstr
[notation 5-reduction.watsup:150.26-150.42] {I32 i + 1}  :  {numtype c_numtype}
[notation 5-reduction.watsup:150.32-150.35] I32  :  numtype
[elab 5-reduction.watsup:150.32-150.35] I32  :  numtype
[notation 5-reduction.watsup:150.32-150.35] {}  :  {}
[notation 5-reduction.watsup:150.26-150.42] {i + 1}  :  {c_numtype}
[notation 5-reduction.watsup:150.36-150.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:150.36-150.42] i + 1  :  c_numtype
[elab 5-reduction.watsup:150.38-150.39] i  :  nat
[elab 5-reduction.watsup:150.40-150.41] 1  :  nat
[notation 5-reduction.watsup:150.26-150.42] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74] ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:150.44-150.57] ({CONST I32 n})  :  admininstr*
[notation 5-reduction.watsup:150.44-150.57] ({CONST I32 n})  :  admininstr
[notation 5-reduction.watsup:150.45-150.56] {CONST I32 n}  :  admininstr
[elab 5-reduction.watsup:150.45-150.56] {CONST I32 n}  :  admininstr
[notation 5-reduction.watsup:150.45-150.56] {I32 n}  :  {numtype c_numtype}
[notation 5-reduction.watsup:150.51-150.54] I32  :  numtype
[elab 5-reduction.watsup:150.51-150.54] I32  :  numtype
[notation 5-reduction.watsup:150.51-150.54] {}  :  {}
[notation 5-reduction.watsup:150.45-150.56] {n}  :  {c_numtype}
[notation 5-reduction.watsup:150.55-150.56] n  :  c_numtype
[elab 5-reduction.watsup:150.55-150.56] n  :  c_numtype
[notation 5-reduction.watsup:150.45-150.56] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:150.58-150.74] ({TABLE.INIT x y})  :  admininstr*
[notation 5-reduction.watsup:150.58-150.74] ({TABLE.INIT x y})  :  admininstr
[notation 5-reduction.watsup:150.59-150.73] {TABLE.INIT x y}  :  admininstr
[elab 5-reduction.watsup:150.59-150.73] {TABLE.INIT x y}  :  admininstr
[notation 5-reduction.watsup:150.59-150.73] {x y}  :  {tableidx elemidx}
[notation 5-reduction.watsup:150.70-150.71] x  :  tableidx
[elab 5-reduction.watsup:150.70-150.71] x  :  tableidx
[notation 5-reduction.watsup:150.59-150.73] {y}  :  {elemidx}
[notation 5-reduction.watsup:150.72-150.73] y  :  elemidx
[elab 5-reduction.watsup:150.72-150.73] y  :  elemidx
[notation 5-reduction.watsup:150.59-150.73] {}  :  {}
[niteration 5-reduction.watsup:149.6-150.74]   :  admininstr*
[notation 5-reduction.watsup:154.3-154.47] z ; ({CALL x}) ~> ({CALL_ADDR $funcaddr(z)[x]})  :  config ~> admininstr*
[notation 5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  config
[elab 5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  config
[notation 5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  state ; admininstr*
[notation 5-reduction.watsup:154.3-154.4] z  :  state
[elab 5-reduction.watsup:154.3-154.4] z  :  state
[notation 5-reduction.watsup:154.6-154.14] ({CALL x})  :  admininstr*
[notation 5-reduction.watsup:154.7-154.13] {CALL x}  :  admininstr
[elab 5-reduction.watsup:154.7-154.13] {CALL x}  :  admininstr
[notation 5-reduction.watsup:154.7-154.13] {x}  :  {funcidx}
[notation 5-reduction.watsup:154.12-154.13] x  :  funcidx
[elab 5-reduction.watsup:154.12-154.13] x  :  funcidx
[notation 5-reduction.watsup:154.7-154.13] {}  :  {}
[notation 5-reduction.watsup:154.20-154.47] ({CALL_ADDR $funcaddr(z)[x]})  :  admininstr*
[notation 5-reduction.watsup:154.21-154.46] {CALL_ADDR $funcaddr(z)[x]}  :  admininstr
[elab 5-reduction.watsup:154.21-154.46] {CALL_ADDR $funcaddr(z)[x]}  :  admininstr
[notation 5-reduction.watsup:154.21-154.46] {$funcaddr(z)[x]}  :  {funcaddr}
[notation 5-reduction.watsup:154.31-154.46] $funcaddr(z)[x]  :  funcaddr
[elab 5-reduction.watsup:154.31-154.46] $funcaddr(z)[x]  :  funcaddr
[elab 5-reduction.watsup:154.31-154.43] $funcaddr(z)  :  funcaddr*
[elab 5-reduction.watsup:154.40-154.43] (z)  :  (state)
[elab 5-reduction.watsup:154.41-154.42] z  :  (state)
[elab 5-reduction.watsup:154.44-154.45] x  :  nat
[notation 5-reduction.watsup:154.21-154.46] {}  :  {}
[notation 5-reduction.watsup:157.3-157.59] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> ({CALL_ADDR a})  :  config ~> admininstr*
[notation 5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[elab 5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[notation 5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  state ; admininstr*
[notation 5-reduction.watsup:157.3-157.4] z  :  state
[elab 5-reduction.watsup:157.3-157.4] z  :  state
[notation 5-reduction.watsup:157.6-157.40] {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  admininstr*
[niteration 5-reduction.watsup:157.6-157.40] ({CONST I32 i}) ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:157.6-157.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:157.6-157.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:157.7-157.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:157.7-157.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:157.7-157.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:157.13-157.16] I32  :  numtype
[elab 5-reduction.watsup:157.13-157.16] I32  :  numtype
[notation 5-reduction.watsup:157.13-157.16] {}  :  {}
[notation 5-reduction.watsup:157.7-157.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:157.17-157.18] i  :  c_numtype
[elab 5-reduction.watsup:157.17-157.18] i  :  c_numtype
[notation 5-reduction.watsup:157.7-157.18] {}  :  {}
[niteration 5-reduction.watsup:157.6-157.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:157.20-157.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:157.20-157.40] ({CALL_INDIRECT x ft})  :  admininstr
[notation 5-reduction.watsup:157.21-157.39] {CALL_INDIRECT x ft}  :  admininstr
[elab 5-reduction.watsup:157.21-157.39] {CALL_INDIRECT x ft}  :  admininstr
[notation 5-reduction.watsup:157.21-157.39] {x ft}  :  {tableidx functype}
[notation 5-reduction.watsup:157.35-157.36] x  :  tableidx
[elab 5-reduction.watsup:157.35-157.36] x  :  tableidx
[notation 5-reduction.watsup:157.21-157.39] {ft}  :  {functype}
[notation 5-reduction.watsup:157.37-157.39] ft  :  functype
[elab 5-reduction.watsup:157.37-157.39] ft  :  functype
[notation 5-reduction.watsup:157.21-157.39] {}  :  {}
[niteration 5-reduction.watsup:157.6-157.40]   :  admininstr*
[notation 5-reduction.watsup:157.46-157.59] ({CALL_ADDR a})  :  admininstr*
[notation 5-reduction.watsup:157.47-157.58] {CALL_ADDR a}  :  admininstr
[elab 5-reduction.watsup:157.47-157.58] {CALL_ADDR a}  :  admininstr
[notation 5-reduction.watsup:157.47-157.58] {a}  :  {funcaddr}
[notation 5-reduction.watsup:157.57-157.58] a  :  funcaddr
[elab 5-reduction.watsup:157.57-157.58] a  :  funcaddr
[notation 5-reduction.watsup:157.47-157.58] {}  :  {}
[elab 5-reduction.watsup:158.9-158.44] $table(z, x)[i] = ({REF.FUNC_ADDR a})  :  bool
[elab 5-reduction.watsup:158.9-158.24] $table(z, x)[i]  :  ref
[elab 5-reduction.watsup:158.9-158.21] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:158.15-158.21] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:158.16-158.17] z  :  state
[elab 5-reduction.watsup:158.19-158.20] x  :  tableidx
[elab 5-reduction.watsup:158.22-158.23] i  :  nat
[elab 5-reduction.watsup:158.27-158.44] ({REF.FUNC_ADDR a})  :  ref
[elab 5-reduction.watsup:158.28-158.43] {REF.FUNC_ADDR a}  :  ref
[notation 5-reduction.watsup:158.28-158.43] {a}  :  {funcaddr}
[notation 5-reduction.watsup:158.42-158.43] a  :  funcaddr
[elab 5-reduction.watsup:158.42-158.43] a  :  funcaddr
[notation 5-reduction.watsup:158.28-158.43] {}  :  {}
[elab 5-reduction.watsup:159.9-159.34] $funcinst(z)[a] = m ; func  :  bool
[elab 5-reduction.watsup:159.9-159.24] $funcinst(z)[a]  :  funcinst
[elab 5-reduction.watsup:159.9-159.21] $funcinst(z)  :  funcinst*
[elab 5-reduction.watsup:159.18-159.21] (z)  :  (state)
[elab 5-reduction.watsup:159.19-159.20] z  :  (state)
[elab 5-reduction.watsup:159.22-159.23] a  :  nat
[elab 5-reduction.watsup:159.27-159.34] m ; func  :  funcinst
[notation 5-reduction.watsup:159.27-159.34] m ; func  :  moduleinst ; func
[notation 5-reduction.watsup:159.27-159.28] m  :  moduleinst
[elab 5-reduction.watsup:159.27-159.28] m  :  moduleinst
[notation 5-reduction.watsup:159.30-159.34] func  :  func
[elab 5-reduction.watsup:159.30-159.34] func  :  func
[notation 5-reduction.watsup:162.3-162.50] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> TRAP  :  config ~> admininstr*
[notation 5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[elab 5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[notation 5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  state ; admininstr*
[notation 5-reduction.watsup:162.3-162.4] z  :  state
[elab 5-reduction.watsup:162.3-162.4] z  :  state
[notation 5-reduction.watsup:162.6-162.40] {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  admininstr*
[niteration 5-reduction.watsup:162.6-162.40] ({CONST I32 i}) ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:162.6-162.19] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:162.6-162.19] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:162.7-162.18] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:162.7-162.18] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:162.7-162.18] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:162.13-162.16] I32  :  numtype
[elab 5-reduction.watsup:162.13-162.16] I32  :  numtype
[notation 5-reduction.watsup:162.13-162.16] {}  :  {}
[notation 5-reduction.watsup:162.7-162.18] {i}  :  {c_numtype}
[notation 5-reduction.watsup:162.17-162.18] i  :  c_numtype
[elab 5-reduction.watsup:162.17-162.18] i  :  c_numtype
[notation 5-reduction.watsup:162.7-162.18] {}  :  {}
[niteration 5-reduction.watsup:162.6-162.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:162.20-162.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation 5-reduction.watsup:162.20-162.40] ({CALL_INDIRECT x ft})  :  admininstr
[notation 5-reduction.watsup:162.21-162.39] {CALL_INDIRECT x ft}  :  admininstr
[elab 5-reduction.watsup:162.21-162.39] {CALL_INDIRECT x ft}  :  admininstr
[notation 5-reduction.watsup:162.21-162.39] {x ft}  :  {tableidx functype}
[notation 5-reduction.watsup:162.35-162.36] x  :  tableidx
[elab 5-reduction.watsup:162.35-162.36] x  :  tableidx
[notation 5-reduction.watsup:162.21-162.39] {ft}  :  {functype}
[notation 5-reduction.watsup:162.37-162.39] ft  :  functype
[elab 5-reduction.watsup:162.37-162.39] ft  :  functype
[notation 5-reduction.watsup:162.21-162.39] {}  :  {}
[niteration 5-reduction.watsup:162.6-162.40]   :  admininstr*
[notation 5-reduction.watsup:162.46-162.50] TRAP  :  admininstr*
[notation 5-reduction.watsup:162.46-162.50] TRAP  :  admininstr
[elab 5-reduction.watsup:162.46-162.50] TRAP  :  admininstr
[notation 5-reduction.watsup:162.46-162.50] {}  :  {}
[notation 5-reduction.watsup:166.3-166.115] z ; {val^k ({CALL_ADDR a})} ~> ({FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})})  :  config ~> admininstr*
[notation 5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  config
[elab 5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  config
[notation 5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  state ; admininstr*
[notation 5-reduction.watsup:166.3-166.4] z  :  state
[elab 5-reduction.watsup:166.3-166.4] z  :  state
[notation 5-reduction.watsup:166.6-166.25] {val^k ({CALL_ADDR a})}  :  admininstr*
[niteration 5-reduction.watsup:166.6-166.25] val^k ({CALL_ADDR a})  :  admininstr*
[notation 5-reduction.watsup:166.6-166.11] val^k  :  admininstr*
[notation 5-reduction.watsup:166.6-166.9] val  :  admininstr
[elab 5-reduction.watsup:166.6-166.9] val  :  admininstr
[elab 5-reduction.watsup:166.10-166.11] k  :  nat
[niteration 5-reduction.watsup:166.6-166.25] ({CALL_ADDR a})  :  admininstr*
[notation 5-reduction.watsup:166.12-166.25] ({CALL_ADDR a})  :  admininstr*
[notation 5-reduction.watsup:166.12-166.25] ({CALL_ADDR a})  :  admininstr
[notation 5-reduction.watsup:166.13-166.24] {CALL_ADDR a}  :  admininstr
[elab 5-reduction.watsup:166.13-166.24] {CALL_ADDR a}  :  admininstr
[notation 5-reduction.watsup:166.13-166.24] {a}  :  {funcaddr}
[notation 5-reduction.watsup:166.23-166.24] a  :  funcaddr
[elab 5-reduction.watsup:166.23-166.24] a  :  funcaddr
[notation 5-reduction.watsup:166.13-166.24] {}  :  {}
[niteration 5-reduction.watsup:166.6-166.25]   :  admininstr*
[notation 5-reduction.watsup:166.31-166.115] ({FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})})  :  admininstr*
[notation 5-reduction.watsup:166.32-166.114] {FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  admininstr
[elab 5-reduction.watsup:166.32-166.114] {FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  admininstr
[notation 5-reduction.watsup:166.32-166.114] {n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  {n `{frame} admininstr*}
[notation 5-reduction.watsup:166.39-166.40] n  :  n
[elab 5-reduction.watsup:166.39-166.40] n  :  n
[notation 5-reduction.watsup:166.32-166.114] {`{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  {`{frame} admininstr*}
[notation 5-reduction.watsup:166.41-166.85] `{{LOCAL {val^k ($default_(t))*}, MODULE m}}  :  `{frame}
[notation 5-reduction.watsup:166.44-166.83] {LOCAL {val^k ($default_(t))*}, MODULE m}  :  frame
[elab 5-reduction.watsup:166.44-166.83] {LOCAL {val^k ($default_(t))*}, MODULE m}  :  frame
[notation 5-reduction.watsup:166.51-166.72] {val^k ($default_(t))*}  :  val*
[niteration 5-reduction.watsup:166.51-166.72] val^k ($default_(t))*  :  val*
[notation 5-reduction.watsup:166.51-166.56] val^k  :  val*
[notation 5-reduction.watsup:166.51-166.54] val  :  val
[elab 5-reduction.watsup:166.51-166.54] val  :  val
[elab 5-reduction.watsup:166.55-166.56] k  :  nat
[niteration 5-reduction.watsup:166.51-166.72] ($default_(t))*  :  val*
[notation 5-reduction.watsup:166.57-166.72] ($default_(t))*  :  val*
[notation 5-reduction.watsup:166.57-166.71] ($default_(t))  :  val
[notation 5-reduction.watsup:166.58-166.70] $default_(t)  :  val
[elab 5-reduction.watsup:166.58-166.70] $default_(t)  :  val
[elab 5-reduction.watsup:166.67-166.70] (t)  :  (valtype)
[elab 5-reduction.watsup:166.68-166.69] t  :  (valtype)
[niteration 5-reduction.watsup:166.51-166.72]   :  val*
[notation 5-reduction.watsup:166.81-166.82] m  :  moduleinst
[elab 5-reduction.watsup:166.81-166.82] m  :  moduleinst
[notation 5-reduction.watsup:166.32-166.114] {({LABEL_ n `{epsilon} instr*})}  :  {admininstr*}
[notation 5-reduction.watsup:166.32-166.114] {({LABEL_ n `{epsilon} instr*})}  :  admininstr*
[elab 5-reduction.watsup:166.86-166.114] ({LABEL_ n `{epsilon} instr*})  :  admininstr*
[elab 5-reduction.watsup:166.87-166.113] {LABEL_ n `{epsilon} instr*}  :  admininstr*
[notation 5-reduction.watsup:166.87-166.113] {n `{epsilon} instr*}  :  {n `{instr*} admininstr*}
[notation 5-reduction.watsup:166.94-166.95] n  :  n
[elab 5-reduction.watsup:166.94-166.95] n  :  n
[notation 5-reduction.watsup:166.87-166.113] {`{epsilon} instr*}  :  {`{instr*} admininstr*}
[notation 5-reduction.watsup:166.96-166.106] `{epsilon}  :  `{instr*}
[notation 5-reduction.watsup:166.98-166.105] epsilon  :  instr*
[niteration 5-reduction.watsup:166.98-166.105]   :  instr*
[notation 5-reduction.watsup:166.87-166.113] {instr*}  :  {admininstr*}
[notation 5-reduction.watsup:166.87-166.113] {instr*}  :  admininstr*
[elab 5-reduction.watsup:166.107-166.113] instr*  :  admininstr*
[elab 5-reduction.watsup:166.107-166.112] instr  :  admininstr
[elab 5-reduction.watsup:167.9-167.61] $funcinst(z)[a] = m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  bool
[elab 5-reduction.watsup:167.9-167.24] $funcinst(z)[a]  :  funcinst
[elab 5-reduction.watsup:167.9-167.21] $funcinst(z)  :  funcinst*
[elab 5-reduction.watsup:167.18-167.21] (z)  :  (state)
[elab 5-reduction.watsup:167.19-167.20] z  :  (state)
[elab 5-reduction.watsup:167.22-167.23] a  :  nat
[elab 5-reduction.watsup:167.27-167.61] m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  funcinst
[notation 5-reduction.watsup:167.27-167.61] m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  moduleinst ; func
[notation 5-reduction.watsup:167.27-167.28] m  :  moduleinst
[elab 5-reduction.watsup:167.27-167.28] m  :  moduleinst
[notation 5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  func
[elab 5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  func
[notation 5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  {FUNC functype valtype* expr}
[notation 5-reduction.watsup:167.30-167.34] FUNC  :  FUNC
[notation 5-reduction.watsup:167.30-167.61] {(t_1^k -> t_2^n) t* instr*}  :  {functype valtype* expr}
[notation 5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  functype
[elab 5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  functype
[notation 5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation 5-reduction.watsup:167.36-167.41] t_1^k  :  resulttype
[elab 5-reduction.watsup:167.36-167.41] t_1^k  :  resulttype
[elab 5-reduction.watsup:167.36-167.39] t_1  :  valtype
[elab 5-reduction.watsup:167.40-167.41] k  :  nat
[notation 5-reduction.watsup:167.45-167.50] t_2^n  :  resulttype
[elab 5-reduction.watsup:167.45-167.50] t_2^n  :  resulttype
[elab 5-reduction.watsup:167.45-167.48] t_2  :  valtype
[elab 5-reduction.watsup:167.49-167.50] n  :  nat
[notation 5-reduction.watsup:167.30-167.61] {t* instr*}  :  {valtype* expr}
[notation 5-reduction.watsup:167.52-167.54] t*  :  valtype*
[notation 5-reduction.watsup:167.52-167.53] t  :  valtype
[elab 5-reduction.watsup:167.52-167.53] t  :  valtype
[notation 5-reduction.watsup:167.30-167.61] {instr*}  :  {expr}
[notation 5-reduction.watsup:167.55-167.61] instr*  :  expr
[elab 5-reduction.watsup:167.55-167.61] instr*  :  expr
[elab 5-reduction.watsup:167.55-167.60] instr  :  instr
[notation 5-reduction.watsup:167.30-167.61] {}  :  {}
[elab 5-reduction.watsup:167.40-167.41] k  :  nat
[elab 5-reduction.watsup:167.49-167.50] n  :  nat
[elab 5-reduction.watsup:166.55-166.56] k  :  nat
[notation 5-reduction.watsup:170.3-170.60] z ; {val ({LOCAL.SET x})} ~> $with_local(z, x, val) ; epsilon  :  config ~> config
[notation 5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  config
[elab 5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  config
[notation 5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:170.3-170.4] z  :  state
[elab 5-reduction.watsup:170.3-170.4] z  :  state
[notation 5-reduction.watsup:170.7-170.24] {val ({LOCAL.SET x})}  :  admininstr*
[niteration 5-reduction.watsup:170.7-170.24] val ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:170.7-170.10] val  :  admininstr*
[notation 5-reduction.watsup:170.7-170.10] val  :  admininstr
[elab 5-reduction.watsup:170.7-170.10] val  :  admininstr
[niteration 5-reduction.watsup:170.7-170.24] ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:170.11-170.24] ({LOCAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:170.11-170.24] ({LOCAL.SET x})  :  admininstr
[notation 5-reduction.watsup:170.12-170.23] {LOCAL.SET x}  :  admininstr
[elab 5-reduction.watsup:170.12-170.23] {LOCAL.SET x}  :  admininstr
[notation 5-reduction.watsup:170.12-170.23] {x}  :  {localidx}
[notation 5-reduction.watsup:170.22-170.23] x  :  localidx
[elab 5-reduction.watsup:170.22-170.23] x  :  localidx
[notation 5-reduction.watsup:170.12-170.23] {}  :  {}
[niteration 5-reduction.watsup:170.7-170.24]   :  admininstr*
[notation 5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  config
[elab 5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  config
[notation 5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  state ; admininstr*
[notation 5-reduction.watsup:170.28-170.50] $with_local(z, x, val)  :  state
[elab 5-reduction.watsup:170.28-170.50] $with_local(z, x, val)  :  state
[elab 5-reduction.watsup:170.39-170.50] (z, x, val)  :  (state, localidx, val)
[elab 5-reduction.watsup:170.40-170.41] z  :  state
[elab 5-reduction.watsup:170.43-170.44] x  :  localidx
[elab 5-reduction.watsup:170.46-170.49] val  :  val
[notation 5-reduction.watsup:170.53-170.60] epsilon  :  admininstr*
[niteration 5-reduction.watsup:170.53-170.60]   :  admininstr*
[notation 5-reduction.watsup:173.3-173.62] z ; {val ({GLOBAL.SET x})} ~> $with_global(z, x, val) ; epsilon  :  config ~> config
[notation 5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  config
[elab 5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  config
[notation 5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:173.3-173.4] z  :  state
[elab 5-reduction.watsup:173.3-173.4] z  :  state
[notation 5-reduction.watsup:173.7-173.25] {val ({GLOBAL.SET x})}  :  admininstr*
[niteration 5-reduction.watsup:173.7-173.25] val ({GLOBAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:173.7-173.10] val  :  admininstr*
[notation 5-reduction.watsup:173.7-173.10] val  :  admininstr
[elab 5-reduction.watsup:173.7-173.10] val  :  admininstr
[niteration 5-reduction.watsup:173.7-173.25] ({GLOBAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:173.11-173.25] ({GLOBAL.SET x})  :  admininstr*
[notation 5-reduction.watsup:173.11-173.25] ({GLOBAL.SET x})  :  admininstr
[notation 5-reduction.watsup:173.12-173.24] {GLOBAL.SET x}  :  admininstr
[elab 5-reduction.watsup:173.12-173.24] {GLOBAL.SET x}  :  admininstr
[notation 5-reduction.watsup:173.12-173.24] {x}  :  {globalidx}
[notation 5-reduction.watsup:173.23-173.24] x  :  globalidx
[elab 5-reduction.watsup:173.23-173.24] x  :  globalidx
[notation 5-reduction.watsup:173.12-173.24] {}  :  {}
[niteration 5-reduction.watsup:173.7-173.25]   :  admininstr*
[notation 5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  config
[elab 5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  config
[notation 5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  state ; admininstr*
[notation 5-reduction.watsup:173.29-173.52] $with_global(z, x, val)  :  state
[elab 5-reduction.watsup:173.29-173.52] $with_global(z, x, val)  :  state
[elab 5-reduction.watsup:173.41-173.52] (z, x, val)  :  (state, globalidx, val)
[elab 5-reduction.watsup:173.42-173.43] z  :  state
[elab 5-reduction.watsup:173.45-173.46] x  :  globalidx
[elab 5-reduction.watsup:173.48-173.51] val  :  val
[notation 5-reduction.watsup:173.55-173.62] epsilon  :  admininstr*
[niteration 5-reduction.watsup:173.55-173.62]   :  admininstr*
[notation 5-reduction.watsup:176.3-176.77] z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> $with_table(z, x, i, ref) ; epsilon  :  config ~> config
[notation 5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[elab 5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[notation 5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:176.3-176.4] z  :  state
[elab 5-reduction.watsup:176.3-176.4] z  :  state
[notation 5-reduction.watsup:176.7-176.38] {({CONST I32 i}) ref ({TABLE.GET x})}  :  admininstr*
[niteration 5-reduction.watsup:176.7-176.38] ({CONST I32 i}) ref ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:176.7-176.20] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:176.7-176.20] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:176.8-176.19] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:176.8-176.19] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:176.8-176.19] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:176.14-176.17] I32  :  numtype
[elab 5-reduction.watsup:176.14-176.17] I32  :  numtype
[notation 5-reduction.watsup:176.14-176.17] {}  :  {}
[notation 5-reduction.watsup:176.8-176.19] {i}  :  {c_numtype}
[notation 5-reduction.watsup:176.18-176.19] i  :  c_numtype
[elab 5-reduction.watsup:176.18-176.19] i  :  c_numtype
[notation 5-reduction.watsup:176.8-176.19] {}  :  {}
[niteration 5-reduction.watsup:176.7-176.38] ref ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:176.21-176.24] ref  :  admininstr*
[notation 5-reduction.watsup:176.21-176.24] ref  :  admininstr
[elab 5-reduction.watsup:176.21-176.24] ref  :  admininstr
[niteration 5-reduction.watsup:176.7-176.38] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:176.25-176.38] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:176.25-176.38] ({TABLE.GET x})  :  admininstr
[notation 5-reduction.watsup:176.26-176.37] {TABLE.GET x}  :  admininstr
[elab 5-reduction.watsup:176.26-176.37] {TABLE.GET x}  :  admininstr
[notation 5-reduction.watsup:176.26-176.37] {x}  :  {tableidx}
[notation 5-reduction.watsup:176.36-176.37] x  :  tableidx
[elab 5-reduction.watsup:176.36-176.37] x  :  tableidx
[notation 5-reduction.watsup:176.26-176.37] {}  :  {}
[niteration 5-reduction.watsup:176.7-176.38]   :  admininstr*
[notation 5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  config
[elab 5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  config
[notation 5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  state ; admininstr*
[notation 5-reduction.watsup:176.42-176.67] $with_table(z, x, i, ref)  :  state
[elab 5-reduction.watsup:176.42-176.67] $with_table(z, x, i, ref)  :  state
[elab 5-reduction.watsup:176.53-176.67] (z, x, i, ref)  :  (state, tableidx, n, ref)
[elab 5-reduction.watsup:176.54-176.55] z  :  state
[elab 5-reduction.watsup:176.57-176.58] x  :  tableidx
[elab 5-reduction.watsup:176.60-176.61] i  :  n
[elab 5-reduction.watsup:176.63-176.66] ref  :  ref
[notation 5-reduction.watsup:176.70-176.77] epsilon  :  admininstr*
[niteration 5-reduction.watsup:176.70-176.77]   :  admininstr*
[elab 5-reduction.watsup:177.9-177.27] i < |$table(z, x)|  :  bool
[elab 5-reduction.watsup:177.9-177.10] i  :  nat
[elab 5-reduction.watsup:177.13-177.27] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:177.14-177.26] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:177.20-177.26] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:177.21-177.22] z  :  state
[elab 5-reduction.watsup:177.24-177.25] x  :  tableidx
[notation 5-reduction.watsup:180.3-180.49] z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> z ; TRAP  :  config ~> config
[notation 5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[elab 5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[notation 5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  state ; admininstr*
[notation 5-reduction.watsup:180.3-180.4] z  :  state
[elab 5-reduction.watsup:180.3-180.4] z  :  state
[notation 5-reduction.watsup:180.7-180.38] {({CONST I32 i}) ref ({TABLE.GET x})}  :  admininstr*
[niteration 5-reduction.watsup:180.7-180.38] ({CONST I32 i}) ref ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:180.7-180.20] ({CONST I32 i})  :  admininstr*
[notation 5-reduction.watsup:180.7-180.20] ({CONST I32 i})  :  admininstr
[notation 5-reduction.watsup:180.8-180.19] {CONST I32 i}  :  admininstr
[elab 5-reduction.watsup:180.8-180.19] {CONST I32 i}  :  admininstr
[notation 5-reduction.watsup:180.8-180.19] {I32 i}  :  {numtype c_numtype}
[notation 5-reduction.watsup:180.14-180.17] I32  :  numtype
[elab 5-reduction.watsup:180.14-180.17] I32  :  numtype
[notation 5-reduction.watsup:180.14-180.17] {}  :  {}
[notation 5-reduction.watsup:180.8-180.19] {i}  :  {c_numtype}
[notation 5-reduction.watsup:180.18-180.19] i  :  c_numtype
[elab 5-reduction.watsup:180.18-180.19] i  :  c_numtype
[notation 5-reduction.watsup:180.8-180.19] {}  :  {}
[niteration 5-reduction.watsup:180.7-180.38] ref ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:180.21-180.24] ref  :  admininstr*
[notation 5-reduction.watsup:180.21-180.24] ref  :  admininstr
[elab 5-reduction.watsup:180.21-180.24] ref  :  admininstr
[niteration 5-reduction.watsup:180.7-180.38] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:180.25-180.38] ({TABLE.GET x})  :  admininstr*
[notation 5-reduction.watsup:180.25-180.38] ({TABLE.GET x})  :  admininstr
[notation 5-reduction.watsup:180.26-180.37] {TABLE.GET x}  :  admininstr
[elab 5-reduction.watsup:180.26-180.37] {TABLE.GET x}  :  admininstr
[notation 5-reduction.watsup:180.26-180.37] {x}  :  {tableidx}
[notation 5-reduction.watsup:180.36-180.37] x  :  tableidx
[elab 5-reduction.watsup:180.36-180.37] x  :  tableidx
[notation 5-reduction.watsup:180.26-180.37] {}  :  {}
[niteration 5-reduction.watsup:180.7-180.38]   :  admininstr*
[notation 5-reduction.watsup:180.42-180.49] z ; TRAP  :  config
[elab 5-reduction.watsup:180.42-180.49] z ; TRAP  :  config
[notation 5-reduction.watsup:180.42-180.49] z ; TRAP  :  state ; admininstr*
[notation 5-reduction.watsup:180.42-180.43] z  :  state
[elab 5-reduction.watsup:180.42-180.43] z  :  state
[notation 5-reduction.watsup:180.45-180.49] TRAP  :  admininstr*
[notation 5-reduction.watsup:180.45-180.49] TRAP  :  admininstr
[elab 5-reduction.watsup:180.45-180.49] TRAP  :  admininstr
[notation 5-reduction.watsup:180.45-180.49] {}  :  {}
[elab 5-reduction.watsup:181.9-181.28] i >= |$table(z, x)|  :  bool
[elab 5-reduction.watsup:181.9-181.10] i  :  nat
[elab 5-reduction.watsup:181.14-181.28] |$table(z, x)|  :  nat
[elab 5-reduction.watsup:181.15-181.27] $table(z, x)  :  tableinst
[elab 5-reduction.watsup:181.21-181.27] (z, x)  :  (state, tableidx)
[elab 5-reduction.watsup:181.22-181.23] z  :  state
[elab 5-reduction.watsup:181.25-181.26] x  :  tableidx
== Printing...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
syntax valtype =
  | numtype
  | vectype
  | reftype
  | BOT

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.69
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEMORY(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
syntax binop_IXX =
  | ADD
  | SUB
  | MUL
  | DIV(sx)
  | REM(sx)
  | AND
  | OR
  | XOR
  | SHL
  | SHR(sx)
  | ROTL
  | ROTR

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.55
rec {

;; 1-syntax.watsup:156.1-177.55
syntax instr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype?)
  | BLOCK(blocktype, instr*)
  | LOOP(blocktype, instr*)
  | IF(blocktype, instr*, instr*)
  | BR(labelidx)
  | BR_IF(labelidx)
  | BR_TABLE(labelidx*, labelidx)
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
  | LOCAL.GET(localidx)
  | LOCAL.SET(localidx)
  | LOCAL.TEE(localidx)
  | GLOBAL.GET(globalidx)
  | GLOBAL.SET(globalidx)
  | TABLE.GET(tableidx)
  | TABLE.SET(tableidx)
  | TABLE.SIZE(tableidx)
  | TABLE.GROW(tableidx)
  | TABLE.FILL(tableidx)
  | TABLE.COPY(tableidx, tableidx)
  | TABLE.INIT(tableidx, elemidx)
  | ELEM.DROP(elemidx)
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, nat, nat)
  | STORE(numtype, n?, nat, nat)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:185.1-185.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:186.1-186.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:188.1-189.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:190.1-191.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:192.1-193.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:194.1-195.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:196.1-197.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:198.1-199.26
syntax data = `DATA(*)%*%?`(byte**, datamode?)

;; 1-syntax.watsup:200.1-201.16
syntax start = START(funcidx)

;; 1-syntax.watsup:203.1-204.65
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEMORY(memidx)

;; 1-syntax.watsup:205.1-206.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:207.1-208.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:210.1-211.70
syntax module = `MODULE%*%*%*%*%*%*%*%*%*`(import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:5.1-5.55
def size : valtype -> nat
  ;; 2-aux.watsup:10.1-10.22
  def size(V128_valtype) = 128
  ;; 2-aux.watsup:9.1-9.20
  def size(F64_valtype) = 64
  ;; 2-aux.watsup:8.1-8.20
  def size(F32_valtype) = 32
  ;; 2-aux.watsup:7.1-7.20
  def size(I64_valtype) = 64
  ;; 2-aux.watsup:6.1-6.20
  def size(I32_valtype) = 32

;; 2-aux.watsup:15.1-15.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:16.1-16.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:18.1-18.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:19.1-19.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:21.1-30.39
syntax testfuse =
  | AB_(nat, nat, nat)
  | CD(nat, nat, nat)
  | EF(nat, nat, nat)
  | GH(nat, nat, nat)
  | IJ(nat, nat, nat)
  | KL(nat, nat, nat)
  | MN(nat, nat, nat)
  | OP(nat, nat, nat)
  | QR(nat, nat, nat)

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEMORY_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*, t_2*)
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEMORY_externtype(mt_1), MEMORY_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, t : valtype}:
    `%|-%:%`(C, STORE_instr(nt, n?, n_A, n_O), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(t) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(t) / 8))))?
    -- if ((n? = ?()) \/ (nt = (in <: numtype)))

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, t : valtype}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?, n_A, n_O), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(t) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(t) / 8))))?
    -- if ((n? = ?()) \/ (nt = (in <: numtype)))

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?, t))

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [(rt <: valtype)]))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr((fn_1 <: numtype), CONVERT_cvtop, (fn_2 <: numtype), ?()), `%->%`([(fn_2 <: valtype)], [(fn_1 <: valtype)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((in_1 <: numtype), CONVERT_cvtop, (in_2 <: numtype), sx?), `%->%`([(in_2 <: valtype)], [(in_1 <: valtype)]))
    -- if (in_1 =/= in_2)
    -- if ((sx? = ?()) <=> ($size(in_1 <: valtype) > $size(in_2 <: valtype)))

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1* :: [I32_valtype], t_2*))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*, t_2*))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*, t_2*))
    -- if (C.FUNC_context[x] = `%->%`(t_1*, t_2*))

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1* :: t*, t_2*))
    -- if (C.RETURN_context = ?(t*))

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*, l'), `%->%`(t_1* :: t*, t_2*))
    -- (Resulttype_sub: `|-%*<:%*`(t*, [(C.LABEL_context[l] <: valtype)]))*
    -- Resulttype_sub: `|-%*<:%*`(t*, [(C.LABEL_context[l'] <: valtype)])

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t* :: [I32_valtype], t*))
    -- if (C.LABEL_context[l] = t*)

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1* :: t*, t_2*))
    -- if (C.LABEL_context[l] = t*)

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2 : valtype}:
    `%|-%:%`(C, IF_instr(bt, instr_1*, instr_2*), `%->%`(t_1*, [t_2]))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*, [t_2]))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*, RETURN ?()}, instr_1*, `%->%`(t_1*, t_2*))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*, RETURN ?()}, instr_2*, `%->%`(t_1*, t_2*))

  ;; 3-typing.watsup:183.1-186.56
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2 : valtype}:
    `%|-%:%`(C, LOOP_instr(bt, instr*), `%->%`(t_1*, t_2*))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*, t_2*))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*, RETURN ?()}, instr*, `%->%`(t_1*, [t_2]))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*), `%->%`(t_1*, t_2*))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*, t_2*))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*, RETURN ?()}, instr*, `%->%`(t_1*, t_2*))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*, t_2*))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*, `%->%`(t* :: t_1*, t* :: t_2*))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*, `%->%`(t_1*, t_2*))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1 : valtype, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*, `%->%`([t'_1], t'_2*))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*, `%->%`(t_1*, t_2*))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*, t_1*)
    -- Resulttype_sub: `|-%*<:%*`(t_2*, t'_2*)

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*, `%->%`(t_1*, t_3*))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*, t_2*))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*, t_3*))

  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*, t*)
    -- InstrSeq_ok: `%|-%*:%`(C, instr*, `%->%`([], t*))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*)
    -- (Instr_const: `%|-%CONST`(C, instr))*

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*, expr), ft)
    -- if (ft = `%->%`(t_1*, t_2*))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1* :: t*, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*)}, expr, t_2*)

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:443.1-444.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

  ;; 3-typing.watsup:438.1-441.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*, elemmode?), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [(rt <: valtype)]))*
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:446.1-449.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:434.1-436.40
  rule _ {C : context, b** : byte**, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA(*)%*%?`(b**, datamode?))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:451.1-453.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:456.1-456.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:460.1-462.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:458.1-458.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:480.1-482.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY_externuse(x), MEMORY_externtype(mt))
    -- if (C.MEM_context[x] = mt)

  ;; 3-typing.watsup:476.1-478.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:472.1-474.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:468.1-470.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

;; 3-typing.watsup:457.1-457.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:464.1-466.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:485.1-485.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:487.1-499.22
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start* : start*, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*`(import*, func*, global*, table*, mem*, elem*, data^n, start*, export*))
    -- (Func_ok: `%|-%:%`(C, func, ft))*
    -- (Global_ok: `%|-%:%`(C, global, gt))*
    -- (Table_ok: `%|-%:%`(C, table, tt))*
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*
    -- (Data_ok: `%|-%:OK`(C, data))^n
    -- (Start_ok: `%|-%:OK`(C, start))*
    -- if (C = {FUNC ft*, GLOBAL gt*, TABLE tt*, MEM mt*, ELEM rt*, DATA OK^n, LOCAL [], LABEL [], RETURN ?()})
    -- if (|mem*| <= 1)
    -- if (|start*| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | num
  | ref

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val
  ;; 4-runtime.watsup:49.1-49.34
  def {rt : reftype} default_(rt <: valtype) = REF.NULL_val(rt)
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = CONST_val(F64_numtype, 0)
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = CONST_val(F32_numtype, 0)
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = CONST_val(I64_numtype, 0)
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = CONST_val(I32_numtype, 0)

;; 4-runtime.watsup:60.1-60.71
syntax exportinst = EXPORT(name, externval)

;; 4-runtime.watsup:70.1-77.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:54.1-54.66
syntax funcinst = `%;%`(moduleinst, func)

;; 4-runtime.watsup:55.1-55.53
syntax globalinst = val

;; 4-runtime.watsup:56.1-56.52
syntax tableinst = ref*

;; 4-runtime.watsup:57.1-57.52
syntax meminst = byte*

;; 4-runtime.watsup:58.1-58.53
syntax eleminst = ref*

;; 4-runtime.watsup:59.1-59.51
syntax datainst = byte*

;; 4-runtime.watsup:62.1-68.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:79.1-81.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:82.1-82.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:130.1-137.5
rec {

;; 4-runtime.watsup:130.1-137.5
syntax admininstr =
  | instr
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:83.1-83.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:98.1-98.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:99.1-99.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:101.1-101.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:102.1-102.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:104.1-104.61
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:105.1-105.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:107.1-107.59
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:108.1-108.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:110.1-110.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:111.1-111.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:113.1-113.65
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:114.1-114.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:116.1-116.62
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:117.1-117.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:119.1-119.76
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:120.1-120.50
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL[x] = v])

;; 4-runtime.watsup:122.1-122.79
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:123.1-123.69
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL[f.MODULE_frame.GLOBAL_moduleinst[x]] = v], f)

;; 4-runtime.watsup:125.1-125.84
def with_table : (state, tableidx, n, ref) -> state
  ;; 4-runtime.watsup:126.1-126.72
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE[f.MODULE_frame.TABLE_moduleinst[x]][i] = r], f)

;; 4-runtime.watsup:139.1-142.21
rec {

;; 4-runtime.watsup:139.1-142.21
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 5-reduction.watsup:86.1-88.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*, l')], [BR_admininstr(l')])
    -- if (i >= |l*|)

  ;; 5-reduction.watsup:82.1-84.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*, l')], [BR_admininstr(l*[i])])
    -- if (i < |l*|)

  ;; 5-reduction.watsup:77.1-79.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 5-reduction.watsup:73.1-75.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 5-reduction.watsup:69.1-70.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*, (val <: admininstr)* :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*)], (val <: admininstr)* :: [BR_admininstr(l)])

  ;; 5-reduction.watsup:66.1-67.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*, (val' <: admininstr)* :: (val <: admininstr)^n :: [BR_admininstr(0)] :: (instr <: admininstr)*)], (val <: admininstr)^n :: (instr' <: admininstr)*)

  ;; 5-reduction.watsup:61.1-63.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*, instr_2*)], [BLOCK_admininstr(bt, instr_2*)])
    -- if (c = 0)

  ;; 5-reduction.watsup:57.1-59.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*, instr_2*)], [BLOCK_admininstr(bt, instr_1*)])
    -- if (c =/= 0)

  ;; 5-reduction.watsup:53.1-55.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k :: [LOOP_admininstr(bt, instr*)], [LABEL__admininstr(n, [LOOP_instr(bt, instr*)], (val <: admininstr)^k :: (instr <: admininstr)*)])
    -- if (bt = `%->%`(t_1^k, t_2^n))

  ;; 5-reduction.watsup:49.1-51.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k :: [BLOCK_admininstr(bt, instr*)], [LABEL__admininstr(n, [], (val <: admininstr)^k :: (instr <: admininstr)*)])
    -- if (bt = `%->%`(t_1^k, t_2^n))

  ;; 5-reduction.watsup:46.1-47.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

  ;; 5-reduction.watsup:42.1-44.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?)], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 5-reduction.watsup:38.1-40.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?)], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 5-reduction.watsup:35.1-36.24
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 5-reduction.watsup:32.1-33.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 5-reduction.watsup:29.1-30.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 5-reduction.watsup:25.1-27.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 5-reduction.watsup:21.1-23.26
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

;; 5-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 5-reduction.watsup:165.1-167.61
  rule call_addr {a : addr, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, {LOCAL val^k :: $default_(t)*, MODULE m}, [LABEL__admininstr(n, [], (instr <: admininstr)*)])])
    -- if ($funcinst(z)[a] = `%;%`(m, `FUNC%%*%`(`%->%`(t_1^k, t_2^n), t*, instr*)))

  ;; 5-reduction.watsup:161.1-163.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 5-reduction.watsup:156.1-159.34
  rule call_indirect-call {a : addr, ft : functype, func : func, i : nat, m : moduleinst, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x)[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a] = `%;%`(m, func))

  ;; 5-reduction.watsup:153.1-154.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 5-reduction.watsup:147.1-151.15
  rule table.init-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n + 1)) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y)[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 5-reduction.watsup:144.1-146.15
  rule table.init-zero {i : nat, j : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, 0) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise

  ;; 5-reduction.watsup:141.1-143.62
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y)|) \/ ((j + n) > |$table(z, x)|))

  ;; 5-reduction.watsup:134.1-139.14
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n + 1)) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, (j + n)) CONST_admininstr(I32_numtype, (i + n)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)])
    -- if (j > i)

  ;; 5-reduction.watsup:128.1-133.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n + 1)) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)])
    -- if (j <= i)

  ;; 5-reduction.watsup:125.1-127.15
  rule table.copy-zero {i : nat, j : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, 0) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise

  ;; 5-reduction.watsup:122.1-124.63
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y)|) \/ ((j + n) > |$table(z, x)|))

  ;; 5-reduction.watsup:117.1-120.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, (n + 1)) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 5-reduction.watsup:114.1-116.15
  rule table.fill-zero {i : nat, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, 0) TABLE.FILL_admininstr(x)]), [])
    -- otherwise

  ;; 5-reduction.watsup:111.1-113.34
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x)|)

  ;; 5-reduction.watsup:107.1-109.27
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x)| = n)

  ;; 5-reduction.watsup:103.1-105.27
  rule table.get-lt {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x)[i] <: admininstr)])
    -- if (i < |$table(z, x)|)

  ;; 5-reduction.watsup:99.1-101.28
  rule table.get-ge {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x)|)

  ;; 5-reduction.watsup:96.1-97.37
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x) <: admininstr)])

  ;; 5-reduction.watsup:93.1-94.35
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [($local(z, x) <: admininstr)])

  ;; 5-reduction.watsup:90.1-91.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

;; 5-reduction.watsup:6.1-6.63
relation Step_write: `%~>%`(config, config)
  ;; 5-reduction.watsup:179.1-181.28
  rule table.set-ge {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.GET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x)|)

  ;; 5-reduction.watsup:175.1-177.27
  rule table.set-lt {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.GET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x)|)

  ;; 5-reduction.watsup:172.1-173.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 5-reduction.watsup:169.1-170.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

;; 5-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 5-reduction.watsup:16.1-18.42
  rule write {instr* : instr*, instr'* : instr*, z : state, z' : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*), `%;%*`(z', (instr' <: admininstr)*))
    -- Step_write: `%~>%`(`%;%*`(z, (instr <: admininstr)*), `%;%*`(z', (instr' <: admininstr)*))

  ;; 5-reduction.watsup:12.1-14.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*), `%;%*`(z, (instr' <: admininstr)*))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*), (instr' <: admininstr)*)

  ;; 5-reduction.watsup:8.1-10.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*), `%;%*`(z, (instr' <: admininstr)*))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*, (instr' <: admininstr)*)

== IL Validation...
== Latex Generation...
$$
\begin{array}{@{}lrrl@{}}
& \mathit{n} &::=& \mathit{nat} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(name)} & \mathit{name} &::=& \mathit{text} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(byte)} & \mathit{byte} &::=& \mathit{nat} \\
\mbox{(32-bit integer)} & \mathit{u{\scriptstyle32}} &::=& \mathit{nat} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(index)} & \mathit{idx} &::=& \mathit{nat} \\
\mbox{(function index)} & \mathit{funcidx} &::=& \mathit{idx} \\
\mbox{(global index)} & \mathit{globalidx} &::=& \mathit{idx} \\
\mbox{(table index)} & \mathit{tableidx} &::=& \mathit{idx} \\
\mbox{(memory index)} & \mathit{memidx} &::=& \mathit{idx} \\
\mbox{(elem index)} & \mathit{elemidx} &::=& \mathit{idx} \\
\mbox{(data index)} & \mathit{dataidx} &::=& \mathit{idx} \\
\mbox{(label index)} & \mathit{labelidx} &::=& \mathit{idx} \\
\mbox{(local index)} & \mathit{localidx} &::=& \mathit{idx} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(number type)} & \mathit{numtype} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & \mathit{vectype} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(reference type)} & \mathit{reftype} &::=& \mathsf{funcref} ~|~ \mathsf{externref} \\
\mbox{(value type)} & \mathit{valtype} &::=& \mathit{numtype} ~|~ \mathit{vectype} ~|~ \mathit{reftype} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{\mathit{n}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {\mathsf{f}}{\mathit{n}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(result type)} & \mathit{resulttype} &::=& {\mathit{valtype}^\ast} \\
\mbox{(limits)} & \mathit{limits} &::=& [\mathit{u{\scriptstyle32}} .. \mathit{u{\scriptstyle32}}] \\
\mbox{(global type)} & \mathit{globaltype} &::=& {\mathsf{mut}^?}~\mathit{valtype} \\
\mbox{(function type)} & \mathit{functype} &::=& \mathit{resulttype} \rightarrow \mathit{resulttype} \\
\mbox{(table type)} & \mathit{tabletype} &::=& \mathit{limits}~\mathit{reftype} \\
\mbox{(memory type)} & \mathit{memtype} &::=& \mathit{limits}~\mathsf{i{\scriptstyle8}} \\
\mbox{(element type)} & \mathit{elemtype} &::=& \mathit{reftype} \\
\mbox{(data type)} & \mathit{datatype} &::=& \mathsf{ok} \\
\mbox{(external type)} & \mathit{externtype} &::=& \mathsf{global}~\mathit{globaltype} ~|~ \mathsf{func}~\mathit{functype} ~|~ \mathsf{table}~\mathit{tabletype} ~|~ \mathsf{memory}~\mathit{memtype} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(signedness)} & \mathit{sx} &::=& \mathsf{u} ~|~ \mathsf{s} \\
& \mathit{unop}_{\mathsf{ixx}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
& \mathit{unop}_{\mathsf{fxx}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& \mathit{binop}_{\mathsf{ixx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{\mathsf{\mathit{sx}}} ~|~ {\mathsf{rem\_}}{\mathsf{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{\mathsf{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& \mathit{binop}_{\mathsf{fxx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
& \mathit{testop}_{\mathsf{ixx}} &::=& \mathsf{eqz} \\
& \mathit{testop}_{\mathsf{fxx}} &::=&  \\
& \mathit{relop}_{\mathsf{ixx}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{\mathsf{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{\mathsf{\mathit{sx}}} ~|~ {\mathsf{le\_}}{\mathsf{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{\mathsf{\mathit{sx}}} \\
& \mathit{relop}_{\mathsf{fxx}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& \mathit{unop}_{\mathit{numtype}} &::=& \mathit{unop}_{\mathsf{ixx}} ~|~ \mathit{unop}_{\mathsf{fxx}} \\
& \mathit{binop}_{\mathit{numtype}} &::=& \mathit{binop}_{\mathsf{ixx}} ~|~ \mathit{binop}_{\mathsf{fxx}} \\
& \mathit{testop}_{\mathit{numtype}} &::=& \mathit{testop}_{\mathsf{ixx}} ~|~ \mathit{testop}_{\mathsf{fxx}} \\
& \mathit{relop}_{\mathit{numtype}} &::=& \mathit{relop}_{\mathsf{ixx}} ~|~ \mathit{relop}_{\mathsf{fxx}} \\
& \mathit{cvtop} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& \mathit{c}_{\mathit{numtype}} &::=& \mathit{nat} \\
& \mathit{c}_{\mathit{vectype}} &::=& \mathit{nat} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(block type)} & \mathit{blocktype} &::=& \mathit{functype} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
& \mathit{instr} &::=& \mathsf{unreachable} \\ &&|&
\mathsf{nop} \\ &&|&
\mathsf{drop} \\ &&|&
\mathsf{select}~{\mathit{valtype}^?} \\ &&|&
\mathsf{block}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{loop}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{if}~\mathit{blocktype}~{\mathit{instr}^\ast}~\mathsf{else}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{br}~\mathit{labelidx} \\ &&|&
\mathsf{br\_if}~\mathit{labelidx} \\ &&|&
\mathsf{br\_table}~{\mathit{labelidx}^\ast}~\mathit{labelidx} \\ &&|&
\mathsf{call}~\mathit{funcidx} \\ &&|&
\mathsf{call\_indirect}~\mathit{tableidx}~\mathit{functype} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{\mathit{numtype}}.\mathsf{const}~\mathsf{\mathit{c}\_{\mathit{numtype}}} \\ &&|&
\mathsf{\mathit{numtype}} . \mathsf{\mathit{unop}\_{\mathit{numtype}}} \\ &&|&
\mathsf{\mathit{numtype}} . \mathsf{\mathit{binop}\_{\mathit{numtype}}} \\ &&|&
\mathsf{\mathit{numtype}} . \mathsf{\mathit{testop}\_{\mathit{numtype}}} \\ &&|&
\mathsf{\mathit{numtype}} . \mathsf{\mathit{relop}\_{\mathit{numtype}}} \\ &&|&
{\mathsf{\mathit{numtype}}.\mathsf{extend}}{\mathsf{\mathit{n}}} \\ &&|&
\mathsf{\mathit{numtype}} . {{{{\mathsf{\mathit{cvtop}}}{\mathsf{\_}}}{\mathsf{\mathit{numtype}}}}{\mathsf{\_}}}{\mathsf{{\mathit{sx}^?}}} \\ &&|&
\mathsf{ref.null}~\mathit{reftype} \\ &&|&
\mathsf{ref.func}~\mathit{funcidx} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
\mathsf{local.get}~\mathit{localidx} \\ &&|&
\mathsf{local.set}~\mathit{localidx} \\ &&|&
\mathsf{local.tee}~\mathit{localidx} \\ &&|&
\mathsf{global.get}~\mathit{globalidx} \\ &&|&
\mathsf{global.set}~\mathit{globalidx} \\ &&|&
\mathsf{table.get}~\mathit{tableidx} \\ &&|&
\mathsf{table.set}~\mathit{tableidx} \\ &&|&
\mathsf{table.size}~\mathit{tableidx} \\ &&|&
\mathsf{table.grow}~\mathit{tableidx} \\ &&|&
\mathsf{table.fill}~\mathit{tableidx} \\ &&|&
\mathsf{table.copy}~\mathit{tableidx}~\mathit{tableidx} \\ &&|&
\mathsf{table.init}~\mathit{tableidx}~\mathit{elemidx} \\ &&|&
\mathsf{elem.drop}~\mathit{elemidx} \\ &&|&
\mathsf{memory.size} \\ &&|&
\mathsf{memory.grow} \\ &&|&
\mathsf{memory.fill} \\ &&|&
\mathsf{memory.copy} \\ &&|&
\mathsf{memory.init}~\mathit{dataidx} \\ &&|&
\mathsf{data.drop}~\mathit{dataidx} \\ &&|&
{\mathsf{\mathit{numtype}}.\mathsf{load}}{\mathsf{{(\mathit{n}~\mathit{sx})^?}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{\mathsf{\mathit{numtype}}.\mathsf{store}}{\mathsf{{\mathit{n}^?}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\
\mbox{(expression)} & \mathit{expr} &::=& {\mathit{instr}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& \mathit{elemmode} &::=& \mathsf{table}~\mathit{tableidx}~\mathit{expr} ~|~ \mathsf{declare} \\
& \mathit{datamode} &::=& \mathsf{memory}~\mathit{memidx}~\mathit{expr} \\
\mbox{(function)} & \mathit{func} &::=& \mathsf{func}~\mathit{functype}~{\mathit{valtype}^\ast}~\mathit{expr} \\
\mbox{(global)} & \mathit{global} &::=& \mathsf{global}~\mathit{globaltype}~\mathit{expr} \\
\mbox{(table)} & \mathit{table} &::=& \mathsf{table}~\mathit{tabletype} \\
\mbox{(memory)} & \mathit{mem} &::=& \mathsf{memory}~\mathit{memtype} \\
\mbox{(table segment)} & \mathit{elem} &::=& \mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} \\
\mbox{(memory segment)} & \mathit{data} &::=& \mathsf{data}~{({\mathit{byte}^\ast})^\ast}~{\mathit{datamode}^?} \\
\mbox{(start function)} & \mathit{start} &::=& \mathsf{start}~\mathit{funcidx} \\
\mbox{(external use)} & \mathit{externuse} &::=& \mathsf{func}~\mathit{funcidx} ~|~ \mathsf{global}~\mathit{globalidx} ~|~ \mathsf{table}~\mathit{tableidx} ~|~ \mathsf{memory}~\mathit{memidx} \\
\mbox{(export)} & \mathit{export} &::=& \mathsf{export}~\mathit{name}~\mathit{externuse} \\
\mbox{(import)} & \mathit{import} &::=& \mathsf{import}~\mathit{name}~\mathit{name}~\mathit{externtype} \\
\mbox{(module)} & \mathit{module} &::=& \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^\ast}~{\mathit{start}^\ast}~{\mathit{export}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{i{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{f{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{f{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{v{\scriptstyle128}}|} &=& 128 &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{test}_{\mathit{sub}_{\mathsf{atom}_{22}}}(\mathit{n}_{3_{\mathsf{atom}_{\mathit{y}}}}) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{curried}}_{\mathit{n}_{1}}(\mathit{n}_{2}) &=& \mathit{n}_{1} + \mathit{n}_{2} &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
& \mathit{testfuse} &::=& {\mathsf{ab}}_{\mathit{nat}}\,\,\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{cd}}_{\mathsf{\mathit{nat}}}\,\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}} \\ &&|&
{\mathsf{ef\_}}{\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{{\mathsf{gh}}_{\mathsf{\mathit{nat}}}}{\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{{\mathsf{ij}}_{\mathsf{\mathit{nat}}}}{\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{\mathsf{kl\_ab}}{\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{\mathsf{mn\_}}{\mathsf{ab}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{{\mathsf{op\_}}{\mathsf{ab}}}{\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\ &&|&
{{\mathsf{qr}}_{\mathsf{\mathit{nat}}}}{\mathsf{ab}~\mathsf{\mathit{nat}}~\mathsf{\mathit{nat}}} \\
\mbox{(context)} & \mathit{context} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{functype}^\ast},\; \mathsf{global}~{\mathit{globaltype}^\ast},\; \mathsf{table}~{\mathit{tabletype}^\ast},\; \mathsf{mem}~{\mathit{memtype}^\ast},\; \\
  \mathsf{elem}~{\mathit{elemtype}^\ast},\; \mathsf{data}~{\mathit{datatype}^\ast},\; \\
  \mathsf{local}~{\mathit{valtype}^\ast},\; \mathsf{label}~{\mathit{resulttype}^\ast},\; \mathsf{return}~{\mathit{resulttype}^?} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{limits} : \mathit{nat}}$

$\boxed{{ \vdash }\;\mathit{functype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{globaltype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{tabletype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{memtype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{externtype} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n}_{1} \leq \mathit{n}_{2} \leq \mathit{k}
}{
{ \vdash }\;[\mathit{n}_{1} .. \mathit{n}_{2}] : \mathit{k}
} \, {[\textsc{\scriptsize K{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{ft} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{gt} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim} : {2^{32}} - 1
}{
{ \vdash }\;\mathit{lim}~\mathit{rt} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim} : {2^{16}}
}{
{ \vdash }\;\mathit{lim}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{functype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{func}~\mathit{functype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{globaltype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{global}~\mathit{globaltype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tabletype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{table}~\mathit{tabletype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{memtype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{memory}~\mathit{memtype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{valtype} \leq \mathit{valtype}}$

$\boxed{{ \vdash }\;{\mathit{valtype}^\ast} \leq {\mathit{valtype}^\ast}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{t} \leq \mathit{t}
} \, {[\textsc{\scriptsize S{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathsf{bot} \leq \mathit{t}
} \, {[\textsc{\scriptsize S{-}bot}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({ \vdash }\;\mathit{t}_{1} \leq \mathit{t}_{2})^\ast
}{
{ \vdash }\;{\mathit{t}_{1}^\ast} \leq {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize S{-}result}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{limits} \leq \mathit{limits}}$

$\boxed{{ \vdash }\;\mathit{functype} \leq \mathit{functype}}$

$\boxed{{ \vdash }\;\mathit{globaltype} \leq \mathit{globaltype}}$

$\boxed{{ \vdash }\;\mathit{tabletype} \leq \mathit{tabletype}}$

$\boxed{{ \vdash }\;\mathit{memtype} \leq \mathit{memtype}}$

$\boxed{{ \vdash }\;\mathit{externtype} \leq \mathit{externtype}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n}_{11} \geq \mathit{n}_{21}
 \qquad
\mathit{n}_{12} \leq \mathit{n}_{22}
}{
{ \vdash }\;[\mathit{n}_{11} .. \mathit{n}_{12}] \leq [\mathit{n}_{21} .. \mathit{n}_{22}]
} \, {[\textsc{\scriptsize S{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{ft} \leq \mathit{ft}
} \, {[\textsc{\scriptsize S{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{gt} \leq \mathit{gt}
} \, {[\textsc{\scriptsize S{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
}{
{ \vdash }\;\mathit{lim}_{1}~\mathit{rt} \leq \mathit{lim}_{2}~\mathit{rt}
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
}{
{ \vdash }\;\mathit{lim}_{1}~\mathsf{i{\scriptstyle8}} \leq \mathit{lim}_{2}~\mathsf{i{\scriptstyle8}}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{ft}_{1} \leq \mathit{ft}_{2}
}{
{ \vdash }\;\mathsf{func}~\mathit{ft}_{1} \leq \mathsf{func}~\mathit{ft}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{gt}_{1} \leq \mathit{gt}_{2}
}{
{ \vdash }\;\mathsf{global}~\mathit{gt}_{1} \leq \mathsf{global}~\mathit{gt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tt}_{1} \leq \mathit{tt}_{2}
}{
{ \vdash }\;\mathsf{table}~\mathit{tt}_{1} \leq \mathsf{table}~\mathit{tt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{mt}_{1} \leq \mathit{mt}_{2}
}{
{ \vdash }\;\mathsf{memory}~\mathit{mt}_{1} \leq \mathsf{memory}~\mathit{mt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{instr} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash {\mathit{instr}^\ast} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash \mathit{expr} : \mathit{resulttype}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : \epsilon \rightarrow {\mathit{t}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{instr}_{1} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C} \vdash \mathit{instr}_{2} : {\mathit{t}_{2}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
}{
\mathit{C} \vdash \mathit{instr}_{1}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
} \, {[\textsc{\scriptsize T*{-}seq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \\
{ \vdash }\;{{\mathit{t}'}_{1}^\ast} \leq {\mathit{t}_{1}^\ast}
 \qquad
{ \vdash }\;{\mathit{t}_{2}^\ast} \leq {{\mathit{t}'}_{2}^\ast}
\end{array}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}'}_{1} \rightarrow {{\mathit{t}'}_{2}^\ast}
} \, {[\textsc{\scriptsize T*{-}weak}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}~{\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}^\ast}~{\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T*{-}frame}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{unreachable} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{drop} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{select}~\mathit{t} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{t} \leq {\mathit{t}'}
 \qquad
{\mathit{t}'} = \mathit{numtype} \lor {\mathit{t}'} = \mathit{vectype}
}{
\mathit{C} \vdash \mathsf{select} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}select{-}impl}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{blocktype} : \mathit{functype}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{ft} : \mathsf{ok}
}{
\mathit{C} \vdash \mathit{ft} : \mathit{ft}
} \, {[\textsc{\scriptsize K{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{1}^\ast} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow \mathit{t}_{2}
}{
\mathit{C} \vdash \mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow \mathit{t}_{2}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}_{1}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow \mathit{t}_{2}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
}{
\mathit{C} \vdash \mathsf{br}~\mathit{l} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
}{
\mathit{C} \vdash \mathsf{br\_if}~\mathit{l} : {\mathit{t}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({ \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[\mathit{l}])^\ast
 \qquad
{ \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[{\mathit{l}'}]
}{
\mathit{C} \vdash \mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{return} = ({\mathit{t}^\ast})
}{
\mathit{C} \vdash \mathsf{return} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{call}~\mathit{x} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathsf{funcref}
 \qquad
\mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{call\_indirect}~\mathit{x}~\mathit{ft} : {\mathit{t}_{1}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt}.\mathsf{const}~\mathit{c}_{\mathit{nt}} : \epsilon \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{unop} : \mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{binop} : \mathit{nt}~\mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{testop} : \mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{relop} : \mathit{nt}~\mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n} \leq {|\mathit{nt}|}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{extend}}{\mathit{n}} : \mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}extend}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{nt}_{1} \neq \mathit{nt}_{2}
 \qquad
{|\mathit{nt}_{1}|} = {|\mathit{nt}_{2}|}
}{
\mathit{C} \vdash \mathsf{cvtop}~\mathit{nt}_{1}~\mathsf{reinterpret}~\mathit{nt}_{2} : \mathit{nt}_{2} \rightarrow \mathit{nt}_{1}
} \, {[\textsc{\scriptsize T{-}reinterpret}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{i}}{\mathit{n}}_{1} \neq {\mathsf{i}}{\mathit{n}}_{2}
 \qquad
{\mathit{sx}^?} = \epsilon \Leftrightarrow {|{\mathsf{i}}{\mathit{n}}_{1}|} > {|{\mathsf{i}}{\mathit{n}}_{2}|}
}{
\mathit{C} \vdash {\mathsf{i}}{\mathit{n}}_{1} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{\mathsf{i}}{\mathit{n}}_{2}}}{\mathsf{\_}}}{{\mathit{sx}^?}} : {\mathsf{i}}{\mathit{n}}_{2} \rightarrow {\mathsf{i}}{\mathit{n}}_{1}
} \, {[\textsc{\scriptsize T{-}convert{-}i}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{f}}{\mathit{n}}_{1} \neq {\mathsf{f}}{\mathit{n}}_{2}
}{
\mathit{C} \vdash \mathsf{cvtop}~{\mathsf{f}}{\mathit{n}}_{1}~\mathsf{convert}~{\mathsf{f}}{\mathit{n}}_{2} : {\mathsf{f}}{\mathit{n}}_{2} \rightarrow {\mathsf{f}}{\mathit{n}}_{1}
} \, {[\textsc{\scriptsize T{-}convert{-}f}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{ref.null}~\mathit{rt} : \epsilon \rightarrow \mathit{rt}
} \, {[\textsc{\scriptsize T{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
}{
\mathit{C} \vdash \mathsf{ref.func}~\mathit{x} : \epsilon \rightarrow \mathsf{funcref}
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{ref.is\_null} : \mathit{rt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.tee}~\mathit{x} : \mathit{t} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = {\mathsf{mut}^?}~\mathit{t}
}{
\mathit{C} \vdash \mathsf{global.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \mathsf{mut}~\mathit{t}
}{
\mathit{C} \vdash \mathsf{global.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.get}~\mathit{x} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{rt}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.set}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
}{
\mathit{C} \vdash \mathsf{table.size}~\mathit{x} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.grow}~\mathit{x} : \mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.fill}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}_{1}~\mathit{rt}
 \qquad
\mathit{C}.\mathsf{table}[\mathit{x}_{2}] = \mathit{lim}_{2}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.copy}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}~\mathit{rt}
 \qquad
\mathit{C}.\mathsf{elem}[\mathit{x}_{2}] = \mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.init}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{elem}[\mathit{x}] = \mathit{rt}
}{
\mathit{C} \vdash \mathsf{elem.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.size} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.grow} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.fill} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.copy} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
\mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{memory.init}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{data.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
{2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{t}|} / 8
 \qquad
({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{t}|} / 8)^?
 \qquad
{\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{load}}{{(\mathit{n}~\mathit{sx})^?}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}load}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
{2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{t}|} / 8
 \qquad
({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{t}|} / 8)^?
 \qquad
{\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{store}}{{\mathit{n}^?}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}} : \mathsf{i{\scriptstyle32}}~\mathit{nt} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{instr}~\mathsf{const}}$

$\boxed{\mathit{context} \vdash \mathit{expr}~\mathsf{const}}$

$\boxed{\mathit{context} \vdash \mathit{expr} : \mathit{valtype}~\mathsf{const}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathit{nt}.\mathsf{const}~\mathit{c})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathsf{ref.null}~\mathit{rt})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathsf{ref.func}~\mathit{x})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \epsilon~\mathit{t}
}{
\mathit{C} \vdash (\mathsf{global.get}~\mathit{x})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{instr}~\mathsf{const})^\ast
}{
\mathit{C} \vdash {\mathit{instr}^\ast}~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{expr} : \mathit{t}
 \qquad
\mathit{C} \vdash \mathit{expr}~\mathsf{const}
}{
\mathit{C} \vdash \mathit{expr} : \mathit{t}~\mathsf{const}
} \, {[\textsc{\scriptsize TC{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{func} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash \mathit{global} : \mathit{globaltype}}$

$\boxed{\mathit{context} \vdash \mathit{table} : \mathit{tabletype}}$

$\boxed{\mathit{context} \vdash \mathit{mem} : \mathit{memtype}}$

$\boxed{\mathit{context} \vdash \mathit{elem} : \mathit{reftype}}$

$\boxed{\mathit{context} \vdash \mathit{data} : \mathsf{ok}}$

$\boxed{\mathit{context} \vdash \mathit{elemmode} : \mathit{reftype}}$

$\boxed{\mathit{context} \vdash \mathit{datamode} : \mathsf{ok}}$

$\boxed{\mathit{context} \vdash \mathit{start} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
{ \vdash }\;\mathit{ft} : \mathsf{ok}
 \qquad
\mathit{C}, \mathsf{local}~{\mathit{t}_{1}^\ast}~{\mathit{t}^\ast}, \mathsf{label}~({\mathit{t}_{2}^\ast}), \mathsf{return}~({\mathit{t}_{2}^\ast}) \vdash \mathit{expr} : {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{func}~\mathit{ft}~{\mathit{t}^\ast}~\mathit{expr} : \mathit{ft}
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{gt} : \mathsf{ok}
 \qquad
\mathit{gt} = {\mathsf{mut}^?}~\mathit{t}
 \qquad
\mathit{C} \vdash \mathit{expr} : \mathit{t}~\mathsf{const}
}{
\mathit{C} \vdash \mathsf{global}~\mathit{gt}~\mathit{expr} : \mathit{gt}
} \, {[\textsc{\scriptsize T{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{table}~\mathit{tt} : \mathit{tt}
} \, {[\textsc{\scriptsize T{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{mt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{memory}~\mathit{mt} : \mathit{mt}
} \, {[\textsc{\scriptsize T{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{expr} : \mathit{rt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{elemmode} : \mathit{rt})^?
}{
\mathit{C} \vdash \mathsf{elem}~\mathit{rt}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{datamode} : \mathsf{ok})^?
}{
\mathit{C} \vdash \mathsf{data}~{{\mathit{b}^\ast}^\ast}~{\mathit{datamode}^?} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
 \qquad
(\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
\mathit{C} \vdash \mathsf{table}~\mathit{x}~\mathit{expr} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{declare} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
(\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
\mathit{C} \vdash \mathsf{memory}~0~\mathit{expr} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \epsilon \rightarrow \epsilon
}{
\mathit{C} \vdash \mathsf{start}~\mathit{x} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}start}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{import} : \mathit{externtype}}$

$\boxed{\mathit{context} \vdash \mathit{export} : \mathit{externtype}}$

$\boxed{\mathit{context} \vdash \mathit{externuse} : \mathit{externtype}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{xt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{import}~\mathit{name}_{1}~\mathit{name}_{2}~\mathit{xt} : \mathit{xt}
} \, {[\textsc{\scriptsize T{-}import}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{externuse} : \mathit{xt}
}{
\mathit{C} \vdash \mathsf{export}~\mathit{name}~\mathit{externuse} : \mathit{xt}
} \, {[\textsc{\scriptsize T{-}export}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
}{
\mathit{C} \vdash \mathsf{func}~\mathit{x} : \mathsf{func}~\mathit{ft}
} \, {[\textsc{\scriptsize T{-}externuse{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \mathit{gt}
}{
\mathit{C} \vdash \mathsf{global}~\mathit{x} : \mathsf{global}~\mathit{gt}
} \, {[\textsc{\scriptsize T{-}externuse{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
}{
\mathit{C} \vdash \mathsf{table}~\mathit{x} : \mathsf{table}~\mathit{tt}
} \, {[\textsc{\scriptsize T{-}externuse{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[\mathit{x}] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory}~\mathit{x} : \mathsf{memory}~\mathit{mt}
} \, {[\textsc{\scriptsize T{-}externuse{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{module} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{func} : \mathit{ft})^\ast
 \qquad
(\mathit{C} \vdash \mathit{global} : \mathit{gt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{table} : \mathit{tt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{mem} : \mathit{mt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{elem} : \mathit{rt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{data} : \mathsf{ok})^{\mathit{n}}
 \qquad
(\mathit{C} \vdash \mathit{start} : \mathsf{ok})^\ast
 \qquad
\mathit{C} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{ft}^\ast},\; \mathsf{global}~{\mathit{gt}^\ast},\; \mathsf{table}~{\mathit{tt}^\ast},\; \mathsf{mem}~{\mathit{mt}^\ast},\; \mathsf{elem}~{\mathit{rt}^\ast},\; \mathsf{data}~{\mathsf{ok}^{\mathit{n}}} \}\end{array}
 \qquad
{|{\mathit{mem}^\ast}|} \leq 1
 \qquad
{|{\mathit{start}^\ast}|} \leq 1
}{
{ \vdash }\;\mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^{\mathit{n}}}~{\mathit{start}^\ast}~{\mathit{export}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}module}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(address)} & \mathit{addr} &::=& \mathit{nat} \\
\mbox{(function address)} & \mathit{funcaddr} &::=& \mathit{addr} \\
\mbox{(global address)} & \mathit{globaladdr} &::=& \mathit{addr} \\
\mbox{(table address)} & \mathit{tableaddr} &::=& \mathit{addr} \\
\mbox{(memory address)} & \mathit{memaddr} &::=& \mathit{addr} \\
\mbox{(elem address)} & \mathit{elemaddr} &::=& \mathit{addr} \\
\mbox{(data address)} & \mathit{dataaddr} &::=& \mathit{addr} \\
\mbox{(label address)} & \mathit{labeladdr} &::=& \mathit{addr} \\
\mbox{(host address)} & \mathit{hostaddr} &::=& \mathit{addr} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(number)} & \mathit{num} &::=& \mathsf{\mathit{numtype}}.\mathsf{const}~\mathsf{\mathit{c}\_{\mathit{numtype}}} \\
\mbox{(reference)} & \mathit{ref} &::=& \mathsf{ref.null}~\mathit{reftype} ~|~ \mathsf{ref.func}~\mathsf{\mathit{funcaddr}} ~|~ \mathsf{ref.extern}~\mathsf{\mathit{hostaddr}} \\
\mbox{(value)} & \mathit{val} &::=& \mathit{num} ~|~ \mathit{ref} \\
\mbox{(result)} & \mathit{result} &::=& {\mathit{val}^\ast} ~|~ \mathsf{trap} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(external value)} & \mathit{externval} &::=& \mathsf{func}~\mathit{funcaddr} ~|~ \mathsf{global}~\mathit{globaladdr} ~|~ \mathsf{table}~\mathit{tableaddr} ~|~ \mathsf{mem}~\mathit{memaddr} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{default}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathit{rt}} &=& (\mathsf{ref.null}~\mathit{rt}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(function instance)} & \mathit{funcinst} &::=& \mathit{moduleinst} ; \mathit{func} \\
\mbox{(global instance)} & \mathit{globalinst} &::=& \mathit{val} \\
\mbox{(table instance)} & \mathit{tableinst} &::=& {\mathit{ref}^\ast} \\
\mbox{(memory instance)} & \mathit{meminst} &::=& {\mathit{byte}^\ast} \\
\mbox{(element instance)} & \mathit{eleminst} &::=& {\mathit{ref}^\ast} \\
\mbox{(data instance)} & \mathit{datainst} &::=& {\mathit{byte}^\ast} \\
\mbox{(export instance)} & \mathit{exportinst} &::=& \mathsf{export}~\mathit{name}~\mathit{externval} \\
\mbox{(store)} & \mathit{store} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{funcinst}^\ast},\; \\
  \mathsf{global}~{\mathit{globalinst}^\ast},\; \\
  \mathsf{table}~{\mathit{tableinst}^\ast},\; \\
  \mathsf{mem}~{\mathit{meminst}^\ast},\; \\
  \mathsf{elem}~{\mathit{eleminst}^\ast},\; \\
  \mathsf{data}~{\mathit{datainst}^\ast} \;\}\end{array} \\
\mbox{(module instance)} & \mathit{moduleinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{funcaddr}^\ast},\; \\
  \mathsf{global}~{\mathit{globaladdr}^\ast},\; \\
  \mathsf{table}~{\mathit{tableaddr}^\ast},\; \\
  \mathsf{mem}~{\mathit{memaddr}^\ast},\; \\
  \mathsf{elem}~{\mathit{elemaddr}^\ast},\; \\
  \mathsf{data}~{\mathit{dataaddr}^\ast},\; \\
  \mathsf{export}~{\mathit{exportinst}^\ast} \;\}\end{array} \\
\mbox{(frame)} & \mathit{frame} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{local}~{\mathit{val}^\ast},\; \\
  \mathsf{module}~\mathit{moduleinst} \;\}\end{array} \\
\mbox{(state)} & \mathit{state} &::=& \mathit{store} ; \mathit{frame} \\
\mbox{(configuration)} & \mathit{config} &::=& \mathit{state} ; {\mathit{instr}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{module}.\mathsf{func} &=& \mathit{f}.\mathsf{module}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{func} &=& \mathit{s}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{func}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{func}[\mathit{f}.\mathsf{module}.\mathsf{func}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{local}}{[\mathit{x}]} &=& \mathit{f}.\mathsf{local}[\mathit{x}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{global}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{table}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{elem}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{elem}[\mathit{f}.\mathsf{module}.\mathsf{elem}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f})}{[{\mathsf{local}}{[\mathit{x}]} = \mathit{v}]} &=& \mathit{s} ; \mathit{f}[\mathsf{local}[\mathit{x}] = \mathit{v}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f})}{[{\mathsf{global}}{[\mathit{x}]} = \mathit{v}]} &=& \mathit{s}[\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]] = \mathit{v}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f})}{[{{\mathsf{table}}{[\mathit{x}]}}{[\mathit{i}]} = \mathit{r}]} &=& \mathit{s}[\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]][\mathit{i}] = \mathit{r}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(administrative instruction)} & \mathit{instr} &::=& \mathit{instr} \\ &&|&
\mathsf{ref.func}~\mathsf{\mathit{funcaddr}} \\ &&|&
\mathsf{ref.extern}~\mathsf{\mathit{hostaddr}} \\ &&|&
\mathsf{call}~\mathsf{\mathit{funcaddr}} \\ &&|&
{{\mathsf{label}}_{\mathsf{\mathit{n}}}}{\mathsf{\{{\mathit{instr}^\ast}\}}~\mathsf{{\mathit{instr}^\ast}}} \\ &&|&
{{\mathsf{frame}}_{\mathsf{\mathit{n}}}}{\mathsf{\{\mathit{frame}\}}~\mathsf{{\mathit{instr}^\ast}}} \\ &&|&
\mathsf{trap} \\
\mbox{(evaluation context)} & \mathit{E} &::=& [\mathsf{\_}] \\ &&|&
{\mathit{val}^\ast}~\mathit{E}~{\mathit{instr}^\ast} \\ &&|&
{{\mathsf{label}}_{\mathsf{\mathit{n}}}}{\mathsf{\{{\mathit{instr}^\ast}\}}~\mathsf{\mathit{e}}} \\
\end{array}
$$

$\boxed{\mathit{config} \hookrightarrow \mathit{config}}$

$\boxed{{\mathit{instr}^\ast} \hookrightarrow {\mathit{instr}^\ast}}$

$\boxed{\mathit{config} \hookrightarrow {\mathit{instr}^\ast}}$

$\boxed{\mathit{config} \hookrightarrow \mathit{config}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~\mathit{z} ; {\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}write}]} \quad & \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& {\mathit{z}'} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~\mathit{z} ; {\mathit{instr}^\ast} \hookrightarrow {\mathit{z}'} ; {{\mathit{instr}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~\mathit{val} = \mathsf{ref.null}~\mathit{rt} \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon &  \\
{[\textsc{\scriptsize E{-}drop}]} \quad & \mathit{val}~\mathsf{drop} &\hookrightarrow& \epsilon &  \\
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{1} &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{2} &\quad
  \mbox{if}~\mathit{c} = 0 \\
{[\textsc{\scriptsize E{-}local.tee}]} \quad & \mathit{val}~(\mathsf{local.tee}~\mathit{x}) &\hookrightarrow& \mathit{val}~\mathit{val}~(\mathsf{local.set}~\mathit{x}) &  \\
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{n}}}{\{\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}\}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{1}^\ast}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{2}^\ast}) &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}~{{\mathit{val}'}^\ast}~{\mathit{val}^{\mathit{n}}}~(\mathsf{br}~0)~{\mathit{instr}^\ast}}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}}~{{\mathit{instr}'}^\ast} &  \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}~{\mathit{val}^\ast}~(\mathsf{br}~\mathit{l} + 1)~{\mathit{instr}^\ast}}) &\hookrightarrow& {\mathit{val}^\ast}~(\mathsf{br}~\mathit{l}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& (\mathsf{br}~\mathit{l}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}^\ast}[\mathit{i}]) &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{l}^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'}) &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{l}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.func}]} \quad & \mathit{z} ; (\mathsf{ref.func}~\mathit{x}) &\hookrightarrow& (\mathsf{ref.func}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
{[\textsc{\scriptsize E{-}local.get}]} \quad & \mathit{z} ; (\mathsf{local.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{local}}{[\mathit{x}]} &  \\
{[\textsc{\scriptsize E{-}global.get}]} \quad & \mathit{z} ; (\mathsf{global.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{global}}{[\mathit{x}]} &  \\
{[\textsc{\scriptsize E{-}table.get{-}ge}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.get{-}lt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{table}}{[\mathit{x}]}[\mathit{i}] &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.size}]} \quad & \mathit{z} ; (\mathsf{table.size}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n}) &\quad
  \mbox{if}~{|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} = \mathit{n} \\
{[\textsc{\scriptsize E{-}table.fill{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} + 1)~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}table.copy{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{y}]}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} + 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
  \mbox{if}~\mathit{j} \leq \mathit{i} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} + 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + \mathit{n})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + \mathit{n})~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
  \mbox{if}~\mathit{j} > \mathit{i} \\
{[\textsc{\scriptsize E{-}table.init{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}table.init{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} + 1)~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}[\mathit{i}]~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}call}]} \quad & \mathit{z} ; (\mathsf{call}~\mathit{x}) &\hookrightarrow& (\mathsf{call}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
{[\textsc{\scriptsize E{-}call\_indirect{-}call}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& (\mathsf{call}~\mathit{a}) &\quad
  \mbox{if}~{\mathit{z}.\mathsf{table}}{[\mathit{x}]}[\mathit{i}] = (\mathsf{ref.func}~\mathit{a}) \\
 &&&\quad {\land}~\mathit{z}.\mathsf{func}[\mathit{a}] = \mathit{m} ; \mathit{func} \\
{[\textsc{\scriptsize E{-}call\_indirect{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}call\_addr}]} \quad & \mathit{z} ; {\mathit{val}^{\mathit{k}}}~(\mathsf{call}~\mathit{a}) &\hookrightarrow& ({{\mathsf{frame}}_{\mathit{n}}}{\{\{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~{\mathit{val}^{\mathit{k}}}~{({\mathrm{default}}_{\mathit{t}})^\ast},\; \mathsf{module}~\mathit{m} \}\end{array}\}~({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}~{\mathit{instr}^\ast}})}) &\quad
  \mbox{if}~\mathit{z}.\mathsf{func}[\mathit{a}] = \mathit{m} ; \mathsf{func}~({\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}})~{\mathit{t}^\ast}~{\mathit{instr}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{local.set}~\mathit{x}) &\hookrightarrow& {\mathit{z}}{[{\mathsf{local}}{[\mathit{x}]} = \mathit{val}]} ; \epsilon &  \\
{[\textsc{\scriptsize E{-}global.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{global.set}~\mathit{x}) &\hookrightarrow& {\mathit{z}}{[{\mathsf{global}}{[\mathit{x}]} = \mathit{val}]} ; \epsilon &  \\
{[\textsc{\scriptsize E{-}table.set{-}lt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}}{[{{\mathsf{table}}{[\mathit{x}]}}{[\mathit{i}]} = \mathit{ref}]} ; \epsilon &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
{[\textsc{\scriptsize E{-}table.set{-}ge}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}|} \\
\end{array}
$$


== Prose Generation...
{val REF.IS_NULL} ~> ({CONST I32 1})
    -- if val = {REF.NULL rt}
{val REF.IS_NULL} ~> ({CONST I32 0})
    -- otherwise
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. If val = {REF.NULL rt}, then:
  1) Push the value CONST I32 1 to the stack.
4. If otherwise, then:
  1) Push the value CONST I32 0 to the stack.

UNREACHABLE ~> TRAP
1. Trap.

NOP ~> epsilon
1. Do nothing.

{val DROP} ~> epsilon
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.

{val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_1
    -- if c =/= 0
{val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_2
    -- if c = 0
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 c}) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If c =/= 0, then:
  1) Push the value val_1 to the stack.
8. If c = 0, then:
  1) Push the value val_2 to the stack.

{val ({LOCAL.TEE x})} ~> {val val ({LOCAL.SET x})}
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction LOCAL.SET x.

{val^k ({BLOCK bt instr*})} ~> ({LABEL_ n `{epsilon} val^k instr*})
    -- if bt = t_1^k -> t_2^n
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val^k from the stack.
3. Let bt = t_1^k -> t_2^n.
4. Let L be the label whose arity is n and whose continuation is the end of this instruction.
5. Enter the block val^k instr* with label L.

{val^k ({LOOP bt instr*})} ~> ({LABEL_ n `{{LOOP bt instr*}} val^k instr*})
    -- if bt = t_1^k -> t_2^n
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val^k from the stack.
3. Let bt = t_1^k -> t_2^n.
4. Let L be the label whose arity is n and whose continuation is the start of this instruction.
5. Enter the block val^k instr* with label L.

{({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_1*})
    -- if c =/= 0
{({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_2*})
    -- if c = 0
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 c}) from the stack.
3. If c =/= 0, then:
  1) Execute the instruction BLOCK bt instr_1*.
4. If c = 0, then:
  1) Execute the instruction BLOCK bt instr_2*.

({LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}) ~> {val^n instr'*}
1. YET: Bubble-up semantics.
2. Push the values val^n to the stack.
3. Push the values instr'* to the stack.

({LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}) ~> {val* ({BR l})}
1. YET: Bubble-up semantics.
2. Push the values val* to the stack.
3. Execute the instruction BR l.

{({CONST I32 c}) ({BR_IF l})} ~> ({BR l})
    -- if c =/= 0
{({CONST I32 c}) ({BR_IF l})} ~> epsilon
    -- if c = 0
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 c}) from the stack.
3. If c =/= 0, then:
  1) Execute the instruction BR l.
4. If c = 0, then:
  1) Do nothing.

{({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l*[i]})
    -- if i < |l*|
{({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l'})
    -- if i >= |l*|
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 i}) from the stack.
3. If i < |l*|, then:
  1) Let tmp0 be l*[i].
  2) Execute the instruction BR tmp0.
4. If i >= |l*|, then:
  1) Execute the instruction BR l'.

z ; ({REF.FUNC x}) ~> ({REF.FUNC_ADDR $funcaddr(z)[x]})
1. Let tmp0 be the result of computing $funcaddr(z).
2. Let tmp1 be tmp0[x].
3. Push the value REF.FUNC_ADDR tmp1 to the stack.

z ; ({LOCAL.GET x}) ~> $local(z, x)
1. Let tmp0 be the result of computing $local(z, x).
2. Push the value tmp0 to the stack.

z ; ({GLOBAL.GET x}) ~> $global(z, x)
1. Let tmp0 be the result of computing $global(z, x).
2. Push the value tmp0 to the stack.

z ; {({CONST I32 i}) ({TABLE.GET x})} ~> TRAP
    -- if i >= |$table(z, x)|
z ; {({CONST I32 i}) ({TABLE.GET x})} ~> $table(z, x)[i]
    -- if i < |$table(z, x)|
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 i}) from the stack.
3. If i >= |$table(z, x)|, then:
  1) Trap.
4. If i < |$table(z, x)|, then:
  1) Let tmp0 be the result of computing $table(z, x).
  2) Let tmp1 be tmp0[i].
  3) Push the value tmp1 to the stack.

z ; ({TABLE.SIZE x}) ~> ({CONST I32 n})
    -- if |$table(z, x)| = n
1. Let |$table(z, x)| = n.
2. Push the value CONST I32 n to the stack.

z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})} ~> TRAP
    -- if i + n > |$table(z, x)|
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n}) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 i}) from the stack.
7. Let i + n > |$table(z, x)|.
8. Trap.

z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})} ~> epsilon
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 0}) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 i}) from the stack.

z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})} ~> {({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})}
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n + 1}) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 i}) from the stack.
7. Push the value CONST I32 i to the stack.
8. Push the value val to the stack.
9. Execute the instruction TABLE.SET x.
10. Push the value CONST I32 (i + 1) to the stack.
11. Push the value val to the stack.
12. Push the value CONST I32 n to the stack.
13. Execute the instruction TABLE.FILL x.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})} ~> TRAP
    -- if i + n > |$table(z, y)| \/ j + n > |$table(z, x)|
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.
7. Let i + n > |$table(z, y)| \/ j + n > |$table(z, x)|.
8. Trap.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})} ~> epsilon
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 0}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}
    -- if j <= i
z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}
    -- if j > i
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n + 1}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.
7. If j <= i, then:
  1) Push the value CONST I32 j to the stack.
  2) Push the value CONST I32 i to the stack.
  3) Execute the instruction TABLE.GET y.
  4) Execute the instruction TABLE.SET x.
  5) Push the value CONST I32 (j + 1) to the stack.
  6) Push the value CONST I32 (i + 1) to the stack.
  7) Push the value CONST I32 n to the stack.
  8) Execute the instruction TABLE.COPY x y.
8. If j > i, then:
  1) Push the value CONST I32 (j + n) to the stack.
  2) Push the value CONST I32 (i + n) to the stack.
  3) Execute the instruction TABLE.GET y.
  4) Execute the instruction TABLE.SET x.
  5) Push the value CONST I32 (j + 1) to the stack.
  6) Push the value CONST I32 (i + 1) to the stack.
  7) Push the value CONST I32 n to the stack.
  8) Execute the instruction TABLE.COPY x y.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})} ~> TRAP
    -- if i + n > |$elem(z, y)| \/ j + n > |$table(z, x)|
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.
7. Let i + n > |$elem(z, y)| \/ j + n > |$table(z, x)|.
8. Trap.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})} ~> epsilon
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 0}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.

z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})} ~> {({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})}
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 n + 1}) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value ({CONST I32 j}) from the stack.
7. Push the value CONST I32 j to the stack.
8. Let tmp0 be the result of computing $elem(z, y).
9. Let tmp1 be tmp0[i].
10. Push the value tmp1 to the stack.
11. Execute the instruction TABLE.SET x.
12. Push the value CONST I32 (j + 1) to the stack.
13. Push the value CONST I32 (i + 1) to the stack.
14. Push the value CONST I32 n to the stack.
15. Execute the instruction TABLE.INIT x y.

z ; ({CALL x}) ~> ({CALL_ADDR $funcaddr(z)[x]})
1. Let tmp0 be the result of computing $funcaddr(z).
2. Let tmp1 be tmp0[x].
3. Execute the instruction CALL_ADDR tmp1.

z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> ({CALL_ADDR a})
    -- if $table(z, x)[i] = ({REF.FUNC_ADDR a})
    -- if $funcinst(z)[a] = m ; func
z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> TRAP
    -- otherwise
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value ({CONST I32 i}) from the stack.
3. If $table(z, x)[i] = ({REF.FUNC_ADDR a}) and $funcinst(z)[a] = m ; func, then:
  1) Execute the instruction CALL_ADDR a.
4. If otherwise, then:
  1) Trap.

z ; {val^k ({CALL_ADDR a})} ~> ({FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})})
    -- if $funcinst(z)[a] = m ; {FUNC (t_1^k -> t_2^n) t* instr*}
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val^k from the stack.
3. Let $funcinst(z)[a] = m ; {FUNC (t_1^k -> t_2^n) t* instr*}.
4. Let F be the frame `{{LOCAL {val^k ($default_(t))*}, MODULE m}}.
5. Push the activation of F with the arity n to the stack.
6. Let L be the label whose arity is n and whose continuation is the end of this instruction.
7. Enter the block instr* with label L.

z ; {val ({LOCAL.SET x})} ~> $with_local(z, x, val) ; epsilon
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Perform $with_local(z, x, val).

z ; {val ({GLOBAL.SET x})} ~> $with_global(z, x, val) ; epsilon
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Perform $with_global(z, x, val).

z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> $with_table(z, x, i, ref) ; epsilon
    -- if i < |$table(z, x)|
z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> z ; TRAP
    -- if i >= |$table(z, x)|
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value ({CONST I32 i}) from the stack.
5. If i < |$table(z, x)|, then:
  1) Perform $with_table(z, x, i, ref).
6. If i >= |$table(z, x)|, then:
  1) Trap.


== Complete.
```
