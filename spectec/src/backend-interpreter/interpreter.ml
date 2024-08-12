open Reference_interpreter
open Ds
open Al
open Ast
open Al_util
open Construct
open Print
open Util
open Source
open Printf


(* Errors *)

let empty = ""

let error at msg step = raise (Exception.Error (at, msg, step))

let fail_expr expr msg =
  failwith ("on expr `" ^ string_of_expr expr ^ "` " ^ msg)

let fail_path path msg =
  failwith ("on path `" ^ string_of_path path ^ "` " ^ msg)

let try_with_error fname at stringifier f step =
  let prefix = if fname <> empty then "$" ^ fname ^ ": " else fname in
  try f step with
  | Construct.InvalidConversion msg
  | Exception.InvalidArg msg
  | Exception.InvalidFunc msg
  | Exception.FreeVar msg
  | Failure msg -> error at (prefix ^ msg) (stringifier step)


(* Matrix operations *)

let is_matrix matrix =
  match matrix with
  | [] -> true  (* Empty matrix is considered a valid matrix *)
  | row :: rows -> List.for_all (fun r -> List.length row = List.length r) rows

let transpose matrix =
  assert (is_matrix matrix);
  let rec transpose' = function
    | [] -> []
    | [] :: _ -> []
    | (x :: xs) :: xss ->
      let new_row = (x :: List.map List.hd xss) in
      let new_rows = transpose' (xs :: List.map List.tl xss) in
      new_row :: new_rows in
  transpose' matrix

let extract_exp a =
  match a.it with
  | ExpA e -> Some e
  | TypA _ -> None
let extract_expargs = List.filter_map extract_exp


let rec create_sub_al_context names iter env =
  let option_name_to_list name = lookup_env name env |> unwrap_optv |> Option.to_list in
  let name_to_list name = lookup_env name env |> unwrap_listv_to_list in
  let length_to_list l = List.init l al_of_int in

  let name_to_values name =
    match iter with
    | Opt -> option_name_to_list name
    | ListN (e_n, Some n') when name = n' ->
      eval_expr env e_n
      |> al_to_int
      |> length_to_list
    | _ -> name_to_list name
  in

  names
  |> List.map name_to_values
  |> transpose
  |> List.map (fun vs -> List.fold_right2 Env.add names vs env)

and access_path env base path =
  match path.it with
  | IdxP e' ->
    let a = base |> unwrap_listv_to_array in
    let i = eval_expr env e' |> al_to_int in
    begin try Array.get a i with
    | Invalid_argument _ ->
      fail_path path
        (sprintf "failed Array.get on base %s and index %s"
          (string_of_value base) (string_of_int i))
    end
  | SliceP (e1, e2) ->
    let a = base |> unwrap_listv_to_array in
    let i1 = eval_expr env e1 |> al_to_int in
    let i2 = eval_expr env e2 |> al_to_int in
    Array.sub a i1 i2 |> listV
  | DotP str -> (
    let str = Print.string_of_atom str in
    match base with
    | FrameV (_, StrV r) -> Record.find str r
    | StrV r -> Record.find str r
    | v ->
      fail_path path
        (sprintf "base %s is not a record" (string_of_value v))
    )

and replace_path env base path v_new =
  match path.it with
  | IdxP e' ->
    let a = unwrap_listv_to_array base |> Array.copy in
    let i = eval_expr env e' |> al_to_int in
    Array.set a i v_new;
    listV a
  | SliceP (e1, e2) ->
    let a = unwrap_listv_to_array base |> Array.copy in
    let i1 = eval_expr env e1 |> al_to_int in
    let i2 = eval_expr env e2 |> al_to_int in
    Array.blit (unwrap_listv_to_array v_new) 0 a i1 i2;
    listV a
  | DotP str ->
    let str = Print.string_of_atom str in
    let r =
      match base with
      | FrameV (_, StrV r) -> r
      | StrV r -> r
      | v ->
        fail_path path
          (sprintf "base %s is not a record" (string_of_value v))
    in
    let r_new = Record.clone r in
    Record.replace str v_new r_new;
    strV r_new

and check_type ty v expr =
  (* type definition *)
  let addr_refs = [
    "REF.I31_NUM"; "REF.STRUCT_ADDR"; "REF.ARRAY_ADDR";
    "REF.FUNC_ADDR"; "REF.HOST_ADDR"; "REF.EXTERN";
  ] in
  let pnn_types = [ "I8"; "I16" ] in
  let inn_types = [ "I32"; "I64" ] in
  let fnn_types = [ "F32"; "F64" ] in
  let vnn_types = [ "V128"; ] in
  let abs_heap_types = [
    "ANY"; "EQ"; "I31"; "STRUCT"; "ARRAY"; "NONE"; "FUNC";
    "NOFUNC"; "EXTERN"; "NOEXTERN"
  ] in
  match v with
  (* addrref *)
  | CaseV (ar, _) when List.mem ar addr_refs->
    boolV (ty = "addrref" ||ty = "ref" || ty = "val")
  (* nul *)
  | CaseV ("REF.NULL", _) ->
    boolV (ty = "nul" || ty = "ref" || ty = "val")
  (* values *)
  | CaseV ("CONST", CaseV (nt, []) ::_) when List.mem nt inn_types ->
    boolV (ty = "val")
  | CaseV ("CONST", CaseV (nt, []) ::_) when List.mem nt fnn_types ->
    boolV (ty = "val")
  | CaseV ("VCONST", CaseV (vt, [])::_) when List.mem vt vnn_types ->
    boolV (ty = "val")
  (* numtype *)
  | CaseV (nt, []) when List.mem nt inn_types ->
    boolV (ty = "Inn" || ty = "Jnn" || ty = "numtype" || ty = "valtype")
  | CaseV (nt, []) when List.mem nt fnn_types ->
    boolV (ty = "Fnn" || ty = "numtype" || ty = "valtype")
  | CaseV (vt, []) when List.mem vt vnn_types ->
    boolV (ty = "Vnn" || ty = "vectype" || ty = "valtype")
  (* valtype *)
  | CaseV ("REF", _) ->
    boolV (ty = "reftype" || ty = "valtype" || ty = "val")
  (* absheaptype *)
  | CaseV (aht, []) when List.mem aht abs_heap_types ->
    boolV (ty = "absheaptype" || ty = "heaptype")
  (* deftype *)
  | CaseV ("DEF", [ _; _ ]) ->
    boolV (ty = "deftype" || ty = "heaptype")
  (* typevar *)
  | CaseV ("_IDX", [ _ ]) ->
    boolV (ty = "heaptype" || ty = "typevar")
  (* heaptype *)
  | CaseV ("REC", [ _ ]) ->
    boolV (ty = "heaptype" || ty = "typevar")
  (* packval *)
  | CaseV ("PACK", CaseV (pt, [])::_) when List.mem pt pnn_types ->
    boolV (ty = "val")
  (* packtype *)
  | CaseV (pt, []) when List.mem pt pnn_types ->
    boolV (ty = "Pnn" || ty = "Jnn" || ty = "packtype" || ty = "storagetype")
  | v -> fail_expr expr
    (sprintf "%s doesn't have type %s" (structured_string_of_value v) ty)

and eval_expr env expr =
  let rec to_bool source = function
    | BoolV b -> b
    | ListV _ as v -> List.for_all (to_bool source) (unwrap_listv_to_list v)
    | _ -> fail_expr source "type mismatch for boolean value"
  in

  match expr.it with
  (* Value *)
  | NumE i -> numV i
  (* Numeric Operation *)
  | UnE (MinusOp, inner_e) -> eval_expr env inner_e |> al_to_z |> Z.neg |> numV
  | UnE (NotOp, e) -> eval_expr env e |> to_bool e |> not |> boolV
  | BinE (op, e1, e2) ->
    (match op, eval_expr env e1, eval_expr env e2 with
    | AddOp, NumV i1, NumV i2 -> Z.add i1 i2 |> numV
    | SubOp, NumV i1, NumV i2 -> Z.sub i1 i2 |> numV
    | MulOp, NumV i1, NumV i2 -> Z.mul i1 i2 |> numV
    | DivOp, NumV i1, NumV i2 -> Z.div i1 i2 |> numV
    | ModOp, NumV i1, NumV i2 -> Z.rem i1 i2 |> numV
    | ExpOp, NumV i1, NumV i2 -> Z.pow i1 (Z.to_int i2) |> numV
    | AndOp, b1, b2 -> boolV (to_bool e1 b1 && to_bool e2 b2)
    | OrOp, b1, b2 -> boolV (to_bool e1 b1 || to_bool e2 b2)
    | ImplOp, b1, b2 -> boolV (not (to_bool e1 b1) || to_bool e2 b2)
    | EquivOp, b1, b2 -> boolV (to_bool e1 b1 = to_bool e2 b2)
    | EqOp, v1, v2 -> boolV (v1 = v2)
    | NeOp, v1, v2 -> boolV (v1 <> v2)
    | LtOp, v1, v2 -> boolV (v1 < v2)
    | GtOp, v1, v2 -> boolV (v1 > v2)
    | LeOp, v1, v2 -> boolV (v1 <= v2)
    | GeOp, v1, v2 -> boolV (v1 >= v2)
    | _ -> fail_expr expr "type mismatch for binary operation"
    )
  (* Set Operation *)
  | MemE (e1, e2) ->
    let v1 = eval_expr env e1 in
    eval_expr env e2 |> unwrap_listv_to_array |> Array.exists ((=) v1) |> boolV
  (* Function Call *)
  | CallE (fname, al) ->
    let el = extract_expargs al in
    let args = List.map (eval_expr env) el in
    (match call_func fname args  with
    | Some v -> v
    | _ -> raise (Exception.MissingReturnValue fname)
    )
  | InvCallE (fname, _, al) ->
    let el = extract_expargs al in
    (* TODO: refactor numerics function name *)
    let args = List.map (eval_expr env) el in
    (match call_func ("inverse_of_"^fname) args  with
    | Some v -> v
    | _ -> raise (Exception.MissingReturnValue fname)
    )
  (* Data Structure *)
  | ListE el -> List.map (eval_expr env) el |> listV_of_list
  | CatE (e1, e2) ->
    let a1 = eval_expr env e1 |> unwrap_listv_to_array in
    let a2 = eval_expr env e2 |> unwrap_listv_to_array in
    Array.append a1 a2 |> listV
  | LenE e ->
    eval_expr env e |> unwrap_listv_to_array |> Array.length |> Z.of_int |> numV
  | StrE r ->
    r |> Record.map Print.string_of_atom (eval_expr env) |> strV
  | AccE (e, p) ->
    let base = eval_expr env e in
    access_path env base p
  | ExtE (e1, ps, e2, dir) ->
    let rec extend ps base =
      match ps with
      | path :: rest -> access_path env base path |> extend rest |> replace_path env base path
      | [] ->
        let v = eval_expr env e2 |> unwrap_listv_to_array in
        let a_copy = base |> unwrap_listv_to_array |> Array.copy in
        let a_new =
          match dir with
          | Front -> Array.append v a_copy
          | Back -> Array.append a_copy v
        in
        listV a_new
    in
    eval_expr env e1 |> extend ps
  | UpdE (e1, ps, e2) ->
    let rec replace ps base =
      match ps with
      | path :: rest -> access_path env base path |> replace rest |> replace_path env base path
      | [] -> eval_expr env e2 in
    eval_expr env e1 |> replace ps
  | CaseE (tag, el) -> caseV (Print.string_of_atom tag, List.map (eval_expr env) el)
  | CaseE2 (op, el) -> caseV (Print.string_of_mixop op, List.map (eval_expr env) el)
  | OptE opt -> Option.map (eval_expr env) opt |> optV
  | TupE el -> List.map (eval_expr env) el |> tupV
  (* Context *)
  | ArityE e ->
    (match eval_expr env e with
    | LabelV (v, _) -> v
    | FrameV (Some v, _) -> v
    | FrameV _ -> numV Z.zero
    | _ -> fail_expr expr "inner expr is not a context" (* Due to AL validation, unreachable *))
  | FrameE (e_opt, e) ->
    let arity =
      match Option.map (eval_expr env) e_opt with
      | None | Some (NumV _) as arity -> arity
      | _ -> fail_expr expr "wrong arity of frame"
    in
    let r =
      match eval_expr env e with
      | StrV _ as v -> v
      | _ -> fail_expr expr "inner expr is not a frame"
    in
    FrameV (arity, r)
  | GetCurFrameE -> WasmContext.get_current_frame ()
  | LabelE (e1, e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    LabelV (v1, v2)
  | GetCurLabelE -> WasmContext.get_current_label ()
  | ContE e ->
    (match eval_expr env e with
    | LabelV (_, vs) -> vs
    | _ -> fail_expr expr "inner expr is not a label")
  | ChooseE e ->
    let a = eval_expr env e |> unwrap_listv_to_array in
    if Array.length a = 0 then
      fail_expr expr (sprintf "cannot choose an element from %s because it's empty" (string_of_expr e))
    else
      Array.get a 0
  | VarE "s" -> Store.get ()
  | VarE name -> lookup_env name env
  (* Optimized getter for simple IterE(VarE, ...) *)
  | IterE ({ it = VarE name; _ }, [name'], _) when name = name' ->
    lookup_env name env
  (* Optimized getter for list init *)
  | IterE (e1, [], ListN (e2, None)) ->
    let v = eval_expr env e1 in
    let i = eval_expr env e2 |> al_to_int in
    if i > 1024 * 64 * 1024 (* 1024 pages *) then
      raise Exception.OutOfMemory
    else
      Array.make i v |> listV
  | IterE (inner_e, ids, iter) ->
    let vs =
      env
      |> create_sub_al_context ids iter
      |> List.map (fun env' -> eval_expr env' inner_e)
    in

    (match vs, iter with
    | [], Opt -> optV None
    | [v], Opt -> Option.some v |> optV
    | l, _ -> listV_of_list l)
  (* condition *)
  | TopFrameE ->
    let ctx = WasmContext.get_top_context () in
    (match ctx with
    | Some (FrameV _) -> boolV true
    | _ -> boolV false)
  | TopLabelE ->
    let ctx = WasmContext.get_top_context () in
    (match ctx with
    | Some (LabelV _) -> boolV true
    | _ -> boolV false)
  | IsDefinedE e ->
    e
    |> eval_expr env
    |> unwrap_optv
    |> Option.is_some
    |> boolV
  | IsCaseOfE (e, expected_tag) ->
    let expected_tag = Print.string_of_atom expected_tag in
    (match eval_expr env e with
    | CaseV (tag, _) -> boolV (expected_tag = tag)
    | _ -> boolV false)
  (* TODO : This should be replaced with executing the validation algorithm *)
  | IsValidE e ->
    let valid_lim k = function
      | TupV [ NumV n; NumV m ] -> n <= m && m <= k
      | _ -> false
    in
    (match eval_expr env e with
    (* valid_tabletype *)
    | TupV [ lim; _ ] -> valid_lim (Z.of_int 0xffffffff) lim |> boolV
    (* valid_memtype *)
    | CaseV ("PAGE", [ lim ]) -> valid_lim (Z.of_int 0x10000) lim |> boolV
    (* valid_other *)
    | _ ->
      fail_expr expr "TODO: deferring validation to reference interpreter"
    )
  | HasTypeE (e, s) ->
    (* TODO: This shouldn't be hardcoded *)
    (* check type *)
    let v = eval_expr env e in
    check_type s v expr
  | MatchE (e1, e2) ->
    (* Deferred to reference interpreter *)
    let rt1 = e1 |> eval_expr env |> Construct.al_to_ref_type in
    let rt2 = e2 |> eval_expr env |> Construct.al_to_ref_type in
    boolV (Match.match_ref_type [] rt1 rt2)
  | TopValueE _ ->
    (* TODO: type check *)
    boolV (List.length (WasmContext.get_value_stack ()) > 0)
  | TopValuesE e ->
    let i = eval_expr env e |> al_to_int in
    boolV (List.length (WasmContext.get_value_stack ()) >= i)
  | _ -> fail_expr expr "cannot evaluate expr"


(* Assignment *)

and has_same_keys re rv =
  let k1 = Record.keys re |> List.map string_of_atom |> List.sort String.compare in
  let k2 = Record.keys rv |> List.sort String.compare in
  k1 = k2

and merge env acc =
  let f _ v1 v2 =
    let wrapped =
      match iter_type_of_value v2 with
      | List | List1 | ListN _ ->
        unwrap_listv_to_array v2 |> Array.append [| v1 |] |> listV
      | Opt -> optV (Some v1)
    in
    Some wrapped
  in
  Env.union f env acc

and assign lhs rhs env =
  match lhs.it, rhs with
  | IterE ({ it = VarE name; _ }, _, (List|List1)), ListV _
  | VarE name, _ -> Env.add name rhs env
  | IterE (e, ids, iter), _ ->
    (* Convert rhs to iterable list *)
    let rhs_default, rhs_iter =
      match rhs with
      | OptV opt -> optV None, Option.to_list opt
      | ListV arr -> empty_list, Array.to_list !arr
      | _ ->
        fail_expr lhs
          (sprintf
            "invalid assignment: %s is not an iterable value" (string_of_value rhs)
          )
    in

    (* Assign length variable *)
    let env_with_length =
      match iter with
      | ListN (expr, opt) ->
        if Option.is_some opt then
          fail_expr lhs "invalid assignment: iter with index cannot be an assignment target"
        else
          let length = numV_of_int (List.length rhs_iter) in
          assign expr length env
      | _ -> env
    in

    (* Assign iter variable *)
    ids
    |> List.map (fun n -> n, rhs_default)
    |> List.to_seq
    |> Env.of_seq
    |> List.fold_right merge
      (List.map (fun v -> assign e v Env.empty) rhs_iter)
    |> Env.union (fun _ _ v -> Some v) env_with_length
  | TupE lhs_s, TupV rhs_s
    when List.length lhs_s = List.length rhs_s ->
    List.fold_right2 assign lhs_s rhs_s env
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
    List.fold_right2 assign lhs_s (Array.to_list !rhs_s) env
  | CaseE (lhs_tag, lhs_s), CaseV (rhs_tag, rhs_s)
    when (Print.string_of_atom lhs_tag) = rhs_tag && List.length lhs_s = List.length rhs_s ->
    List.fold_right2 assign lhs_s rhs_s env
  | CaseE2 (op, lhs_s), CaseV (rhs_tag, rhs_s)
    when (Print.string_of_mixop op) = rhs_tag && List.length lhs_s = List.length rhs_s ->
    List.fold_right2 assign lhs_s rhs_s env
  | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs env
  (* Assumption: e1 is the assign target *)
  | BinE (binop, e1, e2), NumV m ->
    let invop =
      match binop with
      | AddOp -> Z.sub
      | SubOp -> Z.add
      | MulOp -> Z.div
      | DivOp -> Z.mul
      | ExpOp -> fail_expr lhs "invalid assignment: ExpOp cannot be an assignment target"
      | _ -> fail_expr lhs "invalid assignment: logical binop cannot be an assignment target" in
    let v = eval_expr env e2 |> al_to_z |> invop m |> numV in
    assign e1 v env
  | CatE _, ListV vs -> assign_split lhs !vs env
  | StrE r1, StrV r2 when has_same_keys r1 r2 ->
    Record.fold (fun k v acc -> (Record.find (Print.string_of_atom k) r2 |> assign v) acc) r1 env
  | _, _ ->
    fail_expr lhs
      (sprintf "invalid assignment: on rhs %s" (string_of_value rhs))

and assign_split lhs vs env =
  let ep, es = unwrap_cate lhs in
  let len = Array.length vs in
  let prefix_len, suffix_len =
    let get_fixed_length e =
      match e.it with
      | ListE es -> Some (List.length es)
      | IterE (_, _, ListN (e, None)) -> Some (al_to_int (eval_expr env e))
      | _ -> None
    in
    match get_fixed_length ep, get_fixed_length es with
    | None, None ->
      fail_expr lhs
        "invalid assignment: non-deterministic pattern cannot be an assignment target"
    | Some l, None -> l, len - l
    | None, Some l -> len - l, l
    | Some l1, Some l2 -> l1, l2
  in
  if prefix_len < 0 || suffix_len < 0 then
    fail_expr lhs "invalid assignment: negative length cannot be an assignment target"
  else if prefix_len + suffix_len <> len then
    fail_expr lhs
      (sprintf "invalid assignment: %s's length is not equal to lhs"
        (string_of_value (listV vs))
      )
  else (
    let prefix = Array.sub vs 0 prefix_len |> listV in
    let suffix = Array.sub vs prefix_len suffix_len |> listV in
    env |> assign ep prefix |> assign es suffix
  )


(* Step *)

and step_instr (fname: string) (ctx: AlContext.t) (env: value Env.t) (instr: instr) : AlContext.t =
  (Info.find instr.note).covered <- true;

  let rec is_true = function
    | BoolV true -> true
    | OptV v_opt -> v_opt |> Option.map is_true |> Option.value ~default:true
    | ListV a -> Array.for_all is_true !a
    | _ -> false
  in


  match instr.it with
  (* Block instruction *)
  | IfI (e, il1, il2) ->
    if is_true (eval_expr env e) then
      AlContext.add_instrs il1 ctx
    else
      AlContext.add_instrs il2 ctx
  | EitherI (il1, il2) ->
    (try
      ctx |> AlContext.add_instrs il1 |> run
    with
    | Exception.MissingReturnValue _
    | Exception.OutOfMemory ->
      AlContext.add_instrs il2 ctx
    )
  | AssertI _e -> ctx
  (*
    if is_true (eval_expr env e) then
      ctx
    else
      fail_expr e "assertion fail"
  *)
  | PushI e ->
    (match eval_expr env e with
    | FrameV _ as v -> WasmContext.push_context (v, [], [])
    | ListV vs -> Array.iter WasmContext.push_value !vs
    | v -> WasmContext.push_value v
    );
    ctx
  | PopI e ->
    (match e.it with
    | FrameE (_, inner_e) ->
      (match WasmContext.pop_context () with
      | FrameV (_, inner_v), _, _ ->
        let new_env = assign inner_e inner_v env in
        AlContext.set_env new_env ctx
      | v, _, _ -> failwith (sprintf "current context `%s` is not a frame" (string_of_value v))
      )
    | IterE ({ it = VarE name; _ }, [name'], ListN (e', None)) when name = name' ->
      let i = eval_expr env e' |> al_to_int in
      let v =
        List.init i (fun _ -> WasmContext.pop_value ())
        |> List.rev
        |> listV_of_list
      in
      AlContext.update_env name v ctx
    | _ ->
      let new_env = assign e (WasmContext.pop_value ()) env in
      AlContext.set_env new_env ctx
    )
  | PopAllI e ->
    let v = WasmContext.pop_value_stack () |> List.rev |> listV_of_list in
    let new_env = assign e v env in
    AlContext.set_env new_env ctx
  | LetI (e1, e2) ->
    let new_env = ctx |> AlContext.get_env |> assign e1 (eval_expr env e2) in
    AlContext.set_env new_env ctx
  | PerformI (f, al) ->
    let el = extract_expargs al in
    let args = List.map (eval_expr env) el in
    call_func f args |> ignore;
    ctx
  | TrapI -> raise Exception.Trap
  | NopI -> ctx
  | ReturnI None -> AlContext.tl ctx
  | ReturnI (Some e) ->
    AlContext.return (eval_expr env e) :: AlContext.tl ctx
  | ExecuteI e ->
    let v = eval_expr env e in
    (match v with
    | ListV _ ->
      let ctx' = v |> unwrap_listv_to_list |> List.map AlContext.execute in
      ctx' @ ctx
    | _ -> AlContext.execute v :: ctx
    )
  | EnterI (e1, e2, il) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    WasmContext.push_context (v1, [], unwrap_listv_to_list v2);
    AlContext.enter (fname, il, env) :: ctx
  | ExitI _ ->
    WasmContext.pop_context () |> ignore;
    AlContext.decrease_depth ctx
  | ReplaceI (e1, { it = IdxP e2; _ }, e3) ->
    let a = eval_expr env e1 |> unwrap_listv_to_array in
    let i = eval_expr env e2 |> al_to_int in
    let v = eval_expr env e3 in
    Array.set a i v;
    ctx
  | ReplaceI (e1, { it = SliceP (e2, e3); _ }, e4) ->
    let a1 = eval_expr env e1 |> unwrap_listv_to_array in (* dest *)
    let i1 = eval_expr env e2 |> al_to_int in   (* start index *)
    let i2 = eval_expr env e3 |> al_to_int in   (* length *)
    let a2 = eval_expr env e4 |> unwrap_listv_to_array in (* src *)
    assert (Array.length a2 = i2);
    Array.blit a2 0 a1 i1 i2;
    ctx
  | ReplaceI (r, { it = DotP s; _ }, e) ->
    let s = Print.string_of_atom s in
    r
    |> eval_expr env
    |> unwrap_strv
    |> Record.replace s (eval_expr env e);
    ctx
  | AppendI (e1, e2) ->
    let a = eval_expr env e1 |> unwrap_listv in
    (match e2.note.it, eval_expr env e2 with
    | IterT _, ListV arr_ref -> a := Array.append !a !arr_ref
    | IterT (_, Opt), OptV opt ->
      a := opt |> Option.to_list |> Array.of_list |> Array.append !a
    | IterT _, v ->
      v
      |> string_of_value
      |> sprintf "the expression is evaluated to %s, not a iterable data type"
      |> fail_expr e2
    | _, v -> a := Array.append !a [|v|]
    );
    ctx
  | _ -> failwith "cannot step instr"

and try_step_instr fname ctx env instr =
  try_with_error fname instr.at string_of_instr (step_instr fname ctx env) instr

and step_wasm (ctx: AlContext.t) : value -> AlContext.t = function
  (* TODO: Change ref.null semantics *)
  | CaseV ("REF.NULL", [ ht ]) when !version = 3 ->
    let mm =
      WasmContext.get_current_frame ()
      |> unwrap_framev
      |> strv_access "MODULE"
    in
    (* TODO: some *)
    let null = caseV ("NULL", [ optV (Some (listV [||])) ]) in
    let dummy_rt = CaseV ("REF", [ null; ht ]) in

    (* substitute heap type *)
    (match call_func "inst_reftype" [ mm; dummy_rt ] with
    | Some (CaseV ("REF", [ n; ht' ])) when n = null ->
      CaseV ("REF.NULL", [ ht' ]) |> WasmContext.push_value
    | _ -> raise (Exception.MissingReturnValue "inst_reftype"));
    ctx
  | CaseV ("REF.NULL", _)
  | CaseV ("CONST", _)
  | CaseV ("VCONST", _) as v -> WasmContext.push_value v; ctx
  | CaseV (name, []) when Builtin.is_builtin name -> Builtin.call name; ctx
  | CaseV (fname, args) -> create_context fname args :: ctx
  | v -> fail_value "cannot step a wasm instr" v


and try_step_wasm ctx v =
  try_with_error empty no_region structured_string_of_value (step_wasm ctx) v

and step : AlContext.t -> AlContext.t = AlContext.(function
  | Al (name, il, env) :: ctx ->
    (match il with
    | [] -> ctx
    | [ instr ] when AlContext.can_tail_call instr -> try_step_instr name ctx env instr
    | h :: t ->
      let new_ctx = Al (name, t, env) :: ctx in
      try_step_instr name new_ctx env h
    )
  | Wasm n :: ctx ->
    if n = 0 then
      ctx
    else
      try_step_wasm (Wasm n :: ctx) (WasmContext.pop_instr ())
  | Enter (name, il, env) :: ctx ->
    (match il with
    | [] ->
      (match ctx with
      | Wasm n :: t -> Wasm (n + 1) :: t
      | Enter (_, [], _) :: t -> Wasm 2 :: t
      | ctx -> Wasm 1 :: ctx
      )
    | h :: t ->
      let new_ctx = Enter (name, t, env) :: ctx in
      try_step_instr name new_ctx env h
    )
  | Execute v :: ctx -> try_step_wasm ctx v
  | _ -> assert false
)


(* AL interpreter Entry *)

and run (ctx: AlContext.t) : AlContext.t =
  if AlContext.is_reducible ctx then run (step ctx) else ctx

and create_context (name: string) (args: value list) : AlContext.mode =
  let algo = lookup_algo name in
  let params = params_of_algo algo in
  let body = body_of_algo algo in

  let params = params |> extract_expargs in

  if List.length args <> List.length params then (
    error
      algo.at
      (Printf.sprintf "Expected %d arguments for the algorithm `%s` but %d arguments are given"
        (List.length params)
        name
        (List.length args))
      (string_of_value (CaseV (name, args)))
  );

  let env =
    Env.empty
    |> List.fold_right2 assign params args
  in

  AlContext.al (name, body, env)

and call_func (name: string) (args: value list) : value option =
  (* Module & Runtime *)
  if bound_func name then
    [create_context name args]
    |> run
    |> AlContext.get_return_value
  (* Numerics *)
  else if Numerics.mem name then
    Some (Numerics.call_numerics name args)
  (* Manual *)
  else if Manual.mem name then
    Some (Manual.call_func name args)
  else
    raise (Exception.InvalidFunc ("There is no function named: " ^ name))


(* Wasm interpreter entry *)

let instantiate (args: value list) : value =
  WasmContext.init_context ();
  match call_func "instantiate" args with
  | Some module_inst -> module_inst
  | None -> failwith "Instantiation doesn't return module instance"

let invoke (args: value list) : value =
  WasmContext.init_context ();
  match call_func "invoke" args with
  | Some v -> v
  | None -> failwith "Invocation doesn't return any values"
