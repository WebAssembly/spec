(* Version *)

let version = 1l


(* Errors *)

module Code = Error.Make ()
exception Code = Code.Error


(* Encoding stream *)

type stream =
{
  buf : Buffer.t;
  patches : (int * char) list ref
}

let stream () = {buf = Buffer.create 8192; patches = ref []}
let pos s = Buffer.length s.buf
let put s b = Buffer.add_char s.buf b
let put_string s bs = Buffer.add_string s.buf bs
let patch s pos b = s.patches := (pos, b) :: !(s.patches)

let to_string s =
  let bs = Buffer.to_bytes s.buf in
  List.iter (fun (pos, b) -> Bytes.set bs pos b) !(s.patches);
  Bytes.to_string bs


(* Encoding *)

module E (S : sig val stream : stream end) =
struct
  let s = S.stream

  (* Generic values *)

  let u8 i = put s (Char.chr (i land 0xff))
  let u16 i = u8 (i land 0xff); u8 (i lsr 8)
  let u32 i =
    Int32.(u16 (to_int (logand i 0xffffl));
           u16 (to_int (shift_right i 16)))
  let u64 i =
    Int64.(u32 (to_int32 (logand i 0xffffffffL));
           u32 (to_int32 (shift_right i 32)))

  let rec vu64 i =
    let b = Int64.(to_int (logand i 0x7fL)) in
    if 0L <= i && i < 128L then u8 b
    else (u8 (b lor 0x80); vu64 (Int64.shift_right_logical i 7))

  let rec vs64 i =
    let b = Int64.(to_int (logand i 0x7fL)) in
    if -64L <= i && i < 64L then u8 b
    else (u8 (b lor 0x80); vs64 (Int64.shift_right i 7))

  let vu1 i = vu64 Int64.(logand (of_int i) 1L)
  let vu32 i = vu64 Int64.(logand (of_int32 i) 0xffffffffL)
  let vs7 i = vs64 (Int64.of_int i)
  let vs32 i = vs64 (Int64.of_int32 i)
  let vs33 i = vs64 (I64_convert.extend_i32_s i)
  let f32 x = u32 (F32.to_bits x)
  let f64 x = u64 (F64.to_bits x)

  let len i =
    if Int32.to_int (Int32.of_int i) <> i then
      Code.error Source.no_region
        "cannot encode length with more than 32 bit";
    vu32 (Int32.of_int i)

  let bool b = vu1 (if b then 1 else 0)
  let string bs = len (String.length bs); put_string s bs
  let name n = string (Utf8.encode n)
  let list f xs = List.iter f xs
  let opt f xo = Lib.Option.app f xo
  let vec f xs = len (List.length xs); list f xs

  let gap32 () = let p = pos s in u32 0l; u8 0; p
  let patch_gap32 p n =
    assert (n <= 0x0fff_ffff); (* Strings cannot excess 2G anyway *)
    let lsb i = Char.chr (i land 0xff) in
    patch s p (lsb (n lor 0x80));
    patch s (p + 1) (lsb ((n lsr 7) lor 0x80));
    patch s (p + 2) (lsb ((n lsr 14) lor 0x80));
    patch s (p + 3) (lsb ((n lsr 21) lor 0x80));
    patch s (p + 4) (lsb (n lsr 28))

  (* Types *)

  open Types

  let mutability = function
    | Immutable -> u8 0
    | Mutable -> u8 1

  let var_type var = function
    | SynVar x -> var x
    | SemVar _ -> assert false

  let num_type = function
    | I32Type -> vs7 (-0x01)
    | I64Type -> vs7 (-0x02)
    | F32Type -> vs7 (-0x03)
    | F64Type -> vs7 (-0x04)

  let heap_type = function
    | AnyHeapType -> vs7 (-0x12)
    | EqHeapType -> vs7 (-0x13)
    | I31HeapType -> vs7 (-0x16)
    | DataHeapType -> vs7 (-0x19)
    | ArrayHeapType -> vs7 (-0x20)
    | FuncHeapType -> vs7 (-0x10)
    | ExternHeapType -> vs7 (-0x11)
    | DefHeapType x -> var_type vs33 x
    | RttHeapType (x, None) -> vs7 (-0x18); var_type vu32 x
    | RttHeapType (x, Some n) -> vs7 (-0x17); vs32 n; var_type vu32 x
    | BotHeapType -> assert false

  let ref_type = function
    | (Nullable, FuncHeapType) -> vs7 (-0x10)
    | (Nullable, ExternHeapType) -> vs7 (-0x11)
    | (Nullable, t) -> vs7 (-0x14); heap_type t
    | (NonNullable, t) -> vs7 (-0x15); heap_type t

  let value_type = function
    | NumType t -> num_type t
    | RefType t -> ref_type t
    | BotType -> assert false

  let packed_type = function
    | Pack8 -> vs7 (-0x06)
    | Pack16 -> vs7 (-0x07)
    | Pack32 -> assert false

  let storage_type = function
    | ValueStorageType t -> value_type t
    | PackedStorageType t -> packed_type t

  let field_type = function
    | FieldType (t, mut) -> storage_type t; mutability mut

  let struct_type = function
    | StructType fts -> vec field_type fts

  let array_type = function
    | ArrayType ft -> field_type ft

  let func_type = function
    | FuncType (ts1, ts2) -> vec value_type ts1; vec value_type ts2

  let def_type = function
    | StructDefType st -> vs7 (-0x21); struct_type st
    | ArrayDefType at -> vs7 (-0x22); array_type at
    | FuncDefType ft -> vs7 (-0x20); func_type ft

  let limits vu {min; max} =
    bool (max <> None); vu min; opt vu max

  let table_type = function
    | TableType (lim, t) -> ref_type t; limits vu32 lim

  let memory_type = function
    | MemoryType lim -> limits vu32 lim

  let global_type = function
    | GlobalType (t, mut) -> value_type t; mutability mut


  (* Expressions *)

  open Source
  open Ast
  open Value

  let op n = u8 n
  let end_ () = op 0x0b

  let memop {align; offset; _} = vu32 (Int32.of_int align); vu32 offset

  let var x = vu32 x.it

  let block_type = function
    | ValBlockType None -> vs33 (-0x40l)
    | ValBlockType (Some t) -> value_type t
    | VarBlockType (SynVar x) -> vs33 x
    | VarBlockType (SemVar _) -> assert false

  let local (t, n) = len n; value_type t.it
  let locals locs =
    let combine t = function
      | (t', n) :: ts when t.it = t'.it -> (t, n + 1) :: ts
      | ts -> (t, 1) :: ts
    in vec local (List.fold_right combine locs [])

  let rec instr e =
    match e.it with
    | Unreachable -> op 0x00
    | Nop -> op 0x01

    | Block (bt, es) -> op 0x02; block_type bt; list instr es; end_ ()
    | Loop (bt, es) -> op 0x03; block_type bt; list instr es; end_ ()
    | If (bt, es1, es2) ->
      op 0x04; block_type bt; list instr es1;
      if es2 <> [] then op 0x05;
      list instr es2; end_ ()
    | Let (bt, locs, es) ->
      op 0x17; block_type bt; locals locs; list instr es; end_ ()

    | Br x -> op 0x0c; var x
    | BrIf x -> op 0x0d; var x
    | BrTable (xs, x) -> op 0x0e; vec var xs; var x
    | BrCast (x, NullOp) -> op 0xd4; var x
    | BrCast (x, I31Op) -> op 0xfb; op 0x62; var x
    | BrCast (x, DataOp) -> op 0xfb; op 0x61; var x
    | BrCast (x, ArrayOp) -> op 0xfb; op 0x66; var x
    | BrCast (x, FuncOp) -> op 0xfb; op 0x60; var x
    | BrCast (x, RttOp) -> op 0xfb; op 0x42; var x
    | BrCastFail (x, NullOp) -> op 0xd6; var x
    | BrCastFail (x, I31Op) -> op 0xfb; op 0x65; var x
    | BrCastFail (x, DataOp) -> op 0xfb; op 0x64; var x
    | BrCastFail (x, ArrayOp) -> op 0xfb; op 0x67; var x
    | BrCastFail (x, FuncOp) -> op 0xfb; op 0x63; var x
    | BrCastFail (x, RttOp) -> op 0xfb; op 0x43; var x
    | Return -> op 0x0f
    | Call x -> op 0x10; var x
    | CallRef -> op 0x14
    | CallIndirect (x, y) -> op 0x11; var y; var x
    | ReturnCallRef -> op 0x15
    | FuncBind x -> op 0x16; var x

    | Drop -> op 0x1a
    | Select None -> op 0x1b
    | Select (Some ts) -> op 0x1c; vec value_type ts

    | LocalGet x -> op 0x20; var x
    | LocalSet x -> op 0x21; var x
    | LocalTee x -> op 0x22; var x
    | GlobalGet x -> op 0x23; var x
    | GlobalSet x -> op 0x24; var x

    | TableGet x -> op 0x25; var x
    | TableSet x -> op 0x26; var x
    | TableSize x -> op 0xfc; vu32 0x10l; var x
    | TableGrow x -> op 0xfc; vu32 0x0fl; var x
    | TableFill x -> op 0xfc; vu32 0x11l; var x
    | TableCopy (x, y) -> op 0xfc; vu32 0x0el; var x; var y
    | TableInit (x, y) -> op 0xfc; vu32 0x0cl; var y; var x
    | ElemDrop x -> op 0xfc; vu32 0x0dl; var x

    | Load ({ty = I32Type; sz = None; _} as mo) -> op 0x28; memop mo
    | Load ({ty = I64Type; sz = None; _} as mo) -> op 0x29; memop mo
    | Load ({ty = F32Type; sz = None; _} as mo) -> op 0x2a; memop mo
    | Load ({ty = F64Type; sz = None; _} as mo) -> op 0x2b; memop mo
    | Load ({ty = I32Type; sz = Some (Pack8, SX); _} as mo) ->
      op 0x2c; memop mo
    | Load ({ty = I32Type; sz = Some (Pack8, ZX); _} as mo) ->
      op 0x2d; memop mo
    | Load ({ty = I32Type; sz = Some (Pack16, SX); _} as mo) ->
      op 0x2e; memop mo
    | Load ({ty = I32Type; sz = Some (Pack16, ZX); _} as mo) ->
      op 0x2f; memop mo
    | Load {ty = I32Type; sz = Some (Pack32, _); _} ->
      assert false
    | Load ({ty = I64Type; sz = Some (Pack8, SX); _} as mo) ->
      op 0x30; memop mo
    | Load ({ty = I64Type; sz = Some (Pack8, ZX); _} as mo) ->
      op 0x31; memop mo
    | Load ({ty = I64Type; sz = Some (Pack16, SX); _} as mo) ->
      op 0x32; memop mo
    | Load ({ty = I64Type; sz = Some (Pack16, ZX); _} as mo) ->
      op 0x33; memop mo
    | Load ({ty = I64Type; sz = Some (Pack32, SX); _} as mo) ->
      op 0x34; memop mo
    | Load ({ty = I64Type; sz = Some (Pack32, ZX); _} as mo) ->
      op 0x35; memop mo
    | Load {ty = F32Type | F64Type; sz = Some _; _} ->
      assert false

    | Store ({ty = I32Type; sz = None; _} as mo) -> op 0x36; memop mo
    | Store ({ty = I64Type; sz = None; _} as mo) -> op 0x37; memop mo
    | Store ({ty = F32Type; sz = None; _} as mo) -> op 0x38; memop mo
    | Store ({ty = F64Type; sz = None; _} as mo) -> op 0x39; memop mo
    | Store ({ty = I32Type; sz = Some Pack8; _} as mo) -> op 0x3a; memop mo
    | Store ({ty = I32Type; sz = Some Pack16; _} as mo) -> op 0x3b; memop mo
    | Store {ty = I32Type; sz = Some Pack32; _} -> assert false
    | Store ({ty = I64Type; sz = Some Pack8; _} as mo) -> op 0x3c; memop mo
    | Store ({ty = I64Type; sz = Some Pack16; _} as mo) -> op 0x3d; memop mo
    | Store ({ty = I64Type; sz = Some Pack32; _} as mo) -> op 0x3e; memop mo
    | Store {ty = F32Type | F64Type; sz = Some _; _} -> assert false

    | MemorySize -> op 0x3f; u8 0x00
    | MemoryGrow -> op 0x40; u8 0x00
    | MemoryFill -> op 0xfc; vu32 0x0bl; u8 0x00
    | MemoryCopy -> op 0xfc; vu32 0x0al; u8 0x00; u8 0x00
    | MemoryInit x -> op 0xfc; vu32 0x08l; var x; u8 0x00
    | DataDrop x -> op 0xfc; vu32 0x09l; var x

    | RefNull t -> op 0xd0; heap_type t
    | RefFunc x -> op 0xd2; var x

    | RefTest NullOp -> op 0xd1
    | RefTest I31Op -> op 0xfb; op 0x52
    | RefTest DataOp -> op 0xfb; op 0x51
    | RefTest ArrayOp -> op 0xfb; op 0x53
    | RefTest FuncOp -> op 0xfb; op 0x50
    | RefTest RttOp -> op 0xfb; op 0x40

    | RefCast NullOp -> op 0xd3
    | RefCast I31Op -> op 0xfb; op 0x5a
    | RefCast DataOp -> op 0xfb; op 0x59
    | RefCast ArrayOp -> op 0xfb; op 0x5b
    | RefCast FuncOp -> op 0xfb; op 0x58
    | RefCast RttOp -> op 0xfb; op 0x41

    | RefEq -> op 0xd5

    | I31New -> op 0xfb; op 0x20
    | I31Get SX -> op 0xfb; op 0x21
    | I31Get ZX -> op 0xfb; op 0x22

    | StructNew (x, Explicit) -> op 0xfb; op 0x01; var x
    | StructNew (x, Implicit) -> op 0xfb; op 0x02; var x
    | StructGet (x, y, None) -> op 0xfb; op 0x03; var x; var y
    | StructGet (x, y, Some SX) -> op 0xfb; op 0x04; var x; var y
    | StructGet (x, y, Some ZX) -> op 0xfb; op 0x05; var x; var y
    | StructSet (x, y) -> op 0xfb; op 0x06; var x; var y

    | ArrayNew (x, Explicit) -> op 0xfb; op 0x11; var x
    | ArrayNew (x, Implicit) -> op 0xfb; op 0x12; var x
    | ArrayGet (x, None) -> op 0xfb; op 0x13; var x
    | ArrayGet (x, Some SX) -> op 0xfb; op 0x14; var x
    | ArrayGet (x, Some ZX) -> op 0xfb; op 0x15; var x
    | ArraySet x -> op 0xfb; op 0x16; var x
    | ArrayLen -> op 0xfb; op 0x17; op 0  (* TODO: remove 0 *)

    | RttCanon x -> op 0xfb; op 0x30; var x
    | RttSub x -> op 0xfb; op 0x31; var x

    | Const {it = I32 c; _} -> op 0x41; vs32 c
    | Const {it = I64 c; _} -> op 0x42; vs64 c
    | Const {it = F32 c; _} -> op 0x43; f32 c
    | Const {it = F64 c; _} -> op 0x44; f64 c

    | Test (I32 I32Op.Eqz) -> op 0x45
    | Test (I64 I64Op.Eqz) -> op 0x50
    | Test (F32 _) -> assert false
    | Test (F64 _) -> assert false

    | Compare (I32 I32Op.Eq) -> op 0x46
    | Compare (I32 I32Op.Ne) -> op 0x47
    | Compare (I32 I32Op.LtS) -> op 0x48
    | Compare (I32 I32Op.LtU) -> op 0x49
    | Compare (I32 I32Op.GtS) -> op 0x4a
    | Compare (I32 I32Op.GtU) -> op 0x4b
    | Compare (I32 I32Op.LeS) -> op 0x4c
    | Compare (I32 I32Op.LeU) -> op 0x4d
    | Compare (I32 I32Op.GeS) -> op 0x4e
    | Compare (I32 I32Op.GeU) -> op 0x4f

    | Compare (I64 I64Op.Eq) -> op 0x51
    | Compare (I64 I64Op.Ne) -> op 0x52
    | Compare (I64 I64Op.LtS) -> op 0x53
    | Compare (I64 I64Op.LtU) -> op 0x54
    | Compare (I64 I64Op.GtS) -> op 0x55
    | Compare (I64 I64Op.GtU) -> op 0x56
    | Compare (I64 I64Op.LeS) -> op 0x57
    | Compare (I64 I64Op.LeU) -> op 0x58
    | Compare (I64 I64Op.GeS) -> op 0x59
    | Compare (I64 I64Op.GeU) -> op 0x5a

    | Compare (F32 F32Op.Eq) -> op 0x5b
    | Compare (F32 F32Op.Ne) -> op 0x5c
    | Compare (F32 F32Op.Lt) -> op 0x5d
    | Compare (F32 F32Op.Gt) -> op 0x5e
    | Compare (F32 F32Op.Le) -> op 0x5f
    | Compare (F32 F32Op.Ge) -> op 0x60

    | Compare (F64 F64Op.Eq) -> op 0x61
    | Compare (F64 F64Op.Ne) -> op 0x62
    | Compare (F64 F64Op.Lt) -> op 0x63
    | Compare (F64 F64Op.Gt) -> op 0x64
    | Compare (F64 F64Op.Le) -> op 0x65
    | Compare (F64 F64Op.Ge) -> op 0x66

    | Unary (I32 I32Op.Clz) -> op 0x67
    | Unary (I32 I32Op.Ctz) -> op 0x68
    | Unary (I32 I32Op.Popcnt) -> op 0x69
    | Unary (I32 (I32Op.ExtendS Pack8)) -> op 0xc0
    | Unary (I32 (I32Op.ExtendS Pack16)) -> op 0xc1
    | Unary (I32 (I32Op.ExtendS Pack32)) -> assert false

    | Unary (I64 I64Op.Clz) -> op 0x79
    | Unary (I64 I64Op.Ctz) -> op 0x7a
    | Unary (I64 I64Op.Popcnt) -> op 0x7b
    | Unary (I64 (I64Op.ExtendS Pack8)) -> op 0xc2
    | Unary (I64 (I64Op.ExtendS Pack16)) -> op 0xc3
    | Unary (I64 (I64Op.ExtendS Pack32)) -> op 0xc4

    | Unary (F32 F32Op.Abs) -> op 0x8b
    | Unary (F32 F32Op.Neg) -> op 0x8c
    | Unary (F32 F32Op.Ceil) -> op 0x8d
    | Unary (F32 F32Op.Floor) -> op 0x8e
    | Unary (F32 F32Op.Trunc) -> op 0x8f
    | Unary (F32 F32Op.Nearest) -> op 0x90
    | Unary (F32 F32Op.Sqrt) -> op 0x91

    | Unary (F64 F64Op.Abs) -> op 0x99
    | Unary (F64 F64Op.Neg) -> op 0x9a
    | Unary (F64 F64Op.Ceil) -> op 0x9b
    | Unary (F64 F64Op.Floor) -> op 0x9c
    | Unary (F64 F64Op.Trunc) -> op 0x9d
    | Unary (F64 F64Op.Nearest) -> op 0x9e
    | Unary (F64 F64Op.Sqrt) -> op 0x9f

    | Binary (I32 I32Op.Add) -> op 0x6a
    | Binary (I32 I32Op.Sub) -> op 0x6b
    | Binary (I32 I32Op.Mul) -> op 0x6c
    | Binary (I32 I32Op.DivS) -> op 0x6d
    | Binary (I32 I32Op.DivU) -> op 0x6e
    | Binary (I32 I32Op.RemS) -> op 0x6f
    | Binary (I32 I32Op.RemU) -> op 0x70
    | Binary (I32 I32Op.And) -> op 0x71
    | Binary (I32 I32Op.Or) -> op 0x72
    | Binary (I32 I32Op.Xor) -> op 0x73
    | Binary (I32 I32Op.Shl) -> op 0x74
    | Binary (I32 I32Op.ShrS) -> op 0x75
    | Binary (I32 I32Op.ShrU) -> op 0x76
    | Binary (I32 I32Op.Rotl) -> op 0x77
    | Binary (I32 I32Op.Rotr) -> op 0x78

    | Binary (I64 I64Op.Add) -> op 0x7c
    | Binary (I64 I64Op.Sub) -> op 0x7d
    | Binary (I64 I64Op.Mul) -> op 0x7e
    | Binary (I64 I64Op.DivS) -> op 0x7f
    | Binary (I64 I64Op.DivU) -> op 0x80
    | Binary (I64 I64Op.RemS) -> op 0x81
    | Binary (I64 I64Op.RemU) -> op 0x82
    | Binary (I64 I64Op.And) -> op 0x83
    | Binary (I64 I64Op.Or) -> op 0x84
    | Binary (I64 I64Op.Xor) -> op 0x85
    | Binary (I64 I64Op.Shl) -> op 0x86
    | Binary (I64 I64Op.ShrS) -> op 0x87
    | Binary (I64 I64Op.ShrU) -> op 0x88
    | Binary (I64 I64Op.Rotl) -> op 0x89
    | Binary (I64 I64Op.Rotr) -> op 0x8a

    | Binary (F32 F32Op.Add) -> op 0x92
    | Binary (F32 F32Op.Sub) -> op 0x93
    | Binary (F32 F32Op.Mul) -> op 0x94
    | Binary (F32 F32Op.Div) -> op 0x95
    | Binary (F32 F32Op.Min) -> op 0x96
    | Binary (F32 F32Op.Max) -> op 0x97
    | Binary (F32 F32Op.CopySign) -> op 0x98

    | Binary (F64 F64Op.Add) -> op 0xa0
    | Binary (F64 F64Op.Sub) -> op 0xa1
    | Binary (F64 F64Op.Mul) -> op 0xa2
    | Binary (F64 F64Op.Div) -> op 0xa3
    | Binary (F64 F64Op.Min) -> op 0xa4
    | Binary (F64 F64Op.Max) -> op 0xa5
    | Binary (F64 F64Op.CopySign) -> op 0xa6

    | Convert (I32 I32Op.ExtendSI32) -> assert false
    | Convert (I32 I32Op.ExtendUI32) -> assert false
    | Convert (I32 I32Op.WrapI64) -> op 0xa7
    | Convert (I32 I32Op.TruncSF32) -> op 0xa8
    | Convert (I32 I32Op.TruncUF32) -> op 0xa9
    | Convert (I32 I32Op.TruncSF64) -> op 0xaa
    | Convert (I32 I32Op.TruncUF64) -> op 0xab
    | Convert (I32 I32Op.TruncSatSF32) -> op 0xfc; vu32 0x00l
    | Convert (I32 I32Op.TruncSatUF32) -> op 0xfc; vu32 0x01l
    | Convert (I32 I32Op.TruncSatSF64) -> op 0xfc; vu32 0x02l
    | Convert (I32 I32Op.TruncSatUF64) -> op 0xfc; vu32 0x03l
    | Convert (I32 I32Op.ReinterpretFloat) -> op 0xbc

    | Convert (I64 I64Op.ExtendSI32) -> op 0xac
    | Convert (I64 I64Op.ExtendUI32) -> op 0xad
    | Convert (I64 I64Op.WrapI64) -> assert false
    | Convert (I64 I64Op.TruncSF32) -> op 0xae
    | Convert (I64 I64Op.TruncUF32) -> op 0xaf
    | Convert (I64 I64Op.TruncSF64) -> op 0xb0
    | Convert (I64 I64Op.TruncUF64) -> op 0xb1
    | Convert (I64 I64Op.TruncSatSF32) -> op 0xfc; vu32 0x04l
    | Convert (I64 I64Op.TruncSatUF32) -> op 0xfc; vu32 0x05l
    | Convert (I64 I64Op.TruncSatSF64) -> op 0xfc; vu32 0x06l
    | Convert (I64 I64Op.TruncSatUF64) -> op 0xfc; vu32 0x07l
    | Convert (I64 I64Op.ReinterpretFloat) -> op 0xbd

    | Convert (F32 F32Op.ConvertSI32) -> op 0xb2
    | Convert (F32 F32Op.ConvertUI32) -> op 0xb3
    | Convert (F32 F32Op.ConvertSI64) -> op 0xb4
    | Convert (F32 F32Op.ConvertUI64) -> op 0xb5
    | Convert (F32 F32Op.PromoteF32) -> assert false
    | Convert (F32 F32Op.DemoteF64) -> op 0xb6
    | Convert (F32 F32Op.ReinterpretInt) -> op 0xbe

    | Convert (F64 F64Op.ConvertSI32) -> op 0xb7
    | Convert (F64 F64Op.ConvertUI32) -> op 0xb8
    | Convert (F64 F64Op.ConvertSI64) -> op 0xb9
    | Convert (F64 F64Op.ConvertUI64) -> op 0xba
    | Convert (F64 F64Op.PromoteF32) -> op 0xbb
    | Convert (F64 F64Op.DemoteF64) -> assert false
    | Convert (F64 F64Op.ReinterpretInt) -> op 0xbf

  let const c =
    list instr c.it; end_ ()

  (* Sections *)

  let section id f x needed =
    if needed then begin
      u8 id;
      let g = gap32 () in
      let p = pos s in
      f x;
      patch_gap32 g (pos s - p)
    end

  (* Type section *)
  let type_ t = def_type t.it

  let type_section ts =
    section 1 (vec type_) ts (ts <> [])

  (* Import section *)
  let import_desc d =
    match d.it with
    | FuncImport x -> u8 0x00; var x
    | TableImport t -> u8 0x01; table_type t
    | MemoryImport t -> u8 0x02; memory_type t
    | GlobalImport t -> u8 0x03; global_type t

  let import im =
    let {module_name; item_name; idesc} = im.it in
    name module_name; name item_name; import_desc idesc

  let import_section ims =
    section 2 (vec import) ims (ims <> [])

  (* Function section *)
  let func f = var f.it.ftype

  let func_section fs =
    section 3 (vec func) fs (fs <> [])

  (* Table section *)
  let table tab =
    let {ttype} = tab.it in
    table_type ttype

  let table_section tabs =
    section 4 (vec table) tabs (tabs <> [])

  (* Memory section *)
  let memory mem =
    let {mtype} = mem.it in
    memory_type mtype

  let memory_section mems =
    section 5 (vec memory) mems (mems <> [])

  (* Global section *)
  let global g =
    let {gtype; ginit} = g.it in
    global_type gtype; const ginit

  let global_section gs =
    section 6 (vec global) gs (gs <> [])

  (* Export section *)
  let export_desc d =
    match d.it with
    | FuncExport x -> u8 0; var x
    | TableExport x -> u8 1; var x
    | MemoryExport x -> u8 2; var x
    | GlobalExport x -> u8 3; var x

  let export ex =
    let {name = n; edesc} = ex.it in
    name n; export_desc edesc

  let export_section exs =
    section 7 (vec export) exs (exs <> [])

  (* Start section *)
  let start_section xo =
    section 8 (opt var) xo (xo <> None)

  (* Code section *)
  let code f =
    let {locals = locs; body; _} = f.it in
    let g = gap32 () in
    let p = pos s in
    locals locs;
    list instr body;
    end_ ();
    patch_gap32 g (pos s - p)

  let code_section fs =
    section 10 (vec code) fs (fs <> [])

  (* Element section *)
  let is_elem_kind = function
    | (NonNullable, FuncHeapType) -> true
    | _ -> false

  let elem_kind = function
    | (NonNullable, FuncHeapType) -> u8 0x00
    | _ -> assert false

  let is_elem_index e =
    match e.it with
    | [{it = RefFunc _; _}] -> true
    | _ -> false

  let elem_index e =
    match e.it with
    | [{it = RefFunc x; _}] -> var x
    | _ -> assert false

  let elem seg =
    let {etype; einit; emode} = seg.it in
    if is_elem_kind etype && List.for_all is_elem_index einit then
      match emode.it with
      | Passive ->
        vu32 0x01l; elem_kind etype; vec elem_index einit
      | Active {index; offset} when index.it = 0l ->
        vu32 0x00l; const offset; vec elem_index einit
      | Active {index; offset} ->
        vu32 0x02l;
        var index; const offset; elem_kind etype; vec elem_index einit
      | Declarative ->
        vu32 0x03l; elem_kind etype; vec elem_index einit
    else
      match emode.it with
      | Passive ->
        vu32 0x05l; ref_type etype; vec const einit
      | Active {index; offset} when index.it = 0l && is_elem_kind etype ->
        vu32 0x04l; const offset; vec const einit
      | Active {index; offset} ->
        vu32 0x06l; var index; const offset; ref_type etype; vec const einit
      | Declarative ->
        vu32 0x07l; ref_type etype; vec const einit

  let elem_section elems =
    section 9 (vec elem) elems (elems <> [])

  (* Data section *)
  let data seg =
    let {dinit; dmode} = seg.it in
    match dmode.it with
    | Passive ->
      vu32 0x01l; string dinit
    | Active {index; offset} when index.it = 0l ->
      vu32 0x00l; const offset; string dinit
    | Active {index; offset} ->
      vu32 0x02l; var index; const offset; string dinit
    | Declarative ->
      assert false

  let data_section datas =
    section 11 (vec data) datas (datas <> [])

  (* Data count section *)
  let data_count_section datas m =
    section 12 len (List.length datas) Free.((module_ m).datas <> Set.empty)

  (* Custom section *)
  let custom (n, bs) =
    name n;
    put_string s bs

  let custom_section n bs =
    section 0 custom (n, bs) true

  (* Module *)
  let module_ m =
    u32 0x6d736100l;
    u32 version;
    type_section m.it.types;
    import_section m.it.imports;
    func_section m.it.funcs;
    table_section m.it.tables;
    memory_section m.it.memories;
    global_section m.it.globals;
    export_section m.it.exports;
    start_section m.it.start;
    elem_section m.it.elems;
    data_count_section m.it.datas m;
    code_section m.it.funcs;
    data_section m.it.datas
end


let encode m =
  let module E = E (struct let stream = stream () end) in
  E.module_ m; to_string E.s

let encode_custom name content =
  let module E = E (struct let stream = stream () end) in
  E.custom_section name content; to_string E.s
