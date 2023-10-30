open Il
open Printf
open Util.Source
open Al.Ast

(** helper functions **)

let check_nop instrs = match instrs with [] -> [ NopI ] | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp |> sprintf "Invalid expression `%s` to be AL %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem |> sprintf "Invalid premise `%s` to be AL %s."

let list_partition_with pred xs =
  let rec list_partition acc = function
  | [] -> acc
  | hd :: tl ->
    let same_groups, diff_groups = List.partition (fun group -> pred (List.hd group) hd) acc in
    match same_groups with
    | [] -> list_partition ([ hd ] :: acc) tl
    | [ my_group ] -> list_partition ( (hd :: my_group) :: diff_groups) tl
    | _ -> failwith "Impossible list_partiton_with: perhaps pred is not equivalence relation"
  in
  list_partition [] xs |> List.rev

let disjoint xs ys = List.for_all (fun x -> List.for_all ((<>) x) ys) xs

(* transform z; e into e *)
let drop_state e = match e.it with
| Ast.MixE (* z; e *)
    ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
      { it = Ast.TupE [ { it = Ast.VarE { it = "z"; _ }; _ }; e' ]; _ } )
  -> e'
| Ast.MixE (* (s; f); e *)
    ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
      { it = Ast.TupE [ { it = Ast.MixE (
        [[]; [ Ast.Semicolon ]; []],
        { it = Ast.TupE [ { it = Ast.VarE { it = "s"; _}; _}; { it = Ast.VarE { it = "f"; _} ; _}]; _ }
      ); _ }; e' ]; _ } )
  -> e'
| _ -> e

(* Ast.exp -> Ast.exp list *)
let rec flatten e =
  match e.it with
  | Ast.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Ast.ListE es -> List.concat_map flatten es
  | _ -> [ e ]

let flatten_rec def =
  match def.it with Ast.RecD defs -> defs | _ -> [def]

(** Translate keywords **)
let name2keyword name note = (name, Il.Print.string_of_typ note)

(** Translate `Ast.type` **)
let rec il_type2al_type t =
  match t.it with
  | Ast.VarT id -> (
      match id.it with
      | "n" -> IntT
      | "numtype" -> IntT
      | idx when String.ends_with ~suffix:"idx" idx -> IntT
      | numerics when String.ends_with ~suffix:"_numtype" numerics -> StringT
      | "addr" -> AddrT
      | "functype" -> TopT
      | "cvtop" -> StringT
      | "sx" -> TopT
      | "val" -> WasmValueTopT
      | "valtype" -> WasmValueTopT
      | "frame" -> FrameT
      | "store" -> StoreT
      | "state" -> StateT
      | _ ->
          (* TODO *)
          (*sprintf "%s -> %s" debug (Print.string_of_typ t) |> print_endline;*)
          TopT)
  | Ast.NatT -> IntT
  | Ast.TupT [t1; t2] -> PairT (il_type2al_type t1, il_type2al_type t2)
  | Ast.IterT (ty, _) -> ListT (il_type2al_type ty)
  | _ -> failwith ("TODO: translate il_type into al_type of " ^ Print.string_of_typ t)

let get_params winstr =
  match winstr.it with
  | Ast.CaseE (_, { it = Ast.TupE exps; _ }) -> exps
  | Ast.CaseE (_, exp) -> [ exp ]
  | _ ->
      print_endline (Print.string_of_exp winstr ^ "is not a vaild wasm instruction.");
      []

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `name` *)
let rec exp2name exp =
  match exp.it with
  | Ast.VarE id -> id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | _ ->
      gen_fail_msg_of_exp exp "identifier" |> print_endline;
      "Yet"

let rec iter2iter = function
  | Ast.Opt -> Opt
  | Ast.List1 -> List1
  | Ast.List -> List
  | Ast.ListN (e, id_opt) ->
    ListN (exp2expr e, Option.map (fun id -> id.it) id_opt)

(* `Ast.exp` -> `expr` *)
and exp2expr exp =
  match exp.it with
  | Ast.NatE n -> NumE (Int64.of_int n)
  (* List *)
  | Ast.LenE inner_exp -> LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> ListE (List.map exp2expr exps)
  | Ast.IdxE (exp1, exp2) ->
      AccessE (exp2expr exp1, IndexP (exp2expr exp2))
  | Ast.SliceE (exp1, exp2, exp3) ->
      AccessE (exp2expr exp1, SliceP (exp2expr exp2, exp2expr exp3))
  | Ast.CatE (exp1, exp2) -> ConcatE (exp2expr exp1, exp2expr exp2)
  (* Variable *)
  | Ast.VarE id -> NameE id.it
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE (inner_exp, (Ast.ListN (times, None), [])) ->
      ListFillE (exp2expr inner_exp, exp2expr times)
  | Ast.IterE (inner_exp, (iter, ids)) ->
      let names = List.map (fun id -> id.it) ids in
      IterE (exp2expr inner_exp, names, iter2iter iter)
  (* property access *)
  | Ast.DotE (inner_exp, Atom p) -> 
      AccessE (exp2expr inner_exp, DotP (name2keyword p inner_exp.note))
  (* conacatenation of records *)
  | Ast.CompE (inner_exp, { it = Ast.StrE expfields; _ }) ->
      (* assumption: CompE is only used for prepending to validation context *)
      let nonempty = function ListE [] | OptE None -> false | _ -> true in
      List.fold_left
        (fun acc extend_exp -> match extend_exp with
        | Ast.Atom name, fieldexp ->
            let extend_expr = exp2expr fieldexp in
            if nonempty extend_expr then
              ExtendE (acc, [ DotP (name2keyword name inner_exp.note) ], extend_expr, Front)
            else
              acc
        | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith)
        (exp2expr inner_exp) expfields
  (* extension of record field *)
  | Ast.ExtE (base, path, v) -> ExtendE (exp2expr base, path2paths path, exp2expr v, Back)
  (* update of record field *)
  | Ast.UpdE (base, path, v) -> ReplaceE (exp2expr base, path2paths path, exp2expr v)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let op = match op with
      | Ast.AddOp -> Add
      | Ast.SubOp -> Sub
      | Ast.MulOp -> Mul
      | Ast.DivOp -> Div
      | Ast.ExpOp -> Exp
      | _ -> Add (* TODO *)
      in
      BinopE (op, lhs, rhs)
  (* ConstructE *)
  | Ast.CaseE (Ast.Atom cons, arg) -> ConstructE (name2keyword cons exp.note, exp2args arg)
  (* Tuple *)
  | Ast.TupE exps -> ListE (List.map exp2expr exps)
  (* Call *)
  | Ast.CallE (id, inner_exp) -> AppE (id.it, exp2args inner_exp)
  (* Record expression *)
  | Ast.StrE expfields ->
      let f acc = function
        | Ast.Atom name, fieldexp ->
            let expr = exp2expr fieldexp in
            Record.add (name2keyword name exp.note) expr acc
        | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith
      in
      let record = List.fold_left f Record.empty expfields in
      RecordE record
  | Ast.MixE (op, e) -> (
      let exps =
        match e.it with
        | TupE exps -> exps
        | _ -> [ e ]
      in
      match (op, exps) with
      | [ []; []; [] ], [ e1; e2 ]
      | [ []; [ Ast.Semicolon ]; [] ], [ e1; e2 ]
      | [ [ Ast.LBrack ]; [ Ast.Dot2 ]; [ Ast.RBrack ]], [ e1; e2 ] ->
          PairE (exp2expr e1, exp2expr e2)
      | [ []; [ Ast.Arrow ]; [] ], [ e1; e2 ] ->
          ArrowE (exp2expr e1, exp2expr e2)
      (* Constructor *)
      (* TODO: Need a better way to convert these CaseE into ConsturctE *)
      | [ [ Ast.Atom "FUNC" ]; []; [ Ast.Star ]; [] ], _ ->
          ConstructE (("FUNC", "func"), List.map exp2expr exps)
      | [ [ Ast.Atom "OK" ] ], [] ->
          ConstructE (("OK", "datatype"), [])
      | [ [ Ast.Atom "MUT" ]; [ Ast.Quest ]; [] ],
        [ { it = Ast.OptE (Some { it = Ast.TupE []; _ }); _}; t ] ->
          PairE (ConstructE (("MUT", "globaltype"), []), exp2expr t)
      | [ [ Ast.Atom "MUT" ]; [ Ast.Quest ]; [] ],
        [ { it = Ast.IterE ({ it = Ast.TupE []; _ }, (Ast.Opt, [])); _}; t ] ->
          PairE (IterE (NameE "mut", ["mut"], Opt), exp2expr t)
      | [ [ Ast.Atom "MODULE" ]; [Star]; [Star]; [Star]; [Star]; [Star]; [Star]; [Star]; [Quest]; [Star] ], el ->
          ConstructE (("MODULE", "module"), List.map exp2expr el)
      | [ [ Ast.Atom "IMPORT" ]; []; []; [] ], el ->
          ConstructE (("IMPORT", "import"), List.map exp2expr el)
      | [ [ Ast.Atom "GLOBAL" ]; []; [] ], el ->
          ConstructE (("GLOBAL", "global"), List.map exp2expr el)
      | [ [ Ast.Atom "TABLE" ]; [] ], el ->
          ConstructE (("TABLE", "table"), List.map exp2expr el)
      | [ [ Ast.Atom "MEMORY" ]; [] ], el ->
          ConstructE (("MEMORY", "mem"), List.map exp2expr el)
      | [ []; [ Ast.Atom "I8" ] ], el ->
          ConstructE (("I8", "memtype"), List.map exp2expr el)
      | [ [ Ast.Atom "ELEM" ]; []; [ Ast.Star ]; [ Ast.Quest ] ], el ->
          ConstructE (("ELEM", "elem"), List.map exp2expr el)
      | [ [ Ast.Atom "DATA" ]; [ Ast.Star ]; [ Ast.Quest ] ], el ->
          ConstructE (("DATA", "data"), List.map exp2expr el)
      | [ [ Ast.Atom "START" ]; [] ], el ->
          ConstructE (("START", "start"), List.map exp2expr el)
      | [ [ Ast.Atom "EXPORT" ]; []; [] ], el ->
          ConstructE (("EXPORT", "export"), List.map exp2expr el)
      | [ [ Ast.Atom "NULL" ]; [ Ast.Quest ] ], _ ->
          ConstructE (("NULL", "nul"), [])
      | _ -> YetE (Print.structured_string_of_exp exp))
  | Ast.OptE inner_exp -> OptE (Option.map exp2expr inner_exp)
  (* Yet *)
  | _ -> YetE (Print.structured_string_of_exp exp)

(* `Ast.exp` -> `expr` *)
and exp2args exp =
  match exp.it with
  | Ast.TupE el -> List.map exp2expr el
  | _ -> [ exp2expr exp ]

(* `Ast.path` -> `path list` *)
and path2paths path =
  let rec path2paths' path =
    match path.it with
    | Ast.RootP -> []
    | Ast.IdxP (p, e) -> (path2paths' p) @ [ IndexP (exp2expr e) ]
    | Ast.SliceP (p, e1, e2) -> (path2paths' p) @ [ SliceP (exp2expr e1, exp2expr e2) ]
    | Ast.DotP (p, Atom a) -> 
        (path2paths' p) @ [ DotP (name2keyword a p.note) ]
    | _ -> failwith "unreachable"
  in
  path2paths' path

(* `Ast.exp` -> `AssertI` *)
let insert_assert exp =
  match exp.it with
  | Ast.CaseE (Ast.Atom "FRAME_", _) -> AssertI TopFrameC
  | Ast.IterE (_, (Ast.ListN (e, None), _)) -> AssertI (TopValuesC (exp2expr e))
  | Ast.CaseE
      (Ast.Atom "LABEL_",
        { it = Ast.TupE [ _n; _instrs; _vals ]; _ }) -> AssertI TopLabelC
  | Ast.CaseE
      ( Ast.Atom "CONST",
        { it = Ast.TupE (ty :: _); _ }) -> AssertI (TopValueC (Some (exp2expr ty)))
  | _ -> AssertI (TopValueC None)

(* `Ast.exp list` -> `Ast.exp list * instr list` *)
let handle_lhs_stack bounds =
  List.fold_left
    (fun (instrs, rest) e ->
      if List.length rest > 0 then (instrs, rest @ [ e ])
      else
        match e.it with
        | Ast.IterE (_, (ListN (n, _), _)) when not (Il.Free.subset (Il.Free.free_exp n) bounds) -> (instrs, [ e ])
        | _ -> (instrs @ [ insert_assert e; PopI (exp2expr e) ], rest))
    ([], [])

let handle_context_winstr winstr =
  match winstr.it with
  (* Frame *)
  | Ast.CaseE (Ast.Atom "FRAME_", args) ->
    ( match args.it with
    | Ast.TupE [arity; name; inner_exp] ->
      [
        LetI (exp2expr name, GetCurFrameE);
        LetI (exp2expr arity, ArityE (exp2expr name));
        insert_assert inner_exp;
        PopI (exp2expr inner_exp);
        insert_assert winstr;
        ExitAbruptI "F";
      ]
    | _ -> failwith "Invalid frame")
  (* Label *)
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; vals ]; _ }) ->
      [
        (* TODO: append Jump instr *)
        PopAllI (exp2expr vals);
        insert_assert winstr;
        ExitAbruptI "L";
      ]
  | _ -> []

let handle_context ctx values = match ctx.it, values with
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ n; instrs; _hole ]; _ }), vs ->
      let first_vs, last_v = Util.Lib.List.split_last vs in
      [
        LetI (NameE "L", GetCurLabelE);
        LetI (exp2expr n, ArityE (NameE "L"));
        LetI (exp2expr instrs, ContE (NameE "L"));
        ]@ List.map (fun v -> PopI (exp2expr v)) first_vs @[
        PopAllI (exp2expr last_v);
        ExitAbruptI "L";
      ]
  | Ast.CaseE (Ast.Atom "FRAME_", { it = Ast.TupE [ n; _f; _hole ]; _ }), vs ->
      let first_vs, last_v = Util.Lib.List.split_last vs in
      [
        LetI (NameE "F", GetCurFrameE);
        LetI (exp2expr n, ArityE (NameE "F"));
        ]@ List.map (fun v -> PopI (exp2expr v)) first_vs @[
        PopAllI (exp2expr last_v);
        ExitAbruptI "F";
      ]
  | _ -> [ YetI "TODO: handle_context" ]

(* `Ast.exp` -> `instr list` *)
let rec rhs2instrs exp =
  match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _) -> [ TrapI ]
  (* Execute instrs *) (* TODO: doing this based on variable name is too ad-hoc. Need smarter way. *)
  | Ast.IterE ({ it = VarE id; _ }, (Ast.List, _))
  | Ast.IterE ({ it = SubE ({ it = VarE id; _ }, _, _); _}, (Ast.List, _))
    when String.starts_with ~prefix:"instr" id.it ->
      [ ExecuteSeqI (exp2expr exp) ]
  | Ast.IterE ({ it = CaseE (Atom atomid, _); note = note; _ }, (Opt, [ id ]))
    when atomid = "CALL" ->
      let new_name = NameE (id.it ^ "_0") in
      [ IfI (IsDefinedC (NameE id.it),
        [
          LetI (OptE (Some new_name), NameE id.it);
          ExecuteI (ConstructE (name2keyword atomid note, [ new_name ]))
        ],
        []) ]
  (* Push *)
  | Ast.SubE _ | IterE _ -> [ PushI (exp2expr exp) ]
  | Ast.CaseE (Atom atomid, _) when List.mem atomid [
      (* TODO: Consider automating this *)
      "CONST";
      "REF.I31_NUM";
      "REF.STRUCT_ADDR";
      "REF.ARRAY_ADDR";
      "REF.FUNC_ADDR";
      "REF.HOST_ADDR";
      "REF.EXTERN";
      "REF.NULL"
    ] -> [ PushI (exp2expr exp) ]
  (* multiple rhs' *)
  | Ast.CatE (exp1, exp2) -> rhs2instrs exp1 @ rhs2instrs exp2
  | Ast.ListE exps -> List.concat_map rhs2instrs exps
  (* Frame *)
  | Ast.CaseE
      ( Ast.Atom "FRAME_",
        {
          it =
            Ast.TupE
              [
                { it = Ast.VarE arity; _ };
                { it = Ast.VarE fname; _ };
                { it = Ast.ListE [ labelexp ]; _ };
              ];
          _;
        }) ->
          [
            LetI (NameE "F", FrameE (Some (NameE arity.it), NameE fname.it));
            EnterI (NameE "F", ListE ([ConstructE (("FRAME_", ""), [])]), rhs2instrs labelexp);
          ]
  (* TODO: Label *)
  | Ast.CaseE
      ( Atom "LABEL_",
        {
          it =
            Ast.TupE
              [ { it = Ast.VarE label_arity; _ }; instrs_exp1; instrs_exp2 ];
          _;
        }) -> (
      let label_expr =
        LabelE (NameE label_arity.it, exp2expr instrs_exp1)
      in
      match instrs_exp2.it with
      | Ast.CatE (valexp, instrsexp) ->
          [
            LetI (NameE "L", label_expr);
            EnterI (NameE "L", ConcatE (exp2expr instrsexp, ListE ([ConstructE (("LABEL_", ""), [])])), [PushI (exp2expr valexp)]);
          ]
      | _ ->
          [
            LetI (NameE "L", label_expr);
            EnterI (NameE "L", ConcatE(exp2expr instrs_exp2, ListE ([ConstructE (("LABEL_", ""), [])])), []);
          ])
  (* Execute instr *)
  | Ast.CaseE (Atom atomid, argexp) ->
      [ ExecuteI (ConstructE (name2keyword atomid exp.note, exp2args argexp)) ]
  | Ast.MixE
      ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
        (* z' ; instr'* *)
        { it = TupE [ state_exp; rhs ]; _ } ) -> (
      let push_instrs = rhs2instrs rhs in
      match state_exp.it with
      | Ast.MixE ([ []; [ Ast.Semicolon ]; [] ], _)
      | Ast.VarE _ -> push_instrs
      | Ast.CallE (f, args) -> push_instrs @ [ PerformI (f.it, exp2args args) ]
      | _ -> failwith "Invalid new state" )
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `cond` *)
let rec exp2cond exp =
  match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let compare_op = match op with
      | Ast.EqOp -> Eq
      | Ast.NeOp -> Ne
      | Ast.GtOp -> Gt
      | Ast.GeOp -> Ge
      | Ast.LtOp -> Lt
      | Ast.LeOp -> Le
      in
      CompareC (compare_op, lhs, rhs)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      let binop = match op with
      | Ast.AndOp -> And
      | Ast.OrOp -> Or
      | Ast.ImplOp -> Impl
      | Ast.EquivOp -> Equiv
      | _ ->
          gen_fail_msg_of_exp exp "binary expression for condition" |> failwith
      in
      BinopC (binop, lhs, rhs)
  | _ -> gen_fail_msg_of_exp exp "condition" |> failwith

let bound_by binding e =
  match e.it with
  | Ast.IterE (_, (ListN ({ it = VarE { it = n; _ }; _ }, None), _)) ->
      if Free.Set.mem n (Free.free_exp binding).varid then
        [ insert_assert e; PopI (exp2expr e) ]
      else []
  | _ -> []

let lhs_id_ref = ref 0
let lhs_prefix = "y_"
let init_lhs_id () = lhs_id_ref := 0
let get_lhs_name () =
  let lhs_id = !lhs_id_ref in
  lhs_id_ref := (lhs_id + 1);
  NameE (lhs_prefix ^ (lhs_id |> string_of_int))

let extract_bound_names lhs rhs targets cont = match lhs with
  (* TODO: Make this actually consider the targets *)
  | AppE (f, args) ->
    let front_args, last_arg = Util.Lib.List.split_last args in
    let new_lhs = last_arg in
    let new_rhs = AppE ("inverse_of_" ^ f, front_args @ [ rhs ]) in
    new_lhs, new_rhs, cont
  | _ ->
    let contains_bound_name e =
      let names = Al.Free.free_expr e in
      names > [] && disjoint names targets in
    let traverse e =
      let conds = ref [] in
      let walker = Al.Walk.walk_expr { Al.Walk.default_config with
        pre_expr = (fun e ->
          if not (contains_bound_name e) then
            e
          else
            let new_e = get_lhs_name() in
            conds := !conds @ [ CompareC (Eq, new_e, e) ];
            new_e
        );
        stop_cond_expr = contains_bound_name;
      } in
      let new_e = walker e in
      new_e, !conds in
    let new_lhs, conds = traverse lhs in
    new_lhs, rhs, List.fold_right (fun c il -> [ IfI (c, il, []) ]) conds cont

let rec letI lhs rhs targets cont =
  let lhs, rhs, cont = extract_bound_names lhs rhs targets cont in
  let rec has_name = function
    | NameE _ -> true
    | IterE (inner_exp, _, _) -> has_name inner_exp
    | _ -> false
  in
  let extract_non_names = List.fold_left_map (fun acc e ->
    if has_name e then acc, e
    else
      let fresh = get_lhs_name() in
      [ e, fresh ] @ acc, fresh
  ) [] in
  let translate_bindings bindings =
    List.fold_right (fun (l, r) cont ->
      match l with
      | _ when Al.Free.free_expr l = [] -> [ IfI (CompareC (Eq, r, l), cont, []) ]
      | _ -> letI l r targets cont
    ) bindings cont
  in
  match lhs with
  | ConstructE (tag, es) ->
    let bindings, es' = extract_non_names es in
    [
      IfI
        ( IsCaseOfC (rhs, tag),
          LetI (ConstructE (tag, es'), rhs) :: translate_bindings bindings,
          [] );
    ]
  | ListE es ->
    let bindings, es' = extract_non_names es in
    if List.length es >= 2 then (* TODO: remove this. This is temporarily for a pure function returning stores *)
    LetI (ListE es', rhs) :: translate_bindings bindings
    else
    [
      IfI
        ( CompareC (Eq, LengthE rhs, NumE (Int64.of_int (List.length es))),
          LetI (ListE es', rhs) :: translate_bindings bindings,
          [] );
    ]
  | OptE None ->
    [
      IfI
        ( NotC (IsDefinedC rhs),
          cont,
          [] );
    ]
  | OptE (Some (NameE _)) ->
    [
      IfI
        ( IsDefinedC rhs,
          LetI (lhs, rhs) :: cont,
          [] );
     ]
  | OptE (Some e) ->
    let fresh = get_lhs_name() in
    [
      IfI
        ( IsDefinedC rhs,
          LetI (OptE (Some fresh), rhs) :: letI e fresh targets cont,
          [] );
     ]
  | BinopE (Add, a, b) ->
    [
      IfI
        ( CompareC (Ge, rhs, b),
          LetI (a, BinopE (Sub, rhs, b)) :: cont,
          [] );
    ]
  | ConcatE (prefix, suffix) ->
    let handle_list e =
     
      match e with
      | ListE es ->
        let bindings', es' = extract_non_names es in
        Some (NumE (Int64.of_int (List.length es))), bindings', ListE es'
      | IterE (NameE _, _, ListN (e', None)) ->
        Some e', [], e
      | _ ->
        None, [], e in
    let length_p, bindings_p, prefix' = handle_list prefix in
    let length_s, bindings_s, suffix' = handle_list suffix in
    (* TODO: This condition should be injected by sideconditions pass *)
    let cond = match length_p, length_s with
      | None, None -> failwith ("Nondeterministic assignment target: " ^ Al.Print.string_of_expr lhs)
      | Some l, None
      | None, Some l -> CompareC (Ge, LengthE rhs, l)
      | Some l1, Some l2 -> CompareC (Eq, LengthE rhs, BinopE (Add, l1, l2))
    in
    [
      IfI
        ( cond,
          LetI (ConcatE (prefix', suffix'), rhs)
            :: translate_bindings (bindings_p @ bindings_s),
          [] );
    ]
  | NameE s when s = "f" || String.starts_with ~prefix:"f_" s ->
      Al.Print.string_of_expr rhs |> print_endline;
      LetI (lhs, rhs) :: cont
  | _ -> LetI (lhs, rhs) :: cont

(* HARDCODE: Translate each RulePr manually based on their names *)
let rulepr2instrs id exp instrs = match id.it, exp2args exp with
  | "Eval_expr", [z; lhs; _z; rhs] ->
    (* TODO: Name of f..? *)
    let f = z in
    EnterI (
      FrameE (None, f),
      ListE [ConstructE (("FRAME_", ""), [])],
      [ LetI (rhs, AppE ("eval_expr", [ lhs ])) ]
    ) :: instrs
  | "Ref_ok", [_s; ref; rt] ->
    LetI (rt, AppE ("ref_type_of", [ ref ])) :: instrs
  | "Reftype_sub", [_C; rt1; rt2] ->
    (* TODO: This is an abuse of notation of `Le` for subtype. Need to grow language. *)
    [ IfI (CompareC (Le, rt1, rt2), instrs |> check_nop, []) ]
  | _ -> YetI ("TODO: Unsupported rule premise:" ^ id.it) :: instrs

(** `Il.instr expr list` -> `prem` -> `instr list` -> `instr list` **)
let rec prem2instrs remain_lhs prem instrs =
  match prem.it with
  | Ast.IfPr exp -> [ IfI (exp2cond exp, instrs |> check_nop, []) ]
  | Ast.ElsePr -> [ OtherwiseI (instrs |> check_nop) ]
  | Ast.LetPr (exp1, exp2, targets) ->
      let instrs' = List.concat_map (bound_by exp1) remain_lhs @ instrs in
      init_lhs_id();
      letI (exp2expr exp1) (exp2expr exp2) targets instrs'
  | Ast.RulePr (id, _, exp) -> rulepr2instrs id exp instrs
  | Ast.IterPr _ -> iterpr2instr remain_lhs prem instrs

and iterpr2instr remain_lhs pr next_il =
  match pr.it with
  (* Inductive case *)
  | Ast.IterPr (pr, (iter, ids)) ->
    let instrs = prem2instrs remain_lhs pr next_il in

    let iter' = iter2iter iter in
    let ids' = List.map (fun id -> id.it) ids in
    let f = Al.Free.(
      function
      | LetI (lhs, rhs) when List.length (intersection (free_expr lhs) ids') > 0 ->
          let lhs_ids = intersection (free_expr lhs) ids' in
          let rhs_ids = intersection (free_expr rhs) ids' in
          [ LetI (IterE (lhs, lhs_ids, iter'), IterE (rhs, rhs_ids, iter')) ]
      (* TODO: iter for IfI *)
      | i -> [i]
    ) in
    let walk_config = { Al.Walk.default_config with post_instr = f } in
    Al.Walk.walk_instrs walk_config instrs
  | _ -> failwith "Unreachable: not an IterPr"

(** `Il.instr expr list` -> `prem list` -> `instr list` -> `instr list` **)
let prems2instrs remain_lhs = List.fold_right (prem2instrs remain_lhs)

(** reduction -> `instr list` **)

let reduction2instrs remain_lhs (_, rhs, prems, _) =
  prems2instrs remain_lhs prems (rhs2instrs rhs)

(* TODO: Perhaps this should be tail recursion *)
let rec split_context_winstr ?(note : Ast.typ option) name stack =
  let top = Ast.VarT ("TOP" $ no_region) $ no_region in
  let wrap typ e = e $$ no_region % typ in
  match stack with
  | [] ->
    let typ = Option.get note in
    [ ([], []), None ], Ast.CaseE (Ast.Atom (String.uppercase_ascii name), (Ast.TupE []) |> wrap top) |> wrap typ
  | hd :: tl ->
    match hd.it with
    | Ast.CaseE (Ast.Atom name', _)
      when name = (String.lowercase_ascii name')
      || name ^ "_"  = (String.lowercase_ascii name') ->
      [ (tl, []), None ], hd
    (* Assumption: The target winstr is inside the first list-argument of this CaseE *)
    | Ast.CaseE (a, ({it = Ast.TupE args; _} as e)) ->
      let is_list e = match e.it with Ast.CatE _ | Ast.ListE _ -> true | _ -> false in
      let list_arg = List.find is_list args in
      let inner_stack = list_arg |> flatten |> List.rev in

      let context, winstr = split_context_winstr name inner_stack in

      let hole = Ast.TextE "_" |> wrap top in
      let holed_args = List.map (fun x -> if x = list_arg then hole else x) args in
      let ctx = { hd with it = Ast.CaseE (a, { e with it = Ast.TupE holed_args }) } in
      let new_context = ((tl, []), Some ctx) :: context in
      new_context, winstr
    | _ ->
      let context, winstr = split_context_winstr ~note:(hd.note) name tl in
      let ((vs, is), c), inners = Util.Lib.List.split_hd context in
      let new_context = ((vs, hd :: is), c) :: inners in
      new_context, winstr

let un_unify (_, rhs, prems, binds) =
  let sub, new_prems = Util.Lib.List.split_hd prems in
  let new_binds = binds in (* TODO *)
  match sub.it with
  | Ast.LetPr (new_lhs, _, _) -> (new_lhs, rhs, new_prems, new_binds)
  | _ -> failwith "Unrechable un_unify"

let is_in_same_context (lhs1, _, _, _) (lhs2, _, _, _) =
  match lhs1.it, lhs2.it with
  | Ast.CaseE (atom1, _), Ast.CaseE (atom2, _) -> atom1 = atom2
  | _, _ -> false

let kind_of_context e =
  match e.it with
  | Ast.CaseE (Ast.Atom "FRAME_", _) -> ("frame", "admininstr")
  | Ast.CaseE (Ast.Atom "LABEL_", _) -> ("label", "admininstr")
  | _ -> "Could not get kind_of_context" ^ Print.string_of_exp e |> failwith

(** Main translation for reduction rules **)
(* `reduction_group list` -> `Backend-prose.Algo` *)
let rec reduction_group2algo (instr_name, reduction_group) =
  let (lhs, _, _, _) = List.hd reduction_group in
  let lhs_stack = lhs |> drop_state |> flatten |> List.rev in
  let context, winstr = split_context_winstr instr_name lhs_stack in
  let bounds = Il.Free.free_exp winstr in
  let state_instrs = if (lhs != drop_state lhs) then [ LetI (NameE "f", GetCurFrameE) ] else [] in
  let instrs = state_instrs @ match context with
    | [(vs, []), None ] ->
      let pop_instrs, remain = handle_lhs_stack bounds vs in
      let inner_pop_instrs = handle_context_winstr winstr in

      let instrs = match reduction_group |> Util.Lib.List.split_last with
      (* No premise for last reduction rule: either *)
      | hds, (_, rhs, [], _) when List.length hds > 0 ->
          assert (List.length remain = 0);
          let blocks = List.map (reduction2instrs []) hds in
          let either_body1 = List.fold_right Transpile.merge blocks [] in
          let either_body2 = rhs2instrs rhs |> check_nop in
          EitherI (either_body1, either_body2) |> Transpile.push_either
      (* Normal case *)
      | _ ->
          let blocks = List.map (reduction2instrs remain) reduction_group in
          List.fold_right Transpile.merge blocks [] in

      pop_instrs @ inner_pop_instrs @ instrs
    (* The target instruction is inside a context *)
    | [ ([], []), Some context ; (vs, _is), None ] ->
      let head_instrs = handle_context context vs in
      let body_instrs = List.map (reduction2instrs []) reduction_group |> List.concat in
      head_instrs @ body_instrs
    (* The target instruction is inside differnet contexts (i.e. return in both label and frame) *)
    | [ ([], [ _ ]), None ] -> ( try
      let orig_group = List.map un_unify reduction_group in
      let sub_groups = list_partition_with is_in_same_context orig_group in
      let unified_sub_groups = List.map (fun g -> Il2il.unify_lhs (instr_name, g)) sub_groups in
      let lhss = List.map (function _, group -> let lhs, _, _, _ = List.hd group in lhs) unified_sub_groups in
      let sub_algos = List.map reduction_group2algo unified_sub_groups in
      List.fold_right2 (fun lhs -> function 
        | RuleA (_, _, body) -> fun acc ->
          let kind = kind_of_context lhs in
          [ IfI (
            ContextKindC (kind, GetCurContextE),
            body,
            acc) ]
        | _ -> failwith "unreachable")
      lhss sub_algos []
      with
      | _ -> [ YetI "TODO: It is likely that the value stack of two rules are differ" ]
      )
    | _ ->
      [ YetI "TODO" ] in

  (* name *)
  let winstr_name = match winstr.it with
  | Ast.CaseE (Ast.Atom winstr_name, _) -> winstr_name
  | _ -> failwith "unreachable"
  in
  let name = name2keyword winstr_name winstr.note in
  (* params *)
  (* TODO: retieve param for return *)
  let al_params =
    if instr_name = "frame" || instr_name = "label"
    then []
    else
      get_params winstr |> List.map exp2expr
  in
  (* body *)
  let body = instrs |> check_nop |> Transpile.enhance_readability |> Transpile.infer_assert in

  (* Algo *)
  RuleA (name, al_params, body)

(** Temporarily convert `Ast.RuleD` into `reduction_group`: (id, (lhs, rhs, prems, binds)+) **)

type reduction_group =
  string * (Ast.exp * Ast.exp * Ast.premise list * Ast.binds) list

(* extract rules except Step/pure and Step/read *)
let extract_rules def =
  match def.it with
  | Ast.RelD (id, _, _, rules) when String.starts_with ~prefix:"Step" id.it ->
      let filter_context rule =
        let (Ast.RuleD (ruleid, _, _, _, _)) = rule.it in
        ruleid.it <> "pure" && ruleid.it <> "read"
      in
      List.filter filter_context rules
  | _ -> []

let name_of_rule rule =
  let (Ast.RuleD (id1, _, _, _, _)) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let rule2tup rule =
  let (Ast.RuleD (_, tenv, _, exp, prems)) = rule.it in
  match exp.it with
  | Ast.TupE [ lhs; rhs ] -> (lhs, rhs, prems, tenv)
  | _ ->
      Print.string_of_exp exp
      |> sprintf "Invalid expression `%s` to be reduction rule."
      |> failwith

(* group reduction rules that have same name *)
let rec group_rules = function
  | [] -> []
  | h :: t ->
      let name = name_of_rule h in
      let same_rules, diff_rules =
        List.partition (fun rule -> name_of_rule rule = name) t in
      let group = (name, List.map rule2tup (h :: same_rules)) in
      group :: group_rules diff_rules

(** Entry for translating reduction rules **)
let translate_rules il =
  let rules = List.concat_map extract_rules il in
  let reduction_groups : reduction_group list = group_rules rules in
  let unified_reduction_groups = List.map Il2il.unify_lhs reduction_groups in

  List.map reduction_group2algo unified_reduction_groups

(* `Ast.exp` -> `Ast.path` -> `expr` *)
let path2expr exp path =
  let rec path2expr' path =
    match path.it with
    | Ast.RootP -> exp
    | Ast.IdxP (p, e) -> Ast.IdxE (path2expr' p, e) $$ (path.at % path.note)
    | Ast.SliceP (p, e1, e2) -> Ast.SliceE (path2expr' p, e1, e2) $$ (path.at % path.note)
    | Ast.DotP (p, a) -> Ast.DotE (path2expr' p, a) $$ (path.at % path.note)
  in
  path2expr' path |> exp2expr

let config_helper2instrs after arity return clause =
  let Ast.DefD (_binds, _e1, e2, prems) = clause.it in
  match e2.it with
  | Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
    { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
      { it = Ast.VarE _s; _ }; { it = Ast.VarE f; _ }
    ]; _ }); _ };
    lhs
  ]; _ }) ->
    let enter =
      EnterI (FrameE (Some arity, NameE f.it), ListE ([ConstructE (("FRAME_", ""), [])]), rhs2instrs lhs)
    in
    enter :: after @ return |> prems2instrs [] prems
  | _ -> failwith "unreachable"

let normal_helper2instrs clause =
  let Ast.DefD (_binds, _e1, e2, prems) = clause.it in
  prems2instrs [] prems [ ReturnI (Option.some (exp2expr e2)) ]

(** Main translation for helper functions **)
let helpers2algo partial_funcs def =
  match def.it with
  | Ast.DecD (_, _, _, []) -> None
  | Ast.DecD (id, _t1, _t2, clauses) ->
      let name = id.it in
      let unified_clauses = Il2il.unify_defs clauses in
      let Ast.DefD (_, params, _, _) = (List.hd unified_clauses).it in
      let al_params =
        (match params.it with Ast.TupE exps -> exps | _ -> [ params ])
        |> List.map exp2expr
      in
      (* TODO: temporary hack for adding return instruction in instantation & invocation *)
      let translator =
        if id.it = "instantiate" then
          [ReturnI (Some (NameE "m"))] |> config_helper2instrs [] (NumE 0L)
        else if id.it = "invoke" then
          [ReturnI (Some (IterE (NameE "val", ["val"], ListN (NameE "k", None))))] |> config_helper2instrs [PopI (IterE (NameE "val", ["val"], ListN (NameE "k", None)))] (NameE "k")
        else
          normal_helper2instrs
      in
      let blocks = List.map translator unified_clauses in
      let body =
        List.fold_right Transpile.merge blocks []
        |> Transpile.enhance_readability
        |> if (List.exists ((=) id) partial_funcs) then (fun x -> x ) else Transpile.enforce_return in

      let algo = FuncA (name, al_params, body) in
      Some algo
  | _ -> None

let is_partial_hint hint = hint.Ast.hintid.it = "partial"
let get_partial_func def = match def.it with
  | Ast.HintD {it = Ast.DecH (id, hints); _} when List.exists is_partial_hint hints ->
    Some (id)
  | _ -> None

(** Entry for translating helper functions **)
let translate_helpers il =
  let partial_funcs = List.filter_map get_partial_func il in
  List.filter_map (helpers2algo partial_funcs) il

(** Entry **)

(* `Ast.script` -> `Algo` *)
let translate il =
  let il = List.concat_map flatten_rec il in
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.transpiler algos
