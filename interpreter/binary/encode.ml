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
  let v128 v = String.iter (put s) (V128.to_bits v)

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

  let num_type = function
    | I32Type -> vs7 (-0x01)
    | I64Type -> vs7 (-0x02)
    | F32Type -> vs7 (-0x03)
    | F64Type -> vs7 (-0x04)

  let simd_type = function
    | V128Type -> vs7 (-0x05)

  let ref_type = function
    | FuncRefType -> vs7 (-0x10)
    | ExternRefType -> vs7 (-0x11)

  let value_type = function
    | NumType t -> num_type t
    | SimdType t -> simd_type t
    | RefType t -> ref_type t

  let func_type = function
    | FuncType (ts1, ts2) ->
      vs7 (-0x20); vec value_type ts1; vec value_type ts2

  let limits vu {min; max} =
    bool (max <> None); vu min; opt vu max

  let table_type = function
    | TableType (lim, t) -> ref_type t; limits vu32 lim

  let memory_type = function
    | MemoryType lim -> limits vu32 lim

  let mutability = function
    | Immutable -> u8 0
    | Mutable -> u8 1

  let global_type = function
    | GlobalType (t, mut) -> value_type t; mutability mut

  (* Expressions *)

  open Source
  open Ast
  open Values
  open Simd

  let op n = u8 n
  let simd_op n = op 0xfd; vu32 n
  let end_ () = op 0x0b

  let memop {align; offset; _} = vu32 (Int32.of_int align); vu32 offset

  let var x = vu32 x.it

  let block_type = function
    | VarBlockType x -> vs33 x.it
    | ValBlockType None -> vs7 (-0x40)
    | ValBlockType (Some t) -> value_type t

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

    | Br x -> op 0x0c; var x
    | BrIf x -> op 0x0d; var x
    | BrTable (xs, x) -> op 0x0e; vec var xs; var x
    | Return -> op 0x0f
    | Call x -> op 0x10; var x
    | CallIndirect (x, y) -> op 0x11; var y; var x

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

    | Load ({ty = I32Type; pack = None; _} as mo) -> op 0x28; memop mo
    | Load ({ty = I64Type; pack = None; _} as mo) -> op 0x29; memop mo
    | Load ({ty = F32Type; pack = None; _} as mo) -> op 0x2a; memop mo
    | Load ({ty = F64Type; pack = None; _} as mo) -> op 0x2b; memop mo
    | Load ({ty = I32Type; pack = Some (Pack8, SX); _} as mo) ->
      op 0x2c; memop mo
    | Load ({ty = I32Type; pack = Some (Pack8, ZX); _} as mo) ->
      op 0x2d; memop mo
    | Load ({ty = I32Type; pack = Some (Pack16, SX); _} as mo) ->
      op 0x2e; memop mo
    | Load ({ty = I32Type; pack = Some (Pack16, ZX); _} as mo) ->
      op 0x2f; memop mo
    | Load {ty = I32Type; pack = Some (Pack32, _); _} ->
      assert false
    | Load ({ty = I64Type; pack = Some (Pack8, SX); _} as mo) ->
      op 0x30; memop mo
    | Load ({ty = I64Type; pack = Some (Pack8, ZX); _} as mo) ->
      op 0x31; memop mo
    | Load ({ty = I64Type; pack = Some (Pack16, SX); _} as mo) ->
      op 0x32; memop mo
    | Load ({ty = I64Type; pack = Some (Pack16, ZX); _} as mo) ->
      op 0x33; memop mo
    | Load ({ty = I64Type; pack = Some (Pack32, SX); _} as mo) ->
      op 0x34; memop mo
    | Load ({ty = I64Type; pack = Some (Pack32, ZX); _} as mo) ->
      op 0x35; memop mo
    | Load {ty = F32Type | F64Type; pack = Some _; _} ->
      assert false
    | Load {ty = I32Type | I64Type; pack = Some (Pack64, _); _} ->
      assert false

    | Store ({ty = I32Type; pack = None; _} as mo) -> op 0x36; memop mo
    | Store ({ty = I64Type; pack = None; _} as mo) -> op 0x37; memop mo
    | Store ({ty = F32Type; pack = None; _} as mo) -> op 0x38; memop mo
    | Store ({ty = F64Type; pack = None; _} as mo) -> op 0x39; memop mo
    | Store ({ty = I32Type; pack = Some Pack8; _} as mo) -> op 0x3a; memop mo
    | Store ({ty = I32Type; pack = Some Pack16; _} as mo) -> op 0x3b; memop mo
    | Store {ty = I32Type; pack = Some Pack32; _} -> assert false
    | Store ({ty = I64Type; pack = Some Pack8; _} as mo) -> op 0x3c; memop mo
    | Store ({ty = I64Type; pack = Some Pack16; _} as mo) -> op 0x3d; memop mo
    | Store ({ty = I64Type; pack = Some Pack32; _} as mo) -> op 0x3e; memop mo
    | Store {ty = F32Type | F64Type; pack = Some _; _} -> assert false
    | Store {ty = (I32Type | I64Type); pack = Some Pack64; _} -> assert false

    | SimdLoad ({ty = V128Type; pack = None; _} as mo) ->
      simd_op 0x00l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack8x8, SX)); _} as mo) ->
      simd_op 0x01l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack8x8, ZX)); _} as mo) ->
      simd_op 0x02l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack16x4, SX)); _} as mo) ->
      simd_op 0x03l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack16x4, ZX)); _} as mo) ->
      simd_op 0x04l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack32x2, SX)); _} as mo) ->
      simd_op 0x05l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtLane (Pack32x2, ZX)); _} as mo) ->
      simd_op 0x06l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack8, ExtSplat); _} as mo) ->
      simd_op 0x07l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack16, ExtSplat); _} as mo) ->
      simd_op 0x08l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack32, ExtSplat); _} as mo) ->
      simd_op 0x09l; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtSplat); _} as mo) ->
      simd_op 0x0al; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack32, ExtZero); _} as mo) ->
      simd_op 0x5cl; memop mo
    | SimdLoad ({ty = V128Type; pack = Some (Pack64, ExtZero); _} as mo) ->
      simd_op 0x5dl; memop mo
    | SimdLoad _ -> assert false

    | SimdLoadLane ({ty = V128Type; pack = Pack8; _} as mo, i) ->
      simd_op 0x54l; memop mo; u8 i;
    | SimdLoadLane ({ty = V128Type; pack = Pack16; _} as mo, i) ->
      simd_op 0x55l; memop mo; u8 i;
    | SimdLoadLane ({ty = V128Type; pack = Pack32; _} as mo, i) ->
      simd_op 0x56l; memop mo; u8 i;
    | SimdLoadLane ({ty = V128Type; pack = Pack64; _} as mo, i) ->
      simd_op 0x57l; memop mo; u8 i;

    | SimdStore ({ty = V128Type; _} as mo) -> simd_op 0x0bl; memop mo

    | SimdStoreLane ({ty = V128Type; pack = Pack8; _} as mo, i) ->
      simd_op 0x58l; memop mo; u8 i;
    | SimdStoreLane ({ty = V128Type; pack = Pack16; _} as mo, i) ->
      simd_op 0x59l; memop mo; u8 i;
    | SimdStoreLane ({ty = V128Type; pack = Pack32; _} as mo, i) ->
      simd_op 0x5al; memop mo; u8 i;
    | SimdStoreLane ({ty = V128Type; pack = Pack64; _} as mo, i) ->
      simd_op 0x5bl; memop mo; u8 i;

    | MemorySize -> op 0x3f; u8 0x00
    | MemoryGrow -> op 0x40; u8 0x00
    | MemoryFill -> op 0xfc; vu32 0x0bl; u8 0x00
    | MemoryCopy -> op 0xfc; vu32 0x0al; u8 0x00; u8 0x00
    | MemoryInit x -> op 0xfc; vu32 0x08l; var x; u8 0x00
    | DataDrop x -> op 0xfc; vu32 0x09l; var x

    | RefNull t -> op 0xd0; ref_type t
    | RefIsNull -> op 0xd1
    | RefFunc x -> op 0xd2; var x

    | Const {it = I32 c; _} -> op 0x41; vs32 c
    | Const {it = I64 c; _} -> op 0x42; vs64 c
    | Const {it = F32 c; _} -> op 0x43; f32 c
    | Const {it = F64 c; _} -> op 0x44; f64 c

    | Test (I32 I32Op.Eqz) -> op 0x45
    | Test (I64 I64Op.Eqz) -> op 0x50
    | Test (F32 _ | F64 _) -> .

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
    | Unary (I32 (I32Op.ExtendS (Pack32 | Pack64))) -> assert false

    | Unary (I64 I64Op.Clz) -> op 0x79
    | Unary (I64 I64Op.Ctz) -> op 0x7a
    | Unary (I64 I64Op.Popcnt) -> op 0x7b
    | Unary (I64 (I64Op.ExtendS Pack8)) -> op 0xc2
    | Unary (I64 (I64Op.ExtendS Pack16)) -> op 0xc3
    | Unary (I64 (I64Op.ExtendS Pack32)) -> op 0xc4
    | Unary (I64 (I64Op.ExtendS Pack64)) -> assert false

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

    | SimdConst {it = V128 c; _} -> simd_op 0x0cl; v128 c

    | SimdTest (V128 V128Op.(I8x16 AllTrue)) -> simd_op 0x63l
    | SimdTest (V128 V128Op.(I16x8 AllTrue)) -> simd_op 0x83l
    | SimdTest (V128 V128Op.(I32x4 AllTrue)) -> simd_op 0xa3l
    | SimdTest (V128 V128Op.(I64x2 AllTrue)) -> simd_op 0xc3l
    | SimdTest (V128 _) -> .

    | SimdUnary (V128 V128Op.(I8x16 Abs)) -> simd_op 0x60l
    | SimdUnary (V128 V128Op.(I8x16 Neg)) -> simd_op 0x61l
    | SimdUnary (V128 V128Op.(I8x16 Popcnt)) -> simd_op 0x62l
    | SimdUnary (V128 V128Op.(I16x8 Abs)) -> simd_op 0x80l
    | SimdUnary (V128 V128Op.(I16x8 Neg)) -> simd_op 0x81l
    | SimdUnary (V128 V128Op.(I16x8 ExtendLowS)) -> simd_op 0x87l
    | SimdUnary (V128 V128Op.(I16x8 ExtendHighS)) -> simd_op 0x88l
    | SimdUnary (V128 V128Op.(I16x8 ExtendLowU)) -> simd_op 0x89l
    | SimdUnary (V128 V128Op.(I16x8 ExtendHighU)) -> simd_op 0x8al
    | SimdUnary (V128 V128Op.(I16x8 ExtAddPairwiseS)) -> simd_op 0x7cl
    | SimdUnary (V128 V128Op.(I16x8 ExtAddPairwiseU)) -> simd_op 0x7dl
    | SimdUnary (V128 V128Op.(I32x4 Abs)) -> simd_op 0xa0l
    | SimdUnary (V128 V128Op.(I32x4 Neg)) -> simd_op 0xa1l
    | SimdUnary (V128 V128Op.(I32x4 ExtendLowS)) -> simd_op 0xa7l
    | SimdUnary (V128 V128Op.(I32x4 ExtendHighS)) -> simd_op 0xa8l
    | SimdUnary (V128 V128Op.(I32x4 ExtendLowU)) -> simd_op 0xa9l
    | SimdUnary (V128 V128Op.(I32x4 ExtendHighU)) -> simd_op 0xaal
    | SimdUnary (V128 V128Op.(I32x4 ExtAddPairwiseS)) -> simd_op 0x7el
    | SimdUnary (V128 V128Op.(I32x4 ExtAddPairwiseU)) -> simd_op 0x7fl
    | SimdUnary (V128 V128Op.(I64x2 Abs)) -> simd_op 0xc0l
    | SimdUnary (V128 V128Op.(I64x2 Neg)) -> simd_op 0xc1l
    | SimdUnary (V128 V128Op.(I64x2 ExtendLowS)) -> simd_op 0xc7l
    | SimdUnary (V128 V128Op.(I64x2 ExtendHighS)) -> simd_op 0xc8l
    | SimdUnary (V128 V128Op.(I64x2 ExtendLowU)) -> simd_op 0xc9l
    | SimdUnary (V128 V128Op.(I64x2 ExtendHighU)) -> simd_op 0xcal
    | SimdUnary (V128 V128Op.(F32x4 Ceil)) -> simd_op 0x67l
    | SimdUnary (V128 V128Op.(F32x4 Floor)) -> simd_op 0x68l
    | SimdUnary (V128 V128Op.(F32x4 Trunc)) -> simd_op 0x69l
    | SimdUnary (V128 V128Op.(F32x4 Nearest)) -> simd_op 0x6al
    | SimdUnary (V128 V128Op.(F64x2 Ceil)) -> simd_op 0x74l
    | SimdUnary (V128 V128Op.(F64x2 Floor)) -> simd_op 0x75l
    | SimdUnary (V128 V128Op.(F64x2 Trunc)) -> simd_op 0x7al
    | SimdUnary (V128 V128Op.(F64x2 Nearest)) -> simd_op 0x94l
    | SimdUnary (V128 V128Op.(F32x4 Abs)) -> simd_op 0xe0l
    | SimdUnary (V128 V128Op.(F32x4 Neg)) -> simd_op 0xe1l
    | SimdUnary (V128 V128Op.(F32x4 Sqrt)) -> simd_op 0xe3l
    | SimdUnary (V128 V128Op.(F64x2 Abs)) -> simd_op 0xecl
    | SimdUnary (V128 V128Op.(F64x2 Neg)) -> simd_op 0xedl
    | SimdUnary (V128 V128Op.(F64x2 Sqrt)) -> simd_op 0xefl
    | SimdUnary (V128 V128Op.(I32x4 TruncSatSF32x4)) -> simd_op 0xf8l
    | SimdUnary (V128 V128Op.(I32x4 TruncSatUF32x4)) -> simd_op 0xf9l
    | SimdUnary (V128 V128Op.(I32x4 TruncSatSZeroF64x2)) -> simd_op 0xfcl
    | SimdUnary (V128 V128Op.(I32x4 TruncSatUZeroF64x2)) -> simd_op 0xfdl
    | SimdUnary (V128 V128Op.(F32x4 ConvertSI32x4)) -> simd_op 0xfal
    | SimdUnary (V128 V128Op.(F32x4 ConvertUI32x4)) -> simd_op 0xfbl
    | SimdUnary (V128 V128Op.(F32x4 DemoteZeroF64x2)) -> simd_op 0x5el
    | SimdUnary (V128 V128Op.(F64x2 PromoteLowF32x4)) -> simd_op 0x5fl
    | SimdUnary (V128 V128Op.(F64x2 ConvertSI32x4)) -> simd_op 0xfel
    | SimdUnary (V128 V128Op.(F64x2 ConvertUI32x4)) -> simd_op 0xffl
    | SimdUnary (V128 _) -> assert false

    | SimdBinary (V128 V128Op.(I8x16 (Shuffle is))) -> simd_op 0x0dl; List.iter u8 is
    | SimdBinary (V128 V128Op.(I8x16 Swizzle)) -> simd_op 0x0el
    | SimdBinary (V128 V128Op.(I8x16 Eq)) -> simd_op 0x23l
    | SimdBinary (V128 V128Op.(I8x16 Ne)) -> simd_op 0x24l
    | SimdBinary (V128 V128Op.(I8x16 LtS)) -> simd_op 0x25l
    | SimdBinary (V128 V128Op.(I8x16 LtU)) -> simd_op 0x26l
    | SimdBinary (V128 V128Op.(I8x16 GtS)) -> simd_op 0x27l
    | SimdBinary (V128 V128Op.(I8x16 GtU)) -> simd_op 0x28l
    | SimdBinary (V128 V128Op.(I8x16 LeS)) -> simd_op 0x29l
    | SimdBinary (V128 V128Op.(I8x16 LeU)) -> simd_op 0x2al
    | SimdBinary (V128 V128Op.(I8x16 GeS)) -> simd_op 0x2bl
    | SimdBinary (V128 V128Op.(I8x16 GeU)) -> simd_op 0x2cl
    | SimdBinary (V128 V128Op.(I8x16 NarrowS)) -> simd_op 0x65l
    | SimdBinary (V128 V128Op.(I8x16 NarrowU)) -> simd_op 0x66l
    | SimdBinary (V128 V128Op.(I8x16 Add)) -> simd_op 0x6el
    | SimdBinary (V128 V128Op.(I8x16 AddSatS)) -> simd_op 0x6fl
    | SimdBinary (V128 V128Op.(I8x16 AddSatU)) -> simd_op 0x70l
    | SimdBinary (V128 V128Op.(I8x16 Sub)) -> simd_op 0x71l
    | SimdBinary (V128 V128Op.(I8x16 SubSatS)) -> simd_op 0x72l
    | SimdBinary (V128 V128Op.(I8x16 SubSatU)) -> simd_op 0x73l
    | SimdBinary (V128 V128Op.(I8x16 MinS)) -> simd_op 0x76l
    | SimdBinary (V128 V128Op.(I8x16 MinU)) -> simd_op 0x77l
    | SimdBinary (V128 V128Op.(I8x16 MaxS)) -> simd_op 0x78l
    | SimdBinary (V128 V128Op.(I8x16 MaxU)) -> simd_op 0x79l
    | SimdBinary (V128 V128Op.(I8x16 AvgrU)) -> simd_op 0x7bl
    | SimdBinary (V128 V128Op.(I16x8 Eq)) -> simd_op 0x2dl
    | SimdBinary (V128 V128Op.(I16x8 Ne)) -> simd_op 0x2el
    | SimdBinary (V128 V128Op.(I16x8 LtS)) -> simd_op 0x2fl
    | SimdBinary (V128 V128Op.(I16x8 LtU)) -> simd_op 0x30l
    | SimdBinary (V128 V128Op.(I16x8 GtS)) -> simd_op 0x31l
    | SimdBinary (V128 V128Op.(I16x8 GtU)) -> simd_op 0x32l
    | SimdBinary (V128 V128Op.(I16x8 LeS)) -> simd_op 0x33l
    | SimdBinary (V128 V128Op.(I16x8 LeU)) -> simd_op 0x34l
    | SimdBinary (V128 V128Op.(I16x8 GeS)) -> simd_op 0x35l
    | SimdBinary (V128 V128Op.(I16x8 GeU)) -> simd_op 0x36l
    | SimdBinary (V128 V128Op.(I16x8 NarrowS)) -> simd_op 0x85l
    | SimdBinary (V128 V128Op.(I16x8 NarrowU)) -> simd_op 0x86l
    | SimdBinary (V128 V128Op.(I16x8 Add)) -> simd_op 0x8el
    | SimdBinary (V128 V128Op.(I16x8 AddSatS)) -> simd_op 0x8fl
    | SimdBinary (V128 V128Op.(I16x8 AddSatU)) -> simd_op 0x90l
    | SimdBinary (V128 V128Op.(I16x8 Sub)) -> simd_op 0x91l
    | SimdBinary (V128 V128Op.(I16x8 SubSatS)) -> simd_op 0x92l
    | SimdBinary (V128 V128Op.(I16x8 SubSatU)) -> simd_op 0x93l
    | SimdBinary (V128 V128Op.(I16x8 Mul)) -> simd_op 0x95l
    | SimdBinary (V128 V128Op.(I16x8 MinS)) -> simd_op 0x96l
    | SimdBinary (V128 V128Op.(I16x8 MinU)) -> simd_op 0x97l
    | SimdBinary (V128 V128Op.(I16x8 MaxS)) -> simd_op 0x98l
    | SimdBinary (V128 V128Op.(I16x8 MaxU)) -> simd_op 0x99l
    | SimdBinary (V128 V128Op.(I16x8 AvgrU)) -> simd_op 0x9bl
    | SimdBinary (V128 V128Op.(I16x8 ExtMulLowS)) -> simd_op 0x9cl
    | SimdBinary (V128 V128Op.(I16x8 ExtMulHighS)) -> simd_op 0x9dl
    | SimdBinary (V128 V128Op.(I16x8 ExtMulLowU)) -> simd_op 0x9el
    | SimdBinary (V128 V128Op.(I16x8 ExtMulHighU)) -> simd_op 0x9fl
    | SimdBinary (V128 V128Op.(I16x8 Q15MulRSatS)) -> simd_op 0x82l
    | SimdBinary (V128 V128Op.(I32x4 Add)) -> simd_op 0xael
    | SimdBinary (V128 V128Op.(I32x4 Sub)) -> simd_op 0xb1l
    | SimdBinary (V128 V128Op.(I32x4 MinS)) -> simd_op 0xb6l
    | SimdBinary (V128 V128Op.(I32x4 MinU)) -> simd_op 0xb7l
    | SimdBinary (V128 V128Op.(I32x4 MaxS)) -> simd_op 0xb8l
    | SimdBinary (V128 V128Op.(I32x4 MaxU)) -> simd_op 0xb9l
    | SimdBinary (V128 V128Op.(I32x4 DotS)) -> simd_op 0xbal
    | SimdBinary (V128 V128Op.(I32x4 Mul)) -> simd_op 0xb5l
    | SimdBinary (V128 V128Op.(I32x4 Eq)) -> simd_op 0x37l
    | SimdBinary (V128 V128Op.(I32x4 Ne)) -> simd_op 0x38l
    | SimdBinary (V128 V128Op.(I32x4 LtS)) -> simd_op 0x39l
    | SimdBinary (V128 V128Op.(I32x4 LtU)) -> simd_op 0x3al
    | SimdBinary (V128 V128Op.(I32x4 GtS)) -> simd_op 0x3bl
    | SimdBinary (V128 V128Op.(I32x4 GtU)) -> simd_op 0x3cl
    | SimdBinary (V128 V128Op.(I32x4 LeS)) -> simd_op 0x3dl
    | SimdBinary (V128 V128Op.(I32x4 LeU)) -> simd_op 0x3el
    | SimdBinary (V128 V128Op.(I32x4 GeS)) -> simd_op 0x3fl
    | SimdBinary (V128 V128Op.(I32x4 GeU)) -> simd_op 0x40l
    | SimdBinary (V128 V128Op.(I32x4 ExtMulLowS)) -> simd_op 0xbcl
    | SimdBinary (V128 V128Op.(I32x4 ExtMulHighS)) -> simd_op 0xbdl
    | SimdBinary (V128 V128Op.(I32x4 ExtMulLowU)) -> simd_op 0xbel
    | SimdBinary (V128 V128Op.(I32x4 ExtMulHighU)) -> simd_op 0xbfl
    | SimdBinary (V128 V128Op.(I64x2 Add)) -> simd_op 0xcel
    | SimdBinary (V128 V128Op.(I64x2 Sub)) -> simd_op 0xd1l
    | SimdBinary (V128 V128Op.(I64x2 Mul)) -> simd_op 0xd5l
    | SimdBinary (V128 V128Op.(I64x2 Eq)) -> simd_op 0xd6l
    | SimdBinary (V128 V128Op.(I64x2 Ne)) -> simd_op 0xd7l
    | SimdBinary (V128 V128Op.(I64x2 LtS)) -> simd_op 0xd8l
    | SimdBinary (V128 V128Op.(I64x2 GtS)) -> simd_op 0xd9l
    | SimdBinary (V128 V128Op.(I64x2 LeS)) -> simd_op 0xdal
    | SimdBinary (V128 V128Op.(I64x2 GeS)) -> simd_op 0xdbl
    | SimdBinary (V128 V128Op.(I64x2 ExtMulLowS)) -> simd_op 0xdcl
    | SimdBinary (V128 V128Op.(I64x2 ExtMulHighS)) -> simd_op 0xddl
    | SimdBinary (V128 V128Op.(I64x2 ExtMulLowU)) -> simd_op 0xdel
    | SimdBinary (V128 V128Op.(I64x2 ExtMulHighU)) -> simd_op 0xdfl
    | SimdBinary (V128 V128Op.(F32x4 Eq)) -> simd_op 0x41l
    | SimdBinary (V128 V128Op.(F32x4 Ne)) -> simd_op 0x42l
    | SimdBinary (V128 V128Op.(F32x4 Lt)) -> simd_op 0x43l
    | SimdBinary (V128 V128Op.(F32x4 Gt)) -> simd_op 0x44l
    | SimdBinary (V128 V128Op.(F32x4 Le)) -> simd_op 0x45l
    | SimdBinary (V128 V128Op.(F32x4 Ge)) -> simd_op 0x46l
    | SimdBinary (V128 V128Op.(F32x4 Add)) -> simd_op 0xe4l
    | SimdBinary (V128 V128Op.(F32x4 Sub)) -> simd_op 0xe5l
    | SimdBinary (V128 V128Op.(F32x4 Mul)) -> simd_op 0xe6l
    | SimdBinary (V128 V128Op.(F32x4 Div)) -> simd_op 0xe7l
    | SimdBinary (V128 V128Op.(F32x4 Min)) -> simd_op 0xe8l
    | SimdBinary (V128 V128Op.(F32x4 Max)) -> simd_op 0xe9l
    | SimdBinary (V128 V128Op.(F32x4 Pmin)) -> simd_op 0xeal
    | SimdBinary (V128 V128Op.(F32x4 Pmax)) -> simd_op 0xebl
    | SimdBinary (V128 V128Op.(F64x2 Eq)) -> simd_op 0x47l
    | SimdBinary (V128 V128Op.(F64x2 Ne)) -> simd_op 0x48l
    | SimdBinary (V128 V128Op.(F64x2 Lt)) -> simd_op 0x49l
    | SimdBinary (V128 V128Op.(F64x2 Gt)) -> simd_op 0x4al
    | SimdBinary (V128 V128Op.(F64x2 Le)) -> simd_op 0x4bl
    | SimdBinary (V128 V128Op.(F64x2 Ge)) -> simd_op 0x4cl
    | SimdBinary (V128 V128Op.(F64x2 Add)) -> simd_op 0xf0l
    | SimdBinary (V128 V128Op.(F64x2 Sub)) -> simd_op 0xf1l
    | SimdBinary (V128 V128Op.(F64x2 Mul)) -> simd_op 0xf2l
    | SimdBinary (V128 V128Op.(F64x2 Div)) -> simd_op 0xf3l
    | SimdBinary (V128 V128Op.(F64x2 Min)) -> simd_op 0xf4l
    | SimdBinary (V128 V128Op.(F64x2 Max)) -> simd_op 0xf5l
    | SimdBinary (V128 V128Op.(F64x2 Pmin)) -> simd_op 0xf6l
    | SimdBinary (V128 V128Op.(F64x2 Pmax)) -> simd_op 0xf7l
    | SimdBinary (V128 _) -> assert false

    | SimdTestVec (V128 V128Op.AnyTrue) -> simd_op 0x53l
    | SimdUnaryVec (V128 V128Op.Not) -> simd_op 0x4dl
    | SimdBinaryVec (V128 V128Op.And) -> simd_op 0x4el
    | SimdBinaryVec (V128 V128Op.AndNot) -> simd_op 0x4fl
    | SimdBinaryVec (V128 V128Op.Or) -> simd_op 0x50l
    | SimdBinaryVec (V128 V128Op.Xor) -> simd_op 0x51l
    | SimdTernaryVec (V128 V128Op.Bitselect) -> simd_op 0x52l

    | SimdShift (V128 V128Op.(I8x16 Shl)) -> simd_op 0x6bl
    | SimdShift (V128 V128Op.(I8x16 ShrS)) -> simd_op 0x6cl
    | SimdShift (V128 V128Op.(I8x16 ShrU)) -> simd_op 0x6dl
    | SimdShift (V128 V128Op.(I16x8 Shl)) -> simd_op 0x8bl
    | SimdShift (V128 V128Op.(I16x8 ShrS)) -> simd_op 0x8cl
    | SimdShift (V128 V128Op.(I16x8 ShrU)) -> simd_op 0x8dl
    | SimdShift (V128 V128Op.(I32x4 Shl)) -> simd_op 0xabl
    | SimdShift (V128 V128Op.(I32x4 ShrS)) -> simd_op 0xacl
    | SimdShift (V128 V128Op.(I32x4 ShrU)) -> simd_op 0xadl
    | SimdShift (V128 V128Op.(I64x2 Shl)) -> simd_op 0xcbl
    | SimdShift (V128 V128Op.(I64x2 ShrS)) -> simd_op 0xccl
    | SimdShift (V128 V128Op.(I64x2 ShrU)) -> simd_op 0xcdl
    | SimdShift (V128 _) -> .

    | SimdBitmask (V128 V128Op.(I8x16 Bitmask)) -> simd_op 0x64l
    | SimdBitmask (V128 V128Op.(I16x8 Bitmask)) -> simd_op 0x84l
    | SimdBitmask (V128 V128Op.(I32x4 Bitmask)) -> simd_op 0xa4l
    | SimdBitmask (V128 V128Op.(I64x2 Bitmask)) -> simd_op 0xc4l
    | SimdBitmask (V128 _) -> .

    | SimdSplat (V128 (V128Op.(I8x16 Splat))) -> simd_op 0x0fl
    | SimdSplat (V128 (V128Op.(I16x8 Splat))) -> simd_op 0x10l
    | SimdSplat (V128 (V128Op.(I32x4 Splat))) -> simd_op 0x11l
    | SimdSplat (V128 (V128Op.(I64x2 Splat))) -> simd_op 0x12l
    | SimdSplat (V128 (V128Op.(F32x4 Splat))) -> simd_op 0x13l
    | SimdSplat (V128 (V128Op.(F64x2 Splat))) -> simd_op 0x14l

    | SimdExtract (V128 V128Op.(I8x16 (Extract (i, SX)))) -> simd_op 0x15l; u8 i
    | SimdExtract (V128 V128Op.(I8x16 (Extract (i, ZX)))) -> simd_op 0x16l; u8 i
    | SimdExtract (V128 V128Op.(I16x8 (Extract (i, SX)))) -> simd_op 0x18l; u8 i
    | SimdExtract (V128 V128Op.(I16x8 (Extract (i, ZX)))) -> simd_op 0x19l; u8 i
    | SimdExtract (V128 V128Op.(I32x4 (Extract (i, ())))) -> simd_op 0x1bl; u8 i
    | SimdExtract (V128 V128Op.(I64x2 (Extract (i, ())))) -> simd_op 0x1dl; u8 i
    | SimdExtract (V128 V128Op.(F32x4 (Extract (i, ())))) -> simd_op 0x1fl; u8 i
    | SimdExtract (V128 V128Op.(F64x2 (Extract (i, ())))) -> simd_op 0x21l; u8 i

    | SimdReplace (V128 V128Op.(I8x16 (Replace i))) -> simd_op 0x17l; u8 i
    | SimdReplace (V128 V128Op.(I16x8 (Replace i))) -> simd_op 0x1al; u8 i
    | SimdReplace (V128 V128Op.(I32x4 (Replace i))) -> simd_op 0x1cl; u8 i
    | SimdReplace (V128 V128Op.(I64x2 (Replace i))) -> simd_op 0x1el; u8 i
    | SimdReplace (V128 V128Op.(F32x4 (Replace i))) -> simd_op 0x20l; u8 i
    | SimdReplace (V128 V128Op.(F64x2 (Replace i))) -> simd_op 0x22l; u8 i

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
  let type_ t = func_type t.it

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
  let compress ts =
    let combine t = function
      | (t', n) :: ts when t = t' -> (t, n + 1) :: ts
      | ts -> (t, 1) :: ts
    in List.fold_right combine ts []

  let local (t, n) = len n; value_type t

  let code f =
    let {locals; body; _} = f.it in
    let g = gap32 () in
    let p = pos s in
    vec local (compress locals);
    list instr body;
    end_ ();
    patch_gap32 g (pos s - p)

  let code_section fs =
    section 10 (vec code) fs (fs <> [])

  (* Element section *)
  let is_elem_kind = function
    | FuncRefType -> true
    | _ -> false

  let elem_kind = function
    | FuncRefType -> u8 0x00
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
      | Active {index; offset} when index.it = 0l && etype = FuncRefType ->
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
      | Active {index; offset} when index.it = 0l && etype = FuncRefType ->
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
