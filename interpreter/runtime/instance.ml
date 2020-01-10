open Types

type module_inst =
{
  types : func_type list;
  funcs : func_inst list;
  tables : table_inst list;
  memories : memory_inst list;
  globals : global_inst list;
  exports : export_inst list;
  elems : elem_inst list;
  datas : data_inst list;
}

and func_inst = module_inst ref Func.t
and table_inst = Table.t
and memory_inst = Memory.t
and global_inst = Global.t
and export_inst = Ast.name * extern
and elem_inst = Values.ref_ list ref
and data_inst = string ref

and extern =
  | ExternFunc of func_inst
  | ExternTable of table_inst
  | ExternMemory of memory_inst
  | ExternGlobal of global_inst


(* Reference types *)

type Values.ref_ += FuncRef of func_inst

let () =
  let type_of_ref' = !Values.type_of_ref' in
  Values.type_of_ref' := function
    | FuncRef _ -> FuncRefType
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Values.string_of_ref' in
  Values.string_of_ref' := function
    | FuncRef _ -> "func"
    | r -> string_of_ref' r


(* Auxiliary functions *)

let empty_module_inst =
  { types = []; funcs = []; tables = []; memories = []; globals = [];
    exports = []; elems = []; datas = [] }

let extern_type_of = function
  | ExternFunc func -> ExternFuncType (Func.type_of func)
  | ExternTable tab -> ExternTableType (Table.type_of tab)
  | ExternMemory mem -> ExternMemoryType (Memory.type_of mem)
  | ExternGlobal glob -> ExternGlobalType (Global.type_of glob)

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
