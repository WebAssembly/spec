# Preview

```sh
$ (cd ../spec/wasm-3.0 && dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
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
[elab def] def ntbytes(numtype, c) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
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
Animation failed:if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))
Animation failed:if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])
Animation failed:if ($ntbytes(nt, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : ($size(nt <: valtype) / 8)])
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (nt = $unpacknumtype(zt))
Animation failed:if ($ztbytes(zt, c) = $data(z, y).DATA_datainst[j : ($storagesize(zt) / 8)])
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ((j + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)
Animation failed:Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
Animation failed:if (sx?{sx} = $sxfield(zt_2))
Animation failed:Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
Animation failed:if (sx?{sx} = $sxfield(zt_2))
Animation failed:Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (nt = $unpacknumtype(zt))
Animation failed:if ($concat_bytes($ztbytes(zt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $storagesize(zt)) / 8)])
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ((i + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)
Animation failed:if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ($default($unpacktype(zt)) = ?(val))
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (i < |zt*{zt}|)
Animation failed:Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (|val*{val}| = |zt*{zt}|)
Animation failed:Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:(if ($default($unpacktype(zt)) = ?(val)))*{val zt}
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt')
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt')
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))
Animation failed:Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
Animation failed:Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
Animation failed:if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt)
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt)
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))
Animation failed:Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (fv = $packval(zt, val))
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (i < |zt*{zt}|)
Animation failed:Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:if (fv = $packval(zt*{zt}[i], val))
Animation failed:Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
Animation failed:if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})
== IL Validation after pass animate...
== Prose Generation...
== Complete.
```
