# Preview

```sh
$ cd ../spec/wasm-3.0 && \
> dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --interpreter ../../test-interpreter/sample.wat addTwo 30 12 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def setminus(idx*, idx*) : idx*
[elab def] def setminus1(idx, idx*) : idx*
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def size(valtype) : nat
[elab def] def packedsize(packedtype) : nat
[elab def] def storagesize(storagetype) : nat
[elab def] def unpacktype(storagetype) : valtype
[elab def] def unpacknumtype(storagetype) : numtype
[elab def] def sxfield(storagetype) : sx?
[elab def] def diffrt(reftype, reftype) : reftype
[elab def] def idx(typeidx) : typevar
[elab def] def subst_typevar(typevar, typevar*, heaptype*) : heaptype
[elab def] def subst_numtype(numtype, typevar*, heaptype*) : numtype
[elab def] def subst_vectype(vectype, typevar*, heaptype*) : vectype
[elab def] def subst_heaptype(heaptype, typevar*, heaptype*) : heaptype
[elab def] def subst_reftype(reftype, typevar*, heaptype*) : reftype
[elab def] def subst_valtype(valtype, typevar*, heaptype*) : valtype
[elab def] def subst_packedtype(packedtype, typevar*, heaptype*) : packedtype
[elab def] def subst_storagetype(storagetype, typevar*, heaptype*) : storagetype
[elab def] def subst_fieldtype(fieldtype, typevar*, heaptype*) : fieldtype
[elab def] def subst_comptype(comptype, typevar*, heaptype*) : comptype
[elab def] def subst_subtype(subtype, typevar*, heaptype*) : subtype
[elab def] def subst_rectype(rectype, typevar*, heaptype*) : rectype
[elab def] def subst_deftype(deftype, typevar*, heaptype*) : deftype
[elab def] def subst_globaltype(globaltype, typevar*, heaptype*) : globaltype
[elab def] def subst_functype(functype, typevar*, heaptype*) : functype
[elab def] def subst_tabletype(tabletype, typevar*, heaptype*) : tabletype
[elab def] def subst_memtype(memtype, typevar*, heaptype*) : memtype
[elab def] def subst_externtype(externtype, typevar*, heaptype*) : externtype
[elab def] def subst_all_reftype(reftype, heaptype*) : reftype
[elab def] def subst_all_deftype(deftype, heaptype*) : deftype
[elab def] def subst_all_deftypes(deftype*, heaptype*) : deftype*
[elab def] def rollrt(typeidx, rectype) : rectype
[elab def] def unrollrt(rectype) : rectype
[elab def] def rolldt(typeidx, rectype) : deftype*
[elab def] def unrolldt(deftype) : subtype
[elab def] def expanddt(deftype) : comptype
[elab def] def funcsxt(externtype*) : deftype*
[elab def] def globalsxt(externtype*) : globaltype*
[elab def] def tablesxt(externtype*) : tabletype*
[elab def] def memsxt(externtype*) : memtype*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c_numtype) : byte*
[elab def] def vtbytes(vectype, c_vectype) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def iadd(N, c, c) : c
[elab def] def imul(N, c, c) : c
[elab def] def ine(N, c, c) : c_numtype
[elab def] def ilt(sx, N, c, c) : c_numtype
[elab def] def lanes(shape, c_vectype) : c*
[elab def] def narrow(N, N, sx, c) : c
[elab def] def ibits(N, N) : c*
[elab def] def unpacked(shape) : numtype
[elab def] def dim(shape) : lanesize
[elab def] def halfop(half, nat, nat) : nat
[elab def] def ishape(nat) : lanetype
[elab def] def vvunop(unop_vvectype, vectype, c_vectype) : c_vectype
[elab def] def vvbinop(binop_vvectype, vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vvternop(ternop_vvectype, vectype, c_vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vunop(unop_vectype, shape, c_vectype) : c_vectype
[elab def] def vbinop(binop_vectype, shape, c_vectype, c_vectype) : c_vectype*
[elab def] def vrelop(relop_vectype, shape, c, c) : c_numtype
[elab def] def vishiftop(shiftop_vectype, lanetype, c, c) : c
[elab def] def vcvtop(cvtop_vectype, N, N, sx?, c) : c
[elab def] def inst_reftype(moduleinst, reftype) : reftype
[elab def] def default(valtype) : val?
[elab def] def packval(storagetype, val) : fieldval
[elab def] def unpackval(storagetype, sx?, fieldval) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def structinst(state) : structinst*
[elab def] def arrayinst(state) : arrayinst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : deftype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val?
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def with_struct(state, structaddr, nat, fieldval) : state
[elab def] def with_array(state, arrayaddr, nat, fieldval) : state
[elab def] def ext_structinst(state, structinst*) : state
[elab def] def ext_arrayinst(state, arrayinst*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def with_locals(context, localidx*, localtype*) : context
[elab def] def clostype(context, deftype) : deftype
[elab def] def clostypes(deftype*) : deftype*
[elab def] def before(heaptype, typeidx, nat) : bool
[elab def] def unrollht(context, heaptype) : subtype
[elab def] def in_numtype(numtype, numtype*) : bool
[elab def] def in_binop(binop_numtype, ibinop*) : bool
[elab def] def blocktype(state, blocktype) : functype
[elab def] def vzero : c_vectype
[elab def] def alloctypes(type*) : deftype*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype, ref) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*, ref*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, ref*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/sample.wat =====
42
== Complete.
$ cd ../spec/wasm-3.0 && \
> dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --interpreter ../../test-interpreter/sample.wasm addTwo 40 2 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def setminus(idx*, idx*) : idx*
[elab def] def setminus1(idx, idx*) : idx*
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def size(valtype) : nat
[elab def] def packedsize(packedtype) : nat
[elab def] def storagesize(storagetype) : nat
[elab def] def unpacktype(storagetype) : valtype
[elab def] def unpacknumtype(storagetype) : numtype
[elab def] def sxfield(storagetype) : sx?
[elab def] def diffrt(reftype, reftype) : reftype
[elab def] def idx(typeidx) : typevar
[elab def] def subst_typevar(typevar, typevar*, heaptype*) : heaptype
[elab def] def subst_numtype(numtype, typevar*, heaptype*) : numtype
[elab def] def subst_vectype(vectype, typevar*, heaptype*) : vectype
[elab def] def subst_heaptype(heaptype, typevar*, heaptype*) : heaptype
[elab def] def subst_reftype(reftype, typevar*, heaptype*) : reftype
[elab def] def subst_valtype(valtype, typevar*, heaptype*) : valtype
[elab def] def subst_packedtype(packedtype, typevar*, heaptype*) : packedtype
[elab def] def subst_storagetype(storagetype, typevar*, heaptype*) : storagetype
[elab def] def subst_fieldtype(fieldtype, typevar*, heaptype*) : fieldtype
[elab def] def subst_comptype(comptype, typevar*, heaptype*) : comptype
[elab def] def subst_subtype(subtype, typevar*, heaptype*) : subtype
[elab def] def subst_rectype(rectype, typevar*, heaptype*) : rectype
[elab def] def subst_deftype(deftype, typevar*, heaptype*) : deftype
[elab def] def subst_globaltype(globaltype, typevar*, heaptype*) : globaltype
[elab def] def subst_functype(functype, typevar*, heaptype*) : functype
[elab def] def subst_tabletype(tabletype, typevar*, heaptype*) : tabletype
[elab def] def subst_memtype(memtype, typevar*, heaptype*) : memtype
[elab def] def subst_externtype(externtype, typevar*, heaptype*) : externtype
[elab def] def subst_all_reftype(reftype, heaptype*) : reftype
[elab def] def subst_all_deftype(deftype, heaptype*) : deftype
[elab def] def subst_all_deftypes(deftype*, heaptype*) : deftype*
[elab def] def rollrt(typeidx, rectype) : rectype
[elab def] def unrollrt(rectype) : rectype
[elab def] def rolldt(typeidx, rectype) : deftype*
[elab def] def unrolldt(deftype) : subtype
[elab def] def expanddt(deftype) : comptype
[elab def] def funcsxt(externtype*) : deftype*
[elab def] def globalsxt(externtype*) : globaltype*
[elab def] def tablesxt(externtype*) : tabletype*
[elab def] def memsxt(externtype*) : memtype*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c_numtype) : byte*
[elab def] def vtbytes(vectype, c_vectype) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def iadd(N, c, c) : c
[elab def] def imul(N, c, c) : c
[elab def] def ine(N, c, c) : c_numtype
[elab def] def ilt(sx, N, c, c) : c_numtype
[elab def] def lanes(shape, c_vectype) : c*
[elab def] def narrow(N, N, sx, c) : c
[elab def] def ibits(N, N) : c*
[elab def] def unpacked(shape) : numtype
[elab def] def dim(shape) : lanesize
[elab def] def halfop(half, nat, nat) : nat
[elab def] def ishape(nat) : lanetype
[elab def] def vvunop(unop_vvectype, vectype, c_vectype) : c_vectype
[elab def] def vvbinop(binop_vvectype, vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vvternop(ternop_vvectype, vectype, c_vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vunop(unop_vectype, shape, c_vectype) : c_vectype
[elab def] def vbinop(binop_vectype, shape, c_vectype, c_vectype) : c_vectype*
[elab def] def vrelop(relop_vectype, shape, c, c) : c_numtype
[elab def] def vishiftop(shiftop_vectype, lanetype, c, c) : c
[elab def] def vcvtop(cvtop_vectype, N, N, sx?, c) : c
[elab def] def inst_reftype(moduleinst, reftype) : reftype
[elab def] def default(valtype) : val?
[elab def] def packval(storagetype, val) : fieldval
[elab def] def unpackval(storagetype, sx?, fieldval) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def structinst(state) : structinst*
[elab def] def arrayinst(state) : arrayinst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : deftype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val?
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def with_struct(state, structaddr, nat, fieldval) : state
[elab def] def with_array(state, arrayaddr, nat, fieldval) : state
[elab def] def ext_structinst(state, structinst*) : state
[elab def] def ext_arrayinst(state, arrayinst*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def with_locals(context, localidx*, localtype*) : context
[elab def] def clostype(context, deftype) : deftype
[elab def] def clostypes(deftype*) : deftype*
[elab def] def before(heaptype, typeidx, nat) : bool
[elab def] def unrollht(context, heaptype) : subtype
[elab def] def in_numtype(numtype, numtype*) : bool
[elab def] def in_binop(binop_numtype, ibinop*) : bool
[elab def] def blocktype(state, blocktype) : functype
[elab def] def vzero : c_vectype
[elab def] def alloctypes(type*) : deftype*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype, ref) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*, ref*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, ref*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/sample.wasm =====
42
== Complete.
$ cd ../spec/wasm-3.0 && \
> dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --interpreter ../../test-interpreter/sample.wast 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def setminus(idx*, idx*) : idx*
[elab def] def setminus1(idx, idx*) : idx*
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def size(valtype) : nat
[elab def] def packedsize(packedtype) : nat
[elab def] def storagesize(storagetype) : nat
[elab def] def unpacktype(storagetype) : valtype
[elab def] def unpacknumtype(storagetype) : numtype
[elab def] def sxfield(storagetype) : sx?
[elab def] def diffrt(reftype, reftype) : reftype
[elab def] def idx(typeidx) : typevar
[elab def] def subst_typevar(typevar, typevar*, heaptype*) : heaptype
[elab def] def subst_numtype(numtype, typevar*, heaptype*) : numtype
[elab def] def subst_vectype(vectype, typevar*, heaptype*) : vectype
[elab def] def subst_heaptype(heaptype, typevar*, heaptype*) : heaptype
[elab def] def subst_reftype(reftype, typevar*, heaptype*) : reftype
[elab def] def subst_valtype(valtype, typevar*, heaptype*) : valtype
[elab def] def subst_packedtype(packedtype, typevar*, heaptype*) : packedtype
[elab def] def subst_storagetype(storagetype, typevar*, heaptype*) : storagetype
[elab def] def subst_fieldtype(fieldtype, typevar*, heaptype*) : fieldtype
[elab def] def subst_comptype(comptype, typevar*, heaptype*) : comptype
[elab def] def subst_subtype(subtype, typevar*, heaptype*) : subtype
[elab def] def subst_rectype(rectype, typevar*, heaptype*) : rectype
[elab def] def subst_deftype(deftype, typevar*, heaptype*) : deftype
[elab def] def subst_globaltype(globaltype, typevar*, heaptype*) : globaltype
[elab def] def subst_functype(functype, typevar*, heaptype*) : functype
[elab def] def subst_tabletype(tabletype, typevar*, heaptype*) : tabletype
[elab def] def subst_memtype(memtype, typevar*, heaptype*) : memtype
[elab def] def subst_externtype(externtype, typevar*, heaptype*) : externtype
[elab def] def subst_all_reftype(reftype, heaptype*) : reftype
[elab def] def subst_all_deftype(deftype, heaptype*) : deftype
[elab def] def subst_all_deftypes(deftype*, heaptype*) : deftype*
[elab def] def rollrt(typeidx, rectype) : rectype
[elab def] def unrollrt(rectype) : rectype
[elab def] def rolldt(typeidx, rectype) : deftype*
[elab def] def unrolldt(deftype) : subtype
[elab def] def expanddt(deftype) : comptype
[elab def] def funcsxt(externtype*) : deftype*
[elab def] def globalsxt(externtype*) : globaltype*
[elab def] def tablesxt(externtype*) : tabletype*
[elab def] def memsxt(externtype*) : memtype*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c_numtype) : byte*
[elab def] def vtbytes(vectype, c_vectype) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def iadd(N, c, c) : c
[elab def] def imul(N, c, c) : c
[elab def] def ine(N, c, c) : c_numtype
[elab def] def ilt(sx, N, c, c) : c_numtype
[elab def] def lanes(shape, c_vectype) : c*
[elab def] def narrow(N, N, sx, c) : c
[elab def] def ibits(N, N) : c*
[elab def] def unpacked(shape) : numtype
[elab def] def dim(shape) : lanesize
[elab def] def halfop(half, nat, nat) : nat
[elab def] def ishape(nat) : lanetype
[elab def] def vvunop(unop_vvectype, vectype, c_vectype) : c_vectype
[elab def] def vvbinop(binop_vvectype, vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vvternop(ternop_vvectype, vectype, c_vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vunop(unop_vectype, shape, c_vectype) : c_vectype
[elab def] def vbinop(binop_vectype, shape, c_vectype, c_vectype) : c_vectype*
[elab def] def vrelop(relop_vectype, shape, c, c) : c_numtype
[elab def] def vishiftop(shiftop_vectype, lanetype, c, c) : c
[elab def] def vcvtop(cvtop_vectype, N, N, sx?, c) : c
[elab def] def inst_reftype(moduleinst, reftype) : reftype
[elab def] def default(valtype) : val?
[elab def] def packval(storagetype, val) : fieldval
[elab def] def unpackval(storagetype, sx?, fieldval) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def structinst(state) : structinst*
[elab def] def arrayinst(state) : arrayinst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : deftype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val?
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def with_struct(state, structaddr, nat, fieldval) : state
[elab def] def with_array(state, arrayaddr, nat, fieldval) : state
[elab def] def ext_structinst(state, structinst*) : state
[elab def] def ext_arrayinst(state, arrayinst*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def with_locals(context, localidx*, localtype*) : context
[elab def] def clostype(context, deftype) : deftype
[elab def] def clostypes(deftype*) : deftype*
[elab def] def before(heaptype, typeidx, nat) : bool
[elab def] def unrollht(context, heaptype) : subtype
[elab def] def in_numtype(numtype, numtype*) : bool
[elab def] def in_binop(binop_numtype, ibinop*) : bool
[elab def] def blocktype(state, blocktype) : functype
[elab def] def vzero : c_vectype
[elab def] def alloctypes(type*) : deftype*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype, ref) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*, ref*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, ref*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/sample.wast =====
- print_i32: 10
- 30/30 (100.00%)

== Complete.
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --test-version $v --interpreter ../../test-interpreter/spec-test-$v \
> ) done 2>/dev/null
Running test for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def size(valtype) : nat
[elab def] def memop0 : memop
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_valtype, valtype, c) : c_valtype*
[elab def] def binop(binop_valtype, valtype, c, c) : c_valtype*
[elab def] def testop(testop_valtype, valtype, c) : c_valtype
[elab def] def relop(relop_valtype, valtype, c, c) : c_valtype
[elab def] def cvtop(cvtop, valtype, valtype, sx?, c) : c_valtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_valtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def bytes(valtype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def default(valtype) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : functype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def local(state, localidx) : val
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, funcaddr) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def growtable(tableinst, nat) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def funcs(externval*) : funcaddr*
[elab def] def globals(externval*) : globaladdr*
[elab def] def tables(externval*) : tableaddr*
[elab def] def mems(externval*) : memaddr*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def initelem(store, moduleinst, u32*, (funcaddr*)*) : store
[elab def] def initdata(store, moduleinst, u32*, (byte*)*) : store
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-1/address.wast =====
- 242/242 (100.00%)

===== ../../test-interpreter/spec-test-1/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-1/binary-leb128.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-1/binary.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-1/block.wast =====
- 42/42 (100.00%)

===== ../../test-interpreter/spec-test-1/br.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-1/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-1/br_table.wast =====
- 147/147 (100.00%)

===== ../../test-interpreter/spec-test-1/break-drop.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/call.wast =====
- 62/62 (100.00%)

===== ../../test-interpreter/spec-test-1/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/const.wast =====
- 638/638 (100.00%)

===== ../../test-interpreter/spec-test-1/conversions.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/conversions.wast

===== ../../test-interpreter/spec-test-1/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-1/data.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/data.wast

===== ../../test-interpreter/spec-test-1/elem.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/elem.wast

===== ../../test-interpreter/spec-test-1/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-1/exports.wast =====
- 60/60 (100.00%)

===== ../../test-interpreter/spec-test-1/f32.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f32.wast

===== ../../test-interpreter/spec-test-1/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-1/f64.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f64.wast

===== ../../test-interpreter/spec-test-1/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-1/fac.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-1/float_exprs.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_exprs.wast

===== ../../test-interpreter/spec-test-1/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-1/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-1/float_misc.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_misc.wast

===== ../../test-interpreter/spec-test-1/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/func.wast =====
- 76/76 (100.00%)

===== ../../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-1/globals.wast =====
- 51/51 (100.00%)

===== ../../test-interpreter/spec-test-1/i32.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/i64.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-1/imports.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/imports.wast

===== ../../test-interpreter/spec-test-1/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-1/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-1/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-1/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-1/linking.wast =====
- 99/99 (100.00%)

===== ../../test-interpreter/spec-test-1/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-1/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-1/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-1/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-1/loop.wast =====
- 67/67 (100.00%)

===== ../../test-interpreter/spec-test-1/memory.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_trap.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
- 483/483 (100.00%)

===== ../../test-interpreter/spec-test-1/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-1/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-1/select.wast =====
- 95/95 (100.00%)

===== ../../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/stack.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-1/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-1/switch.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-1/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-1/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/unreachable.wast =====
- 62/62 (100.00%)

===== ../../test-interpreter/spec-test-1/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

8 parsing fail
Total [9983/9983] (100.00%)

== Complete.
Running test for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def size(valtype) : nat
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def default(valtype) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : functype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def blocktype(state, blocktype) : functype
[elab def] def funcs(externval*) : funcaddr*
[elab def] def globals(externval*) : globaladdr*
[elab def] def tables(externval*) : tableaddr*
[elab def] def mems(externval*) : memaddr*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def utf8(name) : byte*
[elab def] def concat_locals(local**) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-2/address.wast =====
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-2/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-2/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/block.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-2/br.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-2/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-2/br_table.wast =====
- 150/150 (100.00%)

===== ../../test-interpreter/spec-test-2/bulk.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-2/call.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-2/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-2/conversions.wast =====
- 594/594 (100.00%)

===== ../../test-interpreter/spec-test-2/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-2/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-2/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-2/exports.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-2/f32.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-2/f64.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-2/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/float_exprs.wast =====
- 900/900 (100.00%)

===== ../../test-interpreter/spec-test-2/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-2/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-2/float_misc.wast =====
- 441/441 (100.00%)

===== ../../test-interpreter/spec-test-2/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-2/func.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-2/global.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-2/i32.wast =====
- 375/375 (100.00%)

===== ../../test-interpreter/spec-test-2/i64.wast =====
- 385/385 (100.00%)

===== ../../test-interpreter/spec-test-2/if.wast =====
- 124/124 (100.00%)

===== ../../test-interpreter/spec-test-2/imports.wast =====
- print_i32: 13
- print_i32_f32: 14 42
- print_i32: 13
- print_i32: 13
- print_f32: 13
- print_i32: 13
- print_i64: 24
- print_f64_f64: 25 53
- print_i64: 24
- print_f64: 24
- print_f64: 24
- print_f64: 24
- print_i32: 13
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-2/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-2/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-2/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-2/linking.wast =====
- 111/111 (100.00%)

===== ../../test-interpreter/spec-test-2/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-2/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-2/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-2/loop.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-2/memory.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_init.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_trap.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-2/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_func.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-2/select.wast =====
- 120/120 (100.00%)

===== ../../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-2/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-2/switch.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/table.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/table_copy.wast =====
- 1727/1727 (100.00%)

===== ../../test-interpreter/spec-test-2/table_fill.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/table_get.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-2/table_grow.wast =====
- 43/43 (100.00%)

===== ../../test-interpreter/spec-test-2/table_init.wast =====
- 712/712 (100.00%)

===== ../../test-interpreter/spec-test-2/table_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-2/table_size.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-2/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/tokens.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-2/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/unreachable.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-valid.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [20388/20388] (100.00%)

== Complete.
Running test for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def setminus(idx*, idx*) : idx*
[elab def] def setminus1(idx, idx*) : idx*
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def size(valtype) : nat
[elab def] def packedsize(packedtype) : nat
[elab def] def storagesize(storagetype) : nat
[elab def] def unpacktype(storagetype) : valtype
[elab def] def unpacknumtype(storagetype) : numtype
[elab def] def sxfield(storagetype) : sx?
[elab def] def diffrt(reftype, reftype) : reftype
[elab def] def idx(typeidx) : typevar
[elab def] def subst_typevar(typevar, typevar*, heaptype*) : heaptype
[elab def] def subst_numtype(numtype, typevar*, heaptype*) : numtype
[elab def] def subst_vectype(vectype, typevar*, heaptype*) : vectype
[elab def] def subst_heaptype(heaptype, typevar*, heaptype*) : heaptype
[elab def] def subst_reftype(reftype, typevar*, heaptype*) : reftype
[elab def] def subst_valtype(valtype, typevar*, heaptype*) : valtype
[elab def] def subst_packedtype(packedtype, typevar*, heaptype*) : packedtype
[elab def] def subst_storagetype(storagetype, typevar*, heaptype*) : storagetype
[elab def] def subst_fieldtype(fieldtype, typevar*, heaptype*) : fieldtype
[elab def] def subst_comptype(comptype, typevar*, heaptype*) : comptype
[elab def] def subst_subtype(subtype, typevar*, heaptype*) : subtype
[elab def] def subst_rectype(rectype, typevar*, heaptype*) : rectype
[elab def] def subst_deftype(deftype, typevar*, heaptype*) : deftype
[elab def] def subst_globaltype(globaltype, typevar*, heaptype*) : globaltype
[elab def] def subst_functype(functype, typevar*, heaptype*) : functype
[elab def] def subst_tabletype(tabletype, typevar*, heaptype*) : tabletype
[elab def] def subst_memtype(memtype, typevar*, heaptype*) : memtype
[elab def] def subst_externtype(externtype, typevar*, heaptype*) : externtype
[elab def] def subst_all_reftype(reftype, heaptype*) : reftype
[elab def] def subst_all_deftype(deftype, heaptype*) : deftype
[elab def] def subst_all_deftypes(deftype*, heaptype*) : deftype*
[elab def] def rollrt(typeidx, rectype) : rectype
[elab def] def unrollrt(rectype) : rectype
[elab def] def rolldt(typeidx, rectype) : deftype*
[elab def] def unrolldt(deftype) : subtype
[elab def] def expanddt(deftype) : comptype
[elab def] def funcsxt(externtype*) : deftype*
[elab def] def globalsxt(externtype*) : globaltype*
[elab def] def tablesxt(externtype*) : tabletype*
[elab def] def memsxt(externtype*) : memtype*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c_numtype) : byte*
[elab def] def vtbytes(vectype, c_vectype) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def iadd(N, c, c) : c
[elab def] def imul(N, c, c) : c
[elab def] def ine(N, c, c) : c_numtype
[elab def] def ilt(sx, N, c, c) : c_numtype
[elab def] def lanes(shape, c_vectype) : c*
[elab def] def narrow(N, N, sx, c) : c
[elab def] def ibits(N, N) : c*
[elab def] def unpacked(shape) : numtype
[elab def] def dim(shape) : lanesize
[elab def] def halfop(half, nat, nat) : nat
[elab def] def ishape(nat) : lanetype
[elab def] def vvunop(unop_vvectype, vectype, c_vectype) : c_vectype
[elab def] def vvbinop(binop_vvectype, vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vvternop(ternop_vvectype, vectype, c_vectype, c_vectype, c_vectype) : c_vectype
[elab def] def vunop(unop_vectype, shape, c_vectype) : c_vectype
[elab def] def vbinop(binop_vectype, shape, c_vectype, c_vectype) : c_vectype*
[elab def] def vrelop(relop_vectype, shape, c, c) : c_numtype
[elab def] def vishiftop(shiftop_vectype, lanetype, c, c) : c
[elab def] def vcvtop(cvtop_vectype, N, N, sx?, c) : c
[elab def] def inst_reftype(moduleinst, reftype) : reftype
[elab def] def default(valtype) : val?
[elab def] def packval(storagetype, val) : fieldval
[elab def] def unpackval(storagetype, sx?, fieldval) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def structinst(state) : structinst*
[elab def] def arrayinst(state) : arrayinst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : deftype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val?
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def with_struct(state, structaddr, nat, fieldval) : state
[elab def] def with_array(state, arrayaddr, nat, fieldval) : state
[elab def] def ext_structinst(state, structinst*) : state
[elab def] def ext_arrayinst(state, arrayinst*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def with_locals(context, localidx*, localtype*) : context
[elab def] def clostype(context, deftype) : deftype
[elab def] def clostypes(deftype*) : deftype*
[elab def] def before(heaptype, typeidx, nat) : bool
[elab def] def unrollht(context, heaptype) : subtype
[elab def] def in_numtype(numtype, numtype*) : bool
[elab def] def in_binop(binop_numtype, ibinop*) : bool
[elab def] def blocktype(state, blocktype) : functype
[elab def] def vzero : c_vectype
[elab def] def alloctypes(type*) : deftype*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype, ref) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*, ref*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, ref*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-3/address.wast =====
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 150/150 (100.00%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 594/594 (100.00%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 900/900 (100.00%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 441/441 (100.00%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_non_null.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_null.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/call_ref.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/ref_as_non_null.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/binary-gc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/extern.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/i31.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_cast.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_eq.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_test.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 375/375 (100.00%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 385/385 (100.00%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 124/124 (100.00%)

===== ../../test-interpreter/spec-test-3/imports.wast =====
- print_i32: 13
- print_i32_f32: 14 42
- print_i32: 13
- print_i32: 13
- print_f32: 13
- print_i32: 13
- print_i64: 24
- print_f64_f64: 25 53
- print_i64: 24
- print_f64: 24
- print_f64: 24
- print_f64: 24
- print_i32: 13
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 111/111 (100.00%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 120/120 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 213/213 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 141/141 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- 261/261 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 234/234 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 774/774 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 1806/1806 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2583/2583 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 795/795 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 1809/1809 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2661/2661 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 153/153 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 206/206 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 189/189 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 415/415 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 190/190 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 229/229 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 286/286 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 86/86 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 162/162 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/table.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/table_copy.wast =====
- 1727/1727 (100.00%)

===== ../../test-interpreter/spec-test-3/table_fill.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/table_get.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/table_grow.wast =====
- 43/43 (100.00%)

===== ../../test-interpreter/spec-test-3/table_init.wast =====
- 712/712 (100.00%)

===== ../../test-interpreter/spec-test-3/table_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/table_size.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tokens.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/unreachable.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-valid.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [45764/45764] (100.00%)

== Complete.
```
