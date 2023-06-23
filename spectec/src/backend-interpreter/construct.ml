open Reference_interpreter
open Source
open Al.Ast

(* Construct types *)

let al_of_type t =
  let open Types in
  (* num_type *)
  match t with
  | NumType I32Type -> singleton "I32"
  | NumType I64Type -> singleton "I64"
  | NumType F32Type -> singleton "F32"
  | NumType F64Type -> singleton "F64"
  (* vec_type *)
  | VecType V128Type -> singleton "V128"
  (* ref_type *)
  | RefType FuncRefType -> singleton "FUNCREF"
  | RefType ExternRefType ->singleton "EXTERNREF"

(* Construct value *)

let int64_of_int32_u x = x |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let al_of_num n =
  let t, v = match n with
    | Values.I32 i -> "I32", i |> I32.to_bits |> int64_of_int32_u
    | Values.I64 i -> "I64", i |> I64.to_bits
    | Values.F32 f -> "F32", f |> F32.to_bits |> int64_of_int32_u
    | Values.F64 f -> "F64", f |> F64.to_bits in
  let t, v = ConstructV(t, []), NumV v in
  ConstructV ("CONST", [ t; v ])

let al_of_value = function
| Values.Num n -> al_of_num n
| Values.Vec _v -> failwith "TODO"
| Values.Ref r ->
    begin match r with
      | Values.NullRef t -> ConstructV ("REF.NULL", [ al_of_type (RefType t) ])
      | Script.ExternRef i -> ConstructV ("REF.HOST_ADDR", [ NumV (int64_of_int32_u i) ])
      | r -> Values.string_of_ref r |> failwith
    end

(* Construct type *)

let al_of_typeidx types idx =
  let Types.FuncType (param_types, result_types) = (Lib.List32.nth types idx.it).it in
  let result_type_to_listV result_type =
    listV (List.map al_of_type result_type)
  in
  ArrowV(result_type_to_listV param_types, result_type_to_listV result_types)

let al_of_blocktype types = function
| Ast.VarBlockType idx -> al_of_typeidx types idx
| Ast.ValBlockType None -> ArrowV(listV [], listV [])
| Ast.ValBlockType (Some val_type) -> ArrowV(listV [], listV [al_of_type val_type])


(* Construct instruction *)

let al_of_unop_int = function
  | Ast.IntOp.Clz -> StringV "Clz"
  | Ast.IntOp.Ctz -> StringV "Ctz"
  | Ast.IntOp.Popcnt -> StringV "Popcnt"
  | Ast.IntOp.ExtendS Types.Pack8 -> StringV "Extend8S"
  | Ast.IntOp.ExtendS Types.Pack16 -> StringV "Extend16S"
  | Ast.IntOp.ExtendS Types.Pack32 -> StringV "Extend32S"
  | Ast.IntOp.ExtendS Types.Pack64 -> StringV "Extend64S"
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

let al_of_cvtop_int bit_num = function
  | Ast.IntOp.ExtendSI32 -> "Extend", "I32", Some (singleton "S")
  | Ast.IntOp.ExtendUI32 -> "Extend", "I32", Some (singleton "U")
  | Ast.IntOp.WrapI64 -> "Wrap", "I64", None
  | Ast.IntOp.TruncSF32 -> "Trunc", "F32", Some (singleton "S")
  | Ast.IntOp.TruncUF32 -> "Trunc", "F32", Some (singleton "U")
  | Ast.IntOp.TruncSF64 -> "Trunc", "F64", Some (singleton "S")
  | Ast.IntOp.TruncUF64 -> "Trunc", "F64", Some (singleton "U")
  | Ast.IntOp.TruncSatSF32 -> "TruncSat", "F32", Some (singleton "S")
  | Ast.IntOp.TruncSatUF32 -> "TruncSat", "F32", Some (singleton "U")
  | Ast.IntOp.TruncSatSF64 -> "TruncSat", "F64", Some (singleton "S")
  | Ast.IntOp.TruncSatUF64 -> "TruncSat", "F64", Some (singleton "U")
  | Ast.IntOp.ReinterpretFloat -> "Reinterpret", ("F" ^ bit_num), None
let al_of_cvtop_float bit_num = function
  | Ast.FloatOp.ConvertSI32 -> "Convert", "I32", Some (singleton "S")
  | Ast.FloatOp.ConvertUI32 -> "Convert", "I32", Some (singleton "U")
  | Ast.FloatOp.ConvertSI64 -> "Convert", "I64", Some (singleton "S")
  | Ast.FloatOp.ConvertUI64 -> "Convert", "I64", Some (singleton "U")
  | Ast.FloatOp.PromoteF32 -> "Promote", "F32", None
  | Ast.FloatOp.DemoteF64 -> "Demote", "F64", None
  | Ast.FloatOp.ReinterpretInt -> "Reinterpret", ("I" ^ bit_num), None

let al_of_packsize p =
  let s = match p with
    | Types.Pack8 -> 8
    | Types.Pack16 -> 16
    | Types.Pack32 -> 32
    | Types.Pack64 -> 64
  in
  NumV (Int64.of_int s)

let al_of_extension = function
| Types.SX -> singleton "S"
| Types.ZX -> singleton "U"

let al_of_packsize_with_extension (p, s) =
  listV [ al_of_packsize p; al_of_extension s ]


let rec al_of_instr types winstr =
  let to_int i32 = NumV (int64_of_int32_u i32.it) in
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
  | Ast.Unary op ->
    let (ty, op) = (
      match op with
      | Values.I32 op -> ("I32", al_of_unop_int op)
      | Values.I64 op -> ("I64", al_of_unop_int op)
      | Values.F32 op -> ("F32", al_of_unop_float op)
      | Values.F64 op -> ("F64", al_of_unop_float op))
    in
    ConstructV ("UNOP", [ singleton ty; op ])
  | Ast.Binary op ->
    let (ty, op) = (
      match op with
      | Values.I32 op -> ("I32", al_of_binop_int op)
      | Values.I64 op -> ("I64", al_of_binop_int op)
      | Values.F32 op -> ("F32", al_of_binop_float op)
      | Values.F64 op -> ("F64", al_of_binop_float op))
    in
    ConstructV ("BINOP", [ singleton ty; op ])
  | Ast.Test op ->
    let (ty, op) = (
      match op with
      | Values.I32 op -> ("I32", al_of_testop_int op)
      | Values.I64 op -> ("I64", al_of_testop_int op)
      | _ -> .)
    in
    ConstructV ("TESTOP", [ singleton ty; op ])
  | Ast.Compare op ->
    let (ty, op) = (
      match op with
      | Values.I32 op -> ("I32", al_of_relop_int op)
      | Values.I64 op -> ("I64", al_of_relop_int op)
      | Values.F32 op -> ("F32", al_of_relop_float op)
      | Values.F64 op -> ("F64", al_of_relop_float op))
    in
    ConstructV ("RELOP", [ singleton ty; op ])
  | Ast.Convert op ->
    let (ty_to, (op, ty_from, sx_opt)) = (
      match op with
      | Values.I32 op -> ("I32", al_of_cvtop_int "32" op)
      | Values.I64 op -> ("I64", al_of_cvtop_int "64" op)
      | Values.F32 op -> ("F32", al_of_cvtop_float "32" op)
      | Values.F64 op -> ("F64", al_of_cvtop_float "64" op))
    in
    ConstructV ("CVTOP", [ singleton ty_to; StringV op; singleton ty_from; OptV sx_opt ])
  | Ast.RefIsNull -> f "REF.IS_NULL"
  | Ast.RefFunc i32 -> f_i32 "REF.FUNC" i32
  | Ast.Select None -> ConstructV ("SELECT", [ OptV None ])
  | Ast.Select (Some [t]) -> ConstructV ("SELECT", [ OptV (Some (al_of_type t)) ])
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
  | Ast.TableCopy (i32, i32') -> f_i32_i32 "TABLE.COPY" i32 i32'
  | Ast.TableInit (i32, i32') -> f_i32_i32 "TABLE.INIT" i32 i32'
  | Ast.ElemDrop i32 -> f_i32 "ELEM.DROP" i32
  | Ast.Call i32 -> f_i32 "CALL" i32
  | Ast.CallIndirect (i32, i32') ->
      ConstructV
        ("CALL_INDIRECT", [
            to_int i32;
            al_of_typeidx types i32'])
  | Ast.Block (bt, instrs) ->
      ConstructV
        ("BLOCK", [
            al_of_blocktype types bt;
            listV (instrs |> al_of_instrs types)])
  | Ast.Loop (bt, instrs) ->
      ConstructV
        ("LOOP", [
            al_of_blocktype types bt;
            listV (instrs |> al_of_instrs types)])
  | Ast.If (bt, instrs1, instrs2) ->
      ConstructV
        ("IF", [
            al_of_blocktype types bt;
            listV (instrs1 |> al_of_instrs types);
            listV (instrs2 |> al_of_instrs types);
            ])
  | Ast.Br i32 -> f_i32 "BR" i32
  | Ast.BrIf i32 -> f_i32 "BR_IF" i32
  | Ast.BrTable (i32s, i32) ->
      ConstructV
        ("BR_TABLE", [ listV (i32s |> List.map to_int); to_int i32 ])
  | Ast.Return -> f "RETURN"
  | Ast.Load {ty = ty; align = align; offset = offset; pack = pack} ->
      ConstructV
        ("LOAD", [
            al_of_type (Types.NumType ty);
            OptV (Option.map al_of_packsize_with_extension pack);
            NumV (Int64.of_int align);
            NumV (int64_of_int32_u offset) ])
  | Ast.Store {ty = ty; align = align; offset = offset; pack = pack} ->
      ConstructV
        ("STORE", [
            al_of_type (Types.NumType ty);
            OptV (Option.map al_of_packsize pack);
            NumV (Int64.of_int align);
            NumV (int64_of_int32_u offset) ])
  | Ast.MemorySize -> f "MEMORY.SIZE"
  | Ast.MemoryGrow -> f "MEMORY.GROW"
  | Ast.MemoryFill -> f "MEMORY.FILL"
  | Ast.MemoryCopy -> f "MEMORY.COPY"
  | Ast.MemoryInit i32 -> f_i32 "MEMORY.INIT" i32
  | Ast.DataDrop i32 -> f_i32 "DATA.DROP" i32
  | _ -> ConstructV ("Untranslated al", [])

and al_of_instrs types winstrs = List.map (al_of_instr types) winstrs



(* Construct module *)

let it phrase = phrase.it

let al_of_func wasm_module wasm_func =

  (* Get function type from module *)
  (* Note: function type will be placed in function in DSL *)
  let wasm_types = wasm_module.it.Ast.types in
  let Types.FuncType (wtl1, wtl2) =
    Int32.to_int wasm_func.it.Ast.ftype.it
    |> List.nth wasm_types
    |> it
  in

  (* Construct function type *)
  let ftype =
    let al_tl1 = List.map al_of_type wtl1 in
    let al_tl2 = List.map al_of_type wtl2 in
    ArrowV (listV al_tl1, listV al_tl2) in

  (* Construct locals *)
  let locals = List.map al_of_type wasm_func.it.Ast.locals in

  (* Construct code *)
  let code = al_of_instrs wasm_module.it.types wasm_func.it.Ast.body in

  (* Construct func *)
  ConstructV ("FUNC", [ftype; listV locals; listV code])

let al_of_global wasm_global =
  let expr = al_of_instrs [] wasm_global.it.Ast.ginit.it in

  ConstructV ("GLOBAL", [ StringV "Yet: global type"; listV expr ])

let al_of_limits limits =
  let f opt = NumV (int64_of_int32_u opt) in
  PairV (NumV (int64_of_int32_u limits.Types.min), OptV (Option.map f limits.Types.max))

let al_of_table wasm_table =
  let Types.TableType (limits, ref_ty) = wasm_table.it.Ast.ttype in
  let pair = al_of_limits limits in

  ConstructV ("TABLE", [ pair; al_of_type (RefType ref_ty) ])

let al_of_memory wasm_memory =
  let Types.MemoryType (limits) = wasm_memory.it.Ast.mtype in
  let pair = al_of_limits limits in

  ConstructV ("MEMORY", [ pair ])

let al_of_segment wasm_segment active_name = match wasm_segment.it with
  | Ast.Passive -> OptV None
  | Ast.Active { index = index; offset = offset } ->
      OptV (
        Some (
          ConstructV (
            active_name,
            [
              NumV (int64_of_int32_u index.it);
              listV (al_of_instrs [] offset.it)
            ]
          )
        )
      )
  | Ast.Declarative -> OptV (Some (singleton "DECLARE"))

let al_of_elem_segment wasm_segment = al_of_segment wasm_segment "TABLE"

let al_of_elem wasm_elem =
  let reftype = al_of_type (Types.RefType wasm_elem.it.Ast.etype) in

  let al_of_const const = listV (al_of_instrs [] const.it) in
  let instrs = wasm_elem.it.Ast.einit |> List.map al_of_const in

  let mode = al_of_elem_segment wasm_elem.it.Ast.emode in

  ConstructV ("ELEM", [ reftype; listV instrs; mode ])

let al_of_data_segment wasm_segment = al_of_segment wasm_segment "MEMORY"

let al_of_data wasm_data =
  (* TODO: byte list list *)
  let init = wasm_data.it.Ast.dinit in

  let f chr acc = NumV (Int64.of_int (Char.code chr)) :: acc in
  let byte_list = String.fold_right f init [] in

  let mode = al_of_data_segment wasm_data.it.Ast.dmode in

  ConstructV ("DATA", [ listV byte_list; mode ])

let al_of_import_desc wasm_module import_desc = match import_desc.it with
  | Ast.FuncImport v ->

      (* Get function type from module *)
      (* Note: function type will be placed in function in DSL *)
      let wasm_types = wasm_module.it.Ast.types in
      let Types.FuncType (wtl1, wtl2) =
        Int32.to_int v.it
        |> List.nth wasm_types
        |> it
      in

      (* Construct function type *)
      let ftype =
        let al_tl1 = List.map al_of_type wtl1 in
        let al_tl2 = List.map al_of_type wtl2 in
        ArrowV (listV al_tl1, listV al_tl2)
      in

      ConstructV ("FUNC", [ ftype ])
  | Ast.TableImport ty ->
    let Types.TableType (limits, ref_ty) = ty in
    let pair = al_of_limits limits in
    ConstructV ("TABLE", [ pair; al_of_type (RefType ref_ty) ])
  | Ast.MemoryImport ty ->
    let Types.MemoryType (limits) = ty in
    let pair = al_of_limits limits in
    ConstructV ("MEM", [ pair ])
  | Ast.GlobalImport _ -> ConstructV ("GLOBAL", [ StringV "Yet: global type" ])

let al_of_import wasm_module wasm_import =

  let module_name = StringV (wasm_import.it.Ast.module_name |> Ast.string_of_name) in
  let item_name = StringV (wasm_import.it.Ast.item_name |> Ast.string_of_name) in
  let import_desc = al_of_import_desc wasm_module wasm_import.it.Ast.idesc in

  ConstructV ("IMPORT", [ module_name; item_name; import_desc ])

let al_of_export_desc export_desc = match export_desc.it with
  | Ast.FuncExport n -> ConstructV ("FUNC", [ NumV (int64_of_int32_u n.it) ])
  | Ast.TableExport n -> ConstructV ("TABLE", [ NumV (int64_of_int32_u n.it) ])
  | Ast.MemoryExport n -> ConstructV ("MEM", [ NumV (int64_of_int32_u n.it) ])
  | Ast.GlobalExport n -> ConstructV ("GLOBAL", [ NumV (int64_of_int32_u n.it) ])

let al_of_start wasm_start =
  ConstructV ("START", [ NumV (int64_of_int32_u wasm_start.it.Ast.sfunc.it) ])

let al_of_export wasm_export =

  let name = StringV (wasm_export.it.Ast.name |> Ast.string_of_name) in
  let export_desc = al_of_export_desc wasm_export.it.Ast.edesc in

  ConstructV ("EXPORT", [ name; export_desc ])

let al_of_module wasm_module =

  (* Construct imports *)
  let import_list =
    List.map (al_of_import wasm_module) wasm_module.it.imports
  in

  (* Construct functions *)
  let func_list =
    List.map (al_of_func wasm_module) wasm_module.it.funcs
  in

  (* Construct global *)
  let global_list =
    List.map al_of_global wasm_module.it.globals
  in

  (* Construct table *)
  let table_list =
    List.map al_of_table wasm_module.it.tables
  in

  (* Construct memory *)
  let memory_list =
    List.map al_of_memory wasm_module.it.memories
  in

  (* Construct elem *)
  let elem_list =
    List.map al_of_elem wasm_module.it.elems
  in

  (* Construct data *)
  let data_list =
    List.map al_of_data wasm_module.it.datas
  in

  (* Construct start *)
  let start_opt =
    Option.map al_of_start wasm_module.it.start
  in

  (* Construct export *)
  let export_list =
    List.map al_of_export wasm_module.it.exports
  in

  (* print_endline "";
  Print.string_of_value (listV import_list) |> print_endline;
  Print.string_of_value (listV func_list) |> print_endline;
  Print.string_of_value (listV global_list) |> print_endline;
  Print.string_of_value (listV table_list) |> print_endline;
  Print.string_of_value (listV memory_list) |> print_endline;
  Print.string_of_value (listV elem_list) |> print_endline;
  Print.string_of_value (listV data_list) |> print_endline;
  Print.string_of_value (listV export_list) |> print_endline;*)

  ConstructV (
    "MODULE",
    [
      listV import_list;
      listV func_list;
      listV global_list;
      listV table_list;
      listV memory_list;
      listV elem_list;
      listV data_list;
      OptV  start_opt;
      listV export_list
    ]
  )
