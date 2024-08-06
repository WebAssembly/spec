open Types

type module_inst =
{
  types : type_inst list;
  funcs : func_inst list;
  tables : table_inst list;
  memories : memory_inst list;
  globals : global_inst list;
  tags : tag_inst list;
  elems : elem_inst list;
  datas : data_inst list;
  exports : export_inst list;
}

and type_inst = def_type
and func_inst = module_inst Lib.Promise.t Func.t
and table_inst = Table.t
and memory_inst = Memory.t
and global_inst = Global.t
and tag_inst = Tag.t
and elem_inst = Elem.t
and data_inst = Data.t
and export_inst = Ast.name * extern

and extern =
  | ExternFunc of func_inst
  | ExternTable of table_inst
  | ExternMemory of memory_inst
  | ExternGlobal of global_inst
  | ExternTag of tag_inst


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
    | FuncRef f -> DefHT (Func.type_of f)
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | FuncRef _ -> "func"
    | r -> string_of_ref' r


(* Projections *)

let func_inst_of_extern = function ExternFunc f -> f | _ -> failwith "func_inst_of_extern"
let table_inst_of_extern = function ExternTable t -> t | _ -> failwith "table_inst_of_extern"
let memory_inst_of_extern = function ExternMemory m -> m | _ -> failwith "memory_inst_of_extern"
let global_inst_of_extern = function ExternGlobal g -> g | _ -> failwith "global_inst_of_extern"
let tag_inst_of_extern = function ExternTag t -> t | _ -> failwith "tag_inst_of_extern"


(* Auxiliary functions *)

let empty_module_inst =
  { types = []; funcs = []; tables = []; memories = []; globals = [];
    tags = []; elems = []; datas = []; exports = [] }

let extern_type_of c = function
  | ExternFunc func -> ExternFuncT (Func.type_of func)
  | ExternTable tab -> ExternTableT (Table.type_of tab)
  | ExternMemory mem -> ExternMemoryT (Memory.type_of mem)
  | ExternGlobal glob -> ExternGlobalT (Global.type_of glob)
  | ExternTag tag -> ExternTagT (Tag.type_of tag)

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
