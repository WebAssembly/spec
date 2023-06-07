open Print
open Al
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

(* Environmet *)

(* TODO: Perhaps automatically generate this *)
let store : store ref = ref Record.empty
let init_store () =
  store := Record.empty
    |> Record.add "FUNC" (listV [])
    |> Record.add "GLOBAL" (listV [])
    |> Record.add "TABLE" (listV [])
    |> Record.add "MEM" (listV [])
    |> Record.add "ELEM" (listV [])
    |> Record.add "DATA" (listV [])

let add_store s =
  let concat_listv v1 v2 =
    match v1, v2 with
    | ListV l1, ListV l2 -> ListV (ref (Array.append !l1 !l2))
    | _ -> failwith "Invalid store"
  in

  let func = concat_listv (Record.find "FUNC" !store) (Record.find "FUNC" s) in
  let global = concat_listv (Record.find "GLOBAL" !store) (Record.find "GLOBAL" s) in
  let table = concat_listv (Record.find "TABLE" !store) (Record.find "TABLE" s) in
  let mem = concat_listv (Record.find "MEM" !store) (Record.find "MEM" s) in
  let elem = concat_listv (Record.find "ELEM" !store) (Record.find "ELEM" s) in
  let data = concat_listv (Record.find "DATA" !store) (Record.find "DATA" s) in

  store := Record.empty
    |> Record.add "FUNC" func
    |> Record.add "GLOBAL" global
    |> Record.add "TABLE" table
    |> Record.add "MEM" mem
    |> Record.add "ELEM" elem
    |> Record.add "DATA" data

module Env = struct
  module EnvKey = struct
    type t = name

    let compare a b = Stdlib.compare (string_of_name a) (string_of_name b)
  end

  module Env' = Map.Make (EnvKey)

  type t = name Env'.t * value

  (* Result *)
  let get_result (_, res) = res
  let set_result v (env, _) = (env, v)

  (* Printer *)
  let string_of_env env =
    Print.string_of_list
      (fun (k, v) -> Print.string_of_name k ^ ": " ^ Print.string_of_value v)
      "\n{" ",\n  " "\n}" (Env'.bindings env)

  (* Environment API *)
  let empty =
    (Env'.add (N "s") (StoreV store) Env'.empty, StringV "Undefined")

  let find key (env, _) =
    try Env'.find key env
    with Not_found ->
      Printf.sprintf "The key '%s' is not in the map: %s."
        (Print.string_of_name key) (string_of_env env)
      |> prerr_endline;
      raise Not_found

  let add key elem (env, res) = (Env'.add key elem env, res)
end

let stack : stack ref = ref []
let init_stack () = stack := []
let push v = stack := v :: !stack
let pop () =
  let res = List.hd !stack in
  stack := List.tl !stack;
  res

let get_current_label () =
  match List.find_opt (function LabelV _ -> true | _ -> false) !stack with
  | Some label -> label
  | None -> failwith "No label" (* Due to Wasm validation, unreachable *)

let get_current_frame () =
  match List.find_opt (function FrameV _ -> true | _ -> false) !stack with
  | Some frame -> frame
  | None -> failwith "No frame" (* Due to Wasm validation, unreachable *)

(* Evaluation Context *)

exception ExitContext of (value Env.Env'.t * value) * instr list

(* Helper functions *)

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

let rec take n l =
  if n = 0 then [], l
  else match l with
  | [] -> raise (Invalid_argument "take")
  | hd :: tl ->
    let prefix, suffix = take (n-1) tl in
    hd :: prefix, suffix

let sublist st len l =
  let head, rest = take st l in
  let body, tail = take len rest in
  (head, body, tail)

let rec list_set l i x =
  match l, i with
  | [], _ -> raise (Invalid_argument "list_set")
  | _ :: tl, 0 -> x :: tl
  | hd :: tl, _ -> hd :: (list_set tl (i-1) x)

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

(* Interpreter *)

let cnt = ref 0
let wcnt = ref 0

let rec dsl_function_call fname args =
  match fname with
  (* Numerics *)
  | N name when Numerics.mem name -> Numerics.call_numerics name args
  (* Module & Runtime *)
  | N name when AlgoMap.mem name !algo_map ->
      call_algo name args
  | n ->
      string_of_name n
      |> Printf.sprintf "Invalid DSL function call: %s"
      |> failwith

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
  | AppE (fname, el) -> List.map (eval_expr env) el |> dsl_function_call fname
  | MapE (fname, [ e ], _) ->
      (* TODO: handle cases where more than 1 arguments *)
      let l = eval_expr env e |> value_to_list in
      listV (List.map (fun v -> dsl_function_call fname [ v ]) l)
  (* Data Structure *)
  | ListE el -> listV (List.map (eval_expr env) el)
  | ListFillE (e1, e2) ->
      let v = eval_expr env e1 in
      let i = eval_expr env e2 |> value_to_int in
      if i > 256 * 64 * 1024 then (* 256 pages *)
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
  | AccessE (e, p) -> begin match p with
      | IndexP e' ->
        let a = eval_expr env e |> value_to_array in
        let i = eval_expr env e' |> value_to_int in
        ( try Array.get a i with Invalid_argument _ -> failwith ("Failed Array.get during AccessE") )
      | SliceP (e1, e2) ->
        let a = eval_expr env e |> value_to_array in
        let i1 = eval_expr env e1 |> value_to_int in
        let i2 = eval_expr env e2 |> value_to_int in
        let a' = Array.sub a i1 i2 in
        ListV (ref a')
      | DotP str -> begin match eval_expr env e with
        | FrameV (_, RecordV r) -> Record.find str r
        | StoreV s -> Record.find str !s
        | RecordV r -> Record.find str r
        | v ->
            string_of_value v
            |> Printf.sprintf "Not a record: %s"
            |> failwith
        end
      end
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
  | ContE e -> (
      let v = eval_expr env e in
      match v with
      | LabelV (_, vs) -> vs
      | _ -> failwith "Not a label")
  | NameE (name, _) -> Env.find name env
  | e -> structured_string_of_expr e |> failwith

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
  | IsDefinedC e ->
      begin match eval_expr env e with
      | OptV (Some (_)) -> true
      | OptV (_) -> false
      | _ -> structured_string_of_cond cond |> failwith
      end
  | IsTopC "value" -> (
      match !stack with
      | [] -> false
      | h :: _ -> ( match h with ConstructV _ -> true | _ -> false))
  | IsTopC "frame" -> (
      match !stack with
      | [] -> false
      | h :: _ -> ( match h with FrameV _ -> true | _ -> false))
  | IsCaseOfC (e, expected_tag) -> (
      match eval_expr env e with
      | ConstructV (tag, _) -> expected_tag = tag
      | _ -> false)
  | c -> structured_string_of_cond c |> failwith

and interp_instrs env il =
  if !cnt > 3000000 then raise Exception.Timeout else cnt := !cnt + 1;
  match il with
  | [] -> env
  | i :: cont ->
    (* string_of_stack !stack |> print_endline; *)
    (* structured_string_of_instr 0 i |> print_endline; *)
    (* string_of_instr (ref 0) 0 i |> print_endline; *)
    let (env, cont) = (
      match i with
      | IfI (c, il1, il2) ->
          let env = if eval_cond env c then interp_instrs env il1 else interp_instrs env il2 in
          (env, cont)
      | WhileI (c, il) ->
          let rec interp_while env =
            if eval_cond env c then interp_while (interp_instrs env il)
            else env
          in
          (interp_while env, cont)
      | EitherI (il1, il2) ->
          let (orig_store, orig_stack) = (!store, !stack) in
          let env = try
            interp_instrs env il1
          with Exception.OutOfMemory -> (
            store := orig_store;
            stack := orig_stack;
            interp_instrs env il2 ) in
          (env, cont)
      | ForI (e, il) ->
          (match eval_expr env (LengthE e) with
            | NumV n ->
                let n = Int64.to_int n in
                for i = 0 to n - 1 do
                  let new_env = Env.add (N "i") (NumV (Int64.of_int i)) env in
                  interp_instrs new_env il |> ignore
                done;
                (env, cont)
            | _ -> failwith "Unreachable")
      | AssertI _ -> (env, cont) (* TODO: insert assertion *)
      | PushI e ->
          (match eval_expr env e with
          | ListV vs -> Array.iter push (!vs)
          | v -> push v);
          (env, cont)
      | PopI e ->
          let env = (
            match e with
            | NameE (name, [ ListN n ]) ->
                let i = Env.find n env |> value_to_int in
                let vs = List.rev (List.init i (fun _ -> pop ())) in
                Env.add name (listV vs) env
            | _ -> (
                (* due to Wasm validation *)
                let h = pop () in

                match (e, h) with
                | ConstructE ("CONST", [NameE (nt, _); NameE (name, _)]), ConstructV ("CONST", [ ty; v ]) ->
                    env |> Env.add nt ty |> Env.add name v
                | ConstructE ("CONST", [tyE; NameE (name, _)]), ConstructV ("CONST", [ ty; v ]) ->
                    assert (eval_expr env tyE = ty);
                    Env.add name v env
                | NameE (name, _), v -> Env.add name v env
                | _ -> failwith (Printf.sprintf "Invalid pop: %s := %s" (structured_string_of_expr e) (structured_string_of_value h))))
          in
          (env, cont)
      | PopAllI e -> (
        match e with
        | NameE (name, [ List ]) ->
          let rec pop_value vs = (match !stack with
          | h :: _  -> (match h with
            | ConstructV ("CONST", _) -> pop_value (pop () :: vs)
            | _ -> vs)
          | _ -> vs)
          in
          let vs = pop_value [] in
          let env = Env.add name (listV vs) env in
          (env, cont)
        | _ -> failwith "Invalid pop")
      | LetI (pattern, e) ->
          let rec assign lhs rhs env =
            match lhs, rhs with
            | NameE (name, [ ListN n ]), ListV vs ->
                env |> Env.add name rhs |> Env.add n (NumV (Int64.of_int (Array.length !vs)))
            | NameE (name, _), v ->
                Env.add name v env
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
            (* TODO: Remove this. This should be handled by animation *)
            | BinopE (Mul, BinopE (Mul, NameE (name, _), e1), e2), NumV m ->
                let n1 = eval_expr env e1 |> value_to_int in
                let n2 = eval_expr env e2 |> value_to_int in
                Env.add name (NumV (Int64.of_int (Int64.to_int m / n1 / n2))) env
            | e, v ->
                Printf.sprintf "Invalid assignment: %s := %s"
                  (string_of_expr e) (string_of_value v)
                |> failwith
          in
          let env = assign pattern (eval_expr env e) env in
          (env, cont)
      | TrapI -> raise Exception.Trap
      | NopI | ReturnI None -> (env, cont)
      | ReturnI (Some e) ->
          let result = eval_expr env e in
          let env = Env.set_result result env in
          (env, cont)
      | PerformI e ->
          eval_expr env e |> ignore;
          (env, cont)
      | ExecuteI e ->
          eval_expr env e |> execute_wasm_instr;
          (env, cont)
      | ExecuteSeqI e ->
          eval_expr env e |> value_to_list |> execute_wasm_instrs;
          (env, cont)
      | JumpI e ->
          let l = eval_expr env e |> value_to_list in
          (try
            execute_wasm_instrs l; (env, cont)
          with
            ExitContext (env', cont') -> (env', cont'))
      | ExitNormalI _ ->
          let rec pop_while pred =
            let top = pop () in
            if pred top then top :: pop_while pred else []
          in
          (* TODO: When Labels and Frames are expressed with ConstructV, the predicate should be changed accordingly *)
          let vs = pop_while (function ConstructV _ -> true | _ -> false) in
          vs |> List.rev |> List.iter push;
          (env, cont)
      | ExitAbruptI n ->
          let rec pop_while pred =
            let top = pop () in
            if pred top then top :: pop_while pred else []
          in
          let until = Env.find n env in
          let vs = pop_while (function ConstructV _ -> true | _ -> false) in
          vs |> List.rev |> List.iter push;
          (match until with
          | LabelV _ -> raise (ExitContext (env, cont))
          | _ -> ());
          (env, cont)
      | ReplaceI (e1, IndexP e2, e3) ->
          let a = eval_expr env e1 |> value_to_array in
          let i = eval_expr env e2 |> value_to_int in
          let v = eval_expr env e3 in
          Array.set a i v;
          (env, cont)
      | ReplaceI (e1, SliceP (e2, e3), e4) ->
          let a1 = eval_expr env e1 |> value_to_array in (* dest *)
          let i1 = eval_expr env e2 |> value_to_int in   (* start index *)
          let i2 = eval_expr env e3 |> value_to_int in   (* length *)
          let a2 = eval_expr env e4 |> value_to_array in (* src *)
          assert (Array.length a2 = i2);
          Array.iteri (fun i v -> Array.set a1 (i1 + i) v) a2;
          (env, cont)
      | AppendI (e1, e2) ->
          let a = eval_expr env e1 |> value_to_growable_array in
          let v = eval_expr env e2 in
          a := Array.append (!a) [|v|];
          (env, cont)
      | AppendListI (e1, e2) ->
          let a1 = eval_expr env e1 |> value_to_growable_array in
          let a2 = eval_expr env e2 |> value_to_array in
          a1 := Array.append (!a1) a2;
          (env, cont)
      | i -> "Interpreter is not implemented for the instruction: " ^ structured_string_of_instr 0 i |> failwith)
    in
    interp_instrs env cont

and interp_algo algo args =
  let (Algo (_, params, il)) = algo in
  assert (List.length params = List.length args);

  let f acc param arg =
    let pattern, _ = param in
    match (pattern, arg) with
    | NameE (n, _), arg -> Env.add n arg acc
    | _ -> failwith "Invalid destructuring assignment"
  in

  let init_env = List.fold_left2 f Env.empty params args in

  interp_instrs init_env il



(* Search AL Algorithm *)

and call_algo name args =
  (* (name ^ string_of_list string_of_value "(" "," ")" args) |> print_endline; *)
  (* string_of_stack !stack |> print_endline; *)
  let algo =
    match AlgoMap.find_opt name !algo_map with
      | Some v -> v
      | None -> failwith ("Algorithm " ^ name ^ " not found")
  in
  interp_algo algo args |> Env.get_result

and execute_wasm_instr winstr =
  (* Print.string_of_value winstr |> prerr_endline; *)
  (* string_of_stack !stack |> prerr_endline; *)
  (* string_of_record !store |> prerr_endline; *)
  wcnt := !wcnt + 1;
  if !wcnt > 10000 then raise Exception.Timeout;
  match winstr with
  | ConstructV ("CONST", _) | ConstructV ("REF.NULL", _) -> push winstr
  | ConstructV (name, args) -> call_algo ("execution_of_" ^ String.lowercase_ascii name) args |> ignore
  | _ -> failwith (string_of_value winstr ^ " is not a wasm instruction")

and execute_wasm_instrs winstrs = List.iter execute_wasm_instr winstrs


(* Entry *)
let init algos =

  algo_map := to_map algos;

  (* Add manual algorithms *)
  print_endline "** Manual algorithms **\n";

  algo_map :=
    List.fold_left
      (fun acc algo ->
        string_of_algorithm algo |> print_endline;
        let (Algo (name, _, _)) = algo in
        AlgoMap.add name algo acc)
      !algo_map Manual.manual_algos;
