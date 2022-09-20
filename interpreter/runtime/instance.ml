open Types

type module_inst =
{
  types : type_inst list;
  funcs : func_inst list;
  tables : table_inst list;
  memories : memory_inst list;
  globals : global_inst list;
  elems : elem_inst list;
  datas : data_inst list;
  exports : export_inst list;
}

and type_inst = type_addr
and func_inst = module_inst Lib.Promise.t Func.t
and table_inst = Table.t
and memory_inst = Memory.t
and global_inst = Global.t
and elem_inst = Elem.t
and data_inst = Data.t
and export_inst = Ast.name * extern

and extern =
  | ExternFunc of func_inst
  | ExternTable of table_inst
  | ExternMemory of memory_inst
  | ExternGlobal of global_inst


(* Reference types *)

type Value.ref_ += FuncRef of func_inst

let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | FuncRef _, FuncRef _ -> failwith "eq_ref"
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | FuncRef f -> DefHT (DynX (Func.type_inst_of f))
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | FuncRef _ -> "func"
    | r -> string_of_ref' r

let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | FuncRef f1, FuncRef f2 -> f1 == f2
    | _, _ -> eq_ref' r1 r2


(* Auxiliary functions *)

let empty_module_inst =
  { types = []; funcs = []; tables = []; memories = []; globals = [];
    elems = []; datas = []; exports = [] }

let extern_type_of c = function
  | ExternFunc func -> ExternFuncT (DynX (Func.type_inst_of func))
  | ExternTable tab -> ExternTableT (Table.type_of tab)
  | ExternMemory mem -> ExternMemoryT (Memory.type_of mem)
  | ExternGlobal glob -> ExternGlobalT (Global.type_of glob)

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
