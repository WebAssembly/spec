open Al.Ast
open Reference_interpreter
open Source
open Util.Record


(* Smart Constructor *)

let _nid_count = ref 0
let gen_nid () =
  let nid = !_nid_count in
  _nid_count := nid + 1;
  nid

let (%) it nid = { it; nid }
let ($) (instr: instr) it = { instr with it }
let update_node f (node: 'a node) = f node.it % node.nid

let ifI (c, il1, il2) = IfI (c, il1, il2) % gen_nid ()
let eitherI (il1, il2) = EitherI (il1, il2) % gen_nid ()
let enterI (e1, e2, il) = EnterI (e1, e2, il) % gen_nid ()
let assertI c = AssertI c % gen_nid ()
let pushI e = PushI e % gen_nid ()
let popI e = PopI e % gen_nid ()
let popallI e = PopAllI e % gen_nid ()
let letI (e1, e2) = LetI (e1, e2) % gen_nid ()
let trapI = TrapI % gen_nid ()
let nopI = NopI % gen_nid ()
let returnI e_opt = ReturnI e_opt % gen_nid ()
let executeI e = ExecuteI e % gen_nid ()
let executeseqI e = ExecuteSeqI e % gen_nid ()
let performI (id, el) = PerformI (id, el) % gen_nid ()
let exitI = ExitI % gen_nid ()
let replaceI (e1, p, e2) = ReplaceI (e1, p, e2) % gen_nid ()
let appendI (e1, e2) = AppendI (e1, e2) % gen_nid ()
let otherwiseI il = OtherwiseI il % gen_nid ()
let yetI s = YetI s % gen_nid ()

let singleton x = CaseV (x, [])
let listV l = ListV (l |> Array.of_list |> ref)
let id str = VarE str 

let get_name = function
  | RuleA ((name, _), _, _) -> name
  | FuncA (name, _, _) -> name

let get_param = function
  | RuleA (_, params, _) -> params
  | FuncA (_, params, _) -> params

let get_body = function
  | RuleA (_, _, body) -> body
  | FuncA (_, _, body) -> body

(* Construct types *)

let al_of_null = function
  | Types.NoNull -> CaseV ("NULL", [ OptV None ])
  | Types.Null -> CaseV ("NULL", [ OptV (Some (listV [])) ])

let al_of_final = function
  | Types.NoFinal -> OptV None
  | Types.Final -> OptV (Some (singleton "FINAL"))

let al_of_mut = function
  | Types.Cons -> OptV None
  | Types.Var -> OptV (Some (singleton "MUT"))

let rec al_of_storage_type = function
  | Types.ValStorageT vt -> al_of_val_type vt
  | Types.PackStorageT ps ->
    (Pack.packed_size ps * 8)
    |> string_of_int
    |> Printf.sprintf "I%s"
    |> singleton

and al_of_field_type = function
  | Types.FieldT (mut, st) ->
    TupV (al_of_mut mut, al_of_storage_type st)

and al_of_result_type rt = List.map al_of_val_type rt |> listV

and al_of_str_type = function
  | Types.DefStructT (StructT ftl) ->
    let al_ftl = List.map al_of_field_type ftl |> listV in
    CaseV ("STRUCT", [ al_ftl ])
  | Types.DefArrayT (ArrayT ft) ->
    CaseV ("ARRAY", [ al_of_field_type ft ])
  | Types.DefFuncT (FuncT (rt1, rt2)) ->
    CaseV ("FUNC", [ ArrowV (
      al_of_result_type rt1,
      al_of_result_type rt2
    )])

and al_of_sub_type = function
  | Types.SubT (fin, htl, st) ->
    CaseV ("SUBD", [
      al_of_final fin;
      List.map al_of_heap_type htl |> listV;
      al_of_str_type st
    ])

and al_of_rec_type = function
  | Types.RecT stl ->
    let al_stl = List.map al_of_sub_type stl |> listV in
    CaseV ("REC", [ al_stl ])

and al_of_def_type = function
  | Types.DefT (rt, i) ->
    CaseV ("DEF", [al_of_rec_type rt; NumV (Int64.of_int32 i)])

and al_of_heap_type = function
  | Types.VarHT (StatX i) ->
    CaseV ("_IDX", [ NumV (Int64.of_int32 i) ])
  | Types.VarHT (RecX i) ->
    CaseV ("REC", [ NumV (Int64.of_int32 i) ])
  | Types.DefHT dt -> al_of_def_type dt
  | Types.BotHT -> singleton "BOT"
  | ht ->
    Types.string_of_heap_type ht
    |> String.uppercase_ascii
    |> singleton

and al_of_ref_type (null, ht) =
  CaseV ("REF", [ al_of_null null; al_of_heap_type ht ])

and al_of_val_type = function
  | Types.RefT rt -> al_of_ref_type rt
  | vt ->
    Types.string_of_val_type vt
    |> String.uppercase_ascii
    |> singleton

(* Construct value *)

let int64_of_int32_u x = x |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let al_of_num n =
  let t, v = match n with
    | Value.I32 i -> "I32", i |> I32.to_bits |> int64_of_int32_u
    | Value.I64 i -> "I64", i |> I64.to_bits
    | Value.F32 f -> "F32", f |> F32.to_bits |> int64_of_int32_u
    | Value.F64 f -> "F64", f |> F64.to_bits in
  let t, v = CaseV(t, []), NumV v in
  CaseV ("CONST", [ t; v ])

let rec al_of_ref = function
  | Value.NullRef ht ->
    CaseV ("REF.NULL", [ al_of_heap_type ht ])
  (*
  | I31.I31Ref i ->
    CaseV ("REF.I31_NUM", [ NumV (Int64.of_int i) ])
  | Aggr.StructRef a ->
    CaseV ("REF.STRUCT_ADDR", [ NumV (int64_of_int32_u a) ])
  | Aggr.ArrayRef a ->
    CaseV ("REF.ARRAY_ADDR", [ NumV (int64_of_int32_u a) ])
  | Instance.FuncRef a ->
    CaseV ("REF.FUNC_ADDR", [ NumV (int64_of_int32_u a) ])
  *)
  | Script.HostRef a ->
    CaseV ("REF.HOST_ADDR", [ NumV (int64_of_int32_u a) ])
  | Extern.ExternRef r ->
    CaseV ("REF.EXTERN", [ al_of_ref r ])
  | r -> Value.string_of_ref r |> failwith

let al_of_value = function
  | Value.Num n -> al_of_num n
  | Value.Vec _v -> failwith "TODO"
  | Value.Ref r -> al_of_ref r

(* Construct type *)

let al_of_blocktype = function
| Ast.VarBlockType idx -> CaseV ("_IDX", [ NumV (Int64.of_int32 idx.it) ])
| Ast.ValBlockType None -> CaseV ("_RESULT", [ OptV None ])
| Ast.ValBlockType (Some val_type) -> CaseV ("_RESULT", [ OptV (Some (al_of_val_type val_type)) ])


(* Construct instruction *)

let al_of_unop_int = function
  | Ast.IntOp.Clz -> TextV "Clz"
  | Ast.IntOp.Ctz -> TextV "Ctz"
  | Ast.IntOp.Popcnt -> TextV "Popcnt"
  | Ast.IntOp.ExtendS Pack.Pack8 -> TextV "Extend8S"
  | Ast.IntOp.ExtendS Pack.Pack16 -> TextV "Extend16S"
  | Ast.IntOp.ExtendS Pack.Pack32 -> TextV "Extend32S"
  | Ast.IntOp.ExtendS Pack.Pack64 -> TextV "Extend64S"
let al_of_unop_float = function
  | Ast.FloatOp.Neg -> TextV "Neg"
  | Ast.FloatOp.Abs -> TextV "Abs"
  | Ast.FloatOp.Ceil -> TextV "Ceil"
  | Ast.FloatOp.Floor -> TextV "Floor"
  | Ast.FloatOp.Trunc -> TextV "Trunc"
  | Ast.FloatOp.Nearest -> TextV "Nearest"
  | Ast.FloatOp.Sqrt -> TextV "Sqrt"

let al_of_binop_int = function
  | Ast.IntOp.Add -> TextV "Add"
  | Ast.IntOp.Sub -> TextV "Sub"
  | Ast.IntOp.Mul -> TextV "Mul"
  | Ast.IntOp.DivS -> TextV "DivS"
  | Ast.IntOp.DivU -> TextV "DivU"
  | Ast.IntOp.RemS -> TextV "RemS"
  | Ast.IntOp.RemU -> TextV "RemU"
  | Ast.IntOp.And -> TextV "And"
  | Ast.IntOp.Or -> TextV "Or"
  | Ast.IntOp.Xor -> TextV "Xor"
  | Ast.IntOp.Shl -> TextV "Shl"
  | Ast.IntOp.ShrS -> TextV "ShrS"
  | Ast.IntOp.ShrU -> TextV "ShrU"
  | Ast.IntOp.Rotl -> TextV "Rotl"
  | Ast.IntOp.Rotr -> TextV "Rotr"
let al_of_binop_float = function
  | Ast.FloatOp.Add -> TextV "Add"
  | Ast.FloatOp.Sub -> TextV "Sub"
  | Ast.FloatOp.Mul -> TextV "Mul"
  | Ast.FloatOp.Div -> TextV "Div"
  | Ast.FloatOp.Min -> TextV "Min"
  | Ast.FloatOp.Max -> TextV "Max"
  | Ast.FloatOp.CopySign -> TextV "CopySign"

let al_of_testop_int = function
  | Ast.IntOp.Eqz -> TextV "Eqz"

let al_of_relop_int = function
  | Ast.IntOp.Eq -> TextV "Eq"
  | Ast.IntOp.Ne -> TextV "Ne"
  | Ast.IntOp.LtS -> TextV "LtS"
  | Ast.IntOp.LtU -> TextV "LtU"
  | Ast.IntOp.GtS -> TextV "GtS"
  | Ast.IntOp.GtU -> TextV "GtU"
  | Ast.IntOp.LeS -> TextV "LeS"
  | Ast.IntOp.LeU -> TextV "LeU"
  | Ast.IntOp.GeS -> TextV "GeS"
  | Ast.IntOp.GeU -> TextV "GeU"
let al_of_relop_float = function
  | Ast.FloatOp.Eq -> TextV "Eq"
  | Ast.FloatOp.Ne -> TextV "Ne"
  | Ast.FloatOp.Lt -> TextV "Lt"
  | Ast.FloatOp.Gt -> TextV "Gt"
  | Ast.FloatOp.Le -> TextV "Le"
  | Ast.FloatOp.Ge -> TextV "Ge"

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
    | Pack.Pack8 -> 8
    | Pack.Pack16 -> 16
    | Pack.Pack32 -> 32
    | Pack.Pack64 -> 64
  in
  NumV (Int64.of_int s)

let al_of_extension = function
| Pack.SX -> singleton "S"
| Pack.ZX -> singleton "U"

let al_of_packsize_with_extension (p, s) =
  listV [ al_of_packsize p; al_of_extension s ]


let rec al_of_instr winstr =
  let to_int i32 = NumV (int64_of_int32_u i32.it) in
  let f name  = CaseV (name, []) in
  let f_v name v = CaseV (name, [v]) in
  let f_i32 name i32 = CaseV (name, [to_int i32]) in
  let f_i32_i32 name i32 i32' = CaseV (name, [to_int i32; to_int i32']) in

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> al_of_num num.it
  | Ast.RefNull t -> al_of_value (Value.Ref (Value.NullRef t))
  (* wasm instructions *)
  | Ast.Unreachable -> f "UNREACHABLE"
  | Ast.Nop -> f "NOP"
  | Ast.Drop -> f "DROP"
  | Ast.Unary op ->
    let (ty, op) = (
      match op with
      | Value.I32 op -> ("I32", al_of_unop_int op)
      | Value.I64 op -> ("I64", al_of_unop_int op)
      | Value.F32 op -> ("F32", al_of_unop_float op)
      | Value.F64 op -> ("F64", al_of_unop_float op))
    in
    CaseV ("UNOP", [ singleton ty; op ])
  | Ast.Binary op ->
    let (ty, op) = (
      match op with
      | Value.I32 op -> ("I32", al_of_binop_int op)
      | Value.I64 op -> ("I64", al_of_binop_int op)
      | Value.F32 op -> ("F32", al_of_binop_float op)
      | Value.F64 op -> ("F64", al_of_binop_float op))
    in
    CaseV ("BINOP", [ singleton ty; op ])
  | Ast.Test op ->
    let (ty, op) = (
      match op with
      | Value.I32 op -> ("I32", al_of_testop_int op)
      | Value.I64 op -> ("I64", al_of_testop_int op)
      | _ -> .)
    in
    CaseV ("TESTOP", [ singleton ty; op ])
  | Ast.Compare op ->
    let (ty, op) = (
      match op with
      | Value.I32 op -> ("I32", al_of_relop_int op)
      | Value.I64 op -> ("I64", al_of_relop_int op)
      | Value.F32 op -> ("F32", al_of_relop_float op)
      | Value.F64 op -> ("F64", al_of_relop_float op))
    in
    CaseV ("RELOP", [ singleton ty; op ])
  | Ast.Convert op ->
    let (ty_to, (op, ty_from, sx_opt)) = (
      match op with
      | Value.I32 op -> ("I32", al_of_cvtop_int "32" op)
      | Value.I64 op -> ("I64", al_of_cvtop_int "64" op)
      | Value.F32 op -> ("F32", al_of_cvtop_float "32" op)
      | Value.F64 op -> ("F64", al_of_cvtop_float "64" op))
    in
    CaseV ("CVTOP", [ singleton ty_to; TextV op; singleton ty_from; OptV sx_opt ])
  | Ast.RefIsNull -> f "REF.IS_NULL"
  | Ast.RefFunc i32 -> f_i32 "REF.FUNC" i32
  | Ast.Select None -> CaseV ("SELECT", [ OptV None ])
  | Ast.Select (Some ts) -> CaseV ("SELECT", [ OptV (Some (listV (List.map al_of_val_type ts))) ])
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
  | Ast.Block (bt, instrs) ->
      CaseV
        ("BLOCK", [
            al_of_blocktype bt;
            listV (instrs |> al_of_instrs)])
  | Ast.Loop (bt, instrs) ->
      CaseV
        ("LOOP", [
            al_of_blocktype bt;
            listV (instrs |> al_of_instrs)])
  | Ast.If (bt, instrs1, instrs2) ->
      CaseV
        ("IF", [
            al_of_blocktype bt;
            listV (instrs1 |> al_of_instrs);
            listV (instrs2 |> al_of_instrs);
            ])
  | Ast.Br i32 -> f_i32 "BR" i32
  | Ast.BrIf i32 -> f_i32 "BR_IF" i32
  | Ast.BrTable (i32s, i32) ->
      CaseV
        ("BR_TABLE", [ listV (i32s |> List.map to_int); to_int i32 ])
  | Ast.BrOnNull i32 -> f_i32 "BR_ON_NULL" i32
  | Ast.BrOnNonNull i32 -> f_i32 "BR_ON_NON_NULL" i32
  | Ast.BrOnCast (i32, rt1, rt2) ->
      CaseV
        ("BR_ON_CAST", [
            to_int i32;
            al_of_ref_type rt1;
            al_of_ref_type rt2;
            ])
  | Ast.BrOnCastFail (i32, rt1, rt2) ->
      CaseV
        ("BR_ON_CAST_FAIL", [
            to_int i32;
            al_of_ref_type rt1;
            al_of_ref_type rt2;
            ])
  | Ast.Return -> f "RETURN"
  | Ast.Call i32 -> f_i32 "CALL" i32
  | Ast.CallRef i32 -> f_v "CALL_REF" (OptV (Some (to_int i32)))
  | Ast.CallIndirect (i32, i32') -> f_i32_i32 "CALL_INDIRECT" i32 i32'
  | Ast.ReturnCall i32 -> f_i32 "RETURN_CALL"i32
  | Ast.ReturnCallRef i32 -> f_v "RETURN_CALL_REF" (OptV (Some (to_int i32)))
  | Ast.ReturnCallIndirect (i32, i32') -> f_i32_i32 "RETURN_CALL_INDIRECT" i32 i32'
  | Ast.Load {ty = ty; align = align; offset = offset; pack = pack} ->
      CaseV
        ("LOAD", [
            al_of_val_type (Types.NumT ty);
            OptV (Option.map al_of_packsize_with_extension pack);
            NumV 0L;
            StrV (Record.empty
              |> Record.add "ALIGN" (NumV (Int64.of_int align))
              |> Record.add "OFFSET" (NumV (int64_of_int32_u offset))
            )
        ])
  | Ast.Store {ty = ty; align = align; offset = offset; pack = pack} ->
      CaseV
        ("STORE", [
            al_of_val_type (Types.NumT ty);
            OptV (Option.map al_of_packsize pack);
            NumV 0L;
            StrV (Record.empty
              |> Record.add "ALIGN" (NumV (Int64.of_int align))
              |> Record.add "OFFSET" (NumV (int64_of_int32_u offset))
            )
        ])
  | Ast.MemorySize -> CaseV ("MEMORY.SIZE", [ NumV 0L ])
  | Ast.MemoryGrow -> CaseV ("MEMORY.GROW", [ NumV 0L ])
  | Ast.MemoryFill -> CaseV ("MEMORY.FILL", [ NumV 0L ])
  | Ast.MemoryCopy -> CaseV ("MEMORY.COPY", [ NumV 0L; NumV 0L ])
  | Ast.MemoryInit i32 ->
    CaseV ("MEMORY.INIT", [ NumV 0L; to_int i32 ])
  | Ast.DataDrop i32 -> f_i32 "DATA.DROP" i32
  | Ast.RefAsNonNull -> f "REF.AS_NON_NULL"
  | Ast.RefTest rt -> CaseV ("REF.TEST", [ al_of_ref_type rt ])
  | Ast.RefCast rt -> CaseV ("REF.CAST", [ al_of_ref_type rt ])
  | Ast.RefEq -> f "REF.EQ"
  | Ast.RefI31 -> f "REF.I31"
  | Ast.I31Get sx -> CaseV ("I31.GET", [ al_of_extension sx ])
  | Ast.StructNew (i32, Ast.Explicit) -> f_i32 "STRUCT.NEW" i32
  | Ast.StructNew (i32, Ast.Implicit) -> f_i32 "STRUCT.NEW_DEFAULT" i32
  | Ast.StructGet (i32, i32', sx_opt) ->
      CaseV ("STRUCT.GET", [
        OptV (Option.map al_of_extension sx_opt);
        to_int i32;
        to_int i32'
      ])
  | Ast.StructSet (i32, i32') -> f_i32_i32 "STRUCT.SET" i32 i32'
  | Ast.ArrayNew (i32, Ast.Explicit) -> f_i32 "ARRAY.NEW" i32
  | Ast.ArrayNew (i32, Ast.Implicit) -> f_i32 "ARRAY.NEW_DEFAULT" i32
  | Ast.ArrayNewFixed (i32, n) -> CaseV ("ARRAY.NEW_FIXED", [ to_int i32; NumV (int64_of_int32_u n) ])
  | Ast.ArrayNewElem (i32, i32') -> f_i32_i32 "ARRAY.NEW_ELEM" i32 i32'
  | Ast.ArrayNewData (i32, i32') -> f_i32_i32 "ARRAY.NEW_DATA" i32 i32'
  | Ast.ArrayGet (i32, sx_opt) ->
      CaseV
        ("ARRAY.GET", [
            OptV (Option.map al_of_extension sx_opt);
            to_int i32
        ])
  | Ast.ArraySet i32 -> f_i32 "ARRAY.SET" i32
  | Ast.ArrayLen -> f "ARRAY.LEN"
  | Ast.ArrayCopy (i32, i32') -> f_i32_i32 "ARRAY.COPY" i32 i32'
  | Ast.ArrayFill i32 -> f_i32 "ARRAY.FILL" i32
  | Ast.ArrayInitData (i32, i32') -> f_i32_i32 "ARRAY.INIT_DATA" i32 i32'
  | Ast.ArrayInitElem (i32, i32') -> f_i32_i32 "ARRAY.INIT_ELEM" i32 i32'
  | Ast.ExternConvert Ast.Internalize -> f "ANY.CONVERT_EXTERN"
  | Ast.ExternConvert Ast.Externalize -> f "EXTERN.CONVERT_ANY"
  | _ -> CaseV ("TODO: Unconstructed Wasm instruction (al_of_instr)", [])

and al_of_instrs winstrs = List.map al_of_instr winstrs



(* Construct module *)

let it phrase = phrase.it

let al_of_func wasm_func =

  let ftype =
    NumV (Int64.of_int32 wasm_func.it.Ast.ftype.it)
  in

  (* Construct locals *)
  let locals =
    List.map
      (fun l ->
        CaseV ("LOCAL", [ al_of_val_type l.it.Ast.ltype ]))
      wasm_func.it.Ast.locals
  in

  (* Construct code *)
  let code = al_of_instrs wasm_func.it.Ast.body in

  (* Construct func *)
  CaseV ("FUNC", [ftype; listV locals; listV code])

let al_of_global wasm_global =
  let expr = al_of_instrs wasm_global.it.Ast.ginit.it in

  CaseV ("GLOBAL", [ TextV "Yet: global type"; listV expr ])

let al_of_limits limits max =
  let max =
    match limits.Types.max with
    | Some v -> int64_of_int32_u v
    | None -> max
  in

  TupV (NumV (int64_of_int32_u limits.Types.min), NumV max)

let al_of_table wasm_table =

  let Types.TableT (limits, ref_ty) = wasm_table.it.Ast.ttype in
  let pair = al_of_limits limits 4294967295L in

  let expr = al_of_instrs wasm_table.it.Ast.tinit.it in

  CaseV ("TABLE", [ TupV(pair, al_of_val_type (RefT ref_ty)); listV expr ])

let al_of_memory wasm_memory =
  let Types.MemoryT (limits) = wasm_memory.it.Ast.mtype in
  let pair = al_of_limits limits 65536L in

  CaseV ("MEMORY", [ CaseV ("I8", [ pair]) ])

let al_of_segment wasm_segment = match wasm_segment.it with
  | Ast.Passive -> singleton "PASSIVE"
  | Ast.Active { index = index; offset = offset } ->
      CaseV (
        "ACTIVE",
        [
          NumV (int64_of_int32_u index.it);
          listV (al_of_instrs offset.it)
        ]
      )
  | Ast.Declarative -> singleton "DECLARE"

let al_of_elem wasm_elem =
  let reftype = al_of_val_type (Types.RefT wasm_elem.it.Ast.etype) in

  let al_of_const const = listV (al_of_instrs const.it) in
  let instrs = wasm_elem.it.Ast.einit |> List.map al_of_const in

  let mode = al_of_segment wasm_elem.it.Ast.emode in

  CaseV ("ELEM", [ reftype; listV instrs; mode ])

let al_of_data wasm_data =
  (* TODO: byte list list *)
  let init = wasm_data.it.Ast.dinit in

  let f chr acc = NumV (Int64.of_int (Char.code chr)) :: acc in
  let byte_list = String.fold_right f init [] in

  let mode = al_of_segment wasm_data.it.Ast.dmode in

  CaseV ("DATA", [ listV byte_list; mode ])

let al_of_import_desc wasm_module idesc = match idesc.it with
  | Ast.FuncImport x ->
      let dts = Ast.def_types_of wasm_module in
      let dt = Lib.List32.nth dts x.it |> al_of_def_type in
      CaseV ("FUNC", [ dt ])
  | Ast.TableImport ty ->
    let Types.TableT (limits, ref_ty) = ty in
    let pair = al_of_limits limits 4294967295L in
    CaseV ("TABLE", [ pair; al_of_val_type (RefT ref_ty) ])
  | Ast.MemoryImport ty ->
    let Types.MemoryT (limits) = ty in
    let pair = al_of_limits limits 65536L in
    CaseV ("MEM", [ pair ])
  | Ast.GlobalImport _ -> CaseV ("GLOBAL", [ TextV "Yet: global type" ])

let al_of_import wasm_module wasm_import =

  let module_name = TextV (wasm_import.it.Ast.module_name |> Utf8.encode) in
  let item_name = TextV (wasm_import.it.Ast.item_name |> Utf8.encode) in

  let import_desc = al_of_import_desc wasm_module wasm_import.it.Ast.idesc in

  CaseV ("IMPORT", [ module_name; item_name; import_desc ])

let al_of_export_desc export_desc = match export_desc.it with
  | Ast.FuncExport n -> CaseV ("FUNC", [ NumV (int64_of_int32_u n.it) ])
  | Ast.TableExport n -> CaseV ("TABLE", [ NumV (int64_of_int32_u n.it) ])
  | Ast.MemoryExport n -> CaseV ("MEM", [ NumV (int64_of_int32_u n.it) ])
  | Ast.GlobalExport n -> CaseV ("GLOBAL", [ NumV (int64_of_int32_u n.it) ])

let al_of_start wasm_start =
  CaseV ("START", [ NumV (int64_of_int32_u wasm_start.it.Ast.sfunc.it) ])

let al_of_export wasm_export =

  let name = TextV (wasm_export.it.Ast.name |> Utf8.encode) in
  let export_desc = al_of_export_desc wasm_export.it.Ast.edesc in

  CaseV ("EXPORT", [ name; export_desc ])

let al_of_module wasm_module =

  (* Construct types *)
  let type_list =
    List.map (fun ty ->
      CaseV ("TYPE", [ al_of_rec_type ty.it ])
    ) wasm_module.it.Ast.types
  in

  (* Construct imports *)
  let import_list =
    List.map (al_of_import wasm_module) wasm_module.it.imports
  in

  (* Construct functions *)
  let func_list =
    List.map al_of_func wasm_module.it.funcs
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

  CaseV (
    "MODULE",
    [
      listV type_list;
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

let fail ty v =
  Al.Print.string_of_value v
  |> Printf.sprintf "Invalid %s: %s" ty
  |> failwith

open Types

let al_to_null: value -> null = function
  | CaseV ("NULL", [ OptV None ]) -> NoNull
  | CaseV ("NULL", [ OptV _ ]) -> Null
  | v -> fail "null" v

let al_to_final: value -> final = function
  | OptV None -> NoFinal
  | OptV (Some (CaseV ("FINAL", []))) -> Final
  | v -> fail "final" v

let al_to_mut: value -> mut = function
  | OptV None -> Cons
  | OptV (Some (CaseV ("MUT", []))) -> Var
  | v -> fail "mut" v

let rec al_to_storage_type: value -> storage_type = function
  | CaseV ("I8", []) -> PackStorageT Pack8
  | CaseV ("I16", []) -> PackStorageT Pack16
  | v -> ValStorageT (al_to_val_type v)

and al_to_field_type: value -> field_type = function
  | TupV (mut, st) ->
    FieldT (al_to_mut mut, al_to_storage_type st)
  | v -> fail "field type" v

and al_to_result_type: value -> result_type = function
  | ListV vtl ->
    let vtl' = Array.to_list !vtl in
    List.map al_to_val_type vtl'
  | v -> fail "result type" v

and al_to_str_type: value -> str_type = function
  | CaseV ("STRUCT", [ ListV ftl ]) ->
    let ftl' = Array.to_list !ftl in
    DefStructT (StructT (List.map al_to_field_type ftl'))
  | CaseV ("ARRAY", [ ft ]) ->
    DefArrayT (ArrayT (al_to_field_type ft))
  | CaseV ("FUNC", [ ArrowV (rt1, rt2) ]) ->
    DefFuncT (FuncT (al_to_result_type rt1, (al_to_result_type rt2)))
  | v -> fail "str type" v

and al_to_sub_type: value -> sub_type = function
  | CaseV ("SUBD", [ fin; ListV htl; st ]) ->
    let htl' = Array.to_list !htl in
    SubT (
      al_to_final fin,
      List.map al_to_heap_type htl',
      al_to_str_type st
    )
  | v -> fail "sub type" v

and al_to_rec_type: value -> rec_type = function
  | CaseV ("REC", [ ListV stl ]) ->
    let stl' = Array.to_list !stl in
    RecT (List.map al_to_sub_type stl')
  | v -> fail "rec type" v

and al_to_def_type: value -> def_type = function
  | CaseV ("DEF", [ rt; NumV i ]) ->
    DefT (al_to_rec_type rt, Int64.to_int32 i)
  | v -> fail "def type" v

and al_to_heap_type: value -> heap_type = function
  | CaseV ("_IDX", [ NumV i ]) ->
    VarHT (StatX (Int64.to_int32 i))
  | CaseV ("REC", [ NumV i ]) ->
    VarHT (RecX (Int64.to_int32 i))
  | CaseV ("DEF", _) as v ->
    DefHT (al_to_def_type v)
  | CaseV (tag, []) as v ->
    begin match tag with
    | "BOT" -> BotHT
    | "ANY" -> AnyHT
    | "NONE" -> NoneHT
    | "EQ" -> EqHT
    | "I31" -> I31HT
    | "STRUCT" -> StructHT
    | "ARRAY" -> ArrayHT
    | "FUNC" -> FuncHT
    | "NOFUNC" -> NoFuncHT
    | "EXTERN" -> ExternHT
    | "NOEXTERN" -> NoExternHT
    | _ -> fail "abstract heap type" v
    end
  | v -> fail "heap type" v

and al_to_ref_type: value -> ref_type = function
  | CaseV ("REF", [ n; ht ]) ->
    al_to_null n, al_to_heap_type ht
  | v -> fail "ref type" v

and al_to_val_type: value -> val_type = function
  | CaseV ("I32", []) -> NumT I32T
  | CaseV ("I64", []) -> NumT I64T
  | CaseV ("F32", []) -> NumT F32T
  | CaseV ("F64", []) -> NumT F64T
  | CaseV ("V128", []) -> VecT V128T
  | CaseV ("REF", _) as v ->
    RefT (al_to_ref_type v)
  | CaseV ("BOT", []) -> BotT
  | v -> fail "val type" v
