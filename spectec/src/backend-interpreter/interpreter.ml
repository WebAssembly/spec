open Reference_interpreter
open Ds
open Al
open Ast
open Al_util
open Xl
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
  |(Exception.WrongConversion _
  | Exception.ArgMismatch _
  | Exception.UnknownFunc _
  | Exception.FreeVar _) as e -> error at (prefix ^ Printexc.to_string e) (stringifier step)
  | Failure msg -> error at (prefix ^ msg) (stringifier step)

let warn msg = print_endline ("warning: " ^ msg)


(* Hints *)

(* Try to find a hint `hintid` on a spectec function definition `fname`. *)
let find_hint fname hintid =
  let open Il.Ast in
  let open Il2al.Il2al_util in
  List.find_map (fun hintdef ->
    match hintdef.it with
    | DecH (id', hints) when fname = id'.it ->
      List.find_opt (fun hint -> hint.hintid.it = hintid) hints
    | _ -> None
  ) !hintdefs


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

let is_not_typarg a =
  match a.it with
  | TypA _ -> false
  | _ -> true
let remove_typargs = List.filter is_not_typarg

let dispatch_fname f env =
  match lookup_env_opt ("$" ^ f) env with
  | Some (FnameV f') -> f'
  | _ -> f

let rec create_sub_env (iter, xes) env =
  let length_to_list l = List.init l al_of_nat in

  let xe_to_values (x, e) =
    match iter with
    | ListN (e_n, Some x') when x = x' ->
      eval_expr env e_n |> al_to_nat |> length_to_list
    | Opt ->
      eval_expr env e |> unwrap_optv |> Option.to_list
    | _ ->
      eval_expr env e |> unwrap_listv_to_list
  in

  let xs = List.map fst xes in

  xes
  |> List.map xe_to_values
  |> transpose
  |> List.map (fun vs -> List.fold_right2 Env.add xs vs env)

and access_path env base path =
  match path.it with
  | IdxP e' ->
    let a = base |> unwrap_listv_to_array in
    let i = eval_expr env e' |> al_to_nat in
    begin try Array.get a i with
    | Invalid_argument _ ->
      fail_path path
        (sprintf "failed Array.get on base %s and index %s"
          (string_of_value base) (string_of_int i))
    end
  | SliceP (e1, e2) ->
    let a = base |> unwrap_listv_to_array in
    let i1 = eval_expr env e1 |> al_to_nat in
    let i2 = eval_expr env e2 |> al_to_nat in
    Array.sub a i1 i2 |> listV
  | DotP str -> (
    let str = Print.string_of_atom str in
    match base with
    | StrV r -> Record.find str r
    | v ->
      fail_path path
        (sprintf "base %s is not a record" (string_of_value v))
    )

and replace_path env base path v_new =
  match path.it with
  | IdxP e' ->
    let a = unwrap_listv_to_array base |> Array.copy in
    let i = eval_expr env e' |> al_to_nat in
    Array.set a i v_new;
    listV a
  | SliceP (e1, e2) ->
    let a = unwrap_listv_to_array base |> Array.copy in
    let i1 = eval_expr env e1 |> al_to_nat in
    let i2 = eval_expr env e2 |> al_to_nat in
    Array.blit (unwrap_listv_to_array v_new) 0 a i1 i2;
    listV a
  | DotP str ->
    let str = Print.string_of_atom str in
    let r =
      match base with
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
  let abs_heaptypes = [
    "ANY"; "EQ"; "I31"; "STRUCT"; "ARRAY"; "NONE"; "FUNC";
    "NOFUNC"; "EXN"; "NOEXN"; "EXTERN"; "NOEXTERN"
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
    boolV (ty = "Inn" || ty = "Jnn" || ty = "numtype" || ty = "valtype" || ty = "consttype")
  | CaseV (nt, []) when List.mem nt fnn_types ->
    boolV (ty = "Fnn" || ty = "numtype" || ty = "valtype" || ty = "consttype")
  | CaseV (vt, []) when List.mem vt vnn_types ->
    boolV (ty = "Vnn" || ty = "vectype" || ty = "valtype" || ty = "consttype")
  (* valtype *)
  | CaseV ("REF", _) ->
    boolV (ty = "reftype" || ty = "valtype" || ty = "val")
  (* absheaptype *)
  | CaseV (aht, []) when List.mem aht abs_heaptypes ->
    boolV (ty = "absheaptype" || ty = "heaptype")
  (* deftype *)
  | CaseV ("_DEF", [ _; _ ]) ->
    boolV (ty = "heaptype" || ty = "typeuse" || ty = "deftype")
  (* typevar *)
  | CaseV ("_IDX", [ _ ]) ->
    boolV (ty = "heaptype" || ty = "typeuse" || ty = "typevar")
  (* heaptype *)
  | CaseV ("REC", [ _ ]) ->
    boolV (ty = "heaptype" || ty = "typeuse" || ty = "typevar")
  (* packval *)
  | CaseV ("PACK", CaseV (pt, [])::_) when List.mem pt pnn_types ->
    boolV (ty = "val")
  (* packtype *)
  | CaseV (pt, []) when List.mem pt pnn_types ->
    boolV (ty = "Pnn" || ty = "Jnn" || ty = "packtype" || ty = "storagetype")
  | v -> fail_expr expr
    (sprintf "cannot decide if %s has type %s" (structured_string_of_value v) ty)

and eval_expr env expr =
  let rec to_bool source = function
    | BoolV b -> b
    | ListV _ as v -> List.for_all (to_bool source) (unwrap_listv_to_list v)
    | _ -> fail_expr source "type mismatch for boolean value"
  in

  match expr.it with
  (* Value *)
  | NumE n -> numV n
  | BoolE b -> boolV b
  (* Numeric Operation *)
  | CvtE (e1, _, nt) ->
    (match eval_expr env e1 with
    | NumV n1 ->
      (match Num.cvt nt n1 with
      | Some n -> numV n
      | None -> fail_expr expr ("conversion not defined for " ^ string_of_value (NumV n1))
      )
    | v -> fail_expr expr ("type mismatch for conversion operation on " ^ string_of_value v)
    )
  | UnE (op, e1) ->
    (match op, eval_expr env e1 with
    | #Bool.unop as op', v -> Bool.un op' (to_bool e1 v) |> boolV
    | #Num.unop as op', NumV n1 ->
      (match Num.un op' n1 with
      | Some n -> numV n
      | None -> fail_expr expr ("unary operation `" ^ Num.string_of_unop op' ^ "` not defined for " ^ string_of_value (NumV n1))
      )
    | _, v -> fail_expr expr ("type mismatch for unary operation on " ^ string_of_value v)
    )
  | BinE (op, e1, e2) ->
    (match op, eval_expr env e1, eval_expr env e2 with
    | #Bool.binop as op', v1, v2 -> Bool.bin op' (to_bool e1 v1) (to_bool e2 v2) |> boolV
    | #Num.binop as op', NumV n1, NumV n2 ->
      (match Num.bin op' n1 n2 with
      | Some n -> numV n
      | None -> fail_expr expr ("binary operation `" ^ Num.string_of_binop op' ^ "` not defined for " ^ string_of_value (NumV n1) ^ ", " ^ string_of_value (NumV n2))
      )
    | #Bool.cmpop as op', v1, v2 -> boolV (Bool.cmp op' v1 v2)
    | #Num.cmpop as op', NumV n1, NumV n2 ->
      (match Num.cmp op' n1 n2 with
      | Some b -> boolV b
      | None -> fail_expr expr ("comparison operation `" ^ Num.string_of_cmpop op' ^ "` not defined for " ^ string_of_value (NumV n1) ^ ", " ^ string_of_value (NumV n2))
      )
    | _, v1, v2 -> fail_expr expr ("type mismatch for binary operation on " ^ string_of_value v1 ^ " and " ^ string_of_value v2)
    )
  (* Set Operation *)
  | MemE (e1, e2) ->
    let v1 = eval_expr env e1 in
    eval_expr env e2 |> unwrap_listv_to_array |> Array.exists ((=) v1) |> boolV
  (* Function Call *)
  | CallE (fname, al) ->
    let fname' = dispatch_fname fname env in
    let el = remove_typargs al in
    let args = List.map (eval_arg env) el in
    (match call_func fname' args  with
    | Some v -> v
    | _ -> raise (Exception.MissingReturnValue fname)
    )
  | InvCallE (fname, _, al) ->
    let fname' = dispatch_fname fname env in
    let el = remove_typargs al in
    (* TODO: refactor numerics function name *)
    let args = List.map (eval_arg env) el in
    let inv_fname =
      (* If function $f has hint(inverse $invf), but $invf is defined in terms
       * of the inversion of $f, then infinite loop! Implement loop checks? *)
      match find_hint fname' "inverse" with
      | None ->
        fail_expr expr (sprintf "no inverse hint is given for definition `%s`" fname')
      | Some hint ->
        (* We assume that there is only one way to invert the function, on the
         * last argument. We could extend the hint syntax to denote an argument. *)
        match hint.hintexp.it with
        | CallE (fid, []) -> fid.it
        | _ -> failwith (sprintf "ill-formed inverse hint for definition `%s`" fname')
    in
    (match call_func inv_fname args with
    | Some v -> v
    | _ -> raise (Exception.MissingReturnValue fname)
    )
  (* Data Structure *)
  | ListE el -> List.map (eval_expr env) el |> listV_of_list
  | CompE (e1, e2) ->
    let s1 = eval_expr env e1 |> unwrap_strv in
    let s2 = eval_expr env e2 |> unwrap_strv in
    List.map
    (fun (id, v) ->
    let arr1 = match !v with
    | ListV arr_ref -> arr_ref
    | _ -> failwith (sprintf "`%s` is not a list" (string_of_value !v))
    in
    let arr2 = match Record.find id s2 with
    | ListV arr_ref -> arr_ref
    | v -> failwith (sprintf "`%s` is not a list" (string_of_value v))
    in
    (id, Array.append !arr1 !arr2 |> listV |> ref)
    ) s1 |> strV
  | LiftE e1 ->
    eval_expr env e1 |> unwrap_optv |> Option.to_list |> listV_of_list
  | CatE (e1, e2) ->
    let a1 = eval_expr env e1 |> unwrap_seq_to_array in
    let a2 = eval_expr env e2 |> unwrap_seq_to_array in
    Array.append a1 a2 |> listV
  | LenE e ->
    eval_expr env e |> unwrap_listv_to_array |> Array.length |> Z.of_int |> natV
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
  | CaseE (op, el) ->
    (match (get_atom op) with
    | Some a -> caseV (Print.string_of_atom a, List.map (eval_expr env) el)
    | None -> caseV ("", List.map (eval_expr env) el)
    )
  | OptE opt -> Option.map (eval_expr env) opt |> optV
  | TupE el -> List.map (eval_expr env) el |> tupV
  (* Context *)
  | GetCurContextE { it = Atom a; _ } when List.mem a context_names ->
    WasmContext.get_current_context a
  | ChooseE e ->
    let a = eval_expr env e |> unwrap_listv_to_array in
    if Array.length a = 0 then
      fail_expr expr (sprintf "cannot choose an element from %s because it's empty" (string_of_expr e))
    else
      Array.get a 0
  | VarE "s" -> Store.get ()
  | VarE name -> lookup_env name env
  (* Optimized getter for simple IterE(VarE, ...) *)
  | IterE ({ it = VarE name; _ }, (_, [name', e])) when name = name' ->
    eval_expr env e
  (* Optimized getter for list init *)
  | IterE (e1, (ListN (e2, None), [])) ->
    let v = eval_expr env e1 in
    let i = eval_expr env e2 |> al_to_nat in
    if i > 1024 * 64 * 1024 (* 1024 pages *) then
      raise Exception.OutOfMemory
    else
      Array.make i v |> listV
  | IterE (inner_e, (iter, xes)) ->
    let vs =
      env
      |> create_sub_env (iter, xes)
      |> List.map (fun env' -> eval_expr env' inner_e)
    in

    (match vs, iter with
    | [], Opt -> optV None
    | [v], Opt -> Option.some v |> optV
    | l, _ -> listV_of_list l)
  (* condition *)
  | ContextKindE a ->
    let ctx = WasmContext.get_top_context () in
    (match a.it, ctx with
    | Atom case, CaseV (case', _) -> boolV (case = case')
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
      | TupV [ NumV (`Nat n); NumV (`Nat m) ] -> n <= m && m <= k
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
  | HasTypeE (e, t) ->
    (* TODO: This shouldn't be hardcoded *)
    (* check type *)
    let v = eval_expr env e in
    check_type (string_of_typ t) v expr
  | MatchE (e1, e2) ->
    (* Deferred to reference interpreter *)
    let rt1 = e1 |> eval_expr env |> Construct.al_to_reftype in
    let rt2 = e2 |> eval_expr env |> Construct.al_to_reftype in
    boolV (Match.match_reftype [] rt1 rt2)
  | TopValueE _ ->
    (* TODO: type check *)
    boolV (List.length (WasmContext.get_value_stack ()) > 0)
  | TopValuesE e ->
    let i = eval_expr env e |> al_to_nat in
    boolV (List.length (WasmContext.get_value_stack ()) >= i)
  | _ -> fail_expr expr "cannot evaluate expr"

and eval_arg env a =
  match a.it with
  | ExpA e -> eval_expr env e
  | TypA _ -> assert false
  | DefA id -> FnameV (dispatch_fname id env)

(* Assignment *)

and has_same_keys re rv =
  let k1 = Record.keys re |> List.map string_of_atom |> List.sort String.compare in
  let k2 = Record.keys rv |> List.sort String.compare in
  k1 = k2

and assign lhs rhs env =
  match lhs.it, rhs with
  | VarE name, _ -> Env.add name rhs env
  | IterE ({ it = VarE x1; _ }, ((List|List1), [x2, lhs'])), ListV _ when x1 = x2 ->
    assign lhs' rhs env
  | IterE (e, (iter, xes)), _ ->
    let vs = unwrap_seqv_to_list rhs in
    let envs = List.map (fun v -> assign e v Env.empty) vs in

    (* Assign length variable *)
    let env' =
      match iter with
      | ListN (expr, None) ->
        let length = natV_of_int (List.length vs) in
        assign expr length env
      | ListN _ ->
        fail_expr lhs "invalid assignment: iter with index cannot be an assignment target"
      | _ -> env
    in

    List.fold_left (fun env (x, e) ->
      let vs = List.map (lookup_env x) envs in
      let v =
        match iter with
        | Opt -> optV (List.nth_opt vs 0)
        | _ -> listV_of_list vs
      in
      assign e v env
    ) env' xes
  | TupE lhs_s, TupV rhs_s
    when List.length lhs_s = List.length rhs_s ->
    List.fold_right2 assign lhs_s rhs_s env
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
    List.fold_right2 assign lhs_s (Array.to_list !rhs_s) env
  | CaseE (op, lhs_s), CaseV (rhs_tag, rhs_s) when List.length lhs_s = List.length rhs_s ->
    (match get_atom op with
    | Some lhs_tag when (Print.string_of_atom lhs_tag) = rhs_tag ->
      List.fold_right2 assign lhs_s rhs_s env
    | None when "" = rhs_tag ->
      List.fold_right2 assign lhs_s rhs_s env
    | _ -> fail_expr lhs
      (sprintf "invalid assignment: cannot be an assignment target for %s" (string_of_value rhs))
    )
  | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs env
  | CvtE (e1, nt, _), NumV n ->
    (match Num.cvt nt n with
    | Some n' -> assign e1 (NumV n') env
    | None -> fail_expr lhs ("inverse conversion not defined for " ^ string_of_value (NumV n))
    )
  (* Assumption: e1 is the assign target *)
  | BinE (binop, e1, e2), NumV m ->
    let invop =
      match binop with
      | `AddOp -> `SubOp
      | `SubOp -> `AddOp
      | `MulOp -> `DivOp
      | `DivOp -> `MulOp
      | _ -> fail_expr lhs "invalid assignment: logical binop cannot be an assignment target" in
    let v =
      match Num.bin invop m (eval_expr env e2 |> unwrap_numv) with
      | Some n -> numV n
      | None -> fail_expr lhs ("invalid assignment: inverted binop not defined for " ^ string_of_value rhs)
    in
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
      | IterE (_, (ListN (e, None), _)) -> Some (al_to_nat (eval_expr env e))
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

and assign_param lhs rhs env =
  match lhs.it with
  | ExpA e -> assign e rhs env
  | TypA _ -> assert false
  | DefA id -> Env.add ("$" ^ id) rhs env

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
    | Exception.Fail
    | Exception.OutOfMemory ->
      AlContext.add_instrs il2 ctx
    )
  | AssertI e ->
    if is_true (eval_expr env e) then
      ctx
    else
      fail_expr e "assertion fail"
  | PushI e ->
    (match eval_expr env e with
    | CaseV ("FRAME_", _) as v ->
      WasmContext.push_context (v, [], []);
      AlContext.increase_depth ctx
    | ListV vs ->
      Array.iter WasmContext.push_value !vs;
      ctx
    | v ->
      WasmContext.push_value v;
      ctx
    )
  | PopI e ->
    (match e.it with
    | CaseE ([{it = Atom.Atom "FRAME_"; _}] :: _, [_; inner_e]) ->
      (match WasmContext.pop_context () with
      | CaseV ("FRAME_", [_; inner_v]), _, _ ->
        let new_env = assign inner_e inner_v env in
        ctx
        |> AlContext.set_env new_env
        |> AlContext.decrease_depth
      | v, _, _ -> failwith (sprintf "current context `%s` is not a frame" (string_of_value v))
      )
    | IterE ({ it = VarE name; _ }, (ListN (e_n, None), [name', e'])) when name = name' ->
      let i = eval_expr env e_n |> al_to_nat in
      let v =
        List.init i (fun _ -> WasmContext.pop_value ())
        |> List.rev
        |> listV_of_list
      in
      let new_env = assign e' v env in
      AlContext.set_env new_env ctx
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
    let el = remove_typargs al in
    let args = List.map (eval_arg env) el in
    call_func f args |> ignore;
    ctx
  | TrapI -> raise Exception.Trap
  | ThrowI _ -> raise Exception.Throw
  | FailI -> raise Exception.Fail
  | NopI -> ctx
  | ReturnI None -> AlContext.tl ctx
  | ReturnI (Some e) ->
    AlContext.return (eval_expr env e) :: AlContext.tl ctx
  | ExecuteI e ->
    let v = eval_expr env e in
    AlContext.execute v :: ctx
  | ExecuteSeqI e ->
    let v = eval_expr env e in
    (match v with
    | ListV _ ->
      let ctx' = v |> unwrap_listv_to_list |> List.map AlContext.execute in
      ctx' @ ctx
    | _ -> failwith (sprintf "%s is not a sequence value" (string_of_value v))
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
    let i = eval_expr env e2 |> al_to_nat in
    let v = eval_expr env e3 in
    Array.set a i v;
    ctx
  | ReplaceI (e1, { it = SliceP (e2, e3); _ }, e4) ->
    let a1 = eval_expr env e1 |> unwrap_listv_to_array in (* dest *)
    let i1 = eval_expr env e2 |> al_to_nat in   (* start index *)
    let i2 = eval_expr env e3 |> al_to_nat in   (* length *)
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
  | CaseV ("REF.NULL" as name, ([ CaseV ("_IDX", _) ] as args)) ->
    create_context name args :: ctx
  | CaseV ("REF.NULL", _)
  | CaseV ("CONST", _)
  | CaseV ("VCONST", _) as v -> WasmContext.push_value v; ctx
  | CaseV (name, []) when Host.is_host name -> Host.call name; ctx
  | CaseV (name, args) -> create_context name args :: ctx
  | v -> fail_value "cannot step a wasm instr" v


and try_step_wasm ctx v =
  try_with_error empty no_region structured_string_of_value (step_wasm ctx) v

and step (ctx: AlContext.t) : AlContext.t =
  let open AlContext in

  Debugger.run ctx;

  match ctx with
  | Al (name, args, il, env, n) :: ctx ->
    (match il with
    | [] -> ctx
    | [ instr ]
    when can_tail_call instr && n = 0 && not !Debugger.debug ->
      try_step_instr name ctx env instr
    | h :: t ->
      let new_ctx = Al (name, args, t, env, n) :: ctx in
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
      | Wasm n :: t when not !Debugger.debug -> Wasm (n + 1) :: t
      | Enter (_, [], _) :: t -> Wasm 2 :: t
      | ctx -> Wasm 1 :: ctx
      )
    | h :: t ->
      let new_ctx = Enter (name, t, env) :: ctx in
      try_step_instr name new_ctx env h
    )
  | Execute v :: ctx -> try_step_wasm ctx v
  | _ -> assert false


(* AL interpreter Entry *)


and run (ctx: AlContext.t) : AlContext.t =
  if AlContext.is_reducible ctx then run (step ctx) else ctx

and create_context (name: string) (args: value list) : AlContext.mode =
  let algo = lookup_algo name in
  let params = params_of_algo algo in
  let body = body_of_algo algo in
  let params = params |> remove_typargs in

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
    |> List.fold_right2 assign_param params args
  in

  AlContext.al (name, params, body, env, 0)

and call_func (name: string) (args: value list) : value option =
   let builtin_name, is_builtin =
     match find_hint name "builtin" with
     | None -> name, false
     | Some hint ->
       match hint.hintexp.it with
       | SeqE [] -> name, true         (* hint(builtin) *)
       | TextE fname -> fname, true    (* hint(builtin "g") *)
       | _ -> failwith (sprintf "ill-formed builtin hint for definition `%s`" name)
   in
   (* Function *)
   if bound_func name && not is_builtin then
     [create_context name args]
     |> run
     |> AlContext.get_return_value
   (* Numerics *)
   else if Numerics.mem builtin_name then (
     if not is_builtin then
       warn (sprintf "Numeric function `%s` is not defined in source, consider adding a hint(builtin)" name);
     Some (Numerics.call_numerics builtin_name args)
   )
  (* Relation *)
  else if Relation.mem name then (
    if bound_rule name then
      [create_context name args]
      |> run
      |> AlContext.get_return_value
    else
      Some (Relation.call_func name args)
  )
  else
    raise (Exception.UnknownFunc ("There is no function named: " ^ name))


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
