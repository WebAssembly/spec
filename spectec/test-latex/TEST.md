# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/*.watsup -l -p -d spec-splice-in.tex -w)
== Parsing...
== Elaboration...
[elab ../spec/2-aux.watsup:5.10-5.19] (valtype)  :  (valtype)
[elab ../spec/2-aux.watsup:5.11-5.18] valtype  :  (valtype)
[elab ../spec/2-aux.watsup:6.10-6.15] (I32)  :  (valtype)
[elab ../spec/2-aux.watsup:6.11-6.14] I32  :  (valtype)
[notation ../spec/2-aux.watsup:6.11-6.14] {}  :  {}
[elab ../spec/2-aux.watsup:6.18-6.20] 32  :  nat
[elab ../spec/2-aux.watsup:7.10-7.15] (I64)  :  (valtype)
[elab ../spec/2-aux.watsup:7.11-7.14] I64  :  (valtype)
[notation ../spec/2-aux.watsup:7.11-7.14] {}  :  {}
[elab ../spec/2-aux.watsup:7.18-7.20] 64  :  nat
[elab ../spec/2-aux.watsup:8.10-8.15] (F32)  :  (valtype)
[elab ../spec/2-aux.watsup:8.11-8.14] F32  :  (valtype)
[notation ../spec/2-aux.watsup:8.11-8.14] {}  :  {}
[elab ../spec/2-aux.watsup:8.18-8.20] 32  :  nat
[elab ../spec/2-aux.watsup:9.10-9.15] (F64)  :  (valtype)
[elab ../spec/2-aux.watsup:9.11-9.14] F64  :  (valtype)
[notation ../spec/2-aux.watsup:9.11-9.14] {}  :  {}
[elab ../spec/2-aux.watsup:9.18-9.20] 64  :  nat
[elab ../spec/2-aux.watsup:10.10-10.16] (V128)  :  (valtype)
[elab ../spec/2-aux.watsup:10.11-10.15] V128  :  (valtype)
[notation ../spec/2-aux.watsup:10.11-10.15] {}  :  {}
[elab ../spec/2-aux.watsup:10.19-10.22] 128  :  nat
[elab ../spec/2-aux.watsup:15.22-15.34] (n_3_ATOM_y)  :  (n)
[elab ../spec/2-aux.watsup:15.23-15.33] n_3_ATOM_y  :  (n)
[elab ../spec/2-aux.watsup:16.22-16.34] (n_3_ATOM_y)  :  (n)
[elab ../spec/2-aux.watsup:16.23-16.33] n_3_ATOM_y  :  (n)
[elab ../spec/2-aux.watsup:16.37-16.38] 0  :  nat
[elab ../spec/2-aux.watsup:18.14-18.20] (n, n)  :  (n, n)
[elab ../spec/2-aux.watsup:18.15-18.16] n  :  n
[elab ../spec/2-aux.watsup:18.18-18.19] n  :  n
[elab ../spec/2-aux.watsup:19.14-19.24] (n_1, n_2)  :  (n, n)
[elab ../spec/2-aux.watsup:19.15-19.18] n_1  :  n
[elab ../spec/2-aux.watsup:19.20-19.23] n_2  :  n
[elab ../spec/2-aux.watsup:19.27-19.39] n_1 + n_2  :  nat
[elab ../spec/2-aux.watsup:19.29-19.32] n_1  :  nat
[elab ../spec/2-aux.watsup:19.35-19.38] n_2  :  nat
[notation ../spec/3-typing.watsup:23.3-23.23] {} |- `[n_1 .. n_2] : k  :  {} |- limits : nat
[notation ../spec/3-typing.watsup:23.3-23.5] {}  :  {}
[notation ../spec/3-typing.watsup:23.6-23.23] `[n_1 .. n_2] : k  :  limits : nat
[notation ../spec/3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  limits
[elab ../spec/3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  limits
[notation ../spec/3-typing.watsup:23.6-23.19] `[n_1 .. n_2]  :  `[u32 .. u32]
[notation ../spec/3-typing.watsup:23.8-23.18] n_1 .. n_2  :  u32 .. u32
[notation ../spec/3-typing.watsup:23.8-23.11] n_1  :  u32
[elab ../spec/3-typing.watsup:23.8-23.11] n_1  :  u32
[notation ../spec/3-typing.watsup:23.15-23.18] n_2  :  u32
[elab ../spec/3-typing.watsup:23.15-23.18] n_2  :  u32
[notation ../spec/3-typing.watsup:23.22-23.23] k  :  nat
[elab ../spec/3-typing.watsup:23.22-23.23] k  :  nat
[elab ../spec/3-typing.watsup:24.9-24.24] n_1 <= n_2 <= k  :  bool
[elab ../spec/3-typing.watsup:24.9-24.12] n_1  :  nat
[elab ../spec/3-typing.watsup:24.16-24.19] n_2  :  nat
[elab ../spec/3-typing.watsup:24.16-24.24] n_2 <= k  :  bool
[elab ../spec/3-typing.watsup:24.16-24.19] n_2  :  nat
[elab ../spec/3-typing.watsup:24.23-24.24] k  :  nat
[notation ../spec/3-typing.watsup:27.3-27.13] {} |- ft : OK  :  {} |- functype : OK
[notation ../spec/3-typing.watsup:27.3-27.5] {}  :  {}
[notation ../spec/3-typing.watsup:27.6-27.13] ft : OK  :  functype : OK
[notation ../spec/3-typing.watsup:27.6-27.8] ft  :  functype
[elab ../spec/3-typing.watsup:27.6-27.8] ft  :  functype
[notation ../spec/3-typing.watsup:27.11-27.13] OK  :  OK
[notation ../spec/3-typing.watsup:30.3-30.13] {} |- gt : OK  :  {} |- globaltype : OK
[notation ../spec/3-typing.watsup:30.3-30.5] {}  :  {}
[notation ../spec/3-typing.watsup:30.6-30.13] gt : OK  :  globaltype : OK
[notation ../spec/3-typing.watsup:30.6-30.8] gt  :  globaltype
[elab ../spec/3-typing.watsup:30.6-30.8] gt  :  globaltype
[notation ../spec/3-typing.watsup:30.11-30.13] OK  :  OK
[notation ../spec/3-typing.watsup:33.3-33.17] {} |- {lim rt} : OK  :  {} |- tabletype : OK
[notation ../spec/3-typing.watsup:33.3-33.5] {}  :  {}
[notation ../spec/3-typing.watsup:33.6-33.17] {lim rt} : OK  :  tabletype : OK
[notation ../spec/3-typing.watsup:33.6-33.12] {lim rt}  :  tabletype
[elab ../spec/3-typing.watsup:33.6-33.12] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:33.6-33.12] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:33.6-33.9] lim  :  limits
[elab ../spec/3-typing.watsup:33.6-33.9] lim  :  limits
[notation ../spec/3-typing.watsup:33.6-33.12] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:33.10-33.12] rt  :  reftype
[elab ../spec/3-typing.watsup:33.10-33.12] rt  :  reftype
[notation ../spec/3-typing.watsup:33.6-33.12] {}  :  {}
[notation ../spec/3-typing.watsup:33.15-33.17] OK  :  OK
[notation ../spec/3-typing.watsup:34.17-34.35] {} |- lim : 2 ^ 32 - 1  :  {} |- limits : nat
[notation ../spec/3-typing.watsup:34.17-34.19] {}  :  {}
[notation ../spec/3-typing.watsup:34.20-34.35] lim : 2 ^ 32 - 1  :  limits : nat
[notation ../spec/3-typing.watsup:34.20-34.23] lim  :  limits
[elab ../spec/3-typing.watsup:34.20-34.23] lim  :  limits
[notation ../spec/3-typing.watsup:34.26-34.35] 2 ^ 32 - 1  :  nat
[elab ../spec/3-typing.watsup:34.26-34.35] 2 ^ 32 - 1  :  nat
[elab ../spec/3-typing.watsup:34.28-34.32] 2 ^ 32  :  nat
[elab ../spec/3-typing.watsup:34.28-34.29] 2  :  nat
[elab ../spec/3-typing.watsup:34.30-34.32] 32  :  nat
[elab ../spec/3-typing.watsup:34.33-34.34] 1  :  nat
[notation ../spec/3-typing.watsup:37.3-37.17] {} |- {lim I8} : OK  :  {} |- memtype : OK
[notation ../spec/3-typing.watsup:37.3-37.5] {}  :  {}
[notation ../spec/3-typing.watsup:37.6-37.17] {lim I8} : OK  :  memtype : OK
[notation ../spec/3-typing.watsup:37.6-37.12] {lim I8}  :  memtype
[elab ../spec/3-typing.watsup:37.6-37.12] {lim I8}  :  memtype
[notation ../spec/3-typing.watsup:37.6-37.12] {lim I8}  :  {limits I8}
[notation ../spec/3-typing.watsup:37.6-37.9] lim  :  limits
[elab ../spec/3-typing.watsup:37.6-37.9] lim  :  limits
[notation ../spec/3-typing.watsup:37.6-37.12] {I8}  :  {I8}
[notation ../spec/3-typing.watsup:37.10-37.12] I8  :  I8
[notation ../spec/3-typing.watsup:37.6-37.12] {}  :  {}
[notation ../spec/3-typing.watsup:37.15-37.17] OK  :  OK
[notation ../spec/3-typing.watsup:38.17-38.33] {} |- lim : 2 ^ 16  :  {} |- limits : nat
[notation ../spec/3-typing.watsup:38.17-38.19] {}  :  {}
[notation ../spec/3-typing.watsup:38.20-38.33] lim : 2 ^ 16  :  limits : nat
[notation ../spec/3-typing.watsup:38.20-38.23] lim  :  limits
[elab ../spec/3-typing.watsup:38.20-38.23] lim  :  limits
[notation ../spec/3-typing.watsup:38.26-38.33] 2 ^ 16  :  nat
[elab ../spec/3-typing.watsup:38.26-38.33] 2 ^ 16  :  nat
[elab ../spec/3-typing.watsup:38.28-38.29] 2  :  nat
[elab ../spec/3-typing.watsup:38.30-38.32] 16  :  nat
[notation ../spec/3-typing.watsup:42.3-42.24] {} |- {FUNC functype} : OK  :  {} |- externtype : OK
[notation ../spec/3-typing.watsup:42.3-42.5] {}  :  {}
[notation ../spec/3-typing.watsup:42.6-42.24] {FUNC functype} : OK  :  externtype : OK
[notation ../spec/3-typing.watsup:42.6-42.19] {FUNC functype}  :  externtype
[elab ../spec/3-typing.watsup:42.6-42.19] {FUNC functype}  :  externtype
[notation ../spec/3-typing.watsup:42.6-42.19] {functype}  :  {functype}
[notation ../spec/3-typing.watsup:42.11-42.19] functype  :  functype
[elab ../spec/3-typing.watsup:42.11-42.19] functype  :  functype
[notation ../spec/3-typing.watsup:42.6-42.19] {}  :  {}
[notation ../spec/3-typing.watsup:42.22-42.24] OK  :  OK
[notation ../spec/3-typing.watsup:43.19-43.35] {} |- functype : OK  :  {} |- functype : OK
[notation ../spec/3-typing.watsup:43.19-43.21] {}  :  {}
[notation ../spec/3-typing.watsup:43.22-43.35] functype : OK  :  functype : OK
[notation ../spec/3-typing.watsup:43.22-43.30] functype  :  functype
[elab ../spec/3-typing.watsup:43.22-43.30] functype  :  functype
[notation ../spec/3-typing.watsup:43.33-43.35] OK  :  OK
[notation ../spec/3-typing.watsup:46.3-46.28] {} |- {GLOBAL globaltype} : OK  :  {} |- externtype : OK
[notation ../spec/3-typing.watsup:46.3-46.5] {}  :  {}
[notation ../spec/3-typing.watsup:46.6-46.28] {GLOBAL globaltype} : OK  :  externtype : OK
[notation ../spec/3-typing.watsup:46.6-46.23] {GLOBAL globaltype}  :  externtype
[elab ../spec/3-typing.watsup:46.6-46.23] {GLOBAL globaltype}  :  externtype
[notation ../spec/3-typing.watsup:46.6-46.23] {globaltype}  :  {globaltype}
[notation ../spec/3-typing.watsup:46.13-46.23] globaltype  :  globaltype
[elab ../spec/3-typing.watsup:46.13-46.23] globaltype  :  globaltype
[notation ../spec/3-typing.watsup:46.6-46.23] {}  :  {}
[notation ../spec/3-typing.watsup:46.26-46.28] OK  :  OK
[notation ../spec/3-typing.watsup:47.21-47.39] {} |- globaltype : OK  :  {} |- globaltype : OK
[notation ../spec/3-typing.watsup:47.21-47.23] {}  :  {}
[notation ../spec/3-typing.watsup:47.24-47.39] globaltype : OK  :  globaltype : OK
[notation ../spec/3-typing.watsup:47.24-47.34] globaltype  :  globaltype
[elab ../spec/3-typing.watsup:47.24-47.34] globaltype  :  globaltype
[notation ../spec/3-typing.watsup:47.37-47.39] OK  :  OK
[notation ../spec/3-typing.watsup:50.3-50.26] {} |- {TABLE tabletype} : OK  :  {} |- externtype : OK
[notation ../spec/3-typing.watsup:50.3-50.5] {}  :  {}
[notation ../spec/3-typing.watsup:50.6-50.26] {TABLE tabletype} : OK  :  externtype : OK
[notation ../spec/3-typing.watsup:50.6-50.21] {TABLE tabletype}  :  externtype
[elab ../spec/3-typing.watsup:50.6-50.21] {TABLE tabletype}  :  externtype
[notation ../spec/3-typing.watsup:50.6-50.21] {tabletype}  :  {tabletype}
[notation ../spec/3-typing.watsup:50.12-50.21] tabletype  :  tabletype
[elab ../spec/3-typing.watsup:50.12-50.21] tabletype  :  tabletype
[notation ../spec/3-typing.watsup:50.6-50.21] {}  :  {}
[notation ../spec/3-typing.watsup:50.24-50.26] OK  :  OK
[notation ../spec/3-typing.watsup:51.20-51.37] {} |- tabletype : OK  :  {} |- tabletype : OK
[notation ../spec/3-typing.watsup:51.20-51.22] {}  :  {}
[notation ../spec/3-typing.watsup:51.23-51.37] tabletype : OK  :  tabletype : OK
[notation ../spec/3-typing.watsup:51.23-51.32] tabletype  :  tabletype
[elab ../spec/3-typing.watsup:51.23-51.32] tabletype  :  tabletype
[notation ../spec/3-typing.watsup:51.35-51.37] OK  :  OK
[notation ../spec/3-typing.watsup:54.3-54.25] {} |- {MEMORY memtype} : OK  :  {} |- externtype : OK
[notation ../spec/3-typing.watsup:54.3-54.5] {}  :  {}
[notation ../spec/3-typing.watsup:54.6-54.25] {MEMORY memtype} : OK  :  externtype : OK
[notation ../spec/3-typing.watsup:54.6-54.20] {MEMORY memtype}  :  externtype
[elab ../spec/3-typing.watsup:54.6-54.20] {MEMORY memtype}  :  externtype
[notation ../spec/3-typing.watsup:54.6-54.20] {memtype}  :  {memtype}
[notation ../spec/3-typing.watsup:54.13-54.20] memtype  :  memtype
[elab ../spec/3-typing.watsup:54.13-54.20] memtype  :  memtype
[notation ../spec/3-typing.watsup:54.6-54.20] {}  :  {}
[notation ../spec/3-typing.watsup:54.23-54.25] OK  :  OK
[notation ../spec/3-typing.watsup:55.18-55.33] {} |- memtype : OK  :  {} |- memtype : OK
[notation ../spec/3-typing.watsup:55.18-55.20] {}  :  {}
[notation ../spec/3-typing.watsup:55.21-55.33] memtype : OK  :  memtype : OK
[notation ../spec/3-typing.watsup:55.21-55.28] memtype  :  memtype
[elab ../spec/3-typing.watsup:55.21-55.28] memtype  :  memtype
[notation ../spec/3-typing.watsup:55.31-55.33] OK  :  OK
[notation ../spec/3-typing.watsup:65.3-65.12] {} |- t <: t  :  {} |- valtype <: valtype
[notation ../spec/3-typing.watsup:65.3-65.5] {}  :  {}
[notation ../spec/3-typing.watsup:65.6-65.12] t <: t  :  valtype <: valtype
[notation ../spec/3-typing.watsup:65.6-65.7] t  :  valtype
[elab ../spec/3-typing.watsup:65.6-65.7] t  :  valtype
[notation ../spec/3-typing.watsup:65.11-65.12] t  :  valtype
[elab ../spec/3-typing.watsup:65.11-65.12] t  :  valtype
[notation ../spec/3-typing.watsup:68.3-68.14] {} |- BOT <: t  :  {} |- valtype <: valtype
[notation ../spec/3-typing.watsup:68.3-68.5] {}  :  {}
[notation ../spec/3-typing.watsup:68.6-68.14] BOT <: t  :  valtype <: valtype
[notation ../spec/3-typing.watsup:68.6-68.9] BOT  :  valtype
[elab ../spec/3-typing.watsup:68.6-68.9] BOT  :  valtype
[notation ../spec/3-typing.watsup:68.6-68.9] {}  :  {}
[notation ../spec/3-typing.watsup:68.13-68.14] t  :  valtype
[elab ../spec/3-typing.watsup:68.13-68.14] t  :  valtype
[notation ../spec/3-typing.watsup:71.3-71.18] {} |- t_1* <: t_2*  :  {} |- valtype* <: valtype*
[notation ../spec/3-typing.watsup:71.3-71.5] {}  :  {}
[notation ../spec/3-typing.watsup:71.6-71.18] t_1* <: t_2*  :  valtype* <: valtype*
[notation ../spec/3-typing.watsup:71.6-71.10] t_1*  :  valtype*
[notation ../spec/3-typing.watsup:71.6-71.9] t_1  :  valtype
[elab ../spec/3-typing.watsup:71.6-71.9] t_1  :  valtype
[notation ../spec/3-typing.watsup:71.14-71.18] t_2*  :  valtype*
[notation ../spec/3-typing.watsup:71.14-71.17] t_2  :  valtype
[elab ../spec/3-typing.watsup:71.14-71.17] t_2  :  valtype
[notation ../spec/3-typing.watsup:72.20-72.33] {} |- t_1 <: t_2  :  {} |- valtype <: valtype
[notation ../spec/3-typing.watsup:72.20-72.22] {}  :  {}
[notation ../spec/3-typing.watsup:72.23-72.33] t_1 <: t_2  :  valtype <: valtype
[notation ../spec/3-typing.watsup:72.23-72.26] t_1  :  valtype
[elab ../spec/3-typing.watsup:72.23-72.26] t_1  :  valtype
[notation ../spec/3-typing.watsup:72.30-72.33] t_2  :  valtype
[elab ../spec/3-typing.watsup:72.30-72.33] t_2  :  valtype
[notation ../spec/3-typing.watsup:84.3-84.40] {} |- `[n_11 .. n_12] <: `[n_21 .. n_22]  :  {} |- limits <: limits
[notation ../spec/3-typing.watsup:84.3-84.5] {}  :  {}
[notation ../spec/3-typing.watsup:84.6-84.40] `[n_11 .. n_12] <: `[n_21 .. n_22]  :  limits <: limits
[notation ../spec/3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  limits
[elab ../spec/3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  limits
[notation ../spec/3-typing.watsup:84.6-84.21] `[n_11 .. n_12]  :  `[u32 .. u32]
[notation ../spec/3-typing.watsup:84.8-84.20] n_11 .. n_12  :  u32 .. u32
[notation ../spec/3-typing.watsup:84.8-84.12] n_11  :  u32
[elab ../spec/3-typing.watsup:84.8-84.12] n_11  :  u32
[notation ../spec/3-typing.watsup:84.16-84.20] n_12  :  u32
[elab ../spec/3-typing.watsup:84.16-84.20] n_12  :  u32
[notation ../spec/3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  limits
[elab ../spec/3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  limits
[notation ../spec/3-typing.watsup:84.25-84.40] `[n_21 .. n_22]  :  `[u32 .. u32]
[notation ../spec/3-typing.watsup:84.27-84.39] n_21 .. n_22  :  u32 .. u32
[notation ../spec/3-typing.watsup:84.27-84.31] n_21  :  u32
[elab ../spec/3-typing.watsup:84.27-84.31] n_21  :  u32
[notation ../spec/3-typing.watsup:84.35-84.39] n_22  :  u32
[elab ../spec/3-typing.watsup:84.35-84.39] n_22  :  u32
[elab ../spec/3-typing.watsup:85.9-85.21] n_11 >= n_21  :  bool
[elab ../spec/3-typing.watsup:85.9-85.13] n_11  :  nat
[elab ../spec/3-typing.watsup:85.17-85.21] n_21  :  nat
[elab ../spec/3-typing.watsup:86.9-86.21] n_12 <= n_22  :  bool
[elab ../spec/3-typing.watsup:86.9-86.13] n_12  :  nat
[elab ../spec/3-typing.watsup:86.17-86.21] n_22  :  nat
[notation ../spec/3-typing.watsup:89.3-89.14] {} |- ft <: ft  :  {} |- functype <: functype
[notation ../spec/3-typing.watsup:89.3-89.5] {}  :  {}
[notation ../spec/3-typing.watsup:89.6-89.14] ft <: ft  :  functype <: functype
[notation ../spec/3-typing.watsup:89.6-89.8] ft  :  functype
[elab ../spec/3-typing.watsup:89.6-89.8] ft  :  functype
[notation ../spec/3-typing.watsup:89.12-89.14] ft  :  functype
[elab ../spec/3-typing.watsup:89.12-89.14] ft  :  functype
[notation ../spec/3-typing.watsup:92.3-92.14] {} |- gt <: gt  :  {} |- globaltype <: globaltype
[notation ../spec/3-typing.watsup:92.3-92.5] {}  :  {}
[notation ../spec/3-typing.watsup:92.6-92.14] gt <: gt  :  globaltype <: globaltype
[notation ../spec/3-typing.watsup:92.6-92.8] gt  :  globaltype
[elab ../spec/3-typing.watsup:92.6-92.8] gt  :  globaltype
[notation ../spec/3-typing.watsup:92.12-92.14] gt  :  globaltype
[elab ../spec/3-typing.watsup:92.12-92.14] gt  :  globaltype
[notation ../spec/3-typing.watsup:95.3-95.26] {} |- {lim_1 rt} <: {lim_2 rt}  :  {} |- tabletype <: tabletype
[notation ../spec/3-typing.watsup:95.3-95.5] {}  :  {}
[notation ../spec/3-typing.watsup:95.6-95.26] {lim_1 rt} <: {lim_2 rt}  :  tabletype <: tabletype
[notation ../spec/3-typing.watsup:95.6-95.14] {lim_1 rt}  :  tabletype
[elab ../spec/3-typing.watsup:95.6-95.14] {lim_1 rt}  :  tabletype
[notation ../spec/3-typing.watsup:95.6-95.14] {lim_1 rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:95.6-95.11] lim_1  :  limits
[elab ../spec/3-typing.watsup:95.6-95.11] lim_1  :  limits
[notation ../spec/3-typing.watsup:95.6-95.14] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:95.12-95.14] rt  :  reftype
[elab ../spec/3-typing.watsup:95.12-95.14] rt  :  reftype
[notation ../spec/3-typing.watsup:95.6-95.14] {}  :  {}
[notation ../spec/3-typing.watsup:95.18-95.26] {lim_2 rt}  :  tabletype
[elab ../spec/3-typing.watsup:95.18-95.26] {lim_2 rt}  :  tabletype
[notation ../spec/3-typing.watsup:95.18-95.26] {lim_2 rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:95.18-95.23] lim_2  :  limits
[elab ../spec/3-typing.watsup:95.18-95.23] lim_2  :  limits
[notation ../spec/3-typing.watsup:95.18-95.26] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:95.24-95.26] rt  :  reftype
[elab ../spec/3-typing.watsup:95.24-95.26] rt  :  reftype
[notation ../spec/3-typing.watsup:95.18-95.26] {}  :  {}
[notation ../spec/3-typing.watsup:96.18-96.35] {} |- lim_1 <: lim_2  :  {} |- limits <: limits
[notation ../spec/3-typing.watsup:96.18-96.20] {}  :  {}
[notation ../spec/3-typing.watsup:96.21-96.35] lim_1 <: lim_2  :  limits <: limits
[notation ../spec/3-typing.watsup:96.21-96.26] lim_1  :  limits
[elab ../spec/3-typing.watsup:96.21-96.26] lim_1  :  limits
[notation ../spec/3-typing.watsup:96.30-96.35] lim_2  :  limits
[elab ../spec/3-typing.watsup:96.30-96.35] lim_2  :  limits
[notation ../spec/3-typing.watsup:99.3-99.26] {} |- {lim_1 I8} <: {lim_2 I8}  :  {} |- memtype <: memtype
[notation ../spec/3-typing.watsup:99.3-99.5] {}  :  {}
[notation ../spec/3-typing.watsup:99.6-99.26] {lim_1 I8} <: {lim_2 I8}  :  memtype <: memtype
[notation ../spec/3-typing.watsup:99.6-99.14] {lim_1 I8}  :  memtype
[elab ../spec/3-typing.watsup:99.6-99.14] {lim_1 I8}  :  memtype
[notation ../spec/3-typing.watsup:99.6-99.14] {lim_1 I8}  :  {limits I8}
[notation ../spec/3-typing.watsup:99.6-99.11] lim_1  :  limits
[elab ../spec/3-typing.watsup:99.6-99.11] lim_1  :  limits
[notation ../spec/3-typing.watsup:99.6-99.14] {I8}  :  {I8}
[notation ../spec/3-typing.watsup:99.12-99.14] I8  :  I8
[notation ../spec/3-typing.watsup:99.6-99.14] {}  :  {}
[notation ../spec/3-typing.watsup:99.18-99.26] {lim_2 I8}  :  memtype
[elab ../spec/3-typing.watsup:99.18-99.26] {lim_2 I8}  :  memtype
[notation ../spec/3-typing.watsup:99.18-99.26] {lim_2 I8}  :  {limits I8}
[notation ../spec/3-typing.watsup:99.18-99.23] lim_2  :  limits
[elab ../spec/3-typing.watsup:99.18-99.23] lim_2  :  limits
[notation ../spec/3-typing.watsup:99.18-99.26] {I8}  :  {I8}
[notation ../spec/3-typing.watsup:99.24-99.26] I8  :  I8
[notation ../spec/3-typing.watsup:99.18-99.26] {}  :  {}
[notation ../spec/3-typing.watsup:100.18-100.35] {} |- lim_1 <: lim_2  :  {} |- limits <: limits
[notation ../spec/3-typing.watsup:100.18-100.20] {}  :  {}
[notation ../spec/3-typing.watsup:100.21-100.35] lim_1 <: lim_2  :  limits <: limits
[notation ../spec/3-typing.watsup:100.21-100.26] lim_1  :  limits
[elab ../spec/3-typing.watsup:100.21-100.26] lim_1  :  limits
[notation ../spec/3-typing.watsup:100.30-100.35] lim_2  :  limits
[elab ../spec/3-typing.watsup:100.30-100.35] lim_2  :  limits
[notation ../spec/3-typing.watsup:104.3-104.28] {} |- {FUNC ft_1} <: {FUNC ft_2}  :  {} |- externtype <: externtype
[notation ../spec/3-typing.watsup:104.3-104.5] {}  :  {}
[notation ../spec/3-typing.watsup:104.6-104.28] {FUNC ft_1} <: {FUNC ft_2}  :  externtype <: externtype
[notation ../spec/3-typing.watsup:104.6-104.15] {FUNC ft_1}  :  externtype
[elab ../spec/3-typing.watsup:104.6-104.15] {FUNC ft_1}  :  externtype
[notation ../spec/3-typing.watsup:104.6-104.15] {ft_1}  :  {functype}
[notation ../spec/3-typing.watsup:104.11-104.15] ft_1  :  functype
[elab ../spec/3-typing.watsup:104.11-104.15] ft_1  :  functype
[notation ../spec/3-typing.watsup:104.6-104.15] {}  :  {}
[notation ../spec/3-typing.watsup:104.19-104.28] {FUNC ft_2}  :  externtype
[elab ../spec/3-typing.watsup:104.19-104.28] {FUNC ft_2}  :  externtype
[notation ../spec/3-typing.watsup:104.19-104.28] {ft_2}  :  {functype}
[notation ../spec/3-typing.watsup:104.24-104.28] ft_2  :  functype
[elab ../spec/3-typing.watsup:104.24-104.28] ft_2  :  functype
[notation ../spec/3-typing.watsup:104.19-104.28] {}  :  {}
[notation ../spec/3-typing.watsup:105.20-105.35] {} |- ft_1 <: ft_2  :  {} |- functype <: functype
[notation ../spec/3-typing.watsup:105.20-105.22] {}  :  {}
[notation ../spec/3-typing.watsup:105.23-105.35] ft_1 <: ft_2  :  functype <: functype
[notation ../spec/3-typing.watsup:105.23-105.27] ft_1  :  functype
[elab ../spec/3-typing.watsup:105.23-105.27] ft_1  :  functype
[notation ../spec/3-typing.watsup:105.31-105.35] ft_2  :  functype
[elab ../spec/3-typing.watsup:105.31-105.35] ft_2  :  functype
[notation ../spec/3-typing.watsup:108.3-108.32] {} |- {GLOBAL gt_1} <: {GLOBAL gt_2}  :  {} |- externtype <: externtype
[notation ../spec/3-typing.watsup:108.3-108.5] {}  :  {}
[notation ../spec/3-typing.watsup:108.6-108.32] {GLOBAL gt_1} <: {GLOBAL gt_2}  :  externtype <: externtype
[notation ../spec/3-typing.watsup:108.6-108.17] {GLOBAL gt_1}  :  externtype
[elab ../spec/3-typing.watsup:108.6-108.17] {GLOBAL gt_1}  :  externtype
[notation ../spec/3-typing.watsup:108.6-108.17] {gt_1}  :  {globaltype}
[notation ../spec/3-typing.watsup:108.13-108.17] gt_1  :  globaltype
[elab ../spec/3-typing.watsup:108.13-108.17] gt_1  :  globaltype
[notation ../spec/3-typing.watsup:108.6-108.17] {}  :  {}
[notation ../spec/3-typing.watsup:108.21-108.32] {GLOBAL gt_2}  :  externtype
[elab ../spec/3-typing.watsup:108.21-108.32] {GLOBAL gt_2}  :  externtype
[notation ../spec/3-typing.watsup:108.21-108.32] {gt_2}  :  {globaltype}
[notation ../spec/3-typing.watsup:108.28-108.32] gt_2  :  globaltype
[elab ../spec/3-typing.watsup:108.28-108.32] gt_2  :  globaltype
[notation ../spec/3-typing.watsup:108.21-108.32] {}  :  {}
[notation ../spec/3-typing.watsup:109.22-109.37] {} |- gt_1 <: gt_2  :  {} |- globaltype <: globaltype
[notation ../spec/3-typing.watsup:109.22-109.24] {}  :  {}
[notation ../spec/3-typing.watsup:109.25-109.37] gt_1 <: gt_2  :  globaltype <: globaltype
[notation ../spec/3-typing.watsup:109.25-109.29] gt_1  :  globaltype
[elab ../spec/3-typing.watsup:109.25-109.29] gt_1  :  globaltype
[notation ../spec/3-typing.watsup:109.33-109.37] gt_2  :  globaltype
[elab ../spec/3-typing.watsup:109.33-109.37] gt_2  :  globaltype
[notation ../spec/3-typing.watsup:112.3-112.30] {} |- {TABLE tt_1} <: {TABLE tt_2}  :  {} |- externtype <: externtype
[notation ../spec/3-typing.watsup:112.3-112.5] {}  :  {}
[notation ../spec/3-typing.watsup:112.6-112.30] {TABLE tt_1} <: {TABLE tt_2}  :  externtype <: externtype
[notation ../spec/3-typing.watsup:112.6-112.16] {TABLE tt_1}  :  externtype
[elab ../spec/3-typing.watsup:112.6-112.16] {TABLE tt_1}  :  externtype
[notation ../spec/3-typing.watsup:112.6-112.16] {tt_1}  :  {tabletype}
[notation ../spec/3-typing.watsup:112.12-112.16] tt_1  :  tabletype
[elab ../spec/3-typing.watsup:112.12-112.16] tt_1  :  tabletype
[notation ../spec/3-typing.watsup:112.6-112.16] {}  :  {}
[notation ../spec/3-typing.watsup:112.20-112.30] {TABLE tt_2}  :  externtype
[elab ../spec/3-typing.watsup:112.20-112.30] {TABLE tt_2}  :  externtype
[notation ../spec/3-typing.watsup:112.20-112.30] {tt_2}  :  {tabletype}
[notation ../spec/3-typing.watsup:112.26-112.30] tt_2  :  tabletype
[elab ../spec/3-typing.watsup:112.26-112.30] tt_2  :  tabletype
[notation ../spec/3-typing.watsup:112.20-112.30] {}  :  {}
[notation ../spec/3-typing.watsup:113.21-113.36] {} |- tt_1 <: tt_2  :  {} |- tabletype <: tabletype
[notation ../spec/3-typing.watsup:113.21-113.23] {}  :  {}
[notation ../spec/3-typing.watsup:113.24-113.36] tt_1 <: tt_2  :  tabletype <: tabletype
[notation ../spec/3-typing.watsup:113.24-113.28] tt_1  :  tabletype
[elab ../spec/3-typing.watsup:113.24-113.28] tt_1  :  tabletype
[notation ../spec/3-typing.watsup:113.32-113.36] tt_2  :  tabletype
[elab ../spec/3-typing.watsup:113.32-113.36] tt_2  :  tabletype
[notation ../spec/3-typing.watsup:116.3-116.32] {} |- {MEMORY mt_1} <: {MEMORY mt_2}  :  {} |- externtype <: externtype
[notation ../spec/3-typing.watsup:116.3-116.5] {}  :  {}
[notation ../spec/3-typing.watsup:116.6-116.32] {MEMORY mt_1} <: {MEMORY mt_2}  :  externtype <: externtype
[notation ../spec/3-typing.watsup:116.6-116.17] {MEMORY mt_1}  :  externtype
[elab ../spec/3-typing.watsup:116.6-116.17] {MEMORY mt_1}  :  externtype
[notation ../spec/3-typing.watsup:116.6-116.17] {mt_1}  :  {memtype}
[notation ../spec/3-typing.watsup:116.13-116.17] mt_1  :  memtype
[elab ../spec/3-typing.watsup:116.13-116.17] mt_1  :  memtype
[notation ../spec/3-typing.watsup:116.6-116.17] {}  :  {}
[notation ../spec/3-typing.watsup:116.21-116.32] {MEMORY mt_2}  :  externtype
[elab ../spec/3-typing.watsup:116.21-116.32] {MEMORY mt_2}  :  externtype
[notation ../spec/3-typing.watsup:116.21-116.32] {mt_2}  :  {memtype}
[notation ../spec/3-typing.watsup:116.28-116.32] mt_2  :  memtype
[elab ../spec/3-typing.watsup:116.28-116.32] mt_2  :  memtype
[notation ../spec/3-typing.watsup:116.21-116.32] {}  :  {}
[notation ../spec/3-typing.watsup:117.19-117.34] {} |- mt_1 <: mt_2  :  {} |- memtype <: memtype
[notation ../spec/3-typing.watsup:117.19-117.21] {}  :  {}
[notation ../spec/3-typing.watsup:117.22-117.34] mt_1 <: mt_2  :  memtype <: memtype
[notation ../spec/3-typing.watsup:117.22-117.26] mt_1  :  memtype
[elab ../spec/3-typing.watsup:117.22-117.26] mt_1  :  memtype
[notation ../spec/3-typing.watsup:117.30-117.34] mt_2  :  memtype
[elab ../spec/3-typing.watsup:117.30-117.34] mt_2  :  memtype
[notation ../spec/3-typing.watsup:129.3-129.19] C |- instr* : t*  :  context |- expr : resulttype
[notation ../spec/3-typing.watsup:129.3-129.4] C  :  context
[elab ../spec/3-typing.watsup:129.3-129.4] C  :  context
[notation ../spec/3-typing.watsup:129.8-129.19] instr* : t*  :  expr : resulttype
[notation ../spec/3-typing.watsup:129.8-129.14] instr*  :  expr
[elab ../spec/3-typing.watsup:129.8-129.14] instr*  :  expr
[elab ../spec/3-typing.watsup:129.8-129.13] instr  :  instr
[notation ../spec/3-typing.watsup:129.17-129.19] t*  :  resulttype
[elab ../spec/3-typing.watsup:129.17-129.19] t*  :  resulttype
[elab ../spec/3-typing.watsup:129.17-129.18] t  :  valtype
[notation ../spec/3-typing.watsup:130.19-130.46] C |- instr* : epsilon -> t*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:130.19-130.20] C  :  context
[elab ../spec/3-typing.watsup:130.19-130.20] C  :  context
[notation ../spec/3-typing.watsup:130.24-130.46] instr* : epsilon -> t*  :  instr* : functype
[notation ../spec/3-typing.watsup:130.24-130.30] instr*  :  instr*
[notation ../spec/3-typing.watsup:130.24-130.29] instr  :  instr
[elab ../spec/3-typing.watsup:130.24-130.29] instr  :  instr
[notation ../spec/3-typing.watsup:130.33-130.46] epsilon -> t*  :  functype
[elab ../spec/3-typing.watsup:130.33-130.46] epsilon -> t*  :  functype
[notation ../spec/3-typing.watsup:130.33-130.46] epsilon -> t*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:130.33-130.40] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:130.33-130.40] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:130.44-130.46] t*  :  resulttype
[elab ../spec/3-typing.watsup:130.44-130.46] t*  :  resulttype
[elab ../spec/3-typing.watsup:130.44-130.45] t  :  valtype
[notation ../spec/3-typing.watsup:134.3-134.36] C |- epsilon : epsilon -> epsilon  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:134.3-134.4] C  :  context
[elab ../spec/3-typing.watsup:134.3-134.4] C  :  context
[notation ../spec/3-typing.watsup:134.8-134.36] epsilon : epsilon -> epsilon  :  instr* : functype
[notation ../spec/3-typing.watsup:134.8-134.15] epsilon  :  instr*
[niteration ../spec/3-typing.watsup:134.8-134.15]   :  instr*
[notation ../spec/3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  functype
[elab ../spec/3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  functype
[notation ../spec/3-typing.watsup:134.18-134.36] epsilon -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:134.18-134.25] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:134.18-134.25] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:134.29-134.36] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:134.29-134.36] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:137.3-137.39] C |- {instr_1 instr_2*} : t_1* -> t_3*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:137.3-137.4] C  :  context
[elab ../spec/3-typing.watsup:137.3-137.4] C  :  context
[notation ../spec/3-typing.watsup:137.8-137.39] {instr_1 instr_2*} : t_1* -> t_3*  :  instr* : functype
[notation ../spec/3-typing.watsup:137.8-137.24] {instr_1 instr_2*}  :  instr*
[niteration ../spec/3-typing.watsup:137.8-137.24] instr_1 instr_2*  :  instr*
[notation ../spec/3-typing.watsup:137.8-137.15] instr_1  :  instr*
[notation ../spec/3-typing.watsup:137.8-137.15] instr_1  :  instr
[elab ../spec/3-typing.watsup:137.8-137.15] instr_1  :  instr
[niteration ../spec/3-typing.watsup:137.8-137.24] instr_2*  :  instr*
[notation ../spec/3-typing.watsup:137.16-137.24] instr_2*  :  instr*
[notation ../spec/3-typing.watsup:137.16-137.23] instr_2  :  instr
[elab ../spec/3-typing.watsup:137.16-137.23] instr_2  :  instr
[niteration ../spec/3-typing.watsup:137.8-137.24]   :  instr*
[notation ../spec/3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  functype
[elab ../spec/3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  functype
[notation ../spec/3-typing.watsup:137.27-137.39] t_1* -> t_3*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:137.27-137.31] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:137.27-137.31] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:137.27-137.30] t_1  :  valtype
[notation ../spec/3-typing.watsup:137.35-137.39] t_3*  :  resulttype
[elab ../spec/3-typing.watsup:137.35-137.39] t_3*  :  resulttype
[elab ../spec/3-typing.watsup:137.35-137.38] t_3  :  valtype
[notation ../spec/3-typing.watsup:138.16-138.43] C |- instr_1 : t_1* -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:138.16-138.17] C  :  context
[elab ../spec/3-typing.watsup:138.16-138.17] C  :  context
[notation ../spec/3-typing.watsup:138.21-138.43] instr_1 : t_1* -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:138.21-138.28] instr_1  :  instr
[elab ../spec/3-typing.watsup:138.21-138.28] instr_1  :  instr
[notation ../spec/3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:138.31-138.43] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:138.31-138.35] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:138.31-138.35] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:138.31-138.34] t_1  :  valtype
[notation ../spec/3-typing.watsup:138.39-138.43] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:138.39-138.43] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:138.39-138.42] t_2  :  valtype
[notation ../spec/3-typing.watsup:139.19-139.46] C |- instr_2 : t_2* -> t_3*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:139.19-139.20] C  :  context
[elab ../spec/3-typing.watsup:139.19-139.20] C  :  context
[notation ../spec/3-typing.watsup:139.24-139.46] instr_2 : t_2* -> t_3*  :  instr* : functype
[notation ../spec/3-typing.watsup:139.24-139.31] instr_2  :  instr*
[notation ../spec/3-typing.watsup:139.24-139.31] instr_2  :  instr
[elab ../spec/3-typing.watsup:139.24-139.31] instr_2  :  instr
[notation ../spec/3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  functype
[elab ../spec/3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  functype
[notation ../spec/3-typing.watsup:139.34-139.46] t_2* -> t_3*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:139.34-139.38] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:139.34-139.38] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:139.34-139.37] t_2  :  valtype
[notation ../spec/3-typing.watsup:139.42-139.46] t_3*  :  resulttype
[elab ../spec/3-typing.watsup:139.42-139.46] t_3*  :  resulttype
[elab ../spec/3-typing.watsup:139.42-139.45] t_3  :  valtype
[notation ../spec/3-typing.watsup:142.3-142.30] C |- instr* : t'_1 -> t'_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:142.3-142.4] C  :  context
[elab ../spec/3-typing.watsup:142.3-142.4] C  :  context
[notation ../spec/3-typing.watsup:142.8-142.30] instr* : t'_1 -> t'_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:142.8-142.14] instr*  :  instr*
[notation ../spec/3-typing.watsup:142.8-142.13] instr  :  instr
[elab ../spec/3-typing.watsup:142.8-142.13] instr  :  instr
[notation ../spec/3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  functype
[elab ../spec/3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  functype
[notation ../spec/3-typing.watsup:142.17-142.30] t'_1 -> t'_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:142.17-142.21] t'_1  :  resulttype
[elab ../spec/3-typing.watsup:142.17-142.21] t'_1  :  resulttype
[notation ../spec/3-typing.watsup:142.25-142.30] t'_2*  :  resulttype
[elab ../spec/3-typing.watsup:142.25-142.30] t'_2*  :  resulttype
[elab ../spec/3-typing.watsup:142.25-142.29] t'_2  :  valtype
[notation ../spec/3-typing.watsup:143.19-143.45] C |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:143.19-143.20] C  :  context
[elab ../spec/3-typing.watsup:143.19-143.20] C  :  context
[notation ../spec/3-typing.watsup:143.24-143.45] instr* : t_1* -> t_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:143.24-143.30] instr*  :  instr*
[notation ../spec/3-typing.watsup:143.24-143.29] instr  :  instr
[elab ../spec/3-typing.watsup:143.24-143.29] instr  :  instr
[notation ../spec/3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:143.33-143.45] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:143.33-143.37] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:143.33-143.37] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:143.33-143.36] t_1  :  valtype
[notation ../spec/3-typing.watsup:143.41-143.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:143.41-143.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:143.41-143.44] t_2  :  valtype
[notation ../spec/3-typing.watsup:145.18-145.34] {} |- t'_1* <: t_1*  :  {} |- valtype* <: valtype*
[notation ../spec/3-typing.watsup:145.18-145.20] {}  :  {}
[notation ../spec/3-typing.watsup:145.21-145.34] t'_1* <: t_1*  :  valtype* <: valtype*
[notation ../spec/3-typing.watsup:145.21-145.26] t'_1*  :  valtype*
[notation ../spec/3-typing.watsup:145.21-145.25] t'_1  :  valtype
[elab ../spec/3-typing.watsup:145.21-145.25] t'_1  :  valtype
[notation ../spec/3-typing.watsup:145.30-145.34] t_1*  :  valtype*
[notation ../spec/3-typing.watsup:145.30-145.33] t_1  :  valtype
[elab ../spec/3-typing.watsup:145.30-145.33] t_1  :  valtype
[notation ../spec/3-typing.watsup:146.22-146.38] {} |- t_2* <: t'_2*  :  {} |- valtype* <: valtype*
[notation ../spec/3-typing.watsup:146.22-146.24] {}  :  {}
[notation ../spec/3-typing.watsup:146.25-146.38] t_2* <: t'_2*  :  valtype* <: valtype*
[notation ../spec/3-typing.watsup:146.25-146.29] t_2*  :  valtype*
[notation ../spec/3-typing.watsup:146.25-146.28] t_2  :  valtype
[elab ../spec/3-typing.watsup:146.25-146.28] t_2  :  valtype
[notation ../spec/3-typing.watsup:146.33-146.38] t'_2*  :  valtype*
[notation ../spec/3-typing.watsup:146.33-146.37] t'_2  :  valtype
[elab ../spec/3-typing.watsup:146.33-146.37] t'_2  :  valtype
[notation ../spec/3-typing.watsup:149.3-149.35] C |- instr* : {t* t_1*} -> {t* t_2*}  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:149.3-149.4] C  :  context
[elab ../spec/3-typing.watsup:149.3-149.4] C  :  context
[notation ../spec/3-typing.watsup:149.8-149.35] instr* : {t* t_1*} -> {t* t_2*}  :  instr* : functype
[notation ../spec/3-typing.watsup:149.8-149.14] instr*  :  instr*
[notation ../spec/3-typing.watsup:149.8-149.13] instr  :  instr
[elab ../spec/3-typing.watsup:149.8-149.13] instr  :  instr
[notation ../spec/3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  functype
[elab ../spec/3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  functype
[notation ../spec/3-typing.watsup:149.17-149.35] {t* t_1*} -> {t* t_2*}  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:149.17-149.24] {t* t_1*}  :  resulttype
[elab ../spec/3-typing.watsup:149.17-149.24] {t* t_1*}  :  resulttype
[elab ../spec/3-typing.watsup:149.17-149.19] t*  :  resulttype
[elab ../spec/3-typing.watsup:149.17-149.18] t  :  valtype
[elab ../spec/3-typing.watsup:149.20-149.24] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:149.20-149.23] t_1  :  valtype
[notation ../spec/3-typing.watsup:149.28-149.35] {t* t_2*}  :  resulttype
[elab ../spec/3-typing.watsup:149.28-149.35] {t* t_2*}  :  resulttype
[elab ../spec/3-typing.watsup:149.28-149.30] t*  :  resulttype
[elab ../spec/3-typing.watsup:149.28-149.29] t  :  valtype
[elab ../spec/3-typing.watsup:149.31-149.35] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:149.31-149.34] t_2  :  valtype
[notation ../spec/3-typing.watsup:150.19-150.45] C |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:150.19-150.20] C  :  context
[elab ../spec/3-typing.watsup:150.19-150.20] C  :  context
[notation ../spec/3-typing.watsup:150.24-150.45] instr* : t_1* -> t_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:150.24-150.30] instr*  :  instr*
[notation ../spec/3-typing.watsup:150.24-150.29] instr  :  instr
[elab ../spec/3-typing.watsup:150.24-150.29] instr  :  instr
[notation ../spec/3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:150.33-150.45] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:150.33-150.37] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:150.33-150.37] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:150.33-150.36] t_1  :  valtype
[notation ../spec/3-typing.watsup:150.41-150.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:150.41-150.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:150.41-150.44] t_2  :  valtype
[notation ../spec/3-typing.watsup:154.3-154.34] C |- UNREACHABLE : t_1* -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:154.3-154.4] C  :  context
[elab ../spec/3-typing.watsup:154.3-154.4] C  :  context
[notation ../spec/3-typing.watsup:154.8-154.34] UNREACHABLE : t_1* -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:154.8-154.19] UNREACHABLE  :  instr
[elab ../spec/3-typing.watsup:154.8-154.19] UNREACHABLE  :  instr
[notation ../spec/3-typing.watsup:154.8-154.19] {}  :  {}
[notation ../spec/3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:154.22-154.34] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:154.22-154.26] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:154.22-154.26] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:154.22-154.25] t_1  :  valtype
[notation ../spec/3-typing.watsup:154.30-154.34] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:154.30-154.34] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:154.30-154.33] t_2  :  valtype
[notation ../spec/3-typing.watsup:157.3-157.32] C |- NOP : epsilon -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:157.3-157.4] C  :  context
[elab ../spec/3-typing.watsup:157.3-157.4] C  :  context
[notation ../spec/3-typing.watsup:157.8-157.32] NOP : epsilon -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:157.8-157.11] NOP  :  instr
[elab ../spec/3-typing.watsup:157.8-157.11] NOP  :  instr
[notation ../spec/3-typing.watsup:157.8-157.11] {}  :  {}
[notation ../spec/3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  functype
[elab ../spec/3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  functype
[notation ../spec/3-typing.watsup:157.14-157.32] epsilon -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:157.14-157.21] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:157.14-157.21] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:157.25-157.32] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:157.25-157.32] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:160.3-160.27] C |- DROP : t -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:160.3-160.4] C  :  context
[elab ../spec/3-typing.watsup:160.3-160.4] C  :  context
[notation ../spec/3-typing.watsup:160.8-160.27] DROP : t -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:160.8-160.12] DROP  :  instr
[elab ../spec/3-typing.watsup:160.8-160.12] DROP  :  instr
[notation ../spec/3-typing.watsup:160.8-160.12] {}  :  {}
[notation ../spec/3-typing.watsup:160.15-160.27] t -> epsilon  :  functype
[elab ../spec/3-typing.watsup:160.15-160.27] t -> epsilon  :  functype
[notation ../spec/3-typing.watsup:160.15-160.27] t -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:160.15-160.16] t  :  resulttype
[elab ../spec/3-typing.watsup:160.15-160.16] t  :  resulttype
[notation ../spec/3-typing.watsup:160.20-160.27] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:160.20-160.27] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:164.3-164.31] C |- {SELECT t} : {t t I32} -> t  :  context |- instr : functype
[notation ../spec/3-typing.watsup:164.3-164.4] C  :  context
[elab ../spec/3-typing.watsup:164.3-164.4] C  :  context
[notation ../spec/3-typing.watsup:164.8-164.31] {SELECT t} : {t t I32} -> t  :  instr : functype
[notation ../spec/3-typing.watsup:164.8-164.16] {SELECT t}  :  instr
[elab ../spec/3-typing.watsup:164.8-164.16] {SELECT t}  :  instr
[notation ../spec/3-typing.watsup:164.8-164.16] {t}  :  {valtype?}
[notation ../spec/3-typing.watsup:164.8-164.16] {t}  :  valtype?
[elab ../spec/3-typing.watsup:164.15-164.16] t  :  valtype?
[notation ../spec/3-typing.watsup:164.19-164.31] {t t I32} -> t  :  functype
[elab ../spec/3-typing.watsup:164.19-164.31] {t t I32} -> t  :  functype
[notation ../spec/3-typing.watsup:164.19-164.31] {t t I32} -> t  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:164.19-164.26] {t t I32}  :  resulttype
[elab ../spec/3-typing.watsup:164.19-164.26] {t t I32}  :  resulttype
[elab ../spec/3-typing.watsup:164.19-164.20] t  :  resulttype
[elab ../spec/3-typing.watsup:164.21-164.22] t  :  resulttype
[elab ../spec/3-typing.watsup:164.23-164.26] I32  :  resulttype
[notation ../spec/3-typing.watsup:164.23-164.26] {}  :  {}
[notation ../spec/3-typing.watsup:164.30-164.31] t  :  resulttype
[elab ../spec/3-typing.watsup:164.30-164.31] t  :  resulttype
[notation ../spec/3-typing.watsup:167.3-167.29] C |- SELECT : {t t I32} -> t  :  context |- instr : functype
[notation ../spec/3-typing.watsup:167.3-167.4] C  :  context
[elab ../spec/3-typing.watsup:167.3-167.4] C  :  context
[notation ../spec/3-typing.watsup:167.8-167.29] SELECT : {t t I32} -> t  :  instr : functype
[notation ../spec/3-typing.watsup:167.8-167.14] SELECT  :  instr
[elab ../spec/3-typing.watsup:167.8-167.14] SELECT  :  instr
[notation ../spec/3-typing.watsup:167.8-167.14] {}  :  {valtype?}
[notation ../spec/3-typing.watsup:167.8-167.14] {}  :  valtype?
[niteration ../spec/3-typing.watsup:167.8-167.14]   :  valtype?
[notation ../spec/3-typing.watsup:167.17-167.29] {t t I32} -> t  :  functype
[elab ../spec/3-typing.watsup:167.17-167.29] {t t I32} -> t  :  functype
[notation ../spec/3-typing.watsup:167.17-167.29] {t t I32} -> t  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:167.17-167.24] {t t I32}  :  resulttype
[elab ../spec/3-typing.watsup:167.17-167.24] {t t I32}  :  resulttype
[elab ../spec/3-typing.watsup:167.17-167.18] t  :  resulttype
[elab ../spec/3-typing.watsup:167.19-167.20] t  :  resulttype
[elab ../spec/3-typing.watsup:167.21-167.24] I32  :  resulttype
[notation ../spec/3-typing.watsup:167.21-167.24] {}  :  {}
[notation ../spec/3-typing.watsup:167.28-167.29] t  :  resulttype
[elab ../spec/3-typing.watsup:167.28-167.29] t  :  resulttype
[notation ../spec/3-typing.watsup:168.19-168.29] {} |- t <: t'  :  {} |- valtype <: valtype
[notation ../spec/3-typing.watsup:168.19-168.21] {}  :  {}
[notation ../spec/3-typing.watsup:168.22-168.29] t <: t'  :  valtype <: valtype
[notation ../spec/3-typing.watsup:168.22-168.23] t  :  valtype
[elab ../spec/3-typing.watsup:168.22-168.23] t  :  valtype
[notation ../spec/3-typing.watsup:168.27-168.29] t'  :  valtype
[elab ../spec/3-typing.watsup:168.27-168.29] t'  :  valtype
[elab ../spec/3-typing.watsup:169.9-169.37] t' = numtype \/ t' = vectype  :  bool
[elab ../spec/3-typing.watsup:169.9-169.21] t' = numtype  :  bool
[elab ../spec/3-typing.watsup:169.9-169.11] t'  :  valtype
[elab ../spec/3-typing.watsup:169.14-169.21] numtype  :  valtype
[elab ../spec/3-typing.watsup:169.25-169.37] t' = vectype  :  bool
[elab ../spec/3-typing.watsup:169.25-169.27] t'  :  valtype
[elab ../spec/3-typing.watsup:169.30-169.37] vectype  :  valtype
[notation ../spec/3-typing.watsup:175.3-175.15] C |- ft : ft  :  context |- blocktype : functype
[notation ../spec/3-typing.watsup:175.3-175.4] C  :  context
[elab ../spec/3-typing.watsup:175.3-175.4] C  :  context
[notation ../spec/3-typing.watsup:175.8-175.15] ft : ft  :  blocktype : functype
[notation ../spec/3-typing.watsup:175.8-175.10] ft  :  blocktype
[elab ../spec/3-typing.watsup:175.8-175.10] ft  :  blocktype
[notation ../spec/3-typing.watsup:175.13-175.15] ft  :  functype
[elab ../spec/3-typing.watsup:175.13-175.15] ft  :  functype
[notation ../spec/3-typing.watsup:176.19-176.29] {} |- ft : OK  :  {} |- functype : OK
[notation ../spec/3-typing.watsup:176.19-176.21] {}  :  {}
[notation ../spec/3-typing.watsup:176.22-176.29] ft : OK  :  functype : OK
[notation ../spec/3-typing.watsup:176.22-176.24] ft  :  functype
[elab ../spec/3-typing.watsup:176.22-176.24] ft  :  functype
[notation ../spec/3-typing.watsup:176.27-176.29] OK  :  OK
[notation ../spec/3-typing.watsup:179.3-179.38] C |- {BLOCK bt instr*} : t_1* -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:179.3-179.4] C  :  context
[elab ../spec/3-typing.watsup:179.3-179.4] C  :  context
[notation ../spec/3-typing.watsup:179.8-179.38] {BLOCK bt instr*} : t_1* -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:179.8-179.23] {BLOCK bt instr*}  :  instr
[elab ../spec/3-typing.watsup:179.8-179.23] {BLOCK bt instr*}  :  instr
[notation ../spec/3-typing.watsup:179.8-179.23] {bt instr*}  :  {blocktype instr*}
[notation ../spec/3-typing.watsup:179.14-179.16] bt  :  blocktype
[elab ../spec/3-typing.watsup:179.14-179.16] bt  :  blocktype
[notation ../spec/3-typing.watsup:179.8-179.23] {instr*}  :  {instr*}
[notation ../spec/3-typing.watsup:179.8-179.23] {instr*}  :  instr*
[elab ../spec/3-typing.watsup:179.17-179.23] instr*  :  instr*
[elab ../spec/3-typing.watsup:179.17-179.22] instr  :  instr
[notation ../spec/3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:179.26-179.38] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:179.26-179.30] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:179.26-179.30] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:179.26-179.29] t_1  :  valtype
[notation ../spec/3-typing.watsup:179.34-179.38] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:179.34-179.38] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:179.34-179.37] t_2  :  valtype
[notation ../spec/3-typing.watsup:180.20-180.42] C |- bt : t_1* -> t_2*  :  context |- blocktype : functype
[notation ../spec/3-typing.watsup:180.20-180.21] C  :  context
[elab ../spec/3-typing.watsup:180.20-180.21] C  :  context
[notation ../spec/3-typing.watsup:180.25-180.42] bt : t_1* -> t_2*  :  blocktype : functype
[notation ../spec/3-typing.watsup:180.25-180.27] bt  :  blocktype
[elab ../spec/3-typing.watsup:180.25-180.27] bt  :  blocktype
[notation ../spec/3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:180.30-180.42] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:180.30-180.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:180.30-180.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:180.30-180.33] t_1  :  valtype
[notation ../spec/3-typing.watsup:180.38-180.42] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:180.38-180.42] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:180.38-180.41] t_2  :  valtype
[notation ../spec/3-typing.watsup:181.19-181.57] C, {LABEL t_2*} |- instr* : t_1* -> t_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:181.19-181.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:181.19-181.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:181.19-181.20] C  :  context
[elab ../spec/3-typing.watsup:181.28-181.32] {LABEL t_2*}  :  context
[notation ../spec/3-typing.watsup:181.28-181.32] t_2*  :  resulttype*
[notation ../spec/3-typing.watsup:181.28-181.31] t_2  :  resulttype
[elab ../spec/3-typing.watsup:181.28-181.31] t_2  :  resulttype
[notation ../spec/3-typing.watsup:181.36-181.57] instr* : t_1* -> t_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:181.36-181.42] instr*  :  instr*
[notation ../spec/3-typing.watsup:181.36-181.41] instr  :  instr
[elab ../spec/3-typing.watsup:181.36-181.41] instr  :  instr
[notation ../spec/3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:181.45-181.57] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:181.45-181.49] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:181.45-181.49] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:181.45-181.48] t_1  :  valtype
[notation ../spec/3-typing.watsup:181.53-181.57] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:181.53-181.57] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:181.53-181.56] t_2  :  valtype
[notation ../spec/3-typing.watsup:184.3-184.37] C |- {LOOP bt instr*} : t_1* -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:184.3-184.4] C  :  context
[elab ../spec/3-typing.watsup:184.3-184.4] C  :  context
[notation ../spec/3-typing.watsup:184.8-184.37] {LOOP bt instr*} : t_1* -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:184.8-184.22] {LOOP bt instr*}  :  instr
[elab ../spec/3-typing.watsup:184.8-184.22] {LOOP bt instr*}  :  instr
[notation ../spec/3-typing.watsup:184.8-184.22] {bt instr*}  :  {blocktype instr*}
[notation ../spec/3-typing.watsup:184.13-184.15] bt  :  blocktype
[elab ../spec/3-typing.watsup:184.13-184.15] bt  :  blocktype
[notation ../spec/3-typing.watsup:184.8-184.22] {instr*}  :  {instr*}
[notation ../spec/3-typing.watsup:184.8-184.22] {instr*}  :  instr*
[elab ../spec/3-typing.watsup:184.16-184.22] instr*  :  instr*
[elab ../spec/3-typing.watsup:184.16-184.21] instr  :  instr
[notation ../spec/3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:184.25-184.37] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:184.25-184.29] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:184.25-184.29] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:184.25-184.28] t_1  :  valtype
[notation ../spec/3-typing.watsup:184.33-184.37] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:184.33-184.37] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:184.33-184.36] t_2  :  valtype
[notation ../spec/3-typing.watsup:185.20-185.42] C |- bt : t_1* -> t_2*  :  context |- blocktype : functype
[notation ../spec/3-typing.watsup:185.20-185.21] C  :  context
[elab ../spec/3-typing.watsup:185.20-185.21] C  :  context
[notation ../spec/3-typing.watsup:185.25-185.42] bt : t_1* -> t_2*  :  blocktype : functype
[notation ../spec/3-typing.watsup:185.25-185.27] bt  :  blocktype
[elab ../spec/3-typing.watsup:185.25-185.27] bt  :  blocktype
[notation ../spec/3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:185.30-185.42] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:185.30-185.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:185.30-185.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:185.30-185.33] t_1  :  valtype
[notation ../spec/3-typing.watsup:185.38-185.42] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:185.38-185.42] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:185.38-185.41] t_2  :  valtype
[notation ../spec/3-typing.watsup:186.19-186.56] C, {LABEL t_1*} |- instr* : t_1* -> t_2  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:186.19-186.32] C, {LABEL t_1*}  :  context
[elab ../spec/3-typing.watsup:186.19-186.32] C, {LABEL t_1*}  :  context
[elab ../spec/3-typing.watsup:186.19-186.20] C  :  context
[elab ../spec/3-typing.watsup:186.28-186.32] {LABEL t_1*}  :  context
[notation ../spec/3-typing.watsup:186.28-186.32] t_1*  :  resulttype*
[notation ../spec/3-typing.watsup:186.28-186.31] t_1  :  resulttype
[elab ../spec/3-typing.watsup:186.28-186.31] t_1  :  resulttype
[notation ../spec/3-typing.watsup:186.36-186.56] instr* : t_1* -> t_2  :  instr* : functype
[notation ../spec/3-typing.watsup:186.36-186.42] instr*  :  instr*
[notation ../spec/3-typing.watsup:186.36-186.41] instr  :  instr
[elab ../spec/3-typing.watsup:186.36-186.41] instr  :  instr
[notation ../spec/3-typing.watsup:186.45-186.56] t_1* -> t_2  :  functype
[elab ../spec/3-typing.watsup:186.45-186.56] t_1* -> t_2  :  functype
[notation ../spec/3-typing.watsup:186.45-186.56] t_1* -> t_2  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:186.45-186.49] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:186.45-186.49] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:186.45-186.48] t_1  :  valtype
[notation ../spec/3-typing.watsup:186.53-186.56] t_2  :  resulttype
[elab ../spec/3-typing.watsup:186.53-186.56] t_2  :  resulttype
[notation ../spec/3-typing.watsup:189.3-189.50] C |- {IF bt instr_1* ELSE instr_2*} : t_1* -> t_2  :  context |- instr : functype
[notation ../spec/3-typing.watsup:189.3-189.4] C  :  context
[elab ../spec/3-typing.watsup:189.3-189.4] C  :  context
[notation ../spec/3-typing.watsup:189.8-189.50] {IF bt instr_1* ELSE instr_2*} : t_1* -> t_2  :  instr : functype
[notation ../spec/3-typing.watsup:189.8-189.36] {IF bt instr_1* ELSE instr_2*}  :  instr
[elab ../spec/3-typing.watsup:189.8-189.36] {IF bt instr_1* ELSE instr_2*}  :  instr
[notation ../spec/3-typing.watsup:189.8-189.36] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation ../spec/3-typing.watsup:189.11-189.13] bt  :  blocktype
[elab ../spec/3-typing.watsup:189.11-189.13] bt  :  blocktype
[notation ../spec/3-typing.watsup:189.8-189.36] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation ../spec/3-typing.watsup:189.14-189.22] instr_1*  :  instr*
[notation ../spec/3-typing.watsup:189.14-189.21] instr_1  :  instr
[elab ../spec/3-typing.watsup:189.14-189.21] instr_1  :  instr
[notation ../spec/3-typing.watsup:189.8-189.36] {ELSE instr_2*}  :  {ELSE instr*}
[notation ../spec/3-typing.watsup:189.23-189.27] ELSE  :  ELSE
[notation ../spec/3-typing.watsup:189.8-189.36] {instr_2*}  :  {instr*}
[notation ../spec/3-typing.watsup:189.8-189.36] {instr_2*}  :  instr*
[elab ../spec/3-typing.watsup:189.28-189.36] instr_2*  :  instr*
[elab ../spec/3-typing.watsup:189.28-189.35] instr_2  :  instr
[notation ../spec/3-typing.watsup:189.39-189.50] t_1* -> t_2  :  functype
[elab ../spec/3-typing.watsup:189.39-189.50] t_1* -> t_2  :  functype
[notation ../spec/3-typing.watsup:189.39-189.50] t_1* -> t_2  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:189.39-189.43] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:189.39-189.43] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:189.39-189.42] t_1  :  valtype
[notation ../spec/3-typing.watsup:189.47-189.50] t_2  :  resulttype
[elab ../spec/3-typing.watsup:189.47-189.50] t_2  :  resulttype
[notation ../spec/3-typing.watsup:190.20-190.41] C |- bt : t_1* -> t_2  :  context |- blocktype : functype
[notation ../spec/3-typing.watsup:190.20-190.21] C  :  context
[elab ../spec/3-typing.watsup:190.20-190.21] C  :  context
[notation ../spec/3-typing.watsup:190.25-190.41] bt : t_1* -> t_2  :  blocktype : functype
[notation ../spec/3-typing.watsup:190.25-190.27] bt  :  blocktype
[elab ../spec/3-typing.watsup:190.25-190.27] bt  :  blocktype
[notation ../spec/3-typing.watsup:190.30-190.41] t_1* -> t_2  :  functype
[elab ../spec/3-typing.watsup:190.30-190.41] t_1* -> t_2  :  functype
[notation ../spec/3-typing.watsup:190.30-190.41] t_1* -> t_2  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:190.30-190.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:190.30-190.34] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:190.30-190.33] t_1  :  valtype
[notation ../spec/3-typing.watsup:190.38-190.41] t_2  :  resulttype
[elab ../spec/3-typing.watsup:190.38-190.41] t_2  :  resulttype
[notation ../spec/3-typing.watsup:191.19-191.59] C, {LABEL t_2*} |- instr_1* : t_1* -> t_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:191.19-191.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:191.19-191.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:191.19-191.20] C  :  context
[elab ../spec/3-typing.watsup:191.28-191.32] {LABEL t_2*}  :  context
[notation ../spec/3-typing.watsup:191.28-191.32] t_2*  :  resulttype*
[notation ../spec/3-typing.watsup:191.28-191.31] t_2  :  resulttype
[elab ../spec/3-typing.watsup:191.28-191.31] t_2  :  resulttype
[notation ../spec/3-typing.watsup:191.36-191.59] instr_1* : t_1* -> t_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:191.36-191.44] instr_1*  :  instr*
[notation ../spec/3-typing.watsup:191.36-191.43] instr_1  :  instr
[elab ../spec/3-typing.watsup:191.36-191.43] instr_1  :  instr
[notation ../spec/3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:191.47-191.59] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:191.47-191.51] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:191.47-191.51] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:191.47-191.50] t_1  :  valtype
[notation ../spec/3-typing.watsup:191.55-191.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:191.55-191.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:191.55-191.58] t_2  :  valtype
[notation ../spec/3-typing.watsup:192.19-192.59] C, {LABEL t_2*} |- instr_2* : t_1* -> t_2*  :  context |- instr* : functype
[notation ../spec/3-typing.watsup:192.19-192.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:192.19-192.32] C, {LABEL t_2*}  :  context
[elab ../spec/3-typing.watsup:192.19-192.20] C  :  context
[elab ../spec/3-typing.watsup:192.28-192.32] {LABEL t_2*}  :  context
[notation ../spec/3-typing.watsup:192.28-192.32] t_2*  :  resulttype*
[notation ../spec/3-typing.watsup:192.28-192.31] t_2  :  resulttype
[elab ../spec/3-typing.watsup:192.28-192.31] t_2  :  resulttype
[notation ../spec/3-typing.watsup:192.36-192.59] instr_2* : t_1* -> t_2*  :  instr* : functype
[notation ../spec/3-typing.watsup:192.36-192.44] instr_2*  :  instr*
[notation ../spec/3-typing.watsup:192.36-192.43] instr_2  :  instr
[elab ../spec/3-typing.watsup:192.36-192.43] instr_2  :  instr
[notation ../spec/3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:192.47-192.59] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:192.47-192.51] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:192.47-192.51] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:192.47-192.50] t_1  :  valtype
[notation ../spec/3-typing.watsup:192.55-192.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:192.55-192.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:192.55-192.58] t_2  :  valtype
[notation ../spec/3-typing.watsup:196.3-196.30] C |- {BR l} : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:196.3-196.4] C  :  context
[elab ../spec/3-typing.watsup:196.3-196.4] C  :  context
[notation ../spec/3-typing.watsup:196.8-196.30] {BR l} : {t_1* t*} -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:196.8-196.12] {BR l}  :  instr
[elab ../spec/3-typing.watsup:196.8-196.12] {BR l}  :  instr
[notation ../spec/3-typing.watsup:196.8-196.12] {l}  :  {labelidx}
[notation ../spec/3-typing.watsup:196.11-196.12] l  :  labelidx
[elab ../spec/3-typing.watsup:196.11-196.12] l  :  labelidx
[notation ../spec/3-typing.watsup:196.8-196.12] {}  :  {}
[notation ../spec/3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  functype
[elab ../spec/3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  functype
[notation ../spec/3-typing.watsup:196.15-196.30] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:196.15-196.22] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:196.15-196.22] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:196.15-196.19] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:196.15-196.18] t_1  :  valtype
[elab ../spec/3-typing.watsup:196.20-196.22] t*  :  resulttype
[elab ../spec/3-typing.watsup:196.20-196.21] t  :  valtype
[notation ../spec/3-typing.watsup:196.26-196.30] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:196.26-196.30] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:196.26-196.29] t_2  :  valtype
[elab ../spec/3-typing.watsup:197.9-197.24] C.LABEL[l] = t*  :  bool
[elab ../spec/3-typing.watsup:197.9-197.19] C.LABEL[l]  :  resulttype
[elab ../spec/3-typing.watsup:197.9-197.16] C.LABEL  :  resulttype*
[elab ../spec/3-typing.watsup:197.9-197.10] C  :  context
[elab ../spec/3-typing.watsup:197.17-197.18] l  :  nat
[elab ../spec/3-typing.watsup:197.22-197.24] t*  :  resulttype
[elab ../spec/3-typing.watsup:197.22-197.23] t  :  valtype
[notation ../spec/3-typing.watsup:200.3-200.30] C |- {BR_IF l} : {t* I32} -> t*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:200.3-200.4] C  :  context
[elab ../spec/3-typing.watsup:200.3-200.4] C  :  context
[notation ../spec/3-typing.watsup:200.8-200.30] {BR_IF l} : {t* I32} -> t*  :  instr : functype
[notation ../spec/3-typing.watsup:200.8-200.15] {BR_IF l}  :  instr
[elab ../spec/3-typing.watsup:200.8-200.15] {BR_IF l}  :  instr
[notation ../spec/3-typing.watsup:200.8-200.15] {l}  :  {labelidx}
[notation ../spec/3-typing.watsup:200.14-200.15] l  :  labelidx
[elab ../spec/3-typing.watsup:200.14-200.15] l  :  labelidx
[notation ../spec/3-typing.watsup:200.8-200.15] {}  :  {}
[notation ../spec/3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  functype
[elab ../spec/3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  functype
[notation ../spec/3-typing.watsup:200.18-200.30] {t* I32} -> t*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:200.18-200.24] {t* I32}  :  resulttype
[elab ../spec/3-typing.watsup:200.18-200.24] {t* I32}  :  resulttype
[elab ../spec/3-typing.watsup:200.18-200.20] t*  :  resulttype
[elab ../spec/3-typing.watsup:200.18-200.19] t  :  valtype
[elab ../spec/3-typing.watsup:200.21-200.24] I32  :  resulttype
[notation ../spec/3-typing.watsup:200.21-200.24] {}  :  {}
[notation ../spec/3-typing.watsup:200.28-200.30] t*  :  resulttype
[elab ../spec/3-typing.watsup:200.28-200.30] t*  :  resulttype
[elab ../spec/3-typing.watsup:200.28-200.29] t  :  valtype
[elab ../spec/3-typing.watsup:201.9-201.24] C.LABEL[l] = t*  :  bool
[elab ../spec/3-typing.watsup:201.9-201.19] C.LABEL[l]  :  resulttype
[elab ../spec/3-typing.watsup:201.9-201.16] C.LABEL  :  resulttype*
[elab ../spec/3-typing.watsup:201.9-201.10] C  :  context
[elab ../spec/3-typing.watsup:201.17-201.18] l  :  nat
[elab ../spec/3-typing.watsup:201.22-201.24] t*  :  resulttype
[elab ../spec/3-typing.watsup:201.22-201.23] t  :  valtype
[notation ../spec/3-typing.watsup:204.3-204.40] C |- {BR_TABLE l* l'} : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:204.3-204.4] C  :  context
[elab ../spec/3-typing.watsup:204.3-204.4] C  :  context
[notation ../spec/3-typing.watsup:204.8-204.40] {BR_TABLE l* l'} : {t_1* t*} -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:204.8-204.22] {BR_TABLE l* l'}  :  instr
[elab ../spec/3-typing.watsup:204.8-204.22] {BR_TABLE l* l'}  :  instr
[notation ../spec/3-typing.watsup:204.8-204.22] {l* l'}  :  {labelidx* labelidx}
[notation ../spec/3-typing.watsup:204.17-204.19] l*  :  labelidx*
[notation ../spec/3-typing.watsup:204.17-204.18] l  :  labelidx
[elab ../spec/3-typing.watsup:204.17-204.18] l  :  labelidx
[notation ../spec/3-typing.watsup:204.8-204.22] {l'}  :  {labelidx}
[notation ../spec/3-typing.watsup:204.20-204.22] l'  :  labelidx
[elab ../spec/3-typing.watsup:204.20-204.22] l'  :  labelidx
[notation ../spec/3-typing.watsup:204.8-204.22] {}  :  {}
[notation ../spec/3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  functype
[elab ../spec/3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  functype
[notation ../spec/3-typing.watsup:204.25-204.40] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:204.25-204.32] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:204.25-204.32] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:204.25-204.29] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:204.25-204.28] t_1  :  valtype
[elab ../spec/3-typing.watsup:204.30-204.32] t*  :  resulttype
[elab ../spec/3-typing.watsup:204.30-204.31] t  :  valtype
[notation ../spec/3-typing.watsup:204.36-204.40] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:204.36-204.40] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:204.36-204.39] t_2  :  valtype
[notation ../spec/3-typing.watsup:205.23-205.42] {} |- t* <: C.LABEL[l]  :  {} |- valtype* <: valtype*
[notation ../spec/3-typing.watsup:205.23-205.25] {}  :  {}
[notation ../spec/3-typing.watsup:205.26-205.42] t* <: C.LABEL[l]  :  valtype* <: valtype*
[notation ../spec/3-typing.watsup:205.26-205.28] t*  :  valtype*
[notation ../spec/3-typing.watsup:205.26-205.27] t  :  valtype
[elab ../spec/3-typing.watsup:205.26-205.27] t  :  valtype
[notation ../spec/3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype*
[notation ../spec/3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype
[elab ../spec/3-typing.watsup:205.32-205.42] C.LABEL[l]  :  valtype
[elab ../spec/3-typing.watsup:205.32-205.39] C.LABEL  :  resulttype*
[elab ../spec/3-typing.watsup:205.32-205.33] C  :  context
[elab ../spec/3-typing.watsup:205.40-205.41] l  :  nat
[notation ../spec/3-typing.watsup:206.22-206.42] {} |- t* <: C.LABEL[l']  :  {} |- valtype* <: valtype*
[notation ../spec/3-typing.watsup:206.22-206.24] {}  :  {}
[notation ../spec/3-typing.watsup:206.25-206.42] t* <: C.LABEL[l']  :  valtype* <: valtype*
[notation ../spec/3-typing.watsup:206.25-206.27] t*  :  valtype*
[notation ../spec/3-typing.watsup:206.25-206.26] t  :  valtype
[elab ../spec/3-typing.watsup:206.25-206.26] t  :  valtype
[notation ../spec/3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype*
[notation ../spec/3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype
[elab ../spec/3-typing.watsup:206.31-206.42] C.LABEL[l']  :  valtype
[elab ../spec/3-typing.watsup:206.31-206.38] C.LABEL  :  resulttype*
[elab ../spec/3-typing.watsup:206.31-206.32] C  :  context
[elab ../spec/3-typing.watsup:206.39-206.41] l'  :  nat
[notation ../spec/3-typing.watsup:209.3-209.32] C |- RETURN : {t_1* t*} -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:209.3-209.4] C  :  context
[elab ../spec/3-typing.watsup:209.3-209.4] C  :  context
[notation ../spec/3-typing.watsup:209.8-209.32] RETURN : {t_1* t*} -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:209.8-209.14] RETURN  :  instr
[elab ../spec/3-typing.watsup:209.8-209.14] RETURN  :  instr
[notation ../spec/3-typing.watsup:209.8-209.14] {}  :  {}
[notation ../spec/3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  functype
[elab ../spec/3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  functype
[notation ../spec/3-typing.watsup:209.17-209.32] {t_1* t*} -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:209.17-209.24] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:209.17-209.24] {t_1* t*}  :  resulttype
[elab ../spec/3-typing.watsup:209.17-209.21] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:209.17-209.20] t_1  :  valtype
[elab ../spec/3-typing.watsup:209.22-209.24] t*  :  resulttype
[elab ../spec/3-typing.watsup:209.22-209.23] t  :  valtype
[notation ../spec/3-typing.watsup:209.28-209.32] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:209.28-209.32] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:209.28-209.31] t_2  :  valtype
[elab ../spec/3-typing.watsup:210.9-210.24] C.RETURN = (t*)  :  bool
[elab ../spec/3-typing.watsup:210.9-210.17] C.RETURN  :  resulttype?
[elab ../spec/3-typing.watsup:210.9-210.10] C  :  context
[elab ../spec/3-typing.watsup:210.20-210.24] (t*)  :  resulttype?
[elab ../spec/3-typing.watsup:210.21-210.23] t*  :  resulttype
[elab ../spec/3-typing.watsup:210.21-210.22] t  :  valtype
[notation ../spec/3-typing.watsup:213.3-213.29] C |- {CALL x} : t_1* -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:213.3-213.4] C  :  context
[elab ../spec/3-typing.watsup:213.3-213.4] C  :  context
[notation ../spec/3-typing.watsup:213.8-213.29] {CALL x} : t_1* -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:213.8-213.14] {CALL x}  :  instr
[elab ../spec/3-typing.watsup:213.8-213.14] {CALL x}  :  instr
[notation ../spec/3-typing.watsup:213.8-213.14] {x}  :  {funcidx}
[notation ../spec/3-typing.watsup:213.13-213.14] x  :  funcidx
[elab ../spec/3-typing.watsup:213.13-213.14] x  :  funcidx
[notation ../spec/3-typing.watsup:213.8-213.14] {}  :  {}
[notation ../spec/3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  functype
[elab ../spec/3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:213.17-213.29] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:213.17-213.21] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:213.17-213.21] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:213.17-213.20] t_1  :  valtype
[notation ../spec/3-typing.watsup:213.25-213.29] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:213.25-213.29] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:213.25-213.28] t_2  :  valtype
[elab ../spec/3-typing.watsup:214.9-214.33] C.FUNC[x] = t_1* -> t_2*  :  bool
[elab ../spec/3-typing.watsup:214.9-214.18] C.FUNC[x]  :  functype
[elab ../spec/3-typing.watsup:214.9-214.15] C.FUNC  :  functype*
[elab ../spec/3-typing.watsup:214.9-214.10] C  :  context
[elab ../spec/3-typing.watsup:214.16-214.17] x  :  nat
[elab ../spec/3-typing.watsup:214.21-214.33] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:214.21-214.33] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:214.21-214.25] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:214.21-214.25] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:214.21-214.24] t_1  :  valtype
[notation ../spec/3-typing.watsup:214.29-214.33] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:214.29-214.33] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:214.29-214.32] t_2  :  valtype
[notation ../spec/3-typing.watsup:217.3-217.45] C |- {CALL_INDIRECT x ft} : {t_1* I32} -> t_2*  :  context |- instr : functype
[notation ../spec/3-typing.watsup:217.3-217.4] C  :  context
[elab ../spec/3-typing.watsup:217.3-217.4] C  :  context
[notation ../spec/3-typing.watsup:217.8-217.45] {CALL_INDIRECT x ft} : {t_1* I32} -> t_2*  :  instr : functype
[notation ../spec/3-typing.watsup:217.8-217.26] {CALL_INDIRECT x ft}  :  instr
[elab ../spec/3-typing.watsup:217.8-217.26] {CALL_INDIRECT x ft}  :  instr
[notation ../spec/3-typing.watsup:217.8-217.26] {x ft}  :  {tableidx functype}
[notation ../spec/3-typing.watsup:217.22-217.23] x  :  tableidx
[elab ../spec/3-typing.watsup:217.22-217.23] x  :  tableidx
[notation ../spec/3-typing.watsup:217.8-217.26] {ft}  :  {functype}
[notation ../spec/3-typing.watsup:217.24-217.26] ft  :  functype
[elab ../spec/3-typing.watsup:217.24-217.26] ft  :  functype
[notation ../spec/3-typing.watsup:217.8-217.26] {}  :  {}
[notation ../spec/3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  functype
[elab ../spec/3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  functype
[notation ../spec/3-typing.watsup:217.29-217.45] {t_1* I32} -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:217.29-217.37] {t_1* I32}  :  resulttype
[elab ../spec/3-typing.watsup:217.29-217.37] {t_1* I32}  :  resulttype
[elab ../spec/3-typing.watsup:217.29-217.33] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:217.29-217.32] t_1  :  valtype
[elab ../spec/3-typing.watsup:217.34-217.37] I32  :  resulttype
[notation ../spec/3-typing.watsup:217.34-217.37] {}  :  {}
[notation ../spec/3-typing.watsup:217.41-217.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:217.41-217.45] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:217.41-217.44] t_2  :  valtype
[elab ../spec/3-typing.watsup:218.9-218.33] C.TABLE[x] = {lim FUNCREF}  :  bool
[elab ../spec/3-typing.watsup:218.9-218.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:218.9-218.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:218.9-218.10] C  :  context
[elab ../spec/3-typing.watsup:218.17-218.18] x  :  nat
[elab ../spec/3-typing.watsup:218.22-218.33] {lim FUNCREF}  :  tabletype
[notation ../spec/3-typing.watsup:218.22-218.33] {lim FUNCREF}  :  {limits reftype}
[notation ../spec/3-typing.watsup:218.22-218.25] lim  :  limits
[elab ../spec/3-typing.watsup:218.22-218.25] lim  :  limits
[notation ../spec/3-typing.watsup:218.22-218.33] {FUNCREF}  :  {reftype}
[notation ../spec/3-typing.watsup:218.26-218.33] FUNCREF  :  reftype
[elab ../spec/3-typing.watsup:218.26-218.33] FUNCREF  :  reftype
[notation ../spec/3-typing.watsup:218.26-218.33] {}  :  {}
[notation ../spec/3-typing.watsup:218.22-218.33] {}  :  {}
[elab ../spec/3-typing.watsup:219.9-219.26] ft = t_1* -> t_2*  :  bool
[elab ../spec/3-typing.watsup:219.9-219.11] ft  :  functype
[elab ../spec/3-typing.watsup:219.14-219.26] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:219.14-219.26] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:219.14-219.18] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:219.14-219.18] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:219.14-219.17] t_1  :  valtype
[notation ../spec/3-typing.watsup:219.22-219.26] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:219.22-219.26] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:219.22-219.25] t_2  :  valtype
[notation ../spec/3-typing.watsup:223.3-223.37] C |- {CONST nt c_nt} : epsilon -> nt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:223.3-223.4] C  :  context
[elab ../spec/3-typing.watsup:223.3-223.4] C  :  context
[notation ../spec/3-typing.watsup:223.8-223.37] {CONST nt c_nt} : epsilon -> nt  :  instr : functype
[notation ../spec/3-typing.watsup:223.8-223.21] {CONST nt c_nt}  :  instr
[elab ../spec/3-typing.watsup:223.8-223.21] {CONST nt c_nt}  :  instr
[notation ../spec/3-typing.watsup:223.8-223.21] {nt c_nt}  :  {numtype c_numtype}
[notation ../spec/3-typing.watsup:223.14-223.16] nt  :  numtype
[elab ../spec/3-typing.watsup:223.14-223.16] nt  :  numtype
[notation ../spec/3-typing.watsup:223.8-223.21] {c_nt}  :  {c_numtype}
[notation ../spec/3-typing.watsup:223.17-223.21] c_nt  :  c_numtype
[elab ../spec/3-typing.watsup:223.17-223.21] c_nt  :  c_numtype
[notation ../spec/3-typing.watsup:223.8-223.21] {}  :  {}
[notation ../spec/3-typing.watsup:223.24-223.37] epsilon -> nt  :  functype
[elab ../spec/3-typing.watsup:223.24-223.37] epsilon -> nt  :  functype
[notation ../spec/3-typing.watsup:223.24-223.37] epsilon -> nt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:223.24-223.31] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:223.24-223.31] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:223.35-223.37] nt  :  resulttype
[elab ../spec/3-typing.watsup:223.35-223.37] nt  :  resulttype
[notation ../spec/3-typing.watsup:226.3-226.31] C |- {UNOP nt unop} : nt -> nt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:226.3-226.4] C  :  context
[elab ../spec/3-typing.watsup:226.3-226.4] C  :  context
[notation ../spec/3-typing.watsup:226.8-226.31] {UNOP nt unop} : nt -> nt  :  instr : functype
[notation ../spec/3-typing.watsup:226.8-226.20] {UNOP nt unop}  :  instr
[elab ../spec/3-typing.watsup:226.8-226.20] {UNOP nt unop}  :  instr
[notation ../spec/3-typing.watsup:226.8-226.20] {nt unop}  :  {numtype unop_numtype}
[notation ../spec/3-typing.watsup:226.13-226.15] nt  :  numtype
[elab ../spec/3-typing.watsup:226.13-226.15] nt  :  numtype
[notation ../spec/3-typing.watsup:226.8-226.20] {unop}  :  {unop_numtype}
[notation ../spec/3-typing.watsup:226.16-226.20] unop  :  unop_numtype
[elab ../spec/3-typing.watsup:226.16-226.20] unop  :  unop_numtype
[notation ../spec/3-typing.watsup:226.8-226.20] {}  :  {}
[notation ../spec/3-typing.watsup:226.23-226.31] nt -> nt  :  functype
[elab ../spec/3-typing.watsup:226.23-226.31] nt -> nt  :  functype
[notation ../spec/3-typing.watsup:226.23-226.31] nt -> nt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:226.23-226.25] nt  :  resulttype
[elab ../spec/3-typing.watsup:226.23-226.25] nt  :  resulttype
[notation ../spec/3-typing.watsup:226.29-226.31] nt  :  resulttype
[elab ../spec/3-typing.watsup:226.29-226.31] nt  :  resulttype
[notation ../spec/3-typing.watsup:229.3-229.36] C |- {BINOP nt binop} : {nt nt} -> nt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:229.3-229.4] C  :  context
[elab ../spec/3-typing.watsup:229.3-229.4] C  :  context
[notation ../spec/3-typing.watsup:229.8-229.36] {BINOP nt binop} : {nt nt} -> nt  :  instr : functype
[notation ../spec/3-typing.watsup:229.8-229.22] {BINOP nt binop}  :  instr
[elab ../spec/3-typing.watsup:229.8-229.22] {BINOP nt binop}  :  instr
[notation ../spec/3-typing.watsup:229.8-229.22] {nt binop}  :  {numtype binop_numtype}
[notation ../spec/3-typing.watsup:229.14-229.16] nt  :  numtype
[elab ../spec/3-typing.watsup:229.14-229.16] nt  :  numtype
[notation ../spec/3-typing.watsup:229.8-229.22] {binop}  :  {binop_numtype}
[notation ../spec/3-typing.watsup:229.17-229.22] binop  :  binop_numtype
[elab ../spec/3-typing.watsup:229.17-229.22] binop  :  binop_numtype
[notation ../spec/3-typing.watsup:229.8-229.22] {}  :  {}
[notation ../spec/3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  functype
[elab ../spec/3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  functype
[notation ../spec/3-typing.watsup:229.25-229.36] {nt nt} -> nt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:229.25-229.30] {nt nt}  :  resulttype
[elab ../spec/3-typing.watsup:229.25-229.30] {nt nt}  :  resulttype
[elab ../spec/3-typing.watsup:229.25-229.27] nt  :  resulttype
[elab ../spec/3-typing.watsup:229.28-229.30] nt  :  resulttype
[notation ../spec/3-typing.watsup:229.34-229.36] nt  :  resulttype
[elab ../spec/3-typing.watsup:229.34-229.36] nt  :  resulttype
[notation ../spec/3-typing.watsup:232.3-232.36] C |- {TESTOP nt testop} : nt -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:232.3-232.4] C  :  context
[elab ../spec/3-typing.watsup:232.3-232.4] C  :  context
[notation ../spec/3-typing.watsup:232.8-232.36] {TESTOP nt testop} : nt -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:232.8-232.24] {TESTOP nt testop}  :  instr
[elab ../spec/3-typing.watsup:232.8-232.24] {TESTOP nt testop}  :  instr
[notation ../spec/3-typing.watsup:232.8-232.24] {nt testop}  :  {numtype testop_numtype}
[notation ../spec/3-typing.watsup:232.15-232.17] nt  :  numtype
[elab ../spec/3-typing.watsup:232.15-232.17] nt  :  numtype
[notation ../spec/3-typing.watsup:232.8-232.24] {testop}  :  {testop_numtype}
[notation ../spec/3-typing.watsup:232.18-232.24] testop  :  testop_numtype
[elab ../spec/3-typing.watsup:232.18-232.24] testop  :  testop_numtype
[notation ../spec/3-typing.watsup:232.8-232.24] {}  :  {}
[notation ../spec/3-typing.watsup:232.27-232.36] nt -> I32  :  functype
[elab ../spec/3-typing.watsup:232.27-232.36] nt -> I32  :  functype
[notation ../spec/3-typing.watsup:232.27-232.36] nt -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:232.27-232.29] nt  :  resulttype
[elab ../spec/3-typing.watsup:232.27-232.29] nt  :  resulttype
[notation ../spec/3-typing.watsup:232.33-232.36] I32  :  resulttype
[elab ../spec/3-typing.watsup:232.33-232.36] I32  :  resulttype
[notation ../spec/3-typing.watsup:232.33-232.36] {}  :  {}
[notation ../spec/3-typing.watsup:235.3-235.37] C |- {RELOP nt relop} : {nt nt} -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:235.3-235.4] C  :  context
[elab ../spec/3-typing.watsup:235.3-235.4] C  :  context
[notation ../spec/3-typing.watsup:235.8-235.37] {RELOP nt relop} : {nt nt} -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:235.8-235.22] {RELOP nt relop}  :  instr
[elab ../spec/3-typing.watsup:235.8-235.22] {RELOP nt relop}  :  instr
[notation ../spec/3-typing.watsup:235.8-235.22] {nt relop}  :  {numtype relop_numtype}
[notation ../spec/3-typing.watsup:235.14-235.16] nt  :  numtype
[elab ../spec/3-typing.watsup:235.14-235.16] nt  :  numtype
[notation ../spec/3-typing.watsup:235.8-235.22] {relop}  :  {relop_numtype}
[notation ../spec/3-typing.watsup:235.17-235.22] relop  :  relop_numtype
[elab ../spec/3-typing.watsup:235.17-235.22] relop  :  relop_numtype
[notation ../spec/3-typing.watsup:235.8-235.22] {}  :  {}
[notation ../spec/3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  functype
[elab ../spec/3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  functype
[notation ../spec/3-typing.watsup:235.25-235.37] {nt nt} -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:235.25-235.30] {nt nt}  :  resulttype
[elab ../spec/3-typing.watsup:235.25-235.30] {nt nt}  :  resulttype
[elab ../spec/3-typing.watsup:235.25-235.27] nt  :  resulttype
[elab ../spec/3-typing.watsup:235.28-235.30] nt  :  resulttype
[notation ../spec/3-typing.watsup:235.34-235.37] I32  :  resulttype
[elab ../spec/3-typing.watsup:235.34-235.37] I32  :  resulttype
[notation ../spec/3-typing.watsup:235.34-235.37] {}  :  {}
[notation ../spec/3-typing.watsup:239.3-239.30] C |- {EXTEND nt n} : nt -> nt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:239.3-239.4] C  :  context
[elab ../spec/3-typing.watsup:239.3-239.4] C  :  context
[notation ../spec/3-typing.watsup:239.8-239.30] {EXTEND nt n} : nt -> nt  :  instr : functype
[notation ../spec/3-typing.watsup:239.8-239.19] {EXTEND nt n}  :  instr
[elab ../spec/3-typing.watsup:239.8-239.19] {EXTEND nt n}  :  instr
[notation ../spec/3-typing.watsup:239.8-239.19] {nt n}  :  {numtype n}
[notation ../spec/3-typing.watsup:239.15-239.17] nt  :  numtype
[elab ../spec/3-typing.watsup:239.15-239.17] nt  :  numtype
[notation ../spec/3-typing.watsup:239.8-239.19] {n}  :  {n}
[notation ../spec/3-typing.watsup:239.18-239.19] n  :  n
[elab ../spec/3-typing.watsup:239.18-239.19] n  :  n
[notation ../spec/3-typing.watsup:239.8-239.19] {}  :  {}
[notation ../spec/3-typing.watsup:239.22-239.30] nt -> nt  :  functype
[elab ../spec/3-typing.watsup:239.22-239.30] nt -> nt  :  functype
[notation ../spec/3-typing.watsup:239.22-239.30] nt -> nt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:239.22-239.24] nt  :  resulttype
[elab ../spec/3-typing.watsup:239.22-239.24] nt  :  resulttype
[notation ../spec/3-typing.watsup:239.28-239.30] nt  :  resulttype
[elab ../spec/3-typing.watsup:239.28-239.30] nt  :  resulttype
[elab ../spec/3-typing.watsup:240.9-240.23] n <= $size(nt)  :  bool
[elab ../spec/3-typing.watsup:240.9-240.10] n  :  nat
[elab ../spec/3-typing.watsup:240.14-240.23] $size(nt)  :  nat
[elab ../spec/3-typing.watsup:240.19-240.23] (nt)  :  (valtype)
[elab ../spec/3-typing.watsup:240.20-240.22] nt  :  (valtype)
[notation ../spec/3-typing.watsup:243.3-243.50] C |- {CVTOP nt_1 REINTERPRET nt_2} : nt_2 -> nt_1  :  context |- instr : functype
[notation ../spec/3-typing.watsup:243.3-243.4] C  :  context
[elab ../spec/3-typing.watsup:243.3-243.4] C  :  context
[notation ../spec/3-typing.watsup:243.8-243.50] {CVTOP nt_1 REINTERPRET nt_2} : nt_2 -> nt_1  :  instr : functype
[notation ../spec/3-typing.watsup:243.8-243.35] {CVTOP nt_1 REINTERPRET nt_2}  :  instr
[elab ../spec/3-typing.watsup:243.8-243.35] {CVTOP nt_1 REINTERPRET nt_2}  :  instr
[notation ../spec/3-typing.watsup:243.8-243.35] {nt_1 REINTERPRET nt_2}  :  {numtype cvtop numtype sx?}
[notation ../spec/3-typing.watsup:243.14-243.18] nt_1  :  numtype
[elab ../spec/3-typing.watsup:243.14-243.18] nt_1  :  numtype
[notation ../spec/3-typing.watsup:243.8-243.35] {REINTERPRET nt_2}  :  {cvtop numtype sx?}
[notation ../spec/3-typing.watsup:243.19-243.30] REINTERPRET  :  cvtop
[elab ../spec/3-typing.watsup:243.19-243.30] REINTERPRET  :  cvtop
[notation ../spec/3-typing.watsup:243.19-243.30] {}  :  {}
[notation ../spec/3-typing.watsup:243.8-243.35] {nt_2}  :  {numtype sx?}
[notation ../spec/3-typing.watsup:243.31-243.35] nt_2  :  numtype
[elab ../spec/3-typing.watsup:243.31-243.35] nt_2  :  numtype
[notation ../spec/3-typing.watsup:243.8-243.35] {}  :  {sx?}
[notation ../spec/3-typing.watsup:243.8-243.35] {}  :  sx?
[niteration ../spec/3-typing.watsup:243.8-243.35]   :  sx?
[notation ../spec/3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  functype
[elab ../spec/3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  functype
[notation ../spec/3-typing.watsup:243.38-243.50] nt_2 -> nt_1  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:243.38-243.42] nt_2  :  resulttype
[elab ../spec/3-typing.watsup:243.38-243.42] nt_2  :  resulttype
[notation ../spec/3-typing.watsup:243.46-243.50] nt_1  :  resulttype
[elab ../spec/3-typing.watsup:243.46-243.50] nt_1  :  resulttype
[elab ../spec/3-typing.watsup:244.9-244.22] nt_1 =/= nt_2  :  bool
[elab ../spec/3-typing.watsup:244.9-244.13] nt_1  :  numtype
[elab ../spec/3-typing.watsup:244.18-244.22] nt_2  :  numtype
[elab ../spec/3-typing.watsup:245.9-245.34] $size(nt_1) = $size(nt_2)  :  bool
[elab ../spec/3-typing.watsup:245.9-245.20] $size(nt_1)  :  nat
[elab ../spec/3-typing.watsup:245.14-245.20] (nt_1)  :  (valtype)
[elab ../spec/3-typing.watsup:245.15-245.19] nt_1  :  (valtype)
[elab ../spec/3-typing.watsup:245.23-245.34] $size(nt_2)  :  nat
[elab ../spec/3-typing.watsup:245.28-245.34] (nt_2)  :  (valtype)
[elab ../spec/3-typing.watsup:245.29-245.33] nt_2  :  (valtype)
[notation ../spec/3-typing.watsup:248.3-248.50] C |- {CVTOP in_1 CONVERT in_2 sx?} : in_2 -> in_1  :  context |- instr : functype
[notation ../spec/3-typing.watsup:248.3-248.4] C  :  context
[elab ../spec/3-typing.watsup:248.3-248.4] C  :  context
[notation ../spec/3-typing.watsup:248.8-248.50] {CVTOP in_1 CONVERT in_2 sx?} : in_2 -> in_1  :  instr : functype
[notation ../spec/3-typing.watsup:248.8-248.35] {CVTOP in_1 CONVERT in_2 sx?}  :  instr
[elab ../spec/3-typing.watsup:248.8-248.35] {CVTOP in_1 CONVERT in_2 sx?}  :  instr
[notation ../spec/3-typing.watsup:248.8-248.35] {in_1 CONVERT in_2 sx?}  :  {numtype cvtop numtype sx?}
[notation ../spec/3-typing.watsup:248.14-248.18] in_1  :  numtype
[elab ../spec/3-typing.watsup:248.14-248.18] in_1  :  numtype
[notation ../spec/3-typing.watsup:248.8-248.35] {CONVERT in_2 sx?}  :  {cvtop numtype sx?}
[notation ../spec/3-typing.watsup:248.19-248.26] CONVERT  :  cvtop
[elab ../spec/3-typing.watsup:248.19-248.26] CONVERT  :  cvtop
[notation ../spec/3-typing.watsup:248.19-248.26] {}  :  {}
[notation ../spec/3-typing.watsup:248.8-248.35] {in_2 sx?}  :  {numtype sx?}
[notation ../spec/3-typing.watsup:248.27-248.31] in_2  :  numtype
[elab ../spec/3-typing.watsup:248.27-248.31] in_2  :  numtype
[notation ../spec/3-typing.watsup:248.8-248.35] {sx?}  :  {sx?}
[notation ../spec/3-typing.watsup:248.8-248.35] {sx?}  :  sx?
[elab ../spec/3-typing.watsup:248.32-248.35] sx?  :  sx?
[elab ../spec/3-typing.watsup:248.32-248.34] sx  :  sx
[notation ../spec/3-typing.watsup:248.38-248.50] in_2 -> in_1  :  functype
[elab ../spec/3-typing.watsup:248.38-248.50] in_2 -> in_1  :  functype
[notation ../spec/3-typing.watsup:248.38-248.50] in_2 -> in_1  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:248.38-248.42] in_2  :  resulttype
[elab ../spec/3-typing.watsup:248.38-248.42] in_2  :  resulttype
[notation ../spec/3-typing.watsup:248.46-248.50] in_1  :  resulttype
[elab ../spec/3-typing.watsup:248.46-248.50] in_1  :  resulttype
[elab ../spec/3-typing.watsup:249.9-249.22] in_1 =/= in_2  :  bool
[elab ../spec/3-typing.watsup:249.9-249.13] in_1  :  in
[elab ../spec/3-typing.watsup:249.18-249.22] in_2  :  in
[elab ../spec/3-typing.watsup:250.9-250.52] sx? = epsilon <=> $size(in_1) > $size(in_2)  :  bool
[elab ../spec/3-typing.watsup:250.9-250.22] sx? = epsilon  :  bool
[elab ../spec/3-typing.watsup:250.9-250.12] sx?  :  sx?
[elab ../spec/3-typing.watsup:250.9-250.11] sx  :  sx
[elab ../spec/3-typing.watsup:250.15-250.22] epsilon  :  sx?
[elab ../spec/3-typing.watsup:250.27-250.52] $size(in_1) > $size(in_2)  :  bool
[elab ../spec/3-typing.watsup:250.27-250.38] $size(in_1)  :  nat
[elab ../spec/3-typing.watsup:250.32-250.38] (in_1)  :  (valtype)
[elab ../spec/3-typing.watsup:250.33-250.37] in_1  :  (valtype)
[elab ../spec/3-typing.watsup:250.41-250.52] $size(in_2)  :  nat
[elab ../spec/3-typing.watsup:250.46-250.52] (in_2)  :  (valtype)
[elab ../spec/3-typing.watsup:250.47-250.51] in_2  :  (valtype)
[notation ../spec/3-typing.watsup:253.3-253.46] C |- {CVTOP fn_1 CONVERT fn_2} : fn_2 -> fn_1  :  context |- instr : functype
[notation ../spec/3-typing.watsup:253.3-253.4] C  :  context
[elab ../spec/3-typing.watsup:253.3-253.4] C  :  context
[notation ../spec/3-typing.watsup:253.8-253.46] {CVTOP fn_1 CONVERT fn_2} : fn_2 -> fn_1  :  instr : functype
[notation ../spec/3-typing.watsup:253.8-253.31] {CVTOP fn_1 CONVERT fn_2}  :  instr
[elab ../spec/3-typing.watsup:253.8-253.31] {CVTOP fn_1 CONVERT fn_2}  :  instr
[notation ../spec/3-typing.watsup:253.8-253.31] {fn_1 CONVERT fn_2}  :  {numtype cvtop numtype sx?}
[notation ../spec/3-typing.watsup:253.14-253.18] fn_1  :  numtype
[elab ../spec/3-typing.watsup:253.14-253.18] fn_1  :  numtype
[notation ../spec/3-typing.watsup:253.8-253.31] {CONVERT fn_2}  :  {cvtop numtype sx?}
[notation ../spec/3-typing.watsup:253.19-253.26] CONVERT  :  cvtop
[elab ../spec/3-typing.watsup:253.19-253.26] CONVERT  :  cvtop
[notation ../spec/3-typing.watsup:253.19-253.26] {}  :  {}
[notation ../spec/3-typing.watsup:253.8-253.31] {fn_2}  :  {numtype sx?}
[notation ../spec/3-typing.watsup:253.27-253.31] fn_2  :  numtype
[elab ../spec/3-typing.watsup:253.27-253.31] fn_2  :  numtype
[notation ../spec/3-typing.watsup:253.8-253.31] {}  :  {sx?}
[notation ../spec/3-typing.watsup:253.8-253.31] {}  :  sx?
[niteration ../spec/3-typing.watsup:253.8-253.31]   :  sx?
[notation ../spec/3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  functype
[elab ../spec/3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  functype
[notation ../spec/3-typing.watsup:253.34-253.46] fn_2 -> fn_1  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:253.34-253.38] fn_2  :  resulttype
[elab ../spec/3-typing.watsup:253.34-253.38] fn_2  :  resulttype
[notation ../spec/3-typing.watsup:253.42-253.46] fn_1  :  resulttype
[elab ../spec/3-typing.watsup:253.42-253.46] fn_1  :  resulttype
[elab ../spec/3-typing.watsup:254.9-254.22] fn_1 =/= fn_2  :  bool
[elab ../spec/3-typing.watsup:254.9-254.13] fn_1  :  fn
[elab ../spec/3-typing.watsup:254.18-254.22] fn_2  :  fn
[notation ../spec/3-typing.watsup:258.3-258.35] C |- {REF.NULL rt} : epsilon -> rt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:258.3-258.4] C  :  context
[elab ../spec/3-typing.watsup:258.3-258.4] C  :  context
[notation ../spec/3-typing.watsup:258.8-258.35] {REF.NULL rt} : epsilon -> rt  :  instr : functype
[notation ../spec/3-typing.watsup:258.8-258.19] {REF.NULL rt}  :  instr
[elab ../spec/3-typing.watsup:258.8-258.19] {REF.NULL rt}  :  instr
[notation ../spec/3-typing.watsup:258.8-258.19] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:258.17-258.19] rt  :  reftype
[elab ../spec/3-typing.watsup:258.17-258.19] rt  :  reftype
[notation ../spec/3-typing.watsup:258.8-258.19] {}  :  {}
[notation ../spec/3-typing.watsup:258.22-258.35] epsilon -> rt  :  functype
[elab ../spec/3-typing.watsup:258.22-258.35] epsilon -> rt  :  functype
[notation ../spec/3-typing.watsup:258.22-258.35] epsilon -> rt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:258.22-258.29] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:258.22-258.29] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:258.33-258.35] rt  :  resulttype
[elab ../spec/3-typing.watsup:258.33-258.35] rt  :  resulttype
[notation ../spec/3-typing.watsup:261.3-261.39] C |- {REF.FUNC x} : epsilon -> FUNCREF  :  context |- instr : functype
[notation ../spec/3-typing.watsup:261.3-261.4] C  :  context
[elab ../spec/3-typing.watsup:261.3-261.4] C  :  context
[notation ../spec/3-typing.watsup:261.8-261.39] {REF.FUNC x} : epsilon -> FUNCREF  :  instr : functype
[notation ../spec/3-typing.watsup:261.8-261.18] {REF.FUNC x}  :  instr
[elab ../spec/3-typing.watsup:261.8-261.18] {REF.FUNC x}  :  instr
[notation ../spec/3-typing.watsup:261.8-261.18] {x}  :  {funcidx}
[notation ../spec/3-typing.watsup:261.17-261.18] x  :  funcidx
[elab ../spec/3-typing.watsup:261.17-261.18] x  :  funcidx
[notation ../spec/3-typing.watsup:261.8-261.18] {}  :  {}
[notation ../spec/3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  functype
[elab ../spec/3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  functype
[notation ../spec/3-typing.watsup:261.21-261.39] epsilon -> FUNCREF  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:261.21-261.28] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:261.21-261.28] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:261.32-261.39] FUNCREF  :  resulttype
[elab ../spec/3-typing.watsup:261.32-261.39] FUNCREF  :  resulttype
[notation ../spec/3-typing.watsup:261.32-261.39] {}  :  {}
[elab ../spec/3-typing.watsup:262.9-262.23] C.FUNC[x] = ft  :  bool
[elab ../spec/3-typing.watsup:262.9-262.18] C.FUNC[x]  :  functype
[elab ../spec/3-typing.watsup:262.9-262.15] C.FUNC  :  functype*
[elab ../spec/3-typing.watsup:262.9-262.10] C  :  context
[elab ../spec/3-typing.watsup:262.16-262.17] x  :  nat
[elab ../spec/3-typing.watsup:262.21-262.23] ft  :  functype
[notation ../spec/3-typing.watsup:265.3-265.31] C |- REF.IS_NULL : rt -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:265.3-265.4] C  :  context
[elab ../spec/3-typing.watsup:265.3-265.4] C  :  context
[notation ../spec/3-typing.watsup:265.8-265.31] REF.IS_NULL : rt -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:265.8-265.19] REF.IS_NULL  :  instr
[elab ../spec/3-typing.watsup:265.8-265.19] REF.IS_NULL  :  instr
[notation ../spec/3-typing.watsup:265.8-265.19] {}  :  {}
[notation ../spec/3-typing.watsup:265.22-265.31] rt -> I32  :  functype
[elab ../spec/3-typing.watsup:265.22-265.31] rt -> I32  :  functype
[notation ../spec/3-typing.watsup:265.22-265.31] rt -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:265.22-265.24] rt  :  resulttype
[elab ../spec/3-typing.watsup:265.22-265.24] rt  :  resulttype
[notation ../spec/3-typing.watsup:265.28-265.31] I32  :  resulttype
[elab ../spec/3-typing.watsup:265.28-265.31] I32  :  resulttype
[notation ../spec/3-typing.watsup:265.28-265.31] {}  :  {}
[notation ../spec/3-typing.watsup:269.3-269.34] C |- {LOCAL.GET x} : epsilon -> t  :  context |- instr : functype
[notation ../spec/3-typing.watsup:269.3-269.4] C  :  context
[elab ../spec/3-typing.watsup:269.3-269.4] C  :  context
[notation ../spec/3-typing.watsup:269.8-269.34] {LOCAL.GET x} : epsilon -> t  :  instr : functype
[notation ../spec/3-typing.watsup:269.8-269.19] {LOCAL.GET x}  :  instr
[elab ../spec/3-typing.watsup:269.8-269.19] {LOCAL.GET x}  :  instr
[notation ../spec/3-typing.watsup:269.8-269.19] {x}  :  {localidx}
[notation ../spec/3-typing.watsup:269.18-269.19] x  :  localidx
[elab ../spec/3-typing.watsup:269.18-269.19] x  :  localidx
[notation ../spec/3-typing.watsup:269.8-269.19] {}  :  {}
[notation ../spec/3-typing.watsup:269.22-269.34] epsilon -> t  :  functype
[elab ../spec/3-typing.watsup:269.22-269.34] epsilon -> t  :  functype
[notation ../spec/3-typing.watsup:269.22-269.34] epsilon -> t  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:269.22-269.29] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:269.22-269.29] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:269.33-269.34] t  :  resulttype
[elab ../spec/3-typing.watsup:269.33-269.34] t  :  resulttype
[elab ../spec/3-typing.watsup:270.9-270.23] C.LOCAL[x] = t  :  bool
[elab ../spec/3-typing.watsup:270.9-270.19] C.LOCAL[x]  :  valtype
[elab ../spec/3-typing.watsup:270.9-270.16] C.LOCAL  :  valtype*
[elab ../spec/3-typing.watsup:270.9-270.10] C  :  context
[elab ../spec/3-typing.watsup:270.17-270.18] x  :  nat
[elab ../spec/3-typing.watsup:270.22-270.23] t  :  valtype
[notation ../spec/3-typing.watsup:273.3-273.34] C |- {LOCAL.SET x} : t -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:273.3-273.4] C  :  context
[elab ../spec/3-typing.watsup:273.3-273.4] C  :  context
[notation ../spec/3-typing.watsup:273.8-273.34] {LOCAL.SET x} : t -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:273.8-273.19] {LOCAL.SET x}  :  instr
[elab ../spec/3-typing.watsup:273.8-273.19] {LOCAL.SET x}  :  instr
[notation ../spec/3-typing.watsup:273.8-273.19] {x}  :  {localidx}
[notation ../spec/3-typing.watsup:273.18-273.19] x  :  localidx
[elab ../spec/3-typing.watsup:273.18-273.19] x  :  localidx
[notation ../spec/3-typing.watsup:273.8-273.19] {}  :  {}
[notation ../spec/3-typing.watsup:273.22-273.34] t -> epsilon  :  functype
[elab ../spec/3-typing.watsup:273.22-273.34] t -> epsilon  :  functype
[notation ../spec/3-typing.watsup:273.22-273.34] t -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:273.22-273.23] t  :  resulttype
[elab ../spec/3-typing.watsup:273.22-273.23] t  :  resulttype
[notation ../spec/3-typing.watsup:273.27-273.34] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:273.27-273.34] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:274.9-274.23] C.LOCAL[x] = t  :  bool
[elab ../spec/3-typing.watsup:274.9-274.19] C.LOCAL[x]  :  valtype
[elab ../spec/3-typing.watsup:274.9-274.16] C.LOCAL  :  valtype*
[elab ../spec/3-typing.watsup:274.9-274.10] C  :  context
[elab ../spec/3-typing.watsup:274.17-274.18] x  :  nat
[elab ../spec/3-typing.watsup:274.22-274.23] t  :  valtype
[notation ../spec/3-typing.watsup:277.3-277.28] C |- {LOCAL.TEE x} : t -> t  :  context |- instr : functype
[notation ../spec/3-typing.watsup:277.3-277.4] C  :  context
[elab ../spec/3-typing.watsup:277.3-277.4] C  :  context
[notation ../spec/3-typing.watsup:277.8-277.28] {LOCAL.TEE x} : t -> t  :  instr : functype
[notation ../spec/3-typing.watsup:277.8-277.19] {LOCAL.TEE x}  :  instr
[elab ../spec/3-typing.watsup:277.8-277.19] {LOCAL.TEE x}  :  instr
[notation ../spec/3-typing.watsup:277.8-277.19] {x}  :  {localidx}
[notation ../spec/3-typing.watsup:277.18-277.19] x  :  localidx
[elab ../spec/3-typing.watsup:277.18-277.19] x  :  localidx
[notation ../spec/3-typing.watsup:277.8-277.19] {}  :  {}
[notation ../spec/3-typing.watsup:277.22-277.28] t -> t  :  functype
[elab ../spec/3-typing.watsup:277.22-277.28] t -> t  :  functype
[notation ../spec/3-typing.watsup:277.22-277.28] t -> t  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:277.22-277.23] t  :  resulttype
[elab ../spec/3-typing.watsup:277.22-277.23] t  :  resulttype
[notation ../spec/3-typing.watsup:277.27-277.28] t  :  resulttype
[elab ../spec/3-typing.watsup:277.27-277.28] t  :  resulttype
[elab ../spec/3-typing.watsup:278.9-278.23] C.LOCAL[x] = t  :  bool
[elab ../spec/3-typing.watsup:278.9-278.19] C.LOCAL[x]  :  valtype
[elab ../spec/3-typing.watsup:278.9-278.16] C.LOCAL  :  valtype*
[elab ../spec/3-typing.watsup:278.9-278.10] C  :  context
[elab ../spec/3-typing.watsup:278.17-278.18] x  :  nat
[elab ../spec/3-typing.watsup:278.22-278.23] t  :  valtype
[notation ../spec/3-typing.watsup:282.3-282.35] C |- {GLOBAL.GET x} : epsilon -> t  :  context |- instr : functype
[notation ../spec/3-typing.watsup:282.3-282.4] C  :  context
[elab ../spec/3-typing.watsup:282.3-282.4] C  :  context
[notation ../spec/3-typing.watsup:282.8-282.35] {GLOBAL.GET x} : epsilon -> t  :  instr : functype
[notation ../spec/3-typing.watsup:282.8-282.20] {GLOBAL.GET x}  :  instr
[elab ../spec/3-typing.watsup:282.8-282.20] {GLOBAL.GET x}  :  instr
[notation ../spec/3-typing.watsup:282.8-282.20] {x}  :  {globalidx}
[notation ../spec/3-typing.watsup:282.19-282.20] x  :  globalidx
[elab ../spec/3-typing.watsup:282.19-282.20] x  :  globalidx
[notation ../spec/3-typing.watsup:282.8-282.20] {}  :  {}
[notation ../spec/3-typing.watsup:282.23-282.35] epsilon -> t  :  functype
[elab ../spec/3-typing.watsup:282.23-282.35] epsilon -> t  :  functype
[notation ../spec/3-typing.watsup:282.23-282.35] epsilon -> t  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:282.23-282.30] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:282.23-282.30] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:282.34-282.35] t  :  resulttype
[elab ../spec/3-typing.watsup:282.34-282.35] t  :  resulttype
[elab ../spec/3-typing.watsup:283.9-283.29] C.GLOBAL[x] = {MUT? t}  :  bool
[elab ../spec/3-typing.watsup:283.9-283.20] C.GLOBAL[x]  :  globaltype
[elab ../spec/3-typing.watsup:283.9-283.17] C.GLOBAL  :  globaltype*
[elab ../spec/3-typing.watsup:283.9-283.10] C  :  context
[elab ../spec/3-typing.watsup:283.18-283.19] x  :  nat
[elab ../spec/3-typing.watsup:283.23-283.29] {MUT? t}  :  globaltype
[notation ../spec/3-typing.watsup:283.23-283.29] {MUT? t}  :  {MUT? valtype}
[notation ../spec/3-typing.watsup:283.23-283.27] MUT?  :  MUT?
[notation ../spec/3-typing.watsup:283.23-283.26] MUT  :  MUT
[notation ../spec/3-typing.watsup:283.23-283.29] {t}  :  {valtype}
[notation ../spec/3-typing.watsup:283.28-283.29] t  :  valtype
[elab ../spec/3-typing.watsup:283.28-283.29] t  :  valtype
[notation ../spec/3-typing.watsup:283.23-283.29] {}  :  {}
[notation ../spec/3-typing.watsup:286.3-286.35] C |- {GLOBAL.SET x} : t -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:286.3-286.4] C  :  context
[elab ../spec/3-typing.watsup:286.3-286.4] C  :  context
[notation ../spec/3-typing.watsup:286.8-286.35] {GLOBAL.SET x} : t -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:286.8-286.20] {GLOBAL.SET x}  :  instr
[elab ../spec/3-typing.watsup:286.8-286.20] {GLOBAL.SET x}  :  instr
[notation ../spec/3-typing.watsup:286.8-286.20] {x}  :  {globalidx}
[notation ../spec/3-typing.watsup:286.19-286.20] x  :  globalidx
[elab ../spec/3-typing.watsup:286.19-286.20] x  :  globalidx
[notation ../spec/3-typing.watsup:286.8-286.20] {}  :  {}
[notation ../spec/3-typing.watsup:286.23-286.35] t -> epsilon  :  functype
[elab ../spec/3-typing.watsup:286.23-286.35] t -> epsilon  :  functype
[notation ../spec/3-typing.watsup:286.23-286.35] t -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:286.23-286.24] t  :  resulttype
[elab ../spec/3-typing.watsup:286.23-286.24] t  :  resulttype
[notation ../spec/3-typing.watsup:286.28-286.35] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:286.28-286.35] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:287.9-287.28] C.GLOBAL[x] = {MUT t}  :  bool
[elab ../spec/3-typing.watsup:287.9-287.20] C.GLOBAL[x]  :  globaltype
[elab ../spec/3-typing.watsup:287.9-287.17] C.GLOBAL  :  globaltype*
[elab ../spec/3-typing.watsup:287.9-287.10] C  :  context
[elab ../spec/3-typing.watsup:287.18-287.19] x  :  nat
[elab ../spec/3-typing.watsup:287.23-287.28] {MUT t}  :  globaltype
[notation ../spec/3-typing.watsup:287.23-287.28] {MUT t}  :  {MUT? valtype}
[notation ../spec/3-typing.watsup:287.23-287.26] MUT  :  MUT?
[notation ../spec/3-typing.watsup:287.23-287.26] MUT  :  MUT
[notation ../spec/3-typing.watsup:287.23-287.28] {t}  :  {valtype}
[notation ../spec/3-typing.watsup:287.27-287.28] t  :  valtype
[elab ../spec/3-typing.watsup:287.27-287.28] t  :  valtype
[notation ../spec/3-typing.watsup:287.23-287.28] {}  :  {}
[notation ../spec/3-typing.watsup:291.3-291.31] C |- {TABLE.GET x} : I32 -> rt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:291.3-291.4] C  :  context
[elab ../spec/3-typing.watsup:291.3-291.4] C  :  context
[notation ../spec/3-typing.watsup:291.8-291.31] {TABLE.GET x} : I32 -> rt  :  instr : functype
[notation ../spec/3-typing.watsup:291.8-291.19] {TABLE.GET x}  :  instr
[elab ../spec/3-typing.watsup:291.8-291.19] {TABLE.GET x}  :  instr
[notation ../spec/3-typing.watsup:291.8-291.19] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:291.18-291.19] x  :  tableidx
[elab ../spec/3-typing.watsup:291.18-291.19] x  :  tableidx
[notation ../spec/3-typing.watsup:291.8-291.19] {}  :  {}
[notation ../spec/3-typing.watsup:291.22-291.31] I32 -> rt  :  functype
[elab ../spec/3-typing.watsup:291.22-291.31] I32 -> rt  :  functype
[notation ../spec/3-typing.watsup:291.22-291.31] I32 -> rt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:291.22-291.25] I32  :  resulttype
[elab ../spec/3-typing.watsup:291.22-291.25] I32  :  resulttype
[notation ../spec/3-typing.watsup:291.22-291.25] {}  :  {}
[notation ../spec/3-typing.watsup:291.29-291.31] rt  :  resulttype
[elab ../spec/3-typing.watsup:291.29-291.31] rt  :  resulttype
[elab ../spec/3-typing.watsup:292.9-292.28] C.TABLE[x] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:292.9-292.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:292.9-292.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:292.9-292.10] C  :  context
[elab ../spec/3-typing.watsup:292.17-292.18] x  :  nat
[elab ../spec/3-typing.watsup:292.22-292.28] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:292.22-292.28] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:292.22-292.25] lim  :  limits
[elab ../spec/3-typing.watsup:292.22-292.25] lim  :  limits
[notation ../spec/3-typing.watsup:292.22-292.28] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:292.26-292.28] rt  :  reftype
[elab ../spec/3-typing.watsup:292.26-292.28] rt  :  reftype
[notation ../spec/3-typing.watsup:292.22-292.28] {}  :  {}
[notation ../spec/3-typing.watsup:295.3-295.39] C |- {TABLE.SET x} : {I32 rt} -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:295.3-295.4] C  :  context
[elab ../spec/3-typing.watsup:295.3-295.4] C  :  context
[notation ../spec/3-typing.watsup:295.8-295.39] {TABLE.SET x} : {I32 rt} -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:295.8-295.19] {TABLE.SET x}  :  instr
[elab ../spec/3-typing.watsup:295.8-295.19] {TABLE.SET x}  :  instr
[notation ../spec/3-typing.watsup:295.8-295.19] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:295.18-295.19] x  :  tableidx
[elab ../spec/3-typing.watsup:295.18-295.19] x  :  tableidx
[notation ../spec/3-typing.watsup:295.8-295.19] {}  :  {}
[notation ../spec/3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  functype
[elab ../spec/3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  functype
[notation ../spec/3-typing.watsup:295.22-295.39] {I32 rt} -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:295.22-295.28] {I32 rt}  :  resulttype
[elab ../spec/3-typing.watsup:295.22-295.28] {I32 rt}  :  resulttype
[elab ../spec/3-typing.watsup:295.22-295.25] I32  :  resulttype
[notation ../spec/3-typing.watsup:295.22-295.25] {}  :  {}
[elab ../spec/3-typing.watsup:295.26-295.28] rt  :  resulttype
[notation ../spec/3-typing.watsup:295.32-295.39] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:295.32-295.39] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:296.9-296.28] C.TABLE[x] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:296.9-296.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:296.9-296.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:296.9-296.10] C  :  context
[elab ../spec/3-typing.watsup:296.17-296.18] x  :  nat
[elab ../spec/3-typing.watsup:296.22-296.28] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:296.22-296.28] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:296.22-296.25] lim  :  limits
[elab ../spec/3-typing.watsup:296.22-296.25] lim  :  limits
[notation ../spec/3-typing.watsup:296.22-296.28] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:296.26-296.28] rt  :  reftype
[elab ../spec/3-typing.watsup:296.26-296.28] rt  :  reftype
[notation ../spec/3-typing.watsup:296.22-296.28] {}  :  {}
[notation ../spec/3-typing.watsup:299.3-299.37] C |- {TABLE.SIZE x} : epsilon -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:299.3-299.4] C  :  context
[elab ../spec/3-typing.watsup:299.3-299.4] C  :  context
[notation ../spec/3-typing.watsup:299.8-299.37] {TABLE.SIZE x} : epsilon -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:299.8-299.20] {TABLE.SIZE x}  :  instr
[elab ../spec/3-typing.watsup:299.8-299.20] {TABLE.SIZE x}  :  instr
[notation ../spec/3-typing.watsup:299.8-299.20] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:299.19-299.20] x  :  tableidx
[elab ../spec/3-typing.watsup:299.19-299.20] x  :  tableidx
[notation ../spec/3-typing.watsup:299.8-299.20] {}  :  {}
[notation ../spec/3-typing.watsup:299.23-299.37] epsilon -> I32  :  functype
[elab ../spec/3-typing.watsup:299.23-299.37] epsilon -> I32  :  functype
[notation ../spec/3-typing.watsup:299.23-299.37] epsilon -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:299.23-299.30] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:299.23-299.30] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:299.34-299.37] I32  :  resulttype
[elab ../spec/3-typing.watsup:299.34-299.37] I32  :  resulttype
[notation ../spec/3-typing.watsup:299.34-299.37] {}  :  {}
[elab ../spec/3-typing.watsup:300.9-300.24] C.TABLE[x] = tt  :  bool
[elab ../spec/3-typing.watsup:300.9-300.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:300.9-300.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:300.9-300.10] C  :  context
[elab ../spec/3-typing.watsup:300.17-300.18] x  :  nat
[elab ../spec/3-typing.watsup:300.22-300.24] tt  :  tabletype
[notation ../spec/3-typing.watsup:303.3-303.36] C |- {TABLE.GROW x} : {rt I32} -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:303.3-303.4] C  :  context
[elab ../spec/3-typing.watsup:303.3-303.4] C  :  context
[notation ../spec/3-typing.watsup:303.8-303.36] {TABLE.GROW x} : {rt I32} -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:303.8-303.20] {TABLE.GROW x}  :  instr
[elab ../spec/3-typing.watsup:303.8-303.20] {TABLE.GROW x}  :  instr
[notation ../spec/3-typing.watsup:303.8-303.20] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:303.19-303.20] x  :  tableidx
[elab ../spec/3-typing.watsup:303.19-303.20] x  :  tableidx
[notation ../spec/3-typing.watsup:303.8-303.20] {}  :  {}
[notation ../spec/3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  functype
[elab ../spec/3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  functype
[notation ../spec/3-typing.watsup:303.23-303.36] {rt I32} -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:303.23-303.29] {rt I32}  :  resulttype
[elab ../spec/3-typing.watsup:303.23-303.29] {rt I32}  :  resulttype
[elab ../spec/3-typing.watsup:303.23-303.25] rt  :  resulttype
[elab ../spec/3-typing.watsup:303.26-303.29] I32  :  resulttype
[notation ../spec/3-typing.watsup:303.26-303.29] {}  :  {}
[notation ../spec/3-typing.watsup:303.33-303.36] I32  :  resulttype
[elab ../spec/3-typing.watsup:303.33-303.36] I32  :  resulttype
[notation ../spec/3-typing.watsup:303.33-303.36] {}  :  {}
[elab ../spec/3-typing.watsup:304.9-304.28] C.TABLE[x] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:304.9-304.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:304.9-304.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:304.9-304.10] C  :  context
[elab ../spec/3-typing.watsup:304.17-304.18] x  :  nat
[elab ../spec/3-typing.watsup:304.22-304.28] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:304.22-304.28] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:304.22-304.25] lim  :  limits
[elab ../spec/3-typing.watsup:304.22-304.25] lim  :  limits
[notation ../spec/3-typing.watsup:304.22-304.28] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:304.26-304.28] rt  :  reftype
[elab ../spec/3-typing.watsup:304.26-304.28] rt  :  reftype
[notation ../spec/3-typing.watsup:304.22-304.28] {}  :  {}
[notation ../spec/3-typing.watsup:307.3-307.44] C |- {TABLE.FILL x} : {I32 rt I32} -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:307.3-307.4] C  :  context
[elab ../spec/3-typing.watsup:307.3-307.4] C  :  context
[notation ../spec/3-typing.watsup:307.8-307.44] {TABLE.FILL x} : {I32 rt I32} -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:307.8-307.20] {TABLE.FILL x}  :  instr
[elab ../spec/3-typing.watsup:307.8-307.20] {TABLE.FILL x}  :  instr
[notation ../spec/3-typing.watsup:307.8-307.20] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:307.19-307.20] x  :  tableidx
[elab ../spec/3-typing.watsup:307.19-307.20] x  :  tableidx
[notation ../spec/3-typing.watsup:307.8-307.20] {}  :  {}
[notation ../spec/3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  functype
[elab ../spec/3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  functype
[notation ../spec/3-typing.watsup:307.23-307.44] {I32 rt I32} -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:307.23-307.33] {I32 rt I32}  :  resulttype
[elab ../spec/3-typing.watsup:307.23-307.33] {I32 rt I32}  :  resulttype
[elab ../spec/3-typing.watsup:307.23-307.26] I32  :  resulttype
[notation ../spec/3-typing.watsup:307.23-307.26] {}  :  {}
[elab ../spec/3-typing.watsup:307.27-307.29] rt  :  resulttype
[elab ../spec/3-typing.watsup:307.30-307.33] I32  :  resulttype
[notation ../spec/3-typing.watsup:307.30-307.33] {}  :  {}
[notation ../spec/3-typing.watsup:307.37-307.44] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:307.37-307.44] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:308.9-308.28] C.TABLE[x] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:308.9-308.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:308.9-308.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:308.9-308.10] C  :  context
[elab ../spec/3-typing.watsup:308.17-308.18] x  :  nat
[elab ../spec/3-typing.watsup:308.22-308.28] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:308.22-308.28] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:308.22-308.25] lim  :  limits
[elab ../spec/3-typing.watsup:308.22-308.25] lim  :  limits
[notation ../spec/3-typing.watsup:308.22-308.28] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:308.26-308.28] rt  :  reftype
[elab ../spec/3-typing.watsup:308.26-308.28] rt  :  reftype
[notation ../spec/3-typing.watsup:308.22-308.28] {}  :  {}
[notation ../spec/3-typing.watsup:311.3-311.51] C |- {TABLE.COPY x_1 x_2} : {I32 I32 I32} -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:311.3-311.4] C  :  context
[elab ../spec/3-typing.watsup:311.3-311.4] C  :  context
[notation ../spec/3-typing.watsup:311.8-311.51] {TABLE.COPY x_1 x_2} : {I32 I32 I32} -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:311.8-311.26] {TABLE.COPY x_1 x_2}  :  instr
[elab ../spec/3-typing.watsup:311.8-311.26] {TABLE.COPY x_1 x_2}  :  instr
[notation ../spec/3-typing.watsup:311.8-311.26] {x_1 x_2}  :  {tableidx tableidx}
[notation ../spec/3-typing.watsup:311.19-311.22] x_1  :  tableidx
[elab ../spec/3-typing.watsup:311.19-311.22] x_1  :  tableidx
[notation ../spec/3-typing.watsup:311.8-311.26] {x_2}  :  {tableidx}
[notation ../spec/3-typing.watsup:311.23-311.26] x_2  :  tableidx
[elab ../spec/3-typing.watsup:311.23-311.26] x_2  :  tableidx
[notation ../spec/3-typing.watsup:311.8-311.26] {}  :  {}
[notation ../spec/3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  functype
[elab ../spec/3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  functype
[notation ../spec/3-typing.watsup:311.29-311.51] {I32 I32 I32} -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:311.29-311.40] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:311.29-311.40] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:311.29-311.32] I32  :  resulttype
[notation ../spec/3-typing.watsup:311.29-311.32] {}  :  {}
[elab ../spec/3-typing.watsup:311.33-311.36] I32  :  resulttype
[notation ../spec/3-typing.watsup:311.33-311.36] {}  :  {}
[elab ../spec/3-typing.watsup:311.37-311.40] I32  :  resulttype
[notation ../spec/3-typing.watsup:311.37-311.40] {}  :  {}
[notation ../spec/3-typing.watsup:311.44-311.51] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:311.44-311.51] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:312.9-312.32] C.TABLE[x_1] = {lim_1 rt}  :  bool
[elab ../spec/3-typing.watsup:312.9-312.21] C.TABLE[x_1]  :  tabletype
[elab ../spec/3-typing.watsup:312.9-312.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:312.9-312.10] C  :  context
[elab ../spec/3-typing.watsup:312.17-312.20] x_1  :  nat
[elab ../spec/3-typing.watsup:312.24-312.32] {lim_1 rt}  :  tabletype
[notation ../spec/3-typing.watsup:312.24-312.32] {lim_1 rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:312.24-312.29] lim_1  :  limits
[elab ../spec/3-typing.watsup:312.24-312.29] lim_1  :  limits
[notation ../spec/3-typing.watsup:312.24-312.32] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:312.30-312.32] rt  :  reftype
[elab ../spec/3-typing.watsup:312.30-312.32] rt  :  reftype
[notation ../spec/3-typing.watsup:312.24-312.32] {}  :  {}
[elab ../spec/3-typing.watsup:313.9-313.32] C.TABLE[x_2] = {lim_2 rt}  :  bool
[elab ../spec/3-typing.watsup:313.9-313.21] C.TABLE[x_2]  :  tabletype
[elab ../spec/3-typing.watsup:313.9-313.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:313.9-313.10] C  :  context
[elab ../spec/3-typing.watsup:313.17-313.20] x_2  :  nat
[elab ../spec/3-typing.watsup:313.24-313.32] {lim_2 rt}  :  tabletype
[notation ../spec/3-typing.watsup:313.24-313.32] {lim_2 rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:313.24-313.29] lim_2  :  limits
[elab ../spec/3-typing.watsup:313.24-313.29] lim_2  :  limits
[notation ../spec/3-typing.watsup:313.24-313.32] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:313.30-313.32] rt  :  reftype
[elab ../spec/3-typing.watsup:313.30-313.32] rt  :  reftype
[notation ../spec/3-typing.watsup:313.24-313.32] {}  :  {}
[notation ../spec/3-typing.watsup:316.3-316.51] C |- {TABLE.INIT x_1 x_2} : {I32 I32 I32} -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:316.3-316.4] C  :  context
[elab ../spec/3-typing.watsup:316.3-316.4] C  :  context
[notation ../spec/3-typing.watsup:316.8-316.51] {TABLE.INIT x_1 x_2} : {I32 I32 I32} -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:316.8-316.26] {TABLE.INIT x_1 x_2}  :  instr
[elab ../spec/3-typing.watsup:316.8-316.26] {TABLE.INIT x_1 x_2}  :  instr
[notation ../spec/3-typing.watsup:316.8-316.26] {x_1 x_2}  :  {tableidx elemidx}
[notation ../spec/3-typing.watsup:316.19-316.22] x_1  :  tableidx
[elab ../spec/3-typing.watsup:316.19-316.22] x_1  :  tableidx
[notation ../spec/3-typing.watsup:316.8-316.26] {x_2}  :  {elemidx}
[notation ../spec/3-typing.watsup:316.23-316.26] x_2  :  elemidx
[elab ../spec/3-typing.watsup:316.23-316.26] x_2  :  elemidx
[notation ../spec/3-typing.watsup:316.8-316.26] {}  :  {}
[notation ../spec/3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  functype
[elab ../spec/3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  functype
[notation ../spec/3-typing.watsup:316.29-316.51] {I32 I32 I32} -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:316.29-316.40] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:316.29-316.40] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:316.29-316.32] I32  :  resulttype
[notation ../spec/3-typing.watsup:316.29-316.32] {}  :  {}
[elab ../spec/3-typing.watsup:316.33-316.36] I32  :  resulttype
[notation ../spec/3-typing.watsup:316.33-316.36] {}  :  {}
[elab ../spec/3-typing.watsup:316.37-316.40] I32  :  resulttype
[notation ../spec/3-typing.watsup:316.37-316.40] {}  :  {}
[notation ../spec/3-typing.watsup:316.44-316.51] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:316.44-316.51] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:317.9-317.30] C.TABLE[x_1] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:317.9-317.21] C.TABLE[x_1]  :  tabletype
[elab ../spec/3-typing.watsup:317.9-317.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:317.9-317.10] C  :  context
[elab ../spec/3-typing.watsup:317.17-317.20] x_1  :  nat
[elab ../spec/3-typing.watsup:317.24-317.30] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:317.24-317.30] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:317.24-317.27] lim  :  limits
[elab ../spec/3-typing.watsup:317.24-317.27] lim  :  limits
[notation ../spec/3-typing.watsup:317.24-317.30] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:317.28-317.30] rt  :  reftype
[elab ../spec/3-typing.watsup:317.28-317.30] rt  :  reftype
[notation ../spec/3-typing.watsup:317.24-317.30] {}  :  {}
[elab ../spec/3-typing.watsup:318.9-318.25] C.ELEM[x_2] = rt  :  bool
[elab ../spec/3-typing.watsup:318.9-318.20] C.ELEM[x_2]  :  elemtype
[elab ../spec/3-typing.watsup:318.9-318.15] C.ELEM  :  elemtype*
[elab ../spec/3-typing.watsup:318.9-318.10] C  :  context
[elab ../spec/3-typing.watsup:318.16-318.19] x_2  :  nat
[elab ../spec/3-typing.watsup:318.23-318.25] rt  :  elemtype
[notation ../spec/3-typing.watsup:321.3-321.40] C |- {ELEM.DROP x} : epsilon -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:321.3-321.4] C  :  context
[elab ../spec/3-typing.watsup:321.3-321.4] C  :  context
[notation ../spec/3-typing.watsup:321.8-321.40] {ELEM.DROP x} : epsilon -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:321.8-321.19] {ELEM.DROP x}  :  instr
[elab ../spec/3-typing.watsup:321.8-321.19] {ELEM.DROP x}  :  instr
[notation ../spec/3-typing.watsup:321.8-321.19] {x}  :  {elemidx}
[notation ../spec/3-typing.watsup:321.18-321.19] x  :  elemidx
[elab ../spec/3-typing.watsup:321.18-321.19] x  :  elemidx
[notation ../spec/3-typing.watsup:321.8-321.19] {}  :  {}
[notation ../spec/3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  functype
[elab ../spec/3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  functype
[notation ../spec/3-typing.watsup:321.22-321.40] epsilon -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:321.22-321.29] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:321.22-321.29] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:321.33-321.40] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:321.33-321.40] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:322.9-322.23] C.ELEM[x] = rt  :  bool
[elab ../spec/3-typing.watsup:322.9-322.18] C.ELEM[x]  :  elemtype
[elab ../spec/3-typing.watsup:322.9-322.15] C.ELEM  :  elemtype*
[elab ../spec/3-typing.watsup:322.9-322.10] C  :  context
[elab ../spec/3-typing.watsup:322.16-322.17] x  :  nat
[elab ../spec/3-typing.watsup:322.21-322.23] rt  :  elemtype
[notation ../spec/3-typing.watsup:326.3-326.36] C |- MEMORY.SIZE : epsilon -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:326.3-326.4] C  :  context
[elab ../spec/3-typing.watsup:326.3-326.4] C  :  context
[notation ../spec/3-typing.watsup:326.8-326.36] MEMORY.SIZE : epsilon -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:326.8-326.19] MEMORY.SIZE  :  instr
[elab ../spec/3-typing.watsup:326.8-326.19] MEMORY.SIZE  :  instr
[notation ../spec/3-typing.watsup:326.8-326.19] {}  :  {}
[notation ../spec/3-typing.watsup:326.22-326.36] epsilon -> I32  :  functype
[elab ../spec/3-typing.watsup:326.22-326.36] epsilon -> I32  :  functype
[notation ../spec/3-typing.watsup:326.22-326.36] epsilon -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:326.22-326.29] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:326.22-326.29] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:326.33-326.36] I32  :  resulttype
[elab ../spec/3-typing.watsup:326.33-326.36] I32  :  resulttype
[notation ../spec/3-typing.watsup:326.33-326.36] {}  :  {}
[elab ../spec/3-typing.watsup:327.9-327.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:327.9-327.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:327.9-327.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:327.9-327.10] C  :  context
[elab ../spec/3-typing.watsup:327.15-327.16] 0  :  nat
[elab ../spec/3-typing.watsup:327.20-327.22] mt  :  memtype
[notation ../spec/3-typing.watsup:330.3-330.32] C |- MEMORY.GROW : I32 -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:330.3-330.4] C  :  context
[elab ../spec/3-typing.watsup:330.3-330.4] C  :  context
[notation ../spec/3-typing.watsup:330.8-330.32] MEMORY.GROW : I32 -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:330.8-330.19] MEMORY.GROW  :  instr
[elab ../spec/3-typing.watsup:330.8-330.19] MEMORY.GROW  :  instr
[notation ../spec/3-typing.watsup:330.8-330.19] {}  :  {}
[notation ../spec/3-typing.watsup:330.22-330.32] I32 -> I32  :  functype
[elab ../spec/3-typing.watsup:330.22-330.32] I32 -> I32  :  functype
[notation ../spec/3-typing.watsup:330.22-330.32] I32 -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:330.22-330.25] I32  :  resulttype
[elab ../spec/3-typing.watsup:330.22-330.25] I32  :  resulttype
[notation ../spec/3-typing.watsup:330.22-330.25] {}  :  {}
[notation ../spec/3-typing.watsup:330.29-330.32] I32  :  resulttype
[elab ../spec/3-typing.watsup:330.29-330.32] I32  :  resulttype
[notation ../spec/3-typing.watsup:330.29-330.32] {}  :  {}
[elab ../spec/3-typing.watsup:331.9-331.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:331.9-331.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:331.9-331.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:331.9-331.10] C  :  context
[elab ../spec/3-typing.watsup:331.15-331.16] 0  :  nat
[elab ../spec/3-typing.watsup:331.20-331.22] mt  :  memtype
[notation ../spec/3-typing.watsup:334.3-334.40] C |- MEMORY.FILL : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:334.3-334.4] C  :  context
[elab ../spec/3-typing.watsup:334.3-334.4] C  :  context
[notation ../spec/3-typing.watsup:334.8-334.40] MEMORY.FILL : {I32 I32 I32} -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:334.8-334.19] MEMORY.FILL  :  instr
[elab ../spec/3-typing.watsup:334.8-334.19] MEMORY.FILL  :  instr
[notation ../spec/3-typing.watsup:334.8-334.19] {}  :  {}
[notation ../spec/3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  functype
[elab ../spec/3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  functype
[notation ../spec/3-typing.watsup:334.22-334.40] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:334.22-334.33] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:334.22-334.33] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:334.22-334.25] I32  :  resulttype
[notation ../spec/3-typing.watsup:334.22-334.25] {}  :  {}
[elab ../spec/3-typing.watsup:334.26-334.29] I32  :  resulttype
[notation ../spec/3-typing.watsup:334.26-334.29] {}  :  {}
[elab ../spec/3-typing.watsup:334.30-334.33] I32  :  resulttype
[notation ../spec/3-typing.watsup:334.30-334.33] {}  :  {}
[notation ../spec/3-typing.watsup:334.37-334.40] I32  :  resulttype
[elab ../spec/3-typing.watsup:334.37-334.40] I32  :  resulttype
[notation ../spec/3-typing.watsup:334.37-334.40] {}  :  {}
[elab ../spec/3-typing.watsup:335.9-335.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:335.9-335.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:335.9-335.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:335.9-335.10] C  :  context
[elab ../spec/3-typing.watsup:335.15-335.16] 0  :  nat
[elab ../spec/3-typing.watsup:335.20-335.22] mt  :  memtype
[notation ../spec/3-typing.watsup:338.3-338.40] C |- MEMORY.COPY : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:338.3-338.4] C  :  context
[elab ../spec/3-typing.watsup:338.3-338.4] C  :  context
[notation ../spec/3-typing.watsup:338.8-338.40] MEMORY.COPY : {I32 I32 I32} -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:338.8-338.19] MEMORY.COPY  :  instr
[elab ../spec/3-typing.watsup:338.8-338.19] MEMORY.COPY  :  instr
[notation ../spec/3-typing.watsup:338.8-338.19] {}  :  {}
[notation ../spec/3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  functype
[elab ../spec/3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  functype
[notation ../spec/3-typing.watsup:338.22-338.40] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:338.22-338.33] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:338.22-338.33] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:338.22-338.25] I32  :  resulttype
[notation ../spec/3-typing.watsup:338.22-338.25] {}  :  {}
[elab ../spec/3-typing.watsup:338.26-338.29] I32  :  resulttype
[notation ../spec/3-typing.watsup:338.26-338.29] {}  :  {}
[elab ../spec/3-typing.watsup:338.30-338.33] I32  :  resulttype
[notation ../spec/3-typing.watsup:338.30-338.33] {}  :  {}
[notation ../spec/3-typing.watsup:338.37-338.40] I32  :  resulttype
[elab ../spec/3-typing.watsup:338.37-338.40] I32  :  resulttype
[notation ../spec/3-typing.watsup:338.37-338.40] {}  :  {}
[elab ../spec/3-typing.watsup:339.9-339.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:339.9-339.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:339.9-339.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:339.9-339.10] C  :  context
[elab ../spec/3-typing.watsup:339.15-339.16] 0  :  nat
[elab ../spec/3-typing.watsup:339.20-339.22] mt  :  memtype
[notation ../spec/3-typing.watsup:342.3-342.42] C |- {MEMORY.INIT x} : {I32 I32 I32} -> I32  :  context |- instr : functype
[notation ../spec/3-typing.watsup:342.3-342.4] C  :  context
[elab ../spec/3-typing.watsup:342.3-342.4] C  :  context
[notation ../spec/3-typing.watsup:342.8-342.42] {MEMORY.INIT x} : {I32 I32 I32} -> I32  :  instr : functype
[notation ../spec/3-typing.watsup:342.8-342.21] {MEMORY.INIT x}  :  instr
[elab ../spec/3-typing.watsup:342.8-342.21] {MEMORY.INIT x}  :  instr
[notation ../spec/3-typing.watsup:342.8-342.21] {x}  :  {dataidx}
[notation ../spec/3-typing.watsup:342.20-342.21] x  :  dataidx
[elab ../spec/3-typing.watsup:342.20-342.21] x  :  dataidx
[notation ../spec/3-typing.watsup:342.8-342.21] {}  :  {}
[notation ../spec/3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  functype
[elab ../spec/3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  functype
[notation ../spec/3-typing.watsup:342.24-342.42] {I32 I32 I32} -> I32  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:342.24-342.35] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:342.24-342.35] {I32 I32 I32}  :  resulttype
[elab ../spec/3-typing.watsup:342.24-342.27] I32  :  resulttype
[notation ../spec/3-typing.watsup:342.24-342.27] {}  :  {}
[elab ../spec/3-typing.watsup:342.28-342.31] I32  :  resulttype
[notation ../spec/3-typing.watsup:342.28-342.31] {}  :  {}
[elab ../spec/3-typing.watsup:342.32-342.35] I32  :  resulttype
[notation ../spec/3-typing.watsup:342.32-342.35] {}  :  {}
[notation ../spec/3-typing.watsup:342.39-342.42] I32  :  resulttype
[elab ../spec/3-typing.watsup:342.39-342.42] I32  :  resulttype
[notation ../spec/3-typing.watsup:342.39-342.42] {}  :  {}
[elab ../spec/3-typing.watsup:343.9-343.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:343.9-343.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:343.9-343.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:343.9-343.10] C  :  context
[elab ../spec/3-typing.watsup:343.15-343.16] 0  :  nat
[elab ../spec/3-typing.watsup:343.20-343.22] mt  :  memtype
[elab ../spec/3-typing.watsup:344.9-344.23] C.DATA[x] = OK  :  bool
[elab ../spec/3-typing.watsup:344.9-344.18] C.DATA[x]  :  datatype
[elab ../spec/3-typing.watsup:344.9-344.15] C.DATA  :  datatype*
[elab ../spec/3-typing.watsup:344.9-344.10] C  :  context
[elab ../spec/3-typing.watsup:344.16-344.17] x  :  nat
[elab ../spec/3-typing.watsup:344.21-344.23] OK  :  datatype
[notation ../spec/3-typing.watsup:344.21-344.23] OK  :  OK
[notation ../spec/3-typing.watsup:347.3-347.40] C |- {DATA.DROP x} : epsilon -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:347.3-347.4] C  :  context
[elab ../spec/3-typing.watsup:347.3-347.4] C  :  context
[notation ../spec/3-typing.watsup:347.8-347.40] {DATA.DROP x} : epsilon -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:347.8-347.19] {DATA.DROP x}  :  instr
[elab ../spec/3-typing.watsup:347.8-347.19] {DATA.DROP x}  :  instr
[notation ../spec/3-typing.watsup:347.8-347.19] {x}  :  {dataidx}
[notation ../spec/3-typing.watsup:347.18-347.19] x  :  dataidx
[elab ../spec/3-typing.watsup:347.18-347.19] x  :  dataidx
[notation ../spec/3-typing.watsup:347.8-347.19] {}  :  {}
[notation ../spec/3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  functype
[elab ../spec/3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  functype
[notation ../spec/3-typing.watsup:347.22-347.40] epsilon -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:347.22-347.29] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:347.22-347.29] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:347.33-347.40] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:347.33-347.40] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:348.9-348.23] C.DATA[x] = OK  :  bool
[elab ../spec/3-typing.watsup:348.9-348.18] C.DATA[x]  :  datatype
[elab ../spec/3-typing.watsup:348.9-348.15] C.DATA  :  datatype*
[elab ../spec/3-typing.watsup:348.9-348.10] C  :  context
[elab ../spec/3-typing.watsup:348.16-348.17] x  :  nat
[elab ../spec/3-typing.watsup:348.21-348.23] OK  :  datatype
[notation ../spec/3-typing.watsup:348.21-348.23] OK  :  OK
[notation ../spec/3-typing.watsup:351.3-351.43] C |- {LOAD nt ({n sx})? n_A n_O} : I32 -> nt  :  context |- instr : functype
[notation ../spec/3-typing.watsup:351.3-351.4] C  :  context
[elab ../spec/3-typing.watsup:351.3-351.4] C  :  context
[notation ../spec/3-typing.watsup:351.8-351.43] {LOAD nt ({n sx})? n_A n_O} : I32 -> nt  :  instr : functype
[notation ../spec/3-typing.watsup:351.8-351.31] {LOAD nt ({n sx})? n_A n_O}  :  instr
[elab ../spec/3-typing.watsup:351.8-351.31] {LOAD nt ({n sx})? n_A n_O}  :  instr
[notation ../spec/3-typing.watsup:351.8-351.31] {nt ({n sx})? n_A n_O}  :  {numtype ({n sx})? nat nat}
[notation ../spec/3-typing.watsup:351.13-351.15] nt  :  numtype
[elab ../spec/3-typing.watsup:351.13-351.15] nt  :  numtype
[notation ../spec/3-typing.watsup:351.8-351.31] {({n sx})? n_A n_O}  :  {({n sx})? nat nat}
[notation ../spec/3-typing.watsup:351.16-351.23] ({n sx})?  :  ({n sx})?
[notation ../spec/3-typing.watsup:351.16-351.22] ({n sx})  :  ({n sx})
[notation ../spec/3-typing.watsup:351.17-351.21] {n sx}  :  ({n sx})
[notation ../spec/3-typing.watsup:351.17-351.21] {n sx}  :  {n sx}
[notation ../spec/3-typing.watsup:351.17-351.18] n  :  n
[elab ../spec/3-typing.watsup:351.17-351.18] n  :  n
[notation ../spec/3-typing.watsup:351.17-351.21] {sx}  :  {sx}
[notation ../spec/3-typing.watsup:351.19-351.21] sx  :  sx
[elab ../spec/3-typing.watsup:351.19-351.21] sx  :  sx
[notation ../spec/3-typing.watsup:351.17-351.21] {}  :  {}
[notation ../spec/3-typing.watsup:351.8-351.31] {n_A n_O}  :  {nat nat}
[notation ../spec/3-typing.watsup:351.24-351.27] n_A  :  nat
[elab ../spec/3-typing.watsup:351.24-351.27] n_A  :  nat
[notation ../spec/3-typing.watsup:351.8-351.31] {n_O}  :  {nat}
[notation ../spec/3-typing.watsup:351.28-351.31] n_O  :  nat
[elab ../spec/3-typing.watsup:351.28-351.31] n_O  :  nat
[notation ../spec/3-typing.watsup:351.8-351.31] {}  :  {}
[notation ../spec/3-typing.watsup:351.34-351.43] I32 -> nt  :  functype
[elab ../spec/3-typing.watsup:351.34-351.43] I32 -> nt  :  functype
[notation ../spec/3-typing.watsup:351.34-351.43] I32 -> nt  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:351.34-351.37] I32  :  resulttype
[elab ../spec/3-typing.watsup:351.34-351.37] I32  :  resulttype
[notation ../spec/3-typing.watsup:351.34-351.37] {}  :  {}
[notation ../spec/3-typing.watsup:351.41-351.43] nt  :  resulttype
[elab ../spec/3-typing.watsup:351.41-351.43] nt  :  resulttype
[elab ../spec/3-typing.watsup:352.9-352.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:352.9-352.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:352.9-352.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:352.9-352.10] C  :  context
[elab ../spec/3-typing.watsup:352.15-352.16] 0  :  nat
[elab ../spec/3-typing.watsup:352.20-352.22] mt  :  memtype
[elab ../spec/3-typing.watsup:353.9-353.33] 2 ^ (n_A) <= $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:353.11-353.18] 2 ^ (n_A)  :  nat
[elab ../spec/3-typing.watsup:353.11-353.12] 2  :  nat
[elab ../spec/3-typing.watsup:353.13-353.18] (n_A)  :  nat
[elab ../spec/3-typing.watsup:353.14-353.17] n_A  :  nat
[elab ../spec/3-typing.watsup:353.22-353.32] $size(t) / 8  :  nat
[elab ../spec/3-typing.watsup:353.22-353.30] $size(t)  :  nat
[elab ../spec/3-typing.watsup:353.27-353.30] (t)  :  (valtype)
[elab ../spec/3-typing.watsup:353.28-353.29] t  :  (valtype)
[elab ../spec/3-typing.watsup:353.31-353.32] 8  :  nat
[elab ../spec/3-typing.watsup:354.9-354.39] 2 ^ (n_A) <= n / 8 < $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:354.11-354.18] 2 ^ (n_A)  :  nat
[elab ../spec/3-typing.watsup:354.11-354.12] 2  :  nat
[elab ../spec/3-typing.watsup:354.13-354.18] (n_A)  :  nat
[elab ../spec/3-typing.watsup:354.14-354.17] n_A  :  nat
[elab ../spec/3-typing.watsup:354.22-354.25] n / 8  :  nat
[elab ../spec/3-typing.watsup:354.22-354.23] n  :  nat
[elab ../spec/3-typing.watsup:354.24-354.25] 8  :  nat
[elab ../spec/3-typing.watsup:354.22-354.38] n / 8 < $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:354.22-354.25] n / 8  :  nat
[elab ../spec/3-typing.watsup:354.22-354.23] n  :  nat
[elab ../spec/3-typing.watsup:354.24-354.25] 8  :  nat
[elab ../spec/3-typing.watsup:354.28-354.38] $size(t) / 8  :  nat
[elab ../spec/3-typing.watsup:354.28-354.36] $size(t)  :  nat
[elab ../spec/3-typing.watsup:354.33-354.36] (t)  :  (valtype)
[elab ../spec/3-typing.watsup:354.34-354.35] t  :  (valtype)
[elab ../spec/3-typing.watsup:354.37-354.38] 8  :  nat
[elab ../spec/3-typing.watsup:355.9-355.32] n? = epsilon \/ nt = in  :  bool
[elab ../spec/3-typing.watsup:355.9-355.21] n? = epsilon  :  bool
[elab ../spec/3-typing.watsup:355.9-355.11] n?  :  n?
[elab ../spec/3-typing.watsup:355.9-355.10] n  :  n
[elab ../spec/3-typing.watsup:355.14-355.21] epsilon  :  n?
[elab ../spec/3-typing.watsup:355.25-355.32] nt = in  :  bool
[elab ../spec/3-typing.watsup:355.25-355.27] nt  :  numtype
[elab ../spec/3-typing.watsup:355.30-355.32] in  :  numtype
[notation ../spec/3-typing.watsup:358.3-358.47] C |- {STORE nt n? n_A n_O} : {I32 nt} -> epsilon  :  context |- instr : functype
[notation ../spec/3-typing.watsup:358.3-358.4] C  :  context
[elab ../spec/3-typing.watsup:358.3-358.4] C  :  context
[notation ../spec/3-typing.watsup:358.8-358.47] {STORE nt n? n_A n_O} : {I32 nt} -> epsilon  :  instr : functype
[notation ../spec/3-typing.watsup:358.8-358.27] {STORE nt n? n_A n_O}  :  instr
[elab ../spec/3-typing.watsup:358.8-358.27] {STORE nt n? n_A n_O}  :  instr
[notation ../spec/3-typing.watsup:358.8-358.27] {nt n? n_A n_O}  :  {numtype n? nat nat}
[notation ../spec/3-typing.watsup:358.14-358.16] nt  :  numtype
[elab ../spec/3-typing.watsup:358.14-358.16] nt  :  numtype
[notation ../spec/3-typing.watsup:358.8-358.27] {n? n_A n_O}  :  {n? nat nat}
[notation ../spec/3-typing.watsup:358.17-358.19] n?  :  n?
[notation ../spec/3-typing.watsup:358.17-358.18] n  :  n
[elab ../spec/3-typing.watsup:358.17-358.18] n  :  n
[notation ../spec/3-typing.watsup:358.8-358.27] {n_A n_O}  :  {nat nat}
[notation ../spec/3-typing.watsup:358.20-358.23] n_A  :  nat
[elab ../spec/3-typing.watsup:358.20-358.23] n_A  :  nat
[notation ../spec/3-typing.watsup:358.8-358.27] {n_O}  :  {nat}
[notation ../spec/3-typing.watsup:358.24-358.27] n_O  :  nat
[elab ../spec/3-typing.watsup:358.24-358.27] n_O  :  nat
[notation ../spec/3-typing.watsup:358.8-358.27] {}  :  {}
[notation ../spec/3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  functype
[elab ../spec/3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  functype
[notation ../spec/3-typing.watsup:358.30-358.47] {I32 nt} -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:358.30-358.36] {I32 nt}  :  resulttype
[elab ../spec/3-typing.watsup:358.30-358.36] {I32 nt}  :  resulttype
[elab ../spec/3-typing.watsup:358.30-358.33] I32  :  resulttype
[notation ../spec/3-typing.watsup:358.30-358.33] {}  :  {}
[elab ../spec/3-typing.watsup:358.34-358.36] nt  :  resulttype
[notation ../spec/3-typing.watsup:358.40-358.47] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:358.40-358.47] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:359.9-359.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:359.9-359.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:359.9-359.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:359.9-359.10] C  :  context
[elab ../spec/3-typing.watsup:359.15-359.16] 0  :  nat
[elab ../spec/3-typing.watsup:359.20-359.22] mt  :  memtype
[elab ../spec/3-typing.watsup:360.9-360.33] 2 ^ (n_A) <= $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:360.11-360.18] 2 ^ (n_A)  :  nat
[elab ../spec/3-typing.watsup:360.11-360.12] 2  :  nat
[elab ../spec/3-typing.watsup:360.13-360.18] (n_A)  :  nat
[elab ../spec/3-typing.watsup:360.14-360.17] n_A  :  nat
[elab ../spec/3-typing.watsup:360.22-360.32] $size(t) / 8  :  nat
[elab ../spec/3-typing.watsup:360.22-360.30] $size(t)  :  nat
[elab ../spec/3-typing.watsup:360.27-360.30] (t)  :  (valtype)
[elab ../spec/3-typing.watsup:360.28-360.29] t  :  (valtype)
[elab ../spec/3-typing.watsup:360.31-360.32] 8  :  nat
[elab ../spec/3-typing.watsup:361.9-361.39] 2 ^ (n_A) <= n / 8 < $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:361.11-361.18] 2 ^ (n_A)  :  nat
[elab ../spec/3-typing.watsup:361.11-361.12] 2  :  nat
[elab ../spec/3-typing.watsup:361.13-361.18] (n_A)  :  nat
[elab ../spec/3-typing.watsup:361.14-361.17] n_A  :  nat
[elab ../spec/3-typing.watsup:361.22-361.25] n / 8  :  nat
[elab ../spec/3-typing.watsup:361.22-361.23] n  :  nat
[elab ../spec/3-typing.watsup:361.24-361.25] 8  :  nat
[elab ../spec/3-typing.watsup:361.22-361.38] n / 8 < $size(t) / 8  :  bool
[elab ../spec/3-typing.watsup:361.22-361.25] n / 8  :  nat
[elab ../spec/3-typing.watsup:361.22-361.23] n  :  nat
[elab ../spec/3-typing.watsup:361.24-361.25] 8  :  nat
[elab ../spec/3-typing.watsup:361.28-361.38] $size(t) / 8  :  nat
[elab ../spec/3-typing.watsup:361.28-361.36] $size(t)  :  nat
[elab ../spec/3-typing.watsup:361.33-361.36] (t)  :  (valtype)
[elab ../spec/3-typing.watsup:361.34-361.35] t  :  (valtype)
[elab ../spec/3-typing.watsup:361.37-361.38] 8  :  nat
[elab ../spec/3-typing.watsup:362.9-362.32] n? = epsilon \/ nt = in  :  bool
[elab ../spec/3-typing.watsup:362.9-362.21] n? = epsilon  :  bool
[elab ../spec/3-typing.watsup:362.9-362.11] n?  :  n?
[elab ../spec/3-typing.watsup:362.9-362.10] n  :  n
[elab ../spec/3-typing.watsup:362.14-362.21] epsilon  :  n?
[elab ../spec/3-typing.watsup:362.25-362.32] nt = in  :  bool
[elab ../spec/3-typing.watsup:362.25-362.27] nt  :  numtype
[elab ../spec/3-typing.watsup:362.30-362.32] in  :  numtype
[notation ../spec/3-typing.watsup:372.3-372.26] C |- {({CONST nt c}) CONST}  :  context |- {instr CONST}
[notation ../spec/3-typing.watsup:372.3-372.4] C  :  context
[elab ../spec/3-typing.watsup:372.3-372.4] C  :  context
[notation ../spec/3-typing.watsup:372.8-372.26] {({CONST nt c}) CONST}  :  {instr CONST}
[notation ../spec/3-typing.watsup:372.9-372.19] {CONST nt c}  :  instr
[elab ../spec/3-typing.watsup:372.9-372.19] {CONST nt c}  :  instr
[notation ../spec/3-typing.watsup:372.9-372.19] {nt c}  :  {numtype c_numtype}
[notation ../spec/3-typing.watsup:372.15-372.17] nt  :  numtype
[elab ../spec/3-typing.watsup:372.15-372.17] nt  :  numtype
[notation ../spec/3-typing.watsup:372.9-372.19] {c}  :  {c_numtype}
[notation ../spec/3-typing.watsup:372.18-372.19] c  :  c_numtype
[elab ../spec/3-typing.watsup:372.18-372.19] c  :  c_numtype
[notation ../spec/3-typing.watsup:372.9-372.19] {}  :  {}
[notation ../spec/3-typing.watsup:372.8-372.26] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:372.21-372.26] CONST  :  CONST
[notation ../spec/3-typing.watsup:372.8-372.26] {}  :  {}
[notation ../spec/3-typing.watsup:375.3-375.27] C |- {({REF.NULL rt}) CONST}  :  context |- {instr CONST}
[notation ../spec/3-typing.watsup:375.3-375.4] C  :  context
[elab ../spec/3-typing.watsup:375.3-375.4] C  :  context
[notation ../spec/3-typing.watsup:375.8-375.27] {({REF.NULL rt}) CONST}  :  {instr CONST}
[notation ../spec/3-typing.watsup:375.9-375.20] {REF.NULL rt}  :  instr
[elab ../spec/3-typing.watsup:375.9-375.20] {REF.NULL rt}  :  instr
[notation ../spec/3-typing.watsup:375.9-375.20] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:375.18-375.20] rt  :  reftype
[elab ../spec/3-typing.watsup:375.18-375.20] rt  :  reftype
[notation ../spec/3-typing.watsup:375.9-375.20] {}  :  {}
[notation ../spec/3-typing.watsup:375.8-375.27] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:375.22-375.27] CONST  :  CONST
[notation ../spec/3-typing.watsup:375.8-375.27] {}  :  {}
[notation ../spec/3-typing.watsup:378.3-378.26] C |- {({REF.FUNC x}) CONST}  :  context |- {instr CONST}
[notation ../spec/3-typing.watsup:378.3-378.4] C  :  context
[elab ../spec/3-typing.watsup:378.3-378.4] C  :  context
[notation ../spec/3-typing.watsup:378.8-378.26] {({REF.FUNC x}) CONST}  :  {instr CONST}
[notation ../spec/3-typing.watsup:378.9-378.19] {REF.FUNC x}  :  instr
[elab ../spec/3-typing.watsup:378.9-378.19] {REF.FUNC x}  :  instr
[notation ../spec/3-typing.watsup:378.9-378.19] {x}  :  {funcidx}
[notation ../spec/3-typing.watsup:378.18-378.19] x  :  funcidx
[elab ../spec/3-typing.watsup:378.18-378.19] x  :  funcidx
[notation ../spec/3-typing.watsup:378.9-378.19] {}  :  {}
[notation ../spec/3-typing.watsup:378.8-378.26] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:378.21-378.26] CONST  :  CONST
[notation ../spec/3-typing.watsup:378.8-378.26] {}  :  {}
[notation ../spec/3-typing.watsup:381.3-381.28] C |- {({GLOBAL.GET x}) CONST}  :  context |- {instr CONST}
[notation ../spec/3-typing.watsup:381.3-381.4] C  :  context
[elab ../spec/3-typing.watsup:381.3-381.4] C  :  context
[notation ../spec/3-typing.watsup:381.8-381.28] {({GLOBAL.GET x}) CONST}  :  {instr CONST}
[notation ../spec/3-typing.watsup:381.9-381.21] {GLOBAL.GET x}  :  instr
[elab ../spec/3-typing.watsup:381.9-381.21] {GLOBAL.GET x}  :  instr
[notation ../spec/3-typing.watsup:381.9-381.21] {x}  :  {globalidx}
[notation ../spec/3-typing.watsup:381.20-381.21] x  :  globalidx
[elab ../spec/3-typing.watsup:381.20-381.21] x  :  globalidx
[notation ../spec/3-typing.watsup:381.9-381.21] {}  :  {}
[notation ../spec/3-typing.watsup:381.8-381.28] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:381.23-381.28] CONST  :  CONST
[notation ../spec/3-typing.watsup:381.8-381.28] {}  :  {}
[elab ../spec/3-typing.watsup:382.9-382.32] C.GLOBAL[x] = {epsilon t}  :  bool
[elab ../spec/3-typing.watsup:382.9-382.20] C.GLOBAL[x]  :  globaltype
[elab ../spec/3-typing.watsup:382.9-382.17] C.GLOBAL  :  globaltype*
[elab ../spec/3-typing.watsup:382.9-382.10] C  :  context
[elab ../spec/3-typing.watsup:382.18-382.19] x  :  nat
[elab ../spec/3-typing.watsup:382.23-382.32] {epsilon t}  :  globaltype
[notation ../spec/3-typing.watsup:382.23-382.32] {epsilon t}  :  {MUT? valtype}
[notation ../spec/3-typing.watsup:382.23-382.30] epsilon  :  MUT?
[niteration ../spec/3-typing.watsup:382.23-382.30]   :  MUT?
[notation ../spec/3-typing.watsup:382.23-382.32] {t}  :  {valtype}
[notation ../spec/3-typing.watsup:382.31-382.32] t  :  valtype
[elab ../spec/3-typing.watsup:382.31-382.32] t  :  valtype
[notation ../spec/3-typing.watsup:382.23-382.32] {}  :  {}
[notation ../spec/3-typing.watsup:385.18-385.35] C |- {instr* CONST}  :  context |- {expr CONST}
[notation ../spec/3-typing.watsup:385.18-385.19] C  :  context
[elab ../spec/3-typing.watsup:385.18-385.19] C  :  context
[notation ../spec/3-typing.watsup:385.23-385.35] {instr* CONST}  :  {expr CONST}
[notation ../spec/3-typing.watsup:385.23-385.29] instr*  :  expr
[elab ../spec/3-typing.watsup:385.23-385.29] instr*  :  expr
[elab ../spec/3-typing.watsup:385.23-385.28] instr  :  instr
[notation ../spec/3-typing.watsup:385.23-385.35] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:385.30-385.35] CONST  :  CONST
[notation ../spec/3-typing.watsup:385.23-385.35] {}  :  {}
[notation ../spec/3-typing.watsup:386.20-386.36] C |- {instr CONST}  :  context |- {instr CONST}
[notation ../spec/3-typing.watsup:386.20-386.21] C  :  context
[elab ../spec/3-typing.watsup:386.20-386.21] C  :  context
[notation ../spec/3-typing.watsup:386.25-386.36] {instr CONST}  :  {instr CONST}
[notation ../spec/3-typing.watsup:386.25-386.30] instr  :  instr
[elab ../spec/3-typing.watsup:386.25-386.30] instr  :  instr
[notation ../spec/3-typing.watsup:386.25-386.36] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:386.31-386.36] CONST  :  CONST
[notation ../spec/3-typing.watsup:386.25-386.36] {}  :  {}
[notation ../spec/3-typing.watsup:390.3-390.22] C |- expr : {t CONST}  :  context |- expr : {valtype CONST}
[notation ../spec/3-typing.watsup:390.3-390.4] C  :  context
[elab ../spec/3-typing.watsup:390.3-390.4] C  :  context
[notation ../spec/3-typing.watsup:390.8-390.22] expr : {t CONST}  :  expr : {valtype CONST}
[notation ../spec/3-typing.watsup:390.8-390.12] expr  :  expr
[elab ../spec/3-typing.watsup:390.8-390.12] expr  :  expr
[notation ../spec/3-typing.watsup:390.15-390.22] {t CONST}  :  {valtype CONST}
[notation ../spec/3-typing.watsup:390.15-390.16] t  :  valtype
[elab ../spec/3-typing.watsup:390.15-390.16] t  :  valtype
[notation ../spec/3-typing.watsup:390.15-390.22] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:390.17-390.22] CONST  :  CONST
[notation ../spec/3-typing.watsup:390.15-390.22] {}  :  {}
[notation ../spec/3-typing.watsup:391.15-391.28] C |- expr : t  :  context |- expr : resulttype
[notation ../spec/3-typing.watsup:391.15-391.16] C  :  context
[elab ../spec/3-typing.watsup:391.15-391.16] C  :  context
[notation ../spec/3-typing.watsup:391.20-391.28] expr : t  :  expr : resulttype
[notation ../spec/3-typing.watsup:391.20-391.24] expr  :  expr
[elab ../spec/3-typing.watsup:391.20-391.24] expr  :  expr
[notation ../spec/3-typing.watsup:391.27-391.28] t  :  resulttype
[elab ../spec/3-typing.watsup:391.27-391.28] t  :  resulttype
[notation ../spec/3-typing.watsup:392.18-392.33] C |- {expr CONST}  :  context |- {expr CONST}
[notation ../spec/3-typing.watsup:392.18-392.19] C  :  context
[elab ../spec/3-typing.watsup:392.18-392.19] C  :  context
[notation ../spec/3-typing.watsup:392.23-392.33] {expr CONST}  :  {expr CONST}
[notation ../spec/3-typing.watsup:392.23-392.27] expr  :  expr
[elab ../spec/3-typing.watsup:392.23-392.27] expr  :  expr
[notation ../spec/3-typing.watsup:392.23-392.33] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:392.28-392.33] CONST  :  CONST
[notation ../spec/3-typing.watsup:392.23-392.33] {}  :  {}
[notation ../spec/3-typing.watsup:409.3-409.28] C |- {FUNC ft t* expr} : ft  :  context |- func : functype
[notation ../spec/3-typing.watsup:409.3-409.4] C  :  context
[elab ../spec/3-typing.watsup:409.3-409.4] C  :  context
[notation ../spec/3-typing.watsup:409.8-409.28] {FUNC ft t* expr} : ft  :  func : functype
[notation ../spec/3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  func
[elab ../spec/3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  func
[notation ../spec/3-typing.watsup:409.8-409.23] {FUNC ft t* expr}  :  {FUNC functype valtype* expr}
[notation ../spec/3-typing.watsup:409.8-409.12] FUNC  :  FUNC
[notation ../spec/3-typing.watsup:409.8-409.23] {ft t* expr}  :  {functype valtype* expr}
[notation ../spec/3-typing.watsup:409.13-409.15] ft  :  functype
[elab ../spec/3-typing.watsup:409.13-409.15] ft  :  functype
[notation ../spec/3-typing.watsup:409.8-409.23] {t* expr}  :  {valtype* expr}
[notation ../spec/3-typing.watsup:409.16-409.18] t*  :  valtype*
[notation ../spec/3-typing.watsup:409.16-409.17] t  :  valtype
[elab ../spec/3-typing.watsup:409.16-409.17] t  :  valtype
[notation ../spec/3-typing.watsup:409.8-409.23] {expr}  :  {expr}
[notation ../spec/3-typing.watsup:409.19-409.23] expr  :  expr
[elab ../spec/3-typing.watsup:409.19-409.23] expr  :  expr
[notation ../spec/3-typing.watsup:409.8-409.23] {}  :  {}
[notation ../spec/3-typing.watsup:409.26-409.28] ft  :  functype
[elab ../spec/3-typing.watsup:409.26-409.28] ft  :  functype
[elab ../spec/3-typing.watsup:410.9-410.26] ft = t_1* -> t_2*  :  bool
[elab ../spec/3-typing.watsup:410.9-410.11] ft  :  functype
[elab ../spec/3-typing.watsup:410.14-410.26] t_1* -> t_2*  :  functype
[notation ../spec/3-typing.watsup:410.14-410.26] t_1* -> t_2*  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:410.14-410.18] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:410.14-410.18] t_1*  :  resulttype
[elab ../spec/3-typing.watsup:410.14-410.17] t_1  :  valtype
[notation ../spec/3-typing.watsup:410.22-410.26] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:410.22-410.26] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:410.22-410.25] t_2  :  valtype
[notation ../spec/3-typing.watsup:411.19-411.29] {} |- ft : OK  :  {} |- functype : OK
[notation ../spec/3-typing.watsup:411.19-411.21] {}  :  {}
[notation ../spec/3-typing.watsup:411.22-411.29] ft : OK  :  functype : OK
[notation ../spec/3-typing.watsup:411.22-411.24] ft  :  functype
[elab ../spec/3-typing.watsup:411.22-411.24] ft  :  functype
[notation ../spec/3-typing.watsup:411.27-411.29] OK  :  OK
[notation ../spec/3-typing.watsup:412.15-412.75] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)} |- expr : t_2*  :  context |- expr : resulttype
[notation ../spec/3-typing.watsup:412.15-412.60] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)}  :  context
[elab ../spec/3-typing.watsup:412.15-412.60] C, {LOCAL t_1* t*}, {LABEL (t_2*)}, {RETURN (t_2*)}  :  context
[elab ../spec/3-typing.watsup:412.15-412.45] C, {LOCAL t_1* t*}, {LABEL (t_2*)}  :  context
[elab ../spec/3-typing.watsup:412.15-412.31] C, {LOCAL t_1* t*}  :  context
[elab ../spec/3-typing.watsup:412.15-412.16] C  :  context
[elab ../spec/3-typing.watsup:412.18-412.31] {LOCAL {t_1* t*}}  :  context
[notation ../spec/3-typing.watsup:412.18-412.31] {t_1* t*}  :  valtype*
[niteration ../spec/3-typing.watsup:412.18-412.31] t_1* t*  :  valtype*
[notation ../spec/3-typing.watsup:412.24-412.28] t_1*  :  valtype*
[notation ../spec/3-typing.watsup:412.24-412.27] t_1  :  valtype
[elab ../spec/3-typing.watsup:412.24-412.27] t_1  :  valtype
[niteration ../spec/3-typing.watsup:412.18-412.31] t*  :  valtype*
[notation ../spec/3-typing.watsup:412.29-412.31] t*  :  valtype*
[notation ../spec/3-typing.watsup:412.29-412.30] t  :  valtype
[elab ../spec/3-typing.watsup:412.29-412.30] t  :  valtype
[niteration ../spec/3-typing.watsup:412.18-412.31]   :  valtype*
[elab ../spec/3-typing.watsup:412.39-412.45] {LABEL (t_2*)}  :  context
[notation ../spec/3-typing.watsup:412.39-412.45] (t_2*)  :  resulttype*
[notation ../spec/3-typing.watsup:412.40-412.44] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.40-412.44] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.40-412.43] t_2  :  valtype
[elab ../spec/3-typing.watsup:412.54-412.60] {RETURN (t_2*)}  :  context
[notation ../spec/3-typing.watsup:412.54-412.60] (t_2*)  :  resulttype?
[notation ../spec/3-typing.watsup:412.55-412.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.55-412.59] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.55-412.58] t_2  :  valtype
[notation ../spec/3-typing.watsup:412.64-412.75] expr : t_2*  :  expr : resulttype
[notation ../spec/3-typing.watsup:412.64-412.68] expr  :  expr
[elab ../spec/3-typing.watsup:412.64-412.68] expr  :  expr
[notation ../spec/3-typing.watsup:412.71-412.75] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.71-412.75] t_2*  :  resulttype
[elab ../spec/3-typing.watsup:412.71-412.74] t_2  :  valtype
[notation ../spec/3-typing.watsup:415.3-415.27] C |- {GLOBAL gt expr} : gt  :  context |- global : globaltype
[notation ../spec/3-typing.watsup:415.3-415.4] C  :  context
[elab ../spec/3-typing.watsup:415.3-415.4] C  :  context
[notation ../spec/3-typing.watsup:415.8-415.27] {GLOBAL gt expr} : gt  :  global : globaltype
[notation ../spec/3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  global
[elab ../spec/3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  global
[notation ../spec/3-typing.watsup:415.8-415.22] {GLOBAL gt expr}  :  {GLOBAL globaltype expr}
[notation ../spec/3-typing.watsup:415.8-415.14] GLOBAL  :  GLOBAL
[notation ../spec/3-typing.watsup:415.8-415.22] {gt expr}  :  {globaltype expr}
[notation ../spec/3-typing.watsup:415.15-415.17] gt  :  globaltype
[elab ../spec/3-typing.watsup:415.15-415.17] gt  :  globaltype
[notation ../spec/3-typing.watsup:415.8-415.22] {expr}  :  {expr}
[notation ../spec/3-typing.watsup:415.18-415.22] expr  :  expr
[elab ../spec/3-typing.watsup:415.18-415.22] expr  :  expr
[notation ../spec/3-typing.watsup:415.8-415.22] {}  :  {}
[notation ../spec/3-typing.watsup:415.25-415.27] gt  :  globaltype
[elab ../spec/3-typing.watsup:415.25-415.27] gt  :  globaltype
[notation ../spec/3-typing.watsup:416.21-416.31] {} |- gt : OK  :  {} |- globaltype : OK
[notation ../spec/3-typing.watsup:416.21-416.23] {}  :  {}
[notation ../spec/3-typing.watsup:416.24-416.31] gt : OK  :  globaltype : OK
[notation ../spec/3-typing.watsup:416.24-416.26] gt  :  globaltype
[elab ../spec/3-typing.watsup:416.24-416.26] gt  :  globaltype
[notation ../spec/3-typing.watsup:416.29-416.31] OK  :  OK
[elab ../spec/3-typing.watsup:417.9-417.20] gt = {MUT? t}  :  bool
[elab ../spec/3-typing.watsup:417.9-417.11] gt  :  globaltype
[elab ../spec/3-typing.watsup:417.14-417.20] {MUT? t}  :  globaltype
[notation ../spec/3-typing.watsup:417.14-417.20] {MUT? t}  :  {MUT? valtype}
[notation ../spec/3-typing.watsup:417.14-417.18] MUT?  :  MUT?
[notation ../spec/3-typing.watsup:417.14-417.17] MUT  :  MUT
[notation ../spec/3-typing.watsup:417.14-417.20] {t}  :  {valtype}
[notation ../spec/3-typing.watsup:417.19-417.20] t  :  valtype
[elab ../spec/3-typing.watsup:417.19-417.20] t  :  valtype
[notation ../spec/3-typing.watsup:417.14-417.20] {}  :  {}
[notation ../spec/3-typing.watsup:418.21-418.40] C |- expr : {t CONST}  :  context |- expr : {valtype CONST}
[notation ../spec/3-typing.watsup:418.21-418.22] C  :  context
[elab ../spec/3-typing.watsup:418.21-418.22] C  :  context
[notation ../spec/3-typing.watsup:418.26-418.40] expr : {t CONST}  :  expr : {valtype CONST}
[notation ../spec/3-typing.watsup:418.26-418.30] expr  :  expr
[elab ../spec/3-typing.watsup:418.26-418.30] expr  :  expr
[notation ../spec/3-typing.watsup:418.33-418.40] {t CONST}  :  {valtype CONST}
[notation ../spec/3-typing.watsup:418.33-418.34] t  :  valtype
[elab ../spec/3-typing.watsup:418.33-418.34] t  :  valtype
[notation ../spec/3-typing.watsup:418.33-418.40] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:418.35-418.40] CONST  :  CONST
[notation ../spec/3-typing.watsup:418.33-418.40] {}  :  {}
[notation ../spec/3-typing.watsup:421.3-421.21] C |- {TABLE tt} : tt  :  context |- table : tabletype
[notation ../spec/3-typing.watsup:421.3-421.4] C  :  context
[elab ../spec/3-typing.watsup:421.3-421.4] C  :  context
[notation ../spec/3-typing.watsup:421.8-421.21] {TABLE tt} : tt  :  table : tabletype
[notation ../spec/3-typing.watsup:421.8-421.16] {TABLE tt}  :  table
[elab ../spec/3-typing.watsup:421.8-421.16] {TABLE tt}  :  table
[notation ../spec/3-typing.watsup:421.8-421.16] {TABLE tt}  :  {TABLE tabletype}
[notation ../spec/3-typing.watsup:421.8-421.13] TABLE  :  TABLE
[notation ../spec/3-typing.watsup:421.8-421.16] {tt}  :  {tabletype}
[notation ../spec/3-typing.watsup:421.14-421.16] tt  :  tabletype
[elab ../spec/3-typing.watsup:421.14-421.16] tt  :  tabletype
[notation ../spec/3-typing.watsup:421.8-421.16] {}  :  {}
[notation ../spec/3-typing.watsup:421.19-421.21] tt  :  tabletype
[elab ../spec/3-typing.watsup:421.19-421.21] tt  :  tabletype
[notation ../spec/3-typing.watsup:422.20-422.30] {} |- tt : OK  :  {} |- tabletype : OK
[notation ../spec/3-typing.watsup:422.20-422.22] {}  :  {}
[notation ../spec/3-typing.watsup:422.23-422.30] tt : OK  :  tabletype : OK
[notation ../spec/3-typing.watsup:422.23-422.25] tt  :  tabletype
[elab ../spec/3-typing.watsup:422.23-422.25] tt  :  tabletype
[notation ../spec/3-typing.watsup:422.28-422.30] OK  :  OK
[notation ../spec/3-typing.watsup:425.3-425.22] C |- {MEMORY mt} : mt  :  context |- mem : memtype
[notation ../spec/3-typing.watsup:425.3-425.4] C  :  context
[elab ../spec/3-typing.watsup:425.3-425.4] C  :  context
[notation ../spec/3-typing.watsup:425.8-425.22] {MEMORY mt} : mt  :  mem : memtype
[notation ../spec/3-typing.watsup:425.8-425.17] {MEMORY mt}  :  mem
[elab ../spec/3-typing.watsup:425.8-425.17] {MEMORY mt}  :  mem
[notation ../spec/3-typing.watsup:425.8-425.17] {MEMORY mt}  :  {MEMORY memtype}
[notation ../spec/3-typing.watsup:425.8-425.14] MEMORY  :  MEMORY
[notation ../spec/3-typing.watsup:425.8-425.17] {mt}  :  {memtype}
[notation ../spec/3-typing.watsup:425.15-425.17] mt  :  memtype
[elab ../spec/3-typing.watsup:425.15-425.17] mt  :  memtype
[notation ../spec/3-typing.watsup:425.8-425.17] {}  :  {}
[notation ../spec/3-typing.watsup:425.20-425.22] mt  :  memtype
[elab ../spec/3-typing.watsup:425.20-425.22] mt  :  memtype
[notation ../spec/3-typing.watsup:426.18-426.28] {} |- mt : OK  :  {} |- memtype : OK
[notation ../spec/3-typing.watsup:426.18-426.20] {}  :  {}
[notation ../spec/3-typing.watsup:426.21-426.28] mt : OK  :  memtype : OK
[notation ../spec/3-typing.watsup:426.21-426.23] mt  :  memtype
[elab ../spec/3-typing.watsup:426.21-426.23] mt  :  memtype
[notation ../spec/3-typing.watsup:426.26-426.28] OK  :  OK
[notation ../spec/3-typing.watsup:429.3-429.36] C |- {ELEM rt expr* elemmode?} : rt  :  context |- elem : reftype
[notation ../spec/3-typing.watsup:429.3-429.4] C  :  context
[elab ../spec/3-typing.watsup:429.3-429.4] C  :  context
[notation ../spec/3-typing.watsup:429.8-429.36] {ELEM rt expr* elemmode?} : rt  :  elem : reftype
[notation ../spec/3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  elem
[elab ../spec/3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  elem
[notation ../spec/3-typing.watsup:429.8-429.31] {ELEM rt expr* elemmode?}  :  {ELEM reftype expr* elemmode?}
[notation ../spec/3-typing.watsup:429.8-429.12] ELEM  :  ELEM
[notation ../spec/3-typing.watsup:429.8-429.31] {rt expr* elemmode?}  :  {reftype expr* elemmode?}
[notation ../spec/3-typing.watsup:429.13-429.15] rt  :  reftype
[elab ../spec/3-typing.watsup:429.13-429.15] rt  :  reftype
[notation ../spec/3-typing.watsup:429.8-429.31] {expr* elemmode?}  :  {expr* elemmode?}
[notation ../spec/3-typing.watsup:429.16-429.21] expr*  :  expr*
[notation ../spec/3-typing.watsup:429.16-429.20] expr  :  expr
[elab ../spec/3-typing.watsup:429.16-429.20] expr  :  expr
[notation ../spec/3-typing.watsup:429.8-429.31] {elemmode?}  :  {elemmode?}
[notation ../spec/3-typing.watsup:429.8-429.31] {elemmode?}  :  elemmode?
[elab ../spec/3-typing.watsup:429.22-429.31] elemmode?  :  elemmode?
[elab ../spec/3-typing.watsup:429.22-429.30] elemmode  :  elemmode
[notation ../spec/3-typing.watsup:429.34-429.36] rt  :  reftype
[elab ../spec/3-typing.watsup:429.34-429.36] rt  :  reftype
[notation ../spec/3-typing.watsup:430.16-430.30] C |- expr : rt  :  context |- expr : resulttype
[notation ../spec/3-typing.watsup:430.16-430.17] C  :  context
[elab ../spec/3-typing.watsup:430.16-430.17] C  :  context
[notation ../spec/3-typing.watsup:430.21-430.30] expr : rt  :  expr : resulttype
[notation ../spec/3-typing.watsup:430.21-430.25] expr  :  expr
[elab ../spec/3-typing.watsup:430.21-430.25] expr  :  expr
[notation ../spec/3-typing.watsup:430.28-430.30] rt  :  resulttype
[elab ../spec/3-typing.watsup:430.28-430.30] rt  :  resulttype
[notation ../spec/3-typing.watsup:431.20-431.38] C |- elemmode : rt  :  context |- elemmode : reftype
[notation ../spec/3-typing.watsup:431.20-431.21] C  :  context
[elab ../spec/3-typing.watsup:431.20-431.21] C  :  context
[notation ../spec/3-typing.watsup:431.25-431.38] elemmode : rt  :  elemmode : reftype
[notation ../spec/3-typing.watsup:431.25-431.33] elemmode  :  elemmode
[elab ../spec/3-typing.watsup:431.25-431.33] elemmode  :  elemmode
[notation ../spec/3-typing.watsup:431.36-431.38] rt  :  reftype
[elab ../spec/3-typing.watsup:431.36-431.38] rt  :  reftype
[notation ../spec/3-typing.watsup:435.3-435.31] C |- {DATA b** datamode?} : OK  :  context |- data : OK
[notation ../spec/3-typing.watsup:435.3-435.4] C  :  context
[elab ../spec/3-typing.watsup:435.3-435.4] C  :  context
[notation ../spec/3-typing.watsup:435.8-435.31] {DATA b** datamode?} : OK  :  data : OK
[notation ../spec/3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  data
[elab ../spec/3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  data
[notation ../spec/3-typing.watsup:435.8-435.26] {DATA b** datamode?}  :  {DATA (byte*)* datamode?}
[notation ../spec/3-typing.watsup:435.8-435.12] DATA  :  DATA
[notation ../spec/3-typing.watsup:435.8-435.26] {b** datamode?}  :  {(byte*)* datamode?}
[notation ../spec/3-typing.watsup:435.13-435.16] b**  :  (byte*)*
[notation ../spec/3-typing.watsup:435.13-435.15] b*  :  (byte*)
[notation ../spec/3-typing.watsup:435.13-435.15] b*  :  byte*
[notation ../spec/3-typing.watsup:435.13-435.14] b  :  byte
[elab ../spec/3-typing.watsup:435.13-435.14] b  :  byte
[notation ../spec/3-typing.watsup:435.8-435.26] {datamode?}  :  {datamode?}
[notation ../spec/3-typing.watsup:435.8-435.26] {datamode?}  :  datamode?
[elab ../spec/3-typing.watsup:435.17-435.26] datamode?  :  datamode?
[elab ../spec/3-typing.watsup:435.17-435.25] datamode  :  datamode
[notation ../spec/3-typing.watsup:435.29-435.31] OK  :  OK
[notation ../spec/3-typing.watsup:436.20-436.38] C |- datamode : OK  :  context |- datamode : OK
[notation ../spec/3-typing.watsup:436.20-436.21] C  :  context
[elab ../spec/3-typing.watsup:436.20-436.21] C  :  context
[notation ../spec/3-typing.watsup:436.25-436.38] datamode : OK  :  datamode : OK
[notation ../spec/3-typing.watsup:436.25-436.33] datamode  :  datamode
[elab ../spec/3-typing.watsup:436.25-436.33] datamode  :  datamode
[notation ../spec/3-typing.watsup:436.36-436.38] OK  :  OK
[notation ../spec/3-typing.watsup:439.3-439.25] C |- {TABLE x expr} : rt  :  context |- elemmode : reftype
[notation ../spec/3-typing.watsup:439.3-439.4] C  :  context
[elab ../spec/3-typing.watsup:439.3-439.4] C  :  context
[notation ../spec/3-typing.watsup:439.8-439.25] {TABLE x expr} : rt  :  elemmode : reftype
[notation ../spec/3-typing.watsup:439.8-439.20] {TABLE x expr}  :  elemmode
[elab ../spec/3-typing.watsup:439.8-439.20] {TABLE x expr}  :  elemmode
[notation ../spec/3-typing.watsup:439.8-439.20] {x expr}  :  {tableidx expr}
[notation ../spec/3-typing.watsup:439.14-439.15] x  :  tableidx
[elab ../spec/3-typing.watsup:439.14-439.15] x  :  tableidx
[notation ../spec/3-typing.watsup:439.8-439.20] {expr}  :  {expr}
[notation ../spec/3-typing.watsup:439.16-439.20] expr  :  expr
[elab ../spec/3-typing.watsup:439.16-439.20] expr  :  expr
[notation ../spec/3-typing.watsup:439.8-439.20] {}  :  {}
[notation ../spec/3-typing.watsup:439.23-439.25] rt  :  reftype
[elab ../spec/3-typing.watsup:439.23-439.25] rt  :  reftype
[elab ../spec/3-typing.watsup:440.9-440.28] C.TABLE[x] = {lim rt}  :  bool
[elab ../spec/3-typing.watsup:440.9-440.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:440.9-440.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:440.9-440.10] C  :  context
[elab ../spec/3-typing.watsup:440.17-440.18] x  :  nat
[elab ../spec/3-typing.watsup:440.22-440.28] {lim rt}  :  tabletype
[notation ../spec/3-typing.watsup:440.22-440.28] {lim rt}  :  {limits reftype}
[notation ../spec/3-typing.watsup:440.22-440.25] lim  :  limits
[elab ../spec/3-typing.watsup:440.22-440.25] lim  :  limits
[notation ../spec/3-typing.watsup:440.22-440.28] {rt}  :  {reftype}
[notation ../spec/3-typing.watsup:440.26-440.28] rt  :  reftype
[elab ../spec/3-typing.watsup:440.26-440.28] rt  :  reftype
[notation ../spec/3-typing.watsup:440.22-440.28] {}  :  {}
[notation ../spec/3-typing.watsup:441.22-441.43] C |- expr : {I32 CONST}  :  context |- expr : {valtype CONST}
[notation ../spec/3-typing.watsup:441.22-441.23] C  :  context
[elab ../spec/3-typing.watsup:441.22-441.23] C  :  context
[notation ../spec/3-typing.watsup:441.27-441.43] expr : {I32 CONST}  :  expr : {valtype CONST}
[notation ../spec/3-typing.watsup:441.27-441.31] expr  :  expr
[elab ../spec/3-typing.watsup:441.27-441.31] expr  :  expr
[notation ../spec/3-typing.watsup:441.34-441.43] {I32 CONST}  :  {valtype CONST}
[notation ../spec/3-typing.watsup:441.34-441.37] I32  :  valtype
[elab ../spec/3-typing.watsup:441.34-441.37] I32  :  valtype
[notation ../spec/3-typing.watsup:441.34-441.37] {}  :  {}
[notation ../spec/3-typing.watsup:441.34-441.43] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:441.38-441.43] CONST  :  CONST
[notation ../spec/3-typing.watsup:441.34-441.43] {}  :  {}
[notation ../spec/3-typing.watsup:444.3-444.20] C |- DECLARE : rt  :  context |- elemmode : reftype
[notation ../spec/3-typing.watsup:444.3-444.4] C  :  context
[elab ../spec/3-typing.watsup:444.3-444.4] C  :  context
[notation ../spec/3-typing.watsup:444.8-444.20] DECLARE : rt  :  elemmode : reftype
[notation ../spec/3-typing.watsup:444.8-444.15] DECLARE  :  elemmode
[elab ../spec/3-typing.watsup:444.8-444.15] DECLARE  :  elemmode
[notation ../spec/3-typing.watsup:444.8-444.15] {}  :  {}
[notation ../spec/3-typing.watsup:444.18-444.20] rt  :  reftype
[elab ../spec/3-typing.watsup:444.18-444.20] rt  :  reftype
[notation ../spec/3-typing.watsup:447.3-447.26] C |- {MEMORY 0 expr} : OK  :  context |- datamode : OK
[notation ../spec/3-typing.watsup:447.3-447.4] C  :  context
[elab ../spec/3-typing.watsup:447.3-447.4] C  :  context
[notation ../spec/3-typing.watsup:447.8-447.26] {MEMORY 0 expr} : OK  :  datamode : OK
[notation ../spec/3-typing.watsup:447.8-447.21] {MEMORY 0 expr}  :  datamode
[elab ../spec/3-typing.watsup:447.8-447.21] {MEMORY 0 expr}  :  datamode
[notation ../spec/3-typing.watsup:447.8-447.21] {0 expr}  :  {memidx expr}
[notation ../spec/3-typing.watsup:447.15-447.16] 0  :  memidx
[elab ../spec/3-typing.watsup:447.15-447.16] 0  :  memidx
[notation ../spec/3-typing.watsup:447.8-447.21] {expr}  :  {expr}
[notation ../spec/3-typing.watsup:447.17-447.21] expr  :  expr
[elab ../spec/3-typing.watsup:447.17-447.21] expr  :  expr
[notation ../spec/3-typing.watsup:447.8-447.21] {}  :  {}
[notation ../spec/3-typing.watsup:447.24-447.26] OK  :  OK
[elab ../spec/3-typing.watsup:448.9-448.22] C.MEM[0] = mt  :  bool
[elab ../spec/3-typing.watsup:448.9-448.17] C.MEM[0]  :  memtype
[elab ../spec/3-typing.watsup:448.9-448.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:448.9-448.10] C  :  context
[elab ../spec/3-typing.watsup:448.15-448.16] 0  :  nat
[elab ../spec/3-typing.watsup:448.20-448.22] mt  :  memtype
[notation ../spec/3-typing.watsup:449.22-449.43] C |- expr : {I32 CONST}  :  context |- expr : {valtype CONST}
[notation ../spec/3-typing.watsup:449.22-449.23] C  :  context
[elab ../spec/3-typing.watsup:449.22-449.23] C  :  context
[notation ../spec/3-typing.watsup:449.27-449.43] expr : {I32 CONST}  :  expr : {valtype CONST}
[notation ../spec/3-typing.watsup:449.27-449.31] expr  :  expr
[elab ../spec/3-typing.watsup:449.27-449.31] expr  :  expr
[notation ../spec/3-typing.watsup:449.34-449.43] {I32 CONST}  :  {valtype CONST}
[notation ../spec/3-typing.watsup:449.34-449.37] I32  :  valtype
[elab ../spec/3-typing.watsup:449.34-449.37] I32  :  valtype
[notation ../spec/3-typing.watsup:449.34-449.37] {}  :  {}
[notation ../spec/3-typing.watsup:449.34-449.43] {CONST}  :  {CONST}
[notation ../spec/3-typing.watsup:449.38-449.43] CONST  :  CONST
[notation ../spec/3-typing.watsup:449.34-449.43] {}  :  {}
[notation ../spec/3-typing.watsup:452.3-452.20] C |- {START x} : OK  :  context |- start : OK
[notation ../spec/3-typing.watsup:452.3-452.4] C  :  context
[elab ../spec/3-typing.watsup:452.3-452.4] C  :  context
[notation ../spec/3-typing.watsup:452.8-452.20] {START x} : OK  :  start : OK
[notation ../spec/3-typing.watsup:452.8-452.15] {START x}  :  start
[elab ../spec/3-typing.watsup:452.8-452.15] {START x}  :  start
[notation ../spec/3-typing.watsup:452.8-452.15] {START x}  :  {START funcidx}
[notation ../spec/3-typing.watsup:452.8-452.13] START  :  START
[notation ../spec/3-typing.watsup:452.8-452.15] {x}  :  {funcidx}
[notation ../spec/3-typing.watsup:452.14-452.15] x  :  funcidx
[elab ../spec/3-typing.watsup:452.14-452.15] x  :  funcidx
[notation ../spec/3-typing.watsup:452.8-452.15] {}  :  {}
[notation ../spec/3-typing.watsup:452.18-452.20] OK  :  OK
[elab ../spec/3-typing.watsup:453.9-453.39] C.FUNC[x] = epsilon -> epsilon  :  bool
[elab ../spec/3-typing.watsup:453.9-453.18] C.FUNC[x]  :  functype
[elab ../spec/3-typing.watsup:453.9-453.15] C.FUNC  :  functype*
[elab ../spec/3-typing.watsup:453.9-453.10] C  :  context
[elab ../spec/3-typing.watsup:453.16-453.17] x  :  nat
[elab ../spec/3-typing.watsup:453.21-453.39] epsilon -> epsilon  :  functype
[notation ../spec/3-typing.watsup:453.21-453.39] epsilon -> epsilon  :  resulttype -> resulttype
[notation ../spec/3-typing.watsup:453.21-453.28] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:453.21-453.28] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:453.32-453.39] epsilon  :  resulttype
[elab ../spec/3-typing.watsup:453.32-453.39] epsilon  :  resulttype
[notation ../spec/3-typing.watsup:461.3-461.36] C |- {IMPORT name_1 name_2 xt} : xt  :  context |- import : externtype
[notation ../spec/3-typing.watsup:461.3-461.4] C  :  context
[elab ../spec/3-typing.watsup:461.3-461.4] C  :  context
[notation ../spec/3-typing.watsup:461.8-461.36] {IMPORT name_1 name_2 xt} : xt  :  import : externtype
[notation ../spec/3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  import
[elab ../spec/3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  import
[notation ../spec/3-typing.watsup:461.8-461.31] {IMPORT name_1 name_2 xt}  :  {IMPORT name name externtype}
[notation ../spec/3-typing.watsup:461.8-461.14] IMPORT  :  IMPORT
[notation ../spec/3-typing.watsup:461.8-461.31] {name_1 name_2 xt}  :  {name name externtype}
[notation ../spec/3-typing.watsup:461.15-461.21] name_1  :  name
[elab ../spec/3-typing.watsup:461.15-461.21] name_1  :  name
[notation ../spec/3-typing.watsup:461.8-461.31] {name_2 xt}  :  {name externtype}
[notation ../spec/3-typing.watsup:461.22-461.28] name_2  :  name
[elab ../spec/3-typing.watsup:461.22-461.28] name_2  :  name
[notation ../spec/3-typing.watsup:461.8-461.31] {xt}  :  {externtype}
[notation ../spec/3-typing.watsup:461.29-461.31] xt  :  externtype
[elab ../spec/3-typing.watsup:461.29-461.31] xt  :  externtype
[notation ../spec/3-typing.watsup:461.8-461.31] {}  :  {}
[notation ../spec/3-typing.watsup:461.34-461.36] xt  :  externtype
[elab ../spec/3-typing.watsup:461.34-461.36] xt  :  externtype
[notation ../spec/3-typing.watsup:462.21-462.31] {} |- xt : OK  :  {} |- externtype : OK
[notation ../spec/3-typing.watsup:462.21-462.23] {}  :  {}
[notation ../spec/3-typing.watsup:462.24-462.31] xt : OK  :  externtype : OK
[notation ../spec/3-typing.watsup:462.24-462.26] xt  :  externtype
[elab ../spec/3-typing.watsup:462.24-462.26] xt  :  externtype
[notation ../spec/3-typing.watsup:462.29-462.31] OK  :  OK
[notation ../spec/3-typing.watsup:465.3-465.34] C |- {EXPORT name externuse} : xt  :  context |- export : externtype
[notation ../spec/3-typing.watsup:465.3-465.4] C  :  context
[elab ../spec/3-typing.watsup:465.3-465.4] C  :  context
[notation ../spec/3-typing.watsup:465.8-465.34] {EXPORT name externuse} : xt  :  export : externtype
[notation ../spec/3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  export
[elab ../spec/3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  export
[notation ../spec/3-typing.watsup:465.8-465.29] {EXPORT name externuse}  :  {EXPORT name externuse}
[notation ../spec/3-typing.watsup:465.8-465.14] EXPORT  :  EXPORT
[notation ../spec/3-typing.watsup:465.8-465.29] {name externuse}  :  {name externuse}
[notation ../spec/3-typing.watsup:465.15-465.19] name  :  name
[elab ../spec/3-typing.watsup:465.15-465.19] name  :  name
[notation ../spec/3-typing.watsup:465.8-465.29] {externuse}  :  {externuse}
[notation ../spec/3-typing.watsup:465.20-465.29] externuse  :  externuse
[elab ../spec/3-typing.watsup:465.20-465.29] externuse  :  externuse
[notation ../spec/3-typing.watsup:465.8-465.29] {}  :  {}
[notation ../spec/3-typing.watsup:465.32-465.34] xt  :  externtype
[elab ../spec/3-typing.watsup:465.32-465.34] xt  :  externtype
[notation ../spec/3-typing.watsup:466.20-466.39] C |- externuse : xt  :  context |- externuse : externtype
[notation ../spec/3-typing.watsup:466.20-466.21] C  :  context
[elab ../spec/3-typing.watsup:466.20-466.21] C  :  context
[notation ../spec/3-typing.watsup:466.25-466.39] externuse : xt  :  externuse : externtype
[notation ../spec/3-typing.watsup:466.25-466.34] externuse  :  externuse
[elab ../spec/3-typing.watsup:466.25-466.34] externuse  :  externuse
[notation ../spec/3-typing.watsup:466.37-466.39] xt  :  externtype
[elab ../spec/3-typing.watsup:466.37-466.39] xt  :  externtype
[notation ../spec/3-typing.watsup:469.3-469.24] C |- {FUNC x} : {FUNC ft}  :  context |- externuse : externtype
[notation ../spec/3-typing.watsup:469.3-469.4] C  :  context
[elab ../spec/3-typing.watsup:469.3-469.4] C  :  context
[notation ../spec/3-typing.watsup:469.8-469.24] {FUNC x} : {FUNC ft}  :  externuse : externtype
[notation ../spec/3-typing.watsup:469.8-469.14] {FUNC x}  :  externuse
[elab ../spec/3-typing.watsup:469.8-469.14] {FUNC x}  :  externuse
[notation ../spec/3-typing.watsup:469.8-469.14] {x}  :  {funcidx}
[notation ../spec/3-typing.watsup:469.13-469.14] x  :  funcidx
[elab ../spec/3-typing.watsup:469.13-469.14] x  :  funcidx
[notation ../spec/3-typing.watsup:469.8-469.14] {}  :  {}
[notation ../spec/3-typing.watsup:469.17-469.24] {FUNC ft}  :  externtype
[elab ../spec/3-typing.watsup:469.17-469.24] {FUNC ft}  :  externtype
[notation ../spec/3-typing.watsup:469.17-469.24] {ft}  :  {functype}
[notation ../spec/3-typing.watsup:469.22-469.24] ft  :  functype
[elab ../spec/3-typing.watsup:469.22-469.24] ft  :  functype
[notation ../spec/3-typing.watsup:469.17-469.24] {}  :  {}
[elab ../spec/3-typing.watsup:470.9-470.23] C.FUNC[x] = ft  :  bool
[elab ../spec/3-typing.watsup:470.9-470.18] C.FUNC[x]  :  functype
[elab ../spec/3-typing.watsup:470.9-470.15] C.FUNC  :  functype*
[elab ../spec/3-typing.watsup:470.9-470.10] C  :  context
[elab ../spec/3-typing.watsup:470.16-470.17] x  :  nat
[elab ../spec/3-typing.watsup:470.21-470.23] ft  :  functype
[notation ../spec/3-typing.watsup:473.3-473.28] C |- {GLOBAL x} : {GLOBAL gt}  :  context |- externuse : externtype
[notation ../spec/3-typing.watsup:473.3-473.4] C  :  context
[elab ../spec/3-typing.watsup:473.3-473.4] C  :  context
[notation ../spec/3-typing.watsup:473.8-473.28] {GLOBAL x} : {GLOBAL gt}  :  externuse : externtype
[notation ../spec/3-typing.watsup:473.8-473.16] {GLOBAL x}  :  externuse
[elab ../spec/3-typing.watsup:473.8-473.16] {GLOBAL x}  :  externuse
[notation ../spec/3-typing.watsup:473.8-473.16] {x}  :  {globalidx}
[notation ../spec/3-typing.watsup:473.15-473.16] x  :  globalidx
[elab ../spec/3-typing.watsup:473.15-473.16] x  :  globalidx
[notation ../spec/3-typing.watsup:473.8-473.16] {}  :  {}
[notation ../spec/3-typing.watsup:473.19-473.28] {GLOBAL gt}  :  externtype
[elab ../spec/3-typing.watsup:473.19-473.28] {GLOBAL gt}  :  externtype
[notation ../spec/3-typing.watsup:473.19-473.28] {gt}  :  {globaltype}
[notation ../spec/3-typing.watsup:473.26-473.28] gt  :  globaltype
[elab ../spec/3-typing.watsup:473.26-473.28] gt  :  globaltype
[notation ../spec/3-typing.watsup:473.19-473.28] {}  :  {}
[elab ../spec/3-typing.watsup:474.9-474.25] C.GLOBAL[x] = gt  :  bool
[elab ../spec/3-typing.watsup:474.9-474.20] C.GLOBAL[x]  :  globaltype
[elab ../spec/3-typing.watsup:474.9-474.17] C.GLOBAL  :  globaltype*
[elab ../spec/3-typing.watsup:474.9-474.10] C  :  context
[elab ../spec/3-typing.watsup:474.18-474.19] x  :  nat
[elab ../spec/3-typing.watsup:474.23-474.25] gt  :  globaltype
[notation ../spec/3-typing.watsup:477.3-477.26] C |- {TABLE x} : {TABLE tt}  :  context |- externuse : externtype
[notation ../spec/3-typing.watsup:477.3-477.4] C  :  context
[elab ../spec/3-typing.watsup:477.3-477.4] C  :  context
[notation ../spec/3-typing.watsup:477.8-477.26] {TABLE x} : {TABLE tt}  :  externuse : externtype
[notation ../spec/3-typing.watsup:477.8-477.15] {TABLE x}  :  externuse
[elab ../spec/3-typing.watsup:477.8-477.15] {TABLE x}  :  externuse
[notation ../spec/3-typing.watsup:477.8-477.15] {x}  :  {tableidx}
[notation ../spec/3-typing.watsup:477.14-477.15] x  :  tableidx
[elab ../spec/3-typing.watsup:477.14-477.15] x  :  tableidx
[notation ../spec/3-typing.watsup:477.8-477.15] {}  :  {}
[notation ../spec/3-typing.watsup:477.18-477.26] {TABLE tt}  :  externtype
[elab ../spec/3-typing.watsup:477.18-477.26] {TABLE tt}  :  externtype
[notation ../spec/3-typing.watsup:477.18-477.26] {tt}  :  {tabletype}
[notation ../spec/3-typing.watsup:477.24-477.26] tt  :  tabletype
[elab ../spec/3-typing.watsup:477.24-477.26] tt  :  tabletype
[notation ../spec/3-typing.watsup:477.18-477.26] {}  :  {}
[elab ../spec/3-typing.watsup:478.9-478.24] C.TABLE[x] = tt  :  bool
[elab ../spec/3-typing.watsup:478.9-478.19] C.TABLE[x]  :  tabletype
[elab ../spec/3-typing.watsup:478.9-478.16] C.TABLE  :  tabletype*
[elab ../spec/3-typing.watsup:478.9-478.10] C  :  context
[elab ../spec/3-typing.watsup:478.17-478.18] x  :  nat
[elab ../spec/3-typing.watsup:478.22-478.24] tt  :  tabletype
[notation ../spec/3-typing.watsup:481.3-481.28] C |- {MEMORY x} : {MEMORY mt}  :  context |- externuse : externtype
[notation ../spec/3-typing.watsup:481.3-481.4] C  :  context
[elab ../spec/3-typing.watsup:481.3-481.4] C  :  context
[notation ../spec/3-typing.watsup:481.8-481.28] {MEMORY x} : {MEMORY mt}  :  externuse : externtype
[notation ../spec/3-typing.watsup:481.8-481.16] {MEMORY x}  :  externuse
[elab ../spec/3-typing.watsup:481.8-481.16] {MEMORY x}  :  externuse
[notation ../spec/3-typing.watsup:481.8-481.16] {x}  :  {memidx}
[notation ../spec/3-typing.watsup:481.15-481.16] x  :  memidx
[elab ../spec/3-typing.watsup:481.15-481.16] x  :  memidx
[notation ../spec/3-typing.watsup:481.8-481.16] {}  :  {}
[notation ../spec/3-typing.watsup:481.19-481.28] {MEMORY mt}  :  externtype
[elab ../spec/3-typing.watsup:481.19-481.28] {MEMORY mt}  :  externtype
[notation ../spec/3-typing.watsup:481.19-481.28] {mt}  :  {memtype}
[notation ../spec/3-typing.watsup:481.26-481.28] mt  :  memtype
[elab ../spec/3-typing.watsup:481.26-481.28] mt  :  memtype
[notation ../spec/3-typing.watsup:481.19-481.28] {}  :  {}
[elab ../spec/3-typing.watsup:482.9-482.22] C.MEM[x] = mt  :  bool
[elab ../spec/3-typing.watsup:482.9-482.17] C.MEM[x]  :  memtype
[elab ../spec/3-typing.watsup:482.9-482.14] C.MEM  :  memtype*
[elab ../spec/3-typing.watsup:482.9-482.10] C  :  context
[elab ../spec/3-typing.watsup:482.15-482.16] x  :  nat
[elab ../spec/3-typing.watsup:482.20-482.22] mt  :  memtype
[notation ../spec/3-typing.watsup:488.3-488.79] {} |- {MODULE import* func* global* table* mem* elem* data^n start* export*} : OK  :  {} |- module : OK
[notation ../spec/3-typing.watsup:488.3-488.5] {}  :  {}
[notation ../spec/3-typing.watsup:488.6-488.79] {MODULE import* func* global* table* mem* elem* data^n start* export*} : OK  :  module : OK
[notation ../spec/3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  module
[elab ../spec/3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  module
[notation ../spec/3-typing.watsup:488.6-488.74] {MODULE import* func* global* table* mem* elem* data^n start* export*}  :  {MODULE import* func* global* table* mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.6-488.12] MODULE  :  MODULE
[notation ../spec/3-typing.watsup:488.6-488.74] {import* func* global* table* mem* elem* data^n start* export*}  :  {import* func* global* table* mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.13-488.20] import*  :  import*
[notation ../spec/3-typing.watsup:488.13-488.19] import  :  import
[elab ../spec/3-typing.watsup:488.13-488.19] import  :  import
[notation ../spec/3-typing.watsup:488.6-488.74] {func* global* table* mem* elem* data^n start* export*}  :  {func* global* table* mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.21-488.26] func*  :  func*
[notation ../spec/3-typing.watsup:488.21-488.25] func  :  func
[elab ../spec/3-typing.watsup:488.21-488.25] func  :  func
[notation ../spec/3-typing.watsup:488.6-488.74] {global* table* mem* elem* data^n start* export*}  :  {global* table* mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.27-488.34] global*  :  global*
[notation ../spec/3-typing.watsup:488.27-488.33] global  :  global
[elab ../spec/3-typing.watsup:488.27-488.33] global  :  global
[notation ../spec/3-typing.watsup:488.6-488.74] {table* mem* elem* data^n start* export*}  :  {table* mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.35-488.41] table*  :  table*
[notation ../spec/3-typing.watsup:488.35-488.40] table  :  table
[elab ../spec/3-typing.watsup:488.35-488.40] table  :  table
[notation ../spec/3-typing.watsup:488.6-488.74] {mem* elem* data^n start* export*}  :  {mem* elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.42-488.46] mem*  :  mem*
[notation ../spec/3-typing.watsup:488.42-488.45] mem  :  mem
[elab ../spec/3-typing.watsup:488.42-488.45] mem  :  mem
[notation ../spec/3-typing.watsup:488.6-488.74] {elem* data^n start* export*}  :  {elem* data* start* export*}
[notation ../spec/3-typing.watsup:488.47-488.52] elem*  :  elem*
[notation ../spec/3-typing.watsup:488.47-488.51] elem  :  elem
[elab ../spec/3-typing.watsup:488.47-488.51] elem  :  elem
[notation ../spec/3-typing.watsup:488.6-488.74] {data^n start* export*}  :  {data* start* export*}
[notation ../spec/3-typing.watsup:488.53-488.59] data^n  :  data*
[notation ../spec/3-typing.watsup:488.53-488.57] data  :  data
[elab ../spec/3-typing.watsup:488.53-488.57] data  :  data
[elab ../spec/3-typing.watsup:488.58-488.59] n  :  nat
[notation ../spec/3-typing.watsup:488.6-488.74] {start* export*}  :  {start* export*}
[notation ../spec/3-typing.watsup:488.60-488.66] start*  :  start*
[notation ../spec/3-typing.watsup:488.60-488.65] start  :  start
[elab ../spec/3-typing.watsup:488.60-488.65] start  :  start
[notation ../spec/3-typing.watsup:488.6-488.74] {export*}  :  {export*}
[notation ../spec/3-typing.watsup:488.6-488.74] {export*}  :  export*
[elab ../spec/3-typing.watsup:488.67-488.74] export*  :  export*
[elab ../spec/3-typing.watsup:488.67-488.73] export  :  export
[notation ../spec/3-typing.watsup:488.77-488.79] OK  :  OK
[notation ../spec/3-typing.watsup:489.16-489.30] C |- func : ft  :  context |- func : functype
[notation ../spec/3-typing.watsup:489.16-489.17] C  :  context
[elab ../spec/3-typing.watsup:489.16-489.17] C  :  context
[notation ../spec/3-typing.watsup:489.21-489.30] func : ft  :  func : functype
[notation ../spec/3-typing.watsup:489.21-489.25] func  :  func
[elab ../spec/3-typing.watsup:489.21-489.25] func  :  func
[notation ../spec/3-typing.watsup:489.28-489.30] ft  :  functype
[elab ../spec/3-typing.watsup:489.28-489.30] ft  :  functype
[notation ../spec/3-typing.watsup:490.18-490.34] C |- global : gt  :  context |- global : globaltype
[notation ../spec/3-typing.watsup:490.18-490.19] C  :  context
[elab ../spec/3-typing.watsup:490.18-490.19] C  :  context
[notation ../spec/3-typing.watsup:490.23-490.34] global : gt  :  global : globaltype
[notation ../spec/3-typing.watsup:490.23-490.29] global  :  global
[elab ../spec/3-typing.watsup:490.23-490.29] global  :  global
[notation ../spec/3-typing.watsup:490.32-490.34] gt  :  globaltype
[elab ../spec/3-typing.watsup:490.32-490.34] gt  :  globaltype
[notation ../spec/3-typing.watsup:491.17-491.32] C |- table : tt  :  context |- table : tabletype
[notation ../spec/3-typing.watsup:491.17-491.18] C  :  context
[elab ../spec/3-typing.watsup:491.17-491.18] C  :  context
[notation ../spec/3-typing.watsup:491.22-491.32] table : tt  :  table : tabletype
[notation ../spec/3-typing.watsup:491.22-491.27] table  :  table
[elab ../spec/3-typing.watsup:491.22-491.27] table  :  table
[notation ../spec/3-typing.watsup:491.30-491.32] tt  :  tabletype
[elab ../spec/3-typing.watsup:491.30-491.32] tt  :  tabletype
[notation ../spec/3-typing.watsup:492.15-492.28] C |- mem : mt  :  context |- mem : memtype
[notation ../spec/3-typing.watsup:492.15-492.16] C  :  context
[elab ../spec/3-typing.watsup:492.15-492.16] C  :  context
[notation ../spec/3-typing.watsup:492.20-492.28] mem : mt  :  mem : memtype
[notation ../spec/3-typing.watsup:492.20-492.23] mem  :  mem
[elab ../spec/3-typing.watsup:492.20-492.23] mem  :  mem
[notation ../spec/3-typing.watsup:492.26-492.28] mt  :  memtype
[elab ../spec/3-typing.watsup:492.26-492.28] mt  :  memtype
[notation ../spec/3-typing.watsup:493.16-493.30] C |- elem : rt  :  context |- elem : reftype
[notation ../spec/3-typing.watsup:493.16-493.17] C  :  context
[elab ../spec/3-typing.watsup:493.16-493.17] C  :  context
[notation ../spec/3-typing.watsup:493.21-493.30] elem : rt  :  elem : reftype
[notation ../spec/3-typing.watsup:493.21-493.25] elem  :  elem
[elab ../spec/3-typing.watsup:493.21-493.25] elem  :  elem
[notation ../spec/3-typing.watsup:493.28-493.30] rt  :  reftype
[elab ../spec/3-typing.watsup:493.28-493.30] rt  :  reftype
[notation ../spec/3-typing.watsup:494.16-494.30] C |- data : OK  :  context |- data : OK
[notation ../spec/3-typing.watsup:494.16-494.17] C  :  context
[elab ../spec/3-typing.watsup:494.16-494.17] C  :  context
[notation ../spec/3-typing.watsup:494.21-494.30] data : OK  :  data : OK
[notation ../spec/3-typing.watsup:494.21-494.25] data  :  data
[elab ../spec/3-typing.watsup:494.21-494.25] data  :  data
[notation ../spec/3-typing.watsup:494.28-494.30] OK  :  OK
[elab ../spec/3-typing.watsup:494.32-494.33] n  :  nat
[notation ../spec/3-typing.watsup:495.17-495.32] C |- start : OK  :  context |- start : OK
[notation ../spec/3-typing.watsup:495.17-495.18] C  :  context
[elab ../spec/3-typing.watsup:495.17-495.18] C  :  context
[notation ../spec/3-typing.watsup:495.22-495.32] start : OK  :  start : OK
[notation ../spec/3-typing.watsup:495.22-495.27] start  :  start
[elab ../spec/3-typing.watsup:495.22-495.27] start  :  start
[notation ../spec/3-typing.watsup:495.30-495.32] OK  :  OK
[elab ../spec/3-typing.watsup:497.9-497.76] C = {FUNC ft*, GLOBAL gt*, TABLE tt*, MEM mt*, ELEM rt*, DATA OK^n}  :  bool
[elab ../spec/3-typing.watsup:497.9-497.10] C  :  context
[elab ../spec/3-typing.watsup:497.13-497.76] {FUNC ft*, GLOBAL gt*, TABLE tt*, MEM mt*, ELEM rt*, DATA OK^n}  :  context
[notation ../spec/3-typing.watsup:497.19-497.22] ft*  :  functype*
[notation ../spec/3-typing.watsup:497.19-497.21] ft  :  functype
[elab ../spec/3-typing.watsup:497.19-497.21] ft  :  functype
[notation ../spec/3-typing.watsup:497.31-497.34] gt*  :  globaltype*
[notation ../spec/3-typing.watsup:497.31-497.33] gt  :  globaltype
[elab ../spec/3-typing.watsup:497.31-497.33] gt  :  globaltype
[notation ../spec/3-typing.watsup:497.42-497.45] tt*  :  tabletype*
[notation ../spec/3-typing.watsup:497.42-497.44] tt  :  tabletype
[elab ../spec/3-typing.watsup:497.42-497.44] tt  :  tabletype
[notation ../spec/3-typing.watsup:497.51-497.54] mt*  :  memtype*
[notation ../spec/3-typing.watsup:497.51-497.53] mt  :  memtype
[elab ../spec/3-typing.watsup:497.51-497.53] mt  :  memtype
[notation ../spec/3-typing.watsup:497.61-497.64] rt*  :  elemtype*
[notation ../spec/3-typing.watsup:497.61-497.63] rt  :  elemtype
[elab ../spec/3-typing.watsup:497.61-497.63] rt  :  elemtype
[notation ../spec/3-typing.watsup:497.71-497.75] OK^n  :  datatype*
[notation ../spec/3-typing.watsup:497.71-497.73] OK  :  datatype
[elab ../spec/3-typing.watsup:497.71-497.73] OK  :  datatype
[notation ../spec/3-typing.watsup:497.71-497.73] OK  :  OK
[elab ../spec/3-typing.watsup:497.74-497.75] n  :  nat
[elab ../spec/3-typing.watsup:498.9-498.20] |mem*| <= 1  :  bool
[elab ../spec/3-typing.watsup:498.9-498.15] |mem*|  :  nat
[elab ../spec/3-typing.watsup:498.10-498.14] mem*  :  mem*
[elab ../spec/3-typing.watsup:498.10-498.13] mem  :  mem
[elab ../spec/3-typing.watsup:498.19-498.20] 1  :  nat
[elab ../spec/3-typing.watsup:499.9-499.22] |start*| <= 1  :  bool
[elab ../spec/3-typing.watsup:499.9-499.17] |start*|  :  nat
[elab ../spec/3-typing.watsup:499.10-499.16] start*  :  start*
[elab ../spec/3-typing.watsup:499.10-499.15] start  :  start
[elab ../spec/3-typing.watsup:499.21-499.22] 1  :  nat
[elab ../spec/3-typing.watsup:494.32-494.33] n  :  nat
[elab ../spec/4-runtime.watsup:44.14-44.23] (valtype)  :  (valtype)
[elab ../spec/4-runtime.watsup:44.15-44.22] valtype  :  (valtype)
[elab ../spec/4-runtime.watsup:45.14-45.19] (I32)  :  (valtype)
[elab ../spec/4-runtime.watsup:45.15-45.18] I32  :  (valtype)
[notation ../spec/4-runtime.watsup:45.15-45.18] {}  :  {}
[elab ../spec/4-runtime.watsup:45.22-45.35] ({CONST I32 0})  :  val
[elab ../spec/4-runtime.watsup:45.23-45.34] {CONST I32 0}  :  val
[notation ../spec/4-runtime.watsup:45.23-45.34] {I32 0}  :  {numtype c_numtype}
[notation ../spec/4-runtime.watsup:45.29-45.32] I32  :  numtype
[elab ../spec/4-runtime.watsup:45.29-45.32] I32  :  numtype
[notation ../spec/4-runtime.watsup:45.29-45.32] {}  :  {}
[notation ../spec/4-runtime.watsup:45.23-45.34] {0}  :  {c_numtype}
[notation ../spec/4-runtime.watsup:45.33-45.34] 0  :  c_numtype
[elab ../spec/4-runtime.watsup:45.33-45.34] 0  :  c_numtype
[notation ../spec/4-runtime.watsup:45.23-45.34] {}  :  {}
[elab ../spec/4-runtime.watsup:46.14-46.19] (I64)  :  (valtype)
[elab ../spec/4-runtime.watsup:46.15-46.18] I64  :  (valtype)
[notation ../spec/4-runtime.watsup:46.15-46.18] {}  :  {}
[elab ../spec/4-runtime.watsup:46.22-46.35] ({CONST I64 0})  :  val
[elab ../spec/4-runtime.watsup:46.23-46.34] {CONST I64 0}  :  val
[notation ../spec/4-runtime.watsup:46.23-46.34] {I64 0}  :  {numtype c_numtype}
[notation ../spec/4-runtime.watsup:46.29-46.32] I64  :  numtype
[elab ../spec/4-runtime.watsup:46.29-46.32] I64  :  numtype
[notation ../spec/4-runtime.watsup:46.29-46.32] {}  :  {}
[notation ../spec/4-runtime.watsup:46.23-46.34] {0}  :  {c_numtype}
[notation ../spec/4-runtime.watsup:46.33-46.34] 0  :  c_numtype
[elab ../spec/4-runtime.watsup:46.33-46.34] 0  :  c_numtype
[notation ../spec/4-runtime.watsup:46.23-46.34] {}  :  {}
[elab ../spec/4-runtime.watsup:47.14-47.19] (F32)  :  (valtype)
[elab ../spec/4-runtime.watsup:47.15-47.18] F32  :  (valtype)
[notation ../spec/4-runtime.watsup:47.15-47.18] {}  :  {}
[elab ../spec/4-runtime.watsup:47.22-47.35] ({CONST F32 0})  :  val
[elab ../spec/4-runtime.watsup:47.23-47.34] {CONST F32 0}  :  val
[notation ../spec/4-runtime.watsup:47.23-47.34] {F32 0}  :  {numtype c_numtype}
[notation ../spec/4-runtime.watsup:47.29-47.32] F32  :  numtype
[elab ../spec/4-runtime.watsup:47.29-47.32] F32  :  numtype
[notation ../spec/4-runtime.watsup:47.29-47.32] {}  :  {}
[notation ../spec/4-runtime.watsup:47.23-47.34] {0}  :  {c_numtype}
[notation ../spec/4-runtime.watsup:47.33-47.34] 0  :  c_numtype
[elab ../spec/4-runtime.watsup:47.33-47.34] 0  :  c_numtype
[notation ../spec/4-runtime.watsup:47.23-47.34] {}  :  {}
[elab ../spec/4-runtime.watsup:48.14-48.19] (F64)  :  (valtype)
[elab ../spec/4-runtime.watsup:48.15-48.18] F64  :  (valtype)
[notation ../spec/4-runtime.watsup:48.15-48.18] {}  :  {}
[elab ../spec/4-runtime.watsup:48.22-48.35] ({CONST F64 0})  :  val
[elab ../spec/4-runtime.watsup:48.23-48.34] {CONST F64 0}  :  val
[notation ../spec/4-runtime.watsup:48.23-48.34] {F64 0}  :  {numtype c_numtype}
[notation ../spec/4-runtime.watsup:48.29-48.32] F64  :  numtype
[elab ../spec/4-runtime.watsup:48.29-48.32] F64  :  numtype
[notation ../spec/4-runtime.watsup:48.29-48.32] {}  :  {}
[notation ../spec/4-runtime.watsup:48.23-48.34] {0}  :  {c_numtype}
[notation ../spec/4-runtime.watsup:48.33-48.34] 0  :  c_numtype
[elab ../spec/4-runtime.watsup:48.33-48.34] 0  :  c_numtype
[notation ../spec/4-runtime.watsup:48.23-48.34] {}  :  {}
[elab ../spec/4-runtime.watsup:49.14-49.18] (rt)  :  (valtype)
[elab ../spec/4-runtime.watsup:49.15-49.17] rt  :  (valtype)
[elab ../spec/4-runtime.watsup:49.21-49.34] ({REF.NULL rt})  :  val
[elab ../spec/4-runtime.watsup:49.22-49.33] {REF.NULL rt}  :  val
[notation ../spec/4-runtime.watsup:49.22-49.33] {rt}  :  {reftype}
[notation ../spec/4-runtime.watsup:49.31-49.33] rt  :  reftype
[elab ../spec/4-runtime.watsup:49.31-49.33] rt  :  reftype
[notation ../spec/4-runtime.watsup:49.22-49.33] {}  :  {}
[elab ../spec/4-runtime.watsup:98.14-98.21] (state)  :  (state)
[elab ../spec/4-runtime.watsup:98.15-98.20] state  :  (state)
[elab ../spec/4-runtime.watsup:99.14-99.22] ((s ; f))  :  (state)
[elab ../spec/4-runtime.watsup:99.15-99.21] (s ; f)  :  (state)
[elab ../spec/4-runtime.watsup:99.16-99.20] s ; f  :  (state)
[notation ../spec/4-runtime.watsup:99.16-99.20] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:99.16-99.17] s  :  store
[elab ../spec/4-runtime.watsup:99.16-99.17] s  :  store
[notation ../spec/4-runtime.watsup:99.19-99.20] f  :  frame
[elab ../spec/4-runtime.watsup:99.19-99.20] f  :  frame
[elab ../spec/4-runtime.watsup:99.25-99.38] f.MODULE.FUNC  :  funcaddr*
[elab ../spec/4-runtime.watsup:99.25-99.33] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:99.25-99.26] f  :  frame
[elab ../spec/4-runtime.watsup:101.14-101.21] (state)  :  (state)
[elab ../spec/4-runtime.watsup:101.15-101.20] state  :  (state)
[elab ../spec/4-runtime.watsup:102.14-102.22] ((s ; f))  :  (state)
[elab ../spec/4-runtime.watsup:102.15-102.21] (s ; f)  :  (state)
[elab ../spec/4-runtime.watsup:102.16-102.20] s ; f  :  (state)
[notation ../spec/4-runtime.watsup:102.16-102.20] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:102.16-102.17] s  :  store
[elab ../spec/4-runtime.watsup:102.16-102.17] s  :  store
[notation ../spec/4-runtime.watsup:102.19-102.20] f  :  frame
[elab ../spec/4-runtime.watsup:102.19-102.20] f  :  frame
[elab ../spec/4-runtime.watsup:102.25-102.31] s.FUNC  :  funcinst*
[elab ../spec/4-runtime.watsup:102.25-102.26] s  :  store
[elab ../spec/4-runtime.watsup:104.10-104.26] (state, funcidx)  :  (state, funcidx)
[elab ../spec/4-runtime.watsup:104.11-104.16] state  :  state
[elab ../spec/4-runtime.watsup:104.18-104.25] funcidx  :  funcidx
[elab ../spec/4-runtime.watsup:105.10-105.21] ((s ; f), x)  :  (state, funcidx)
[elab ../spec/4-runtime.watsup:105.11-105.17] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:105.12-105.16] s ; f  :  state
[notation ../spec/4-runtime.watsup:105.12-105.16] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:105.12-105.13] s  :  store
[elab ../spec/4-runtime.watsup:105.12-105.13] s  :  store
[notation ../spec/4-runtime.watsup:105.15-105.16] f  :  frame
[elab ../spec/4-runtime.watsup:105.15-105.16] f  :  frame
[elab ../spec/4-runtime.watsup:105.19-105.20] x  :  funcidx
[elab ../spec/4-runtime.watsup:105.24-105.48] s.FUNC[f.MODULE.FUNC[x]]  :  funcinst
[elab ../spec/4-runtime.watsup:105.24-105.30] s.FUNC  :  funcinst*
[elab ../spec/4-runtime.watsup:105.24-105.25] s  :  store
[elab ../spec/4-runtime.watsup:105.31-105.47] f.MODULE.FUNC[x]  :  nat
[elab ../spec/4-runtime.watsup:105.31-105.44] f.MODULE.FUNC  :  funcaddr*
[elab ../spec/4-runtime.watsup:105.31-105.39] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:105.31-105.32] f  :  frame
[elab ../spec/4-runtime.watsup:105.45-105.46] x  :  nat
[elab ../spec/4-runtime.watsup:107.11-107.28] (state, localidx)  :  (state, localidx)
[elab ../spec/4-runtime.watsup:107.12-107.17] state  :  state
[elab ../spec/4-runtime.watsup:107.19-107.27] localidx  :  localidx
[elab ../spec/4-runtime.watsup:108.11-108.22] ((s ; f), x)  :  (state, localidx)
[elab ../spec/4-runtime.watsup:108.12-108.18] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:108.13-108.17] s ; f  :  state
[notation ../spec/4-runtime.watsup:108.13-108.17] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:108.13-108.14] s  :  store
[elab ../spec/4-runtime.watsup:108.13-108.14] s  :  store
[notation ../spec/4-runtime.watsup:108.16-108.17] f  :  frame
[elab ../spec/4-runtime.watsup:108.16-108.17] f  :  frame
[elab ../spec/4-runtime.watsup:108.20-108.21] x  :  localidx
[elab ../spec/4-runtime.watsup:108.25-108.35] f.LOCAL[x]  :  val
[elab ../spec/4-runtime.watsup:108.25-108.32] f.LOCAL  :  val*
[elab ../spec/4-runtime.watsup:108.25-108.26] f  :  frame
[elab ../spec/4-runtime.watsup:108.33-108.34] x  :  nat
[elab ../spec/4-runtime.watsup:110.12-110.30] (state, globalidx)  :  (state, globalidx)
[elab ../spec/4-runtime.watsup:110.13-110.18] state  :  state
[elab ../spec/4-runtime.watsup:110.20-110.29] globalidx  :  globalidx
[elab ../spec/4-runtime.watsup:111.12-111.23] ((s ; f), x)  :  (state, globalidx)
[elab ../spec/4-runtime.watsup:111.13-111.19] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:111.14-111.18] s ; f  :  state
[notation ../spec/4-runtime.watsup:111.14-111.18] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:111.14-111.15] s  :  store
[elab ../spec/4-runtime.watsup:111.14-111.15] s  :  store
[notation ../spec/4-runtime.watsup:111.17-111.18] f  :  frame
[elab ../spec/4-runtime.watsup:111.17-111.18] f  :  frame
[elab ../spec/4-runtime.watsup:111.21-111.22] x  :  globalidx
[elab ../spec/4-runtime.watsup:111.26-111.54] s.GLOBAL[f.MODULE.GLOBAL[x]]  :  globalinst
[elab ../spec/4-runtime.watsup:111.26-111.34] s.GLOBAL  :  globalinst*
[elab ../spec/4-runtime.watsup:111.26-111.27] s  :  store
[elab ../spec/4-runtime.watsup:111.35-111.53] f.MODULE.GLOBAL[x]  :  nat
[elab ../spec/4-runtime.watsup:111.35-111.50] f.MODULE.GLOBAL  :  globaladdr*
[elab ../spec/4-runtime.watsup:111.35-111.43] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:111.35-111.36] f  :  frame
[elab ../spec/4-runtime.watsup:111.51-111.52] x  :  nat
[elab ../spec/4-runtime.watsup:113.11-113.28] (state, tableidx)  :  (state, tableidx)
[elab ../spec/4-runtime.watsup:113.12-113.17] state  :  state
[elab ../spec/4-runtime.watsup:113.19-113.27] tableidx  :  tableidx
[elab ../spec/4-runtime.watsup:114.11-114.22] ((s ; f), x)  :  (state, tableidx)
[elab ../spec/4-runtime.watsup:114.12-114.18] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:114.13-114.17] s ; f  :  state
[notation ../spec/4-runtime.watsup:114.13-114.17] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:114.13-114.14] s  :  store
[elab ../spec/4-runtime.watsup:114.13-114.14] s  :  store
[notation ../spec/4-runtime.watsup:114.16-114.17] f  :  frame
[elab ../spec/4-runtime.watsup:114.16-114.17] f  :  frame
[elab ../spec/4-runtime.watsup:114.20-114.21] x  :  tableidx
[elab ../spec/4-runtime.watsup:114.25-114.51] s.TABLE[f.MODULE.TABLE[x]]  :  tableinst
[elab ../spec/4-runtime.watsup:114.25-114.32] s.TABLE  :  tableinst*
[elab ../spec/4-runtime.watsup:114.25-114.26] s  :  store
[elab ../spec/4-runtime.watsup:114.33-114.50] f.MODULE.TABLE[x]  :  nat
[elab ../spec/4-runtime.watsup:114.33-114.47] f.MODULE.TABLE  :  tableaddr*
[elab ../spec/4-runtime.watsup:114.33-114.41] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:114.33-114.34] f  :  frame
[elab ../spec/4-runtime.watsup:114.48-114.49] x  :  nat
[elab ../spec/4-runtime.watsup:116.10-116.27] (state, tableidx)  :  (state, tableidx)
[elab ../spec/4-runtime.watsup:116.11-116.16] state  :  state
[elab ../spec/4-runtime.watsup:116.18-116.26] tableidx  :  tableidx
[elab ../spec/4-runtime.watsup:117.10-117.21] ((s ; f), x)  :  (state, tableidx)
[elab ../spec/4-runtime.watsup:117.11-117.17] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:117.12-117.16] s ; f  :  state
[notation ../spec/4-runtime.watsup:117.12-117.16] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:117.12-117.13] s  :  store
[elab ../spec/4-runtime.watsup:117.12-117.13] s  :  store
[notation ../spec/4-runtime.watsup:117.15-117.16] f  :  frame
[elab ../spec/4-runtime.watsup:117.15-117.16] f  :  frame
[elab ../spec/4-runtime.watsup:117.19-117.20] x  :  tableidx
[elab ../spec/4-runtime.watsup:117.24-117.48] s.ELEM[f.MODULE.ELEM[x]]  :  eleminst
[elab ../spec/4-runtime.watsup:117.24-117.30] s.ELEM  :  eleminst*
[elab ../spec/4-runtime.watsup:117.24-117.25] s  :  store
[elab ../spec/4-runtime.watsup:117.31-117.47] f.MODULE.ELEM[x]  :  nat
[elab ../spec/4-runtime.watsup:117.31-117.44] f.MODULE.ELEM  :  elemaddr*
[elab ../spec/4-runtime.watsup:117.31-117.39] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:117.31-117.32] f  :  frame
[elab ../spec/4-runtime.watsup:117.45-117.46] x  :  nat
[elab ../spec/4-runtime.watsup:119.16-119.38] (state, localidx, val)  :  (state, localidx, val)
[elab ../spec/4-runtime.watsup:119.17-119.22] state  :  state
[elab ../spec/4-runtime.watsup:119.24-119.32] localidx  :  localidx
[elab ../spec/4-runtime.watsup:119.34-119.37] val  :  val
[elab ../spec/4-runtime.watsup:120.16-120.30] ((s ; f), x, v)  :  (state, localidx, val)
[elab ../spec/4-runtime.watsup:120.17-120.23] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:120.18-120.22] s ; f  :  state
[notation ../spec/4-runtime.watsup:120.18-120.22] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:120.18-120.19] s  :  store
[elab ../spec/4-runtime.watsup:120.18-120.19] s  :  store
[notation ../spec/4-runtime.watsup:120.21-120.22] f  :  frame
[elab ../spec/4-runtime.watsup:120.21-120.22] f  :  frame
[elab ../spec/4-runtime.watsup:120.25-120.26] x  :  localidx
[elab ../spec/4-runtime.watsup:120.28-120.29] v  :  val
[elab ../spec/4-runtime.watsup:120.33-120.50] s ; f[LOCAL[x] = v]  :  state
[notation ../spec/4-runtime.watsup:120.33-120.50] s ; f[LOCAL[x] = v]  :  store ; frame
[notation ../spec/4-runtime.watsup:120.33-120.34] s  :  store
[elab ../spec/4-runtime.watsup:120.33-120.34] s  :  store
[notation ../spec/4-runtime.watsup:120.36-120.50] f[LOCAL[x] = v]  :  frame
[elab ../spec/4-runtime.watsup:120.36-120.50] f[LOCAL[x] = v]  :  frame
[elab ../spec/4-runtime.watsup:120.36-120.37] f  :  frame
[elab ../spec/4-runtime.watsup:120.45-120.46] x  :  nat
[elab ../spec/4-runtime.watsup:120.48-120.49] v  :  val
[elab ../spec/4-runtime.watsup:122.17-122.40] (state, globalidx, val)  :  (state, globalidx, val)
[elab ../spec/4-runtime.watsup:122.18-122.23] state  :  state
[elab ../spec/4-runtime.watsup:122.25-122.34] globalidx  :  globalidx
[elab ../spec/4-runtime.watsup:122.36-122.39] val  :  val
[elab ../spec/4-runtime.watsup:123.17-123.31] ((s ; f), x, v)  :  (state, globalidx, val)
[elab ../spec/4-runtime.watsup:123.18-123.24] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:123.19-123.23] s ; f  :  state
[notation ../spec/4-runtime.watsup:123.19-123.23] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:123.19-123.20] s  :  store
[elab ../spec/4-runtime.watsup:123.19-123.20] s  :  store
[notation ../spec/4-runtime.watsup:123.22-123.23] f  :  frame
[elab ../spec/4-runtime.watsup:123.22-123.23] f  :  frame
[elab ../spec/4-runtime.watsup:123.26-123.27] x  :  globalidx
[elab ../spec/4-runtime.watsup:123.29-123.30] v  :  val
[elab ../spec/4-runtime.watsup:123.34-123.69] s[GLOBAL[f.MODULE.GLOBAL[x]] = v] ; f  :  state
[notation ../spec/4-runtime.watsup:123.34-123.69] s[GLOBAL[f.MODULE.GLOBAL[x]] = v] ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:123.34-123.66] s[GLOBAL[f.MODULE.GLOBAL[x]] = v]  :  store
[elab ../spec/4-runtime.watsup:123.34-123.66] s[GLOBAL[f.MODULE.GLOBAL[x]] = v]  :  store
[elab ../spec/4-runtime.watsup:123.34-123.35] s  :  store
[elab ../spec/4-runtime.watsup:123.44-123.62] f.MODULE.GLOBAL[x]  :  nat
[elab ../spec/4-runtime.watsup:123.44-123.59] f.MODULE.GLOBAL  :  globaladdr*
[elab ../spec/4-runtime.watsup:123.44-123.52] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:123.44-123.45] f  :  frame
[elab ../spec/4-runtime.watsup:123.60-123.61] x  :  nat
[elab ../spec/4-runtime.watsup:123.64-123.65] v  :  globalinst
[notation ../spec/4-runtime.watsup:123.68-123.69] f  :  frame
[elab ../spec/4-runtime.watsup:123.68-123.69] f  :  frame
[elab ../spec/4-runtime.watsup:125.16-125.41] (state, tableidx, n, ref)  :  (state, tableidx, n, ref)
[elab ../spec/4-runtime.watsup:125.17-125.22] state  :  state
[elab ../spec/4-runtime.watsup:125.24-125.32] tableidx  :  tableidx
[elab ../spec/4-runtime.watsup:125.34-125.35] n  :  n
[elab ../spec/4-runtime.watsup:125.37-125.40] ref  :  ref
[elab ../spec/4-runtime.watsup:126.16-126.33] ((s ; f), x, i, r)  :  (state, tableidx, n, ref)
[elab ../spec/4-runtime.watsup:126.17-126.23] (s ; f)  :  state
[elab ../spec/4-runtime.watsup:126.18-126.22] s ; f  :  state
[notation ../spec/4-runtime.watsup:126.18-126.22] s ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:126.18-126.19] s  :  store
[elab ../spec/4-runtime.watsup:126.18-126.19] s  :  store
[notation ../spec/4-runtime.watsup:126.21-126.22] f  :  frame
[elab ../spec/4-runtime.watsup:126.21-126.22] f  :  frame
[elab ../spec/4-runtime.watsup:126.25-126.26] x  :  tableidx
[elab ../spec/4-runtime.watsup:126.28-126.29] i  :  n
[elab ../spec/4-runtime.watsup:126.31-126.32] r  :  ref
[elab ../spec/4-runtime.watsup:126.36-126.72] s[TABLE[f.MODULE.TABLE[x]][i] = r] ; f  :  state
[notation ../spec/4-runtime.watsup:126.36-126.72] s[TABLE[f.MODULE.TABLE[x]][i] = r] ; f  :  store ; frame
[notation ../spec/4-runtime.watsup:126.36-126.69] s[TABLE[f.MODULE.TABLE[x]][i] = r]  :  store
[elab ../spec/4-runtime.watsup:126.36-126.69] s[TABLE[f.MODULE.TABLE[x]][i] = r]  :  store
[elab ../spec/4-runtime.watsup:126.36-126.37] s  :  store
[elab ../spec/4-runtime.watsup:126.45-126.62] f.MODULE.TABLE[x]  :  nat
[elab ../spec/4-runtime.watsup:126.45-126.59] f.MODULE.TABLE  :  tableaddr*
[elab ../spec/4-runtime.watsup:126.45-126.53] f.MODULE  :  moduleinst
[elab ../spec/4-runtime.watsup:126.45-126.46] f  :  frame
[elab ../spec/4-runtime.watsup:126.60-126.61] x  :  nat
[elab ../spec/4-runtime.watsup:126.64-126.65] i  :  nat
[elab ../spec/4-runtime.watsup:126.67-126.68] r  :  ref
[notation ../spec/4-runtime.watsup:126.71-126.72] f  :  frame
[elab ../spec/4-runtime.watsup:126.71-126.72] f  :  frame
[notation ../spec/5-reduction.watsup:9.3-9.28] z ; instr* ~> z ; instr'*  :  config ~> config
[notation ../spec/5-reduction.watsup:9.3-9.12] z ; instr*  :  config
[elab ../spec/5-reduction.watsup:9.3-9.12] z ; instr*  :  config
[notation ../spec/5-reduction.watsup:9.3-9.12] z ; instr*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:9.3-9.4] z  :  state
[elab ../spec/5-reduction.watsup:9.3-9.4] z  :  state
[notation ../spec/5-reduction.watsup:9.6-9.12] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:9.6-9.11] instr  :  admininstr
[elab ../spec/5-reduction.watsup:9.6-9.11] instr  :  admininstr
[notation ../spec/5-reduction.watsup:9.18-9.28] z ; instr'*  :  config
[elab ../spec/5-reduction.watsup:9.18-9.28] z ; instr'*  :  config
[notation ../spec/5-reduction.watsup:9.18-9.28] z ; instr'*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:9.18-9.19] z  :  state
[elab ../spec/5-reduction.watsup:9.18-9.19] z  :  state
[notation ../spec/5-reduction.watsup:9.21-9.28] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:9.21-9.27] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:9.21-9.27] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:10.17-10.34] instr* ~> instr'*  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:10.17-10.23] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:10.17-10.22] instr  :  admininstr
[elab ../spec/5-reduction.watsup:10.17-10.22] instr  :  admininstr
[notation ../spec/5-reduction.watsup:10.27-10.34] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:10.27-10.33] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:10.27-10.33] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:13.3-13.28] z ; instr* ~> z ; instr'*  :  config ~> config
[notation ../spec/5-reduction.watsup:13.3-13.12] z ; instr*  :  config
[elab ../spec/5-reduction.watsup:13.3-13.12] z ; instr*  :  config
[notation ../spec/5-reduction.watsup:13.3-13.12] z ; instr*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:13.3-13.4] z  :  state
[elab ../spec/5-reduction.watsup:13.3-13.4] z  :  state
[notation ../spec/5-reduction.watsup:13.6-13.12] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:13.6-13.11] instr  :  admininstr
[elab ../spec/5-reduction.watsup:13.6-13.11] instr  :  admininstr
[notation ../spec/5-reduction.watsup:13.18-13.28] z ; instr'*  :  config
[elab ../spec/5-reduction.watsup:13.18-13.28] z ; instr'*  :  config
[notation ../spec/5-reduction.watsup:13.18-13.28] z ; instr'*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:13.18-13.19] z  :  state
[elab ../spec/5-reduction.watsup:13.18-13.19] z  :  state
[notation ../spec/5-reduction.watsup:13.21-13.28] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:13.21-13.27] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:13.21-13.27] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:14.17-14.37] z ; instr* ~> instr'*  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:14.17-14.26] z ; instr*  :  config
[elab ../spec/5-reduction.watsup:14.17-14.26] z ; instr*  :  config
[notation ../spec/5-reduction.watsup:14.17-14.26] z ; instr*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:14.17-14.18] z  :  state
[elab ../spec/5-reduction.watsup:14.17-14.18] z  :  state
[notation ../spec/5-reduction.watsup:14.20-14.26] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:14.20-14.25] instr  :  admininstr
[elab ../spec/5-reduction.watsup:14.20-14.25] instr  :  admininstr
[notation ../spec/5-reduction.watsup:14.30-14.37] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:14.30-14.36] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:14.30-14.36] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:17.3-17.29] z ; instr* ~> z' ; instr'*  :  config ~> config
[notation ../spec/5-reduction.watsup:17.3-17.12] z ; instr*  :  config
[elab ../spec/5-reduction.watsup:17.3-17.12] z ; instr*  :  config
[notation ../spec/5-reduction.watsup:17.3-17.12] z ; instr*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:17.3-17.4] z  :  state
[elab ../spec/5-reduction.watsup:17.3-17.4] z  :  state
[notation ../spec/5-reduction.watsup:17.6-17.12] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:17.6-17.11] instr  :  admininstr
[elab ../spec/5-reduction.watsup:17.6-17.11] instr  :  admininstr
[notation ../spec/5-reduction.watsup:17.18-17.29] z' ; instr'*  :  config
[elab ../spec/5-reduction.watsup:17.18-17.29] z' ; instr'*  :  config
[notation ../spec/5-reduction.watsup:17.18-17.29] z' ; instr'*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:17.18-17.20] z'  :  state
[elab ../spec/5-reduction.watsup:17.18-17.20] z'  :  state
[notation ../spec/5-reduction.watsup:17.22-17.29] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:17.22-17.28] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:17.22-17.28] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:18.18-18.42] z ; instr* ~> z' ; instr'*  :  config ~> config
[notation ../spec/5-reduction.watsup:18.18-18.27] z ; instr*  :  config
[elab ../spec/5-reduction.watsup:18.18-18.27] z ; instr*  :  config
[notation ../spec/5-reduction.watsup:18.18-18.27] z ; instr*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:18.18-18.19] z  :  state
[elab ../spec/5-reduction.watsup:18.18-18.19] z  :  state
[notation ../spec/5-reduction.watsup:18.21-18.27] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:18.21-18.26] instr  :  admininstr
[elab ../spec/5-reduction.watsup:18.21-18.26] instr  :  admininstr
[notation ../spec/5-reduction.watsup:18.31-18.42] z' ; instr'*  :  config
[elab ../spec/5-reduction.watsup:18.31-18.42] z' ; instr'*  :  config
[notation ../spec/5-reduction.watsup:18.31-18.42] z' ; instr'*  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:18.31-18.33] z'  :  state
[elab ../spec/5-reduction.watsup:18.31-18.33] z'  :  state
[notation ../spec/5-reduction.watsup:18.35-18.42] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:18.35-18.41] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:18.35-18.41] instr'  :  admininstr
[notation ../spec/5-reduction.watsup:22.3-22.35] {val REF.IS_NULL} ~> ({CONST I32 1})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:22.3-22.18] {val REF.IS_NULL}  :  admininstr*
[niteration ../spec/5-reduction.watsup:22.3-22.18] val REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:22.3-22.6] val  :  admininstr*
[notation ../spec/5-reduction.watsup:22.3-22.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:22.3-22.6] val  :  admininstr
[niteration ../spec/5-reduction.watsup:22.3-22.18] REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr
[elab ../spec/5-reduction.watsup:22.7-22.18] REF.IS_NULL  :  admininstr
[notation ../spec/5-reduction.watsup:22.7-22.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:22.3-22.18]   :  admininstr*
[notation ../spec/5-reduction.watsup:22.22-22.35] ({CONST I32 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:22.23-22.34] {CONST I32 1}  :  admininstr
[elab ../spec/5-reduction.watsup:22.23-22.34] {CONST I32 1}  :  admininstr
[notation ../spec/5-reduction.watsup:22.23-22.34] {I32 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:22.29-22.32] I32  :  numtype
[elab ../spec/5-reduction.watsup:22.29-22.32] I32  :  numtype
[notation ../spec/5-reduction.watsup:22.29-22.32] {}  :  {}
[notation ../spec/5-reduction.watsup:22.23-22.34] {1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:22.33-22.34] 1  :  c_numtype
[elab ../spec/5-reduction.watsup:22.33-22.34] 1  :  c_numtype
[notation ../spec/5-reduction.watsup:22.23-22.34] {}  :  {}
[elab ../spec/5-reduction.watsup:23.9-23.26] val = {REF.NULL rt}  :  bool
[elab ../spec/5-reduction.watsup:23.9-23.12] val  :  val
[elab ../spec/5-reduction.watsup:23.15-23.26] {REF.NULL rt}  :  val
[notation ../spec/5-reduction.watsup:23.15-23.26] {rt}  :  {reftype}
[notation ../spec/5-reduction.watsup:23.24-23.26] rt  :  reftype
[elab ../spec/5-reduction.watsup:23.24-23.26] rt  :  reftype
[notation ../spec/5-reduction.watsup:23.15-23.26] {}  :  {}
[notation ../spec/5-reduction.watsup:26.3-26.35] {val REF.IS_NULL} ~> ({CONST I32 0})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:26.3-26.18] {val REF.IS_NULL}  :  admininstr*
[niteration ../spec/5-reduction.watsup:26.3-26.18] val REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:26.3-26.6] val  :  admininstr*
[notation ../spec/5-reduction.watsup:26.3-26.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:26.3-26.6] val  :  admininstr
[niteration ../spec/5-reduction.watsup:26.3-26.18] REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr*
[notation ../spec/5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr
[elab ../spec/5-reduction.watsup:26.7-26.18] REF.IS_NULL  :  admininstr
[notation ../spec/5-reduction.watsup:26.7-26.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:26.3-26.18]   :  admininstr*
[notation ../spec/5-reduction.watsup:26.22-26.35] ({CONST I32 0})  :  admininstr*
[notation ../spec/5-reduction.watsup:26.23-26.34] {CONST I32 0}  :  admininstr
[elab ../spec/5-reduction.watsup:26.23-26.34] {CONST I32 0}  :  admininstr
[notation ../spec/5-reduction.watsup:26.23-26.34] {I32 0}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:26.29-26.32] I32  :  numtype
[elab ../spec/5-reduction.watsup:26.29-26.32] I32  :  numtype
[notation ../spec/5-reduction.watsup:26.29-26.32] {}  :  {}
[notation ../spec/5-reduction.watsup:26.23-26.34] {0}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:26.33-26.34] 0  :  c_numtype
[elab ../spec/5-reduction.watsup:26.33-26.34] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:26.23-26.34] {}  :  {}
[notation ../spec/5-reduction.watsup:30.3-30.24] UNREACHABLE ~> TRAP  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr*
[notation ../spec/5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr
[elab ../spec/5-reduction.watsup:30.3-30.14] UNREACHABLE  :  admininstr
[notation ../spec/5-reduction.watsup:30.3-30.14] {}  :  {}
[notation ../spec/5-reduction.watsup:30.20-30.24] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:30.20-30.24] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:30.20-30.24] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:30.20-30.24] {}  :  {}
[notation ../spec/5-reduction.watsup:33.3-33.19] NOP ~> epsilon  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:33.3-33.6] NOP  :  admininstr*
[notation ../spec/5-reduction.watsup:33.3-33.6] NOP  :  admininstr
[elab ../spec/5-reduction.watsup:33.3-33.6] NOP  :  admininstr
[notation ../spec/5-reduction.watsup:33.3-33.6] {}  :  {}
[notation ../spec/5-reduction.watsup:33.12-33.19] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:33.12-33.19]   :  admininstr*
[notation ../spec/5-reduction.watsup:36.3-36.24] {val DROP} ~> epsilon  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:36.3-36.11] {val DROP}  :  admininstr*
[niteration ../spec/5-reduction.watsup:36.3-36.11] val DROP  :  admininstr*
[notation ../spec/5-reduction.watsup:36.3-36.6] val  :  admininstr*
[notation ../spec/5-reduction.watsup:36.3-36.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:36.3-36.6] val  :  admininstr
[niteration ../spec/5-reduction.watsup:36.3-36.11] DROP  :  admininstr*
[notation ../spec/5-reduction.watsup:36.7-36.11] DROP  :  admininstr*
[notation ../spec/5-reduction.watsup:36.7-36.11] DROP  :  admininstr
[elab ../spec/5-reduction.watsup:36.7-36.11] DROP  :  admininstr
[notation ../spec/5-reduction.watsup:36.7-36.11] {}  :  {}
[niteration ../spec/5-reduction.watsup:36.3-36.11]   :  admininstr*
[notation ../spec/5-reduction.watsup:36.17-36.24] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:36.17-36.24]   :  admininstr*
[notation ../spec/5-reduction.watsup:39.3-39.51] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_1  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:39.3-39.40] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:39.3-39.40] val_1 val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.3-39.8] val_1  :  admininstr*
[notation ../spec/5-reduction.watsup:39.3-39.8] val_1  :  admininstr
[elab ../spec/5-reduction.watsup:39.3-39.8] val_1  :  admininstr
[niteration ../spec/5-reduction.watsup:39.3-39.40] val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.9-39.14] val_2  :  admininstr*
[notation ../spec/5-reduction.watsup:39.9-39.14] val_2  :  admininstr
[elab ../spec/5-reduction.watsup:39.9-39.14] val_2  :  admininstr
[niteration ../spec/5-reduction.watsup:39.3-39.40] ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.15-39.28] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.15-39.28] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:39.16-39.27] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:39.16-39.27] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:39.16-39.27] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:39.22-39.25] I32  :  numtype
[elab ../spec/5-reduction.watsup:39.22-39.25] I32  :  numtype
[notation ../spec/5-reduction.watsup:39.22-39.25] {}  :  {}
[notation ../spec/5-reduction.watsup:39.16-39.27] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:39.26-39.27] c  :  c_numtype
[elab ../spec/5-reduction.watsup:39.26-39.27] c  :  c_numtype
[notation ../spec/5-reduction.watsup:39.16-39.27] {}  :  {}
[niteration ../spec/5-reduction.watsup:39.3-39.40] ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.29-39.40] ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:39.29-39.40] ({SELECT t?})  :  admininstr
[notation ../spec/5-reduction.watsup:39.30-39.39] {SELECT t?}  :  admininstr
[elab ../spec/5-reduction.watsup:39.30-39.39] {SELECT t?}  :  admininstr
[notation ../spec/5-reduction.watsup:39.30-39.39] {t?}  :  {valtype?}
[notation ../spec/5-reduction.watsup:39.30-39.39] {t?}  :  valtype?
[elab ../spec/5-reduction.watsup:39.37-39.39] t?  :  valtype?
[elab ../spec/5-reduction.watsup:39.37-39.38] t  :  valtype
[niteration ../spec/5-reduction.watsup:39.3-39.40]   :  admininstr*
[notation ../spec/5-reduction.watsup:39.46-39.51] val_1  :  admininstr*
[notation ../spec/5-reduction.watsup:39.46-39.51] val_1  :  admininstr
[elab ../spec/5-reduction.watsup:39.46-39.51] val_1  :  admininstr
[elab ../spec/5-reduction.watsup:40.9-40.16] c =/= 0  :  bool
[elab ../spec/5-reduction.watsup:40.9-40.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:40.15-40.16] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:43.3-43.51] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})} ~> val_2  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:43.3-43.40] {val_1 val_2 ({CONST I32 c}) ({SELECT t?})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:43.3-43.40] val_1 val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.3-43.8] val_1  :  admininstr*
[notation ../spec/5-reduction.watsup:43.3-43.8] val_1  :  admininstr
[elab ../spec/5-reduction.watsup:43.3-43.8] val_1  :  admininstr
[niteration ../spec/5-reduction.watsup:43.3-43.40] val_2 ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.9-43.14] val_2  :  admininstr*
[notation ../spec/5-reduction.watsup:43.9-43.14] val_2  :  admininstr
[elab ../spec/5-reduction.watsup:43.9-43.14] val_2  :  admininstr
[niteration ../spec/5-reduction.watsup:43.3-43.40] ({CONST I32 c}) ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.15-43.28] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.15-43.28] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:43.16-43.27] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:43.16-43.27] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:43.16-43.27] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:43.22-43.25] I32  :  numtype
[elab ../spec/5-reduction.watsup:43.22-43.25] I32  :  numtype
[notation ../spec/5-reduction.watsup:43.22-43.25] {}  :  {}
[notation ../spec/5-reduction.watsup:43.16-43.27] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:43.26-43.27] c  :  c_numtype
[elab ../spec/5-reduction.watsup:43.26-43.27] c  :  c_numtype
[notation ../spec/5-reduction.watsup:43.16-43.27] {}  :  {}
[niteration ../spec/5-reduction.watsup:43.3-43.40] ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.29-43.40] ({SELECT t?})  :  admininstr*
[notation ../spec/5-reduction.watsup:43.29-43.40] ({SELECT t?})  :  admininstr
[notation ../spec/5-reduction.watsup:43.30-43.39] {SELECT t?}  :  admininstr
[elab ../spec/5-reduction.watsup:43.30-43.39] {SELECT t?}  :  admininstr
[notation ../spec/5-reduction.watsup:43.30-43.39] {t?}  :  {valtype?}
[notation ../spec/5-reduction.watsup:43.30-43.39] {t?}  :  valtype?
[elab ../spec/5-reduction.watsup:43.37-43.39] t?  :  valtype?
[elab ../spec/5-reduction.watsup:43.37-43.38] t  :  valtype
[niteration ../spec/5-reduction.watsup:43.3-43.40]   :  admininstr*
[notation ../spec/5-reduction.watsup:43.46-43.51] val_2  :  admininstr*
[notation ../spec/5-reduction.watsup:43.46-43.51] val_2  :  admininstr
[elab ../spec/5-reduction.watsup:43.46-43.51] val_2  :  admininstr
[elab ../spec/5-reduction.watsup:44.9-44.14] c = 0  :  bool
[elab ../spec/5-reduction.watsup:44.9-44.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:44.13-44.14] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:47.3-47.47] {val ({LOCAL.TEE x})} ~> {val val ({LOCAL.SET x})}  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:47.3-47.20] {val ({LOCAL.TEE x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:47.3-47.20] val ({LOCAL.TEE x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.3-47.6] val  :  admininstr*
[notation ../spec/5-reduction.watsup:47.3-47.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:47.3-47.6] val  :  admininstr
[niteration ../spec/5-reduction.watsup:47.3-47.20] ({LOCAL.TEE x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.7-47.20] ({LOCAL.TEE x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.7-47.20] ({LOCAL.TEE x})  :  admininstr
[notation ../spec/5-reduction.watsup:47.8-47.19] {LOCAL.TEE x}  :  admininstr
[elab ../spec/5-reduction.watsup:47.8-47.19] {LOCAL.TEE x}  :  admininstr
[notation ../spec/5-reduction.watsup:47.8-47.19] {x}  :  {localidx}
[notation ../spec/5-reduction.watsup:47.18-47.19] x  :  localidx
[elab ../spec/5-reduction.watsup:47.18-47.19] x  :  localidx
[notation ../spec/5-reduction.watsup:47.8-47.19] {}  :  {}
[niteration ../spec/5-reduction.watsup:47.3-47.20]   :  admininstr*
[notation ../spec/5-reduction.watsup:47.26-47.47] {val val ({LOCAL.SET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:47.26-47.47] val val ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.26-47.29] val  :  admininstr*
[notation ../spec/5-reduction.watsup:47.26-47.29] val  :  admininstr
[elab ../spec/5-reduction.watsup:47.26-47.29] val  :  admininstr
[niteration ../spec/5-reduction.watsup:47.26-47.47] val ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.30-47.33] val  :  admininstr*
[notation ../spec/5-reduction.watsup:47.30-47.33] val  :  admininstr
[elab ../spec/5-reduction.watsup:47.30-47.33] val  :  admininstr
[niteration ../spec/5-reduction.watsup:47.26-47.47] ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.34-47.47] ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:47.34-47.47] ({LOCAL.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:47.35-47.46] {LOCAL.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:47.35-47.46] {LOCAL.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:47.35-47.46] {x}  :  {localidx}
[notation ../spec/5-reduction.watsup:47.45-47.46] x  :  localidx
[elab ../spec/5-reduction.watsup:47.45-47.46] x  :  localidx
[notation ../spec/5-reduction.watsup:47.35-47.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:47.26-47.47]   :  admininstr*
[notation ../spec/5-reduction.watsup:50.3-50.66] {val^k ({BLOCK bt instr*})} ~> ({LABEL_ n `{epsilon} val^k instr*})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:50.3-50.26] {val^k ({BLOCK bt instr*})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:50.3-50.26] val^k ({BLOCK bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:50.3-50.8] val^k  :  admininstr*
[notation ../spec/5-reduction.watsup:50.3-50.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:50.3-50.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:50.7-50.8] k  :  nat
[niteration ../spec/5-reduction.watsup:50.3-50.26] ({BLOCK bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:50.9-50.26] ({BLOCK bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:50.9-50.26] ({BLOCK bt instr*})  :  admininstr
[notation ../spec/5-reduction.watsup:50.10-50.25] {BLOCK bt instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:50.10-50.25] {BLOCK bt instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:50.10-50.25] {bt instr*}  :  {blocktype instr*}
[notation ../spec/5-reduction.watsup:50.16-50.18] bt  :  blocktype
[elab ../spec/5-reduction.watsup:50.16-50.18] bt  :  blocktype
[notation ../spec/5-reduction.watsup:50.10-50.25] {instr*}  :  {instr*}
[notation ../spec/5-reduction.watsup:50.10-50.25] {instr*}  :  instr*
[elab ../spec/5-reduction.watsup:50.19-50.25] instr*  :  instr*
[elab ../spec/5-reduction.watsup:50.19-50.24] instr  :  instr
[niteration ../spec/5-reduction.watsup:50.3-50.26]   :  admininstr*
[notation ../spec/5-reduction.watsup:50.32-50.66] ({LABEL_ n `{epsilon} val^k instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:50.33-50.65] {LABEL_ n `{epsilon} val^k instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:50.33-50.65] {LABEL_ n `{epsilon} val^k instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:50.33-50.65] {n `{epsilon} val^k instr*}  :  {n `{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:50.40-50.41] n  :  n
[elab ../spec/5-reduction.watsup:50.40-50.41] n  :  n
[notation ../spec/5-reduction.watsup:50.33-50.65] {`{epsilon} val^k instr*}  :  {`{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:50.42-50.52] `{epsilon}  :  `{instr*}
[notation ../spec/5-reduction.watsup:50.44-50.51] epsilon  :  instr*
[niteration ../spec/5-reduction.watsup:50.44-50.51]   :  instr*
[notation ../spec/5-reduction.watsup:50.33-50.65] {val^k instr*}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:50.33-50.65] {val^k instr*}  :  admininstr*
[niteration ../spec/5-reduction.watsup:50.33-50.65] val^k instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:50.53-50.58] val^k  :  admininstr*
[notation ../spec/5-reduction.watsup:50.53-50.56] val  :  admininstr
[elab ../spec/5-reduction.watsup:50.53-50.56] val  :  admininstr
[elab ../spec/5-reduction.watsup:50.57-50.58] k  :  nat
[niteration ../spec/5-reduction.watsup:50.33-50.65] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:50.59-50.65] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:50.59-50.64] instr  :  admininstr
[elab ../spec/5-reduction.watsup:50.59-50.64] instr  :  admininstr
[niteration ../spec/5-reduction.watsup:50.33-50.65]   :  admininstr*
[elab ../spec/5-reduction.watsup:51.9-51.28] bt = t_1^k -> t_2^n  :  bool
[elab ../spec/5-reduction.watsup:51.9-51.11] bt  :  blocktype
[elab ../spec/5-reduction.watsup:51.14-51.28] t_1^k -> t_2^n  :  blocktype
[notation ../spec/5-reduction.watsup:51.14-51.28] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation ../spec/5-reduction.watsup:51.14-51.19] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:51.14-51.19] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:51.14-51.17] t_1  :  valtype
[elab ../spec/5-reduction.watsup:51.18-51.19] k  :  nat
[notation ../spec/5-reduction.watsup:51.23-51.28] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:51.23-51.28] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:51.23-51.26] t_2  :  valtype
[elab ../spec/5-reduction.watsup:51.27-51.28] n  :  nat
[elab ../spec/5-reduction.watsup:51.18-51.19] k  :  nat
[elab ../spec/5-reduction.watsup:51.27-51.28] n  :  nat
[elab ../spec/5-reduction.watsup:50.57-50.58] k  :  nat
[notation ../spec/5-reduction.watsup:54.3-54.72] {val^k ({LOOP bt instr*})} ~> ({LABEL_ n `{{LOOP bt instr*}} val^k instr*})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:54.3-54.25] {val^k ({LOOP bt instr*})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:54.3-54.25] val^k ({LOOP bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:54.3-54.8] val^k  :  admininstr*
[notation ../spec/5-reduction.watsup:54.3-54.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:54.3-54.6] val  :  admininstr
[elab ../spec/5-reduction.watsup:54.7-54.8] k  :  nat
[niteration ../spec/5-reduction.watsup:54.3-54.25] ({LOOP bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:54.9-54.25] ({LOOP bt instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:54.9-54.25] ({LOOP bt instr*})  :  admininstr
[notation ../spec/5-reduction.watsup:54.10-54.24] {LOOP bt instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:54.10-54.24] {LOOP bt instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:54.10-54.24] {bt instr*}  :  {blocktype instr*}
[notation ../spec/5-reduction.watsup:54.15-54.17] bt  :  blocktype
[elab ../spec/5-reduction.watsup:54.15-54.17] bt  :  blocktype
[notation ../spec/5-reduction.watsup:54.10-54.24] {instr*}  :  {instr*}
[notation ../spec/5-reduction.watsup:54.10-54.24] {instr*}  :  instr*
[elab ../spec/5-reduction.watsup:54.18-54.24] instr*  :  instr*
[elab ../spec/5-reduction.watsup:54.18-54.23] instr  :  instr
[niteration ../spec/5-reduction.watsup:54.3-54.25]   :  admininstr*
[notation ../spec/5-reduction.watsup:54.31-54.72] ({LABEL_ n `{{LOOP bt instr*}} val^k instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:54.32-54.71] {LABEL_ n `{{LOOP bt instr*}} val^k instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:54.32-54.71] {LABEL_ n `{{LOOP bt instr*}} val^k instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:54.32-54.71] {n `{{LOOP bt instr*}} val^k instr*}  :  {n `{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:54.39-54.40] n  :  n
[elab ../spec/5-reduction.watsup:54.39-54.40] n  :  n
[notation ../spec/5-reduction.watsup:54.32-54.71] {`{{LOOP bt instr*}} val^k instr*}  :  {`{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:54.41-54.58] `{{LOOP bt instr*}}  :  `{instr*}
[notation ../spec/5-reduction.watsup:54.43-54.57] {LOOP bt instr*}  :  instr*
[niteration ../spec/5-reduction.watsup:54.43-54.57] LOOP bt instr*  :  instr*
[notation ../spec/5-reduction.watsup:54.43-54.57] {bt instr*}  :  {blocktype instr*}
[notation ../spec/5-reduction.watsup:54.48-54.50] bt  :  blocktype
[elab ../spec/5-reduction.watsup:54.48-54.50] bt  :  blocktype
[notation ../spec/5-reduction.watsup:54.43-54.57] {instr*}  :  {instr*}
[notation ../spec/5-reduction.watsup:54.43-54.57] {instr*}  :  instr*
[elab ../spec/5-reduction.watsup:54.51-54.57] instr*  :  instr*
[elab ../spec/5-reduction.watsup:54.51-54.56] instr  :  instr
[notation ../spec/5-reduction.watsup:54.32-54.71] {val^k instr*}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:54.32-54.71] {val^k instr*}  :  admininstr*
[niteration ../spec/5-reduction.watsup:54.32-54.71] val^k instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:54.59-54.64] val^k  :  admininstr*
[notation ../spec/5-reduction.watsup:54.59-54.62] val  :  admininstr
[elab ../spec/5-reduction.watsup:54.59-54.62] val  :  admininstr
[elab ../spec/5-reduction.watsup:54.63-54.64] k  :  nat
[niteration ../spec/5-reduction.watsup:54.32-54.71] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:54.65-54.71] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:54.65-54.70] instr  :  admininstr
[elab ../spec/5-reduction.watsup:54.65-54.70] instr  :  admininstr
[niteration ../spec/5-reduction.watsup:54.32-54.71]   :  admininstr*
[elab ../spec/5-reduction.watsup:55.9-55.28] bt = t_1^k -> t_2^n  :  bool
[elab ../spec/5-reduction.watsup:55.9-55.11] bt  :  blocktype
[elab ../spec/5-reduction.watsup:55.14-55.28] t_1^k -> t_2^n  :  blocktype
[notation ../spec/5-reduction.watsup:55.14-55.28] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation ../spec/5-reduction.watsup:55.14-55.19] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:55.14-55.19] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:55.14-55.17] t_1  :  valtype
[elab ../spec/5-reduction.watsup:55.18-55.19] k  :  nat
[notation ../spec/5-reduction.watsup:55.23-55.28] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:55.23-55.28] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:55.23-55.26] t_2  :  valtype
[elab ../spec/5-reduction.watsup:55.27-55.28] n  :  nat
[elab ../spec/5-reduction.watsup:55.18-55.19] k  :  nat
[elab ../spec/5-reduction.watsup:55.27-55.28] n  :  nat
[elab ../spec/5-reduction.watsup:54.63-54.64] k  :  nat
[notation ../spec/5-reduction.watsup:58.3-58.72] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_1*})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:58.3-58.47] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:58.3-58.47] ({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:58.3-58.16] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:58.3-58.16] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:58.4-58.15] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:58.4-58.15] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:58.4-58.15] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:58.10-58.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:58.10-58.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:58.10-58.13] {}  :  {}
[notation ../spec/5-reduction.watsup:58.4-58.15] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:58.14-58.15] c  :  c_numtype
[elab ../spec/5-reduction.watsup:58.14-58.15] c  :  c_numtype
[notation ../spec/5-reduction.watsup:58.4-58.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:58.3-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:58.17-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:58.17-58.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr
[notation ../spec/5-reduction.watsup:58.18-58.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[elab ../spec/5-reduction.watsup:58.18-58.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[notation ../spec/5-reduction.watsup:58.18-58.46] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation ../spec/5-reduction.watsup:58.21-58.23] bt  :  blocktype
[elab ../spec/5-reduction.watsup:58.21-58.23] bt  :  blocktype
[notation ../spec/5-reduction.watsup:58.18-58.46] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation ../spec/5-reduction.watsup:58.24-58.32] instr_1*  :  instr*
[notation ../spec/5-reduction.watsup:58.24-58.31] instr_1  :  instr
[elab ../spec/5-reduction.watsup:58.24-58.31] instr_1  :  instr
[notation ../spec/5-reduction.watsup:58.18-58.46] {ELSE instr_2*}  :  {ELSE instr*}
[notation ../spec/5-reduction.watsup:58.33-58.37] ELSE  :  ELSE
[notation ../spec/5-reduction.watsup:58.18-58.46] {instr_2*}  :  {instr*}
[notation ../spec/5-reduction.watsup:58.18-58.46] {instr_2*}  :  instr*
[elab ../spec/5-reduction.watsup:58.38-58.46] instr_2*  :  instr*
[elab ../spec/5-reduction.watsup:58.38-58.45] instr_2  :  instr
[niteration ../spec/5-reduction.watsup:58.3-58.47]   :  admininstr*
[notation ../spec/5-reduction.watsup:58.53-58.72] ({BLOCK bt instr_1*})  :  admininstr*
[notation ../spec/5-reduction.watsup:58.54-58.71] {BLOCK bt instr_1*}  :  admininstr
[elab ../spec/5-reduction.watsup:58.54-58.71] {BLOCK bt instr_1*}  :  admininstr
[notation ../spec/5-reduction.watsup:58.54-58.71] {bt instr_1*}  :  {blocktype instr*}
[notation ../spec/5-reduction.watsup:58.60-58.62] bt  :  blocktype
[elab ../spec/5-reduction.watsup:58.60-58.62] bt  :  blocktype
[notation ../spec/5-reduction.watsup:58.54-58.71] {instr_1*}  :  {instr*}
[notation ../spec/5-reduction.watsup:58.54-58.71] {instr_1*}  :  instr*
[elab ../spec/5-reduction.watsup:58.63-58.71] instr_1*  :  instr*
[elab ../spec/5-reduction.watsup:58.63-58.70] instr_1  :  instr
[elab ../spec/5-reduction.watsup:59.9-59.16] c =/= 0  :  bool
[elab ../spec/5-reduction.watsup:59.9-59.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:59.15-59.16] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:62.3-62.72] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})} ~> ({BLOCK bt instr_2*})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:62.3-62.47] {({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:62.3-62.47] ({CONST I32 c}) ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:62.3-62.16] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:62.3-62.16] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:62.4-62.15] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:62.4-62.15] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:62.4-62.15] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:62.10-62.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:62.10-62.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:62.10-62.13] {}  :  {}
[notation ../spec/5-reduction.watsup:62.4-62.15] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:62.14-62.15] c  :  c_numtype
[elab ../spec/5-reduction.watsup:62.14-62.15] c  :  c_numtype
[notation ../spec/5-reduction.watsup:62.4-62.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:62.3-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:62.17-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:62.17-62.47] ({IF bt instr_1* ELSE instr_2*})  :  admininstr
[notation ../spec/5-reduction.watsup:62.18-62.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[elab ../spec/5-reduction.watsup:62.18-62.46] {IF bt instr_1* ELSE instr_2*}  :  admininstr
[notation ../spec/5-reduction.watsup:62.18-62.46] {bt instr_1* ELSE instr_2*}  :  {blocktype instr* ELSE instr*}
[notation ../spec/5-reduction.watsup:62.21-62.23] bt  :  blocktype
[elab ../spec/5-reduction.watsup:62.21-62.23] bt  :  blocktype
[notation ../spec/5-reduction.watsup:62.18-62.46] {instr_1* ELSE instr_2*}  :  {instr* ELSE instr*}
[notation ../spec/5-reduction.watsup:62.24-62.32] instr_1*  :  instr*
[notation ../spec/5-reduction.watsup:62.24-62.31] instr_1  :  instr
[elab ../spec/5-reduction.watsup:62.24-62.31] instr_1  :  instr
[notation ../spec/5-reduction.watsup:62.18-62.46] {ELSE instr_2*}  :  {ELSE instr*}
[notation ../spec/5-reduction.watsup:62.33-62.37] ELSE  :  ELSE
[notation ../spec/5-reduction.watsup:62.18-62.46] {instr_2*}  :  {instr*}
[notation ../spec/5-reduction.watsup:62.18-62.46] {instr_2*}  :  instr*
[elab ../spec/5-reduction.watsup:62.38-62.46] instr_2*  :  instr*
[elab ../spec/5-reduction.watsup:62.38-62.45] instr_2  :  instr
[niteration ../spec/5-reduction.watsup:62.3-62.47]   :  admininstr*
[notation ../spec/5-reduction.watsup:62.53-62.72] ({BLOCK bt instr_2*})  :  admininstr*
[notation ../spec/5-reduction.watsup:62.54-62.71] {BLOCK bt instr_2*}  :  admininstr
[elab ../spec/5-reduction.watsup:62.54-62.71] {BLOCK bt instr_2*}  :  admininstr
[notation ../spec/5-reduction.watsup:62.54-62.71] {bt instr_2*}  :  {blocktype instr*}
[notation ../spec/5-reduction.watsup:62.60-62.62] bt  :  blocktype
[elab ../spec/5-reduction.watsup:62.60-62.62] bt  :  blocktype
[notation ../spec/5-reduction.watsup:62.54-62.71] {instr_2*}  :  {instr*}
[notation ../spec/5-reduction.watsup:62.54-62.71] {instr_2*}  :  instr*
[elab ../spec/5-reduction.watsup:62.63-62.71] instr_2*  :  instr*
[elab ../spec/5-reduction.watsup:62.63-62.70] instr_2  :  instr
[elab ../spec/5-reduction.watsup:63.9-63.14] c = 0  :  bool
[elab ../spec/5-reduction.watsup:63.9-63.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:63.13-63.14] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:67.3-67.69] ({LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}) ~> {val^n instr'*}  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:67.3-67.50] ({LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:67.4-67.49] {LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:67.4-67.49] {LABEL_ n `{instr'*} val'* val^n ({BR 0}) instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:67.4-67.49] {n `{instr'*} val'* val^n ({BR 0}) instr*}  :  {n `{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:67.11-67.12] n  :  n
[elab ../spec/5-reduction.watsup:67.11-67.12] n  :  n
[notation ../spec/5-reduction.watsup:67.4-67.49] {`{instr'*} val'* val^n ({BR 0}) instr*}  :  {`{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:67.13-67.23] `{instr'*}  :  `{instr*}
[notation ../spec/5-reduction.watsup:67.15-67.22] instr'*  :  instr*
[notation ../spec/5-reduction.watsup:67.15-67.21] instr'  :  instr
[elab ../spec/5-reduction.watsup:67.15-67.21] instr'  :  instr
[notation ../spec/5-reduction.watsup:67.4-67.49] {val'* val^n ({BR 0}) instr*}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:67.4-67.49] {val'* val^n ({BR 0}) instr*}  :  admininstr*
[niteration ../spec/5-reduction.watsup:67.4-67.49] val'* val^n ({BR 0}) instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.24-67.29] val'*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.24-67.28] val'  :  admininstr
[elab ../spec/5-reduction.watsup:67.24-67.28] val'  :  admininstr
[niteration ../spec/5-reduction.watsup:67.4-67.49] val^n ({BR 0}) instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.30-67.35] val^n  :  admininstr*
[notation ../spec/5-reduction.watsup:67.30-67.33] val  :  admininstr
[elab ../spec/5-reduction.watsup:67.30-67.33] val  :  admininstr
[elab ../spec/5-reduction.watsup:67.34-67.35] n  :  nat
[niteration ../spec/5-reduction.watsup:67.4-67.49] ({BR 0}) instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.36-67.42] ({BR 0})  :  admininstr*
[notation ../spec/5-reduction.watsup:67.36-67.42] ({BR 0})  :  admininstr
[notation ../spec/5-reduction.watsup:67.37-67.41] {BR 0}  :  admininstr
[elab ../spec/5-reduction.watsup:67.37-67.41] {BR 0}  :  admininstr
[notation ../spec/5-reduction.watsup:67.37-67.41] {0}  :  {labelidx}
[notation ../spec/5-reduction.watsup:67.40-67.41] 0  :  labelidx
[elab ../spec/5-reduction.watsup:67.40-67.41] 0  :  labelidx
[notation ../spec/5-reduction.watsup:67.37-67.41] {}  :  {}
[niteration ../spec/5-reduction.watsup:67.4-67.49] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.43-67.49] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.43-67.48] instr  :  admininstr
[elab ../spec/5-reduction.watsup:67.43-67.48] instr  :  admininstr
[niteration ../spec/5-reduction.watsup:67.4-67.49]   :  admininstr*
[notation ../spec/5-reduction.watsup:67.56-67.69] {val^n instr'*}  :  admininstr*
[niteration ../spec/5-reduction.watsup:67.56-67.69] val^n instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.56-67.61] val^n  :  admininstr*
[notation ../spec/5-reduction.watsup:67.56-67.59] val  :  admininstr
[elab ../spec/5-reduction.watsup:67.56-67.59] val  :  admininstr
[elab ../spec/5-reduction.watsup:67.60-67.61] n  :  nat
[niteration ../spec/5-reduction.watsup:67.56-67.69] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.62-67.69] instr'*  :  admininstr*
[notation ../spec/5-reduction.watsup:67.62-67.68] instr'  :  admininstr
[elab ../spec/5-reduction.watsup:67.62-67.68] instr'  :  admininstr
[niteration ../spec/5-reduction.watsup:67.56-67.69]   :  admininstr*
[elab ../spec/5-reduction.watsup:67.60-67.61] n  :  nat
[notation ../spec/5-reduction.watsup:70.3-70.65] ({LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}) ~> {val* ({BR l})}  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:70.3-70.48] ({LABEL_ n `{instr'*} val* ({BR l + 1}) instr*})  :  admininstr*
[notation ../spec/5-reduction.watsup:70.4-70.47] {LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}  :  admininstr
[elab ../spec/5-reduction.watsup:70.4-70.47] {LABEL_ n `{instr'*} val* ({BR l + 1}) instr*}  :  admininstr
[notation ../spec/5-reduction.watsup:70.4-70.47] {n `{instr'*} val* ({BR l + 1}) instr*}  :  {n `{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:70.11-70.12] n  :  n
[elab ../spec/5-reduction.watsup:70.11-70.12] n  :  n
[notation ../spec/5-reduction.watsup:70.4-70.47] {`{instr'*} val* ({BR l + 1}) instr*}  :  {`{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:70.13-70.23] `{instr'*}  :  `{instr*}
[notation ../spec/5-reduction.watsup:70.15-70.22] instr'*  :  instr*
[notation ../spec/5-reduction.watsup:70.15-70.21] instr'  :  instr
[elab ../spec/5-reduction.watsup:70.15-70.21] instr'  :  instr
[notation ../spec/5-reduction.watsup:70.4-70.47] {val* ({BR l + 1}) instr*}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:70.4-70.47] {val* ({BR l + 1}) instr*}  :  admininstr*
[niteration ../spec/5-reduction.watsup:70.4-70.47] val* ({BR l + 1}) instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.24-70.28] val*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.24-70.27] val  :  admininstr
[elab ../spec/5-reduction.watsup:70.24-70.27] val  :  admininstr
[niteration ../spec/5-reduction.watsup:70.4-70.47] ({BR l + 1}) instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.29-70.40] ({BR l + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:70.29-70.40] ({BR l + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:70.30-70.39] {BR l + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:70.30-70.39] {BR l + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:70.30-70.39] {l + 1}  :  {labelidx}
[notation ../spec/5-reduction.watsup:70.33-70.39] l + 1  :  labelidx
[elab ../spec/5-reduction.watsup:70.33-70.39] l + 1  :  labelidx
[elab ../spec/5-reduction.watsup:70.35-70.36] l  :  nat
[elab ../spec/5-reduction.watsup:70.37-70.38] 1  :  nat
[notation ../spec/5-reduction.watsup:70.30-70.39] {}  :  {}
[niteration ../spec/5-reduction.watsup:70.4-70.47] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.41-70.47] instr*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.41-70.46] instr  :  admininstr
[elab ../spec/5-reduction.watsup:70.41-70.46] instr  :  admininstr
[niteration ../spec/5-reduction.watsup:70.4-70.47]   :  admininstr*
[notation ../spec/5-reduction.watsup:70.54-70.65] {val* ({BR l})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:70.54-70.65] val* ({BR l})  :  admininstr*
[notation ../spec/5-reduction.watsup:70.54-70.58] val*  :  admininstr*
[notation ../spec/5-reduction.watsup:70.54-70.57] val  :  admininstr
[elab ../spec/5-reduction.watsup:70.54-70.57] val  :  admininstr
[niteration ../spec/5-reduction.watsup:70.54-70.65] ({BR l})  :  admininstr*
[notation ../spec/5-reduction.watsup:70.59-70.65] ({BR l})  :  admininstr*
[notation ../spec/5-reduction.watsup:70.59-70.65] ({BR l})  :  admininstr
[notation ../spec/5-reduction.watsup:70.60-70.64] {BR l}  :  admininstr
[elab ../spec/5-reduction.watsup:70.60-70.64] {BR l}  :  admininstr
[notation ../spec/5-reduction.watsup:70.60-70.64] {l}  :  {labelidx}
[notation ../spec/5-reduction.watsup:70.63-70.64] l  :  labelidx
[elab ../spec/5-reduction.watsup:70.63-70.64] l  :  labelidx
[notation ../spec/5-reduction.watsup:70.60-70.64] {}  :  {}
[niteration ../spec/5-reduction.watsup:70.54-70.65]   :  admininstr*
[notation ../spec/5-reduction.watsup:74.3-74.38] {({CONST I32 c}) ({BR_IF l})} ~> ({BR l})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:74.3-74.26] {({CONST I32 c}) ({BR_IF l})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:74.3-74.26] ({CONST I32 c}) ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:74.3-74.16] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:74.3-74.16] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:74.4-74.15] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:74.4-74.15] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:74.4-74.15] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:74.10-74.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:74.10-74.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:74.10-74.13] {}  :  {}
[notation ../spec/5-reduction.watsup:74.4-74.15] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:74.14-74.15] c  :  c_numtype
[elab ../spec/5-reduction.watsup:74.14-74.15] c  :  c_numtype
[notation ../spec/5-reduction.watsup:74.4-74.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:74.3-74.26] ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:74.17-74.26] ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:74.17-74.26] ({BR_IF l})  :  admininstr
[notation ../spec/5-reduction.watsup:74.18-74.25] {BR_IF l}  :  admininstr
[elab ../spec/5-reduction.watsup:74.18-74.25] {BR_IF l}  :  admininstr
[notation ../spec/5-reduction.watsup:74.18-74.25] {l}  :  {labelidx}
[notation ../spec/5-reduction.watsup:74.24-74.25] l  :  labelidx
[elab ../spec/5-reduction.watsup:74.24-74.25] l  :  labelidx
[notation ../spec/5-reduction.watsup:74.18-74.25] {}  :  {}
[niteration ../spec/5-reduction.watsup:74.3-74.26]   :  admininstr*
[notation ../spec/5-reduction.watsup:74.32-74.38] ({BR l})  :  admininstr*
[notation ../spec/5-reduction.watsup:74.33-74.37] {BR l}  :  admininstr
[elab ../spec/5-reduction.watsup:74.33-74.37] {BR l}  :  admininstr
[notation ../spec/5-reduction.watsup:74.33-74.37] {l}  :  {labelidx}
[notation ../spec/5-reduction.watsup:74.36-74.37] l  :  labelidx
[elab ../spec/5-reduction.watsup:74.36-74.37] l  :  labelidx
[notation ../spec/5-reduction.watsup:74.33-74.37] {}  :  {}
[elab ../spec/5-reduction.watsup:75.9-75.16] c =/= 0  :  bool
[elab ../spec/5-reduction.watsup:75.9-75.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:75.15-75.16] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:78.3-78.39] {({CONST I32 c}) ({BR_IF l})} ~> epsilon  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:78.3-78.26] {({CONST I32 c}) ({BR_IF l})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:78.3-78.26] ({CONST I32 c}) ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:78.3-78.16] ({CONST I32 c})  :  admininstr*
[notation ../spec/5-reduction.watsup:78.3-78.16] ({CONST I32 c})  :  admininstr
[notation ../spec/5-reduction.watsup:78.4-78.15] {CONST I32 c}  :  admininstr
[elab ../spec/5-reduction.watsup:78.4-78.15] {CONST I32 c}  :  admininstr
[notation ../spec/5-reduction.watsup:78.4-78.15] {I32 c}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:78.10-78.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:78.10-78.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:78.10-78.13] {}  :  {}
[notation ../spec/5-reduction.watsup:78.4-78.15] {c}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:78.14-78.15] c  :  c_numtype
[elab ../spec/5-reduction.watsup:78.14-78.15] c  :  c_numtype
[notation ../spec/5-reduction.watsup:78.4-78.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:78.3-78.26] ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:78.17-78.26] ({BR_IF l})  :  admininstr*
[notation ../spec/5-reduction.watsup:78.17-78.26] ({BR_IF l})  :  admininstr
[notation ../spec/5-reduction.watsup:78.18-78.25] {BR_IF l}  :  admininstr
[elab ../spec/5-reduction.watsup:78.18-78.25] {BR_IF l}  :  admininstr
[notation ../spec/5-reduction.watsup:78.18-78.25] {l}  :  {labelidx}
[notation ../spec/5-reduction.watsup:78.24-78.25] l  :  labelidx
[elab ../spec/5-reduction.watsup:78.24-78.25] l  :  labelidx
[notation ../spec/5-reduction.watsup:78.18-78.25] {}  :  {}
[niteration ../spec/5-reduction.watsup:78.3-78.26]   :  admininstr*
[notation ../spec/5-reduction.watsup:78.32-78.39] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:78.32-78.39]   :  admininstr*
[elab ../spec/5-reduction.watsup:79.9-79.14] c = 0  :  bool
[elab ../spec/5-reduction.watsup:79.9-79.10] c  :  c_numtype
[elab ../spec/5-reduction.watsup:79.13-79.14] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:83.3-83.49] {({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l*[i]})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:83.3-83.33] {({CONST I32 i}) ({BR_TABLE l* l'})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:83.3-83.33] ({CONST I32 i}) ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:83.3-83.16] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:83.3-83.16] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:83.4-83.15] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:83.4-83.15] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:83.4-83.15] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:83.10-83.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:83.10-83.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:83.10-83.13] {}  :  {}
[notation ../spec/5-reduction.watsup:83.4-83.15] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:83.14-83.15] i  :  c_numtype
[elab ../spec/5-reduction.watsup:83.14-83.15] i  :  c_numtype
[notation ../spec/5-reduction.watsup:83.4-83.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:83.3-83.33] ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:83.17-83.33] ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:83.17-83.33] ({BR_TABLE l* l'})  :  admininstr
[notation ../spec/5-reduction.watsup:83.18-83.32] {BR_TABLE l* l'}  :  admininstr
[elab ../spec/5-reduction.watsup:83.18-83.32] {BR_TABLE l* l'}  :  admininstr
[notation ../spec/5-reduction.watsup:83.18-83.32] {l* l'}  :  {labelidx* labelidx}
[notation ../spec/5-reduction.watsup:83.27-83.29] l*  :  labelidx*
[notation ../spec/5-reduction.watsup:83.27-83.28] l  :  labelidx
[elab ../spec/5-reduction.watsup:83.27-83.28] l  :  labelidx
[notation ../spec/5-reduction.watsup:83.18-83.32] {l'}  :  {labelidx}
[notation ../spec/5-reduction.watsup:83.30-83.32] l'  :  labelidx
[elab ../spec/5-reduction.watsup:83.30-83.32] l'  :  labelidx
[notation ../spec/5-reduction.watsup:83.18-83.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:83.3-83.33]   :  admininstr*
[notation ../spec/5-reduction.watsup:83.39-83.49] ({BR l*[i]})  :  admininstr*
[notation ../spec/5-reduction.watsup:83.40-83.48] {BR l*[i]}  :  admininstr
[elab ../spec/5-reduction.watsup:83.40-83.48] {BR l*[i]}  :  admininstr
[notation ../spec/5-reduction.watsup:83.40-83.48] {l*[i]}  :  {labelidx}
[notation ../spec/5-reduction.watsup:83.43-83.48] l*[i]  :  labelidx
[elab ../spec/5-reduction.watsup:83.43-83.48] l*[i]  :  labelidx
[elab ../spec/5-reduction.watsup:83.43-83.45] l*  :  labelidx*
[elab ../spec/5-reduction.watsup:83.43-83.44] l  :  labelidx
[elab ../spec/5-reduction.watsup:83.46-83.47] i  :  nat
[notation ../spec/5-reduction.watsup:83.40-83.48] {}  :  {}
[elab ../spec/5-reduction.watsup:84.9-84.17] i < |l*|  :  bool
[elab ../spec/5-reduction.watsup:84.9-84.10] i  :  nat
[elab ../spec/5-reduction.watsup:84.13-84.17] |l*|  :  nat
[elab ../spec/5-reduction.watsup:84.14-84.16] l*  :  labelidx*
[elab ../spec/5-reduction.watsup:84.14-84.15] l  :  labelidx
[notation ../spec/5-reduction.watsup:87.3-87.46] {({CONST I32 i}) ({BR_TABLE l* l'})} ~> ({BR l'})  :  admininstr* ~> admininstr*
[notation ../spec/5-reduction.watsup:87.3-87.33] {({CONST I32 i}) ({BR_TABLE l* l'})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:87.3-87.33] ({CONST I32 i}) ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:87.3-87.16] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:87.3-87.16] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:87.4-87.15] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:87.4-87.15] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:87.4-87.15] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:87.10-87.13] I32  :  numtype
[elab ../spec/5-reduction.watsup:87.10-87.13] I32  :  numtype
[notation ../spec/5-reduction.watsup:87.10-87.13] {}  :  {}
[notation ../spec/5-reduction.watsup:87.4-87.15] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:87.14-87.15] i  :  c_numtype
[elab ../spec/5-reduction.watsup:87.14-87.15] i  :  c_numtype
[notation ../spec/5-reduction.watsup:87.4-87.15] {}  :  {}
[niteration ../spec/5-reduction.watsup:87.3-87.33] ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:87.17-87.33] ({BR_TABLE l* l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:87.17-87.33] ({BR_TABLE l* l'})  :  admininstr
[notation ../spec/5-reduction.watsup:87.18-87.32] {BR_TABLE l* l'}  :  admininstr
[elab ../spec/5-reduction.watsup:87.18-87.32] {BR_TABLE l* l'}  :  admininstr
[notation ../spec/5-reduction.watsup:87.18-87.32] {l* l'}  :  {labelidx* labelidx}
[notation ../spec/5-reduction.watsup:87.27-87.29] l*  :  labelidx*
[notation ../spec/5-reduction.watsup:87.27-87.28] l  :  labelidx
[elab ../spec/5-reduction.watsup:87.27-87.28] l  :  labelidx
[notation ../spec/5-reduction.watsup:87.18-87.32] {l'}  :  {labelidx}
[notation ../spec/5-reduction.watsup:87.30-87.32] l'  :  labelidx
[elab ../spec/5-reduction.watsup:87.30-87.32] l'  :  labelidx
[notation ../spec/5-reduction.watsup:87.18-87.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:87.3-87.33]   :  admininstr*
[notation ../spec/5-reduction.watsup:87.39-87.46] ({BR l'})  :  admininstr*
[notation ../spec/5-reduction.watsup:87.40-87.45] {BR l'}  :  admininstr
[elab ../spec/5-reduction.watsup:87.40-87.45] {BR l'}  :  admininstr
[notation ../spec/5-reduction.watsup:87.40-87.45] {l'}  :  {labelidx}
[notation ../spec/5-reduction.watsup:87.43-87.45] l'  :  labelidx
[elab ../spec/5-reduction.watsup:87.43-87.45] l'  :  labelidx
[notation ../spec/5-reduction.watsup:87.40-87.45] {}  :  {}
[elab ../spec/5-reduction.watsup:88.9-88.18] i >= |l*|  :  bool
[elab ../spec/5-reduction.watsup:88.9-88.10] i  :  nat
[elab ../spec/5-reduction.watsup:88.14-88.18] |l*|  :  nat
[elab ../spec/5-reduction.watsup:88.15-88.17] l*  :  labelidx*
[elab ../spec/5-reduction.watsup:88.15-88.16] l  :  labelidx
[notation ../spec/5-reduction.watsup:91.3-91.53] z ; ({REF.FUNC x}) ~> ({REF.FUNC_ADDR $funcaddr(z)[x]})  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  config
[elab ../spec/5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  config
[notation ../spec/5-reduction.watsup:91.3-91.18] z ; ({REF.FUNC x})  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:91.3-91.4] z  :  state
[elab ../spec/5-reduction.watsup:91.3-91.4] z  :  state
[notation ../spec/5-reduction.watsup:91.6-91.18] ({REF.FUNC x})  :  admininstr*
[notation ../spec/5-reduction.watsup:91.7-91.17] {REF.FUNC x}  :  admininstr
[elab ../spec/5-reduction.watsup:91.7-91.17] {REF.FUNC x}  :  admininstr
[notation ../spec/5-reduction.watsup:91.7-91.17] {x}  :  {funcidx}
[notation ../spec/5-reduction.watsup:91.16-91.17] x  :  funcidx
[elab ../spec/5-reduction.watsup:91.16-91.17] x  :  funcidx
[notation ../spec/5-reduction.watsup:91.7-91.17] {}  :  {}
[notation ../spec/5-reduction.watsup:91.22-91.53] ({REF.FUNC_ADDR $funcaddr(z)[x]})  :  admininstr*
[notation ../spec/5-reduction.watsup:91.23-91.52] {REF.FUNC_ADDR $funcaddr(z)[x]}  :  admininstr
[elab ../spec/5-reduction.watsup:91.23-91.52] {REF.FUNC_ADDR $funcaddr(z)[x]}  :  admininstr
[notation ../spec/5-reduction.watsup:91.23-91.52] {$funcaddr(z)[x]}  :  {funcaddr}
[notation ../spec/5-reduction.watsup:91.37-91.52] $funcaddr(z)[x]  :  funcaddr
[elab ../spec/5-reduction.watsup:91.37-91.52] $funcaddr(z)[x]  :  funcaddr
[elab ../spec/5-reduction.watsup:91.37-91.49] $funcaddr(z)  :  funcaddr*
[elab ../spec/5-reduction.watsup:91.46-91.49] (z)  :  (state)
[elab ../spec/5-reduction.watsup:91.47-91.48] z  :  (state)
[elab ../spec/5-reduction.watsup:91.50-91.51] x  :  nat
[notation ../spec/5-reduction.watsup:91.23-91.52] {}  :  {}
[notation ../spec/5-reduction.watsup:94.3-94.35] z ; ({LOCAL.GET x}) ~> $local(z, x)  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  config
[elab ../spec/5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  config
[notation ../spec/5-reduction.watsup:94.3-94.19] z ; ({LOCAL.GET x})  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:94.3-94.4] z  :  state
[elab ../spec/5-reduction.watsup:94.3-94.4] z  :  state
[notation ../spec/5-reduction.watsup:94.6-94.19] ({LOCAL.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:94.7-94.18] {LOCAL.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:94.7-94.18] {LOCAL.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:94.7-94.18] {x}  :  {localidx}
[notation ../spec/5-reduction.watsup:94.17-94.18] x  :  localidx
[elab ../spec/5-reduction.watsup:94.17-94.18] x  :  localidx
[notation ../spec/5-reduction.watsup:94.7-94.18] {}  :  {}
[notation ../spec/5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr*
[notation ../spec/5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr
[elab ../spec/5-reduction.watsup:94.23-94.35] $local(z, x)  :  admininstr
[elab ../spec/5-reduction.watsup:94.29-94.35] (z, x)  :  (state, localidx)
[elab ../spec/5-reduction.watsup:94.30-94.31] z  :  state
[elab ../spec/5-reduction.watsup:94.33-94.34] x  :  localidx
[notation ../spec/5-reduction.watsup:97.3-97.37] z ; ({GLOBAL.GET x}) ~> $global(z, x)  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  config
[elab ../spec/5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  config
[notation ../spec/5-reduction.watsup:97.3-97.20] z ; ({GLOBAL.GET x})  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:97.3-97.4] z  :  state
[elab ../spec/5-reduction.watsup:97.3-97.4] z  :  state
[notation ../spec/5-reduction.watsup:97.6-97.20] ({GLOBAL.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:97.7-97.19] {GLOBAL.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:97.7-97.19] {GLOBAL.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:97.7-97.19] {x}  :  {globalidx}
[notation ../spec/5-reduction.watsup:97.18-97.19] x  :  globalidx
[elab ../spec/5-reduction.watsup:97.18-97.19] x  :  globalidx
[notation ../spec/5-reduction.watsup:97.7-97.19] {}  :  {}
[notation ../spec/5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr*
[notation ../spec/5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr
[elab ../spec/5-reduction.watsup:97.24-97.37] $global(z, x)  :  admininstr
[elab ../spec/5-reduction.watsup:97.31-97.37] (z, x)  :  (state, globalidx)
[elab ../spec/5-reduction.watsup:97.32-97.33] z  :  state
[elab ../spec/5-reduction.watsup:97.35-97.36] x  :  globalidx
[notation ../spec/5-reduction.watsup:100.3-100.41] z ; {({CONST I32 i}) ({TABLE.GET x})} ~> TRAP  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[elab ../spec/5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[notation ../spec/5-reduction.watsup:100.3-100.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:100.3-100.4] z  :  state
[elab ../spec/5-reduction.watsup:100.3-100.4] z  :  state
[notation ../spec/5-reduction.watsup:100.6-100.33] {({CONST I32 i}) ({TABLE.GET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:100.6-100.33] ({CONST I32 i}) ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:100.6-100.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:100.6-100.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:100.7-100.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:100.7-100.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:100.7-100.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:100.13-100.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:100.13-100.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:100.13-100.16] {}  :  {}
[notation ../spec/5-reduction.watsup:100.7-100.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:100.17-100.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:100.17-100.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:100.7-100.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:100.6-100.33] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:100.20-100.33] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:100.20-100.33] ({TABLE.GET x})  :  admininstr
[notation ../spec/5-reduction.watsup:100.21-100.32] {TABLE.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:100.21-100.32] {TABLE.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:100.21-100.32] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:100.31-100.32] x  :  tableidx
[elab ../spec/5-reduction.watsup:100.31-100.32] x  :  tableidx
[notation ../spec/5-reduction.watsup:100.21-100.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:100.6-100.33]   :  admininstr*
[notation ../spec/5-reduction.watsup:100.37-100.41] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:100.37-100.41] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:100.37-100.41] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:100.37-100.41] {}  :  {}
[elab ../spec/5-reduction.watsup:101.9-101.28] i >= |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:101.9-101.10] i  :  nat
[elab ../spec/5-reduction.watsup:101.14-101.28] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:101.15-101.27] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:101.21-101.27] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:101.22-101.23] z  :  state
[elab ../spec/5-reduction.watsup:101.25-101.26] x  :  tableidx
[notation ../spec/5-reduction.watsup:104.3-104.51] z ; {({CONST I32 i}) ({TABLE.GET x})} ~> $table(z, x)[i]  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[elab ../spec/5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  config
[notation ../spec/5-reduction.watsup:104.3-104.33] z ; {({CONST I32 i}) ({TABLE.GET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:104.3-104.4] z  :  state
[elab ../spec/5-reduction.watsup:104.3-104.4] z  :  state
[notation ../spec/5-reduction.watsup:104.6-104.33] {({CONST I32 i}) ({TABLE.GET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:104.6-104.33] ({CONST I32 i}) ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:104.6-104.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:104.6-104.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:104.7-104.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:104.7-104.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:104.7-104.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:104.13-104.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:104.13-104.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:104.13-104.16] {}  :  {}
[notation ../spec/5-reduction.watsup:104.7-104.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:104.17-104.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:104.17-104.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:104.7-104.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:104.6-104.33] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:104.20-104.33] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:104.20-104.33] ({TABLE.GET x})  :  admininstr
[notation ../spec/5-reduction.watsup:104.21-104.32] {TABLE.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:104.21-104.32] {TABLE.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:104.21-104.32] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:104.31-104.32] x  :  tableidx
[elab ../spec/5-reduction.watsup:104.31-104.32] x  :  tableidx
[notation ../spec/5-reduction.watsup:104.21-104.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:104.6-104.33]   :  admininstr*
[notation ../spec/5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr*
[notation ../spec/5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr
[elab ../spec/5-reduction.watsup:104.37-104.51] $table(z, x)[i]  :  admininstr
[elab ../spec/5-reduction.watsup:104.37-104.48] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:104.43-104.48] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:104.44-104.45] z  :  state
[elab ../spec/5-reduction.watsup:104.46-104.47] x  :  tableidx
[elab ../spec/5-reduction.watsup:104.49-104.50] i  :  nat
[elab ../spec/5-reduction.watsup:105.9-105.27] i < |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:105.9-105.10] i  :  nat
[elab ../spec/5-reduction.watsup:105.13-105.27] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:105.14-105.26] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:105.20-105.26] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:105.21-105.22] z  :  state
[elab ../spec/5-reduction.watsup:105.24-105.25] x  :  tableidx
[notation ../spec/5-reduction.watsup:108.3-108.37] z ; ({TABLE.SIZE x}) ~> ({CONST I32 n})  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  config
[elab ../spec/5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  config
[notation ../spec/5-reduction.watsup:108.3-108.20] z ; ({TABLE.SIZE x})  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:108.3-108.4] z  :  state
[elab ../spec/5-reduction.watsup:108.3-108.4] z  :  state
[notation ../spec/5-reduction.watsup:108.6-108.20] ({TABLE.SIZE x})  :  admininstr*
[notation ../spec/5-reduction.watsup:108.7-108.19] {TABLE.SIZE x}  :  admininstr
[elab ../spec/5-reduction.watsup:108.7-108.19] {TABLE.SIZE x}  :  admininstr
[notation ../spec/5-reduction.watsup:108.7-108.19] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:108.18-108.19] x  :  tableidx
[elab ../spec/5-reduction.watsup:108.18-108.19] x  :  tableidx
[notation ../spec/5-reduction.watsup:108.7-108.19] {}  :  {}
[notation ../spec/5-reduction.watsup:108.24-108.37] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:108.25-108.36] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:108.25-108.36] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:108.25-108.36] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:108.31-108.34] I32  :  numtype
[elab ../spec/5-reduction.watsup:108.31-108.34] I32  :  numtype
[notation ../spec/5-reduction.watsup:108.31-108.34] {}  :  {}
[notation ../spec/5-reduction.watsup:108.25-108.36] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:108.35-108.36] n  :  c_numtype
[elab ../spec/5-reduction.watsup:108.35-108.36] n  :  c_numtype
[notation ../spec/5-reduction.watsup:108.25-108.36] {}  :  {}
[elab ../spec/5-reduction.watsup:109.9-109.27] |$table(z, x)| = n  :  bool
[elab ../spec/5-reduction.watsup:109.9-109.23] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:109.10-109.22] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:109.16-109.22] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:109.17-109.18] z  :  state
[elab ../spec/5-reduction.watsup:109.20-109.21] x  :  tableidx
[elab ../spec/5-reduction.watsup:109.26-109.27] n  :  nat
[notation ../spec/5-reduction.watsup:112.3-112.60] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})} ~> TRAP  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config
[elab ../spec/5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config
[notation ../spec/5-reduction.watsup:112.3-112.52] z ; {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:112.3-112.4] z  :  state
[elab ../spec/5-reduction.watsup:112.3-112.4] z  :  state
[notation ../spec/5-reduction.watsup:112.6-112.52] {({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:112.6-112.52] ({CONST I32 i}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.6-112.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.6-112.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:112.7-112.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:112.7-112.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:112.7-112.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:112.13-112.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:112.13-112.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:112.13-112.16] {}  :  {}
[notation ../spec/5-reduction.watsup:112.7-112.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:112.17-112.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:112.17-112.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:112.7-112.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:112.6-112.52] val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.20-112.23] val  :  admininstr*
[notation ../spec/5-reduction.watsup:112.20-112.23] val  :  admininstr
[elab ../spec/5-reduction.watsup:112.20-112.23] val  :  admininstr
[niteration ../spec/5-reduction.watsup:112.6-112.52] ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.24-112.37] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.24-112.37] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:112.25-112.36] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:112.25-112.36] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:112.25-112.36] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:112.31-112.34] I32  :  numtype
[elab ../spec/5-reduction.watsup:112.31-112.34] I32  :  numtype
[notation ../spec/5-reduction.watsup:112.31-112.34] {}  :  {}
[notation ../spec/5-reduction.watsup:112.25-112.36] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:112.35-112.36] n  :  c_numtype
[elab ../spec/5-reduction.watsup:112.35-112.36] n  :  c_numtype
[notation ../spec/5-reduction.watsup:112.25-112.36] {}  :  {}
[niteration ../spec/5-reduction.watsup:112.6-112.52] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.38-112.52] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:112.38-112.52] ({TABLE.FILL x})  :  admininstr
[notation ../spec/5-reduction.watsup:112.39-112.51] {TABLE.FILL x}  :  admininstr
[elab ../spec/5-reduction.watsup:112.39-112.51] {TABLE.FILL x}  :  admininstr
[notation ../spec/5-reduction.watsup:112.39-112.51] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:112.50-112.51] x  :  tableidx
[elab ../spec/5-reduction.watsup:112.50-112.51] x  :  tableidx
[notation ../spec/5-reduction.watsup:112.39-112.51] {}  :  {}
[niteration ../spec/5-reduction.watsup:112.6-112.52]   :  admininstr*
[notation ../spec/5-reduction.watsup:112.56-112.60] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:112.56-112.60] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:112.56-112.60] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:112.56-112.60] {}  :  {}
[elab ../spec/5-reduction.watsup:113.9-113.34] i + n > |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:113.9-113.17] i + n  :  nat
[elab ../spec/5-reduction.watsup:113.11-113.12] i  :  nat
[elab ../spec/5-reduction.watsup:113.15-113.16] n  :  nat
[elab ../spec/5-reduction.watsup:113.20-113.34] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:113.21-113.33] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:113.27-113.33] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:113.28-113.29] z  :  state
[elab ../spec/5-reduction.watsup:113.31-113.32] x  :  tableidx
[notation ../spec/5-reduction.watsup:115.3-115.63] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})} ~> epsilon  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  config
[elab ../spec/5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  config
[notation ../spec/5-reduction.watsup:115.3-115.52] z ; {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:115.3-115.4] z  :  state
[elab ../spec/5-reduction.watsup:115.3-115.4] z  :  state
[notation ../spec/5-reduction.watsup:115.6-115.52] {({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:115.6-115.52] ({CONST I32 i}) val ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.6-115.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.6-115.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:115.7-115.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:115.7-115.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:115.7-115.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:115.13-115.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:115.13-115.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:115.13-115.16] {}  :  {}
[notation ../spec/5-reduction.watsup:115.7-115.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:115.17-115.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:115.17-115.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:115.7-115.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:115.6-115.52] val ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.20-115.23] val  :  admininstr*
[notation ../spec/5-reduction.watsup:115.20-115.23] val  :  admininstr
[elab ../spec/5-reduction.watsup:115.20-115.23] val  :  admininstr
[niteration ../spec/5-reduction.watsup:115.6-115.52] ({CONST I32 0}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.24-115.37] ({CONST I32 0})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.24-115.37] ({CONST I32 0})  :  admininstr
[notation ../spec/5-reduction.watsup:115.25-115.36] {CONST I32 0}  :  admininstr
[elab ../spec/5-reduction.watsup:115.25-115.36] {CONST I32 0}  :  admininstr
[notation ../spec/5-reduction.watsup:115.25-115.36] {I32 0}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:115.31-115.34] I32  :  numtype
[elab ../spec/5-reduction.watsup:115.31-115.34] I32  :  numtype
[notation ../spec/5-reduction.watsup:115.31-115.34] {}  :  {}
[notation ../spec/5-reduction.watsup:115.25-115.36] {0}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:115.35-115.36] 0  :  c_numtype
[elab ../spec/5-reduction.watsup:115.35-115.36] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:115.25-115.36] {}  :  {}
[niteration ../spec/5-reduction.watsup:115.6-115.52] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.38-115.52] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:115.38-115.52] ({TABLE.FILL x})  :  admininstr
[notation ../spec/5-reduction.watsup:115.39-115.51] {TABLE.FILL x}  :  admininstr
[elab ../spec/5-reduction.watsup:115.39-115.51] {TABLE.FILL x}  :  admininstr
[notation ../spec/5-reduction.watsup:115.39-115.51] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:115.50-115.51] x  :  tableidx
[elab ../spec/5-reduction.watsup:115.50-115.51] x  :  tableidx
[notation ../spec/5-reduction.watsup:115.39-115.51] {}  :  {}
[niteration ../spec/5-reduction.watsup:115.6-115.52]   :  admininstr*
[notation ../spec/5-reduction.watsup:115.56-115.63] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:115.56-115.63]   :  admininstr*
[notation ../spec/5-reduction.watsup:118.3-119.89] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})} ~> {({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  config
[elab ../spec/5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  config
[notation ../spec/5-reduction.watsup:118.3-118.57] z ; {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:118.3-118.4] z  :  state
[elab ../spec/5-reduction.watsup:118.3-118.4] z  :  state
[notation ../spec/5-reduction.watsup:118.6-118.57] {({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:118.6-118.57] ({CONST I32 i}) val ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.6-118.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.6-118.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:118.7-118.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:118.7-118.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:118.7-118.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:118.13-118.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:118.13-118.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:118.13-118.16] {}  :  {}
[notation ../spec/5-reduction.watsup:118.7-118.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:118.17-118.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:118.17-118.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:118.7-118.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:118.6-118.57] val ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.20-118.23] val  :  admininstr*
[notation ../spec/5-reduction.watsup:118.20-118.23] val  :  admininstr
[elab ../spec/5-reduction.watsup:118.20-118.23] val  :  admininstr
[niteration ../spec/5-reduction.watsup:118.6-118.57] ({CONST I32 n + 1}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.24-118.42] ({CONST I32 n + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.24-118.42] ({CONST I32 n + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:118.25-118.41] {CONST I32 n + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:118.25-118.41] {CONST I32 n + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:118.25-118.41] {I32 n + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:118.31-118.34] I32  :  numtype
[elab ../spec/5-reduction.watsup:118.31-118.34] I32  :  numtype
[notation ../spec/5-reduction.watsup:118.31-118.34] {}  :  {}
[notation ../spec/5-reduction.watsup:118.25-118.41] {n + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:118.35-118.41] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:118.35-118.41] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:118.37-118.38] n  :  nat
[elab ../spec/5-reduction.watsup:118.39-118.40] 1  :  nat
[notation ../spec/5-reduction.watsup:118.25-118.41] {}  :  {}
[niteration ../spec/5-reduction.watsup:118.6-118.57] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.43-118.57] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:118.43-118.57] ({TABLE.FILL x})  :  admininstr
[notation ../spec/5-reduction.watsup:118.44-118.56] {TABLE.FILL x}  :  admininstr
[elab ../spec/5-reduction.watsup:118.44-118.56] {TABLE.FILL x}  :  admininstr
[notation ../spec/5-reduction.watsup:118.44-118.56] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:118.55-118.56] x  :  tableidx
[elab ../spec/5-reduction.watsup:118.55-118.56] x  :  tableidx
[notation ../spec/5-reduction.watsup:118.44-118.56] {}  :  {}
[niteration ../spec/5-reduction.watsup:118.6-118.57]   :  admininstr*
[notation ../spec/5-reduction.watsup:119.6-119.89] {({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:119.6-119.89] ({CONST I32 i}) val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.6-119.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.6-119.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:119.7-119.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:119.7-119.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:119.7-119.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:119.13-119.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:119.13-119.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:119.13-119.16] {}  :  {}
[notation ../spec/5-reduction.watsup:119.7-119.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:119.17-119.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:119.17-119.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:119.7-119.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:119.6-119.89] val ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.20-119.23] val  :  admininstr*
[notation ../spec/5-reduction.watsup:119.20-119.23] val  :  admininstr
[elab ../spec/5-reduction.watsup:119.20-119.23] val  :  admininstr
[niteration ../spec/5-reduction.watsup:119.6-119.89] ({TABLE.SET x}) ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.24-119.37] ({TABLE.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.24-119.37] ({TABLE.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:119.25-119.36] {TABLE.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:119.25-119.36] {TABLE.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:119.25-119.36] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:119.35-119.36] x  :  tableidx
[elab ../spec/5-reduction.watsup:119.35-119.36] x  :  tableidx
[notation ../spec/5-reduction.watsup:119.25-119.36] {}  :  {}
[niteration ../spec/5-reduction.watsup:119.6-119.89] ({CONST I32 i + 1}) val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.38-119.56] ({CONST I32 i + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.38-119.56] ({CONST I32 i + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:119.39-119.55] {CONST I32 i + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:119.39-119.55] {CONST I32 i + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:119.39-119.55] {I32 i + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:119.45-119.48] I32  :  numtype
[elab ../spec/5-reduction.watsup:119.45-119.48] I32  :  numtype
[notation ../spec/5-reduction.watsup:119.45-119.48] {}  :  {}
[notation ../spec/5-reduction.watsup:119.39-119.55] {i + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:119.49-119.55] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:119.49-119.55] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:119.51-119.52] i  :  nat
[elab ../spec/5-reduction.watsup:119.53-119.54] 1  :  nat
[notation ../spec/5-reduction.watsup:119.39-119.55] {}  :  {}
[niteration ../spec/5-reduction.watsup:119.6-119.89] val ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.57-119.60] val  :  admininstr*
[notation ../spec/5-reduction.watsup:119.57-119.60] val  :  admininstr
[elab ../spec/5-reduction.watsup:119.57-119.60] val  :  admininstr
[niteration ../spec/5-reduction.watsup:119.6-119.89] ({CONST I32 n}) ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.61-119.74] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.61-119.74] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:119.62-119.73] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:119.62-119.73] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:119.62-119.73] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:119.68-119.71] I32  :  numtype
[elab ../spec/5-reduction.watsup:119.68-119.71] I32  :  numtype
[notation ../spec/5-reduction.watsup:119.68-119.71] {}  :  {}
[notation ../spec/5-reduction.watsup:119.62-119.73] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:119.72-119.73] n  :  c_numtype
[elab ../spec/5-reduction.watsup:119.72-119.73] n  :  c_numtype
[notation ../spec/5-reduction.watsup:119.62-119.73] {}  :  {}
[niteration ../spec/5-reduction.watsup:119.6-119.89] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.75-119.89] ({TABLE.FILL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:119.75-119.89] ({TABLE.FILL x})  :  admininstr
[notation ../spec/5-reduction.watsup:119.76-119.88] {TABLE.FILL x}  :  admininstr
[elab ../spec/5-reduction.watsup:119.76-119.88] {TABLE.FILL x}  :  admininstr
[notation ../spec/5-reduction.watsup:119.76-119.88] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:119.87-119.88] x  :  tableidx
[elab ../spec/5-reduction.watsup:119.87-119.88] x  :  tableidx
[notation ../spec/5-reduction.watsup:119.76-119.88] {}  :  {}
[niteration ../spec/5-reduction.watsup:119.6-119.89]   :  admininstr*
[notation ../spec/5-reduction.watsup:123.3-123.72] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})} ~> TRAP  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config
[elab ../spec/5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config
[notation ../spec/5-reduction.watsup:123.3-123.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:123.3-123.4] z  :  state
[elab ../spec/5-reduction.watsup:123.3-123.4] z  :  state
[notation ../spec/5-reduction.watsup:123.6-123.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:123.6-123.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.6-123.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.6-123.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:123.7-123.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:123.7-123.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:123.7-123.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:123.13-123.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:123.13-123.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:123.13-123.16] {}  :  {}
[notation ../spec/5-reduction.watsup:123.7-123.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:123.17-123.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:123.17-123.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:123.7-123.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:123.6-123.64] ({CONST I32 i}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.20-123.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.20-123.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:123.21-123.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:123.21-123.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:123.21-123.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:123.27-123.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:123.27-123.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:123.27-123.30] {}  :  {}
[notation ../spec/5-reduction.watsup:123.21-123.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:123.31-123.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:123.31-123.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:123.21-123.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:123.6-123.64] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.34-123.47] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.34-123.47] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:123.35-123.46] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:123.35-123.46] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:123.35-123.46] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:123.41-123.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:123.41-123.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:123.41-123.44] {}  :  {}
[notation ../spec/5-reduction.watsup:123.35-123.46] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:123.45-123.46] n  :  c_numtype
[elab ../spec/5-reduction.watsup:123.45-123.46] n  :  c_numtype
[notation ../spec/5-reduction.watsup:123.35-123.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:123.6-123.64] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.48-123.64] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:123.48-123.64] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:123.49-123.63] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:123.49-123.63] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:123.49-123.63] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:123.60-123.61] x  :  tableidx
[elab ../spec/5-reduction.watsup:123.60-123.61] x  :  tableidx
[notation ../spec/5-reduction.watsup:123.49-123.63] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:123.62-123.63] y  :  tableidx
[elab ../spec/5-reduction.watsup:123.62-123.63] y  :  tableidx
[notation ../spec/5-reduction.watsup:123.49-123.63] {}  :  {}
[niteration ../spec/5-reduction.watsup:123.6-123.64]   :  admininstr*
[notation ../spec/5-reduction.watsup:123.68-123.72] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:123.68-123.72] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:123.68-123.72] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:123.68-123.72] {}  :  {}
[elab ../spec/5-reduction.watsup:124.9-124.63] i + n > |$table(z, y)| \/ j + n > |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:124.9-124.34] i + n > |$table(z, y)|  :  bool
[elab ../spec/5-reduction.watsup:124.9-124.17] i + n  :  nat
[elab ../spec/5-reduction.watsup:124.11-124.12] i  :  nat
[elab ../spec/5-reduction.watsup:124.15-124.16] n  :  nat
[elab ../spec/5-reduction.watsup:124.20-124.34] |$table(z, y)|  :  nat
[elab ../spec/5-reduction.watsup:124.21-124.33] $table(z, y)  :  tableinst
[elab ../spec/5-reduction.watsup:124.27-124.33] (z, y)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:124.28-124.29] z  :  state
[elab ../spec/5-reduction.watsup:124.31-124.32] y  :  tableidx
[elab ../spec/5-reduction.watsup:124.38-124.63] j + n > |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:124.38-124.46] j + n  :  nat
[elab ../spec/5-reduction.watsup:124.40-124.41] j  :  nat
[elab ../spec/5-reduction.watsup:124.44-124.45] n  :  nat
[elab ../spec/5-reduction.watsup:124.49-124.63] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:124.50-124.62] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:124.56-124.62] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:124.57-124.58] z  :  state
[elab ../spec/5-reduction.watsup:124.60-124.61] x  :  tableidx
[notation ../spec/5-reduction.watsup:126.3-126.75] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})} ~> epsilon  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  config
[elab ../spec/5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  config
[notation ../spec/5-reduction.watsup:126.3-126.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:126.3-126.4] z  :  state
[elab ../spec/5-reduction.watsup:126.3-126.4] z  :  state
[notation ../spec/5-reduction.watsup:126.6-126.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:126.6-126.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.6-126.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.6-126.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:126.7-126.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:126.7-126.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:126.7-126.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:126.13-126.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:126.13-126.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:126.13-126.16] {}  :  {}
[notation ../spec/5-reduction.watsup:126.7-126.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:126.17-126.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:126.17-126.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:126.7-126.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:126.6-126.64] ({CONST I32 i}) ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.20-126.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.20-126.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:126.21-126.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:126.21-126.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:126.21-126.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:126.27-126.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:126.27-126.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:126.27-126.30] {}  :  {}
[notation ../spec/5-reduction.watsup:126.21-126.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:126.31-126.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:126.31-126.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:126.21-126.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:126.6-126.64] ({CONST I32 0}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.34-126.47] ({CONST I32 0})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.34-126.47] ({CONST I32 0})  :  admininstr
[notation ../spec/5-reduction.watsup:126.35-126.46] {CONST I32 0}  :  admininstr
[elab ../spec/5-reduction.watsup:126.35-126.46] {CONST I32 0}  :  admininstr
[notation ../spec/5-reduction.watsup:126.35-126.46] {I32 0}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:126.41-126.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:126.41-126.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:126.41-126.44] {}  :  {}
[notation ../spec/5-reduction.watsup:126.35-126.46] {0}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:126.45-126.46] 0  :  c_numtype
[elab ../spec/5-reduction.watsup:126.45-126.46] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:126.35-126.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:126.6-126.64] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.48-126.64] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:126.48-126.64] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:126.49-126.63] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:126.49-126.63] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:126.49-126.63] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:126.60-126.61] x  :  tableidx
[elab ../spec/5-reduction.watsup:126.60-126.61] x  :  tableidx
[notation ../spec/5-reduction.watsup:126.49-126.63] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:126.62-126.63] y  :  tableidx
[elab ../spec/5-reduction.watsup:126.62-126.63] y  :  tableidx
[notation ../spec/5-reduction.watsup:126.49-126.63] {}  :  {}
[niteration ../spec/5-reduction.watsup:126.6-126.64]   :  admininstr*
[notation ../spec/5-reduction.watsup:126.68-126.75] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:126.68-126.75]   :  admininstr*
[notation ../spec/5-reduction.watsup:129.3-131.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[elab ../spec/5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[notation ../spec/5-reduction.watsup:129.3-129.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:129.3-129.4] z  :  state
[elab ../spec/5-reduction.watsup:129.3-129.4] z  :  state
[notation ../spec/5-reduction.watsup:129.6-129.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:129.6-129.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.6-129.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.6-129.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:129.7-129.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:129.7-129.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:129.7-129.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:129.13-129.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:129.13-129.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:129.13-129.16] {}  :  {}
[notation ../spec/5-reduction.watsup:129.7-129.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:129.17-129.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:129.17-129.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:129.7-129.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:129.6-129.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.20-129.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.20-129.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:129.21-129.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:129.21-129.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:129.21-129.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:129.27-129.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:129.27-129.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:129.27-129.30] {}  :  {}
[notation ../spec/5-reduction.watsup:129.21-129.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:129.31-129.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:129.31-129.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:129.21-129.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:129.6-129.69] ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.34-129.52] ({CONST I32 n + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.34-129.52] ({CONST I32 n + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:129.35-129.51] {CONST I32 n + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:129.35-129.51] {CONST I32 n + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:129.35-129.51] {I32 n + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:129.41-129.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:129.41-129.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:129.41-129.44] {}  :  {}
[notation ../spec/5-reduction.watsup:129.35-129.51] {n + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:129.45-129.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:129.45-129.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:129.47-129.48] n  :  nat
[elab ../spec/5-reduction.watsup:129.49-129.50] 1  :  nat
[notation ../spec/5-reduction.watsup:129.35-129.51] {}  :  {}
[niteration ../spec/5-reduction.watsup:129.6-129.69] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.53-129.69] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:129.53-129.69] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:129.54-129.68] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:129.54-129.68] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:129.54-129.68] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:129.65-129.66] x  :  tableidx
[elab ../spec/5-reduction.watsup:129.65-129.66] x  :  tableidx
[notation ../spec/5-reduction.watsup:129.54-129.68] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:129.67-129.68] y  :  tableidx
[elab ../spec/5-reduction.watsup:129.67-129.68] y  :  tableidx
[notation ../spec/5-reduction.watsup:129.54-129.68] {}  :  {}
[niteration ../spec/5-reduction.watsup:129.6-129.69]   :  admininstr*
[notation ../spec/5-reduction.watsup:130.6-131.74] {({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({CONST I32 j}) ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.6-130.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.6-130.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:130.7-130.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:130.7-130.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:130.7-130.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:130.13-130.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:130.13-130.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:130.13-130.16] {}  :  {}
[notation ../spec/5-reduction.watsup:130.7-130.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:130.17-130.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:130.17-130.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:130.7-130.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({CONST I32 i}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.20-130.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.20-130.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:130.21-130.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:130.21-130.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:130.21-130.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:130.27-130.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:130.27-130.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:130.27-130.30] {}  :  {}
[notation ../spec/5-reduction.watsup:130.21-130.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:130.31-130.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:130.31-130.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:130.21-130.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.34-130.47] ({TABLE.GET y})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.34-130.47] ({TABLE.GET y})  :  admininstr
[notation ../spec/5-reduction.watsup:130.35-130.46] {TABLE.GET y}  :  admininstr
[elab ../spec/5-reduction.watsup:130.35-130.46] {TABLE.GET y}  :  admininstr
[notation ../spec/5-reduction.watsup:130.35-130.46] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:130.45-130.46] y  :  tableidx
[elab ../spec/5-reduction.watsup:130.45-130.46] y  :  tableidx
[notation ../spec/5-reduction.watsup:130.35-130.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.48-130.61] ({TABLE.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:130.48-130.61] ({TABLE.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:130.49-130.60] {TABLE.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:130.49-130.60] {TABLE.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:130.49-130.60] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:130.59-130.60] x  :  tableidx
[elab ../spec/5-reduction.watsup:130.59-130.60] x  :  tableidx
[notation ../spec/5-reduction.watsup:130.49-130.60] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.6-131.24] ({CONST I32 j + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.6-131.24] ({CONST I32 j + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:131.7-131.23] {CONST I32 j + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:131.7-131.23] {CONST I32 j + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:131.7-131.23] {I32 j + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:131.13-131.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:131.13-131.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:131.13-131.16] {}  :  {}
[notation ../spec/5-reduction.watsup:131.7-131.23] {j + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:131.17-131.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:131.17-131.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:131.19-131.20] j  :  nat
[elab ../spec/5-reduction.watsup:131.21-131.22] 1  :  nat
[notation ../spec/5-reduction.watsup:131.7-131.23] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.25-131.43] ({CONST I32 i + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.25-131.43] ({CONST I32 i + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:131.26-131.42] {CONST I32 i + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:131.26-131.42] {CONST I32 i + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:131.26-131.42] {I32 i + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:131.32-131.35] I32  :  numtype
[elab ../spec/5-reduction.watsup:131.32-131.35] I32  :  numtype
[notation ../spec/5-reduction.watsup:131.32-131.35] {}  :  {}
[notation ../spec/5-reduction.watsup:131.26-131.42] {i + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:131.36-131.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:131.36-131.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:131.38-131.39] i  :  nat
[elab ../spec/5-reduction.watsup:131.40-131.41] 1  :  nat
[notation ../spec/5-reduction.watsup:131.26-131.42] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.44-131.57] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.44-131.57] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:131.45-131.56] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:131.45-131.56] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:131.45-131.56] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:131.51-131.54] I32  :  numtype
[elab ../spec/5-reduction.watsup:131.51-131.54] I32  :  numtype
[notation ../spec/5-reduction.watsup:131.51-131.54] {}  :  {}
[notation ../spec/5-reduction.watsup:131.45-131.56] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:131.55-131.56] n  :  c_numtype
[elab ../spec/5-reduction.watsup:131.55-131.56] n  :  c_numtype
[notation ../spec/5-reduction.watsup:131.45-131.56] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.58-131.74] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:131.58-131.74] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:131.59-131.73] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:131.59-131.73] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:131.59-131.73] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:131.70-131.71] x  :  tableidx
[elab ../spec/5-reduction.watsup:131.70-131.71] x  :  tableidx
[notation ../spec/5-reduction.watsup:131.59-131.73] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:131.72-131.73] y  :  tableidx
[elab ../spec/5-reduction.watsup:131.72-131.73] y  :  tableidx
[notation ../spec/5-reduction.watsup:131.59-131.73] {}  :  {}
[niteration ../spec/5-reduction.watsup:130.6-131.74]   :  admininstr*
[elab ../spec/5-reduction.watsup:133.9-133.15] j <= i  :  bool
[elab ../spec/5-reduction.watsup:133.9-133.10] j  :  nat
[elab ../spec/5-reduction.watsup:133.14-133.15] i  :  nat
[notation ../spec/5-reduction.watsup:135.3-137.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})} ~> {({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[elab ../spec/5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  config
[notation ../spec/5-reduction.watsup:135.3-135.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:135.3-135.4] z  :  state
[elab ../spec/5-reduction.watsup:135.3-135.4] z  :  state
[notation ../spec/5-reduction.watsup:135.6-135.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:135.6-135.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.6-135.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.6-135.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:135.7-135.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:135.7-135.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:135.7-135.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:135.13-135.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:135.13-135.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:135.13-135.16] {}  :  {}
[notation ../spec/5-reduction.watsup:135.7-135.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:135.17-135.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:135.17-135.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:135.7-135.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:135.6-135.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.20-135.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.20-135.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:135.21-135.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:135.21-135.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:135.21-135.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:135.27-135.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:135.27-135.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:135.27-135.30] {}  :  {}
[notation ../spec/5-reduction.watsup:135.21-135.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:135.31-135.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:135.31-135.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:135.21-135.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:135.6-135.69] ({CONST I32 n + 1}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.34-135.52] ({CONST I32 n + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.34-135.52] ({CONST I32 n + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:135.35-135.51] {CONST I32 n + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:135.35-135.51] {CONST I32 n + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:135.35-135.51] {I32 n + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:135.41-135.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:135.41-135.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:135.41-135.44] {}  :  {}
[notation ../spec/5-reduction.watsup:135.35-135.51] {n + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:135.45-135.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:135.45-135.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:135.47-135.48] n  :  nat
[elab ../spec/5-reduction.watsup:135.49-135.50] 1  :  nat
[notation ../spec/5-reduction.watsup:135.35-135.51] {}  :  {}
[niteration ../spec/5-reduction.watsup:135.6-135.69] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.53-135.69] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:135.53-135.69] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:135.54-135.68] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:135.54-135.68] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:135.54-135.68] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:135.65-135.66] x  :  tableidx
[elab ../spec/5-reduction.watsup:135.65-135.66] x  :  tableidx
[notation ../spec/5-reduction.watsup:135.54-135.68] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:135.67-135.68] y  :  tableidx
[elab ../spec/5-reduction.watsup:135.67-135.68] y  :  tableidx
[notation ../spec/5-reduction.watsup:135.54-135.68] {}  :  {}
[niteration ../spec/5-reduction.watsup:135.6-135.69]   :  admininstr*
[notation ../spec/5-reduction.watsup:136.6-137.74] {({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({CONST I32 j + n}) ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.6-136.24] ({CONST I32 j + n})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.6-136.24] ({CONST I32 j + n})  :  admininstr
[notation ../spec/5-reduction.watsup:136.7-136.23] {CONST I32 j + n}  :  admininstr
[elab ../spec/5-reduction.watsup:136.7-136.23] {CONST I32 j + n}  :  admininstr
[notation ../spec/5-reduction.watsup:136.7-136.23] {I32 j + n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:136.13-136.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:136.13-136.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:136.13-136.16] {}  :  {}
[notation ../spec/5-reduction.watsup:136.7-136.23] {j + n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:136.17-136.23] j + n  :  c_numtype
[elab ../spec/5-reduction.watsup:136.17-136.23] j + n  :  c_numtype
[elab ../spec/5-reduction.watsup:136.19-136.20] j  :  nat
[elab ../spec/5-reduction.watsup:136.21-136.22] n  :  nat
[notation ../spec/5-reduction.watsup:136.7-136.23] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({CONST I32 i + n}) ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.25-136.43] ({CONST I32 i + n})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.25-136.43] ({CONST I32 i + n})  :  admininstr
[notation ../spec/5-reduction.watsup:136.26-136.42] {CONST I32 i + n}  :  admininstr
[elab ../spec/5-reduction.watsup:136.26-136.42] {CONST I32 i + n}  :  admininstr
[notation ../spec/5-reduction.watsup:136.26-136.42] {I32 i + n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:136.32-136.35] I32  :  numtype
[elab ../spec/5-reduction.watsup:136.32-136.35] I32  :  numtype
[notation ../spec/5-reduction.watsup:136.32-136.35] {}  :  {}
[notation ../spec/5-reduction.watsup:136.26-136.42] {i + n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:136.36-136.42] i + n  :  c_numtype
[elab ../spec/5-reduction.watsup:136.36-136.42] i + n  :  c_numtype
[elab ../spec/5-reduction.watsup:136.38-136.39] i  :  nat
[elab ../spec/5-reduction.watsup:136.40-136.41] n  :  nat
[notation ../spec/5-reduction.watsup:136.26-136.42] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({TABLE.GET y}) ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.44-136.57] ({TABLE.GET y})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.44-136.57] ({TABLE.GET y})  :  admininstr
[notation ../spec/5-reduction.watsup:136.45-136.56] {TABLE.GET y}  :  admininstr
[elab ../spec/5-reduction.watsup:136.45-136.56] {TABLE.GET y}  :  admininstr
[notation ../spec/5-reduction.watsup:136.45-136.56] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:136.55-136.56] y  :  tableidx
[elab ../spec/5-reduction.watsup:136.55-136.56] y  :  tableidx
[notation ../spec/5-reduction.watsup:136.45-136.56] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.58-136.71] ({TABLE.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:136.58-136.71] ({TABLE.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:136.59-136.70] {TABLE.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:136.59-136.70] {TABLE.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:136.59-136.70] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:136.69-136.70] x  :  tableidx
[elab ../spec/5-reduction.watsup:136.69-136.70] x  :  tableidx
[notation ../spec/5-reduction.watsup:136.59-136.70] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.6-137.24] ({CONST I32 j + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.6-137.24] ({CONST I32 j + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:137.7-137.23] {CONST I32 j + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:137.7-137.23] {CONST I32 j + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:137.7-137.23] {I32 j + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:137.13-137.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:137.13-137.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:137.13-137.16] {}  :  {}
[notation ../spec/5-reduction.watsup:137.7-137.23] {j + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:137.17-137.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:137.17-137.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:137.19-137.20] j  :  nat
[elab ../spec/5-reduction.watsup:137.21-137.22] 1  :  nat
[notation ../spec/5-reduction.watsup:137.7-137.23] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.25-137.43] ({CONST I32 i + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.25-137.43] ({CONST I32 i + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:137.26-137.42] {CONST I32 i + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:137.26-137.42] {CONST I32 i + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:137.26-137.42] {I32 i + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:137.32-137.35] I32  :  numtype
[elab ../spec/5-reduction.watsup:137.32-137.35] I32  :  numtype
[notation ../spec/5-reduction.watsup:137.32-137.35] {}  :  {}
[notation ../spec/5-reduction.watsup:137.26-137.42] {i + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:137.36-137.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:137.36-137.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:137.38-137.39] i  :  nat
[elab ../spec/5-reduction.watsup:137.40-137.41] 1  :  nat
[notation ../spec/5-reduction.watsup:137.26-137.42] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({CONST I32 n}) ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.44-137.57] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.44-137.57] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:137.45-137.56] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:137.45-137.56] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:137.45-137.56] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:137.51-137.54] I32  :  numtype
[elab ../spec/5-reduction.watsup:137.51-137.54] I32  :  numtype
[notation ../spec/5-reduction.watsup:137.51-137.54] {}  :  {}
[notation ../spec/5-reduction.watsup:137.45-137.56] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:137.55-137.56] n  :  c_numtype
[elab ../spec/5-reduction.watsup:137.55-137.56] n  :  c_numtype
[notation ../spec/5-reduction.watsup:137.45-137.56] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.58-137.74] ({TABLE.COPY x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:137.58-137.74] ({TABLE.COPY x y})  :  admininstr
[notation ../spec/5-reduction.watsup:137.59-137.73] {TABLE.COPY x y}  :  admininstr
[elab ../spec/5-reduction.watsup:137.59-137.73] {TABLE.COPY x y}  :  admininstr
[notation ../spec/5-reduction.watsup:137.59-137.73] {x y}  :  {tableidx tableidx}
[notation ../spec/5-reduction.watsup:137.70-137.71] x  :  tableidx
[elab ../spec/5-reduction.watsup:137.70-137.71] x  :  tableidx
[notation ../spec/5-reduction.watsup:137.59-137.73] {y}  :  {tableidx}
[notation ../spec/5-reduction.watsup:137.72-137.73] y  :  tableidx
[elab ../spec/5-reduction.watsup:137.72-137.73] y  :  tableidx
[notation ../spec/5-reduction.watsup:137.59-137.73] {}  :  {}
[niteration ../spec/5-reduction.watsup:136.6-137.74]   :  admininstr*
[elab ../spec/5-reduction.watsup:139.9-139.14] j > i  :  bool
[elab ../spec/5-reduction.watsup:139.9-139.10] j  :  nat
[elab ../spec/5-reduction.watsup:139.13-139.14] i  :  nat
[notation ../spec/5-reduction.watsup:142.3-142.72] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})} ~> TRAP  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config
[elab ../spec/5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config
[notation ../spec/5-reduction.watsup:142.3-142.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:142.3-142.4] z  :  state
[elab ../spec/5-reduction.watsup:142.3-142.4] z  :  state
[notation ../spec/5-reduction.watsup:142.6-142.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:142.6-142.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.6-142.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.6-142.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:142.7-142.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:142.7-142.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:142.7-142.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:142.13-142.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:142.13-142.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:142.13-142.16] {}  :  {}
[notation ../spec/5-reduction.watsup:142.7-142.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:142.17-142.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:142.17-142.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:142.7-142.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:142.6-142.64] ({CONST I32 i}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.20-142.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.20-142.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:142.21-142.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:142.21-142.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:142.21-142.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:142.27-142.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:142.27-142.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:142.27-142.30] {}  :  {}
[notation ../spec/5-reduction.watsup:142.21-142.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:142.31-142.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:142.31-142.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:142.21-142.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:142.6-142.64] ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.34-142.47] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.34-142.47] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:142.35-142.46] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:142.35-142.46] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:142.35-142.46] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:142.41-142.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:142.41-142.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:142.41-142.44] {}  :  {}
[notation ../spec/5-reduction.watsup:142.35-142.46] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:142.45-142.46] n  :  c_numtype
[elab ../spec/5-reduction.watsup:142.45-142.46] n  :  c_numtype
[notation ../spec/5-reduction.watsup:142.35-142.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:142.6-142.64] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.48-142.64] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:142.48-142.64] ({TABLE.INIT x y})  :  admininstr
[notation ../spec/5-reduction.watsup:142.49-142.63] {TABLE.INIT x y}  :  admininstr
[elab ../spec/5-reduction.watsup:142.49-142.63] {TABLE.INIT x y}  :  admininstr
[notation ../spec/5-reduction.watsup:142.49-142.63] {x y}  :  {tableidx elemidx}
[notation ../spec/5-reduction.watsup:142.60-142.61] x  :  tableidx
[elab ../spec/5-reduction.watsup:142.60-142.61] x  :  tableidx
[notation ../spec/5-reduction.watsup:142.49-142.63] {y}  :  {elemidx}
[notation ../spec/5-reduction.watsup:142.62-142.63] y  :  elemidx
[elab ../spec/5-reduction.watsup:142.62-142.63] y  :  elemidx
[notation ../spec/5-reduction.watsup:142.49-142.63] {}  :  {}
[niteration ../spec/5-reduction.watsup:142.6-142.64]   :  admininstr*
[notation ../spec/5-reduction.watsup:142.68-142.72] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:142.68-142.72] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:142.68-142.72] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:142.68-142.72] {}  :  {}
[elab ../spec/5-reduction.watsup:143.9-143.62] i + n > |$elem(z, y)| \/ j + n > |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:143.9-143.33] i + n > |$elem(z, y)|  :  bool
[elab ../spec/5-reduction.watsup:143.9-143.17] i + n  :  nat
[elab ../spec/5-reduction.watsup:143.11-143.12] i  :  nat
[elab ../spec/5-reduction.watsup:143.15-143.16] n  :  nat
[elab ../spec/5-reduction.watsup:143.20-143.33] |$elem(z, y)|  :  nat
[elab ../spec/5-reduction.watsup:143.21-143.32] $elem(z, y)  :  eleminst
[elab ../spec/5-reduction.watsup:143.26-143.32] (z, y)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:143.27-143.28] z  :  state
[elab ../spec/5-reduction.watsup:143.30-143.31] y  :  tableidx
[elab ../spec/5-reduction.watsup:143.37-143.62] j + n > |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:143.37-143.45] j + n  :  nat
[elab ../spec/5-reduction.watsup:143.39-143.40] j  :  nat
[elab ../spec/5-reduction.watsup:143.43-143.44] n  :  nat
[elab ../spec/5-reduction.watsup:143.48-143.62] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:143.49-143.61] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:143.55-143.61] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:143.56-143.57] z  :  state
[elab ../spec/5-reduction.watsup:143.59-143.60] x  :  tableidx
[notation ../spec/5-reduction.watsup:145.3-145.75] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})} ~> epsilon  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  config
[elab ../spec/5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  config
[notation ../spec/5-reduction.watsup:145.3-145.64] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:145.3-145.4] z  :  state
[elab ../spec/5-reduction.watsup:145.3-145.4] z  :  state
[notation ../spec/5-reduction.watsup:145.6-145.64] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:145.6-145.64] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.6-145.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.6-145.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:145.7-145.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:145.7-145.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:145.7-145.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:145.13-145.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:145.13-145.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:145.13-145.16] {}  :  {}
[notation ../spec/5-reduction.watsup:145.7-145.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:145.17-145.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:145.17-145.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:145.7-145.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:145.6-145.64] ({CONST I32 i}) ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.20-145.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.20-145.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:145.21-145.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:145.21-145.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:145.21-145.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:145.27-145.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:145.27-145.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:145.27-145.30] {}  :  {}
[notation ../spec/5-reduction.watsup:145.21-145.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:145.31-145.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:145.31-145.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:145.21-145.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:145.6-145.64] ({CONST I32 0}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.34-145.47] ({CONST I32 0})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.34-145.47] ({CONST I32 0})  :  admininstr
[notation ../spec/5-reduction.watsup:145.35-145.46] {CONST I32 0}  :  admininstr
[elab ../spec/5-reduction.watsup:145.35-145.46] {CONST I32 0}  :  admininstr
[notation ../spec/5-reduction.watsup:145.35-145.46] {I32 0}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:145.41-145.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:145.41-145.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:145.41-145.44] {}  :  {}
[notation ../spec/5-reduction.watsup:145.35-145.46] {0}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:145.45-145.46] 0  :  c_numtype
[elab ../spec/5-reduction.watsup:145.45-145.46] 0  :  c_numtype
[notation ../spec/5-reduction.watsup:145.35-145.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:145.6-145.64] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.48-145.64] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:145.48-145.64] ({TABLE.INIT x y})  :  admininstr
[notation ../spec/5-reduction.watsup:145.49-145.63] {TABLE.INIT x y}  :  admininstr
[elab ../spec/5-reduction.watsup:145.49-145.63] {TABLE.INIT x y}  :  admininstr
[notation ../spec/5-reduction.watsup:145.49-145.63] {x y}  :  {tableidx elemidx}
[notation ../spec/5-reduction.watsup:145.60-145.61] x  :  tableidx
[elab ../spec/5-reduction.watsup:145.60-145.61] x  :  tableidx
[notation ../spec/5-reduction.watsup:145.49-145.63] {y}  :  {elemidx}
[notation ../spec/5-reduction.watsup:145.62-145.63] y  :  elemidx
[elab ../spec/5-reduction.watsup:145.62-145.63] y  :  elemidx
[notation ../spec/5-reduction.watsup:145.49-145.63] {}  :  {}
[niteration ../spec/5-reduction.watsup:145.6-145.64]   :  admininstr*
[notation ../spec/5-reduction.watsup:145.68-145.75] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:145.68-145.75]   :  admininstr*
[notation ../spec/5-reduction.watsup:148.3-150.74] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})} ~> {({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  config
[elab ../spec/5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  config
[notation ../spec/5-reduction.watsup:148.3-148.69] z ; {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:148.3-148.4] z  :  state
[elab ../spec/5-reduction.watsup:148.3-148.4] z  :  state
[notation ../spec/5-reduction.watsup:148.6-148.69] {({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:148.6-148.69] ({CONST I32 j}) ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.6-148.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.6-148.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:148.7-148.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:148.7-148.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:148.7-148.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:148.13-148.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:148.13-148.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:148.13-148.16] {}  :  {}
[notation ../spec/5-reduction.watsup:148.7-148.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:148.17-148.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:148.17-148.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:148.7-148.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:148.6-148.69] ({CONST I32 i}) ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.20-148.33] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.20-148.33] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:148.21-148.32] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:148.21-148.32] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:148.21-148.32] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:148.27-148.30] I32  :  numtype
[elab ../spec/5-reduction.watsup:148.27-148.30] I32  :  numtype
[notation ../spec/5-reduction.watsup:148.27-148.30] {}  :  {}
[notation ../spec/5-reduction.watsup:148.21-148.32] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:148.31-148.32] i  :  c_numtype
[elab ../spec/5-reduction.watsup:148.31-148.32] i  :  c_numtype
[notation ../spec/5-reduction.watsup:148.21-148.32] {}  :  {}
[niteration ../spec/5-reduction.watsup:148.6-148.69] ({CONST I32 n + 1}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.34-148.52] ({CONST I32 n + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.34-148.52] ({CONST I32 n + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:148.35-148.51] {CONST I32 n + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:148.35-148.51] {CONST I32 n + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:148.35-148.51] {I32 n + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:148.41-148.44] I32  :  numtype
[elab ../spec/5-reduction.watsup:148.41-148.44] I32  :  numtype
[notation ../spec/5-reduction.watsup:148.41-148.44] {}  :  {}
[notation ../spec/5-reduction.watsup:148.35-148.51] {n + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:148.45-148.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:148.45-148.51] n + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:148.47-148.48] n  :  nat
[elab ../spec/5-reduction.watsup:148.49-148.50] 1  :  nat
[notation ../spec/5-reduction.watsup:148.35-148.51] {}  :  {}
[niteration ../spec/5-reduction.watsup:148.6-148.69] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.53-148.69] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:148.53-148.69] ({TABLE.INIT x y})  :  admininstr
[notation ../spec/5-reduction.watsup:148.54-148.68] {TABLE.INIT x y}  :  admininstr
[elab ../spec/5-reduction.watsup:148.54-148.68] {TABLE.INIT x y}  :  admininstr
[notation ../spec/5-reduction.watsup:148.54-148.68] {x y}  :  {tableidx elemidx}
[notation ../spec/5-reduction.watsup:148.65-148.66] x  :  tableidx
[elab ../spec/5-reduction.watsup:148.65-148.66] x  :  tableidx
[notation ../spec/5-reduction.watsup:148.54-148.68] {y}  :  {elemidx}
[notation ../spec/5-reduction.watsup:148.67-148.68] y  :  elemidx
[elab ../spec/5-reduction.watsup:148.67-148.68] y  :  elemidx
[notation ../spec/5-reduction.watsup:148.54-148.68] {}  :  {}
[niteration ../spec/5-reduction.watsup:148.6-148.69]   :  admininstr*
[notation ../spec/5-reduction.watsup:149.6-150.74] {({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({CONST I32 j}) $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:149.6-149.19] ({CONST I32 j})  :  admininstr*
[notation ../spec/5-reduction.watsup:149.6-149.19] ({CONST I32 j})  :  admininstr
[notation ../spec/5-reduction.watsup:149.7-149.18] {CONST I32 j}  :  admininstr
[elab ../spec/5-reduction.watsup:149.7-149.18] {CONST I32 j}  :  admininstr
[notation ../spec/5-reduction.watsup:149.7-149.18] {I32 j}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:149.13-149.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:149.13-149.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:149.13-149.16] {}  :  {}
[notation ../spec/5-reduction.watsup:149.7-149.18] {j}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:149.17-149.18] j  :  c_numtype
[elab ../spec/5-reduction.watsup:149.17-149.18] j  :  c_numtype
[notation ../spec/5-reduction.watsup:149.7-149.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74] $elem(z, y)[i] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr*
[notation ../spec/5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr
[elab ../spec/5-reduction.watsup:149.20-149.33] $elem(z, y)[i]  :  admininstr
[elab ../spec/5-reduction.watsup:149.20-149.30] $elem(z, y)  :  eleminst
[elab ../spec/5-reduction.watsup:149.25-149.30] (z, y)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:149.26-149.27] z  :  state
[elab ../spec/5-reduction.watsup:149.28-149.29] y  :  tableidx
[elab ../spec/5-reduction.watsup:149.31-149.32] i  :  nat
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({TABLE.SET x}) ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:149.34-149.47] ({TABLE.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:149.34-149.47] ({TABLE.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:149.35-149.46] {TABLE.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:149.35-149.46] {TABLE.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:149.35-149.46] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:149.45-149.46] x  :  tableidx
[elab ../spec/5-reduction.watsup:149.45-149.46] x  :  tableidx
[notation ../spec/5-reduction.watsup:149.35-149.46] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({CONST I32 j + 1}) ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.6-150.24] ({CONST I32 j + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.6-150.24] ({CONST I32 j + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:150.7-150.23] {CONST I32 j + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:150.7-150.23] {CONST I32 j + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:150.7-150.23] {I32 j + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:150.13-150.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:150.13-150.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:150.13-150.16] {}  :  {}
[notation ../spec/5-reduction.watsup:150.7-150.23] {j + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:150.17-150.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:150.17-150.23] j + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:150.19-150.20] j  :  nat
[elab ../spec/5-reduction.watsup:150.21-150.22] 1  :  nat
[notation ../spec/5-reduction.watsup:150.7-150.23] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({CONST I32 i + 1}) ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.25-150.43] ({CONST I32 i + 1})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.25-150.43] ({CONST I32 i + 1})  :  admininstr
[notation ../spec/5-reduction.watsup:150.26-150.42] {CONST I32 i + 1}  :  admininstr
[elab ../spec/5-reduction.watsup:150.26-150.42] {CONST I32 i + 1}  :  admininstr
[notation ../spec/5-reduction.watsup:150.26-150.42] {I32 i + 1}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:150.32-150.35] I32  :  numtype
[elab ../spec/5-reduction.watsup:150.32-150.35] I32  :  numtype
[notation ../spec/5-reduction.watsup:150.32-150.35] {}  :  {}
[notation ../spec/5-reduction.watsup:150.26-150.42] {i + 1}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:150.36-150.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:150.36-150.42] i + 1  :  c_numtype
[elab ../spec/5-reduction.watsup:150.38-150.39] i  :  nat
[elab ../spec/5-reduction.watsup:150.40-150.41] 1  :  nat
[notation ../spec/5-reduction.watsup:150.26-150.42] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({CONST I32 n}) ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.44-150.57] ({CONST I32 n})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.44-150.57] ({CONST I32 n})  :  admininstr
[notation ../spec/5-reduction.watsup:150.45-150.56] {CONST I32 n}  :  admininstr
[elab ../spec/5-reduction.watsup:150.45-150.56] {CONST I32 n}  :  admininstr
[notation ../spec/5-reduction.watsup:150.45-150.56] {I32 n}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:150.51-150.54] I32  :  numtype
[elab ../spec/5-reduction.watsup:150.51-150.54] I32  :  numtype
[notation ../spec/5-reduction.watsup:150.51-150.54] {}  :  {}
[notation ../spec/5-reduction.watsup:150.45-150.56] {n}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:150.55-150.56] n  :  c_numtype
[elab ../spec/5-reduction.watsup:150.55-150.56] n  :  c_numtype
[notation ../spec/5-reduction.watsup:150.45-150.56] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.58-150.74] ({TABLE.INIT x y})  :  admininstr*
[notation ../spec/5-reduction.watsup:150.58-150.74] ({TABLE.INIT x y})  :  admininstr
[notation ../spec/5-reduction.watsup:150.59-150.73] {TABLE.INIT x y}  :  admininstr
[elab ../spec/5-reduction.watsup:150.59-150.73] {TABLE.INIT x y}  :  admininstr
[notation ../spec/5-reduction.watsup:150.59-150.73] {x y}  :  {tableidx elemidx}
[notation ../spec/5-reduction.watsup:150.70-150.71] x  :  tableidx
[elab ../spec/5-reduction.watsup:150.70-150.71] x  :  tableidx
[notation ../spec/5-reduction.watsup:150.59-150.73] {y}  :  {elemidx}
[notation ../spec/5-reduction.watsup:150.72-150.73] y  :  elemidx
[elab ../spec/5-reduction.watsup:150.72-150.73] y  :  elemidx
[notation ../spec/5-reduction.watsup:150.59-150.73] {}  :  {}
[niteration ../spec/5-reduction.watsup:149.6-150.74]   :  admininstr*
[notation ../spec/5-reduction.watsup:154.3-154.47] z ; ({CALL x}) ~> ({CALL_ADDR $funcaddr(z)[x]})  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  config
[elab ../spec/5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  config
[notation ../spec/5-reduction.watsup:154.3-154.14] z ; ({CALL x})  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:154.3-154.4] z  :  state
[elab ../spec/5-reduction.watsup:154.3-154.4] z  :  state
[notation ../spec/5-reduction.watsup:154.6-154.14] ({CALL x})  :  admininstr*
[notation ../spec/5-reduction.watsup:154.7-154.13] {CALL x}  :  admininstr
[elab ../spec/5-reduction.watsup:154.7-154.13] {CALL x}  :  admininstr
[notation ../spec/5-reduction.watsup:154.7-154.13] {x}  :  {funcidx}
[notation ../spec/5-reduction.watsup:154.12-154.13] x  :  funcidx
[elab ../spec/5-reduction.watsup:154.12-154.13] x  :  funcidx
[notation ../spec/5-reduction.watsup:154.7-154.13] {}  :  {}
[notation ../spec/5-reduction.watsup:154.20-154.47] ({CALL_ADDR $funcaddr(z)[x]})  :  admininstr*
[notation ../spec/5-reduction.watsup:154.21-154.46] {CALL_ADDR $funcaddr(z)[x]}  :  admininstr
[elab ../spec/5-reduction.watsup:154.21-154.46] {CALL_ADDR $funcaddr(z)[x]}  :  admininstr
[notation ../spec/5-reduction.watsup:154.21-154.46] {$funcaddr(z)[x]}  :  {funcaddr}
[notation ../spec/5-reduction.watsup:154.31-154.46] $funcaddr(z)[x]  :  funcaddr
[elab ../spec/5-reduction.watsup:154.31-154.46] $funcaddr(z)[x]  :  funcaddr
[elab ../spec/5-reduction.watsup:154.31-154.43] $funcaddr(z)  :  funcaddr*
[elab ../spec/5-reduction.watsup:154.40-154.43] (z)  :  (state)
[elab ../spec/5-reduction.watsup:154.41-154.42] z  :  (state)
[elab ../spec/5-reduction.watsup:154.44-154.45] x  :  nat
[notation ../spec/5-reduction.watsup:154.21-154.46] {}  :  {}
[notation ../spec/5-reduction.watsup:157.3-157.59] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> ({CALL_ADDR a})  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[elab ../spec/5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[notation ../spec/5-reduction.watsup:157.3-157.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:157.3-157.4] z  :  state
[elab ../spec/5-reduction.watsup:157.3-157.4] z  :  state
[notation ../spec/5-reduction.watsup:157.6-157.40] {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:157.6-157.40] ({CONST I32 i}) ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:157.6-157.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:157.6-157.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:157.7-157.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:157.7-157.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:157.7-157.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:157.13-157.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:157.13-157.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:157.13-157.16] {}  :  {}
[notation ../spec/5-reduction.watsup:157.7-157.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:157.17-157.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:157.17-157.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:157.7-157.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:157.6-157.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:157.20-157.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:157.20-157.40] ({CALL_INDIRECT x ft})  :  admininstr
[notation ../spec/5-reduction.watsup:157.21-157.39] {CALL_INDIRECT x ft}  :  admininstr
[elab ../spec/5-reduction.watsup:157.21-157.39] {CALL_INDIRECT x ft}  :  admininstr
[notation ../spec/5-reduction.watsup:157.21-157.39] {x ft}  :  {tableidx functype}
[notation ../spec/5-reduction.watsup:157.35-157.36] x  :  tableidx
[elab ../spec/5-reduction.watsup:157.35-157.36] x  :  tableidx
[notation ../spec/5-reduction.watsup:157.21-157.39] {ft}  :  {functype}
[notation ../spec/5-reduction.watsup:157.37-157.39] ft  :  functype
[elab ../spec/5-reduction.watsup:157.37-157.39] ft  :  functype
[notation ../spec/5-reduction.watsup:157.21-157.39] {}  :  {}
[niteration ../spec/5-reduction.watsup:157.6-157.40]   :  admininstr*
[notation ../spec/5-reduction.watsup:157.46-157.59] ({CALL_ADDR a})  :  admininstr*
[notation ../spec/5-reduction.watsup:157.47-157.58] {CALL_ADDR a}  :  admininstr
[elab ../spec/5-reduction.watsup:157.47-157.58] {CALL_ADDR a}  :  admininstr
[notation ../spec/5-reduction.watsup:157.47-157.58] {a}  :  {funcaddr}
[notation ../spec/5-reduction.watsup:157.57-157.58] a  :  funcaddr
[elab ../spec/5-reduction.watsup:157.57-157.58] a  :  funcaddr
[notation ../spec/5-reduction.watsup:157.47-157.58] {}  :  {}
[elab ../spec/5-reduction.watsup:158.9-158.44] $table(z, x)[i] = ({REF.FUNC_ADDR a})  :  bool
[elab ../spec/5-reduction.watsup:158.9-158.24] $table(z, x)[i]  :  ref
[elab ../spec/5-reduction.watsup:158.9-158.21] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:158.15-158.21] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:158.16-158.17] z  :  state
[elab ../spec/5-reduction.watsup:158.19-158.20] x  :  tableidx
[elab ../spec/5-reduction.watsup:158.22-158.23] i  :  nat
[elab ../spec/5-reduction.watsup:158.27-158.44] ({REF.FUNC_ADDR a})  :  ref
[elab ../spec/5-reduction.watsup:158.28-158.43] {REF.FUNC_ADDR a}  :  ref
[notation ../spec/5-reduction.watsup:158.28-158.43] {a}  :  {funcaddr}
[notation ../spec/5-reduction.watsup:158.42-158.43] a  :  funcaddr
[elab ../spec/5-reduction.watsup:158.42-158.43] a  :  funcaddr
[notation ../spec/5-reduction.watsup:158.28-158.43] {}  :  {}
[elab ../spec/5-reduction.watsup:159.9-159.34] $funcinst(z)[a] = m ; func  :  bool
[elab ../spec/5-reduction.watsup:159.9-159.24] $funcinst(z)[a]  :  funcinst
[elab ../spec/5-reduction.watsup:159.9-159.21] $funcinst(z)  :  funcinst*
[elab ../spec/5-reduction.watsup:159.18-159.21] (z)  :  (state)
[elab ../spec/5-reduction.watsup:159.19-159.20] z  :  (state)
[elab ../spec/5-reduction.watsup:159.22-159.23] a  :  nat
[elab ../spec/5-reduction.watsup:159.27-159.34] m ; func  :  funcinst
[notation ../spec/5-reduction.watsup:159.27-159.34] m ; func  :  moduleinst ; func
[notation ../spec/5-reduction.watsup:159.27-159.28] m  :  moduleinst
[elab ../spec/5-reduction.watsup:159.27-159.28] m  :  moduleinst
[notation ../spec/5-reduction.watsup:159.30-159.34] func  :  func
[elab ../spec/5-reduction.watsup:159.30-159.34] func  :  func
[notation ../spec/5-reduction.watsup:162.3-162.50] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})} ~> TRAP  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[elab ../spec/5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  config
[notation ../spec/5-reduction.watsup:162.3-162.40] z ; {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:162.3-162.4] z  :  state
[elab ../spec/5-reduction.watsup:162.3-162.4] z  :  state
[notation ../spec/5-reduction.watsup:162.6-162.40] {({CONST I32 i}) ({CALL_INDIRECT x ft})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:162.6-162.40] ({CONST I32 i}) ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:162.6-162.19] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:162.6-162.19] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:162.7-162.18] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:162.7-162.18] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:162.7-162.18] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:162.13-162.16] I32  :  numtype
[elab ../spec/5-reduction.watsup:162.13-162.16] I32  :  numtype
[notation ../spec/5-reduction.watsup:162.13-162.16] {}  :  {}
[notation ../spec/5-reduction.watsup:162.7-162.18] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:162.17-162.18] i  :  c_numtype
[elab ../spec/5-reduction.watsup:162.17-162.18] i  :  c_numtype
[notation ../spec/5-reduction.watsup:162.7-162.18] {}  :  {}
[niteration ../spec/5-reduction.watsup:162.6-162.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:162.20-162.40] ({CALL_INDIRECT x ft})  :  admininstr*
[notation ../spec/5-reduction.watsup:162.20-162.40] ({CALL_INDIRECT x ft})  :  admininstr
[notation ../spec/5-reduction.watsup:162.21-162.39] {CALL_INDIRECT x ft}  :  admininstr
[elab ../spec/5-reduction.watsup:162.21-162.39] {CALL_INDIRECT x ft}  :  admininstr
[notation ../spec/5-reduction.watsup:162.21-162.39] {x ft}  :  {tableidx functype}
[notation ../spec/5-reduction.watsup:162.35-162.36] x  :  tableidx
[elab ../spec/5-reduction.watsup:162.35-162.36] x  :  tableidx
[notation ../spec/5-reduction.watsup:162.21-162.39] {ft}  :  {functype}
[notation ../spec/5-reduction.watsup:162.37-162.39] ft  :  functype
[elab ../spec/5-reduction.watsup:162.37-162.39] ft  :  functype
[notation ../spec/5-reduction.watsup:162.21-162.39] {}  :  {}
[niteration ../spec/5-reduction.watsup:162.6-162.40]   :  admininstr*
[notation ../spec/5-reduction.watsup:162.46-162.50] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:162.46-162.50] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:162.46-162.50] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:162.46-162.50] {}  :  {}
[notation ../spec/5-reduction.watsup:166.3-166.115] z ; {val^k ({CALL_ADDR a})} ~> ({FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})})  :  config ~> admininstr*
[notation ../spec/5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  config
[elab ../spec/5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  config
[notation ../spec/5-reduction.watsup:166.3-166.25] z ; {val^k ({CALL_ADDR a})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:166.3-166.4] z  :  state
[elab ../spec/5-reduction.watsup:166.3-166.4] z  :  state
[notation ../spec/5-reduction.watsup:166.6-166.25] {val^k ({CALL_ADDR a})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:166.6-166.25] val^k ({CALL_ADDR a})  :  admininstr*
[notation ../spec/5-reduction.watsup:166.6-166.11] val^k  :  admininstr*
[notation ../spec/5-reduction.watsup:166.6-166.9] val  :  admininstr
[elab ../spec/5-reduction.watsup:166.6-166.9] val  :  admininstr
[elab ../spec/5-reduction.watsup:166.10-166.11] k  :  nat
[niteration ../spec/5-reduction.watsup:166.6-166.25] ({CALL_ADDR a})  :  admininstr*
[notation ../spec/5-reduction.watsup:166.12-166.25] ({CALL_ADDR a})  :  admininstr*
[notation ../spec/5-reduction.watsup:166.12-166.25] ({CALL_ADDR a})  :  admininstr
[notation ../spec/5-reduction.watsup:166.13-166.24] {CALL_ADDR a}  :  admininstr
[elab ../spec/5-reduction.watsup:166.13-166.24] {CALL_ADDR a}  :  admininstr
[notation ../spec/5-reduction.watsup:166.13-166.24] {a}  :  {funcaddr}
[notation ../spec/5-reduction.watsup:166.23-166.24] a  :  funcaddr
[elab ../spec/5-reduction.watsup:166.23-166.24] a  :  funcaddr
[notation ../spec/5-reduction.watsup:166.13-166.24] {}  :  {}
[niteration ../spec/5-reduction.watsup:166.6-166.25]   :  admininstr*
[notation ../spec/5-reduction.watsup:166.31-166.115] ({FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})})  :  admininstr*
[notation ../spec/5-reduction.watsup:166.32-166.114] {FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  admininstr
[elab ../spec/5-reduction.watsup:166.32-166.114] {FRAME_ n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  admininstr
[notation ../spec/5-reduction.watsup:166.32-166.114] {n `{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  {n `{frame} admininstr*}
[notation ../spec/5-reduction.watsup:166.39-166.40] n  :  n
[elab ../spec/5-reduction.watsup:166.39-166.40] n  :  n
[notation ../spec/5-reduction.watsup:166.32-166.114] {`{{LOCAL {val^k ($default_(t))*}, MODULE m}} ({LABEL_ n `{epsilon} instr*})}  :  {`{frame} admininstr*}
[notation ../spec/5-reduction.watsup:166.41-166.85] `{{LOCAL {val^k ($default_(t))*}, MODULE m}}  :  `{frame}
[notation ../spec/5-reduction.watsup:166.44-166.83] {LOCAL {val^k ($default_(t))*}, MODULE m}  :  frame
[elab ../spec/5-reduction.watsup:166.44-166.83] {LOCAL {val^k ($default_(t))*}, MODULE m}  :  frame
[notation ../spec/5-reduction.watsup:166.51-166.72] {val^k ($default_(t))*}  :  val*
[niteration ../spec/5-reduction.watsup:166.51-166.72] val^k ($default_(t))*  :  val*
[notation ../spec/5-reduction.watsup:166.51-166.56] val^k  :  val*
[notation ../spec/5-reduction.watsup:166.51-166.54] val  :  val
[elab ../spec/5-reduction.watsup:166.51-166.54] val  :  val
[elab ../spec/5-reduction.watsup:166.55-166.56] k  :  nat
[niteration ../spec/5-reduction.watsup:166.51-166.72] ($default_(t))*  :  val*
[notation ../spec/5-reduction.watsup:166.57-166.72] ($default_(t))*  :  val*
[notation ../spec/5-reduction.watsup:166.57-166.71] ($default_(t))  :  val
[notation ../spec/5-reduction.watsup:166.58-166.70] $default_(t)  :  val
[elab ../spec/5-reduction.watsup:166.58-166.70] $default_(t)  :  val
[elab ../spec/5-reduction.watsup:166.67-166.70] (t)  :  (valtype)
[elab ../spec/5-reduction.watsup:166.68-166.69] t  :  (valtype)
[niteration ../spec/5-reduction.watsup:166.51-166.72]   :  val*
[notation ../spec/5-reduction.watsup:166.81-166.82] m  :  moduleinst
[elab ../spec/5-reduction.watsup:166.81-166.82] m  :  moduleinst
[notation ../spec/5-reduction.watsup:166.32-166.114] {({LABEL_ n `{epsilon} instr*})}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:166.32-166.114] {({LABEL_ n `{epsilon} instr*})}  :  admininstr*
[elab ../spec/5-reduction.watsup:166.86-166.114] ({LABEL_ n `{epsilon} instr*})  :  admininstr*
[elab ../spec/5-reduction.watsup:166.87-166.113] {LABEL_ n `{epsilon} instr*}  :  admininstr*
[notation ../spec/5-reduction.watsup:166.87-166.113] {n `{epsilon} instr*}  :  {n `{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:166.94-166.95] n  :  n
[elab ../spec/5-reduction.watsup:166.94-166.95] n  :  n
[notation ../spec/5-reduction.watsup:166.87-166.113] {`{epsilon} instr*}  :  {`{instr*} admininstr*}
[notation ../spec/5-reduction.watsup:166.96-166.106] `{epsilon}  :  `{instr*}
[notation ../spec/5-reduction.watsup:166.98-166.105] epsilon  :  instr*
[niteration ../spec/5-reduction.watsup:166.98-166.105]   :  instr*
[notation ../spec/5-reduction.watsup:166.87-166.113] {instr*}  :  {admininstr*}
[notation ../spec/5-reduction.watsup:166.87-166.113] {instr*}  :  admininstr*
[elab ../spec/5-reduction.watsup:166.107-166.113] instr*  :  admininstr*
[elab ../spec/5-reduction.watsup:166.107-166.112] instr  :  admininstr
[elab ../spec/5-reduction.watsup:167.9-167.61] $funcinst(z)[a] = m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  bool
[elab ../spec/5-reduction.watsup:167.9-167.24] $funcinst(z)[a]  :  funcinst
[elab ../spec/5-reduction.watsup:167.9-167.21] $funcinst(z)  :  funcinst*
[elab ../spec/5-reduction.watsup:167.18-167.21] (z)  :  (state)
[elab ../spec/5-reduction.watsup:167.19-167.20] z  :  (state)
[elab ../spec/5-reduction.watsup:167.22-167.23] a  :  nat
[elab ../spec/5-reduction.watsup:167.27-167.61] m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  funcinst
[notation ../spec/5-reduction.watsup:167.27-167.61] m ; {FUNC (t_1^k -> t_2^n) t* instr*}  :  moduleinst ; func
[notation ../spec/5-reduction.watsup:167.27-167.28] m  :  moduleinst
[elab ../spec/5-reduction.watsup:167.27-167.28] m  :  moduleinst
[notation ../spec/5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  func
[elab ../spec/5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  func
[notation ../spec/5-reduction.watsup:167.30-167.61] {FUNC (t_1^k -> t_2^n) t* instr*}  :  {FUNC functype valtype* expr}
[notation ../spec/5-reduction.watsup:167.30-167.34] FUNC  :  FUNC
[notation ../spec/5-reduction.watsup:167.30-167.61] {(t_1^k -> t_2^n) t* instr*}  :  {functype valtype* expr}
[notation ../spec/5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  functype
[elab ../spec/5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  functype
[notation ../spec/5-reduction.watsup:167.36-167.50] t_1^k -> t_2^n  :  resulttype -> resulttype
[notation ../spec/5-reduction.watsup:167.36-167.41] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:167.36-167.41] t_1^k  :  resulttype
[elab ../spec/5-reduction.watsup:167.36-167.39] t_1  :  valtype
[elab ../spec/5-reduction.watsup:167.40-167.41] k  :  nat
[notation ../spec/5-reduction.watsup:167.45-167.50] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:167.45-167.50] t_2^n  :  resulttype
[elab ../spec/5-reduction.watsup:167.45-167.48] t_2  :  valtype
[elab ../spec/5-reduction.watsup:167.49-167.50] n  :  nat
[notation ../spec/5-reduction.watsup:167.30-167.61] {t* instr*}  :  {valtype* expr}
[notation ../spec/5-reduction.watsup:167.52-167.54] t*  :  valtype*
[notation ../spec/5-reduction.watsup:167.52-167.53] t  :  valtype
[elab ../spec/5-reduction.watsup:167.52-167.53] t  :  valtype
[notation ../spec/5-reduction.watsup:167.30-167.61] {instr*}  :  {expr}
[notation ../spec/5-reduction.watsup:167.55-167.61] instr*  :  expr
[elab ../spec/5-reduction.watsup:167.55-167.61] instr*  :  expr
[elab ../spec/5-reduction.watsup:167.55-167.60] instr  :  instr
[notation ../spec/5-reduction.watsup:167.30-167.61] {}  :  {}
[elab ../spec/5-reduction.watsup:167.40-167.41] k  :  nat
[elab ../spec/5-reduction.watsup:167.49-167.50] n  :  nat
[elab ../spec/5-reduction.watsup:166.55-166.56] k  :  nat
[notation ../spec/5-reduction.watsup:170.3-170.60] z ; {val ({LOCAL.SET x})} ~> $with_local(z, x, val) ; epsilon  :  config ~> config
[notation ../spec/5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  config
[elab ../spec/5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  config
[notation ../spec/5-reduction.watsup:170.3-170.24] z ; {val ({LOCAL.SET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:170.3-170.4] z  :  state
[elab ../spec/5-reduction.watsup:170.3-170.4] z  :  state
[notation ../spec/5-reduction.watsup:170.7-170.24] {val ({LOCAL.SET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:170.7-170.24] val ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:170.7-170.10] val  :  admininstr*
[notation ../spec/5-reduction.watsup:170.7-170.10] val  :  admininstr
[elab ../spec/5-reduction.watsup:170.7-170.10] val  :  admininstr
[niteration ../spec/5-reduction.watsup:170.7-170.24] ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:170.11-170.24] ({LOCAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:170.11-170.24] ({LOCAL.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:170.12-170.23] {LOCAL.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:170.12-170.23] {LOCAL.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:170.12-170.23] {x}  :  {localidx}
[notation ../spec/5-reduction.watsup:170.22-170.23] x  :  localidx
[elab ../spec/5-reduction.watsup:170.22-170.23] x  :  localidx
[notation ../spec/5-reduction.watsup:170.12-170.23] {}  :  {}
[niteration ../spec/5-reduction.watsup:170.7-170.24]   :  admininstr*
[notation ../spec/5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  config
[elab ../spec/5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  config
[notation ../spec/5-reduction.watsup:170.28-170.60] $with_local(z, x, val) ; epsilon  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:170.28-170.50] $with_local(z, x, val)  :  state
[elab ../spec/5-reduction.watsup:170.28-170.50] $with_local(z, x, val)  :  state
[elab ../spec/5-reduction.watsup:170.39-170.50] (z, x, val)  :  (state, localidx, val)
[elab ../spec/5-reduction.watsup:170.40-170.41] z  :  state
[elab ../spec/5-reduction.watsup:170.43-170.44] x  :  localidx
[elab ../spec/5-reduction.watsup:170.46-170.49] val  :  val
[notation ../spec/5-reduction.watsup:170.53-170.60] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:170.53-170.60]   :  admininstr*
[notation ../spec/5-reduction.watsup:173.3-173.62] z ; {val ({GLOBAL.SET x})} ~> $with_global(z, x, val) ; epsilon  :  config ~> config
[notation ../spec/5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  config
[elab ../spec/5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  config
[notation ../spec/5-reduction.watsup:173.3-173.25] z ; {val ({GLOBAL.SET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:173.3-173.4] z  :  state
[elab ../spec/5-reduction.watsup:173.3-173.4] z  :  state
[notation ../spec/5-reduction.watsup:173.7-173.25] {val ({GLOBAL.SET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:173.7-173.25] val ({GLOBAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:173.7-173.10] val  :  admininstr*
[notation ../spec/5-reduction.watsup:173.7-173.10] val  :  admininstr
[elab ../spec/5-reduction.watsup:173.7-173.10] val  :  admininstr
[niteration ../spec/5-reduction.watsup:173.7-173.25] ({GLOBAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:173.11-173.25] ({GLOBAL.SET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:173.11-173.25] ({GLOBAL.SET x})  :  admininstr
[notation ../spec/5-reduction.watsup:173.12-173.24] {GLOBAL.SET x}  :  admininstr
[elab ../spec/5-reduction.watsup:173.12-173.24] {GLOBAL.SET x}  :  admininstr
[notation ../spec/5-reduction.watsup:173.12-173.24] {x}  :  {globalidx}
[notation ../spec/5-reduction.watsup:173.23-173.24] x  :  globalidx
[elab ../spec/5-reduction.watsup:173.23-173.24] x  :  globalidx
[notation ../spec/5-reduction.watsup:173.12-173.24] {}  :  {}
[niteration ../spec/5-reduction.watsup:173.7-173.25]   :  admininstr*
[notation ../spec/5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  config
[elab ../spec/5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  config
[notation ../spec/5-reduction.watsup:173.29-173.62] $with_global(z, x, val) ; epsilon  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:173.29-173.52] $with_global(z, x, val)  :  state
[elab ../spec/5-reduction.watsup:173.29-173.52] $with_global(z, x, val)  :  state
[elab ../spec/5-reduction.watsup:173.41-173.52] (z, x, val)  :  (state, globalidx, val)
[elab ../spec/5-reduction.watsup:173.42-173.43] z  :  state
[elab ../spec/5-reduction.watsup:173.45-173.46] x  :  globalidx
[elab ../spec/5-reduction.watsup:173.48-173.51] val  :  val
[notation ../spec/5-reduction.watsup:173.55-173.62] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:173.55-173.62]   :  admininstr*
[notation ../spec/5-reduction.watsup:176.3-176.77] z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> $with_table(z, x, i, ref) ; epsilon  :  config ~> config
[notation ../spec/5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[elab ../spec/5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[notation ../spec/5-reduction.watsup:176.3-176.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:176.3-176.4] z  :  state
[elab ../spec/5-reduction.watsup:176.3-176.4] z  :  state
[notation ../spec/5-reduction.watsup:176.7-176.38] {({CONST I32 i}) ref ({TABLE.GET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:176.7-176.38] ({CONST I32 i}) ref ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:176.7-176.20] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:176.7-176.20] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:176.8-176.19] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:176.8-176.19] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:176.8-176.19] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:176.14-176.17] I32  :  numtype
[elab ../spec/5-reduction.watsup:176.14-176.17] I32  :  numtype
[notation ../spec/5-reduction.watsup:176.14-176.17] {}  :  {}
[notation ../spec/5-reduction.watsup:176.8-176.19] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:176.18-176.19] i  :  c_numtype
[elab ../spec/5-reduction.watsup:176.18-176.19] i  :  c_numtype
[notation ../spec/5-reduction.watsup:176.8-176.19] {}  :  {}
[niteration ../spec/5-reduction.watsup:176.7-176.38] ref ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:176.21-176.24] ref  :  admininstr*
[notation ../spec/5-reduction.watsup:176.21-176.24] ref  :  admininstr
[elab ../spec/5-reduction.watsup:176.21-176.24] ref  :  admininstr
[niteration ../spec/5-reduction.watsup:176.7-176.38] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:176.25-176.38] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:176.25-176.38] ({TABLE.GET x})  :  admininstr
[notation ../spec/5-reduction.watsup:176.26-176.37] {TABLE.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:176.26-176.37] {TABLE.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:176.26-176.37] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:176.36-176.37] x  :  tableidx
[elab ../spec/5-reduction.watsup:176.36-176.37] x  :  tableidx
[notation ../spec/5-reduction.watsup:176.26-176.37] {}  :  {}
[niteration ../spec/5-reduction.watsup:176.7-176.38]   :  admininstr*
[notation ../spec/5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  config
[elab ../spec/5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  config
[notation ../spec/5-reduction.watsup:176.42-176.77] $with_table(z, x, i, ref) ; epsilon  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:176.42-176.67] $with_table(z, x, i, ref)  :  state
[elab ../spec/5-reduction.watsup:176.42-176.67] $with_table(z, x, i, ref)  :  state
[elab ../spec/5-reduction.watsup:176.53-176.67] (z, x, i, ref)  :  (state, tableidx, n, ref)
[elab ../spec/5-reduction.watsup:176.54-176.55] z  :  state
[elab ../spec/5-reduction.watsup:176.57-176.58] x  :  tableidx
[elab ../spec/5-reduction.watsup:176.60-176.61] i  :  n
[elab ../spec/5-reduction.watsup:176.63-176.66] ref  :  ref
[notation ../spec/5-reduction.watsup:176.70-176.77] epsilon  :  admininstr*
[niteration ../spec/5-reduction.watsup:176.70-176.77]   :  admininstr*
[elab ../spec/5-reduction.watsup:177.9-177.27] i < |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:177.9-177.10] i  :  nat
[elab ../spec/5-reduction.watsup:177.13-177.27] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:177.14-177.26] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:177.20-177.26] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:177.21-177.22] z  :  state
[elab ../spec/5-reduction.watsup:177.24-177.25] x  :  tableidx
[notation ../spec/5-reduction.watsup:180.3-180.49] z ; {({CONST I32 i}) ref ({TABLE.GET x})} ~> z ; TRAP  :  config ~> config
[notation ../spec/5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[elab ../spec/5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  config
[notation ../spec/5-reduction.watsup:180.3-180.38] z ; {({CONST I32 i}) ref ({TABLE.GET x})}  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:180.3-180.4] z  :  state
[elab ../spec/5-reduction.watsup:180.3-180.4] z  :  state
[notation ../spec/5-reduction.watsup:180.7-180.38] {({CONST I32 i}) ref ({TABLE.GET x})}  :  admininstr*
[niteration ../spec/5-reduction.watsup:180.7-180.38] ({CONST I32 i}) ref ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:180.7-180.20] ({CONST I32 i})  :  admininstr*
[notation ../spec/5-reduction.watsup:180.7-180.20] ({CONST I32 i})  :  admininstr
[notation ../spec/5-reduction.watsup:180.8-180.19] {CONST I32 i}  :  admininstr
[elab ../spec/5-reduction.watsup:180.8-180.19] {CONST I32 i}  :  admininstr
[notation ../spec/5-reduction.watsup:180.8-180.19] {I32 i}  :  {numtype c_numtype}
[notation ../spec/5-reduction.watsup:180.14-180.17] I32  :  numtype
[elab ../spec/5-reduction.watsup:180.14-180.17] I32  :  numtype
[notation ../spec/5-reduction.watsup:180.14-180.17] {}  :  {}
[notation ../spec/5-reduction.watsup:180.8-180.19] {i}  :  {c_numtype}
[notation ../spec/5-reduction.watsup:180.18-180.19] i  :  c_numtype
[elab ../spec/5-reduction.watsup:180.18-180.19] i  :  c_numtype
[notation ../spec/5-reduction.watsup:180.8-180.19] {}  :  {}
[niteration ../spec/5-reduction.watsup:180.7-180.38] ref ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:180.21-180.24] ref  :  admininstr*
[notation ../spec/5-reduction.watsup:180.21-180.24] ref  :  admininstr
[elab ../spec/5-reduction.watsup:180.21-180.24] ref  :  admininstr
[niteration ../spec/5-reduction.watsup:180.7-180.38] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:180.25-180.38] ({TABLE.GET x})  :  admininstr*
[notation ../spec/5-reduction.watsup:180.25-180.38] ({TABLE.GET x})  :  admininstr
[notation ../spec/5-reduction.watsup:180.26-180.37] {TABLE.GET x}  :  admininstr
[elab ../spec/5-reduction.watsup:180.26-180.37] {TABLE.GET x}  :  admininstr
[notation ../spec/5-reduction.watsup:180.26-180.37] {x}  :  {tableidx}
[notation ../spec/5-reduction.watsup:180.36-180.37] x  :  tableidx
[elab ../spec/5-reduction.watsup:180.36-180.37] x  :  tableidx
[notation ../spec/5-reduction.watsup:180.26-180.37] {}  :  {}
[niteration ../spec/5-reduction.watsup:180.7-180.38]   :  admininstr*
[notation ../spec/5-reduction.watsup:180.42-180.49] z ; TRAP  :  config
[elab ../spec/5-reduction.watsup:180.42-180.49] z ; TRAP  :  config
[notation ../spec/5-reduction.watsup:180.42-180.49] z ; TRAP  :  state ; admininstr*
[notation ../spec/5-reduction.watsup:180.42-180.43] z  :  state
[elab ../spec/5-reduction.watsup:180.42-180.43] z  :  state
[notation ../spec/5-reduction.watsup:180.45-180.49] TRAP  :  admininstr*
[notation ../spec/5-reduction.watsup:180.45-180.49] TRAP  :  admininstr
[elab ../spec/5-reduction.watsup:180.45-180.49] TRAP  :  admininstr
[notation ../spec/5-reduction.watsup:180.45-180.49] {}  :  {}
[elab ../spec/5-reduction.watsup:181.9-181.28] i >= |$table(z, x)|  :  bool
[elab ../spec/5-reduction.watsup:181.9-181.10] i  :  nat
[elab ../spec/5-reduction.watsup:181.14-181.28] |$table(z, x)|  :  nat
[elab ../spec/5-reduction.watsup:181.15-181.27] $table(z, x)  :  tableinst
[elab ../spec/5-reduction.watsup:181.21-181.27] (z, x)  :  (state, tableidx)
[elab ../spec/5-reduction.watsup:181.22-181.23] z  :  state
[elab ../spec/5-reduction.watsup:181.25-181.26] x  :  tableidx
== IL Validation...
== Latex Generation...
warning: syntax `E` was never spliced
warning: syntax `addr` was never spliced
warning: syntax `admininstr` was never spliced
warning: syntax `binop_FXX` was never spliced
warning: syntax `binop_IXX` was never spliced
warning: syntax `binop_numtype` was never spliced
warning: syntax `blocktype` was never spliced
warning: syntax `byte` was never spliced
warning: syntax `c_numtype` was never spliced
warning: syntax `c_vectype` was never spliced
warning: syntax `config` was never spliced
warning: syntax `context` was never spliced
warning: syntax `cvtop` was never spliced
warning: syntax `data` was never spliced
warning: syntax `dataaddr` was never spliced
warning: syntax `dataidx` was never spliced
warning: syntax `datainst` was never spliced
warning: syntax `datamode` was never spliced
warning: syntax `datatype` was never spliced
warning: syntax `elem` was never spliced
warning: syntax `elemaddr` was never spliced
warning: syntax `elemidx` was never spliced
warning: syntax `eleminst` was never spliced
warning: syntax `elemmode` was never spliced
warning: syntax `elemtype` was never spliced
warning: syntax `export` was never spliced
warning: syntax `exportinst` was never spliced
warning: syntax `externuse` was never spliced
warning: syntax `externval` was never spliced
warning: syntax `fn` was never spliced
warning: syntax `frame` was never spliced
warning: syntax `func` was never spliced
warning: syntax `funcaddr` was never spliced
warning: syntax `funcidx` was never spliced
warning: syntax `funcinst` was never spliced
warning: syntax `global` was never spliced
warning: syntax `globaladdr` was never spliced
warning: syntax `globalidx` was never spliced
warning: syntax `globalinst` was never spliced
warning: syntax `hostaddr` was never spliced
warning: syntax `idx` was never spliced
warning: syntax `import` was never spliced
warning: syntax `in` was never spliced
warning: syntax `labeladdr` was never spliced
warning: syntax `labelidx` was never spliced
warning: syntax `localidx` was never spliced
warning: syntax `mem` was never spliced
warning: syntax `memaddr` was never spliced
warning: syntax `memidx` was never spliced
warning: syntax `meminst` was never spliced
warning: syntax `module` was never spliced
warning: syntax `moduleinst` was never spliced
warning: syntax `n` was never spliced
warning: syntax `name` was never spliced
warning: syntax `num` was never spliced
warning: syntax `ref` was never spliced
warning: syntax `relop_FXX` was never spliced
warning: syntax `relop_IXX` was never spliced
warning: syntax `relop_numtype` was never spliced
warning: syntax `result` was never spliced
warning: syntax `start` was never spliced
warning: syntax `state` was never spliced
warning: syntax `store` was never spliced
warning: syntax `sx` was never spliced
warning: syntax `table` was never spliced
warning: syntax `tableaddr` was never spliced
warning: syntax `tableidx` was never spliced
warning: syntax `tableinst` was never spliced
warning: syntax `testop_FXX` was never spliced
warning: syntax `testop_IXX` was never spliced
warning: syntax `testop_numtype` was never spliced
warning: syntax `u32` was never spliced
warning: syntax `unop_FXX` was never spliced
warning: syntax `unop_IXX` was never spliced
warning: syntax `unop_numtype` was never spliced
warning: syntax `val` was never spliced
warning: rule `Blocktype_ok` was never spliced
warning: rule `Data_ok` was never spliced
warning: rule `Datamode_ok` was never spliced
warning: rule `Elem_ok` was never spliced
warning: rule `Elemmode_ok/active` was never spliced
warning: rule `Elemmode_ok/declare` was never spliced
warning: rule `Export_ok` was never spliced
warning: rule `Expr_const` was never spliced
warning: rule `Expr_ok` was never spliced
warning: rule `Expr_ok_const` was never spliced
warning: rule `Externtype_ok/func` was never spliced
warning: rule `Externtype_ok/global` was never spliced
warning: rule `Externtype_ok/table` was never spliced
warning: rule `Externtype_ok/mem` was never spliced
warning: rule `Externtype_sub/func` was never spliced
warning: rule `Externtype_sub/global` was never spliced
warning: rule `Externtype_sub/table` was never spliced
warning: rule `Externtype_sub/mem` was never spliced
warning: rule `Externuse_ok/func` was never spliced
warning: rule `Externuse_ok/global` was never spliced
warning: rule `Externuse_ok/table` was never spliced
warning: rule `Externuse_ok/mem` was never spliced
warning: rule `Func_ok` was never spliced
warning: rule `Functype_ok` was never spliced
warning: rule `Functype_sub` was never spliced
warning: rule `Global_ok` was never spliced
warning: rule `Globaltype_ok` was never spliced
warning: rule `Globaltype_sub` was never spliced
warning: rule `Import_ok` was never spliced
warning: rule `InstrSeq_ok/empty` was spliced more than once
warning: rule `InstrSeq_ok/frame` was spliced more than once
warning: rule `Instr_const/const` was never spliced
warning: rule `Instr_const/ref.null` was never spliced
warning: rule `Instr_const/ref.func` was never spliced
warning: rule `Instr_const/global.get` was never spliced
warning: rule `Instr_ok/select-expl` was never spliced
warning: rule `Instr_ok/select-impl` was never spliced
warning: rule `Instr_ok/br` was never spliced
warning: rule `Instr_ok/br_if` was never spliced
warning: rule `Instr_ok/br_table` was never spliced
warning: rule `Instr_ok/return` was never spliced
warning: rule `Instr_ok/call` was never spliced
warning: rule `Instr_ok/call_indirect` was never spliced
warning: rule `Instr_ok/const` was never spliced
warning: rule `Instr_ok/unop` was never spliced
warning: rule `Instr_ok/binop` was never spliced
warning: rule `Instr_ok/testop` was never spliced
warning: rule `Instr_ok/relop` was never spliced
warning: rule `Instr_ok/extend` was never spliced
warning: rule `Instr_ok/reinterpret` was never spliced
warning: rule `Instr_ok/convert-i` was never spliced
warning: rule `Instr_ok/convert-f` was never spliced
warning: rule `Instr_ok/ref.null` was never spliced
warning: rule `Instr_ok/ref.func` was never spliced
warning: rule `Instr_ok/ref.is_null` was never spliced
warning: rule `Instr_ok/local.get` was never spliced
warning: rule `Instr_ok/local.set` was never spliced
warning: rule `Instr_ok/local.tee` was never spliced
warning: rule `Instr_ok/global.get` was never spliced
warning: rule `Instr_ok/global.set` was never spliced
warning: rule `Instr_ok/table.get` was never spliced
warning: rule `Instr_ok/table.set` was never spliced
warning: rule `Instr_ok/table.size` was never spliced
warning: rule `Instr_ok/table.grow` was never spliced
warning: rule `Instr_ok/table.fill` was never spliced
warning: rule `Instr_ok/table.copy` was never spliced
warning: rule `Instr_ok/table.init` was never spliced
warning: rule `Instr_ok/elem.drop` was never spliced
warning: rule `Instr_ok/memory.size` was never spliced
warning: rule `Instr_ok/memory.grow` was never spliced
warning: rule `Instr_ok/memory.fill` was never spliced
warning: rule `Instr_ok/memory.copy` was never spliced
warning: rule `Instr_ok/memory.init` was never spliced
warning: rule `Instr_ok/data.drop` was never spliced
warning: rule `Instr_ok/load` was never spliced
warning: rule `Instr_ok/store` was never spliced
warning: rule `Limits_ok` was never spliced
warning: rule `Limits_sub` was never spliced
warning: rule `Mem_ok` was never spliced
warning: rule `Memtype_ok` was never spliced
warning: rule `Memtype_sub` was never spliced
warning: rule `Module_ok` was never spliced
warning: rule `Resulttype_sub` was never spliced
warning: rule `Start_ok` was never spliced
warning: rule `Step/write` was never spliced
warning: rule `Step_pure/ref.is_null-true` was never spliced
warning: rule `Step_pure/ref.is_null-false` was never spliced
warning: rule `Step_pure/unreachable` was never spliced
warning: rule `Step_pure/nop` was never spliced
warning: rule `Step_pure/drop` was never spliced
warning: rule `Step_pure/select-true` was never spliced
warning: rule `Step_pure/select-false` was never spliced
warning: rule `Step_pure/local.tee` was never spliced
warning: rule `Step_pure/if-true` was spliced more than once
warning: rule `Step_pure/if-false` was spliced more than once
warning: rule `Step_pure/br-zero` was never spliced
warning: rule `Step_pure/br-succ` was never spliced
warning: rule `Step_pure/br_if-true` was never spliced
warning: rule `Step_pure/br_if-false` was never spliced
warning: rule `Step_pure/br_table-lt` was never spliced
warning: rule `Step_pure/br_table-ge` was never spliced
warning: rule `Step_read/ref.func` was never spliced
warning: rule `Step_read/local.get` was never spliced
warning: rule `Step_read/global.get` was never spliced
warning: rule `Step_read/table.get-ge` was never spliced
warning: rule `Step_read/table.get-lt` was never spliced
warning: rule `Step_read/table.size` was never spliced
warning: rule `Step_read/table.fill-trap` was never spliced
warning: rule `Step_read/table.fill-zero` was never spliced
warning: rule `Step_read/table.fill-succ` was never spliced
warning: rule `Step_read/table.copy-trap` was never spliced
warning: rule `Step_read/table.copy-zero` was never spliced
warning: rule `Step_read/table.copy-le` was never spliced
warning: rule `Step_read/table.copy-gt` was never spliced
warning: rule `Step_read/table.init-trap` was never spliced
warning: rule `Step_read/table.init-zero` was never spliced
warning: rule `Step_read/table.init-le` was never spliced
warning: rule `Step_read/call` was never spliced
warning: rule `Step_read/call_indirect-call` was never spliced
warning: rule `Step_read/call_indirect-trap` was never spliced
warning: rule `Step_read/call_addr` was never spliced
warning: rule `Step_write/local.set` was never spliced
warning: rule `Step_write/global.set` was never spliced
warning: rule `Step_write/table.set-lt` was never spliced
warning: rule `Step_write/table.set-ge` was never spliced
warning: rule `Table_ok` was never spliced
warning: rule `Tabletype_ok` was never spliced
warning: rule `Tabletype_sub` was never spliced
warning: rule `Valtype_sub/refl` was never spliced
warning: rule `Valtype_sub/bot` was never spliced
warning: definition `elem` was never spliced
warning: definition `global` was never spliced
warning: definition `local` was never spliced
warning: definition `with_global` was never spliced
warning: definition `with_local` was never spliced
warning: definition `with_table` was never spliced
== Complete.
```
