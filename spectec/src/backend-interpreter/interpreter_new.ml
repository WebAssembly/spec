open Al
open Ast
open Print
open Ds
open Reference_interpreter

let value_to_option = function OptV opt -> opt | v -> failwith (string_of_value v ^ " is not a option")
let value_to_growable_array = function ListV a -> a | v -> failwith (string_of_value v ^ " is not a list")
let value_to_array v = v |> value_to_growable_array |> (!)
let value_to_list v = v |> value_to_array |> Array.to_list
let value_to_num = function NumV n -> n | v -> failwith (string_of_value v ^ " is not a number")
let value_to_int v = v |> value_to_num |> Int64.to_int
let check_i32_const = function
  | ConstructV ("CONST", [ ConstructV ("I32", []); NumV (n) ]) ->
    let n' = Int64.logand 0xFFFFFFFFL n in
    ConstructV ("CONST", [ ConstructV ("I32", []); NumV (n') ])
  | v -> v

let rec int64_exp base exponent =
  if exponent = 0L then
    1L
  else if exponent = 1L then
    base
  else
    let half_pow = int64_exp base (Int64.div exponent 2L) in
    let pow = Int64.mul half_pow half_pow in
    if Int64.rem exponent 2L = 0L then
      pow
    else
      Int64.mul base pow

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

(* Expression *)

let rec create_sub_al_context names iter al_context =
  let env, return_value, depth = al_context in
  let name_to_value name = Env.find name env in
  let option_name_to_list name = name |> name_to_value |> value_to_option |> Option.to_list in
  let name_to_list name = name |> name_to_value |> value_to_list in
  let length_to_list l = List.init l (fun i -> NumV (Int64.of_int i)) in

  let name_to_values name =
    match iter with
    | Opt -> option_name_to_list name
    | ListN (e_n, Some n') when name = n' -> eval_expr al_context e_n |> value_to_int |> length_to_list
    | _ -> name_to_list name
  in

  names
  |> List.map name_to_values
  |> transpose
  |> List.map (fun vs -> List.fold_right2 Env.add names vs env, return_value, depth)

and access_path al_context base path = match path with
  | IndexP e' ->
      let a = base |> value_to_array in
      let i = eval_expr al_context e' |> value_to_int in
      ( try Array.get a i with Invalid_argument _ -> failwith ("Failed Array.get during ReplaceE") )
  | SliceP (e1, e2) ->
      let a = base |> value_to_array in
      let i1 = eval_expr al_context e1 |> value_to_int in
      let i2 = eval_expr al_context e2 |> value_to_int in
      let a' = Array.sub a i1 i2 in
      ListV (ref a')
  | DotP (str, _) -> (
      match base with
      | FrameV (_, RecordV r) -> Record.find str r
      | StoreV s -> Record.find str !s
      | RecordV r -> Record.find str r
      | v ->
          string_of_value v
          |> Printf.sprintf "Not a record: %s"
          |> failwith)

and replace_path al_context base path v_new = match path with
  | IndexP e' ->
      let a = base |> value_to_array in
      let a_new = Array.copy a in
      let i = eval_expr al_context e' |> value_to_int in
      Array.set a_new i v_new;
      ListV (ref a_new)
  | SliceP (e1, e2) ->
      let a = base |> value_to_array in
      let a_new = Array.copy a in
      let i1 = eval_expr al_context e1 |> value_to_int in
      let i2 = eval_expr al_context e2 |> value_to_int in
      Array.blit (v_new |> value_to_array) 0 a_new i1 (i2 - i1 + 1);
      ListV (ref a_new)
  | DotP (str, _) ->
      let r = (
        match base with
        | FrameV (_, RecordV r) -> r
        | StoreV s -> !s
        | RecordV r -> r
        | v ->
            string_of_value v
            |> Printf.sprintf "Not a record: %s"
            |> failwith)
      in
      let r_new = Record.clone r in
      Record.replace str v_new r_new;
      RecordV r_new

and eval_expr al_context expr =
  let (env, _, _) = al_context in
  match expr with
  (* Value *)
  | NumE i -> NumV i
  | StringE s -> StringV s
  (* Numeric Operation *)
  | MinusE inner_e -> NumV (eval_expr al_context inner_e |> value_to_num |> Int64.neg)
  | BinopE (op, e1, e2) ->
      let v1 = eval_expr al_context e1 in
      let v2 = eval_expr al_context e2 in
      begin match v1, v2 with
      | NumV v1, NumV v2 ->
          let result = match op with
          | Add -> Int64.add v1 v2
          | Sub -> Int64.sub v1 v2
          | Mul -> Int64.mul v1 v2
          | Div -> Int64.div v1 v2
          | Exp -> int64_exp v1 v2
          in
          NumV result
      | _ -> failwith "Not an integer"
      end
  (* Function Call *)
  | AppE (fname, el) ->
    let args = List.map (eval_expr al_context) el in
    begin match dsl_function_call al_context fname args with
    | Some v -> v
    | _ ->
      string_of_expr expr
     |> Printf.sprintf "%s doesn't have return value"
     |> failwith
    end
  (* Data Structure *)
  | ListE el -> listV (List.map (eval_expr al_context) el)
  | ListFillE (e1, e2) ->
      let v = eval_expr al_context e1 in
      let i = eval_expr al_context e2 |> value_to_int in
      if i > 1024 * 64 * 1024 then (* 1024 pages *)
        raise Exception.OutOfMemory
      else
        ListV (ref (Array.make i v))
  | ConcatE (e1, e2) ->
      let a1 = eval_expr al_context e1 |> value_to_array in
      let a2 = eval_expr al_context e2 |> value_to_array in
      ListV (Array.append a1 a2 |> ref)
  | LengthE e ->
      let a = eval_expr al_context e |> value_to_array in
      NumV (I64.of_int_u (Array.length a))
  | RecordE r -> 
      let elist = Record.to_list r in
      let vlist = List.map (fun (k, e) -> ((string_of_keyword k), !e |> eval_expr al_context |> ref)) elist in
      RecordV (Record.of_list vlist)
  | AccessE (e, p) ->
      let base = eval_expr al_context e in
      access_path al_context base p
  | ExtendE (e1, ps, e2, dir) ->
      let v_new = eval_expr al_context e2 |> value_to_array in
      let rec extend base ps = (
        match ps with
        | path :: rest ->
            let v_new = extend (access_path al_context base path) rest in
            replace_path al_context base path v_new
        | [] ->
            let a = base |> value_to_array in
            let a_copy = Array.copy a in
            let a_new = (
              match dir with
              | Front -> Array.append v_new a_copy
              | Back -> Array.append a_copy v_new)
            in
            ListV (ref a_new))
      in
      let base = eval_expr al_context e1 in
      extend base ps
  | ReplaceE (e1, ps, e2) ->
      let v_new = eval_expr al_context e2 in
      let rec replace base ps = (
        match ps with
        | path :: rest ->
            let v_new = replace (access_path al_context base path) rest in
            replace_path al_context base path v_new
        | [] -> v_new)
      in
      let base = eval_expr al_context e1 in
      replace base ps
  | ConstructE ((tag, _), el) -> ConstructV (tag, List.map (eval_expr al_context) el) |> check_i32_const
  | OptE opt -> OptV (Option.map (eval_expr al_context) opt)
  | PairE (e1, e2) -> PairV (eval_expr al_context e1, eval_expr al_context e2)
  (* Context *)
  | ArityE e -> (
      match eval_expr al_context e with
      | LabelV (v, _) -> v
      | FrameV (Some v, _) -> v
      | _ -> failwith "Not a label" (* Due to AL validation, unreachable *))
  | FrameE (e1, e2) -> (
      let v1 = Option.map (eval_expr al_context) e1 in
      let v2 = eval_expr al_context e2 in
      match (v1, v2) with
      | (Some (NumV _)|None), RecordV _ -> FrameV (v1, v2)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid frame: " ^ string_of_expr expr |> failwith)
  (*| GetCurFrameE -> get_current_frame () *)
  | LabelE (e1, e2) ->
      let v1 = eval_expr al_context e1 in
      let v2 = eval_expr al_context e2 in
      LabelV (v1, v2)
  (*| GetCurLabelE -> get_current_label ()
  | GetCurContextE -> get_current_context ()
  | ContE e -> (
      let v = eval_expr al_context e in
      match v with
      | LabelV (_, vs) -> vs
      | _ -> failwith "Not a label") *)
  | NameE name -> Env.find name env
  | IterE (NameE name, _, List) -> (* Optimized getter for simple IterE(NameE, ...) *)
      Env.find name env
  | IterE (inner_e, names, iter) ->
      al_context
      |> create_sub_al_context names iter
      |> List.map (fun new_al_context -> eval_expr new_al_context inner_e)
      |> if (iter = Opt)
      then
        (function
          | [] -> OptV None
          | [v] -> OptV (Some v)
          | _ -> failwith "Unreachable")
      else listV
  | e -> structured_string_of_expr e |> failwith

(* Condition *)

and eval_cond al_context cond =
  match cond with
  | NotC c -> eval_cond al_context c |> not
  | BinopC (op, c1, c2) ->
      let b1 = eval_cond al_context c1 in
      let b2 = eval_cond al_context c2 in
      begin match op with
      | And -> b1 && b2
      | Or -> b1 || b2
      | Impl -> not b1 || b2
      | Equiv -> b1 = b2
      end
  | CompareC (op, e1, e2) ->
      let v1 = eval_expr al_context e1 in
      let v2 = eval_expr al_context e2 in
      begin match op with
      | Eq -> v1 = v2
      | Ne -> v1 <> v2
      | Lt -> v1 < v2
      | Le -> v1 <= v2
      | Gt -> v1 > v2
      | Ge -> v1 >= v2
      end
  | ContextKindC ((kind, _), e) ->
      begin match kind, eval_expr al_context e with
      | "frame", FrameV _ -> true
      | "label", LabelV _ -> true
      | _ -> false
      end
  | IsDefinedC e ->
      begin match eval_expr al_context e with
      | OptV (Some (_)) -> true
      | OptV (_) -> false
      | _ -> structured_string_of_cond cond |> failwith
      end
  | IsCaseOfC (e, (expected_tag, _)) -> (
      match eval_expr al_context e with
      | ConstructV (tag, _) -> expected_tag = tag
      | _ -> false)
  (* TODO : This sohuld be replaced with executing the validation algorithm *)
  | ValidC e -> (
      let valid_lim k = function
        | PairV (NumV n, NumV m) -> n <= m && m <= k
        | _ -> false
      in
      match eval_expr al_context e with
      (* valid_tabletype *)
      | PairV (lim, _) -> valid_lim 0xffffffffL lim
      (* valid_memtype *)
      | ConstructV ("I8", [ lim ]) -> valid_lim 0x10000L lim
      (* valid_other *)
      | _ -> failwith "TODO: Currently, we are already validating tabletype and memtype"
  )
  | c -> structured_string_of_cond c |> failwith

(* Assignment *)

and has_same_keys r1 r2 =
  let k1 = Record.keys r1 |> List.map string_of_keyword |> List.sort String.compare in
  let k2 = Record.keys r2 |> List.sort String.compare in
  k1 = k2

and merge_envs_with_grouping default_al_context al_contexts =
  let merge al_context acc =
    let env, return_value, depth = al_context in
    let acc_env, _, _ = acc in
    let f _ v1 = function
      | ListV arr ->
          v1 :: Array.to_list !arr |> listV |> Option.some
      | OptV None -> v1 |> Value.opt |> Option.some
      | _ -> failwith "Unreachable merge"
    in
    Env.union f env acc_env, return_value, depth
  in
  List.fold_right merge al_contexts default_al_context

and assign lhs rhs al_context: AL_Context.t =
  let (env, return_value, depth) = al_context in
  match lhs, rhs with
  | NameE name, v -> Env.add name v env, return_value, depth
  | IterE (NameE n, _, List), ListV _ -> (* Optimized assign for simple IterE(NameE, ...) *)
      Env.add n rhs env, return_value, depth
  | IterE (e, _, iter), _ ->
      let new_env, default_rhs, rhs_list =
        match iter, rhs with
        | (List | List1), ListV arr -> env, listV [], Array.to_list !arr
        | ListN (expr, None), ListV arr ->
            let length = Array.length !arr |> Int64.of_int |> Value.num in
            let env', _, _ = assign expr length al_context in
            env', listV [], Array.to_list !arr
        | Opt, OptV opt -> env, OptV None, Option.to_list opt
        | _ ->
            Printf.sprintf "Invalid iter %s with rhs %s"
              (string_of_iter iter)
              (string_of_value rhs)
            |> failwith
      in

      let default_env =
        Al.Free.free_expr e
        |> List.map (fun n -> n, default_rhs)
        |> List.to_seq
        |> Env.of_seq
      in
      let default_al_context = default_env, return_value, depth in

      let merged_env, _, _ =
        List.map (fun v -> assign e v (Env.empty, return_value, depth)) rhs_list
        |> merge_envs_with_grouping default_al_context
      in
      Env.union (fun _ _ v -> Some v) new_env merged_env, return_value, depth
  | PairE (lhs1, lhs2), PairV (rhs1, rhs2)
  | ArrowE (lhs1, lhs2), ArrowV (rhs1, rhs2) ->
      al_context |> assign lhs1 rhs1 |> assign lhs2 rhs2
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
      List.fold_right2 assign lhs_s (!rhs_s |> Array.to_list) al_context
  | ConstructE ((lhs_tag, _), lhs_s), ConstructV (rhs_tag, rhs_s)
    when lhs_tag = rhs_tag && List.length lhs_s = List.length rhs_s ->
      List.fold_right2 assign lhs_s rhs_s al_context
  | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs al_context
  (* Assumption: e1 is the assign target *)
  | BinopE (binop, e1, e2), NumV m ->
      let n = eval_expr al_context e2 |> value_to_num in
      let invop = match binop with
      | Add -> Int64.sub
      | Sub -> Int64.add
      | Mul -> Int64.unsigned_div
      | Div -> Int64.mul
      | _ -> failwith "Invvalid binop for lhs of assignment" in
      al_context |> assign e1 (NumV (invop m n))
  | ConcatE (e1, e2), ListV vs -> assign_split e1 e2 !vs al_context
  | RecordE r1, RecordV r2 when has_same_keys r1 r2 ->
      Record.fold (fun k v acc -> (Record.find (string_of_keyword k) r2 |> assign v) acc) r1 al_context
  | e, v ->
      Printf.sprintf "Invalid assignment: %s := %s"
        (string_of_expr e) (string_of_value v)
      |> failwith

and assign_split ep es vs al_context =
  let len = Array.length vs in
  let prefix_len, suffix_len =
    let get_length = function
    | ListE es -> Some (List.length es)
    | IterE (_, _, ListN (e, None)) -> Some (eval_expr al_context e |> value_to_int)
    | _ -> None in
    match get_length ep, get_length es with
    | None, None -> failwith "Unrecahble: nondeterministic list split"
    | Some l, None -> l, len - l
    | None, Some l -> len - l, l
    | Some l1, Some l2 -> l1, l2 in
  assert (prefix_len >= 0 && suffix_len >= 0 && prefix_len + suffix_len = len);
  let prefix = Array.sub vs 0 prefix_len in
  let suffix = Array.sub vs prefix_len suffix_len in
  al_context |> assign ep (ListV (ref prefix)) |> assign es (ListV (ref suffix))

and assign_opt lhs_opt rhs al_context = match lhs_opt with
  | None -> al_context
  | Some lhs -> assign lhs rhs al_context


(* Instruction *)

and dsl_function_call (al_context: AL_Context.t) (fname: string) (args: value list): AL_Context.return_value =
  (* Numerics *)
  if Numerics.mem fname then
    AL_Context.Some (Numerics.call_numerics fname args)
  (* Module & Runtime *)
  else if FuncMap.mem fname !func_map then
    call_algo al_context fname args
  else
    Printf.sprintf "Invalid DSL function call: %s" fname |> failwith

and execute (al_context: AL_Context.t) (wasm_instr: value) =
  let decode = function
    | ConstructV (fname, args) -> fname, args
    | v ->
      string_of_value v
      |> Printf.sprintf "Executing invalid value: %s"
      |> failwith
  in

  let fname, args = decode wasm_instr in
  call_algo al_context fname args |> ignore

and interp_instr (al_context: AL_Context.t) (i: instr): AL_Context.t =
  (* TODO: remove env parameters *)
  let env, return_value, depth = al_context in
  match i with
  (* Block instruction *)
  | IfI (c, il1, il2) ->
    if eval_cond al_context c then
      interp_instrs al_context il1
    else
      interp_instrs al_context il2
  | EitherI (il1, il2) ->
    begin try interp_instrs al_context il1 with
    | Exception.MissingReturnValue
    | Exception.OutOfMemory -> interp_instrs al_context il2
    end
  | AssertI c -> assert (eval_cond al_context c); al_context
  | PushI e ->
    begin match eval_expr al_context e with
    | ListV vs -> Array.iter WasmContext.push_value !vs
    | v -> WasmContext.push_value v
    end;
    al_context
  | PopI (IterE (NameE name, [name'], ListN (e', None))) when name = name' ->
    let i = eval_expr al_context e' |> value_to_int in
    let vs = List.rev (List.init i (fun _ -> WasmContext.pop_value ())) in
    Env.add name (listV vs) env, return_value, depth
  | PopI e ->
    begin match (e, WasmContext.pop_value ()) with
    | ConstructE (("CONST", _), [NameE nt; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
      let new_env =
        env
        |> Env.add nt ty
        |> Env.add name v
      in
      new_env, return_value, depth
    | ConstructE (("CONST", _), [tyE; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
      assert (eval_expr al_context tyE = ty);
      Env.add name v env, return_value, depth
    | NameE name, v -> Env.add name v env, return_value, depth
    | (e, h) ->
      Printf.sprintf "Invalid pop: %s := %s"
        (structured_string_of_expr e)
        (structured_string_of_value h)
      |> failwith
    end
  | PopAllI (IterE (NameE name, [name'], List)) when name = name' ->
    let rec pop_all acc =
      if WasmContext.get_value_stack () |> List.length > 0 then
        WasmContext.pop_value () :: acc |> pop_all
      else 
        acc
    in
    let vs = pop_all [] in
    Env.add name (listV vs) env, return_value, depth
  | PopAllI e ->
    string_of_expr e
    |> Printf.sprintf "Invalid pop: Popall %s"
    |> failwith
  | LetI (pattern, e) ->
    assign pattern (eval_expr al_context e) al_context
  | CallI _ -> failwith "No CallI"
  | PerformI (f, el) ->
    let args = List.map (eval_expr al_context) el in
    dsl_function_call al_context f args |> ignore;
    al_context
  | TrapI -> raise Exception.Trap
  | NopI -> al_context
  | ReturnI None -> env, None, depth
  | ReturnI (Some e) -> env, Some (eval_expr al_context e), depth
  | ExecuteI e ->
    let wasm_instr = eval_expr al_context e in
    execute al_context wasm_instr;
    al_context
  | ExecuteSeqI e ->
    let wasm_instrs = eval_expr al_context e |> value_to_list in
    List.iter (execute al_context) wasm_instrs;
    al_context
  | ExitAbruptI _ ->
    WasmContext.pop_context () |> ignore;
    AL_Context.decrease_depth ();
    al_context
  | ReplaceI (e1, IndexP e2, e3) ->
    let a = eval_expr al_context e1 |> value_to_array in
    let i = eval_expr al_context e2 |> value_to_int in
    let v = eval_expr al_context e3 in
    Array.set a i v;
    al_context
  | ReplaceI (e1, SliceP (e2, e3), e4) ->
    let a1 = eval_expr al_context e1 |> value_to_array in (* dest *)
    let i1 = eval_expr al_context e2 |> value_to_int in   (* start index *)
    let i2 = eval_expr al_context e3 |> value_to_int in   (* length *)
    let a2 = eval_expr al_context e4 |> value_to_array in (* src *)
    assert (Array.length a2 = i2);
    Array.iteri (fun i v -> Array.set a1 (i1 + i) v) a2;
    al_context
  | ReplaceI (e1, DotP (s, _), e2) ->
    begin match eval_expr al_context e1 with
    | RecordV r ->
        let v = eval_expr al_context e2 in
        Record.replace s v r
    | _ -> failwith "Not a Record"
    end;
    al_context
  | AppendI (e1, e2) ->
    let a = eval_expr al_context e1 |> value_to_growable_array in
    let v = eval_expr al_context e2 in
    a := Array.append (!a) [|v|];
    al_context
  | AppendListI (e1, e2) ->
    let a1 = eval_expr al_context e1 |> value_to_growable_array in
    let a2 = eval_expr al_context e2 |> value_to_array in
    a1 := Array.append (!a1) a2;
    al_context
  | i ->
    structured_string_of_instr 0 i
    |> Printf.sprintf "Interpreter is not implemented for the instruction: %s"
    |> failwith

and interp_instrs (al_context: AL_Context.t) (il: instr list): AL_Context.t =
  match il with
  | [] -> al_context
  | h :: t ->
    match interp_instr al_context h with
    | (_, Bot, _) -> interp_instrs al_context t
    | new_al_context -> new_al_context
      


(* Algorithm *)

(* TODO: move to ds.ml *)
and create_al_context (algo: algorithm) (args: value list) =
  let params = get_param algo in
  assert (List.length params = List.length args);

  (Env.empty, AL_Context.Bot, 0)
  |> List.fold_right2 assign params args

and interp_algo (algo: algorithm) (args: value list): AL_Context.return_value =

  (* Create AL context *)
  let al_context = create_al_context algo args in

  (* Interp body *)
  let _, return_value, depth = get_body algo |> interp_instrs al_context in

  assert (depth = 0);
  return_value

and call_algo (al_context: AL_Context.t) (name: string) (args: value list): AL_Context.return_value =
  print_endline name;
  (* Push AL context *)
  AL_Context.push_context al_context;

  (* Interp algorithm *)
  let algo = lookup name in
  let return_value = interp_algo algo args in

  (* Pop AL context *)
  AL_Context.pop_context () |> ignore;
  return_value

let instantiation args =
  match interp_algo (lookup "instantiation") args with
  | AL_Context.Some module_inst -> module_inst
  | _ -> failwith "Instantiation doesn't return module instance"
let invocation args =
  match interp_algo (lookup "invocation") args with
  | AL_Context.Some v -> v
  | _ -> failwith "Invocation doesn't return value"
