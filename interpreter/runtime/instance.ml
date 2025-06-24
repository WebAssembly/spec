open Types

type moduleinst =
{
  types : typeinst list;
  funcs : funcinst list;
  tables : tableinst list;
  memories : memoryinst list;
  globals : globalinst list;
  tags : taginst list;
  elems : eleminst list;
  datas : datainst list;
  exports : exportinst list;
}

and typeinst = deftype
and funcinst = moduleinst Lib.Promise.t Func.t
and tableinst = Table.t
and memoryinst = Memory.t
and globalinst = Global.t
and taginst = Tag.t
and eleminst = Elem.t
and datainst = Data.t
and exportinst = Ast.name * extern

and extern =
  | ExternFunc of funcinst
  | ExternTable of tableinst
  | ExternMemory of memoryinst
  | ExternGlobal of globalinst
  | ExternTag of taginst


(* Reference types *)

type Value.ref_ += FuncRef of funcinst

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

let funcinst_of_extern = function ExternFunc f -> f | _ -> failwith "funcinst_of_extern"
let tableinst_of_extern = function ExternTable t -> t | _ -> failwith "tableinst_of_extern"
let memoryinst_of_extern = function ExternMemory m -> m | _ -> failwith "memoryinst_of_extern"
let globalinst_of_extern = function ExternGlobal g -> g | _ -> failwith "globalinst_of_extern"
let taginst_of_extern = function ExternTag t -> t | _ -> failwith "taginst_of_extern"


(* Auxiliary functions *)

let empty_moduleinst =
  { types = []; funcs = []; tables = []; memories = []; globals = [];
    tags = []; elems = []; datas = []; exports = [] }

let externtype_of c = function
  | ExternFunc func -> ExternFuncT (Func.type_of func)
  | ExternTable tab -> ExternTableT (Table.type_of tab)
  | ExternMemory mem -> ExternMemoryT (Memory.type_of mem)
  | ExternGlobal glob -> ExternGlobalT (Global.type_of glob)
  | ExternTag tag -> ExternTagT (Tag.type_of tag)

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
