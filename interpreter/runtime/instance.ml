open Types

type module_inst =
{
  types : func_type list;
  funcs : func_inst list;
  tables : table_inst list;
  mems : mem_inst list;
  globals : global_inst list;
  exports : export_inst list;
}

and func_inst = module_inst ref Func.t
and table_inst = Table.t
and mem_inst = Mem.t
and global_inst = Global.t
and export_inst = Ast.name * extern

and extern =
  | ExternFunc of func_inst
  | ExternTable of table_inst
  | ExternMem of mem_inst
  | ExternGlobal of global_inst

type Table.elem += FuncElem of func_inst


(* Auxiliary functions *)

let empty_module_inst =
  { types = []; funcs = []; tables = []; mems = []; globals = []; exports = [] }

let extern_type_of = function
  | ExternFunc func -> ExternFuncType (Func.type_of func)
  | ExternTable tab -> ExternTableType (Table.type_of tab)
  | ExternMem mem -> ExternMemType (Mem.type_of mem)
  | ExternGlobal glob -> ExternGlobalType (Global.type_of glob)

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
