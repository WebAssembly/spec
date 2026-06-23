open Types

type moduleinst =
{
  types : typeinst list;
  tags : taginst list;
  globals : globalinst list;
  memories : memoryinst list;
  tables : tableinst list;
  funcs : funcinst list;
  datas : datainst list;
  elems : eleminst list;
  exports : exportinst list;
}

and typeinst = deftype
and taginst = Tag.t
and globalinst = Global.t
and memoryinst = Memory.t
and tableinst = Table.t
and funcinst = moduleinst Lib.Promise.t Func.t
and datainst = Data.t
and eleminst = Elem.t
and exportinst = Ast.name * externinst

and externinst =
  | ExternTag of taginst
  | ExternGlobal of globalinst
  | ExternMemory of memoryinst
  | ExternTable of tableinst
  | ExternFunc of funcinst


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
    | FuncRef f -> UseHT (Def (Func.type_of f))
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | FuncRef _ -> "func"
    | r -> string_of_ref' r


(* Projections *)

let taginst_of_extern = function ExternTag t -> t | _ -> failwith "taginst_of_extern"
let globalinst_of_extern = function ExternGlobal g -> g | _ -> failwith "globalinst_of_extern"
let memoryinst_of_extern = function ExternMemory m -> m | _ -> failwith "memoryinst_of_extern"
let tableinst_of_extern = function ExternTable t -> t | _ -> failwith "tableinst_of_extern"
let funcinst_of_extern = function ExternFunc f -> f | _ -> failwith "funcinst_of_extern"


(* Auxiliary functions *)

let empty_moduleinst =
  { types = []; tags = []; globals = []; memories = []; tables = []; funcs = [];
    datas = []; elems = []; exports = [] }

let externtype_of c = function
  | ExternTag tag -> ExternTagT (Tag.type_of tag)
  | ExternGlobal glob -> ExternGlobalT (Global.type_of glob)
  | ExternMemory mem -> ExternMemoryT (Memory.type_of mem)
  | ExternTable tab -> ExternTableT (Table.type_of tab)
  | ExternFunc func -> ExternFuncT (Def (Func.type_of func))

let export inst name =
  try Some (List.assoc name inst.exports) with Not_found -> None
