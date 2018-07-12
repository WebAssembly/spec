
open Ast
open Source
open Merkle

(* remap function calls *)
let rec remap_func' map gmap ftmap = function
 | Block (ty, lst) -> Block (ty, List.map (remap_func map gmap ftmap) lst) 
 | Loop (ty, lst) -> Loop (ty, List.map (remap_func map gmap ftmap) lst)
 | If (ty, texp, fexp) -> If (ty, List.map (remap_func map gmap ftmap) texp, List.map (remap_func map gmap ftmap) fexp)
 | GetGlobal v -> GetGlobal {v with it = gmap v.it}
 | SetGlobal v -> SetGlobal {v with it = gmap v.it}
 | Call v -> Call {v with it = map v.it}
 | CallIndirect v -> CallIndirect {v with it = ftmap v.it}
 | a -> a

and remap_func map gmap ftmap i = {i with it = remap_func' map gmap ftmap i.it}

let rec remap' map gmap ftmap f = {f with ftype={(f.ftype) with it = ftmap f.ftype.it}; body=List.map (remap_func map gmap ftmap) f.body}
and remap map gmap ftmap i = {i with it = remap' map gmap ftmap i.it}

let remap_var map v = {v with it=map v.it}

let remap_edesc map gmap ftmap = function
 | FuncExport v -> FuncExport (remap_var map v)
 | GlobalExport v -> GlobalExport (remap_var gmap v)
 | a -> a

let remap_export map gmap ftmap conflict x =
  let res = {x with it={x.it with edesc = {x.it.edesc with it=remap_edesc map gmap ftmap x.it.edesc.it}}} in
  if Utf8.encode res.it.name = "runPostSets" then {res with it={res.it with name=Utf8.decode ("runPostSets" ^ conflict)}}
  else res

let remap_global map gmap ftmap x =
  let res = {x with it={x.it with value = {x.it.value with it=List.map (remap_func map gmap ftmap) x.it.value.it}}} in
  res

let drop_table exp = match exp.it.edesc.it with
 | TableExport _ -> false
 | _ ->
   let str = Utf8.encode exp.it.name in
   str <> "_stackSave" &&
   str <> "_stackAlloc" &&
   str <> "_runPostSets" &&
   str <> "_stackRestore"

let drop_table_import exp = match exp.it.idesc.it with
 | TableImport _ -> false
 | MemoryImport _ -> false
 | _ -> true

let remap_idesc ftmap = function
 | FuncImport v -> FuncImport (remap_var ftmap v)
 | a -> a

let remap_import ftmap x =
  let res = {x with it={x.it with idesc = {x.it.idesc with it=remap_idesc ftmap x.it.idesc.it}}} in
  res

let do_it f x = {x with it=f x.it}

let remap_elements map el = do_it (fun x -> {x with init=List.map (remap_var map) x.init}) el

(*
let extra = ""
let delim = "_"
*)

let extra = ""

(* probably all funcs will have to stay *)
let merge a b =
  let f_imports = ref [] in
  let g_imports = ref [] in
  let map1 = Hashtbl.create 10 in
  let gmap1 = Hashtbl.create 10 in
  let map2 = Hashtbl.create 10 in
  let gmap2 = Hashtbl.create 10 in
  (* check from exports, if some imports should be linked *)
  let taken_imports = Hashtbl.create 10 in
  let taken_imports_a = Hashtbl.create 10 in
  let taken_imports_b = Hashtbl.create 10 in
  let taken_globals = Hashtbl.create 10 in
  (* function type remapping *)
  let ftmap1 x = x in
  let ftmap2 x = Int32.add x (Int32.of_int (List.length a.it.types)) in
  let reserve_export x =
    let name = Utf8.encode x.it.name in
    let name = if name = "_malloc" then extra ^ "_env__malloc" else name in
    Hashtbl.add taken_imports name 0l in
  List.iter reserve_export a.it.exports;
  List.iter reserve_export b.it.exports;
  let add_import taken taken_cur imports map num imp =
    (* check if import was already taken *)
    let name = extra ^ "_" ^ Utf8.encode imp.it.module_name ^ "_" ^ Utf8.encode imp.it.item_name in
    if not (Hashtbl.mem taken name) || Hashtbl.mem taken_cur name then begin
      let loc = Int32.of_int (List.length !imports) in
      Hashtbl.add map (Int32.of_int num) loc;
      imports := imp :: !imports;
      Run.trace ("Got import " ^ name ^ ", linked to " ^ Int32.to_string loc);
(*      if name = "_env__llvm_bswap_i64" || (String.length name > 11 && String.sub name 0 11 = "_env_invoke") then () else *)
      Hashtbl.add taken_cur name loc;
      Hashtbl.add taken name loc
    end else begin
      let loc = Hashtbl.find taken name in
      Run.trace ("Dropping import " ^ name ^ ", linked to " ^ Int32.to_string loc);
      Hashtbl.add map (Int32.of_int num) loc
    end in
  (* first just have to calculate total number of imports *)
  let imports_a = List.map (remap_import ftmap1) (func_imports a) in
  let imports_b = List.map (remap_import ftmap2) (func_imports b) in
  List.iteri (fun n x -> add_import taken_imports taken_imports_a f_imports map1 n x) imports_a;
  List.iteri (fun n x -> add_import taken_imports taken_imports_b f_imports map2 n x) imports_b;
  List.iteri (fun n x -> add_import taken_globals taken_imports_a g_imports gmap1 n x) (global_imports a);
  List.iteri (fun n x -> add_import taken_globals taken_imports_b g_imports gmap2 n x) (global_imports b);
  let num_f = List.length !f_imports in
  let num_g = List.length !g_imports in
  Run.trace ("Function imports: " ^ string_of_int num_f ^ "; Global imports: " ^ string_of_int num_g);
  (* now can calculate the export positions *)
  let taken_imports = Hashtbl.create 10 in
  let taken_imports_a = Hashtbl.create 10 in
  let taken_imports_b = Hashtbl.create 10 in
  let reserve_export offset x =
    match x.it.edesc.it with
    | FuncExport v ->
       let name = Utf8.encode x.it.name in
       let name = if name = "_malloc" then "_env__malloc" else name in
       Hashtbl.add taken_imports name (Int32.add offset v.it)
    | _ -> () in
  let num_fa = List.length (func_imports a) in
  let num_fb = List.length (func_imports b) in
  let offset_a = num_f - num_fa in
  let offset_b = num_f - num_fb + List.length a.it.funcs in
  let num_ga = List.length (global_imports a) in
  let num_gb = List.length (global_imports b) in
  let offset_ga = num_g - num_ga in
  let offset_gb = num_g - num_gb + List.length a.it.globals in
  List.iter (reserve_export (Int32.of_int offset_a)) a.it.exports;
  List.iter (reserve_export (Int32.of_int offset_b)) b.it.exports;
  f_imports := [];
  List.iteri (fun n x -> add_import taken_imports taken_imports_a f_imports map1 n x) imports_a;
  List.iteri (fun n x -> add_import taken_imports taken_imports_b f_imports map2 n x) imports_b;
  Run.trace ("Function imports: " ^ string_of_int num_f ^ "; Global imports: " ^ string_of_int num_g);
  Run.trace ("Functions A: " ^ string_of_int (List.length a.it.funcs) ^ "; Functions B: " ^ string_of_int (List.length b.it.funcs));
  (* add remapping for functions *)
  List.iteri (fun i _ ->
    Hashtbl.add map1 (Int32.of_int (i + num_fa)) (Int32.of_int (i + num_fa + offset_a))) a.it.funcs;
  List.iteri (fun i _ ->
    Hashtbl.add map2 (Int32.of_int (i + num_fb)) (Int32.of_int (i + num_fb + offset_b))) b.it.funcs;
  (* add remapping for globals *)
  List.iteri (fun i _ ->
    Run.trace ("global " ^ string_of_int i ^ " -> " ^ string_of_int (i + num_ga + offset_ga));
    Hashtbl.add gmap1 (Int32.of_int (i + num_ga)) (Int32.of_int (i + num_ga + offset_ga))) a.it.globals;
  List.iteri (fun i _ ->
    Run.trace ("global " ^ string_of_int i ^ " -> " ^ string_of_int (i + num_gb + offset_gb));
    Hashtbl.add gmap2 (Int32.of_int (i + num_gb)) (Int32.of_int (i + num_gb + offset_gb))) b.it.globals;
  (* remap exports *)
  let exports_a = List.map (remap_export (Hashtbl.find map1) (Hashtbl.find gmap1) ftmap1 "") a.it.exports in
  let exports_b = List.map (remap_export (Hashtbl.find map2) (Hashtbl.find gmap2) ftmap2 "_b") b.it.exports in
  (* funcs will have to be remapped *)
  let funcs_a = List.map (remap (Hashtbl.find map1) (Hashtbl.find gmap1) ftmap1) a.it.funcs in
  let funcs_b = List.map (remap (Hashtbl.find map2) (Hashtbl.find gmap2) ftmap2) b.it.funcs in
  let more_imports = other_imports a @ List.filter drop_table_import (other_imports b) in
  (* table elements have to be remapped *)
  Run.trace ("Remapping globals");
  {a with it={(a.it) with funcs = funcs_a@funcs_b;
     globals = List.map (remap_global (Hashtbl.find map1) (Hashtbl.find gmap1) ftmap1) a.it.globals @
               List.map (remap_global (Hashtbl.find map2) (Hashtbl.find gmap2) ftmap2) b.it.globals;
     imports = List.rev !f_imports @ List.rev !g_imports @ more_imports;
     exports = exports_a@List.filter drop_table exports_b;
     elems = List.map (remap_elements (Hashtbl.find map1)) a.it.elems;
     types=a.it.types@b.it.types}}

