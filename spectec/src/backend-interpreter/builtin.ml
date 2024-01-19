open Construct
open Al.Ast
open Util
open Reference_interpreter
open Ds

let builtin () =

  (* TODO : Change this into host fnuction instance, instead of current normal function instance *)
  let create_funcinst (name, type_tags) =
    let winstr_tag = String.uppercase_ascii name in
    let code = singleton winstr_tag in
    let ptype = Array.map singleton type_tags in
    let arrow = TupV [ listV ptype; listV [||] ] in
    let ftype = CaseV ("FUNC", [ arrow ]) in
    let dt =
      CaseV ("DEF", [
        CaseV ("REC", [
          [| CaseV ("SUBD", [OptV (Some (singleton "FINAL")); listV [||]; ftype]) |] |> listV
        ]); numV 0L
      ]) in
    name, StrV [
      "TYPE", ref (if !Construct.version = 3 then dt else arrow);
      "MODULE", ref (StrV Record.empty); (* dummy module *)
      "CODE", ref (CaseV ("FUNC", [ ftype; listV [||]; listV [| code |] ]))
    ] in

  let create_globalinst t v = StrV [
    "TYPE", t |> ref;
    "VALUE", v |> ref
  ] in

  let create_tableinst t elems = StrV [
    "TYPE", t |> ref;
    "ELEM", elems |> ref
  ] in

  let create_meminst t bytes_ = StrV [
    "TYPE", t |> ref;
    "DATA", bytes_ |> ref
  ] in

  (* Builtin functions *)
  let funcs = List.rev [
    ("print", [||]) |> create_funcinst;
    ("print_i32", [| "I32" |]) |> create_funcinst;
    ("print_i64", [| "I64" |]) |> create_funcinst;
    ("print_f32", [| "F32" |]) |> create_funcinst;
    ("print_f64", [| "F64" |]) |> create_funcinst;
    ("print_i32_f32", [| "I32"; "F32" |]) |> create_funcinst;
    ("print_f64_f64", [| "F64"; "F64" |]) |> create_funcinst
  ] in
  (* Builtin globals *)
  let globals = List.rev [
    "global_i32", 666   |> I32.of_int_u |> Numerics.i32_to_const |> create_globalinst (TextV "global_type");
    "global_i64", 666   |> I64.of_int_u |> Numerics.i64_to_const |> create_globalinst (TextV "global_type");
    "global_f32", 666.6 |> F32.of_float |> Numerics.f32_to_const |> create_globalinst (TextV "global_type");
    "global_f64", 666.6 |> F64.of_float |> Numerics.f64_to_const |> create_globalinst (TextV "global_type");
  ] in
  (* Builtin tables *)
  let nulls = CaseV ("REF.NULL", [ singleton "FUNC" ]) |> Array.make 10 in
  let tables = [
    "table",
    listV nulls
    |> create_tableinst (TupV [ TupV [ numV 10L; numV 20L ]; singleton "FUNCREF" ]);
  ] in
  (* Builtin memories *)
  let zeros = numV 0L |> Array.make 0x10000 in
  let memories = [
    "memory",
    listV zeros
    |> create_meminst (CaseV ("I8", [ TupV [ numV 1L; numV 2L ] ]));
  ] in

  let append kind (name, inst) extern =

    (* Generate ExternFunc *)

    let addr =
      match Record.find kind (get_store ()) with
      | ListV a -> Array.length !a |> Int64.of_int
      | _ -> failwith "Unreachable"
    in
    let new_extern =
      StrV [ "NAME", ref (TextV name); "VALUE", ref (CaseV (kind, [ numV addr ])) ]
    in

    (* Update Store *)

    (match Record.find kind (get_store ()) with
    | ListV a -> a := Array.append !a [|inst|]
    | _ -> failwith "Invalid store field");

    new_extern :: extern in

  (* extern -> new_extern *)
  let func_extern = List.fold_right (append "FUNC") funcs in
  let global_extern = List.fold_right (append "GLOBAL") globals in
  let table_extern = List.fold_right (append "TABLE") tables in
  let memory_extern = List.fold_right (append "MEM") memories in

  let extern =
    []
    |> func_extern
    |> global_extern
    |> table_extern
    |> memory_extern
    |> Array.of_list in

  let moduleinst =
    Record.empty
    |> Record.add "FUNC" (listV [||])
    |> Record.add "GLOBAL" (listV [||])
    |> Record.add "TABLE" (listV [||])
    |> Record.add "MEM" (listV [||])
    |> Record.add "ELEM" (listV [||])
    |> Record.add "DATA" (listV [||])
    |> Record.add "EXPORT" (listV extern) in

  StrV moduleinst
