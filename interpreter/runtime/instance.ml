open Types

type module_inst =
{
  types : func_type list lazy_t;
  funcs : func_inst list lazy_t;
  tables : table_inst list lazy_t;
  memories : memory_inst list lazy_t;
  globals : global_inst list lazy_t;
  exports : export_inst list lazy_t;
}

and func_inst = module_inst Func.t
and table_inst = Table.t
and memory_inst = Memory.t
and global_inst = Global.t
and export_inst = Ast.name * extern

and extern =
  | ExternFunc of func_inst
  | ExternTable of table_inst
  | ExternMemory of memory_inst
  | ExternGlobal of global_inst

type Table.elem += FuncElem of func_inst


(* Auxiliary functions *)

let empty_module_inst =
  { types = lazy []; funcs = lazy []; tables = lazy []; memories = lazy [];
    globals = lazy []; exports = lazy [] }

let extern_type_of = function
  | ExternFunc func -> ExternFuncType (Func.type_of func)
  | ExternTable tab -> ExternTableType (Table.type_of tab)
  | ExternMemory mem -> ExternMemoryType (Memory.type_of mem)
  | ExternGlobal glob -> ExternGlobalType (Global.type_of glob)

let extern_funcs =
  Lib.List.map_filter (function ExternFunc f -> Some f | _ -> None)
let extern_tables =
  Lib.List.map_filter (function ExternTable t -> Some t | _ -> None)
let extern_memories =
  Lib.List.map_filter (function ExternMemory m -> Some m | _ -> None)
let extern_globals =
  Lib.List.map_filter (function ExternGlobal g -> Some g | _ -> None)

let export inst name =
  try Some (List.assoc name (Lazy.force inst.exports)) with Not_found -> None
