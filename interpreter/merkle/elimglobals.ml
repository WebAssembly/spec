
open Ast
open Source
open Types
open Values

let do_it x f = {x with it=f x.it}

let it e = {it=e; at=no_region}

type ctx = {
   global_type : var -> global_type;
   offset : int32;
}

let flatten_map f lst = List.map it (List.flatten (List.map f lst))

(* there should be somekind of type map *)
let rec remap_inst ctx inst = match inst.it with
 | Block (ty, lst) -> [Block (ty, flatten_map (remap_inst ctx) lst)] 
 | Loop (ty, lst) -> [Loop (ty, flatten_map (remap_inst ctx) lst)]
 | If (ty, texp, fexp) -> [If (ty, flatten_map (remap_inst ctx) texp, flatten_map (remap_inst ctx) fexp)]
 | GetGlobal v ->
    let loc = Int32.of_int (4 * Int32.to_int v.it) in
    let GlobalType (ty, _) = ctx.global_type v in
    [Const (it (I32 loc)); Load {offset=ctx.offset; align=0; ty=ty; sz=None}]
 | SetGlobal v ->
    let loc = Int32.of_int (4 * Int32.to_int v.it) in
    let GlobalType (ty, _) = ctx.global_type v in
    [Const (it (I32 loc)); Store {offset=ctx.offset; align=0; ty=ty; sz=None}]
 | a -> [a]

let remap ctx f = do_it f (fun f -> {f with body=flatten_map (remap_inst ctx) f.body})

let inline_globals instance (d:string Ast.segment) = do_it d (fun dta ->
   let offset = Eval.eval_const instance dta.offset in
   {dta with offset = it [it (Const (it offset))]})

let remove_globals e = match e.it.edesc.it with
 | GlobalExport _ -> false
 | _ -> true

let get_byte32 a pos = Int32.to_int (Int32.logand (Int32.shift_right a pos) 0xffl)
let get_byte64 a pos = Int64.to_int (Int64.logand (Int64.shift_right a pos) 0xffL)

let i32_bytes n = [
  get_byte32 n 24;
  get_byte32 n 16;
  get_byte32 n 8;
  get_byte32 n 0; ]

let i64_bytes n = [
  get_byte64 n 56;
  get_byte64 n 48;
  get_byte64 n 40;
  get_byte64 n 32;
  get_byte64 n 24;
  get_byte64 n 16;
  get_byte64 n 8;
  get_byte64 n 0; ]


let value_to_bytes = function
  | I32 x -> i32_bytes x
  | I64 x -> i64_bytes x
  | F32 x -> i32_bytes (F32.to_bits x)
  | F64 x -> i64_bytes (F64.to_bits x)

let value_segment v =
  String.concat "" (List.map (fun x -> String.make 1 (Char.chr x)) (value_to_bytes v))

let init_global instance i g =
  let loc = Int32.of_int (4 * i + 256) in
  it {offset=it [it (Const (it (I32 loc)))];
  init=value_segment (Eval.eval_const instance g.it.value);
  index=it 0l}

let process m' =
   do_it m' (fun m ->
     let imports = Import.link m' in
     let instance = Eval.init m' imports in
     let tctx = Valid.module_context m' in
     let ctx = {
       offset = 0xffl;
       global_type = Valid.global tctx;
     } in
     {m with funcs=List.map (remap ctx) m.funcs; data=List.map (inline_globals instance) m.data @ List.mapi (init_global instance) m.globals; globals=[]; exports=List.filter remove_globals m.exports})

