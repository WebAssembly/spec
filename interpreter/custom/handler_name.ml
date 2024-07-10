(* Handler for "name" section and @name annotations *)

open Custom
open Annot
open Source

module IdxMap = Map.Make(Int32)

type name = Ast.name Source.phrase
type name_map = name IdxMap.t
type indirect_name_map = name_map Source.phrase IdxMap.t

type format = format' Source.phrase
and format' =
{
  module_ : name option;
  funcs : name_map;
  locals : indirect_name_map;
  types : name_map;
  fields : indirect_name_map;
}


let empty =
{
  module_ = None;
  funcs = IdxMap.empty;
  locals = IdxMap.empty;
  types = IdxMap.empty;
  fields = IdxMap.empty;
}

let name = Utf8.decode "name"

let place _fmt = After last


(* Decoding *)

(* TODO: make Decode module reusable instead of duplicating code *)

type stream = {bytes : string; pos : int ref}

exception EOS

let stream bs = {bytes = bs; pos = ref 0}

let len s = String.length s.bytes
let pos s = !(s.pos)
let eos s = (pos s = len s)

let check n s = if pos s + n > len s then raise EOS
let skip n s = if n < 0 then raise EOS else check n s; s.pos := !(s.pos) + n

let read s = Char.code (s.bytes.[!(s.pos)])
let peek s = if eos s then None else Some (read s)
let get s = check 1 s; let b = read s in skip 1 s; b
let get_string n s = let i = pos s in skip n s; String.sub s.bytes i n

let position pos = Source.{file = "@name section"; line = -1; column = pos}
let region left right = Source.{left = position left; right = position right}

let at f s =
  let left = pos s in
  let x = f s in
  let right = pos s in
  Source.(x @@ region left right)

let decode_error pos msg = raise (Custom.Code (region pos pos, msg))
let require b pos msg = if not b then decode_error pos msg

let decode_byte s =
  get s

let rec decode_uN n s =
  require (n > 0) (pos s) "integer representation too long";
  let b = decode_byte s in
  require (n >= 7 || b land 0x7f < 1 lsl n) (pos s - 1) "integer too large";
  let x = Int32.of_int (b land 0x7f) in
  if b land 0x80 = 0 then x else
  Int32.(logor x (shift_left (decode_uN (n - 7) s) 7))

let decode_u32 = decode_uN 32

let decode_size s =
  Int32.to_int (decode_u32 s)

let decode_name s =
  let n = decode_size s in
  let pos = pos s in
  try Utf8.decode (get_string n s) with Utf8.Utf8 ->
    decode_error pos "malformed UTF-8 encoding"

let decode_name_assoc s =
  let x = decode_u32 s in
  let n = decode_name s in
  (x, n)

let decode_name_map s =
  let n = decode_size s in
  let m = ref IdxMap.empty in
  for _ = 1 to n do
    let {it = (x, name); at} = at decode_name_assoc s in
    if IdxMap.mem x !m then
      decode_error at.left.column "custom @name: multiple function or local names";
    m := IdxMap.add x (name @@ at) !m
  done;
  !m

let decode_indirect_name_assoc s =
  let x = decode_u32 s in
  let m = at decode_name_map s in
  (x, m)

let decode_indirect_name_map s =
  let n = decode_size s in
  let m = ref IdxMap.empty in
  for _ = 1 to n do
    let {it = (x, m'); at} = at decode_indirect_name_assoc s in
    if IdxMap.mem x !m then
      decode_error at.left.column "custom @name: multiple function names";
    m := IdxMap.add x m' !m
  done;
  !m

let decode_module s = Some (at decode_name s)
let decode_funcs s = decode_name_map s
let decode_locals s = decode_indirect_name_map s
let decode_types s = decode_name_map s
let decode_fields s = decode_indirect_name_map s

let decode_subsec id f default s =
  match peek s with
  | None -> default
  | Some id' when id' <> id -> default
  | _ ->
    let _id = decode_byte s in
    let n = decode_size s in
    let pos' = pos s in
    let ss = f s in
    require (pos s = pos' + n) (pos s) "name subsection size mismatch";
    ss

let decode _m _bs custom =
  let s = stream custom.it.content in
  try
    let module_ = decode_subsec 0x00 decode_module None s in
    let funcs = decode_subsec 0x01 decode_funcs IdxMap.empty s in
    let locals = decode_subsec 0x02 decode_locals IdxMap.empty s in
    let types = decode_subsec 0x04 decode_types IdxMap.empty s in
    let fields = decode_subsec 0x0a decode_fields IdxMap.empty s in
    require (eos s) (pos s) "invalid name subsection id";
    {module_; funcs; locals; types; fields} @@ custom.at
  with EOS -> decode_error (pos s) "unexpected end of name section"


(* Encoding *)

(* TODO: make Encode module reusable *)

let encode_byte buf b =
  Buffer.add_char buf (Char.chr b)

let rec encode_u32 buf i =
  let b = Int32.(to_int (logand i 0x7fl)) in
  if 0l <= i && i < 128l then encode_byte buf b
  else (
    encode_byte buf (b lor 0x80);
    encode_u32 buf (Int32.shift_right_logical i 7)
  )

let encode_size buf n =
  encode_u32 buf (Int32.of_int n)

let encode_name buf n =
  let s = Utf8.encode n in
  encode_size buf (String.length s);
  Buffer.add_string buf s

let encode_name_assoc buf x n =
  encode_u32 buf x;
  encode_name buf n.it

let encode_name_map buf m =
  encode_size buf (IdxMap.cardinal m);
  IdxMap.iter (encode_name_assoc buf) m

let encode_indirect_name_assoc buf x m =
  encode_u32 buf x;
  encode_name_map buf m.it

let encode_indirect_name_map buf m =
  encode_size buf (IdxMap.cardinal m);
  IdxMap.iter (encode_indirect_name_assoc buf) m

let encode_subsec_begin buf id =
  encode_byte buf id;
  let pre = Buffer.contents buf in
  Buffer.clear buf;
  pre

let encode_subsec_end buf pre =
  let contents = Buffer.contents buf in
  Buffer.clear buf;
  Buffer.add_string buf pre;
  encode_size buf (String.length contents);
  Buffer.add_string buf contents

let encode_module buf name_opt =
  match name_opt with
  | None -> ()
  | Some name ->
    let subsec = encode_subsec_begin buf 0x00 in
    encode_name buf name.it;
    encode_subsec_end buf subsec

let encode_funcs buf name_map =
  if not (IdxMap.is_empty name_map) then begin
    let subsec = encode_subsec_begin buf 0x01 in
    encode_name_map buf name_map;
    encode_subsec_end buf subsec
  end

let encode_locals buf name_map_map =
  if not (IdxMap.is_empty name_map_map) then begin
    let subsec = encode_subsec_begin buf 0x02 in
    encode_indirect_name_map buf name_map_map;
    encode_subsec_end buf subsec
  end

let encode_types buf name_map =
  if not (IdxMap.is_empty name_map) then begin
    let subsec = encode_subsec_begin buf 0x04 in
    encode_name_map buf name_map;
    encode_subsec_end buf subsec
  end

let encode_fields buf name_map_map =
  if not (IdxMap.is_empty name_map_map) then begin
    let subsec = encode_subsec_begin buf 0x0a in
    encode_indirect_name_map buf name_map_map;
    encode_subsec_end buf subsec
  end

let encode _m _bs sec =
  let {module_; funcs; locals; types; fields} = sec.it in
  let buf = Buffer.create 200 in
  encode_module buf module_;
  encode_funcs buf funcs;
  encode_locals buf locals;
  encode_types buf types;
  encode_fields buf fields;
  let content = Buffer.contents buf in
  {name = Utf8.decode "name"; content; place = After last} @@ sec.at


(* Parsing *)

open Ast
open Types

let parse_error at msg = raise (Custom.Syntax (at, msg))

let merge_name_opt n1 n2 =
  match n1, n2 with
  | None, None -> None
  | None, some
  | some, None -> some
  | Some _, Some n2 ->
    parse_error n2.at "@name annotation: multiple module names"

let merge_name_map m1 m2 =
  IdxMap.union (fun x _ n2 ->
    parse_error n2.at "@name annotation: multiple function names"
  ) m1 m2

let merge_indirect_name_map m1 m2 =
  IdxMap.union (fun x m1' m2' ->
    Some (
      IdxMap.union (fun x _ n2 ->
        parse_error n2.at "@name annotation: multiple local names"
      ) m1'.it m2'.it @@ {left = m1'.at.left; right = m2'.at.right}
    )
  ) m1 m2

let merge s1 s2 =
  {
    module_ = merge_name_opt s1.it.module_ s2.it.module_;
    funcs = merge_name_map s1.it.funcs s2.it.funcs;
    locals = merge_indirect_name_map s1.it.locals s2.it.locals;
    types = merge_name_map s1.it.types s2.it.types;
    fields = merge_indirect_name_map s1.it.fields s2.it.fields;
  } @@ {left = s1.at.left; right = s2.at.right}


let is_contained r1 r2 = r1.left >= r2.left && r1.right <= r2.right
let is_left r1 r2 = r1.right <= r2.left

let locate_func bs x name at (f : func) =
  if is_left at f.it.ftype.at then
    {empty with funcs = IdxMap.singleton x name}
  else if f.it.body = [] || is_left at (List.hd f.it.body).at then
    (* TODO re-parse the function params and locals from bs *)
    parse_error at "@name annotation: local names not yet supported"
  else
    parse_error at "@name annotation: misplaced annotation"

let locate_type bs x name at (ty : type_) =
  (* TODO re-parse types from bs *)
  parse_error at "@name annotation: type and field names not yet supported"

let locate_module bs name at (m : module_) =
  if not (is_contained at m.at) then
    parse_error at "misplaced @name annotation";
  let {types; globals; tables; memories; funcs; start;
    elems; datas; imports; exports} = m.it in
  let ats =
    List.map (fun p -> p.at) types @
    List.map (fun p -> p.at) globals @
    List.map (fun p -> p.at) tables @
    List.map (fun p -> p.at) memories @
    List.map (fun p -> p.at) funcs @
    List.map (fun p -> p.at) (Option.to_list start) @
    List.map (fun p -> p.at) elems @
    List.map (fun p -> p.at) datas @
    List.map (fun p -> p.at) imports @
    List.map (fun p -> p.at) exports |> List.sort compare
  in
  match ats with
  | [] -> {empty with module_ = Some name}
  | at1::_ when is_left at at1 -> {empty with module_ = Some name}
  | _ ->
    match Lib.List.index_where (fun f -> is_contained at f.at) types with
    | Some x -> locate_type bs (Int32.of_int x) name at (List.nth types x)
    | None ->
    match Lib.List.index_where (fun f -> is_contained at f.at) funcs with
    | Some x -> locate_func bs (Int32.of_int x) name at (List.nth funcs x)
    | None -> parse_error at "misplaced @name annotation"


let rec parse m bs annots =
  let ms = List.map (parse_annot m bs) annots in
  match ms with
  | [] -> []
  | m::ms' -> [List.fold_left merge (empty @@ m.at) ms]

and parse_annot m bs annot =
  let {name = n; items} = annot.it in
  assert (n = name);
  let name, items' = parse_name annot.at items in
  parse_end items';
  locate_module bs name annot.at m @@ annot.at

and parse_name at = function
  | {it = String s; at} :: items ->
    (try Utf8.decode s @@ at, items with Utf8.Utf8 ->
      parse_error at "malformed UTF-8 encoding"
    )
  | _ ->
    parse_error at "@name annotation: string expected"

and parse_end = function
  | [] -> ()
  | item :: _ ->
    parse_error item.at "@name annotation: unexpected token"


(* Printing *)

let arrange m bs fmt =
  (* Print as generic custom section *)
  Handler_custom.arrange m bs (encode m "" fmt)


(* Checking *)

let check_error at msg = raise (Custom.Invalid (at, msg))

let check (m : module_) (fmt : format) =
  let subtypes =
    List.concat (List.map (fun {it = RecT ss; _} -> ss) m.it.types) in
  let comptypes = List.map (fun (SubT (_, _, ct)) -> ct) subtypes in
  IdxMap.iter (fun x name ->
    if I32.ge_u x (Lib.List32.length m.it.funcs) then
      check_error name.at ("custom @name: invalid function index " ^
        I32.to_string_u x)
  ) fmt.it.funcs;
  IdxMap.iter (fun x map ->
    if I32.ge_u x (Lib.List32.length m.it.funcs) then
      check_error map.at ("custom @name: invalid function index " ^
        I32.to_string_u x);
    let f = Lib.List32.nth m.it.funcs x in
    if I32.ge_u f.it.ftype.it (Lib.List32.length comptypes) then
      check_error map.at ("custom @name: invalid type index " ^
        I32.to_string_u f.it.ftype.it ^ " for function " ^ I32.to_string_u x);
    let ts =
      match Lib.List32.nth comptypes f.it.ftype.it with
      | DefFuncT (FuncT (ts, _)) -> ts
      | _ ->
        check_error map.at ("custom @name: non-function type " ^
          I32.to_string_u f.it.ftype.it ^ " for function " ^ I32.to_string_u x)
    in
    let n = I32.add (Lib.List32.length ts) (Lib.List32.length f.it.locals) in
    IdxMap.iter (fun y name ->
      if I32.ge_u y n then
        check_error name.at ("custom @name: invalid local index " ^
          I32.to_string_u y ^ " for function " ^ I32.to_string_u x)
    ) map.it;
  ) fmt.it.locals;
  IdxMap.iter (fun x name ->
    if I32.ge_u x (Lib.List32.length comptypes) then
      check_error name.at ("custom @name: invalid type index " ^
        I32.to_string_u x)
  ) fmt.it.types;
  IdxMap.iter (fun x map ->
    if I32.ge_u x (Lib.List32.length comptypes) then
      check_error map.at ("custom @name: invalid type index " ^
        I32.to_string_u x);
    let n =
      match Lib.List32.nth comptypes x with
      | DefStructT (StructT fs) -> Lib.List32.length fs
      | _ ->
        check_error map.at ("custom @name: non-struct type " ^
          I32.to_string_u x)
    in
    IdxMap.iter (fun y name ->
      if I32.ge_u y n then
        check_error name.at ("custom @name: invalid field index " ^
          I32.to_string_u y ^ " for type " ^ I32.to_string_u x)
    ) map.it;
  ) fmt.it.fields
