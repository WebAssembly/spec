open Al
open Al.Ast
open Al.Print
open Reference_interpreter

(* AL Data Structures *)

(* Algorithm Map *)

module AlgoMapKey = struct
  type t = string

  let compare = Stdlib.compare
end

module AlgoMap = Map.Make (AlgoMapKey)

let algo_map = ref AlgoMap.empty

let to_map algos =
  let f acc algo =
    let (Algo (name, _, _)) = algo in
    AlgoMap.add name algo acc
  in

  List.fold_left f AlgoMap.empty algos

(* Store *)

(* TODO: Perhaps automatically generate this *)
let store : store ref = ref Record.empty

(* Environmet *)

module EnvKey = struct
  type t = name

  let compare a b = Stdlib.compare (string_of_name a) (string_of_name b)
end

module Env = struct include Map.Make (EnvKey)

  (* Printer *)
  let string_of_env env =
    Print.string_of_list
      (fun (k, v) ->
        Print.string_of_name k ^ ": " ^ Print.string_of_value v)
      "\n{" ",\n  " "\n}"
      (bindings env)

  (* Environment API *)
  let find key env =
    try find key env
    with Not_found ->
      Printf.sprintf "The key '%s' is not in the map: %s."
        (Print.string_of_name key) (string_of_env env)
      |> prerr_endline;
      raise Not_found
end

type env = value Env.t

(* Stack *)

let stack : stack ref = ref []
let init_stack () = stack := []
let push v = stack := v :: !stack
let pop () =
  try
    let res = List.hd !stack in
    stack := List.tl !stack;
    res
  with _ -> failwith "Pop some values from empty stack"

(* Context *)

let rec pop_context' vs =
  let v = pop () in
  match v with
  | ConstructV _ -> pop_context' (v :: vs)
  | v -> v :: vs

let pop_context () = pop_context' []

let get_current_label () =
  try
    List.find (function LabelV _ -> true | _ -> false) !stack
  (* Due to Wasm validation, unreachable *)
  with Not_found -> failwith "No label"

let get_current_frame () =
  try
    List.find (function FrameV _ -> true | _ -> false) !stack
  (* Due to Wasm validation, unreachable *)
  with Not_found -> failwith "No frame"

let get_current_context () =
  try
    List.find (function FrameV _ | LabelV _ -> true | _ -> false) !stack
  (* Due to Wasm validation, unreachable *)
  with Not_found -> failwith "Not in context"

(* Evaluation Context *)

exception ExitContext of (env * value) * instr list

(* Helper functions *)

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

(* Interpreter *)

let cnt = ref 0

let rec eval_expr env expr =
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
  | AppE (_fname, _el) -> failwith "AppE should be removed by transpiler"
  (* Data Structure *)
  | ListE el -> listV (List.map (eval_expr env) el)
  | ListFillE (e1, e2) ->
      let v = eval_expr env e1 in
      let i = eval_expr env e2 |> value_to_int in
      if i > 1024 * 64 * 1024 then (* 1024 pages *)
        raise Exception.OutOfMemory
      else
        listV (List.init i (function _ -> v))
  | ConcatE (e1, e2) ->
      let a1 = eval_expr env e1 |> value_to_array in
      let a2 = eval_expr env e2 |> value_to_array in
      ListV (Array.append a1 a2 |> ref)
  | LengthE e ->
      let a = eval_expr env e |> value_to_array in
      NumV (I64.of_int_u (Array.length a))
  | RecordE r -> RecordV (Record.map (fun e -> eval_expr env e) r)
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
  | ConstructE (tag, el) -> ConstructV (tag, List.map (eval_expr env) el) |> check_i32_const
  | OptE opt -> OptV (Option.map (eval_expr env) opt)
  | PairE (e1, e2) -> PairV (eval_expr env e1, eval_expr env e2)
  (* Context *)
  | ArityE e -> (
      match eval_expr env e with
      | LabelV (v, _) -> v
      | FrameV (v, _) -> v
      | _ -> failwith "Not a label" (* Due to AL validation, unreachable *))
  | FrameE (e1, e2) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | NumV _, RecordV _ -> FrameV (v1, v2)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid frame: " ^ string_of_expr expr |> failwith)
  | GetCurFrameE -> get_current_frame ()
  | LabelE (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      LabelV (v1, v2)
  | GetCurLabelE -> get_current_label ()
  | GetCurContextE -> get_current_context ()
  | ContE e -> (
      let v = eval_expr env e in
      match v with
      | LabelV (_, vs) -> vs
      | _ -> failwith "Not a label")
  | NameE name -> Env.find name env
  | IterE (inner_e, names, iter) ->
      env
      |> create_sub_envs names iter
      |> List.map (fun new_env -> eval_expr new_env inner_e)
      |> if (iter = Opt)
      then
        (function
          | [] -> OptV None
          | [v] -> OptV (Some v)
          | _ -> failwith "Unreachable")
      else listV
  | e -> structured_string_of_expr e |> failwith

and create_sub_envs names iter env =
  let name_to_value name = Env.find name env in
  let option_name_to_list name = name |> name_to_value |> value_to_option |> Option.to_list in
  let name_to_list name = name |> name_to_value |> value_to_list in
  let length_to_list l = List.init l (fun i -> NumV (Int64.of_int i)) in

  let name_to_values name =
    match iter with
    | Opt -> option_name_to_list name
    | ListN (e_n, Some _) -> eval_expr env e_n |> value_to_int |> length_to_list
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
      ( try Array.get a i with Invalid_argument _ -> failwith ("Failed Array.get during ReplaceE") )
  | SliceP (e1, e2) ->
      let a = base |> value_to_array in
      let i1 = eval_expr env e1 |> value_to_int in
      let i2 = eval_expr env e2 |> value_to_int in
      let a' = Array.sub a i1 i2 in
      ListV (ref a')
  | DotP str -> (
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
  | DotP str ->
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

let rec eval_cond env cond =
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
  | ContextKindC (kind, e) ->
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
  | IsCaseOfC (e, expected_tag) -> (
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
  | c -> structured_string_of_cond c |> failwith

type map_info = (string * value list * value list * value list)

type context = env * instr list * action
and wstack = (value list * context) list
(* Specifies what to do upon obtaining a value *)
and action =
  | Pass
  | AssignLhs of expr option * context
  | JumpToNextWinstr
  | ExecuteWinstrs of value list * context
  (* TODO: remove all Func *)
  | Func of (value -> value)

let merge_envs_with_grouping default_env envs =
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

let rec assign lhs rhs env =
  match lhs, rhs with
  | NameE name, v -> Env.add name v env
  | IterE (e, _, iter), _ ->
      let new_env, default_rhs, rhs_list =
        match iter, rhs with
        | (List | List1), ListV arr -> env, listV [], Array.to_list !arr
        | ListN (expr, None), ListV arr ->
            let length = Array.length !arr |> Int64.of_int |> Value.num in
            assign expr length env, listV [], Array.to_list !arr
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

      List.map (fun v -> assign e v Env.empty) rhs_list
      |> merge_envs_with_grouping default_env
      |> Env.union (fun _ _ v -> Some v) new_env
  | PairE (lhs1, lhs2), PairV (rhs1, rhs2)
  | ArrowE (lhs1, lhs2), ArrowV (rhs1, rhs2) ->
      env |> assign lhs1 rhs1 |> assign lhs2 rhs2
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
      List.fold_right2 assign lhs_s (!rhs_s |> Array.to_list) env
  | ConstructE (lhs_tag, lhs_s), ConstructV (rhs_tag, rhs_s)
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
  | RecordE r1, RecordV r2 when Record.keys r1 = Record.keys r2 ->
      Record.fold (fun k v acc -> (Record.find k r2 |> assign v) acc) r1 env
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

let assign_opt lhs_opt rhs env = match lhs_opt with
  | None -> env
  | Some lhs -> assign lhs rhs env

let rec dsl_function_call lhs_opt fname args iters env il cont action =
  match fname with
  (* Numerics *)
  | N name when Numerics.mem name ->
      let rec aux env = function
      | [] ->
        let vs = List.map (eval_expr env) args in
        Numerics.call_numerics name vs
      | (names, dim) :: iters' ->
        let envs = create_sub_envs names dim env in
        List.map (fun env' -> aux env' iters') envs |> listV (* TODO: handle case where dim is Opt *)
      in
      let rhs = aux env iters in
      interp_instrs (assign_opt lhs_opt rhs env) il cont action
  (* Module & Runtime *)
  | N name when AlgoMap.mem name !algo_map ->
      let new_action = AssignLhs(lhs_opt, (env, il, action)) in
      call_algo name args iters env cont new_action
  | n ->
      string_of_name n
      |> Printf.sprintf "Invalid DSL function call: %s"
      |> failwith

and interp_instrs env il cont action =
  (* if !cnt > 2000000 then raise Exception.Timeout else cnt := !cnt + 1; *)
  (* Printexc.get_callstack 1000 |> Printexc.raw_backtrace_length |> print_int; print_endline ""; *)
  match il with
  | [] -> leave_algo cont action
  | i :: icont ->
    (* string_of_stack !stack |> print_endline; *)
    (* structured_string_of_instr 0 i |> print_endline; *)
    (* string_of_instr (ref 0) 0 i |> print_endline; *)
    let interp il = interp_instrs env il cont action in
    let interp_with env il = interp_instrs env il cont action in
    ( match i with
    | IfI (c, il1, il2) ->
        if eval_cond env c then interp (il1 @ icont) else interp (il2 @ icont)
    | WhileI (c, il) ->
        if eval_cond env c then interp (il @ (i :: icont)) else interp icont
    | EitherI (il1, il2) -> (
        (*TODO: Make EitherI cps *)
        try interp (il1 @ icont) with
        | Exception.MissingReturnValue
        | Exception.OutOfMemory -> interp (il2 @ icont)
    )
    | ForI (e, il') ->
        let n = eval_expr env e |> value_to_array |> Array.length in
        interp_for n il' env icont cont action
    | AssertI _ -> interp icont (* TODO: insert assertion *)
    | PushI e ->
        (match eval_expr env e with
        | ListV vs -> Array.iter push (!vs)
        | v -> push v);
        interp icont
    | PopI e ->
        let new_env = (
          match e with
          | IterE (NameE name, [name'], ListN (e', None)) when name = name' ->
              let i = eval_expr env e' |> value_to_int in
              let vs = List.rev (List.init i (fun _ -> pop ())) in
              Env.add name (listV vs) env
          | _ -> (
              (* due to Wasm validation *)
              let h = pop () in

              match (e, h) with
              | ConstructE ("CONST", [NameE nt; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
                  env |> Env.add nt ty |> Env.add name v
              | ConstructE ("CONST", [tyE; NameE name]), ConstructV ("CONST", [ ty; v ]) ->
                  assert (eval_expr env tyE = ty);
                  Env.add name v env
              | NameE name, v -> Env.add name v env
              | _ -> failwith (Printf.sprintf "Invalid pop: %s := %s" (structured_string_of_expr e) (structured_string_of_value h))))
        in
        interp_with new_env icont
    | PopAllI e -> (
      match e with
      | IterE (NameE name, [name'], List) when name = name' ->
        let is_boundary = function FrameV _ | LabelV _ -> true | _ -> false in
        let rec pop_value acc = match !stack with
        | h :: _  when not (is_boundary h) -> pop_value (pop () :: acc)
        | _ -> acc in
        let vs = pop_value [] in
        let new_env = Env.add name (listV vs) env in
        interp_with new_env icont
      | _ -> failwith ("Invalid pop: Popall " ^ string_of_expr e))
    | LetI (pattern, e) ->
        let new_env = assign pattern (eval_expr env e) env in
        interp_with new_env icont
    | CallI (lhs, f, args, iters) ->
        dsl_function_call (Some lhs) f args iters env icont cont action
    | TrapI -> raise Exception.Trap
    | NopI -> interp icont
    | ReturnI None -> leave_algo cont action
    | ReturnI (Some e) -> return_some (eval_expr env e) cont action
    | PerformI (f, args) ->
        dsl_function_call None f args [] env icont cont action
    | ExecuteI e ->
        let winstrs = [eval_expr env e] in
        execute_wasm_instrs winstrs env icont cont action false
    | ExecuteSeqI e ->
        let winstrs = eval_expr env e |> value_to_list in
        execute_wasm_instrs winstrs env icont cont action false
    | JumpI e ->
        let winstrs = eval_expr env e |> value_to_list in
        let exit = ConstructV ("EXIT_CONTEXT", []) in
        execute_wasm_instrs (winstrs @ [exit]) env icont cont action true
    | ExitNormalI _ -> failwith "ExitNormalI should be removed"
    | ExitAbruptI _ ->
        let rec pop_while pred =
          let top = pop () in
          if pred top then top :: pop_while pred else [ top ]
        in
        let vs = pop_while (function ConstructV _ -> true | _ -> false) |> List.rev in
        let ctx = List.hd vs in
        vs |> List.tl |> List.iter push;
        ( match ctx with
        | LabelV _ -> ( match cont with
          | (_, ctxt) :: rest ->
            (* Pretend as if rest of instructions were executed in outter context *)
            let new_action = AssignLhs (None, ctxt) in
            interp_instrs env icont rest new_action
          | _ -> failwith "Cannot abruptly exit: no context")
        | FrameV _ -> interp_instrs env icont cont action
        | _ -> failwith "Unreachable" )
    | ReplaceI (e1, IndexP e2, e3) ->
        let a = eval_expr env e1 |> value_to_array in
        let i = eval_expr env e2 |> value_to_int in
        let v = eval_expr env e3 in
        Array.set a i v;
        interp icont
    | ReplaceI (e1, SliceP (e2, e3), e4) ->
        let a1 = eval_expr env e1 |> value_to_array in (* dest *)
        let i1 = eval_expr env e2 |> value_to_int in   (* start index *)
        let i2 = eval_expr env e3 |> value_to_int in   (* length *)
        let a2 = eval_expr env e4 |> value_to_array in (* src *)
        assert (Array.length a2 = i2);
        Array.iteri (fun i v -> Array.set a1 (i1 + i) v) a2;
        interp icont
    | ReplaceI (e1, DotP s, e2) ->
        begin match eval_expr env e1 with
        | RecordV r ->
            let v = eval_expr env e2 in
            Record.replace s v r
        | _ -> failwith "Not a Record"
        end;
        interp icont
    | AppendI (e1, e2) ->
        let a = eval_expr env e1 |> value_to_growable_array in
        let v = eval_expr env e2 in
        a := Array.append (!a) [|v|];
        interp icont
    | AppendListI (e1, e2) ->
        let a1 = eval_expr env e1 |> value_to_growable_array in
        let a2 = eval_expr env e2 |> value_to_array in
        a1 := Array.append (!a1) a2;
        interp icont
    | i -> "Interpreter is not implemented for the instruction: " ^ structured_string_of_instr 0 i |> failwith)

and interp_for n body env il cont action =
  let unrolled = List.init n (fun i ->
    LetI (NameE (N "i"), NumE (Int64.of_int i)) :: body
  ) in
  interp_instrs env (List.concat unrolled @ il) cont action

and return_some v cont = function
| Pass -> v
| AssignLhs (lhs_opt, (env, il, action)) ->
    interp_instrs (assign_opt lhs_opt v env) il cont action
| Func f -> f v
| _ -> failwith "Impossible action for return_some"

and leave_algo cont = function
| AssignLhs (None, (env, il, action)) ->
    interp_instrs env il cont action
| JumpToNextWinstr ->
    let winstrs, (env, il, action) = List.hd cont in
    execute_wasm_instrs winstrs env il (List.tl cont) action true
| ExecuteWinstrs (winstrs, (env, il, action)) ->
    execute_wasm_instrs winstrs env il cont action false
| _ -> raise Exception.MissingReturnValue

and interp_algo algo args cont action =
  let (Algo (_name, params, body)) = algo in
  assert (List.length params = List.length args);

  (* (name ^ string_of_list string_of_value "(" "," ")" args) |> print_endline; *)
  (* string_of_stack !stack |> print_endline; *)


  let env_with_store = Env.add (N "s") (StoreV store) Env.empty in
  let init_env = List.fold_right2 assign params args env_with_store in

  interp_instrs init_env body cont action

(* Search AL Algorithm *)

and get_algo name = match AlgoMap.find_opt name !algo_map with
  | Some v -> v
  | None -> failwith ("Algorithm " ^ name ^ " not found")

and call_algo name args iters env cont action =
  let algo = get_algo name in
  let handle_map_result result = return_some result cont in
  let rec aux iters envs acc action = match envs with
    | [] ->
      let ys = listV (List.rev acc) in
      handle_map_result ys action
    | env :: envs' ->
      let action' = Func (fun y ->
        aux iters envs' (y :: acc) action
      ) in
      aux' iters env action'
  and aux' iters env action = match iters with
    | [] ->
      let vs = List.map (eval_expr env) args in
      interp_algo algo vs cont action
    | (names, dim) :: iters' ->
      let envs = create_sub_envs names dim env in
      aux iters' envs [] action
  in

  aux' iters env action

and call_toplevel_algo name args =
  let algo = get_algo name in
  interp_algo algo args [] Pass

and is_builtin = function
  | "PRINT" | "PRINT_I32" | "PRINT_I64" | "PRINT_F32" | "PRINT_F64" | "PRINT_I32_F32" | "PRINT_F64_F64" -> true
  | _ -> false

and call_builtin name =
  let local x = call_toplevel_algo "local" [ NumV (Int64.of_int x) ] in
  let as_const ty = function
  | ConstructV ("CONST", [ ConstructV (ty', []) ; n ]) when ty = ty' -> n
  | _ -> failwith ("Not " ^ ty ^ ".CONST") in
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

and execute_wasm_instrs winstrs env il cont action is_jump =
  match winstrs with
  | [] -> interp_instrs env il cont action
  | winstr :: rest_winstr ->
    (* Print.string_of_value winstr |> prerr_endline; *)
    (* string_of_stack !stack |> prerr_endline; *)
    (* string_of_record !store |> prerr_endline; *)
    match winstr with
    | ConstructV ("CONST", _) | ConstructV ("REF.NULL", _) ->
      push winstr;
      execute_wasm_instrs rest_winstr env il cont action is_jump
    | ConstructV ("EXIT_CONTEXT", _) ->
      let rec pop_while pred =
        let top = pop () in
        if pred top then top :: pop_while pred else []
      in
      (* TODO: When Labels and Frames are expressed with ConstructV, the predicate should be changed accordingly *)
      let vs = pop_while (function ConstructV _ -> true | _ -> false) in
      vs |> List.rev |> List.iter push;
      (* If currently in frame, pop again *)
      ( try (
        let ctx = get_current_context() in
        match ctx with
        | FrameV _ ->
          let vs = pop_while (function FrameV _ -> false | _ -> true) in
          vs |> List.rev |> List.iter push
        | _ -> ()
      ) with _ -> () );
      execute_wasm_instrs rest_winstr env il cont action is_jump
    | ConstructV (name, []) when is_builtin name ->
      call_builtin name;
      execute_wasm_instrs rest_winstr env il cont action is_jump
    | ConstructV (name, args) ->
      let algo_name = ("execution_of_" ^ String.lowercase_ascii name) in
      let algo = get_algo algo_name in
      if is_jump then
        interp_algo algo args ((rest_winstr, (env, il, action)) :: cont) JumpToNextWinstr
      else
        interp_algo algo args cont (ExecuteWinstrs (rest_winstr, (env, il, action)))
    | _ -> failwith (string_of_value winstr ^ " is not a wasm instruction")

(* Entry *)
let init algos = algo_map := to_map algos;
