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
    |> Record.add "FUNC" (ListV [||])
    |> Record.add "GLOBAL" (ListV [||])
    |> Record.add "TABLE" (ListV [||])
    |> Record.add "MEM" (ListV [||])
    |> Record.add "ELEM" (ListV [||])
    |> Record.add "DATA" (ListV [||])

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
  match List.find_map (function LabelV l -> Some l | _ -> None) !stack with
  | Some label -> label
  | None -> failwith "No label" (* Due to Wasm validation, unreachable *)

let get_current_frame () =
  match List.find_map (function FrameV f -> Some f | _ -> None) !stack with
  | Some frame -> frame
  | None -> failwith "No frame" (* Due to Wasm validation, unreachable *)

(* Evaluation Context *)

exception ExitContext of (value Env.Env'.t * value) * instr list

(* Helper functions *)

let value_to_array = function ListV a -> a | v -> failwith (string_of_value v ^ "is not a list")
let value_to_list v = v |> value_to_array |> Array.to_list
let value_to_num = function NumV n -> n | v -> failwith (string_of_value v ^ "is not a number")
let value_to_int v = v |> value_to_num |> Int64.to_int

(* Interpreter *)

let cnt = ref 0
exception Trap
exception Timeout

let rec dsl_function_call fname args =
  match fname with
  (* Numerics *)
  | N name when Numerics.mem name ->
    ( try Numerics.call_numerics name args with Numerics.Trap -> raise Trap )
  (* Module & Runtime *)
  | N name when AlgoMap.mem name !algo_map ->
      call_algo name args
  | n ->
      string_of_name n
      |> Printf.sprintf "Invalid DSL function call: %s"
      |> failwith

and eval_expr env expr =
  match expr with
  | ValueE v -> v
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
          in
          NumV result
      | _ -> failwith "Not an integer"
      end
  | AppE (fname, el) -> List.map (eval_expr env) el |> dsl_function_call fname
  | MapE (fname, [ e ], _) -> (
      (* TODO: handle cases where more than 1 arguments *)
      match eval_expr env e with
      | ListV vs ->
          ListV (Array.map (fun v -> dsl_function_call fname [ v ]) vs)
      | _ ->
          Print.string_of_expr e ^ " is not iterable."
          |> failwith (* Due to WASM validation, unreachable *))
  | LengthE e ->
      let a = eval_expr env e |> value_to_array in
      NumV (I64.of_int_u (Array.length a))
  | ArityE e -> (
      match eval_expr env e with
      | LabelV (n, _) -> NumV n
      | FrameV (n, _) -> NumV n
      | _ -> failwith "Not a label" (* Due to AL validation, unreachable *))
  | GetCurLabelE -> LabelV (get_current_label ())
  | GetCurFrameE -> FrameV (get_current_frame ())
  | FrameE (e1, e2) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | NumV n, RecordV r -> FrameV (n, r)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid frame: " ^ string_of_expr expr |> failwith)
  | ConcatE (e1, e2) ->
      let a1 = eval_expr env e1 |> value_to_array in
      let a2 = eval_expr env e2 |> value_to_array in
      ListV (Array.append a1 a2)
  | ListE el -> ListV (Array.map (eval_expr env) el)
  | ListFillE (e1, e2) ->
      let v = eval_expr env e1 in
      let i = eval_expr env e2 |> value_to_int in
      ListV (Array.make i v)
  | AccessE (e, p) -> begin match p with
      | IndexP e' ->
        let a = eval_expr env e |> value_to_array in
        let i = eval_expr env e' |> value_to_int in
        Array.get a i
      | SliceP (e1, e2) ->
        let a = eval_expr env e |> value_to_array in
        let i1 = eval_expr env e1 |> value_to_int in
        let i2 = eval_expr env e2 |> value_to_int in
        ListV (Array.sub a i1 i2)
      | DotP str -> begin match eval_expr env e with
        | FrameV (_, r) -> Record.find str r
        | StoreV s -> Record.find str !s
        | RecordV r -> Record.find str r
        | v ->
            string_of_value v
            |> Printf.sprintf "Not a record: %s"
            |> failwith
        end
      end
  | LabelE (e1, e2) ->
      let n = eval_expr env e1 |> value_to_num in
      let l = eval_expr env e2 |> value_to_list in
      LabelV (n, l)
  | NameE name | IterE (name, _) -> Env.find name env
  | RecordE r -> RecordV (Record.map (eval_expr env) r)
  | ContE e -> (
      let v = eval_expr env e in
      match v with
      | LabelV (_, vs) -> ListV (Array.of_list vs)
      | _ -> failwith "Not a label")
  | PairE (e1, e2) -> PairV (eval_expr env e1, eval_expr env e2)
  | ConstructE (tag, el) -> ConstructV (tag, List.map (eval_expr env) el)
  | OptE opt -> OptV (Option.map (eval_expr env) opt)
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
  if !cnt > 1000000 then raise Timeout else cnt := !cnt + 1;
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
          | ListV vs -> Array.iter push vs
          | v -> push v);
          (env, cont)
      | PopI e ->
          let env = (
            match e with
            | IterE (name, ListN n) ->
                let i = Env.find n env |> value_to_int in
                let vs = List.rev (List.init i (fun _ -> pop ())) in
                Env.add name (ListV (Array.of_list vs)) env
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
          (env, cont)
      | PopAllI e -> (
        match e with
        | IterE (name, List) ->
          let rec pop_value vs = (match !stack with
          | h :: _  -> (match h with
            | ConstructV ("CONST", _) -> pop_value (pop () :: vs)
            | _ -> vs)
          | _ -> vs)
          in
          let vs = pop_value [] in
          let env = Env.add name (ListV (Array.of_list vs)) env in
          (env, cont)
        | _ -> failwith "Invalid pop")
      | LetI (pattern, e) ->
          let rec assign lhs rhs env =
            match lhs, rhs with
            | IterE (name, ListN n), ListV vs ->
                env |> Env.add name rhs |> Env.add n (NumV (Int64.of_int (Array.length vs)))
            | NameE name, v
            | IterE (name, _), v ->
                Env.add name v env
            | PairE (lhs1, lhs2), PairV (rhs1, rhs2)
            | ArrowE (lhs1, lhs2), ArrowV (rhs1, rhs2) ->
                env |> assign lhs1 rhs1 |> assign lhs2 rhs2
            | ListE lhs_s, ListV rhs_s
              when Array.length lhs_s = Array.length rhs_s ->
                List.fold_right2 assign (Array.to_list lhs_s) (Array.to_list rhs_s) env
            | ConstructE (lhs_tag, lhs_s), ConstructV (rhs_tag, rhs_s)
              when lhs_tag = rhs_tag && List.length lhs_s = List.length rhs_s ->
                List.fold_right2 assign lhs_s rhs_s env
            | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs env
            (* TODO: Remove this. This should be handled by animation *)
            | BinopE (Mul, BinopE (Mul, NameE name, e1), e2), NumV m ->
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
      | TrapI -> raise Trap
      | NopI | ReturnI None -> (env, cont)
      | ReturnI (Some e) ->
          let result = eval_expr env e in
          let env = Env.set_result result env in
          (env, cont)
      | ReplaceI (e1, IndexP e2, e3) ->
          let a = eval_expr env e1 |> value_to_array in
          let i = eval_expr env e2 |> value_to_int in
          let v = eval_expr env e3 in
          Array.set a i v;
          (env, cont)
      | ReplaceI (e1, SliceP (e2, e3), e4) -> (
          let v1 = eval_expr env e1 in
          let v2 = eval_expr env e2 in
          let v3 = eval_expr env e3 in
          let v4 = eval_expr env e4 in
          match v1, v2, v3, v4 with
          | ListV l1, NumV st, NumV len, ListV l2 ->
              for i = 0 to Int64.to_int len - 1 do
                i |> Array.get l2 |> Array.set l1 (Int64.to_int st + i);
              done;
              (env, cont)
          | _ -> failwith "Invalid Replace instr")
      | PerformI e ->
          eval_expr env e |> ignore;
          (env, cont)
      | ExecuteI e ->
          eval_expr env e |> execute_wasm_instr;
          (env, cont)
      | ExecuteSeqI e ->
          (match eval_expr env e with
          | ListV winstrs -> Array.to_list winstrs |> execute_wasm_instrs
          | _ -> failwith "Invalid ExecuteSeqI");
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
      | AppendI (e1, e2, s) ->
          let v1 = eval_expr env e1 in
          (match eval_expr env e2 with
          | StoreV ref when Record.mem s !ref |> not ->
              ref := Record.add s (ListV [| v1 |]) !ref
          | StoreV ref ->
              let a = match Record.find s !ref with
                | ListV l -> l
                | _ -> failwith "Unreachable" in
              let appended_result = ListV (Array.append a [| v1 |]) in
              ref := Record.add s appended_result !ref
          | v -> string_of_value v |> Printf.sprintf "Append %s" |> failwith);
          (env, cont)
      | i -> structured_string_of_instr 0 i |> failwith)
    in
    interp_instrs env cont

and interp_algo algo args =
  let (Algo (_, params, il)) = algo in
  assert (List.length params = List.length args);

  let f acc param arg =
    let pattern, _ = param in
    match (pattern, arg) with
    | NameE n, arg -> Env.add n arg acc
    | IterE (n, _), arg -> Env.add n arg acc
    | _ -> failwith "Invalid destructuring assignment"
  in

  let init_env = List.fold_left2 f Env.empty params args in

  interp_instrs init_env il



(* Search AL Algorithm *)

and call_algo name args =
  let algo =
    match AlgoMap.find_opt name !algo_map with
      | Some v -> v
      | None -> failwith ("Algorithm " ^ name ^ " not found")
  in
  interp_algo algo args |> Env.get_result

and execute_wasm_instr winstr =
  (* Print.string_of_value winstr |> print_endline; *)
  match winstr with
  | ConstructV ("CONST", _) | ConstructV ("REF.NULL", _) -> push winstr
  | ConstructV (name, args) -> call_algo (String.lowercase_ascii name) args |> ignore
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
