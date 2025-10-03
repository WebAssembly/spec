open Types


(* Context *)

type context = deftype list

let lookup c x = Lib.List32.nth c x


(* Extremas *)

let abs_of_comptype _c = function
  | StructT _ | ArrayT _ -> StructHT
  | FuncT _ -> FuncHT

let rec top_of_comptype c ct =
  top_of_heaptype c (abs_of_comptype c ct)

and top_of_typeuse c = function
  | Idx x -> top_of_comptype c (expand_deftype (lookup c x))
  | Rec _ -> assert false
  | Def dt -> top_of_comptype c (expand_deftype dt)

and top_of_heaptype c = function
  | AnyHT | NoneHT | EqHT | StructHT | ArrayHT | I31HT -> AnyHT
  | FuncHT | NoFuncHT -> FuncHT
  | ExnHT | NoExnHT -> ExnHT
  | ExternHT | NoExternHT -> ExternHT
  | UseHT ut -> top_of_typeuse c ut
  | BotHT -> assert false

let top_of_valtype c = function
  | NumT _ as t -> t
  | VecT _ as t -> t
  | RefT (_, ht) -> RefT (Null, top_of_heaptype c ht)
  | BotT -> BotT (* well.. *)

let rec bot_of_comptype c ct =
  bot_of_heaptype c (abs_of_comptype c ct)

and bot_of_typeuse c = function
  | Idx x -> bot_of_comptype c (expand_deftype (lookup c x))
  | Rec _ -> assert false
  | Def dt -> bot_of_comptype c (expand_deftype dt)

and bot_of_heaptype c = function
  | AnyHT | NoneHT | EqHT | StructHT | ArrayHT | I31HT -> NoneHT
  | FuncHT | NoFuncHT -> NoFuncHT
  | ExnHT | NoExnHT -> NoExnHT
  | ExternHT | NoExternHT -> NoExternHT
  | UseHT ut -> bot_of_typeuse c ut
  | BotHT -> assert false


(* Subtyping *)

let match_null _c nul1 nul2 =
  match nul1, nul2 with
  | NoNull, Null -> true
  | _, _ -> nul1 = nul2

let match_limits _c lim1 lim2 =
  I64.ge_u lim1.min lim2.min &&
  match lim1.max, lim2.max with
  | _, None -> true
  | None, Some _ -> false
  | Some i, Some j -> I64.le_u i j


let match_numtype _c t1 t2 =
  t1 = t2

let match_vectype _c t1 t2 =
  t1 = t2

let rec match_heaptype c t1 t2 =
  match t1, t2 with
  | EqHT, AnyHT -> true
  | StructHT, AnyHT -> true
  | ArrayHT, AnyHT -> true
  | I31HT, AnyHT -> true
  | I31HT, EqHT -> true
  | StructHT, EqHT -> true
  | ArrayHT, EqHT -> true
  | NoneHT, t -> match_heaptype c t AnyHT
  | NoFuncHT, t -> match_heaptype c t FuncHT
  | NoExnHT, t -> match_heaptype c t ExnHT
  | NoExternHT, t -> match_heaptype c t ExternHT
  | UseHT (Idx x1), _ -> match_heaptype c (UseHT (Def (lookup c x1))) t2
  | _, UseHT (Idx x2) -> match_heaptype c t1 (UseHT (Def (lookup c x2)))
  | UseHT (Def dt1), UseHT (Def dt2) -> match_deftype c dt1 dt2
  | UseHT (Def dt), t ->
    (match expand_deftype dt, t with
    | StructT _, AnyHT -> true
    | StructT _, EqHT -> true
    | StructT _, StructHT -> true
    | ArrayT _, AnyHT -> true
    | ArrayT _, EqHT -> true
    | ArrayT _, ArrayHT -> true
    | FuncT _, FuncHT -> true
    | _ -> false
    )
  | BotHT, _ -> true
  | _, _ -> t1 = t2

and match_reftype c t1 t2 =
  match t1, t2 with
  | (nul1, t1'), (nul2, t2') ->
    match_null c nul1 nul2 && match_heaptype c t1' t2'

and match_valtype c t1 t2 =
  match t1, t2 with
  | NumT t1', NumT t2' -> match_numtype c t1' t2'
  | VecT t1', VecT t2' -> match_vectype c t1' t2'
  | RefT t1', RefT t2' -> match_reftype c t1' t2'
  | BotT, _ -> true
  | _, _ -> false

and match_resulttype c ts1 ts2 =
  List.length ts1 = List.length ts2 &&
  List.for_all2 (match_valtype c) ts1 ts2


and match_packtype _c t1 t2 =
  t1 = t2

and match_storagetype c st1 st2 =
  match st1, st2 with
  | ValStorageT t1, ValStorageT t2 -> match_valtype c t1 t2
  | PackStorageT t1, PackStorageT t2 -> match_packtype c t1 t2
  | _, _ -> false

and match_fieldtype c (FieldT (mut1, st1)) (FieldT (mut2, st2)) =
  mut1 = mut2 && match_storagetype c st1 st2 &&
  match mut1 with
  | Cons -> true
  | Var -> match_storagetype c st2 st1

and match_comptype c ct1 ct2 =
  match ct1, ct2 with
  | StructT fts1, StructT fts2 ->
    List.length fts1 >= List.length fts2 &&
    List.for_all2 (match_fieldtype c) (Lib.List.take (List.length fts2) fts1) fts2
  | ArrayT ft1, ArrayT ft2 ->
    match_fieldtype c ft1 ft2
  | FuncT (ts11, ts12), FuncT (ts21, ts22) ->
    match_resulttype c ts21 ts11 && match_resulttype c ts12 ts22
  | _, _ -> false

and match_deftype c dt1 dt2 =
  dt1 == dt2 ||  (* optimisation *)
  let s = subst_of c in subst_deftype s dt1 = subst_deftype s dt2 ||
  let SubT (_fin, uts1, _st) = unroll_deftype dt1 in
  List.exists (fun ut1 -> match_heaptype c (UseHT ut1) (UseHT (Def dt2))) uts1

let match_tagtype c (TagT ut1) (TagT ut2) =
  match ut1, ut2 with
  | Def dt1, Def dt2 -> match_deftype c dt1 dt2 && match_deftype c dt2 dt1
  | _, _ -> assert false

let match_globaltype c (GlobalT (mut1, t1)) (GlobalT (mut2, t2)) =
  mut1 = mut2 && match_valtype c t1 t2 &&
  match mut1 with
  | Cons -> true
  | Var -> match_valtype c t2 t1

let match_memorytype c (MemoryT (at1, lim1)) (MemoryT (at2, lim2)) =
  at1 = at2 && match_limits c lim1 lim2

let match_tabletype c (TableT (at1, lim1, t1)) (TableT (at2, lim2, t2)) =
  at1 = at2 && match_limits c lim1 lim2 &&
  match_reftype c t1 t2 && match_reftype c t2 t1

let match_externtype c xt1 xt2 =
  match xt1, xt2 with
  | ExternTagT tt1, ExternTagT tt2 -> match_tagtype c tt1 tt2
  | ExternGlobalT gt1, ExternGlobalT gt2 -> match_globaltype c gt1 gt2
  | ExternMemoryT mt1, ExternMemoryT mt2 -> match_memorytype c mt1 mt2
  | ExternTableT tt1, ExternTableT tt2 -> match_tabletype c tt1 tt2
  | ExternFuncT (Def dt1), ExternFuncT (Def dt2) -> match_deftype c dt1 dt2
  | _, _ -> false
