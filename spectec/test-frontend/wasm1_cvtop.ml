(* Exercise the SpecTec syntax constraints directly. WAST modules cannot express
   arbitrary CVTOP combinations, and the interpreter backend delegates module
   validation to the reference interpreter. See WebAssembly/spec#2302. *)

open Util.Source

(* Destination, source, operator: the 25 conversions in Wasm 1.0. Keep this
   explicit so the oracle is independent of the specification's side conditions. *)
let valid_conversions = [
  "I32", "I64", "WRAP";
  "I64", "I32", "EXTEND S";
  "I64", "I32", "EXTEND U";
  "I32", "F32", "TRUNC S";
  "I32", "F32", "TRUNC U";
  "I32", "F64", "TRUNC S";
  "I32", "F64", "TRUNC U";
  "I64", "F32", "TRUNC S";
  "I64", "F32", "TRUNC U";
  "I64", "F64", "TRUNC S";
  "I64", "F64", "TRUNC U";
  "F32", "I32", "CONVERT S";
  "F32", "I32", "CONVERT U";
  "F32", "I64", "CONVERT S";
  "F32", "I64", "CONVERT U";
  "F64", "I32", "CONVERT S";
  "F64", "I32", "CONVERT U";
  "F64", "I64", "CONVERT S";
  "F64", "I64", "CONVERT U";
  "F32", "F64", "DEMOTE";
  "F64", "F32", "PROMOTE";
  "I32", "F32", "REINTERPRET";
  "I64", "F64", "REINTERPRET";
  "F32", "I32", "REINTERPRET";
  "F64", "I64", "REINTERPRET";
]

let types = ["I32"; "I64"; "F32"; "F64"]
let operators = [
  "WRAP"; "EXTEND S"; "EXTEND U"; "TRUNC S"; "TRUNC U";
  "CONVERT S"; "CONVERT U"; "DEMOTE"; "PROMOTE"; "REINTERPRET";
]

(* Elaboration resolves the type families. Evaluate the actual constructor
   premises from the resulting IL as well: elaboration alone does not discharge
   the width restrictions or the distinct-source-and-destination condition. *)
let rec syntax_holds env e =
  match e.it with
  | Il.Ast.SubE (e, _, _) -> syntax_holds env e
  | Il.Ast.TupE es -> List.for_all (syntax_holds env) es
  | Il.Ast.CaseE (operator, arguments, _) ->
    let cases =
      match Il.Eval.reduce_typdef env e.note with
      | Ok {it = Il.Ast.VariantT cases; _} -> cases
      | _ -> failwith "expected a ground variant type"
    in
    let _, (typ, _, premises), _ =
      List.find (fun (op, _, _) -> Il.Eq.eq_mixop operator op) cases
    in
    let substitution =
      match typ.it, arguments.it with
      | Il.Ast.TupT fields, Il.Ast.TupE values ->
        List.fold_left2 (fun subst (name, _) value ->
          Il.Subst.add_varid subst name value
        ) Il.Subst.empty fields values
      | _ -> Il.Subst.empty
    in
    syntax_holds env arguments &&
    List.for_all (fun premise ->
      match premise.it with
      | Il.Ast.IfPr condition ->
        let condition = Il.Subst.subst_exp substitution condition in
        (match Il.Eval.reduce_exp env condition with
        | Ok {it = Il.Ast.BoolE result; _} -> result
        | _ -> failwith "expected a ground syntax condition"
        )
      | _ -> failwith "expected a syntax side condition"
    ) premises
  | _ -> false

let accepts frontend_env eval_env instruction =
  let exp = Frontend.Parse.parse_exp instruction in
  let typ = Frontend.Parse.parse_typ "instr" in
  let elaborated =
    try Some (Frontend.Elab.elab_exp frontend_env exp typ)
    with Util.Error.Error _ -> None
  in
  match elaborated with
  | Some exp' -> syntax_holds eval_env exp'
  | None -> false

let () =
  let directory = Sys.argv.(1) in
  let script =
    Sys.readdir directory
    |> Array.to_list
    |> List.filter (fun file -> Filename.check_suffix file ".spectec")
    |> List.sort String.compare
    |> List.concat_map (fun file ->
      Frontend.Parse.parse_file (Filename.concat directory file))
  in
  let il, frontend_env = Frontend.Elab.elab script in
  Il.Valid.valid il;
  let eval_env = Il.Env.env_of_script il in
  let accepted = ref 0 in
  let rejected = ref 0 in
  let mismatches = ref [] in
  List.iter (fun destination ->
    List.iter (fun source ->
      List.iter (fun operator ->
        let instruction =
          Printf.sprintf "CVTOP %s %s (%s)" destination source operator
        in
        let expected = List.mem (destination, source, operator) valid_conversions in
        let actual = accepts frontend_env eval_env instruction in
        if actual <> expected then
          mismatches := (Printf.sprintf "%s: expected %s, got %s" instruction
            (if expected then "accept" else "reject")
            (if actual then "accept" else "reject")) :: !mismatches;
        if actual then incr accepted else incr rejected
      ) operators
    ) types
  ) types;
  (match List.rev !mismatches with
  | [] -> ()
  | first :: _ ->
    failwith (Printf.sprintf "%d unexpected CVTOP results (%d accepted, %d rejected): %s"
      (List.length !mismatches) !accepted !rejected first)
  );
  assert (!accepted = 25 && !rejected = 135);
  Printf.printf "Wasm 1.0 CVTOP: %d legal combinations accepted, %d illegal combinations rejected\n"
    !accepted !rejected
