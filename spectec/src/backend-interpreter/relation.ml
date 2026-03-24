open Reference_interpreter
open Al
open Ast
open Al_util
open Ds

module FuncMap = Map.Make (String)

let ref_ok =
  (* TODO: some / none *)
  let null = some "NULL" in
  let nonull = none "NULL" in

  function
  (* null *)
  | [CaseV ("REF.NULL_ADDR", [])] -> CaseV ("REF", [ null; nullary "BOT"])
  (* i31 *)
  | [CaseV ("REF.I31_NUM", [ _ ])] -> CaseV ("REF", [ nonull; nullary "I31"])
  (* host *)
  | [CaseV ("REF.HOST_ADDR", [ _ ])] -> CaseV ("REF", [ nonull; nullary "ANY"])
  (* exception *)
  | [CaseV ("REF.EXN_ADDR", [ _ ])] -> CaseV ("REF", [ nonull; nullary "EXN"])
  (* array/func/struct addr *)
  | [CaseV (name, [ NumV (`Nat i) ])]
  when String.starts_with ~prefix:"REF." name && String.ends_with ~suffix:"_ADDR" name ->
    let field_name = String.sub name 4 (String.length name - 9) in
    let object_ = listv_nth (Ds.Store.access (field_name ^ "S")) (Z.to_int i) in
    let dt = strv_access "TYPE" object_ in
    CaseV ("REF", [ nonull; dt])
  (* extern *)
  (* TODO: check null *)
  | [CaseV ("REF.EXTERN", [ _ ])] -> CaseV ("REF", [ nonull; nullary "EXTERN"])
  | vs -> Numerics.error_values "$Reftype" vs

let module_ok v =
  if !Construct.version <> 3 then failwith "This hardcoded function ($Module_ok) should be only called with test version 3.0";
  match v with
  | [ m ] ->
    (try
      let module_ = Construct.al_to_module m in
      let ModuleT (its, ets) = Reference_interpreter.Valid.check_module module_ in
      let importtypes = List.map (fun (Types.ImportT (_, _, xt)) -> Construct.al_of_externtype xt) its in
      let exporttypes = List.map (fun (Types.ExportT (_, xt)) -> Construct.al_of_externtype xt) ets in
      CaseV ("->", [ listV_of_list importtypes; listV_of_list exporttypes ])
    with exn -> raise (Exception.Invalid (exn, Printexc.get_raw_backtrace ()))
    )

  | vs -> Numerics.error_values "$Module_ok" vs

let externaddr_ok = function
  | [ CaseV (name, [ NumV (`Nat z) ]); t ] ->
    (try
      let addr = Z.to_int z in
      let externaddr_type =
        name^"S"
        |> Store.access
        |> unwrap_listv_to_array
        |> fun arr -> Array.get arr addr
        |> strv_access "TYPE"
        |> fun type_ -> CaseV (name, [type_])
        |> Construct.al_to_externtype
      in
      let externtype = Construct.al_to_externtype t in
      boolV (Match.match_externtype [] externaddr_type externtype)
    with exn -> raise (Exception.Invalid (exn, Printexc.get_raw_backtrace ())))
  | vs -> Numerics.error_values "$Externaddr_ok" vs

let val_ok = function
  | [ v; t ] ->
    let value = Construct.al_to_value v in
    let valtype = Construct.al_to_valtype t in
    (try
      boolV (Match.match_valtype [] (Value.type_of_value value) valtype)
    with exn -> raise (Exception.Invalid (exn, Printexc.get_raw_backtrace ())))
  | vs -> Numerics.error_values "$Val_ok" vs

let expand = function
  | [ v ] ->
    (try
      v
      |> Construct.al_to_deftype
      |> Types.expand_deftype
      |> Construct.al_of_comptype
    with exn -> raise (Exception.Invalid (exn, Printexc.get_raw_backtrace ())))
  | vs -> Numerics.error_values "$Expand" vs

let manual_map =
  FuncMap.empty
  |> FuncMap.add "Ref_ok" ref_ok
  |> FuncMap.add "Module_ok" module_ok
  |> FuncMap.add "Val_ok" val_ok
  |> FuncMap.add "Externaddr_ok" externaddr_ok
  |> FuncMap.add "Expand" expand

let mem name =

  let interpreter_manual_names =
    manual_map
    |> FuncMap.bindings
    |> List.map fst
  in

  let il2al_manual_names =
    Il2al.Manual.manual_algos
    |> List.map name_of_algo
  in

  List.mem name (interpreter_manual_names @ il2al_manual_names)

let call_func name args =
  let func = FuncMap.find name manual_map in
  func args
