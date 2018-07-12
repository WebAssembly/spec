
open Source
open Ast
open Types
open Values
open Merkle 

(* just simply merge two files *)

let do_it x f = {x with it=f x.it}

let simple_add n i = Int32.add i (Int32.of_int n)

let merge a b =
  let funcs_a = a.it.funcs in
  let num = List.length (Merkle.func_imports a) + List.length funcs_a in
  let num_ft = List.length a.it.types in
  let funcs_b = List.map (Merge.remap (simple_add num) (fun x -> x) (simple_add num_ft)) b.it.funcs in
  {a with it={(a.it) with funcs = funcs_a@funcs_b;
     globals = a.it.globals @ b.it.globals;
     imports = a.it.imports;
     exports = a.it.exports@List.filter Merge.drop_table (List.map (Merge.remap_export (simple_add num) (fun x -> x) (simple_add num_ft) "") b.it.exports);
     elems = a.it.elems;
     types=a.it.types@b.it.types;
     data=a.it.data@b.it.data@[Addglobals.generate_data (256, !Flags.memory_offset)]}}

let convert_type' = function
 | I32Type -> I32Type
 | F32Type -> I32Type
 | I64Type -> I64Type
 | F64Type -> I64Type

let convert_type t = do_it t convert_type'

let convert_ftype ft =
  do_it ft (function FuncType (l1, l2) -> FuncType (List.map convert_type' l1, List.map convert_type' l2))

let convert_gtype = function GlobalType (t,mut) -> GlobalType (convert_type' t, mut)

let rec convert_inst' = function
 | Block (ty, lst) -> Block (List.map convert_type' ty, List.map convert_inst lst) 
 | Loop (ty, lst) -> Loop (List.map convert_type' ty, List.map convert_inst lst)
 | If (ty, texp, fexp) -> If (List.map convert_type' ty, List.map convert_inst texp, List.map convert_inst fexp)
 | a -> a

and convert_inst x = do_it x (fun x -> convert_inst' x)

let convert_func f =
  do_it f (fun f -> {f with body=List.map convert_inst f.body; locals=List.map convert_type' f.locals})

(* convert all types *)
let convert_types m =
  (* also constants have to be converted *)
  do_it m (fun m ->
    {m with types=List.map convert_ftype m.types;
            funcs=List.map convert_func m.funcs})

(* perhaps just the types inside softfloat should be changed? but how to make only in interface? *)

(* exported function by name *)
let find_function m (name:string) =
  let rec find = function
   | [] ->
     Run.trace ("Not found " ^ name);
     raise Not_found
   | a::tl ->
     if Utf8.encode a.it.name = name then
       ( match a.it.edesc.it with
       | FuncExport v -> v.it
       | _ -> find tl )
     else find tl in
  {it=find m.it.exports; at=no_region}

(* add ops ... *)

let convert_float m =
  let rec convert_op' = function
   | Block (ty, lst) -> [Block (ty, convert_body lst)]
   | Loop (ty, lst) -> [Loop (ty, convert_body lst)]
   | If (ty, texp, fexp) -> [If (ty, convert_body texp, convert_body fexp)]

   | Store ({ty=F32Type; _} as op) -> [Store {op with ty=I32Type}]
   | Load ({ty=F32Type; _} as op) -> [Load {op with ty=I32Type}]
   | Store ({ty=F64Type; _} as op) -> [Store {op with ty=I64Type}]
   | Load ({ty=F64Type; _} as op) -> [Load {op with ty=I64Type}]

   | Binary (F32 F32Op.Add) -> [Call (find_function m "f32_add")]
   | Binary (F32 F32Op.Div) -> [Call (find_function m "f32_div")]
   | Binary (F32 F32Op.Mul) -> [Call (find_function m "f32_mul")]
   | Binary (F32 F32Op.Sub) -> [Call (find_function m "f32_sub")]
   | Binary (F32 F32Op.Min) -> [Call (find_function m "f32_min")]
   | Binary (F32 F32Op.Max) -> [Call (find_function m "f32_max")]
   | Unary (F32 F32Op.Sqrt) -> [Call (find_function m "f32_sqrt")]
   | Unary (F32 F32Op.Nearest) -> [Call (find_function m "f32_nearest")]
   | Unary (F32 F32Op.Ceil) -> [Call (find_function m "f32_ceil")]
   | Unary (F32 F32Op.Floor) -> [Call (find_function m "f32_floor")]
   | Unary (F32 F32Op.Trunc) -> [Call (find_function m "f32_trunc")]
   | Unary (F32 F32Op.Neg) -> [Call (find_function m "f32_neg")]
   | Unary (F32 F32Op.Abs) -> [Call (find_function m "f32_abs")]
   | Compare (F32 F32Op.Eq) -> [Call (find_function m "f32_eq")]
   | Compare (F32 F32Op.Le) -> [Call (find_function m "f32_le")]
   | Compare (F32 F32Op.Lt) -> [Call (find_function m "f32_lt")]
   | Compare (F32 F32Op.Ne) -> [Call (find_function m "f32_ne")]
   | Compare (F32 F32Op.Ge) -> [Call (find_function m "f32_ge")]
   | Compare (F32 F32Op.Gt) -> [Call (find_function m "f32_gt")]

   | Binary (F64 F64Op.Add) -> [Call (find_function m "f64_add")]
   | Binary (F64 F64Op.Div) -> [Call (find_function m "f64_div")]
   | Binary (F64 F64Op.Mul) -> [Call (find_function m "f64_mul")]
   | Binary (F64 F64Op.Sub) -> [Call (find_function m "f64_sub")]
   | Binary (F64 F64Op.Min) -> [Call (find_function m "f64_min")]
   | Binary (F64 F64Op.Max) -> [Call (find_function m "f64_max")]
   | Unary (F64 F64Op.Sqrt) -> [Call (find_function m "f64_sqrt")]
   | Unary (F64 F64Op.Nearest) -> [Call (find_function m "f64_nearest")]
   | Unary (F64 F64Op.Ceil) -> [Call (find_function m "f64_ceil")]
   | Unary (F64 F64Op.Floor) -> [Call (find_function m "f64_floor")]
   | Unary (F64 F64Op.Trunc) -> [Call (find_function m "f64_trunc")]
   | Unary (F64 F64Op.Neg) -> [Call (find_function m "f64_neg")]
   | Unary (F64 F64Op.Abs) -> [Call (find_function m "f64_abs")]
   | Compare (F64 F64Op.Eq) -> [Call (find_function m "f64_eq")]
   | Compare (F64 F64Op.Le) -> [Call (find_function m "f64_le")]
   | Compare (F64 F64Op.Lt) -> [Call (find_function m "f64_lt")]
   | Compare (F64 F64Op.Ne) -> [Call (find_function m "f64_ne")]
   | Compare (F64 F64Op.Ge) -> [Call (find_function m "f64_ge")]
   | Compare (F64 F64Op.Gt) -> [Call (find_function m "f64_gt")]

   | Convert (F32 F32Op.ReinterpretInt) -> []
   | Convert (F64 F64Op.ReinterpretInt) -> []
   | Convert (I32 I32Op.ReinterpretFloat) -> []
   | Convert (I64 I64Op.ReinterpretFloat) -> []
   | Convert (F32 F32Op.ConvertSI32) -> [Call (find_function m "i32_to_f32")]
   | Convert (F32 F32Op.ConvertUI32) -> [Call (find_function m "ui32_to_f32")]
   | Convert (F64 F64Op.ConvertSI32) -> [Call (find_function m "i32_to_f64")]
   | Convert (F64 F64Op.ConvertUI32) -> [Call (find_function m "ui32_to_f64")]
   | Convert (F32 F32Op.ConvertSI64) -> [Call (find_function m "i64_to_f32")]
   | Convert (F32 F32Op.ConvertUI64) -> [Call (find_function m "ui64_to_f32")]
   | Convert (F64 F64Op.ConvertSI64) -> [Call (find_function m "i64_to_f64")]
   | Convert (F64 F64Op.ConvertUI64) -> [Call (find_function m "ui64_to_f64")]
   | Convert (F64 F64Op.DemoteF64) -> [Call (find_function m "f64_to_f32")]
   | Convert (F32 F32Op.DemoteF64) -> [Call (find_function m "f64_to_f32")]
   | Convert (F32 F32Op.PromoteF32) -> [Call (find_function m "f32_to_f64")]
   | Convert (F64 F64Op.PromoteF32) -> [Call (find_function m "f32_to_f64")]
   | Convert (I32 I32Op.TruncSF32) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f32_to_i32")]
   | Convert (I32 I32Op.TruncUF32) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f32_to_ui32")]
   | Convert (I32 I32Op.TruncSF64) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f64_to_i32")]
   | Convert (I32 I32Op.TruncUF64) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f64_to_ui32")]
   | Convert (I64 I64Op.TruncSF32) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f32_to_i64")]
   | Convert (I64 I64Op.TruncUF32) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f32_to_ui64")]
   | Convert (I64 I64Op.TruncSF64) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f64_to_i64")]
   | Convert (I64 I64Op.TruncUF64) -> [Const (elem (I32 (Int32.of_int 2))); Const (elem (I32 (Int32.of_int 0))); Call (find_function m "f64_to_ui64")]
   | Const {it=F32 f; _} -> [Const (elem (I32 (F32.to_bits f)))]
   | Const {it=F64 f; _} -> [Const (elem (I64 (F64.to_bits f)))]
   | a -> [a]
  and convert_op x = List.map elem (convert_op' x.it)
  and convert_body lst = List.flatten (List.map convert_op lst) in
  let convert_func f = do_it f (fun f -> {f with body=convert_body f.body}) in
  let convert_global g = do_it g (fun g -> {value=do_it g.value convert_body; gtype=convert_gtype g.gtype}) in
  Run.trace "Converting floats";
  do_it m (fun m -> {m with funcs=List.map convert_func m.funcs; globals=List.map convert_global m.globals})

let process a b =
  convert_float (convert_types (merge a b))
  




