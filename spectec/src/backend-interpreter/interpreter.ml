open Reference_interpreter
open Al
open Ast
open Print
open Construct
open Ds
open Util.Source
open Util.Record

let check_i32_const = function
  | CaseV ("CONST", [ CaseV ("I32", []); NumV (n) ]) ->
    let n' = Int64.logand 0xFFFFFFFFL n in
    CaseV ("CONST", [ CaseV ("I32", []); NumV (n') ])
  | v -> v
let rec is_true = function
  | BoolV true -> true
  | ListV a -> Array.for_all is_true !a
  | _ -> false

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

(* helper functions for recursive type *)

(* null *)
let null = caseV ("NULL", [ optV (Some (listV [])) ])
let nonull = caseV ("NULL", [ optV None ])
(* abstract heap types for null *)
let none = singleton "NONE"
let nofunc = singleton "NOFUNC"
let noextern = singleton "NOEXTERN"


let match_ref_type v1 v2 =
  let rt1 = Construct.al_to_ref_type v1 in
  let rt2 = Construct.al_to_ref_type v2 in
  Match.match_ref_type [] rt1 rt2

let match_heap_type v1 v2 =
  let rt1 = Construct.al_to_heap_type v1 in
  let rt2 = Construct.al_to_heap_type v2 in
  Match.match_heap_type [] rt1 rt2

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
  let option_name_to_list name = name |> name_to_value |> unwrap_optv |> Option.to_list in
  let name_to_list name = name |> name_to_value |> unwrap_listv_to_list in
  let length_to_list l = List.init l al_of_int in

  let name_to_values name =
    match iter with
    | Opt -> option_name_to_list name
    | ListN (e_n, Some n') when name = n' ->
      eval_expr e_n
      |> al_to_int
      |> length_to_list
    | _ -> name_to_list name
  in

  names
  |> List.map name_to_values
  |> transpose
  |> List.map (fun vs -> List.fold_right2 Env.add names vs env)

and access_path base path =
  match path.it with
  | IdxP e' ->
      let a = base |> unwrap_listv_to_array in
      let i = eval_expr e' |> al_to_int in
      begin try Array.get a i with
      | Invalid_argument _ ->
        Printf.sprintf "Failed Array.get during ReplaceE: %s[%s]"
          (string_of_value base)
          (string_of_int i)
        |> failwith
      end
  | SliceP (e1, e2) ->
      let a = base |> unwrap_listv_to_array in
      let i1 = eval_expr e1 |> al_to_int in
      let i2 = eval_expr e2 |> al_to_int in
      let a' = Array.sub a i1 i2 in
      ListV (ref a')
  | DotP (str, _) -> (
      match base with
      | FrameV (_, StrV r) -> Record.find str r
      | StoreV s -> Record.find str !s
      | StrV r -> Record.find str r
      | v ->
          string_of_value v
          |> Printf.sprintf "Not a record: %s"
          |> failwith)

and replace_path base path v_new =
  match path.it with
  | IdxP e' ->
      let a = base |> unwrap_listv_to_array in
      let a_new = Array.copy a in
      let i = eval_expr e' |> al_to_int in
      Array.set a_new i v_new;
      ListV (ref a_new)
  | SliceP (e1, e2) ->
      let a = base |> unwrap_listv_to_array in
      let a_new = Array.copy a in
      let i1 = eval_expr e1 |> al_to_int in
      let i2 = eval_expr e2 |> al_to_int in
      Array.blit (v_new |> unwrap_listv_to_array) 0 a_new i1 i2;
      ListV (ref a_new)
  | DotP (str, _) ->
    let r =
      match base with
      | FrameV (_, StrV r) -> r
      | StoreV s -> !s
      | StrV r -> r
      | v ->
        string_of_value v
        |> Printf.sprintf "Not a record: %s"
        |> failwith in
    let r_new = Record.clone r in
    Record.replace str v_new r_new;
    strV r_new

and eval_expr expr =
  match expr.it with
  (* Value *)
  | NumE i -> numV i
  (* Numeric Operation *)
  | UnE (MinusOp, inner_e) -> eval_expr inner_e |> al_to_int64 |> Int64.neg |> numV
  | UnE (NotOp, e) -> eval_expr e |> al_to_bool |> not |> boolV
  | BinE (op, e1, e2) ->
    (match op, eval_expr e1, eval_expr e2 with
    | AddOp, NumV i1, NumV i2 -> Int64.add i1 i2 |> numV
    | SubOp, NumV i1, NumV i2 -> Int64.sub i1 i2 |> numV
    | MulOp, NumV i1, NumV i2 -> Int64.mul i1 i2 |> numV
    | DivOp, NumV i1, NumV i2 -> Int64.div i1 i2 |> numV
    | ExpOp, NumV i1, NumV i2 -> int64_exp i1 i2 |> numV
    | AndOp, BoolV b1, BoolV b2 -> boolV (b1 && b2)
    | OrOp, BoolV b1, BoolV b2 -> boolV (b1 || b2)
    | ImplOp, BoolV b1, BoolV b2 -> boolV (not b1 || b2)
    | EquivOp, BoolV b1, BoolV b2 -> boolV (b1 = b2)
    | EqOp, v1, v2 -> boolV (v1 = v2)
    | NeOp, v1, v2 -> boolV (v1 <> v2)
    | LtOp, v1, v2 -> boolV (v1 < v2)
    | GtOp, v1, v2 -> boolV (v1 > v2)
    | LeOp, v1, v2 -> boolV (v1 <= v2)
    | GeOp, v1, v2 -> boolV (v1 >= v2)
    | _ -> failwith "Invalid BinE")
  (* Function Call *)
  | CallE (fname, el) ->
    let args = List.map eval_expr el in
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
  | ListE el -> List.map eval_expr el |> listV
  | CatE (e1, e2) ->
    let a1 = eval_expr e1 |> unwrap_listv_to_array in
    let a2 = eval_expr e2 |> unwrap_listv_to_array in
    ListV (Array.append a1 a2 |> ref)
  | LenE e ->
    let a = eval_expr e |> unwrap_listv_to_array in
    Array.length a |> I64.of_int_u |> numV
  | StrE r ->
    Record.to_list r
    |> List.map (fun (k, e) -> string_of_kwd k, !e |> eval_expr |> ref)
    |> Record.of_list
    |> strV
  | AccE (e, p) ->
    let base = eval_expr e in
    access_path base p
  | ExtE (e1, ps, e2, dir) ->
    let rec extend ps base =
      match ps with
      | path :: rest -> access_path base path |> extend rest |> replace_path base path
      | [] ->
        let v = eval_expr e2 |> unwrap_listv_to_array in
        let a_copy = base |> unwrap_listv_to_array |> Array.copy in
        let a_new =
          match dir with
          | Front -> Array.append v a_copy
          | Back -> Array.append a_copy v
        in
        ListV (ref a_new)
    in
    eval_expr e1 |> extend ps
  | UpdE (e1, ps, e2) ->
    let rec replace ps base =
      match ps with
      | path :: rest -> access_path base path |> replace rest |> replace_path base path
      | [] -> eval_expr e2 in
    eval_expr e1 |> replace ps
  | CaseE ((tag, _), el) -> caseV (tag, List.map eval_expr el) |> check_i32_const
  | OptE opt -> Option.map eval_expr opt |> optV
  | TupE el -> List.map eval_expr el |> tupV
  (* Context *)
  | ArityE e ->
    (match eval_expr e with
    | LabelV (v, _) -> v
    | FrameV (Some v, _) -> v
    | FrameV _ -> numV 0L
    | _ -> failwith "Not a context" (* Due to AL validation, unreachable *))
  | FrameE (e1, e2) ->
    let v1 = Option.map eval_expr e1 in
    let v2 = eval_expr e2 in
    (match v1, v2 with
    | (Some (NumV _)|None), StrV _ -> FrameV (v1, v2)
    (* Due to AL validation unreachable *)
    | _ -> "Invalid frame: " ^ string_of_expr expr |> failwith)
  | GetCurFrameE -> WasmContext.get_current_frame ()
  | LabelE (e1, e2) ->
    let v1 = eval_expr e1 in
    let v2 = eval_expr e2 in
    LabelV (v1, v2)
  | GetCurLabelE -> WasmContext.get_current_label ()
  | GetCurContextE -> WasmContext.get_current_context ()
  | ContE e ->
    (match eval_expr e with
    | LabelV (_, vs) -> vs
    | _ -> failwith "Not a label")
  | VarE name -> AlContext.get_env () |> Env.find name
  (* Optimized getter for simple IterE(VarE, ...) *)
  | IterE ({ it = VarE name; _ }, [name'], _) when name = name' ->
    AlContext.get_env () |> Env.find name
  (* Optimized getter for list init *)
  | IterE (e1, [], ListN (e2, None)) ->
    let v = eval_expr e1 in
    let i = eval_expr e2 |> al_to_int in
    if i > 1024 * 64 * 1024 (* 1024 pages *) then
      (AlContext.pop_context () |> ignore; raise Exception.OutOfMemory)
    else
      List.init i (fun _ -> v) |> listV
  | IterE (inner_e, ids, iter) ->
    let env = AlContext.get_env () in
    let vs =
      create_sub_al_context ids iter env
      |> List.map (fun env' -> AlContext.set_env env'; eval_expr inner_e) in
    AlContext.set_env env;

    (match vs, iter with
    | [], Opt -> optV None
    | [v], Opt -> Option.some v |> optV
    | l, _ -> listV l)
  | ArrowE (e1, e2) -> ArrowV (eval_expr e1, eval_expr e2)
  (* condition *)
  | ContextKindE ((kind, _), e) ->
    (match kind, eval_expr e with
    | "frame", FrameV _ -> boolV true
    | "label", LabelV _ -> boolV true
    | _ -> boolV false)
  | IsDefinedE e ->
    (match eval_expr e with
    | OptV (Some _) -> boolV true
    | OptV _ -> boolV false
    | _ -> structured_string_of_expr e |> failwith)
  | IsCaseOfE (e, (expected_tag, _)) ->
    (match eval_expr e with
    | CaseV (tag, _) -> boolV (expected_tag = tag)
    | _ -> boolV false)
  (* TODO : This sohuld be replaced with executing the validation algorithm *)
  | IsValidE e ->
    let valid_lim k = function
      | TupV [ NumV n; NumV m ] -> n <= m && m <= k
      | _ -> false in
    (match eval_expr e with
    (* valid_tabletype *)
    | TupV [ lim; _ ] -> valid_lim 0xffffffffL lim |> boolV
    (* valid_memtype *)
    | CaseV ("I8", [ lim ]) -> valid_lim 0x10000L lim |> boolV
    (* valid_other *)
    | _ -> failwith "TODO: Currently, we are already validating tabletype and memtype")
  | HasTypeE (e, s) ->

    (* type definition *)

    let addr_refs = [
      "REF.I31_NUM"; "REF.STRUCT_ADDR"; "REF.ARRAY_ADDR";
      "REF.FUNC_ADDR"; "REF.HOST_ADDR"; "REF.EXTERN";
    ] in
    let packed_types = [ "I8"; "I16" ] in
    let num_types = [ "I32"; "I64"; "F32"; "F64" ] in
    let vec_types = [ "V128"; ] in
    let abs_heap_types = [
      "ANY"; "EQ"; "I31"; "STRUCT"; "ARRAY"; "NONE"; "FUNC";
      "NOFUNC"; "EXTERN"; "NOEXTERN"
    ] in

    (* check type *)

    (match eval_expr e with
    (* addrref *)
    | CaseV (ar, _) when List.mem ar addr_refs->
      boolV (s = "addrref" || s = "ref" || s = "val")
    (* nul *)
    | CaseV ("REF.NULL", _) ->
      boolV (s = "nul" || s = "ref" || s = "val")
    (* numtype *)
    | CaseV (nt, []) when List.mem nt num_types ->
      boolV (s = "numtype" || s = "valtype")
    | CaseV (vt, []) when List.mem vt vec_types ->
      boolV (s = "vectype" || s = "valtype")
    (* valtype *)
    | CaseV ("REF", _) ->
      boolV (s = "reftype" || s = "valtype")
    (* absheaptype *)
    | CaseV (aht, []) when List.mem aht abs_heap_types ->
      boolV (s = "absheaptype" || s = "heaptype")
    (* deftype *)
    | CaseV ("DEF", [ _; _ ]) ->
      boolV (s = "deftype" || s = "heaptype")
    (* typevar *)
    | CaseV ("_IDX", [ _ ]) ->
      boolV (s = "heaptype" || s = "typevar")
    (* heaptype *)
    | CaseV ("REC", [ _ ]) ->
      boolV (s = "heaptype" || s = "typevar")
    (* packedtype *)
    | CaseV (pt, []) when List.mem pt packed_types ->
      boolV (s = "packedtype" || s = "storagetype")
    | v ->
      string_of_value v
      |> Printf.sprintf "Invalid %s: %s" s
      |> failwith)
  | MatchE (e1, e2) ->
    let v1 = eval_expr e1 in
    let v2 = eval_expr e2 in
    match_ref_type v1 v2 |> boolV
  | _ -> structured_string_of_expr expr |> failwith

(* Assignment *)

and has_same_keys r1 r2 =
  let k1 = Record.keys r1 |> List.map string_of_kwd |> List.sort String.compare in
  let k2 = Record.keys r2 |> List.sort String.compare in
  k1 = k2

and merge_envs_with_grouping default_env envs =
  let merge env acc =
    let f _ v1 = function
      | ListV arr ->
          v1 :: Array.to_list !arr |> listV |> Option.some
      | OptV None -> Option.some v1 |> optV |> Option.some
      | _ -> failwith "Unreachable merge"
    in
    Env.union f env acc
  in
  List.fold_right merge envs default_env

and assign lhs rhs env =
  match lhs.it, rhs with
  | VarE name, v -> Env.add name v env
  | IterE ({ it = VarE n; _ }, _, List), ListV _ -> (* Optimized assign for simple IterE(VarE, ...) *)
      Env.add n rhs env
  | IterE (e, _, iter), _ ->
      let new_env, default_rhs, rhs_list =
        match iter, rhs with
        | (List | List1), ListV arr -> env, listV [], Array.to_list !arr
        | ListN (expr, None), ListV arr ->
            let length = Array.length !arr |> Int64.of_int |> numV in
            assign expr length env, listV [], Array.to_list !arr
        | Opt, OptV opt -> env, optV None, Option.to_list opt
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
  | ArrowE (lhs1, lhs2), ArrowV (rhs1, rhs2) ->
      env |> assign lhs1 rhs1 |> assign lhs2 rhs2
  | TupE lhs_s, TupV rhs_s
    when List.length lhs_s = List.length rhs_s ->
      List.fold_right2 assign lhs_s rhs_s env
  | ListE lhs_s, ListV rhs_s
    when List.length lhs_s = Array.length !rhs_s ->
      List.fold_right2 assign lhs_s (Array.to_list !rhs_s) env
  | CaseE ((lhs_tag, _), lhs_s), CaseV (rhs_tag, rhs_s)
    when lhs_tag = rhs_tag && List.length lhs_s = List.length rhs_s ->
      List.fold_right2 assign lhs_s rhs_s env
  | OptE (Some lhs), OptV (Some rhs) -> assign lhs rhs env
  (* Assumption: e1 is the assign target *)
  | BinE (binop, e1, e2), NumV m ->
    let invop =
      match binop with
      | AddOp -> Int64.sub
      | SubOp -> Int64.add
      | MulOp -> Int64.unsigned_div
      | DivOp -> Int64.mul
      | _ -> failwith "Invvalid binop for lhs of assignment" in
    let v = eval_expr e2 |> al_to_int64 |> invop m |> numV in
    assign e1 v env
  | CatE (e1, e2), ListV vs -> assign_split e1 e2 !vs env
  | StrE r1, StrV r2 when has_same_keys r1 r2 ->
      Record.fold (fun k v acc -> (Record.find (string_of_kwd k) r2 |> assign v) acc) r1 env
  | _, v ->
      Printf.sprintf "Invalid assignment: %s := %s"
        (string_of_expr lhs) (string_of_value v)
      |> failwith

and assign_split ep es vs env =
  let len = Array.length vs in
  let prefix_len, suffix_len =
    let get_length e = match e.it with
    | ListE es -> List.length es |> Option.some
    | IterE (_, _, ListN (e, None)) -> eval_expr e |> al_to_int |> Option.some
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


(* Instruction *)

and dsl_function_call (fname: string) (args: value list): AlContext.return_value =
  (* Numerics *)
  if Numerics.mem fname then
    AlContext.Some (Numerics.call_numerics fname args)
  (* Module & Runtime *)
  else if FuncMap.mem fname !func_map then
    call_algo fname args
  (* HARDCODE: hardcoded validation rule *)
  else if fname = "ref_type_of" then (
    assert (List.length args = 1);

    let rt =
      match List.hd args with
      (* null *)
      | CaseV ("REF.NULL", [ ht ]) ->
        if match_heap_type none ht then
          CaseV ("REF", [ null; none])
        else if match_heap_type nofunc ht then
          CaseV ("REF", [ null; nofunc])
        else if match_heap_type noextern ht then
          CaseV ("REF", [ null; noextern])
        else
          List.hd args
          |> string_of_value
          |> Printf.sprintf "Invalid null reference: %s"
          |> failwith
      (* i31 *)
      | CaseV ("REF.I31_NUM", [ _ ]) ->
        CaseV ("REF", [ nonull; singleton "I31"])
      (* struct *)
      | CaseV ("REF.STRUCT_ADDR", [ NumV i ]) ->
        let e =
          accE (
            accE (
              accE (
                varE "s",
                dotP ("STRUCT", "struct")
              ),
              idxP (numE i)
            ),
            dotP ("TYPE", "type")
          )
        in
        (* TODO: remove hack *)
        let dt = eval_expr e in
        CaseV ("REF", [ nonull; dt])
      (* array *)
      | CaseV ("REF.ARRAY_ADDR", [ NumV i ]) ->
        let e =
          accE (
            accE (
              accE (
                varE "s",
                dotP ("ARRAY", "array")
              ),
              idxP (numE i)
            ),
            dotP ("TYPE", "type")
          )
        in
        (* TODO: remove hack *)
        let dt = eval_expr e in
        CaseV ("REF", [ nonull; dt])
      (* func *)
      | CaseV ("REF.FUNC_ADDR", [ NumV i ]) ->
        let e =
          accE (
            accE (
              accE (
                varE "s",
                dotP ("FUNC", "func")
              ),
              idxP (numE i)
            ),
            dotP ("TYPE", "type")
          )
        in
        (* TODO: remove hack *)
        let dt = eval_expr e in
        CaseV ("REF", [ nonull; dt])
      (* host *)
      | CaseV ("REF.HOST_ADDR", [ _ ]) ->
        CaseV ("REF", [ nonull; singleton "ANY"])
      (* extern *)
      (* TODO: check null *)
      | CaseV ("REF.EXTERN", [ _ ]) ->
        CaseV ("REF", [ nonull; singleton "EXTERN"])
      | _ -> failwith "Invalid arguments for $ref_type_of"
    in

    AlContext.Some rt
  ) else
    Printf.sprintf "Invalid DSL function call: %s" fname |> failwith

and is_builtin = function
  | "PRINT" | "PRINT_I32" | "PRINT_I64" | "PRINT_F32" | "PRINT_F64" | "PRINT_I32_F32" | "PRINT_F64_F64" -> true
  | _ -> false

and call_builtin name =
  let local x =
    match call_algo "local" [ numV (Int64.of_int x) ] with
    | Some v -> v
    | _ -> failwith "builtin doesn't return value"
  in
  let as_const ty = function
  | CaseV ("CONST", [ CaseV (ty', []) ; n ])
  | OptV (Some (CaseV ("CONST", [ CaseV (ty', []) ; n ]))) when ty = ty' -> n
  | v -> failwith ("Not " ^ ty ^ ".CONST: " ^ string_of_value v) in
  match name with
  | "PRINT" -> print_endline "- print: ()"
  | "PRINT_I32" ->
    local 0
    |> as_const "I32"
    |> al_to_int32
    |> I32.to_string_s
    |> Printf.sprintf "- print_i32: %s"
    |> print_endline
  | "PRINT_I64" ->
    local 0
    |> as_const "I64"
    |> al_to_int64
    |> I64.to_string_s
    |> Printf.sprintf "- print_i64: %s"
    |> print_endline
  | "PRINT_F32" ->
    local 0
    |> as_const "F32"
    |> al_to_float32
    |> F32.to_string
    |> Printf.sprintf "- print_f32: %s"
    |> print_endline
  | "PRINT_F64" ->
    local 0
    |> as_const "F64"
    |> al_to_float64
    |> F64.to_string
    |> Printf.sprintf "- print_f64: %s"
    |> print_endline
  | "PRINT_I32_F32" ->
    let i32 = local 0 |> as_const "I32" |> al_to_int32 |> I32.to_string_s in
    let f32 = local 1 |> as_const "F32" |> al_to_float32 |> F32.to_string in
    Printf.sprintf "- print_i32_f32: %s %s" i32 f32 |> print_endline
  | "PRINT_F64_F64" ->
    let f64 = local 0 |> as_const "F64" |> al_to_float64 |> F64.to_string in
    let f64' = local 1 |> as_const "F64" |> al_to_float64 |> F64.to_string in
    Printf.sprintf "- print_f64_f64: %s %s" f64 f64' |> print_endline
  | name ->
    ("Invalid builtin function: " ^ name) |> failwith

and execute (wasm_instr: value): unit =
  match wasm_instr with
  | CaseV ("REF.NULL", [ ht ]) -> ( match !version with
    | 3 ->
      (* substitute heap type*)
      let dummy_rt = CaseV ("REF", [ null; ht ]) in
      (* TODO: remove hack *)
      let mm = callE ("moduleinst", []) |> eval_expr in
      begin match call_algo "inst_reftype" [ mm; dummy_rt ] with
      | AlContext.Some (CaseV ("REF", [ n; ht' ])) when n = null ->
        CaseV ("REF.NULL", [ ht' ]) |> WasmContext.push_value
      | _ -> raise Exception.MissingReturnValue
      end
    | _ -> WasmContext.push_value wasm_instr )
  | CaseV ("CONST", _)
  | CaseV ("VVCONST", _) ->
    WasmContext.push_value wasm_instr
  | CaseV (name, []) when is_builtin name ->
    call_builtin name;
  | CaseV (fname, args) ->
    call_algo fname args |> ignore
  | v ->
    string_of_value v
    |> Printf.sprintf "Executing invalid value: %s"
    |> failwith

and interp_instr (instr: instr): unit =
  (*
  AL_Context.get_name () |> print_endline;
  string_of_instr instr |> Printf.sprintf "[INSTR]: %s" |> prerr_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AlContext.string_of_context_stack () |> print_endline;
  print_endline "";
  *)


  (InfoMap.find instr.note !info_map).covered <- true;

  match instr.it with
  (* Block instruction *)
  | IfI (e, il1, il2) ->
    if eval_expr e |> is_true then
      interp_instrs il1
    else
      interp_instrs il2
  | EitherI (il1, il2) ->
    begin try interp_instrs il1 with
    | Exception.MissingReturnValue
    | Exception.OutOfMemory -> interp_instrs il2
    end
  | AssertI _ -> () (*assert (eval_cond env c);*)
  | PushI e ->
    (match eval_expr e with
    | ListV vs -> Array.iter WasmContext.push_value !vs
    | v -> WasmContext.push_value v)
  | PopI ({ it = IterE ({ it = VarE name; _ }, [name'], ListN (e', None)); _ }) when name = name' ->
    let i = eval_expr e' |> al_to_int in
    List.init i (fun _ -> WasmContext.pop_value ())
    |> List.rev
    |> listV
    |> AlContext.update_env name
  | PopI e ->
    begin match e.it, WasmContext.pop_value () with
    | CaseE (("CONST", _), [{ it = VarE nt; _ }; { it = VarE name; _ }]), CaseV ("CONST", [ ty; v ]) ->
      AlContext.update_env nt ty;
      AlContext.update_env name v
    | CaseE (("CONST", _), [tyE; { it = VarE name; _ }]), CaseV ("CONST", [ ty; v ]) ->
      assert (eval_expr tyE = ty);
      AlContext.update_env name v
    | VarE name, v -> AlContext.update_env name v
    | CaseE (("VVCONST", _), [tyE; { it = VarE name; _ }]), CaseV ("VVCONST", [ ty; v ]) ->
      assert (eval_expr tyE = ty);
      AlContext.update_env name v
    (* TODO remove this *)
    | FrameE _, FrameV _ -> ()
    | (_, h) ->
      Printf.sprintf "Invalid pop: %s := %s"
        (structured_string_of_expr e)
        (structured_string_of_value h)
      |> failwith
    end
  | PopAllI ({ it = IterE ({ it = VarE name; _ }, [name'], List); _ }) when name = name' ->
    let rec pop_all acc =
      if WasmContext.get_value_stack () |> List.length > 0 then
        WasmContext.pop_value () :: acc |> pop_all
      else
        acc
    in
    pop_all [] |> listV |> AlContext.update_env name
  | PopAllI e ->
    string_of_expr e
    |> Printf.sprintf "Invalid pop: Popall %s"
    |> failwith
  | LetI (pattern, e) ->
    AlContext.get_env () |> assign pattern (eval_expr e) |> AlContext.set_env
  | PerformI (f, el) ->
    List.map eval_expr el |> dsl_function_call f |> ignore
  | TrapI -> raise Exception.Trap
  | NopI -> ()
  | ReturnI None ->
    AlContext.set_return ()
  | ReturnI (Some e) ->
    eval_expr e |> AlContext.set_return_value
  | ExecuteI e ->
    eval_expr e |> execute
  | ExecuteSeqI e ->
    eval_expr e |> unwrap_listv_to_list |> List.iter execute
  | EnterI (e1, e2, il) ->
    let v1 = eval_expr e1 in
    let v2 = eval_expr e2 in

    WasmContext.push_context (v1, [], unwrap_listv_to_list v2);
    AlContext.increase_depth ();

    (* TODO: refactor cleanup *)
    let previous_depth = AlContext.get_depth () in
    let rec cleanup () =
      let current_depth = AlContext.get_depth () in
      if current_depth = previous_depth then (
        WasmContext.pop_instr () |> execute;
        cleanup ()
      )
    in

    (* NOTE: doesn't have variable scope *)
    interp_instrs il;
    cleanup ()
  | ExitI ->
    WasmContext.pop_context () |> ignore;
    AlContext.decrease_depth ()
  | ReplaceI (e1, { it = IdxP e2; _ }, e3) ->
    let a = eval_expr e1 |> unwrap_listv_to_array in
    let i = eval_expr e2 |> al_to_int in
    let v = eval_expr e3 in
    Array.set a i v
  | ReplaceI (e1, { it = SliceP (e2, e3); _ }, e4) ->
    let a1 = eval_expr e1 |> unwrap_listv_to_array in (* dest *)
    let i1 = eval_expr e2 |> al_to_int in   (* start index *)
    let i2 = eval_expr e3 |> al_to_int in   (* length *)
    let a2 = eval_expr e4 |> unwrap_listv_to_array in (* src *)
    assert (Array.length a2 = i2);
    Array.iteri (fun i v -> Array.set a1 (i1 + i) v) a2
  | ReplaceI (e1, { it = DotP (s, _); _ }, e2) ->
    (match eval_expr e1 with
    | StrV r ->
      let v = eval_expr e2 in
      Record.replace s v r
    | _ -> failwith "Not a Record")
  | AppendI (e1, e2) ->
    let a = eval_expr e1 |> unwrap_listv in
    let v = eval_expr e2 in
    a := Array.append (!a) [|v|]
  | _ ->
    structured_string_of_instr instr
    |> Printf.sprintf "Interpreter is not implemented for the instruction: %s"
    |> failwith


and interp_instrs: instr list -> unit = function
  | [] -> ()
  (* For tailcall optimization *)
  | [ i ] -> interp_instr i
  | h :: t ->
    interp_instr h;
    if AlContext.get_return_value () = Bot then
      interp_instrs t
    else
      ()



(* Algorithm *)

(* TODO: move to ds.ml *)

and interp_algo (algo: algorithm) (args: value list): unit =
  let params = get_param algo in

  Env.empty
  |> Env.add_store
  |> List.fold_right2 assign params args
  |> AlContext.set_env;

  get_body algo |> interp_instrs

and call_algo (name: string) (args: value list): AlContext.return_value =
  (*
  print_endline "**************************************";
  Printf.sprintf "[ALGO]: %s" name |> print_endline;
  Print.string_of_list Print.string_of_value "[" ", " "]"args |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AlContext.string_of_context_stack () |> print_endline;
  print_endline "";
  *)
  let depth = !AlContext.context_stack_length in
  if depth > 70_000 then
    failwith "Stack overflow";

  (* Push AL context *)
  let al_context = AlContext.create_context name in
  AlContext.push_context al_context;

  (* Interp algorithm *)
  let algo = lookup name in
  if List.length args <> List.length (get_param algo) then
    failwith ("Argument number mismatch for algorithm " ^ name);
  interp_algo algo args;

  (* Pop AL context *)
  let _, _, return_value, depth = AlContext.pop_context () in

  (*
  Printf.sprintf "[END ALGO]: %s" name |> print_endline;
  WasmContext.string_of_context_stack () |> print_endline;
  AlContext.string_of_context_stack () |> print_endline;
  print_endline "";
  *)

  assert (depth = 0);
  return_value

(* Entry *)

let init_context () =
  AlContext.init_context ();
  WasmContext.init_context ()

let instantiate (args: value list): value =
  init_context();
  match call_algo "instantiate" args with
  | AlContext.Some module_inst -> module_inst
  | _ -> failwith "Instantiation doesn't return module instance"
let invoke (args: value list): value =
  init_context();
  match call_algo "invoke" args with
  | AlContext.Some v -> v
  | _ -> failwith "Invocation doesn't return value"
