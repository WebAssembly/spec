(* Generic Types *)

type typeidx = int32
type localidx = int32
type name = Utf8.unicode

type null = NoNull | Null
type mut = Cons | Var
type init = Set | Unset
type final = NoFinal | Final
type limits = {min : int64; max : int64 option}

type var = IdxX of typeidx | RecX of int32

type addrtype = I32AT | I64AT
type numtype = I32T | I64T | F32T | F64T
type vectype = V128T
type heaptype =
  | AnyHT | NoneHT | EqHT | I31HT | StructHT | ArrayHT
  | FuncHT | NoFuncHT
  | ExnHT | NoExnHT
  | ExternHT | NoExternHT
  | VarHT of var
  | DefHT of deftype
  | BotHT
and reftype = null * heaptype
and valtype = NumT of numtype | VecT of vectype | RefT of reftype | BotT

and resulttype = valtype list
and instrtype = InstrT of resulttype * resulttype * localidx list

and packtype = I8T | I16T
and storagetype = ValStorageT of valtype | PackStorageT of packtype
and fieldtype = FieldT of mut * storagetype

and structtype = StructT of fieldtype list
and arraytype = ArrayT of fieldtype
and functype = FuncT of resulttype * resulttype

and comptype =
  | StructCT of structtype
  | ArrayCT of arraytype
  | FuncCT of functype

and subtype = SubT of final * heaptype list * comptype
and rectype = RecT of subtype list
and deftype = DefT of rectype * int32

type tabletype = TableT of addrtype * limits * reftype
type memorytype = MemoryT of addrtype * limits
type globaltype = GlobalT of mut * valtype
type tagtype = TagT of deftype
type localtype = LocalT of init * valtype
type externtype =
  | ExternFuncT of deftype
  | ExternTableT of tabletype
  | ExternMemoryT of memorytype
  | ExternGlobalT of globaltype
  | ExternTagT of tagtype

type exporttype = ExportT of externtype * name
type importtype = ImportT of externtype * name * name
type moduletype = ModuleT of importtype list * exporttype list


(* Attributes *)

let num_size = function
  | I32T | F32T -> 4
  | I64T | F64T -> 8

let vec_size = function
  | V128T -> 16

let val_size = function
  | NumT t -> num_size t
  | VecT t -> vec_size t
  | RefT _ | BotT -> failwith "val_size"

let pack_size = function
  | I8T -> 1
  | I16T -> 2

let storage_size = function
  | ValStorageT t -> val_size t
  | PackStorageT t -> pack_size t

let is_idx_var = function IdxX _ -> true | _ -> false
let is_rec_var = function RecX _ -> true | _ -> false

let as_idx_var = function IdxX x -> x | _ -> assert false
let as_rec_var = function RecX x -> x | _ -> assert false


let is_numtype = function
  | NumT _ | BotT -> true
  | _ -> false

let is_vectype = function
  | VecT _ | BotT -> true
  | _ -> false

let is_reftype = function
  | RefT _ | BotT -> true
  | _ -> false

let is_packed_storagetype = function
  | ValStorageT _ -> false
  | PackStorageT _ -> true


let defaultable = function
  | NumT _ -> true
  | VecT _ -> true
  | RefT (nul, _) -> nul = Null
  | BotT -> assert false


(* Conversions & Projections *)

let numtype_of_addrtype = function
  | I32AT -> I32T
  | I64AT -> I64T

let addrtype_of_numtype = function
  | I32T -> I32AT
  | I64T -> I64AT
  | _ -> assert false


let unpacked_storagetype = function
  | ValStorageT t -> t
  | PackStorageT _ -> NumT I32T

let unpacked_fieldtype (FieldT (_mut, t)) = unpacked_storagetype t


let as_func_comptype (ct : comptype) : functype =
  match ct with
  | FuncCT ft -> ft
  | _ -> assert false

let as_struct_comptype (ct : comptype) : structtype =
  match ct with
  | StructCT st -> st
  | _ -> assert false

let as_array_comptype (ct : comptype) : arraytype =
  match ct with
  | ArrayCT at -> at
  | _ -> assert false

let externtype_of_importtype (ImportT (et, _, _)) = et
let externtype_of_exporttype (ExportT (et, _)) = et


(* Filters *)

let funcs = List.filter_map (function ExternFuncT ft -> Some ft | _ -> None)
let tables = List.filter_map (function ExternTableT tt -> Some tt | _ -> None)
let memories = List.filter_map (function ExternMemoryT mt -> Some mt | _ -> None)
let globals = List.filter_map (function ExternGlobalT gt -> Some gt | _ -> None)
let tags = List.filter_map (function ExternTagT tt -> Some tt | _ -> None)


(* Substitution *)

type subst = var -> heaptype

let subst_of dts = function
  | IdxX x -> DefHT (Lib.List32.nth dts x)
  | RecX i -> VarHT (RecX i)

let subst_addrtype s t = t

let subst_numtype s t = t

let subst_vectype s t = t

let subst_heaptype s = function
  | AnyHT -> AnyHT
  | NoneHT -> NoneHT
  | EqHT -> EqHT
  | I31HT -> I31HT
  | StructHT -> StructHT
  | ArrayHT -> ArrayHT
  | FuncHT -> FuncHT
  | NoFuncHT -> NoFuncHT
  | ExnHT -> ExnHT
  | NoExnHT -> NoExnHT
  | ExternHT -> ExternHT
  | NoExternHT -> NoExternHT
  | VarHT x -> s x
  | DefHT dt -> DefHT dt  (* assume closed *)
  | BotHT -> BotHT

let subst_reftype s = function
  | (nul, t) -> (nul, subst_heaptype s t)

let subst_valtype s = function
  | NumT t -> NumT (subst_numtype s t)
  | VecT t -> VecT (subst_vectype s t)
  | RefT t -> RefT (subst_reftype s t)
  | BotT -> BotT

let subst_resulttype s = function
  | ts -> List.map (subst_valtype s) ts


let subst_storagetype s = function
  | ValStorageT t -> ValStorageT (subst_valtype s t)
  | PackStorageT p -> PackStorageT p

let subst_fieldtype s = function
  | FieldT (mut, t) -> FieldT (mut, subst_storagetype s t)

let subst_structtype s = function
  | StructT ts -> StructT (List.map (subst_fieldtype s) ts)

let subst_arraytype s = function
  | ArrayT t -> ArrayT (subst_fieldtype s t)

let subst_functype s = function
  | FuncT (ts1, ts2) -> FuncT (subst_resulttype s ts1, subst_resulttype s ts2)

let subst_comptype s = function
  | StructCT st -> StructCT (subst_structtype s st)
  | ArrayCT at -> ArrayCT (subst_arraytype s at)
  | FuncCT ft -> FuncCT (subst_functype s ft)

let subst_subtype s = function
  | SubT (fin, hts, ct) ->
    SubT (fin, List.map (subst_heaptype s) hts, subst_comptype s ct)

let subst_rectype s = function
  | RecT sts -> RecT (List.map (subst_subtype s) sts)

let subst_deftype s = function
  | DefT (rt, i) -> DefT (subst_rectype s rt, i)


let subst_memorytype s = function
  | MemoryT (at, lim) -> MemoryT (subst_addrtype s at, lim)

let subst_tabletype s = function
  | TableT (at, lim, t) -> TableT (subst_addrtype s at, lim, subst_reftype s t)

let subst_globaltype s = function
  | GlobalT (mut, t) ->  GlobalT (mut, subst_valtype s t)

let subst_tagtype s = function
  | TagT dt -> TagT (subst_deftype s dt)

let subst_externtype s = function
  | ExternFuncT dt -> ExternFuncT (subst_deftype s dt)
  | ExternTableT tt -> ExternTableT (subst_tabletype s tt)
  | ExternMemoryT mt -> ExternMemoryT (subst_memorytype s mt)
  | ExternGlobalT gt -> ExternGlobalT (subst_globaltype s gt)
  | ExternTagT tt -> ExternTagT (subst_tagtype s tt)


let subst_exporttype s = function
  | ExportT (xt, name) -> ExportT (subst_externtype s xt, name)

let subst_importtype s = function
  | ImportT (xt, module_name, name) ->
    ImportT (subst_externtype s xt, module_name, name)

let subst_moduletype s = function
  | ModuleT (its, ets) ->
    ModuleT (
      List.map (subst_importtype s) its,
      List.map (subst_exporttype s) ets
    )


(* Recursive types *)

let roll_rectype x (rt : rectype) : rectype =
  let RecT sts = rt in
  let y = Int32.add x (Lib.List32.length sts) in
  let s = function
    | IdxX x' when x <= x' && x' < y -> VarHT (RecX (Int32.sub x' x))
    | var -> VarHT var
  in
  subst_rectype s rt

let roll_deftypes x (rt : rectype) : deftype list =
  let RecT sts as rt' = roll_rectype x rt in
  Lib.List32.mapi (fun i _ -> DefT (rt', i)) sts


let unroll_rectype (rt : rectype) : rectype =
  let s = function
    | RecX i -> DefHT (DefT (rt, i))
    | var -> VarHT var
  in
  subst_rectype s rt

let unroll_deftype (dt : deftype) : subtype =
  let DefT (rt, i) = dt in
  let RecT sts = unroll_rectype rt in
  Lib.List32.nth sts i

let expand_deftype (dt : deftype) : comptype =
  let SubT (_, _, st) = unroll_deftype dt in
  st


(* String conversion *)

let string_of_idx x =
  I32.to_string_u x

let string_of_name n =
  let b = Buffer.create 16 in
  let escape uc =
    if uc < 0x20 || uc >= 0x7f then
      Buffer.add_string b (Printf.sprintf "\\u{%02x}" uc)
    else begin
      let c = Char.chr uc in
      if c = '\"' || c = '\\' then Buffer.add_char b '\\';
      Buffer.add_char b c
    end
  in
  List.iter escape n;
  Buffer.contents b

let string_of_var = function
  | IdxX x -> I32.to_string_u x
  | RecX x -> "rec." ^ I32.to_string_u x

let string_of_null = function
  | NoNull -> ""
  | Null -> "null "

let string_of_final = function
  | NoFinal -> ""
  | Final -> " final"

let string_of_mut s = function
  | Cons -> s
  | Var -> "(mut " ^ s ^ ")"


let string_of_numtype = function
  | I32T -> "i32"
  | I64T -> "i64"
  | F32T -> "f32"
  | F64T -> "f64"

let string_of_addrtype at =
  string_of_numtype (numtype_of_addrtype at)

let string_of_vectype = function
  | V128T -> "v128"

let rec string_of_heaptype = function
  | AnyHT -> "any"
  | NoneHT -> "none"
  | EqHT -> "eq"
  | I31HT -> "i31"
  | StructHT -> "struct"
  | ArrayHT -> "array"
  | FuncHT -> "func"
  | NoFuncHT -> "nofunc"
  | ExnHT -> "exn"
  | NoExnHT -> "noexn"
  | ExternHT -> "extern"
  | NoExternHT -> "noextern"
  | VarHT x -> string_of_var x
  | DefHT dt -> "(" ^ string_of_deftype dt ^ ")"
  | BotHT -> "something"

and string_of_reftype = function
  | (nul, t) -> "(ref " ^ string_of_null nul ^ string_of_heaptype t ^ ")"

and string_of_valtype = function
  | NumT t -> string_of_numtype t
  | VecT t -> string_of_vectype t
  | RefT t -> string_of_reftype t
  | BotT -> "bot"

and string_of_resulttype = function
  | ts -> "[" ^ String.concat " " (List.map string_of_valtype ts) ^ "]"


and string_of_packtype = function
  | I8T -> "i8"
  | I16T -> "i16"

and string_of_storagetype = function
  | ValStorageT t -> string_of_valtype t
  | PackStorageT t -> string_of_packtype t

and string_of_fieldtype = function
  | FieldT (mut, t) -> string_of_mut (string_of_storagetype t) mut

and string_of_structtype = function
  | StructT fts ->
    String.concat " " (List.map (fun ft -> "(field " ^ string_of_fieldtype ft ^ ")") fts)

and string_of_arraytype = function
  | ArrayT ft -> string_of_fieldtype ft

and string_of_functype = function
  | FuncT (ts1, ts2) ->
    string_of_resulttype ts1 ^ " -> " ^ string_of_resulttype ts2

and string_of_comptype = function
  | StructCT st -> "struct " ^ string_of_structtype st
  | ArrayCT at -> "array " ^ string_of_arraytype at
  | FuncCT ft -> "func " ^ string_of_functype ft

and string_of_subtype = function
  | SubT (Final, [], ct) -> string_of_comptype ct
  | SubT (fin, hts, ct) ->
    String.concat " "
      (("sub" ^ string_of_final fin) :: List.map string_of_heaptype hts) ^
    " (" ^ string_of_comptype ct ^ ")"

and string_of_rectype = function
  | RecT [st] -> string_of_subtype st
  | RecT sts ->
    "rec " ^
    String.concat " " (List.map (fun st -> "(" ^ string_of_subtype st ^ ")") sts)

and string_of_deftype = function
  | DefT (RecT [st], 0l) -> string_of_subtype st
  | DefT (rt, i) -> "(" ^ string_of_rectype rt ^ ")." ^ I32.to_string_u i

let string_of_limits = function
  | {min; max} ->
    I64.to_string_u min ^
    (match max with None -> "" | Some n -> " " ^ I64.to_string_u n)

let string_of_memorytype = function
  | MemoryT (at, lim) -> string_of_addrtype at ^ " " ^ string_of_limits lim

let string_of_tabletype = function
  | TableT (at, lim, t) ->
    string_of_addrtype at ^ " " ^ string_of_limits lim ^ " " ^ string_of_reftype t

let string_of_globaltype = function
  | GlobalT (mut, t) -> string_of_mut (string_of_valtype t) mut

let string_of_tagtype = function
  | TagT dt -> string_of_deftype dt

let string_of_localtype = function
  | LocalT (Set, t) -> string_of_valtype t
  | LocalT (Unset, t) -> "(unset " ^ string_of_valtype t ^ ")"

let string_of_externtype = function
  | ExternFuncT dt -> "func " ^ string_of_deftype dt
  | ExternTableT tt -> "table " ^ string_of_tabletype tt
  | ExternMemoryT mt -> "memory " ^ string_of_memorytype mt
  | ExternGlobalT gt -> "global " ^ string_of_globaltype gt
  | ExternTagT tt -> "tag " ^ string_of_tagtype tt


let string_of_exporttype = function
  | ExportT (xt, name) ->
    "\"" ^ string_of_name name ^ "\" : " ^ string_of_externtype xt

let string_of_importtype = function
  | ImportT (xt, module_name, name) ->
    "\"" ^ string_of_name module_name ^ "\" \"" ^
      string_of_name name ^ "\" : " ^ string_of_externtype xt

let string_of_moduletype = function
  | ModuleT (its, ets) ->
    String.concat "" (
      List.map (fun it -> "import " ^ string_of_importtype it ^ "\n") its @
      List.map (fun et -> "export " ^ string_of_exporttype et ^ "\n") ets
    )
