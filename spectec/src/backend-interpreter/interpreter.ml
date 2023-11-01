open Reference_interpreter
open Al
open Ast
open Print
open Ds

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

let rec create_sub_al_context names iter env =

  (*
    Currently, the index is mistakenly inserted in names
    due to IL fault.
    TODO: remove hack
  *)

  let names =
    match iter with
    | ListN (_, Some _) -> names
    | _ -> List.filter (fun name -> Env.mem name env) names
  in

  let name_to_value name = Env.find name env in
  let option_name_to_list name = name |> name_to_value |> value_to_option |> Option.to_list in
  let name_to_list name = name |> name_to_value |> value_to_list in
  let length_to_list l = List.init l (fun i -> NumV (Int64.of_int i)) in

  let name_to_values name =
    match iter with
    | Opt -> option_name_to_list name
    | ListN (e_n, Some n') when name = n' ->
      eval_expr env e_n
      |> value_to_int
      |> length_to_list
    | _ -> name_to_list name
  in

  names
  |> List.map name_to_values
  |> transpose
  |> List.map (fun vs -> List.fold_right2 Env.add names vs env)

and access_path env base path = match path with
  | IndexP e' ->
      let a = base |> value_to_array in
      let i = eval_expr env e' |> value_to_int in
      begin try Array.get a i with
      | Invalid_argument _ ->
        Printf.sprintf "Failed Array.get during ReplaceE: %s[%s]"
          (string_of_value base)
          (string_of_int i)
        |> failwith
      end
  | SliceP (e1, e2) ->
      let a = base |> value_to_array in
      let i1 = eval_expr env e1 |> value_to_int in
      let i2 = eval_expr env e2 |> value_to_int in
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

and replace_path env base path v_new = match path with
  | IndexP e' ->
      let a = base |> value_to_array in
      let a_new = Array.copy a in
      let i = eval_expr env e' |> value_to_int in
      Array.set a_new i v_new;
      ListV (ref a_new)
  | SliceP (e1, e2) ->
      let a = base |> value_to_array in
      let a_new = Array.copy a in
      let i1 = eval_expr env e1 |> value_to_int in
      let i2 = eval_expr env e2 |> value_to_int in
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

and eval_expr env expr =
  match expr with
  (* Value *)
  | NumE i -> NumV i
  | StringE s -> StringV s
  (* Numeric Operation *)
  | MinusE inner_e -> NumV (eval_expr env inner_e |> value_to_num |> Int64.neg)
  | BinopE (op, e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
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
    let args = List.map (eval_expr env) el in
    begin match dsl_function_call fname args with
    | Some v -> v
    | _ -> raise Exception.MissingReturnValue
    (*
    | _ ->
      string_of_expr expr
     |> Printf.sprintf "%s doesn't have return value"
     |> failwith
    *)
    end
  (* Data Structure *)
  | ListE el -> listV (List.map (eval_expr env) el)
  | ListFillE (e1, e2) ->
      let v = eval_expr env e1 in
      let i = eval_expr env e2 |> value_to_int in
      if i > 1024 * 64 * 1024 then (* 1024 pages *) (
        AL_Context.pop_context () |> ignore;
        raise Exception.OutOfMemory
      )
      else
        ListV (ref (Array.make i v))
  | ConcatE (e1, e2) ->
      let a1 = eval_expr env e1 |> value_to_array in
      let a2 = eval_expr env e2 |> value_to_array in
      ListV (Array.append a1 a2 |> ref)
  | LengthE e ->
      let a = eval_expr env e |> value_to_array in
      NumV (I64.of_int_u (Array.length a))
  | RecordE r -> 
      let elist = Record.to_list r in
      let vlist = List.map (fun (k, e) -> ((string_of_keyword k), !e |> eval_expr env |> ref)) elist in
      RecordV (Record.of_list vlist)
  | AccessE (e, p) ->
      let base = eval_expr env e in
      access_path env base p
  | ExtendE (e1, ps, e2, dir) ->
      let v_new = eval_expr env e2 |> value_to_array in
      let rec extend base ps = (
        match ps with
        | path :: rest ->
            let v_new = extend (access_path env base path) rest in
            replace_path env base path v_new
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
      let base = eval_expr env e1 in
      extend base ps
  | ReplaceE (e1, ps, e2) ->
      let v_new = eval_expr env e2 in
      let rec replace base ps = (
        match ps with
        | path :: rest ->
            let v_new = replace (access_path env base path) rest in
            replace_path env base path v_new
        | [] -> v_new)
      in
      let base = eval_expr env e1 in
      replace base ps
  | ConstructE ((tag, _), el) -> ConstructV (tag, List.map (eval_expr env) el) |> check_i32_const
  | OptE opt -> OptV (Option.map (eval_expr env) opt)
  | PairE (e1, e2) -> PairV (eval_expr env e1, eval_expr env e2)
  (* Context *)
  | ArityE e -> (
      match eval_expr env e with
      | LabelV (v, _) -> v
      | FrameV (Some v, _) -> v
      | FrameV _ -> NumV 0L
      | _ -> failwith "Not a context" (* Due to AL validation, unreachable *))
  | FrameE (e1, e2) -> (
      let v1 = Option.map (eval_expr env) e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | (Some (NumV _)|None), RecordV _ -> FrameV (v1, v2)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid frame: " ^ string_of_expr expr |> failwith)
  | GetCurFrameE -> WasmContext.get_current_frame ()
  | LabelE (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      LabelV (v1, v2)
  | GetCurLabelE -> WasmContext.get_current_label ()
  | GetCurContextE -> WasmContext.get_current_context ()
  | ContE e -> (
      let v = eval_expr env e in
      match v with
      | LabelV (_, vs) -> vs
      | _ -> failwith "Not a label")
  | NameE name -> Env.find name env
  | IterE (NameE name, _, List) -> (* Optimized getter for simple IterE(NameE, ...) *)
      Env.find name env
  | IterE (inner_e, names, iter) ->
    env
    |> create_sub_al_context names iter
    |> List.map (fun new_al_context -> eval_expr new_al_context inner_e)
    |> if (iter = Opt)
    then
      (function
        | [] -> OptV None
        | [v] -> OptV (Some v)
        | _ -> failwith "Unreachable")
    else listV
  | ArrowE (e1, e2) -> ArrowV (eval_expr env e1, eval_expr env e2)
  | e -> structured_string_of_expr e |> failwith

(* Condition *)

and eval_cond env cond =
  match cond with
  | NotC c -> eval_cond env c |> not
  | BinopC (op, c1, c2) ->
      let b1 = eval_cond env c1 in
      let b2 = eval_cond env c2 in
      begin match op with
      | And -> b1 && b2
      | Or -> b1 || b2
      | Impl -> not b1 || b2
      | Equiv -> b1 = b2
      end
  | CompareC (op, e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      begin match op with
      | Eq -> v1 = v2
      | Ne -> v1 <> v2
      | Lt -> v1 < v2
      | Le -> v1 <= v2
      | Gt -> v1 > v2
      | Ge -> v1 >= v2
      end
  | ContextKindC ((kind, _), e) ->
      begin match kind, eval_expr env e with
      | "frame", FrameV _ -> true
      | "label", LabelV _ -> true
      | _ -> false
      end
  | IsDefinedC e ->
      begin match eval_expr env e with
      | OptV (Some (_)) -> true
      | OptV (_) -> false
      | _ -> structured_string_of_cond cond |> failwith
      end
  | IsCaseOfC (e, (expected_tag, _)) -> (
      match eval_expr env e with
      | ConstructV (tag, _) -> expected_tag = tag
      | _ -> false)
  (* TODO : This sohuld be replaced with executing the validation algorithm *)
  | ValidC e -> (
      let valid_lim k = function
        | PairV (NumV n, NumV m) -> n <= m && m <= k
        | _ -> false
      in
      match eval_expr env e with
      (* valid_tabletype *)
      | PairV (lim, _) -> valid_lim 0xffffffffL lim
      (* valid_memtype *)
      | ConstructV ("I8", [ lim ]) -> valid_lim 0x10000L lim
      (* valid_other *)
      | _ -> failwith "TODO: Currently, we are already validating tabletype and memtype"
  )
  | HasTypeC (e, s) ->

    (* type definition *)

    let num_types = [ "I32"; "I64"; "F32"; "F64" ] in
    let abs_heap_types = [
      "ANY"; "EQ"; "I31"; "STRUCT"; "ARRAY"; "NONE"; "FUNC";
      "NOFUNC"; "EXTERN"; "NOEXTERN"
    ] in

    (* check type *)

    begin match eval_expr env e with
    (* numtype *)
    | ConstructV (nt, []) when List.mem nt num_types ->
      s = "numtype" || s = "valtype"
    (* valtype *)
    | ConstructV ("REF", _) ->
      s = "reftype" || s = "valtype"
    (* absheaptype *)
    | ConstructV (aht, []) when List.mem aht abs_heap_types ->
      s = "absheaptype" || s = "heaptype"
    (* deftype *)
    | ConstructV ("DEF", [ _; _ ]) ->
      s = "deftype" || s = "heaptype"
    (* typevar *)
    | ConstructV ("_IDX", [ _ ]) ->
      s = "heaptype" || s = "typevar"
    (* heaptype *)
    | ConstructV ("REC", [ _ ]) ->
      s = "heaptype"
    | v ->
      string_of_value v
      |> Printf.sprintf "Invalid %s: %s" s
      |> failwith
    end
  | MatchC (e1, e2) ->
    let rec matches =
      function
      | ConstructV ("REF", [ _; ht1 ]),
        ConstructV ("REF", [
          ConstructV ("NULL", [ OptV (Some (_)) ]);
          ht2
        ]) -> matches (ht1, ht2)
      | v1, v2 when v1 = v2 -> true
      | _, ConstructV ("DEF", _) -> false
      | v1, v2 ->
        Printf.sprintf "%s <: %s"
          (string_of_value v1)
          (string_of_value v2)
        |> failwith
    in

    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    matches (v1, v2)
  | c ->
    structured_string_of_cond c |> failwith

(* Assignment *)

and has_same_keys r1 r2 =
  let k1 = Record.keys r1 |> List.map string_of_keyword |> List.sort String.compare in
  let k2 = Record.keys r2 |> List.sort String.compare in
  k1 = k2

and merge_envs_with_grouping default_env envs =
  let merge env acc =
    let f _ v1 = function
      | ListV arr ->
          v1 :: Array.to_list !arr |> listV |> Option.some
      | OptV None -> v1 |> Value.opt |> Option.some
      | _ -> failwith "Unreachable merge"
    in
    Env.union f env acc
  in
  List.fold_right merge envs default_env

and assign lhs rhs env =
  match lhs, rhs with
  | NameE name, v -> Env.add name v env
  | IterE (NameE n, _, List), ListV _ -> (* Optimized assign for simple IterE(NameE, ...) *)
      Env.add n rhs env
  | IterE (e, _, iter), _ ->
      let new_env, default_rhs, rhs_list =
        match iter, rhs with
        | (List | List1), ListV arr -> env, listV [], Array.to_list !arr
        | ListN (expr, None), ListV arr ->
            let length = Array.length !arr |> Int64.of_int |> Value.num in
            assign expr length env, listV [], Array.to_list !arr
        | Opt, OptV opt -> env, OptV None, Option.to_list opt
        | ListN (_, Some _), ListV _ ->
            Printf.sprintf "Invalid iter %s with rhs %s"
              (string_of_iter iter)
              (string_of_value rhs)
            |> failwith
        | _, _ ->
          Printf.sprintf "Invalid assignment: %s = %s"
            (string_of_expr lhs)
            (string_of_value rhs)
          |> failwith
      in

      let default_env =
        Al.Free.free_expr e
        |> List.map (fun n -> n, default_rhs)
        |> List.to_seq
        |> Env.of_seq
      in

      List.map (fun v -> assign e v Env.empty) rhs_list
      |> merge_envs_with_grouping default_env
      |> Env.union (fun _ _ v -> Some v) new_env
  | PairE (lhs1, lhs2), PairV (rhs1, rhs2)
  | ArrowE (lhs1, lhs2), ArrowV (rhs1, rhs2) ->
      env |> assign lhs1 rhs1 |> assign lhs2 rhs2
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
      List.fold_right2 assign lhs_s (!rhs_s |> Array.to_list) env
  | ConstructE ((lhs_tag, _), lhs_s), ConstructV (rhs_tag, rhs_s)
    when lhs_tag = rhs_tag && List.length lhs_s = List.length rhs_s ->
      List.fold_right2 assign lhs_s rhs_s env
  | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs env
  (* Assumption: e1 is the assign target *)
  | BinopE (binop, e1, e2), NumV m ->
      let n = eval_expr env e2 |> value_to_num in
      let invop = match binop with
      | Add -> Int64.sub
      | Sub -> Int64.add
      | Mul -> Int64.unsigned_div
      | Div -> Int64.mul
      | _ -> failwith "Invvalid binop for lhs of assignment" in
      env |> assign e1 (NumV (invop m n))
  | ConcatE (e1, e2), ListV vs -> assign_split e1 e2 !vs env
  | RecordE r1, RecordV r2 when has_same_keys r1 r2 ->
      Record.fold (fun k v acc -> (Record.find (string_of_keyword k) r2 |> assign v) acc) r1 env
  | e, v ->
      Printf.sprintf "Invalid assignment: %s := %s"
        (string_of_expr e) (string_of_value v)
      |> failwith

and assign_split ep es vs env =
  let len = Array.length vs in
  let prefix_len, suffix_len =
    let get_length = function
    | ListE es -> Some (List.length es)
    | IterE (_, _, ListN (e, None)) -> Some (eval_expr env e |> value_to_int)
    | _ -> None in
    match get_length ep, get_length es with
    | None, None -> failwith "Unrecahble: nondeterministic list split"
    | Some l, None -> l, len - l
    | None, Some l -> len - l, l
    | Some l1, Some l2 -> l1, l2 in
  assert (prefix_len >= 0 && suffix_len >= 0 && prefix_len + suffix_len = len);
  let prefix = Array.sub vs 0 prefix_len in
  let suffix = Array.sub vs prefix_len suffix_len in
  env |> assign ep (ListV (ref prefix)) |> assign es (ListV (ref suffix))

and assign_opt lhs_opt rhs env = match lhs_opt with
  | None -> env
  | Some lhs -> assign lhs rhs env


(* Instruction *)

and dsl_function_call (fname: string) (args: value list): AL_Context.return_value =
  (* Numerics *)
  if Numerics.mem fname then
    AL_Context.Some (Numerics.call_numerics fname args)
  (* Module & Runtime *)
  else if FuncMap.mem fname !func_map then
    call_algo fname args
  else if fname = "ref_type_of" then (
    assert (List.length args = 1);

    let rt =
      let null = ConstructV ("NULL", [ OptV (Some (listV [])) ]) in
      let nonull = ConstructV ("NULL", [ OptV None ]) in
      match List.hd args with
      (* null *)
      | ConstructV ("REF.NULL", [ ht ]) ->
        ConstructV ("REF", [ null; ht])
      (* i31 *)
      | ConstructV ("REF.I31_NUM", [ _ ]) ->
        ConstructV ("REF", [ nonull; singleton "I31"])
      (* struct *)
      | ConstructV ("REF.STRUCT_ADDR", [ NumV i ]) ->
        let e =
          AccessE (
            AccessE (
              AccessE (
                NameE "s",
                DotP ("STRUCT", "struct")
              ),
              IndexP (NumE i)
            ),
            DotP ("TYPE", "type")
          )
        in
        let dt = eval_expr (Env.add_store Env.empty) e in
        ConstructV ("REF", [ nonull; dt])
      (* array *)
      | ConstructV ("REF.ARRAY_ADDR", [ NumV i ]) ->
        let e =
          AccessE (
            AccessE (
              AccessE (
                NameE "s",
                DotP ("ARRAY", "array")
              ),
              IndexP (NumE i)
            ),
            DotP ("TYPE", "type")
          )
        in
        let dt = eval_expr (Env.add_store Env.empty) e in
        ConstructV ("REF", [ nonull; dt])
      (* func *)
      | ConstructV ("REF.FUNC_ADDR", [ NumV i ]) ->
        let e =
          AccessE (
            AccessE (
              AccessE (
                NameE "s",
                DotP ("FUNC", "func")
              ),
              IndexP (NumE i)
            ),
            DotP ("TYPE", "type")
          )
        in
        let dt = eval_expr (Env.add_store Env.empty) e in
        ConstructV ("REF", [ nonull; dt])
      (* host *)
      | ConstructV ("REF.HOST_ADDR", [ _ ]) ->
        ConstructV ("REF", [ nonull; singleton "ANY"])
      (* extern *)
      | ConstructV ("REF.EXTERN", [ _ ]) ->
        ConstructV ("REF", [ nonull; singleton "EXTERN"])
      | _ -> failwith "Invalid arguments for $ref_type_of"
    in

    AL_Context.Some rt
  ) else
    Printf.sprintf "Invalid DSL function call: %s" fname |> failwith

and is_builtin = function
  | "PRINT" | "PRINT_I32" | "PRINT_I64" | "PRINT_F32" | "PRINT_F64" | "PRINT_I32_F32" | "PRINT_F64_F64" -> true
  | _ -> false

and call_builtin name =
  let local x =
    match call_algo "local" [ NumV (Int64.of_int x) ] with
    | Some v -> v
    | _ -> failwith "builtin doesn't return value"
  in
  let as_const ty = function
  | OptV (Some (ConstructV ("CONST", [ ConstructV (ty', []) ; n ]))) when ty = ty' -> n
  | v -> failwith ("Not " ^ ty ^ ".CONST: " ^ string_of_value v) in
  match name with
  | "PRINT" -> print_endline "- print: ()"
  | "PRINT_I32" ->
    let i32 = local 0 |> as_const "I32" in
    print_endline ("- print_i32: " ^ Numerics.num_to_i32_string i32)
  | "PRINT_I64" ->
    let i64 = local 0 |> as_const "I64" in
    print_endline ("- print_i64: " ^ Numerics.num_to_i64_string i64)
  | "PRINT_F32" ->
    let f32 = local 0 |> as_const "F32" in
    print_endline ("- print_f32: " ^ Numerics.num_to_f32_string f32)
  | "PRINT_F64" ->
    let f64 = local 0 |> as_const "F64" in
    print_endline ("- print_f64: " ^ Numerics.num_to_f64_string f64)
  | "PRINT_I32_F32" ->
    let i32 = local 0 |> as_const "I32" in
    let f32 = local 1 |> as_const "F32" in
    print_endline ("- print_i32_f32: " ^ Numerics.num_to_i32_string i32 ^ " " ^ Numerics.num_to_f32_string f32 )
  | "PRINT_F64_F64" ->
    let f64 = local 0 |> as_const "F64" in
    let f64' = local 1 |> as_const "F64" in
    print_endline ("- print_f64_f64: " ^ Numerics.num_to_f64_string f64 ^ " " ^ Numerics.num_to_f64_string f64' )
  | _ -> failwith "Impossible"

and execute (wasm_instr: value): unit =
  match wasm_instr with
  | ConstructV ("CONST", _) | ConstructV ("REF.NULL", _) ->
    WasmContext.push_value wasm_instr
  | ConstructV (name, []) when is_builtin name ->
    call_builtin name;
  | ConstructV (fname, args) ->
    call_algo fname args |> ignore
  | v ->
    string_of_value v
    |> Printf.sprintf "Executing invalid value: %s"
    |> failwith

and interp_instr (env: env) (instr: instr): env =
  (*
  string_of_instr (ref 0) 0 instr |> Printf.sprintf "[INSTR]: %s" |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AL_Context.string_of_context_stack () |> print_endline;
  print_endline "";
  *)

  let res =
  match instr with
  (* Block instruction *)
  | IfI (c, il1, il2) ->
    if eval_cond env c then
      interp_instrs env il1
    else
      interp_instrs env il2
  | EitherI (il1, il2) ->
    begin try interp_instrs env il1 with
    | Exception.MissingReturnValue
    | Exception.OutOfMemory -> interp_instrs env il2
    end
  | AssertI _ -> (*assert (eval_cond env c);*) env
  | PushI e ->
    begin match eval_expr env e with
    | ListV vs -> Array.iter WasmContext.push_value !vs
    | v -> WasmContext.push_value v
    end;
    env
  | PopI (IterE (NameE name, [name'], ListN (e', None))) when name = name' ->
    let i = eval_expr env e' |> value_to_int in
    let vs = List.rev (List.init i (fun _ -> WasmContext.pop_value ())) in
    Env.add name (listV vs) env
  | PopI e ->
    begin match (e, WasmContext.pop_value ()) with
    | ConstructE (("CONST", _), [NameE nt; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
      env
      |> Env.add nt ty
      |> Env.add name v
    | ConstructE (("CONST", _), [tyE; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
      assert (eval_expr env tyE = ty);
      Env.add name v env
    | NameE name, v -> Env.add name v env
    (* TODO remove this *)
    | FrameE _, FrameV _ -> env
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
    let vs = pop_all [] |> listV in
    Env.add name vs env
  | PopAllI e ->
    string_of_expr e
    |> Printf.sprintf "Invalid pop: Popall %s"
    |> failwith
  | LetI (pattern, e) ->
    assign pattern (eval_expr env e) env
  | CallI _ -> failwith "No CallI"
  | PerformI (f, el) ->
    let args = List.map (eval_expr env) el in
    dsl_function_call f args |> ignore;
    env
  | TrapI -> raise Exception.Trap
  | NopI -> env
  | ReturnI None -> env
  | ReturnI (Some e) ->
    eval_expr env e |> AL_Context.set_return_value;
    env
  | ExecuteI e ->
    eval_expr env e |> execute;
    env
  | ExecuteSeqI e ->
    eval_expr env e
    |> value_to_list
    |> List.iter execute;
    env
  | EnterI (e1, e2, il) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in

    WasmContext.push_context (v1, [], value_to_list v2);
    AL_Context.increase_depth ();

    (* TODO: refactor cleanup *)
    let previous_depth = AL_Context.get_depth () in
    let rec cleanup () =
      let current_depth = AL_Context.get_depth () in
      if current_depth = previous_depth then (
        WasmContext.pop_instr () |> execute;
        cleanup ()
      )
    in

    (* NOTE: doesn't have variable scope *)
    let new_env = interp_instrs env il in
    cleanup ();
    new_env
  | ExitAbruptI _ ->
    WasmContext.pop_context () |> ignore;
    AL_Context.decrease_depth ();
    env
  | ReplaceI (e1, IndexP e2, e3) ->
    let a = eval_expr env e1 |> value_to_array in
    let i = eval_expr env e2 |> value_to_int in
    let v = eval_expr env e3 in
    Array.set a i v;
    env
  | ReplaceI (e1, SliceP (e2, e3), e4) ->
    let a1 = eval_expr env e1 |> value_to_array in (* dest *)
    let i1 = eval_expr env e2 |> value_to_int in   (* start index *)
    let i2 = eval_expr env e3 |> value_to_int in   (* length *)
    let a2 = eval_expr env e4 |> value_to_array in (* src *)
    assert (Array.length a2 = i2);
    Array.iteri (fun i v -> Array.set a1 (i1 + i) v) a2;
    env
  | ReplaceI (e1, DotP (s, _), e2) ->
    begin match eval_expr env e1 with
    | RecordV r ->
        let v = eval_expr env e2 in
        Record.replace s v r
    | _ -> failwith "Not a Record"
    end;
    env
  | AppendI (e1, e2) ->
    let a = eval_expr env e1 |> value_to_growable_array in
    let v = eval_expr env e2 in
    a := Array.append (!a) [|v|];
    env
  | AppendListI (e1, e2) ->
    let a1 = eval_expr env e1 |> value_to_growable_array in
    let a2 = eval_expr env e2 |> value_to_array in
    a1 := Array.append (!a1) a2;
    env
  | i ->
    structured_string_of_instr 0 i
    |> Printf.sprintf "Interpreter is not implemented for the instruction: %s"
    |> failwith
  in

  (*
  string_of_instr (ref 0) 0 instr |> Printf.sprintf "[END INSTR]: %s" |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AL_Context.string_of_context_stack () |> print_endline;
  print_endline "";
  *)

  res

and interp_instrs (env: env) (il: instr list): env =
  match il with
  | [] -> env
  | h :: t ->
    let new_env = interp_instr env h in
    if AL_Context.get_return_value () = Bot then
      interp_instrs new_env t
    else
      new_env
      


(* Algorithm *)

(* TODO: move to ds.ml *)

and interp_algo (algo: algorithm) (args: value list): unit =

  let params = get_param algo in

  let env =
    Env.empty
    |> Env.add_store
    |> List.fold_right2 assign params args
  in

  get_body algo |> interp_instrs env |> ignore

and call_algo (name: string) (args: value list): AL_Context.return_value =
  (*
  print_endline "**************************************";
  Printf.sprintf "[ALGO]: %s" name |> print_endline;
  Print.string_of_list Print.string_of_value "[" ", " "]"args |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AL_Context.string_of_context_stack () |> print_endline;
  print_endline "";
  *)

  (* Push AL context *)
  let al_context = AL_Context.create_context name in
  AL_Context.push_context al_context;

  (* Interp algorithm *)
  let algo = lookup name in
  interp_algo algo args;

  (* Pop AL context *)
  let (_, return_value, depth) = AL_Context.pop_context () in

  (*
  Printf.sprintf "[END ALGO]: %s" name |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AL_Context.string_of_context_stack () |> print_endline;
  print_endline "";
  *)

  assert (depth = 0);
  return_value

(* Entry *)

let instantiation (args: value list): value =
  match call_algo "instantiate" args with
  | AL_Context.Some module_inst -> module_inst
  | _ -> failwith "Instantiation doesn't return module instance"
let invocation (args: value list): value =
  match call_algo "invoke" args with
  | AL_Context.Some v -> v
  | _ -> failwith "Invocation doesn't return value"
