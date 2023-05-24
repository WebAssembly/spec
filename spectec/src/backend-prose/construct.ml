open Reference_interpreter
open Source
open Al

(* Construct value *)
let al_of_num n =
  let s = Values.string_of_num n in
  let t = Values.type_of_num n in
  match t with
  | I32Type | I64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); IntV (int_of_string s) ])
  | F32Type | F64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); FloatV (float_of_string s) ])

let al_of_value = function
| Values.Num n -> al_of_num n
| Values.Vec _v -> failwith "TODO"
| Values.Ref r ->
    begin match r with
      | Values.NullRef t -> al_of_instr [] {it = Ast.RefNull t; at = Source.no_region}
      | Script.ExternRef i -> ConstructV ("REF.HOST_ADDR", [ IntV (Int32.to_int i) ])
      | r -> Values.string_of_ref r |> failwith
    end

(* Construct type *)
let al_of_blocktype types wtype =
  match wtype with
  | Ast.VarBlockType idx ->
    let Types.FuncType (param_types, result_types) = (Lib.List32.nth types idx.it).it in
    let result_type_to_listV result_type =
      ListV (List.map (fun t -> WasmTypeV t) result_type |> Array.of_list)
    in
    ArrowV(result_type_to_listV param_types, result_type_to_listV result_types)
  | Ast.ValBlockType None -> ArrowV(ListV [||], ListV [||])
  | Ast.ValBlockType (Some val_type) -> ArrowV(ListV [||], ListV[| WasmTypeV val_type |])

(* Construct instruction *)
let al_of_unop = function
  | Ast.IntOp.Clz -> StringV "Clz"
  | Ast.IntOp.Ctz -> StringV "Ctz"
  | Ast.IntOp.Popcnt
  | Ast.IntOp.ExtendS _ -> StringV "TODO"
let al_of_binop = function
  | Ast.IntOp.Add -> StringV "Add"
  | Ast.IntOp.Sub -> StringV "Sub"
  | Ast.IntOp.Mul -> StringV "Mul"
  | Ast.IntOp.DivS
  | Ast.IntOp.DivU
  | Ast.IntOp.RemS
  | Ast.IntOp.RemU
  | Ast.IntOp.And
  | Ast.IntOp.Or
  | Ast.IntOp.Xor
  | Ast.IntOp.Shl
  | Ast.IntOp.ShrS
  | Ast.IntOp.ShrU
  | Ast.IntOp.Rotl
  | Ast.IntOp.Rotr -> StringV "TODO"
let al_of_testop = function
  | Ast.IntOp.Eqz -> StringV "Eqz"
let al_of_relop = function
  | Ast.IntOp.Eq -> StringV "Eq"
  | Ast.IntOp.Ne -> StringV "Ne"
  | Ast.IntOp.LtS -> StringV "LtS"
  | Ast.IntOp.LtU -> StringV "LtU"
  | Ast.IntOp.GtS -> StringV "GtS"
  | Ast.IntOp.GtU -> StringV "GtU"
  | Ast.IntOp.LeS -> StringV "LeS"
  | Ast.IntOp.LeU -> StringV "LeU"
  | Ast.IntOp.GeS -> StringV "GeS"
  | Ast.IntOp.GeU -> StringV "GeU"
let al_of_cvtop = function
  | Ast.IntOp.ExtendSI32
  | Ast.IntOp.ExtendUI32
  | Ast.IntOp.WrapI64
  | Ast.IntOp.TruncSF32
  | Ast.IntOp.TruncUF32
  | Ast.IntOp.TruncSF64
  | Ast.IntOp.TruncUF64
  | Ast.IntOp.TruncSatSF32
  | Ast.IntOp.TruncSatUF32
  | Ast.IntOp.TruncSatSF64
  | Ast.IntOp.TruncSatUF64
  | Ast.IntOp.ReinterpretFloat -> StringV "TODO"

let rec al_of_instr types winstr =
  let to_int i32 = IntV (Int32.to_int i32.it) in
  let f name  = WasmInstrV (name, []) in
  let f_i32 name i32 = WasmInstrV (name, [to_int i32]) in

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> al_of_num num.it
  | Ast.RefNull t -> WasmInstrV ("ref.null", [ WasmTypeV (RefType t) ])
  (* wasm instructions *)
  | Ast.Unreachable -> f "unreachable"
  | Ast.Nop -> f "nop"
  | Ast.Drop -> f "drop"
  | Ast.Unary (Values.I32 op) ->
      WasmInstrV
        ("unop", [ WasmTypeV (Types.NumType Types.I32Type); al_of_unop op ])
  | Ast.Binary (Values.I32 op) ->
      WasmInstrV
        ("binop", [ WasmTypeV (Types.NumType Types.I32Type); al_of_binop op ])
  | Ast.Test (Values.I32 op) ->
      WasmInstrV
        ("testop", [ WasmTypeV (Types.NumType Types.I32Type); al_of_testop op ])
  | Ast.Compare (Values.I32 op) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.I32Type); al_of_relop op ])
  | Ast.Compare (Values.F32 Ast.F32Op.Gt) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.F32Type); StringV "Gt" ])
  | Ast.Select None -> WasmInstrV ("select", [ StringV "TODO: None" ])
  | Ast.LocalGet i32 -> f_i32 "local.get" i32
  | Ast.LocalSet i32 -> f_i32 "local.set" i32
  | Ast.LocalTee i32 -> f_i32 "local.tee" i32
  | Ast.GlobalGet i32 -> f_i32 "global.get" i32
  | Ast.GlobalSet i32 -> f_i32 "global.set" i32
  | Ast.TableGet i32 -> f_i32 "table.get" i32
  | Ast.Call i32 -> f_i32 "call" i32
  | Ast.CallIndirect (i32, i32') ->
      WasmInstrV
        ("call_indirect", [ to_int i32; to_int i32' ])
  | Ast.Block (bt, instrs) ->
      WasmInstrV
        ("block", [
            al_of_blocktype types bt;
            ListV (instrs |> al_of_instrs types |> Array.of_list)])
  | Ast.Loop (bt, instrs) ->
      WasmInstrV
        ("loop", [
            al_of_blocktype types bt;
            ListV (instrs |> al_of_instrs types |> Array.of_list)])
  | Ast.If (bt, instrs1, instrs2) ->
      WasmInstrV
        ("if", [
            al_of_blocktype types bt;
            ListV (instrs1 |> al_of_instrs types |> Array.of_list);
            ListV (instrs2 |> al_of_instrs types |> Array.of_list);
            ])
  | Ast.Br i32 -> f_i32 "br" i32
  | Ast.BrIf i32 -> f_i32 "br_if" i32
  | Ast.BrTable (i32s, i32) ->
      WasmInstrV
        ("br_table", [ ListV (i32s |> List.map to_int |> Array.of_list); to_int i32 ])
  | Ast.Return -> WasmInstrV ("return", [])
  | Ast.Load _loadop -> StringV "TODO: load"
  | Ast.Store _storeop -> StringV "TODO: store"
  | Ast.MemorySize -> f "memory.size"
  | Ast.MemoryGrow -> f "mewmory.grow"
  | Ast.MemoryFill -> f "memory.fill"
  | Ast.MemoryCopy -> f "memory.copy"
  | _ -> WasmInstrV ("Yet: " ^ Print.string_of_winstr winstr, [])

and al_of_instrs types winstrs = List.map (al_of_instr types) winstrs

(* Construct module *)

let al_of_func wasm_module wasm_func =

  (* Get function type from module *)
  (* Note: function type will be placed in function in DSL *)
  let { it = Types.FuncType (wtl1, wtl2); _ } =
    Int32.to_int wasm_func.it.Ast.ftype.it
    |> List.nth wasm_module.it.Ast.types in

  (* Construct function type *)
  let ftype =
    let al_of_type ty = WasmTypeV ty in
    let al_tl1 = List.map al_of_type wtl1 in
    let al_tl2 = List.map al_of_type wtl2 in
    ArrowV (ListV (Array.of_list al_tl1), ListV (Array.of_list al_tl2)) in

  (* Construct code *)
  let code = al_of_instrs wasm_module.it.types wasm_func.it.Ast.body |> Array.of_list in

  ConstructV ("FUNC", [ftype; ListV [||]; ListV (code)])

let al_of_global wasm_global =
  let expr = al_of_instrs [] wasm_global.it.Ast.ginit.it |> Array.of_list in

  ConstructV ("GLOBAL", [ StringV "Yet: global type"; ListV expr ])

let al_of_table wasm_table =
  let Types.TableType (limits, ref_ty) = wasm_table.it.Ast.ttype in

  let f opt = IntV (Int32.to_int opt) in
  let limits_pair =
    PairV (IntV (Int32.to_int limits.Types.min), OptV (Option.map f limits.Types.max)) in

  ConstructV ("TABLE", [limits_pair; WasmTypeV (RefType ref_ty)])

let al_of_module wasm_module =

  (* Construct functions *)
  let func_list =
    List.map (al_of_func wasm_module) wasm_module.it.funcs
    |> Array.of_list
  in

  (* Construct global *)
  let global_list =
    List.map al_of_global wasm_module.it.globals
    |> Array.of_list
  in

  (* Construct table *)
  let table_list =
    List.map al_of_table wasm_module.it.tables
    |> Array.of_list
  in

  ConstructV (
    "MODULE",
    [
      ListV func_list;
      ListV global_list;
      ListV table_list;
    ]
  )
