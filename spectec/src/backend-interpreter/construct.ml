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

let al_of_int i = NumV (Int64.of_int i)
let int64_of_int32_u i32 = Int64.of_int32 i32 |> Int64.logand 0x0000_0000_ffff_ffffL
let al_of_int32 i32 = NumV (int64_of_int32_u i32)
let al_of_idx (idx: Ast.idx) = al_of_int32 idx.it


(* Construct type *)

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

and al_of_num_type nt =
  Types.string_of_num_type nt
  |> String.uppercase_ascii
  |> singleton

and al_of_vec_type vt =
  Types.string_of_vec_type vt
  |> String.uppercase_ascii
  |> singleton

and al_of_val_type = function
  | Types.RefT rt -> al_of_ref_type rt
  | Types.NumT nt -> al_of_num_type nt
  | Types.VecT vt -> al_of_vec_type vt
  | Types.BotT -> singleton "BOT"

let al_of_blocktype = function
  | Ast.VarBlockType idx -> CaseV ("_IDX", [ NumV (Int64.of_int32 idx.it) ])
  | Ast.ValBlockType None -> CaseV ("_RESULT", [ OptV None ])
  | Ast.ValBlockType (Some val_type) ->
    CaseV ("_RESULT", [ OptV (Some (al_of_val_type val_type)) ])


(* Construct value *)

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


(* Construct operation *)

let al_of_op f1 f2 = function
  | Value.I32 op -> [ singleton "I32"; f1 op ]
  | Value.I64 op -> [ singleton "I64"; f1 op ]
  | Value.F32 op -> [ singleton "F32"; f2 op ]
  | Value.F64 op -> [ singleton "F64"; f2 op ]

let al_of_int_unop = function
  | Ast.IntOp.Clz -> TextV "Clz"
  | Ast.IntOp.Ctz -> TextV "Ctz"
  | Ast.IntOp.Popcnt -> TextV "Popcnt"
  | Ast.IntOp.ExtendS Pack.Pack8 -> TextV "Extend8S"
  | Ast.IntOp.ExtendS Pack.Pack16 -> TextV "Extend16S"
  | Ast.IntOp.ExtendS Pack.Pack32 -> TextV "Extend32S"
  | Ast.IntOp.ExtendS Pack.Pack64 -> TextV "Extend64S"
let al_of_float_unop = function
  | Ast.FloatOp.Neg -> TextV "Neg"
  | Ast.FloatOp.Abs -> TextV "Abs"
  | Ast.FloatOp.Ceil -> TextV "Ceil"
  | Ast.FloatOp.Floor -> TextV "Floor"
  | Ast.FloatOp.Trunc -> TextV "Trunc"
  | Ast.FloatOp.Nearest -> TextV "Nearest"
  | Ast.FloatOp.Sqrt -> TextV "Sqrt"
let al_of_unop = al_of_op al_of_int_unop al_of_float_unop

let al_of_int_binop = function
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
let al_of_float_binop = function
  | Ast.FloatOp.Add -> TextV "Add"
  | Ast.FloatOp.Sub -> TextV "Sub"
  | Ast.FloatOp.Mul -> TextV "Mul"
  | Ast.FloatOp.Div -> TextV "Div"
  | Ast.FloatOp.Min -> TextV "Min"
  | Ast.FloatOp.Max -> TextV "Max"
  | Ast.FloatOp.CopySign -> TextV "CopySign"
let al_of_binop = al_of_op al_of_int_binop al_of_float_binop

let al_of_int_testop = function
  | Ast.IntOp.Eqz -> TextV "Eqz"
let al_of_testop: Ast.testop -> value list = function
  | Value.I32 op -> [ singleton "I32"; al_of_int_testop op ]
  | Value.I64 op -> [ singleton "I64"; al_of_int_testop op ]
  | _ -> .

let al_of_int_relop = function
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
let al_of_float_relop = function
  | Ast.FloatOp.Eq -> TextV "Eq"
  | Ast.FloatOp.Ne -> TextV "Ne"
  | Ast.FloatOp.Lt -> TextV "Lt"
  | Ast.FloatOp.Gt -> TextV "Gt"
  | Ast.FloatOp.Le -> TextV "Le"
  | Ast.FloatOp.Ge -> TextV "Ge"
let al_of_relop = al_of_op al_of_int_relop al_of_float_relop

let al_of_int_cvtop num_bits = function
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
  | Ast.IntOp.ReinterpretFloat -> "Reinterpret", "F" ^ num_bits, None
let al_of_float_cvtop num_bits = function
  | Ast.FloatOp.ConvertSI32 -> "Convert", "I32", Some (singleton ("S"))
  | Ast.FloatOp.ConvertUI32 -> "Convert", "I32", Some (singleton ("U"))
  | Ast.FloatOp.ConvertSI64 -> "Convert", "I64", Some (singleton ("S"))
  | Ast.FloatOp.ConvertUI64 -> "Convert", "I64", Some (singleton ("U"))
  | Ast.FloatOp.PromoteF32 -> "Promote", "F32", None
  | Ast.FloatOp.DemoteF64 -> "Demote", "F64", None
  | Ast.FloatOp.ReinterpretInt -> "Reinterpret", "I" ^ num_bits, None
let al_of_cvtop = function
  | Value.I32 op ->
    let op', to_, sx = al_of_int_cvtop "32" op in
    [ singleton "I32"; TextV op'; singleton to_; OptV sx ]
  | Value.I64 op ->
    let op', to_, sx = al_of_int_cvtop "64" op in
    [ singleton "I64"; TextV op'; singleton to_; OptV sx ]
  | Value.F32 op ->
    let op', to_, sx = al_of_float_cvtop "32" op in
    [ singleton "F32"; TextV op'; singleton to_; OptV sx ]
  | Value.F64 op ->
    let op', to_, sx = al_of_float_cvtop "64" op in
    [ singleton "F64"; TextV op'; singleton to_; OptV sx ]

let al_of_pack_size = function
  | Pack.Pack8 -> NumV (Int64.of_int 8)
  | Pack.Pack16 -> NumV (Int64.of_int 16)
  | Pack.Pack32 -> NumV (Int64.of_int 32)
  | Pack.Pack64 -> NumV (Int64.of_int 64)

let al_of_extension = function
  | Pack.SX -> singleton "S"
  | Pack.ZX -> singleton "U"

let al_of_memop al_of_pack memop =
  let str =
    Record.empty
    |> Record.add "ALIGN" (al_of_int memop.Ast.align)
    |> Record.add "OFFSET" (al_of_int32 memop.Ast.offset)
  in
  [
    al_of_num_type memop.Ast.ty;
    OptV (Option.map al_of_pack memop.Ast.pack);
    NumV 0L;
    StrV str;
  ]

let al_of_pack_size_extension (p, s) = listV [ al_of_pack_size p; al_of_extension s ]

let al_of_loadop = al_of_memop al_of_pack_size_extension

let al_of_storeop = al_of_memop al_of_pack_size


(* Construct instruction *)

let rec al_of_instr winstr =

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> al_of_num num.it
  | Ast.RefNull ht -> CaseV ("REF.NULL", [ al_of_heap_type ht ])
  (* wasm instructions *)
  | Ast.Unreachable -> singleton "UNREACHABLE"
  | Ast.Nop -> singleton "NOP"
  | Ast.Drop -> singleton "DROP"
  | Ast.Unary op -> CaseV ("UNOP", al_of_unop op)
  | Ast.Binary op -> CaseV ("BINOP", al_of_binop op)
  | Ast.Test op -> CaseV ("TESTOP", al_of_testop op)
  | Ast.Compare op -> CaseV ("RELOP", al_of_relop op)
  | Ast.Convert op -> CaseV ("CVTOP", al_of_cvtop op)
  | Ast.RefIsNull -> singleton "REF.IS_NULL"
  | Ast.RefFunc idx -> CaseV ("REF.FUNC", [ al_of_idx idx ])
  | Ast.Select None -> CaseV ("SELECT", [ OptV None ])
  | Ast.Select (Some ts) ->
    CaseV ("SELECT", [ OptV (Some (listV (List.map al_of_val_type ts))) ])
  | Ast.LocalGet idx -> CaseV ("LOCAL.GET", [ al_of_idx idx ])
  | Ast.LocalSet idx -> CaseV ("LOCAL.SET", [ al_of_idx idx ])
  | Ast.LocalTee idx -> CaseV ("LOCAL.TEE", [ al_of_idx idx ])
  | Ast.GlobalGet idx -> CaseV ("GLOBAL.GET", [ al_of_idx idx ])
  | Ast.GlobalSet idx -> CaseV ("GLOBAL.SET", [ al_of_idx idx ])
  | Ast.TableGet idx -> CaseV ("TABLE.GET", [ al_of_idx idx ])
  | Ast.TableSet idx -> CaseV ("TABLE.SET", [ al_of_idx idx ])
  | Ast.TableSize idx -> CaseV ("TABLE.SIZE", [ al_of_idx idx ])
  | Ast.TableGrow idx -> CaseV ("TABLE.GROW", [ al_of_idx idx ])
  | Ast.TableFill idx -> CaseV ("TABLE.FILL", [ al_of_idx idx ])
  | Ast.TableCopy (idx1, idx2) ->
    CaseV ("TABLE.COPY", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.TableInit (idx1, idx2) ->
    CaseV ("TABLE.INIT", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ElemDrop idx -> CaseV ("ELEM.DROP", [ al_of_idx idx ])
  | Ast.Block (bt, instrs) ->
    CaseV ("BLOCK", [ al_of_blocktype bt; listV (al_of_instrs instrs) ])
  | Ast.Loop (bt, instrs) ->
    CaseV ("LOOP", [ al_of_blocktype bt; listV (al_of_instrs instrs) ])
  | Ast.If (bt, instrs1, instrs2) ->
    CaseV ("IF", [
      al_of_blocktype bt;
      listV (al_of_instrs instrs1);
      listV (al_of_instrs instrs2);
    ])
  | Ast.Br idx -> CaseV ("BR", [ al_of_idx idx ])
  | Ast.BrIf idx -> CaseV ("BR_IF", [ al_of_idx idx ])
  | Ast.BrTable (idxs, idx) ->
    CaseV ("BR_TABLE", [ listV (List.map al_of_idx idxs); al_of_idx idx ])
  | Ast.BrOnNull idx -> CaseV ("BR_ON_NULL", [ al_of_idx idx ])
  | Ast.BrOnNonNull idx -> CaseV ("BR_ON_NON_NULL", [ al_of_idx idx ])
  | Ast.BrOnCast (idx, rt1, rt2) ->
    CaseV ("BR_ON_CAST", [ al_of_idx idx; al_of_ref_type rt1; al_of_ref_type rt2 ])
  | Ast.BrOnCastFail (idx, rt1, rt2) ->
    CaseV ("BR_ON_CAST_FAIL", [ al_of_idx idx; al_of_ref_type rt1; al_of_ref_type rt2 ])
  | Ast.Return -> singleton "RETURN"
  | Ast.Call idx -> CaseV ("CALL", [ al_of_idx idx ])
  | Ast.CallRef idx -> CaseV ("CALL_REF", [ OptV (Some (al_of_idx idx)) ])
  | Ast.CallIndirect (idx1, idx2) ->
    CaseV ("CALL_INDIRECT", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ReturnCall idx -> CaseV ("RETURN_CALL", [ al_of_idx idx ])
  | Ast.ReturnCallRef idx -> CaseV ("RETURN_CALL_REF", [ OptV (Some (al_of_idx idx)) ])
  | Ast.ReturnCallIndirect (idx1, idx2) ->
    CaseV ("RETURN_CALL_INDIRECT", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.Load loadop -> CaseV ("LOAD", al_of_loadop loadop)
  | Ast.Store storeop -> CaseV ("STORE", al_of_storeop storeop)
  | Ast.MemorySize -> CaseV ("MEMORY.SIZE", [ NumV 0L ])
  | Ast.MemoryGrow -> CaseV ("MEMORY.GROW", [ NumV 0L ])
  | Ast.MemoryFill -> CaseV ("MEMORY.FILL", [ NumV 0L ])
  | Ast.MemoryCopy -> CaseV ("MEMORY.COPY", [ NumV 0L; NumV 0L ])
  | Ast.MemoryInit i32 -> CaseV ("MEMORY.INIT", [ NumV 0L; al_of_idx i32 ])
  | Ast.DataDrop idx -> CaseV ("DATA.DROP", [ al_of_idx idx ])
  | Ast.RefAsNonNull -> singleton "REF.AS_NON_NULL"
  | Ast.RefTest rt -> CaseV ("REF.TEST", [ al_of_ref_type rt ])
  | Ast.RefCast rt -> CaseV ("REF.CAST", [ al_of_ref_type rt ])
  | Ast.RefEq -> singleton "REF.EQ"
  | Ast.RefI31 -> singleton "REF.I31"
  | Ast.I31Get sx -> CaseV ("I31.GET", [ al_of_extension sx ])
  | Ast.StructNew (idx, Ast.Explicit) -> CaseV ("STRUCT.NEW", [ al_of_idx idx ])
  | Ast.StructNew (idx, Ast.Implicit) -> CaseV ("STRUCT.NEW_DEFAULT", [ al_of_idx idx ])
  | Ast.StructGet (idx1, idx2, sx_opt) ->
    CaseV ("STRUCT.GET", [
      OptV (Option.map al_of_extension sx_opt);
      al_of_idx idx1;
      al_of_idx idx2;
    ])
  | Ast.StructSet (idx1, idx2) -> CaseV ("STRUCT.SET", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ArrayNew (idx, Ast.Explicit) -> CaseV ("ARRAY.NEW", [ al_of_idx idx ])
  | Ast.ArrayNew (idx, Ast.Implicit) -> CaseV ("ARRAY.NEW_DEFAULT", [ al_of_idx idx ])
  | Ast.ArrayNewFixed (idx, i32) ->
    CaseV ("ARRAY.NEW_FIXED", [ al_of_idx idx; al_of_int32 i32 ])
  | Ast.ArrayNewElem (idx1, idx2) ->
    CaseV ("ARRAY.NEW_ELEM", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ArrayNewData (idx1, idx2) ->
    CaseV ("ARRAY.NEW_DATA", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ArrayGet (idx, sx_opt) ->
    CaseV ("ARRAY.GET", [ OptV (Option.map al_of_extension sx_opt); al_of_idx idx ])
  | Ast.ArraySet idx -> CaseV ("ARRAY.SET", [ al_of_idx idx ])
  | Ast.ArrayLen -> singleton "ARRAY.LEN"
  | Ast.ArrayCopy (idx1, idx2) -> CaseV ("ARRAY.COPY", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ArrayFill idx -> CaseV ("ARRAY.FILL", [ al_of_idx idx ])
  | Ast.ArrayInitData (idx1, idx2) -> CaseV ("ARRAY.INIT_DATA", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ArrayInitElem (idx1, idx2) -> CaseV ("ARRAY.INIT_ELEM", [ al_of_idx idx1; al_of_idx idx2 ])
  | Ast.ExternConvert Ast.Internalize -> singleton "ANY.CONVERT_EXTERN"
  | Ast.ExternConvert Ast.Externalize -> singleton "EXTERN.CONVERT_ANY"
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

let al_to_idx: value -> Ast.idx = function
  | NumV i -> Int64.to_int32 i @@ no_region
  | v -> fail "idx" v

open Types

(* Deconstruct type *)

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

(* Deconstruct value *)

open Value
open Al.Ast

let al_to_num: value -> Value.num = function
  | CaseV (_, [ CaseV ("I32", []); NumV i ]) -> I32 (Int64.to_int32 i)
  | CaseV (_, [ CaseV ("I64", []); NumV i ]) -> I64 i
  | CaseV (_, [ CaseV ("F32", []); NumV i ]) ->
    let f32 = Int64.to_int32 i |> F32.of_bits in
    F32 f32
  | CaseV (_, [ CaseV ("F64", []); NumV i ]) -> F64 (F64.of_bits i)
  | v -> fail "num" v

let rec al_to_ref: value -> Value.ref_ = function
  | CaseV ("REF.NULL", [ ht ]) -> NullRef (al_to_heap_type ht)
  | CaseV ("REF.HOST_ADDR", [ NumV i ]) -> Script.HostRef (Int64.to_int32 i)
  | CaseV ("REF.EXTERN", [ r ]) -> Extern.ExternRef (al_to_ref r)
  | v -> fail "ref" v

let al_to_value: value -> Value.value = function
  | CaseV ("CONST", _) as v -> Num (al_to_num v)
  | CaseV (ref, _) as v when String.starts_with ~prefix:"REF." ref ->
    Ref (al_to_ref v)
  | v -> fail "value" v

(* Deconstruct block type *)

open Ast

let al_to_block_type: value -> block_type = function
  | CaseV ("_IDX", [ idx ]) -> VarBlockType (al_to_idx idx)
  | CaseV ("_RESULT", [ OptV None ]) -> ValBlockType None
  | CaseV ("_RESULT", [ OptV (Some (val_type)) ]) -> ValBlockType (Some (al_to_val_type val_type))
  | v -> fail "block type" v

(* Deconstruct operator *)

let al_to_op f1 f2 = function
  | [ CaseV ("I32", []); op ] -> Value.I32 (f1 op)
  | [ CaseV ("I64", []); op ] -> Value.I64 (f1 op)
  | [ CaseV ("F32", []); op ] -> Value.F32 (f2 op)
  | [ CaseV ("F64", []); op ] -> Value.F64 (f2 op)
  | v -> fail "op" (listV v)

let al_to_int_unop: value -> IntOp.unop = function
  | TextV "Clz" -> IntOp.Clz
  | TextV "Ctz" -> IntOp.Ctz
  | TextV "Popcnt" -> IntOp.Popcnt
  | TextV "Extend8S" -> IntOp.ExtendS Pack.Pack8
  | TextV "Extend16S" -> IntOp.ExtendS Pack.Pack16
  | TextV "Extend32S" -> IntOp.ExtendS Pack.Pack32
  | TextV "Extend64S" -> IntOp.ExtendS Pack.Pack64
  | v -> fail "integer unop" v
let al_to_float_unop: value -> FloatOp.unop = function
  | TextV "Neg" -> FloatOp.Neg
  | TextV "Abs" -> FloatOp.Abs
  | TextV "Ceil" -> FloatOp.Ceil
  | TextV "Floor" -> FloatOp.Floor
  | TextV "Trunc" -> FloatOp.Trunc
  | TextV "Nearest" -> FloatOp.Nearest
  | TextV "Sqrt" -> FloatOp.Sqrt
  | v -> fail "float unop" v
let al_to_unop: value list -> Ast.unop = al_to_op al_to_int_unop al_to_float_unop

let al_to_int_binop: value -> IntOp.binop = function
  | TextV "Add" -> IntOp.Add
  | TextV "Sub" -> IntOp.Sub
  | TextV "Mul" -> IntOp.Mul
  | TextV "DivS" -> IntOp.DivS
  | TextV "DivU" -> IntOp.DivU
  | TextV "RemS" -> IntOp.RemS
  | TextV "RemU" -> IntOp.RemU
  | TextV "And" -> IntOp.And
  | TextV "Or" -> IntOp.Or
  | TextV "Xor" -> IntOp.Xor
  | TextV "Shl" -> IntOp.Shl
  | TextV "ShrS" -> IntOp.ShrS
  | TextV "ShrU" -> IntOp.ShrU
  | TextV "Rotl" -> IntOp.Rotl
  | v -> fail "integer binop" v
let al_to_float_binop: value -> FloatOp.binop = function
  | TextV "Add" -> FloatOp.Add
  | TextV "Sub" -> FloatOp.Sub
  | TextV "Mul" -> FloatOp.Mul
  | TextV "Div" -> FloatOp.Div
  | TextV "Min" -> FloatOp.Min
  | TextV "Max" -> FloatOp.Max
  | TextV "CopySign" -> FloatOp.CopySign
  | v -> fail "float binop" v
let al_to_binop: value list -> Ast.binop = al_to_op al_to_int_binop al_to_float_binop

let al_to_int_testop: value -> IntOp.testop = function
  | TextV "Eqz" -> Ast.IntOp.Eqz
  | v -> fail "integer testop" v
let al_to_testop: value list -> Ast.testop = function
  | [ CaseV ("I32", []); op ] -> Value.I32 (al_to_int_testop op)
  | [ CaseV ("I64", []); op ] -> Value.I64 (al_to_int_testop op)
  | v -> fail "testop" (listV v)

let al_to_int_relop: value -> IntOp.relop = function
  | TextV "Eq" -> Ast.IntOp.Eq
  | TextV "Ne" -> Ast.IntOp.Ne
  | TextV "LtS" -> Ast.IntOp.LtS
  | TextV "LtU" -> Ast.IntOp.LtU
  | TextV "GtS" -> Ast.IntOp.GtS
  | TextV "GtU" -> Ast.IntOp.GtU
  | TextV "LeS" -> Ast.IntOp.LeS
  | TextV "LeU" -> Ast.IntOp.LeU
  | TextV "GeS" -> Ast.IntOp.GeS
  | TextV "GeU" -> Ast.IntOp.GeU
  | v -> fail "integer relop" v
let al_to_float_relop: value -> FloatOp.relop = function
  | TextV "Eq" -> Ast.FloatOp.Eq
  | TextV "Ne" -> Ast.FloatOp.Ne
  | TextV "Lt" -> Ast.FloatOp.Lt
  | TextV "Gt" -> Ast.FloatOp.Gt
  | TextV "Le" -> Ast.FloatOp.Le
  | TextV "Ge" -> Ast.FloatOp.Ge
  | v -> fail "float relop" v
let al_to_relop: value list -> Ast.relop = al_to_op al_to_int_relop al_to_float_relop

let al_to_int_cvtop: value list -> IntOp.cvtop = function
  | [ TextV "Extend"; CaseV ("I32", []); OptV (Some (CaseV ("S", []))) ] -> Ast.IntOp.ExtendSI32
  | [ TextV "Extend"; CaseV ("I32", []); OptV (Some (CaseV ("U", []))) ] -> Ast.IntOp.ExtendUI32
  | [ TextV "Wrap"; CaseV ("I64", []); OptV None ] -> Ast.IntOp.WrapI64
  | [ TextV "Trunc"; CaseV ("F32", []); OptV (Some (CaseV ("S", []))) ] -> Ast.IntOp.TruncSF32
  | [ TextV "Trunc"; CaseV ("F32", []); OptV (Some (CaseV ("U", []))) ] -> Ast.IntOp.TruncUF32
  | [ TextV "Trunc"; CaseV ("F64", []); OptV (Some (CaseV ("S", []))) ] -> Ast.IntOp.TruncSF64
  | [ TextV "Trunc"; CaseV ("F64", []); OptV (Some (CaseV ("U", []))) ] -> Ast.IntOp.TruncUF64
  | [ TextV "TruncSat"; CaseV ("F32", []); OptV (Some (CaseV ("S", []))) ] -> Ast.IntOp.TruncSatSF32
  | [ TextV "TruncSat"; CaseV ("F32", []); OptV (Some (CaseV ("U", []))) ] -> Ast.IntOp.TruncSatUF32
  | [ TextV "TruncSat"; CaseV ("F64", []); OptV (Some (CaseV ("S", []))) ] -> Ast.IntOp.TruncSatSF64
  | [ TextV "TruncSat"; CaseV ("F64", []); OptV (Some (CaseV ("U", []))) ] -> Ast.IntOp.TruncSatUF64
  | [ TextV "Reinterpret"; _; OptV None ] -> Ast.IntOp.ReinterpretFloat
  | v -> fail "integer cvtop" (listV v)
let al_to_float_cvtop : value list -> FloatOp.cvtop = function
  | [ TextV "Convert"; CaseV ("I32", []); OptV (Some (CaseV (("S", [])))) ] -> Ast.FloatOp.ConvertSI32
  | [ TextV "Convert"; CaseV ("I32", []); OptV (Some (CaseV (("U", [])))) ] -> Ast.FloatOp.ConvertUI32
  | [ TextV "Convert"; CaseV ("I64", []); OptV (Some (CaseV (("S", [])))) ] -> Ast.FloatOp.ConvertSI64
  | [ TextV "Convert"; CaseV ("I64", []); OptV (Some (CaseV (("U", [])))) ] -> Ast.FloatOp.ConvertUI64
  | [ TextV "Promote"; CaseV ("F32", []); OptV None ] -> Ast.FloatOp.PromoteF32
  | [ TextV "Demote"; CaseV ("F64", []); OptV None ] -> Ast.FloatOp.DemoteF64
  | [ TextV "Reinterpret"; _; OptV None ] -> Ast.FloatOp.ReinterpretInt
  | v -> fail "float cvtop" (listV v)
let al_to_cvtop: value list -> Ast.cvtop = function
  | CaseV ("I32", []) :: op -> Value.I32 (al_to_int_cvtop op)
  | CaseV ("I64", []) :: op -> Value.I64 (al_to_int_cvtop op)
  | CaseV ("F32", []) :: op -> Value.F32 (al_to_float_cvtop op)
  | CaseV ("F64", []) :: op -> Value.F64 (al_to_float_cvtop op)
  | v -> fail "cvtop" (listV v)

let al_to_pack_size: value -> Pack.pack_size = function
  | NumV 8L -> Pack.Pack8
  | NumV 16L -> Pack.Pack16
  | NumV 32L -> Pack.Pack32
  | NumV 64L -> Pack.Pack64
  | v -> fail "pack_size" v

let al_to_extension: value -> Pack.extension = function
  | CaseV ("S", []) -> Pack.SX
  | CaseV ("U", []) -> Pack.ZX
  | v -> fail "extension" v

let al_to_pack_size_with_extension (_p, _s) = failwith "TODO"

let rec al_to_instr (v: value): Ast.instr = al_to_instr' v @@ no_region
and al_to_instr': value -> Ast.instr' = function
  (* wasm values *)
  | CaseV ("CONST", _) as v -> Ast.Const (al_to_num v @@ no_region)
  | CaseV ("REF.NULL", [ ht ]) -> Ast.RefNull (al_to_heap_type ht)
  (* wasm instructions *)
  | CaseV ("UNREACHABLE", []) -> Ast.Unreachable
  | CaseV ("NOP", []) -> Ast.Nop
  | CaseV ("DROP", []) -> Ast.Drop
  | CaseV ("UNOP", op) -> Ast.Unary (al_to_unop op)
  | CaseV ("BINOP", op) -> Ast.Binary (al_to_binop op)
  | CaseV ("TESTOP", op) -> Ast.Test (al_to_testop op)
  | CaseV ("RELOP", op) -> Ast.Compare (al_to_relop op)
  | CaseV ("CVTOP", op) -> Ast.Convert (al_to_cvtop op)
  | CaseV ("REF.IS_NULL", []) -> Ast.RefIsNull
  | CaseV ("REF.FUNC", [ idx ]) -> Ast.RefFunc (al_to_idx idx)
  | CaseV ("SELECT", [ OptV None ]) -> Ast.Select None
  | CaseV ("SELECT", [ OptV (Some (ListV vs)) ]) ->
    let vs' = Array.to_list !vs in
    Ast.Select (Some (List.map al_to_val_type vs'))
  | CaseV ("LOCAL.GET", [ idx ]) -> Ast.LocalGet (al_to_idx idx)
  | CaseV ("LOCAL.SET", [ idx ]) -> Ast.LocalSet (al_to_idx idx)
  | CaseV ("LOCAL.TEE", [ idx ]) -> Ast.LocalTee (al_to_idx idx)
  | CaseV ("GLOBAL.GET", [ idx ]) -> Ast.GlobalGet (al_to_idx idx)
  | CaseV ("GLOBAL.SET", [ idx ]) -> Ast.GlobalSet (al_to_idx idx)
  | CaseV ("TABLE.GET", [ idx ]) -> Ast.TableGet (al_to_idx idx)
  | CaseV ("TABLE.SET", [ idx ]) -> Ast.TableSet (al_to_idx idx)
  | CaseV ("TABLE.SIZE", [ idx ]) -> Ast.TableSize (al_to_idx idx)
  | CaseV ("TABLE.GROW", [ idx ]) -> Ast.TableGrow (al_to_idx idx)
  | CaseV ("TABLE.FILL", [ idx ]) -> Ast.TableFill (al_to_idx idx)
  | CaseV ("TABLE.COPY", [ idx1; idx2 ]) -> Ast.TableCopy (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("TABLE.INIT", [ idx1; idx2 ]) -> Ast.TableInit (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("ELEM.DROP", [ idx ]) -> Ast.ElemDrop (al_to_idx idx)
  | CaseV ("BLOCK", [ bt; ListV instrs ]) ->
    let instrs' = Array.to_list !instrs in
    Ast.Block (al_to_block_type bt, List.map al_to_instr instrs')
  | CaseV ("LOOP", [ bt; ListV instrs ]) ->
    let instrs' = Array.to_list !instrs in
    Ast.Loop (al_to_block_type bt, List.map al_to_instr instrs')
  | CaseV ("IF", [ bt; ListV instrs1; ListV instrs2 ]) ->
    let instrs1' = Array.to_list !instrs1 in
    let instrs2' = Array.to_list !instrs2 in
    Ast.If (al_to_block_type bt, List.map al_to_instr instrs1', List.map al_to_instr instrs2')
  | CaseV ("BR", [ idx ]) -> Ast.Br (al_to_idx idx)
  | CaseV ("BR_IF", [ idx ]) -> Ast.BrIf (al_to_idx idx)
  | CaseV ("BR_TABLE", [ ListV idxs; idx ]) ->
    let idxs' = Array.to_list !idxs in
    Ast.BrTable (List.map al_to_idx idxs', al_to_idx idx)
  | CaseV ("BR_ON_NULL", [ idx ]) -> Ast.BrOnNull (al_to_idx idx)
  | CaseV ("BR_ON_NON_NULL", [ idx ]) -> Ast.BrOnNonNull (al_to_idx idx)
  | CaseV ("BR_ON_CAST", [ idx; rt1; rt2 ]) ->
    Ast.BrOnCast (al_to_idx idx, al_to_ref_type rt1, al_to_ref_type rt2)
  | CaseV ("BR_ON_CAST_FAIL", [ idx; rt1; rt2 ]) ->
    Ast.BrOnCastFail (al_to_idx idx, al_to_ref_type rt1, al_to_ref_type rt2)
  | CaseV ("RETURN", []) -> Ast.Return
  | CaseV ("CALL", [ idx ]) -> Ast.Call (al_to_idx idx)
  | CaseV ("CALL_REF", [ OptV (Some idx) ]) -> Ast.CallRef (al_to_idx idx)
  | CaseV ("CALL_INDIRECT", [ idx1; idx2 ]) ->
    Ast.CallIndirect (al_to_idx idx1, al_to_idx idx2)
  | CaseV ("RETURN_CALL", [ idx ]) -> Ast.ReturnCall (al_to_idx idx)
  | CaseV ("RETURN_CALL_REF", [ OptV (Some idx) ]) -> Ast.ReturnCallRef (al_to_idx idx)
  | CaseV ("RETURN_CALL_INDIRECT", [ idx1; idx2 ]) ->
    Ast.ReturnCallIndirect (al_to_idx idx1, al_to_idx idx2)
  | v -> fail "instrunction" v
