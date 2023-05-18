open Reference_interpreter
open Source
open Al

let al_of_wasm_num n =
  let s = Values.string_of_num n in
  let t = Values.type_of_num n in
  match t with
  | I32Type | I64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); IntV (int_of_string s) ])
  | F32Type | F64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); FloatV (float_of_string s) ])

let al_of_wasm_blocktype types wtype =
  match wtype with
  | Ast.VarBlockType idx ->
    let Types.FuncType (param_types, result_types) = (Lib.List32.nth types idx.it).it in
    let result_type_to_listV result_type =
      ListV (List.map (fun t -> WasmTypeV t) result_type |> Array.of_list)
    in
    ArrowV(result_type_to_listV param_types, result_type_to_listV result_types)
  | Ast.ValBlockType None -> ArrowV(ListV [||], ListV [||])
  | Ast.ValBlockType (Some val_type) -> ArrowV(ListV [||], ListV[| WasmTypeV val_type |])

let rec al_of_wasm_instr types winstr =
  let f_i32 f i32 = WasmInstrV (f, [ IntV (Int32.to_int i32.it) ]) in

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> al_of_wasm_num num.it
  | Ast.RefNull t -> WasmInstrV ("ref.null", [ WasmTypeV (RefType t) ])
  (* wasm instructions *)
  | Ast.Nop -> WasmInstrV ("nop", [])
  | Ast.Drop -> WasmInstrV ("drop", [])
  | Ast.Binary (Values.I32 Ast.I32Op.Add) ->
      WasmInstrV
        ("binop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "Add" ])
  | Ast.Binary (Values.I32 Ast.I32Op.Sub) ->
      WasmInstrV
        ("binop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "Sub" ])
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      WasmInstrV
        ("testop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "Eqz" ])
  | Ast.Compare (Values.F32 Ast.F32Op.Gt) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.F32Type); StringV "Gt" ])
  | Ast.Compare (Values.I32 Ast.I32Op.GtS) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "GtS" ])
  | Ast.Select None -> WasmInstrV ("select", [ StringV "TODO: None" ])
  | Ast.LocalGet i32 -> f_i32 "local.get" i32
  | Ast.LocalSet i32 -> f_i32 "local.set" i32
  | Ast.LocalTee i32 -> f_i32 "local.tee" i32
  | Ast.GlobalGet i32 -> f_i32 "global.get" i32
  | Ast.GlobalSet i32 -> f_i32 "global.set" i32
  | Ast.TableGet i32 -> f_i32 "table.get" i32
  | Ast.Call i32 -> f_i32 "call" i32
  | Ast.Block (bt, instrs) ->
      WasmInstrV
        ("block", [
            al_of_wasm_blocktype types bt;
            ListV (instrs |> al_of_wasm_instrs types |> Array.of_list)])
  | Ast.Loop (bt, instrs) ->
      WasmInstrV
        ("loop", [
            al_of_wasm_blocktype types bt;
            ListV (instrs |> al_of_wasm_instrs types |> Array.of_list)])
  | Ast.If (bt, instrs1, instrs2) ->
      WasmInstrV
        ("if", [
            al_of_wasm_blocktype types bt;
            ListV (instrs1 |> al_of_wasm_instrs types |> Array.of_list);
            ListV (instrs2 |> al_of_wasm_instrs types |> Array.of_list);
            ])
  | Ast.Br i32 -> f_i32 "br" i32
  | Ast.Return -> WasmInstrV ("return", [])
  | _ -> failwith "al_of_wasm_instr for this instr is not implemented"

and al_of_wasm_instrs types winstrs = List.map (al_of_wasm_instr types) winstrs

(* Test Interpreter *)

let al_of_wasm_func wasm_module wasm_func =

  (* Get function type from module *)
  (* Note: function type will be placed in function in DSL *)
  let { it = Types.FuncType (wtl1, wtl2); _ } =
    Int32.to_int wasm_func.it.Ast.ftype.it
    |> List.nth wasm_module.it.Ast.types in

  (* Construct function type *)
  let ftype =
    let al_of_wasm_type ty = WasmTypeV ty in
    let al_tl1 = List.map al_of_wasm_type wtl1 in
    let al_tl2 = List.map al_of_wasm_type wtl2 in
    ArrowV (ListV (Array.of_list al_tl1), ListV (Array.of_list al_tl2)) in

  (* Construct code *)
  let code = al_of_wasm_instrs wasm_module.it.types wasm_func.it.Ast.body |> Array.of_list in

  ConstructV ("FUNC", [ftype; ListV [||]; ListV (code)])

let al_of_wasm_table wasm_table =
  let Types.TableType (limits, ref_ty) = wasm_table.it.Ast.ttype in

  let f opt = IntV (Int32.to_int opt) in
  let limits_pair =
    PairV (IntV (Int32.to_int limits.Types.min), OptV (Option.map f limits.Types.max)) in

  ConstructV ("TABLE", [limits_pair; WasmTypeV (RefType ref_ty)])

let al_of_wasm_module wasm_module =

  (* Construct functions *)
  let func_list =
    List.map (al_of_wasm_func wasm_module) wasm_module.it.funcs
    |> Array.of_list
    in

  (* Construct table *)
  let table_list =
    List.map al_of_wasm_table wasm_module.it.tables
    |> Array.of_list
    in

  ConstructV ("MODULE", [ListV func_list; ListV table_list])
