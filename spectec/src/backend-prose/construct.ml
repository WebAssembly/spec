open Reference_interpreter
open Source
open Al

(* Construct types *)

let al_of_type t =
  let open Types in
  (* num_type *)
  match t with
  | NumType I32Type -> ConstructV ("I32", [])
  | NumType I64Type -> ConstructV ("I64", [])
  | NumType F32Type -> ConstructV ("F32", [])
  | NumType F64Type -> ConstructV ("F64", [])
  (* vec_type *)
  | VecType V128Type -> ConstructV ("V128", [])
  (* ref_type *)
  | RefType FuncRefType -> ConstructV ("FUNCREF", [])
  | RefType ExternRefType ->ConstructV ("EXTERNREF", [])

(* Construct value *)

let al_of_num n =
  let s = Values.string_of_num n in
  let t = Values.type_of_num n in
  match t with
  | I32Type | I64Type ->
      ConstructV ("CONST", [ al_of_type (NumType t); IntV (int_of_string s) ])
  | F32Type | F64Type ->
      ConstructV ("CONST", [ al_of_type (NumType t); FloatV (float_of_string s) ])

let al_of_value = function
| Values.Num n -> al_of_num n
| Values.Vec _v -> failwith "TODO"
| Values.Ref r ->
    begin match r with
      | Values.NullRef t -> ConstructV ("REF.NULL", [ al_of_type (RefType t) ])
      | Script.ExternRef i -> ConstructV ("REF.HOST_ADDR", [ IntV (Int32.to_int i) ])
      | r -> Values.string_of_ref r |> failwith
    end

(* Construct type *)

let al_of_blocktype types wtype =
  match wtype with
  | Ast.VarBlockType idx ->
    let Types.FuncType (param_types, result_types) = (Lib.List32.nth types idx.it).it in
    let result_type_to_listV result_type =
      ListV (List.map al_of_type result_type |> Array.of_list)
    in
    ArrowV(result_type_to_listV param_types, result_type_to_listV result_types)
  | Ast.ValBlockType None -> ArrowV(ListV [||], ListV [||])
  | Ast.ValBlockType (Some val_type) -> ArrowV(ListV [||], ListV[| al_of_type val_type |])

(* Construct instruction *)

let al_of_unop_int = function
  | Ast.IntOp.Clz -> StringV "Clz"
  | Ast.IntOp.Ctz -> StringV "Ctz"
  | Ast.IntOp.Popcnt -> StringV "Popcnt"
  | Ast.IntOp.ExtendS _ -> StringV "TODO"
let al_of_unop_float = function
  | Ast.FloatOp.Neg -> StringV "Neg"
  | Ast.FloatOp.Abs -> StringV "Abs"
  | Ast.FloatOp.Ceil -> StringV "Ceil"
  | Ast.FloatOp.Floor -> StringV "Floor"
  | Ast.FloatOp.Trunc -> StringV "Trunc"
  | Ast.FloatOp.Nearest -> StringV "Nearest"
  | Ast.FloatOp.Sqrt -> StringV "Sqrt"

let al_of_binop_int = function
  | Ast.IntOp.Add -> StringV "Add"
  | Ast.IntOp.Sub -> StringV "Sub"
  | Ast.IntOp.Mul -> StringV "Mul"
  | Ast.IntOp.DivS -> StringV "DivS"
  | Ast.IntOp.DivU -> StringV "DivU"
  | Ast.IntOp.RemS -> StringV "RemS"
  | Ast.IntOp.RemU -> StringV "RemU"
  | Ast.IntOp.And -> StringV "And"
  | Ast.IntOp.Or -> StringV "Or"
  | Ast.IntOp.Xor -> StringV "Xor"
  | Ast.IntOp.Shl -> StringV "Shl"
  | Ast.IntOp.ShrS -> StringV "ShrS"
  | Ast.IntOp.ShrU -> StringV "ShrU"
  | Ast.IntOp.Rotl -> StringV "Rotl"
  | Ast.IntOp.Rotr -> StringV "Rotr"
let al_of_binop_float = function
  | Ast.FloatOp.Add -> StringV "Add"
  | Ast.FloatOp.Sub -> StringV "Sub"
  | Ast.FloatOp.Mul -> StringV "Mul"
  | Ast.FloatOp.Div -> StringV "Div"
  | Ast.FloatOp.Min -> StringV "Min"
  | Ast.FloatOp.Max -> StringV "Max"
  | Ast.FloatOp.CopySign -> StringV "CopySign"

let al_of_testop_int = function
  | Ast.IntOp.Eqz -> StringV "Eqz"

let al_of_relop_int = function
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
let al_of_relop_float = function
  | Ast.FloatOp.Eq -> StringV "Eq"
  | Ast.FloatOp.Ne -> StringV "Ne"
  | Ast.FloatOp.Lt -> StringV "Lt"
  | Ast.FloatOp.Gt -> StringV "Gt"
  | Ast.FloatOp.Le -> StringV "Le"
  | Ast.FloatOp.Ge -> StringV "Ge"

let al_of_cvtop_int = function
  | Ast.IntOp.ExtendSI32 -> StringV "ExtendI32"
  | Ast.IntOp.ExtendUI32 -> StringV "ExtendUI32"
  | Ast.IntOp.WrapI64 -> StringV "WrapI64"
  | Ast.IntOp.TruncSF32 -> StringV "TruncSF32"
  | Ast.IntOp.TruncUF32 -> StringV "TruncUF32"
  | Ast.IntOp.TruncSF64 -> StringV "TruncSF64"
  | Ast.IntOp.TruncUF64 -> StringV "TruncUF64"
  | Ast.IntOp.TruncSatSF32 -> StringV "TrucSatSF32"
  | Ast.IntOp.TruncSatUF32 -> StringV "TrunsSatUF32"
  | Ast.IntOp.TruncSatSF64 -> StringV "TruncSatSF64"
  | Ast.IntOp.TruncSatUF64 -> StringV "TruncSatUF64"
  | Ast.IntOp.ReinterpretFloat -> StringV "ReinterpretFloat"
let al_of_cvtop_float = function
  | Ast.FloatOp.ConvertSI32 -> StringV "ConvertI32"
  | Ast.FloatOp.ConvertUI32 -> StringV "ConvertUI32"
  | Ast.FloatOp.ConvertSI64 -> StringV "ConvertI64"
  | Ast.FloatOp.ConvertUI64 -> StringV "ConvertUI64"
  | Ast.FloatOp.PromoteF32 -> StringV "PromoteF32"
  | Ast.FloatOp.DemoteF64 -> StringV "DemoteF64"
  | Ast.FloatOp.ReinterpretInt -> StringV "ReinterpretInt"

let al_of_packsize = function
| Types.Pack8 -> IntV 8
| Types.Pack16 -> IntV 16
| Types.Pack32 -> IntV 32
| Types.Pack64 -> IntV 64

let al_of_extension = function
| Types.SX -> ConstructV ("S", [])
| Types.ZX -> ConstructV ("U", [])

let al_of_packsize_with_extension (p, s) =
  ListV [| al_of_packsize p; al_of_extension s |]


let rec al_of_instr types winstr =
  let to_int i32 = IntV (Int32.to_int i32.it) in
  let f name  = ConstructV (name, []) in
  let f_i32 name i32 = ConstructV (name, [to_int i32]) in
  let f_i32_i32 name i32 i32' = ConstructV (name, [to_int i32; to_int i32']) in

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> al_of_num num.it
  | Ast.RefNull t -> al_of_value (Values.Ref (Values.NullRef t))
  (* wasm instructions *)
  | Ast.Unreachable -> f "UNREACHABLE"
  | Ast.Nop -> f "NOP"
  | Ast.Drop -> f "DROP"
  | Ast.Unary (Values.I32 op) ->
      ConstructV
        ("UNOP", [ al_of_type (Types.NumType Types.I32Type); al_of_unop_int op ])
  | Ast.Unary (Values.F32 op) ->
      ConstructV
        ("UNOP", [ al_of_type (Types.NumType Types.F32Type); al_of_unop_float op ])
  | Ast.Binary (Values.I32 op) ->
      ConstructV
        ("BINOP", [ al_of_type (Types.NumType Types.I32Type); al_of_binop_int op ])
  | Ast.Binary (Values.F32 op) ->
      ConstructV
        ("BINOP", [ al_of_type (Types.NumType Types.F32Type); al_of_binop_float op ])
  | Ast.Test (Values.I32 op) ->
      ConstructV
        ("TESTOP", [ al_of_type (Types.NumType Types.I32Type); al_of_testop_int op ])
  | Ast.Compare (Values.I32 op) ->
      ConstructV
        ("RELOP", [ al_of_type (Types.NumType Types.I32Type); al_of_relop_int op ])
  | Ast.Compare (Values.F32 op) ->
      ConstructV
        ("RELOP", [ al_of_type (Types.NumType Types.F32Type); al_of_relop_float op ])
  | Ast.RefIsNull -> f "REF.IS_NULL"
  | Ast.RefFunc i32 -> f_i32 "REF.FUNC" i32
  | Ast.Select None -> ConstructV ("SELECT", [ StringV "TODO: None" ])
  | Ast.LocalGet i32 -> f_i32 "LOCAL.GET" i32
  | Ast.LocalSet i32 -> f_i32 "LOCAL.SET" i32
  | Ast.LocalTee i32 -> f_i32 "LOCAL.TEE" i32
  | Ast.GlobalGet i32 -> f_i32 "GLOBAL.GET" i32
  | Ast.GlobalSet i32 -> f_i32 "GLOBAL.SET" i32
  | Ast.TableGet i32 -> f_i32 "TABLE.GET" i32
  | Ast.TableSet i32 -> f_i32 "TABLE.SET" i32
  | Ast.TableSize i32 -> f_i32 "TABLE.SIZE" i32
  | Ast.TableGrow i32 -> f_i32 "TABLE.GROW" i32
  | Ast.TableFill i32 -> f_i32 "TABLE.FILL" i32
  | Ast.TableInit (i32, i32') -> f_i32_i32 "TABLE.INIT" i32 i32'
  | Ast.Call i32 -> f_i32 "CALL" i32
  | Ast.CallIndirect (i32, i32') -> f_i32_i32 "CALL_INDIRECT" i32 i32'
  | Ast.Block (bt, instrs) ->
      ConstructV
        ("BLOCK", [
            al_of_blocktype types bt;
            ListV (instrs |> al_of_instrs types |> Array.of_list)])
  | Ast.Loop (bt, instrs) ->
      ConstructV
        ("LOOP", [
            al_of_blocktype types bt;
            ListV (instrs |> al_of_instrs types |> Array.of_list)])
  | Ast.If (bt, instrs1, instrs2) ->
      ConstructV
        ("IF", [
            al_of_blocktype types bt;
            ListV (instrs1 |> al_of_instrs types |> Array.of_list);
            ListV (instrs2 |> al_of_instrs types |> Array.of_list);
            ])
  | Ast.Br i32 -> f_i32 "BR" i32
  | Ast.BrIf i32 -> f_i32 "BR_IF" i32
  | Ast.BrTable (i32s, i32) ->
      ConstructV
        ("BR_TABLE", [ ListV (i32s |> List.map to_int |> Array.of_list); to_int i32 ])
  | Ast.Return -> ConstructV ("RETURN", [])
  | Ast.Load {ty = ty; align = align; offset = offset; pack = pack} ->
      ConstructV
        ("LOAD", [
            al_of_type (Types.NumType ty);
            OptV (Option.map al_of_packsize_with_extension pack);
            IntV align;
            IntV (Int32.to_int offset) ])
  | Ast.Store {ty = ty; align = align; offset = offset; pack = pack} ->
      ConstructV
        ("STORE", [
            al_of_type (Types.NumType ty);
            OptV (Option.map al_of_packsize pack);
            IntV align;
            IntV (Int32.to_int offset) ])
  | Ast.MemorySize -> f "MEMORY.SIZE"
  | Ast.MemoryGrow -> f "MEMORY.GROW"
  | Ast.MemoryFill -> f "MEMORY.FILL"
  | Ast.MemoryCopy -> f "MEMORY.COPY"
  | _ -> ConstructV ("Yet: " ^ Print.string_of_winstr winstr, [])

and al_of_instrs types winstrs = List.map (al_of_instr types) winstrs



(* Construct module *)

let al_of_func wasm_module wasm_func =
  (* Destruct wasm_module and wasm_func *)
  let { Ast.types = wasm_types; _ } = wasm_module.it in
  let { Ast.ftype = wasm_ftype; Ast.locals = wasm_locals; Ast.body = wasm_body} = wasm_func.it in

  (* Get function type from module *)
  (* Note: function type will be placed in function in DSL *)
  let { it = Types.FuncType (wtl1, wtl2); _ } =
    List.nth wasm_types (Int32.to_int wasm_ftype.it) in

  (* Construct function type *)
  let ftype =
    let al_tl1 = List.map al_of_type wtl1 in
    let al_tl2 = List.map al_of_type wtl2 in
    ArrowV (ListV (Array.of_list al_tl1), ListV (Array.of_list al_tl2)) in

  (* Construct locals *)
  let locals = List.map al_of_type wasm_locals |> Array.of_list in

  (* Construct code *)
  let code = al_of_instrs wasm_module.it.types wasm_body |> Array.of_list in

  (* Construct func *)
  ConstructV ("FUNC", [ftype; ListV locals; ListV code])

let al_of_global wasm_global =
  let expr = al_of_instrs [] wasm_global.it.Ast.ginit.it |> Array.of_list in

  ConstructV ("GLOBAL", [ StringV "Yet: global type"; ListV expr ])

let al_of_limits limits =
  let f opt = IntV (Int32.to_int opt) in
  PairV (IntV (Int32.to_int limits.Types.min), OptV (Option.map f limits.Types.max))

let al_of_table wasm_table =
  let Types.TableType (limits, ref_ty) = wasm_table.it.Ast.ttype in
  let pair = al_of_limits limits in

  ConstructV ("TABLE", [ pair; al_of_type (RefType ref_ty) ])

let al_of_memory wasm_memory =
  let Types.MemoryType (limits) = wasm_memory.it.Ast.mtype in
  let pair = al_of_limits limits in

  ConstructV ("MEMORY", [ pair ])

let al_of_segment wasm_segment = match wasm_segment.it with
  | Ast.Passive -> OptV None
  | Ast.Active { index = index; offset = offset } ->
      OptV (
        Some (
          ConstructV (
            "MEMORY",
            [
              IntV (Int32.to_int index.it);
              ListV (al_of_instrs [] offset.it |> Array.of_list)
            ]
          )
        )
      )
  | Ast.Declarative -> failwith "TODO: Declarative"

let al_of_data wasm_data =
  (* TODO: byte list list *)
  let init = wasm_data.it.Ast.dinit in
  let f chr acc = IntV (Char.code chr) :: acc in
  let byte_list = String.fold_right f init [] |> Array.of_list in
  let mode = al_of_segment wasm_data.it.Ast.dmode in

  ConstructV ("DATA", [ ListV byte_list; mode ])

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

  (* Construct memory *)
  let memory_list =
    List.map al_of_memory wasm_module.it.memories
    |> Array.of_list
  in

  (* Construct elem *)
  (* TODO *)
  let elem_list = [| StringV "Yet" |] in

  (* Construct data *)
  let data_list =
    List.map al_of_data wasm_module.it.datas
    |> Array.of_list
  in

  ConstructV (
    "MODULE",
    [
      ListV func_list;
      ListV global_list;
      ListV table_list;
      ListV memory_list;
      ListV elem_list;
      ListV data_list
    ]
  )
