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

(* Environmet *)

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
  | MapE (fname, el, _) ->
      (* TODO: handle cases where iteratng argument is not the last *)
      let args = el |> List.map (eval_expr env) in
      let front_args, last_arg = Lib.List.split_last args in
      let xs = value_to_list last_arg in
      listV (List.map (fun x -> dsl_function_call fname (front_args @ [ x ])) xs)
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
  | ExtendE (e1, ps, e2) -> 
      let v_new = eval_expr env e2 in
      let rec extend base ps = (
        match ps with
        | path :: rest ->
            let v_new = extend (access_path env base path) rest in
            replace_path env base path v_new
        | [] -> 
            let a = base |> value_to_array in
            let a_new = Array.copy a in
            ListV (ref (Array.append a_new [|v_new|])))
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
  | IterE (e, _) -> eval_expr env e
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
  | IsTopC "value" -> (
      match !stack with
      | [] -> false
      | h :: _ -> ( match h with ConstructV _ -> true | _ -> false))
  | IsTopC "frame" -> (
      match !stack with
      | [] -> false
      | h :: _ -> ( match h with FrameV _ -> true | _ -> false))
  (* TODO : This sohuld be replaced with executing the validation algorithm *)
  | ValidC e -> (
      let valid_lim lim k = match lim with
      | PairV (NumV n, OptV (Some (NumV m))) -> n <= m && m <= k
      | PairV (NumV n, OptV None) -> n <= k
      | _ -> failwith ("invalid limit: " ^ structured_string_of_value lim) in
      match eval_expr env e with
      (* valid_tabletype *)
      | PairV (lim, _rt) -> valid_lim lim 0xffffffffL
      (* valid_memtype *)
      | ConstructV ("I8", [ lim ]) -> valid_lim lim 0x10000L
      (* valid_other *)
      | _ -> failwith "TODO: Currently, we are already validating tabletype and memtype"
      )
  | c -> structured_string_of_cond c |> failwith

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

and interp_instrs env il =
  if !cnt > 200000 then raise Exception.Timeout else cnt := !cnt + 1;
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
            | IterE (NameE name, ListN n) ->
                let i = Env.find n env |> value_to_int in
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
                | NameE name, v
                | IterE (NameE name, _), v -> Env.add name v env
                | _ -> failwith (Printf.sprintf "Invalid pop: %s := %s" (structured_string_of_expr e) (structured_string_of_value h))))
          in
          (env, cont)
      | PopAllI e -> (
        match e with
        | IterE (NameE name, List) ->
          let is_boundary = function FrameV _ | LabelV _ -> true | _ -> false in
          let rec pop_value acc = match !stack with
          | h :: _  when not (is_boundary h) -> pop_value (pop () :: acc)
          | _ -> acc in
          let vs = pop_value [] in
          let env = Env.add name (listV vs) env in
          (env, cont)
        | _ -> failwith ("Invalid pop: Popall " ^ string_of_expr e))
      | LetI (pattern, e) ->
          let rec assign lhs rhs env =
            match lhs, rhs with
            | IterE (NameE name, ListN n), ListV vs ->
                env |> Env.add name rhs |> Env.add n (NumV (Int64.of_int (Array.length !vs)))
            | NameE name, v
            | IterE (NameE name, _), v ->
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
            (* TODO: Should this be handled by interpreter? animation? translation? *)
            | ConcatE (e, IterE (NameE n1, ListN n2)), ListV vs ->
              let len = Array.length !vs in
              let suffix_len = eval_expr env (NameE n2) |> value_to_int in
              assert (len >= suffix_len);
              let prefix = Array.sub !vs 0 (len - suffix_len) in
              let suffix = Array.sub !vs (len - suffix_len) suffix_len in
              env |> assign e (ListV (ref prefix)) |> Env.add n1 (ListV (ref suffix))
            | RecordE r1, RecordV r2 when Record.keys r1 = Record.keys r2 ->
                Record.fold (fun k v acc -> (Record.find k r2 |> assign v) acc) r1 env
            | e, v ->
                Printf.sprintf "Invalid assignment: %s := %s"
                  (string_of_expr e) (string_of_value v)
                |> failwith
          in
          let env = assign pattern (eval_expr env e) env in
          (env, cont)
      | CallI (lhs, f, args) -> interp_instrs env [LetI (lhs, AppE (f, args))], cont
      | MapI (lhs, f, args, iters) -> interp_instrs env [LetI (lhs, MapE (f, args, iters))], cont
      | TrapI -> raise Exception.Trap
      | NopI | ReturnI None -> (env, cont)
      | ReturnI (Some e) ->
          let result = eval_expr env e in
          let env = Env.set_result result env in
          (env, cont)
      | PerformI (f, args) ->
          eval_expr env (AppE (f, args)) |> ignore;
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
          begin match get_current_context () with
            | FrameV _ -> call_algo "execution_of_frame" []
            | LabelV _ -> call_algo "execution_of_label" []
            | _ -> failwith "Unreachable"
          end
          |> ignore;
          (env, cont)
      | ExitAbruptI _ ->
          let vs = pop_context () in
          let ctx = List.hd vs in
          List.tl vs |> List.iter push;
          begin match ctx with
          | LabelV _ -> raise (ExitContext (env, cont))
          | _ -> ()
          end;
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
      | ReplaceI (e1, DotP s, e2) ->
          begin match eval_expr env e1 with
          | RecordV r ->
              let v = eval_expr env e2 in
              Record.replace s v r
          | _ -> failwith "Not a Record"
          end;
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
    | NameE n, arg
    | IterE (NameE n, _), arg -> Env.add n arg acc
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

and is_builtin = function
  | "PRINT" | "PRINT_I32" | "PRINT_I64" | "PRINT_F32" | "PRINT_F64" | "PRINT_I32_F32" | "PRINT_F64_F64" -> true
  | _ -> false

and call_builtin name =
  let local x = call_algo "local" [ NumV (Int64.of_int x) ] in
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

and execute_wasm_instr winstr =
  (* Print.string_of_value winstr |> prerr_endline; *)
  (* string_of_stack !stack |> prerr_endline; *)
  (* string_of_record !store |> prerr_endline; *)
  match winstr with
  | ConstructV ("CONST", _) | ConstructV ("REF.NULL", _) -> push winstr
  | ConstructV (name, []) when is_builtin name -> call_builtin name
  | ConstructV (name, args) -> call_algo ("execution_of_" ^ String.lowercase_ascii name) args |> ignore
  | _ -> failwith (string_of_value winstr ^ " is not a wasm instruction")

and execute_wasm_instrs winstrs = List.iter execute_wasm_instr winstrs


(* Entry *)
let init algos = algo_map := to_map algos;
