
open Ast
open Source
open Types
open Values

let do_it x f = {x with it=f x.it}

let it e = {it=e; at=no_region}

type ctx = {
  tctx : Valid.context;
  g64 : var;
  possible : int32 -> bool;
  adjust_stack0 : var;
  adjust_stack_i32 : var;
  adjust_stack_i64 : var;
  adjust_stack_f32 : var;
  adjust_stack_f64 : var;
  start_block : var;
  count_bottom : var;
  end_block : var;
  label : int;
  pop : var;
  push : var;
  var_type : int32 -> func_type;
  lookup_type : int32 -> func_type;
  bottom : int32;
  store_local_i32 : var;
  store_local_i64 : var;
  store_local_f32 : var;
  store_local_f64 : var;
  num_locals : var;
}

(* perhaps should get everything as args, just be a C function: add them to env *)

let rec inner_loops inst =
  let loc = Int32.of_int inst.at.left.column in
  match inst.it with
  | Block (ty, lst) -> List.flatten (List.map inner_loops lst)
  | Loop (ty, lst) -> loc :: List.flatten (List.map inner_loops lst)
  | If (ty, l1, l2) -> List.flatten (List.map inner_loops l1) @ List.flatten (List.map inner_loops l2)
  | a -> []

(* for active blocks ... *)

let type_rets = function
 | FuncType (_, lst) -> List.length lst

let type_pops = function
 | FuncType (lst, _) -> List.length lst

let inst_rets ctx = function
  | Block (ty, _) -> List.length ty
  | Loop (ty, _) -> List.length ty
  | If (ty, _, _) -> List.length ty
  | Const _ -> 1
  | Test _ -> 1
  | Compare _ -> 1
  | Unary _ -> 1
  | Binary _ -> 1
  | Convert _ -> 1
  | BrIf _ -> 0
  | BrTable (_, _) -> 0
  | Drop -> 0
  | GrowMemory -> 0
  | CurrentMemory -> 1
  | GetGlobal _ -> 1
  | SetGlobal _ -> 0
  | Call {it=v; _} -> type_rets (ctx.var_type v)
  | CallIndirect {it=v; _} -> type_rets (ctx.lookup_type v)
  | Select -> 1
  | GetLocal _ -> 1
  | SetLocal _ -> 0
  | TeeLocal _ -> 1
  | Load _ -> 1
  | Store _ -> 0
  | _ -> 0

let inst_pops ctx = function
  | Block (ty, _) -> 0
  | Loop (ty, _) -> 0
  | If (ty, _, _) -> 1
  | Const _ -> 0
  | Test _ -> 1
  | Compare _ -> 2
  | Unary _ -> 1
  | Binary _ -> 2
  | Convert _ -> 1
  | BrIf _ -> 1
  | BrTable (_, _) -> 1
  | Drop -> 1
  | GrowMemory -> 1
  | CurrentMemory -> 0
  | GetGlobal _ -> 0
  | SetGlobal _ -> 1
  | Call {it=v; _} -> type_pops (ctx.var_type v)
  | CallIndirect {it=v; _} -> type_pops (ctx.lookup_type v)
  | Select -> 3
  | GetLocal _ -> 0
  | SetLocal _ -> 1
  | TeeLocal _ -> 1
  | Load _ -> 1
  | Store _ -> 2
  | _ -> 0

let determine_type tctx block =
  let _, lst = Valid.type_seq tctx block in
(*  prerr_endline (string_of_int (List.length lst)); *)
  match List.rev lst with
  | Some x :: _ -> x
  | _ -> raise (Failure "typeing error")

let store_locals ctx =
   let num_locals = List.length ctx.tctx.Valid.locals in
   let res = ref [Const (it (I32 (Int32.of_int num_locals))); Call ctx.num_locals] in
   for i = 0 to num_locals - 1 do
      let var = it (Int32.of_int i) in
      let lst = match Valid.local ctx.tctx var with
      | I32Type -> [GetLocal var; Call ctx.store_local_i32]
      | F32Type -> [GetLocal var; Call ctx.store_local_f32]
      | F64Type -> [GetLocal var; Call ctx.store_local_f64]
      | I64Type -> [Const (it (I32 64l)); GetLocal var; Store {ty=I64Type; align=0; offset=0l; sz=None}; Call ctx.store_local_i64] in
      res := !res @ (Const (it (I32 (Int32.of_int i))) :: lst)
   done;
   !res

(* after each instruction, modify stack *)
(* perhaps call should be different? nope *)
(* so there should be two alternatives for return... *)
let build_stack loc ctx (pre, inst) =
  let rets = inst_rets ctx inst.it in
  let cloc = Int32.of_int inst.at.left.column in
  if rets > 1 then prerr_endline ("number of rets " ^ string_of_int rets);
  let pops = inst_pops ctx inst.it in
  let adjust =
    if rets = 0 then [Call ctx.adjust_stack0] else match determine_type ctx.tctx (pre@[inst]) with
    | I32Type -> [Call ctx.adjust_stack_i32]
    | F32Type -> [Call ctx.adjust_stack_f32]
    | I64Type -> [Drop; SetGlobal ctx.g64; Const (it (I32 64l)); GetGlobal ctx.g64; Store {ty=I64Type; align=0; offset=0l; sz=None}; Const (it (I32 (Int32.of_int pops))); Call ctx.adjust_stack_i64; GetGlobal ctx.g64] (* Drop *)
    | F64Type -> [Call ctx.adjust_stack_f64]
    in
  let res = inst :: List.map it (Const (it (I32 (Int32.of_int pops))) :: adjust) in
  if loc = ctx.bottom then List.map it [Const (it (I32 cloc)); Call ctx.count_bottom] @ res else res

let rec remap_blocks label inst =
  let handle {it=v; _} = if Int32.of_int label > v then it v else it (Int32.add v 1l) in
  do_it inst (function
  | Block (ty, lst) -> Block (ty, List.map (remap_blocks (label+1)) lst)
  | If (ty, l1, l2) -> If (ty, List.map (remap_blocks (label+1)) l1, List.map (remap_blocks (label+1)) l2)
  | Loop (ty, lst) -> Loop (ty, List.map (remap_blocks (label+1)) lst)
  | Br v -> Br (handle v)
  | BrIf v -> BrIf (handle v)
  | BrTable (lst, v) -> BrTable (List.map handle lst, handle v)
  | a -> a)

let rec postfix = function
 | [] -> []
 | a::tl -> (tl, a) :: postfix tl

let prefix lst = List.rev (List.map (fun (l, a) -> List.rev l, a) (postfix (List.rev lst)))

let rec process_inst ctx inst =
  let loc = Int32.of_int inst.at.left.column in
  let loop_locs = List.rev (inner_loops inst) in
  let mk_block ty lst =
     if loop_locs = [] then lst
     else if ctx.possible loc then 
        (* here we have to remap all the blocks ... *)
        let lst = List.map (remap_blocks 0) lst in
        List.map it [
          Const (it (I32 loc));
          Call ctx.start_block;
          If (ty, List.flatten (List.map (build_stack loc ctx) (prefix lst)), lst)]
     else List.map it [
        Const (it (I32 loc));
        Call ctx.start_block;
        Drop] @ lst in
  let e_block = if loop_locs = [] then [] else List.map it [Const (it (I32 loc)); Call ctx.end_block] in
(*  let s_block = [Const (it (I32 loc)); Call ctx.start_block; Drop] in *)
  let s_block = [Const (it (I32 loc)); Call ctx.start_block; If ([], List.map it (store_locals ctx), [])] in
  let it x = {at=inst.at; it=x} in
  let res = match inst.it with
  | Block (ty, lst) -> List.map it [Block (ty, mk_block ty (List.flatten (List.map (process_inst ctx) lst)))] @ e_block
  | If (ty, l1, l2) -> List.map it [If (ty, mk_block ty (List.flatten (List.map (process_inst ctx) l1)), mk_block ty (List.flatten (List.map (process_inst ctx) l2)))] @ e_block
  | Loop (ty, lst) -> List.map it [Loop (ty, List.map it [Const (it (I32 loc)); Call ctx.end_block] @ mk_block ty (List.flatten (List.map (process_inst ctx) lst)))] @ e_block
  | Call x -> List.map it (s_block @ [Call x; Call ctx.pop; Const (it (I32 loc)); Call ctx.end_block])
  | CallIndirect x -> List.map it (s_block @ [CallIndirect x; Call ctx.pop; Const (it (I32 loc)); Call ctx.end_block])
  | a -> List.map it [a] in
  res

let fnum = ref 0

let process_function ctx f =
  let loc = Int32.of_int f.at.left.column in
  prerr_endline ("Function " ^ string_of_int !fnum ^ " is at " ^ Int32.to_string loc);
  incr fnum;
  let ctx = {ctx with tctx=Valid.func_context ctx.tctx f} in
  let mk_block ty lst =
     if ctx.possible loc then 
        (* here we have to remap all the blocks ... *)
        let lst = List.map (remap_blocks 0) lst in
        List.map it [
          Const (it (I32 loc));
          Call ctx.push;
          If (ty, List.flatten (List.map (build_stack loc ctx) (prefix lst)), lst)]
     else List.map it [
        Const (it (I32 loc));
        Call ctx.push;
        Drop] @ lst in  
  let FuncType (_, rets) = ctx.lookup_type f.it.ftype.it in
  do_it f (fun f ->
    {f with body=mk_block rets (List.flatten (List.map (process_inst ctx) f.body))})

let path_table fn =
  let open Yojson.Basic in
  let data = from_channel (open_in fn) in
  let lst = Util.to_list data in
  List.map (fun el ->
     let loc = Util.member "loc" el in
     Int32.of_int (Util.to_int loc)) lst

let list_to_map lst =
  let res = Hashtbl.create 123 in
  List.iter (fun el -> Hashtbl.add res el true) lst;
  res

let process m =
  do_it m (fun m ->
    (* add function types *)
    let i_num = List.length (Merkle.func_imports (it m)) in
    let ftypes = m.types @ [
      it (FuncType ([I32Type], []));
      it (FuncType ([I32Type], [I32Type]));
      it (FuncType ([I32Type], []));
      it (FuncType ([], []));
      it (FuncType ([I32Type; I32Type], [I32Type]));
      it (FuncType ([I32Type], []));
(*      it (FuncType ([I64Type; I32Type], [I64Type])); *)
      it (FuncType ([F32Type; I32Type], [F32Type]));
      it (FuncType ([F64Type; I32Type], [F64Type]));
      it (FuncType ([I32Type], []));
      
      it (FuncType ([I32Type; I32Type], []));
      it (FuncType ([I32Type], []));
      it (FuncType ([I32Type; F32Type], []));
      it (FuncType ([I32Type; F64Type], []));
      ] in
    let ftypes_len = List.length m.types in
    let adjust_type0 = it (Int32.of_int ftypes_len) in
    let start_type = it (Int32.of_int (ftypes_len+1)) in
    let end_type = it (Int32.of_int (ftypes_len+2)) in
    let pop_type = it (Int32.of_int (ftypes_len+3)) in
    let adjust_type_i32 = it (Int32.of_int (ftypes_len+4)) in
    let adjust_type_i64 = it (Int32.of_int (ftypes_len+5)) in
    let adjust_type_f32 = it (Int32.of_int (ftypes_len+6)) in
    let adjust_type_f64 = it (Int32.of_int (ftypes_len+7)) in
    let count_bottom_type = it (Int32.of_int (ftypes_len+8)) in
    let store_type_i32 = it (Int32.of_int (ftypes_len+9)) in
    let store_type_i64 = it (Int32.of_int (ftypes_len+10)) in
    let store_type_f32 = it (Int32.of_int (ftypes_len+11)) in
    let store_type_f64 = it (Int32.of_int (ftypes_len+12)) in
    (* add imports *)
    let added = [
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "adjustStack0"; idesc=it (FuncImport adjust_type0)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "startCritical"; idesc=it (FuncImport start_type)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "endCritical"; idesc=it (FuncImport end_type)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "popCritical"; idesc=it (FuncImport pop_type)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "pushCritical"; idesc=it (FuncImport start_type)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "adjustStackI32"; idesc=it (FuncImport adjust_type_i32)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "adjustStackI64"; idesc=it (FuncImport adjust_type_i64)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "adjustStackF32"; idesc=it (FuncImport adjust_type_f32)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "adjustStackF64"; idesc=it (FuncImport adjust_type_f64)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "countBottom"; idesc=it (FuncImport count_bottom_type)};
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "storeLocalI32"; idesc=it (FuncImport store_type_i32)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "storeLocalI64"; idesc=it (FuncImport store_type_i64)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "storeLocalF32"; idesc=it (FuncImport store_type_f32)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "storeLocalF64"; idesc=it (FuncImport store_type_f64)}; (* for each type, need a different function *)
       it {module_name=Utf8.decode "env"; item_name=Utf8.decode "numLocals"; idesc=it (FuncImport adjust_type0)};
    ] in
    let imps = m.imports @ added in
    let pos_lst = path_table "critical.out" in
    let pos_tab = list_to_map pos_lst in
    (* remap calls *)
    let remap x = let x = Int32.to_int x in if x >= i_num then Int32.of_int (x + List.length added) else Int32.of_int x in
    let funcs = List.map (Merge.remap remap (fun x -> x) (fun x -> x)) m.funcs in
    let pre_m = {m with funcs=funcs;
            types=ftypes;
            imports=imps;
            globals=m.globals @ [it {gtype=GlobalType (I64Type, Mutable); value=it [it (Const (it (I64 0L)))]}];
            exports=List.map (Merge.remap_export remap (fun x -> x) (fun x -> x) "") m.exports;
            elems=List.map (Merge.remap_elements remap) m.elems; } in
    let ftab, ttab = Merkle.make_tables pre_m in
    let ctx = {
      g64 = it (Int32.of_int (List.length m.globals));
      tctx = Valid.module_context (it pre_m);
      adjust_stack0 = it (Int32.of_int (i_num+0));
      start_block = it (Int32.of_int (i_num+1));
      end_block = it (Int32.of_int (i_num+2));
      pop = it (Int32.of_int (i_num+3));
      push = it (Int32.of_int (i_num+4));
      adjust_stack_i32 = it (Int32.of_int (i_num+5));
      adjust_stack_i64 = it (Int32.of_int (i_num+6));
      adjust_stack_f32 = it (Int32.of_int (i_num+7));
      adjust_stack_f64 = it (Int32.of_int (i_num+8));
      count_bottom = it (Int32.of_int (i_num+9));
      store_local_i32 = it (Int32.of_int (i_num+10));
      store_local_i64 = it (Int32.of_int (i_num+11));
      store_local_f32 = it (Int32.of_int (i_num+12));
      store_local_f64 = it (Int32.of_int (i_num+13));
      num_locals = it (Int32.of_int (i_num+14));
      var_type = Hashtbl.find ftab;
      lookup_type = Hashtbl.find ttab;
      possible = (fun loc -> Hashtbl.mem pos_tab loc);
      bottom = List.hd (List.rev pos_lst);
      label = 0;
    } in
    let res = {pre_m with funcs=List.map (process_function ctx) pre_m.funcs} in
    res
    )



