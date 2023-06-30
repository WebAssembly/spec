(* Handler for "metadata.code.branch_hint" section and @metadata.code.branch_hint annotations *)

open Custom
open Annot
open Source
open Ast
module IdxMap = Map.Make (Int32)

type kind = Likely | Unlikely

type hint = hint' Source.phrase
and hint' = kind * int

type hints = hint list
type func_hints = hints IdxMap.t

type format = format' Source.phrase
and format' = { func_hints : func_hints }

let empty = { func_hints = IdxMap.empty }
let name = Utf8.decode "metadata.code.branch_hint"
let place _fmt = Before Code
let is_contained r1 r2 = r1.left >= r2.left && r1.right <= r2.right

let is_left r1 r2 =
  r1.right.line < r2.left.line
  || (r1.right.line == r2.left.line && r1.right.column <= r2.left.column)

let starts_before r1 r2 =
  r1.left.line < r2.left.line
  || (r1.left.line == r2.left.line && r1.left.column < r2.left.column)

let get_func m fidx =
  let nimp = List.length m.it.imports in
  let fn = Int32.to_int fidx - nimp in
  List.nth m.it.funcs fn

let flatten_instr_locs is =
  let rec flatten is =
    match is with
    | [] -> []
    | i :: rest ->
        let group =
          match i.it with
          | Block (_, inner) -> [ i ] @ flatten inner
          | Loop (_, inner) -> [ i ] @ flatten inner
          | If (_, inner1, inner2) -> [ i ] @ flatten inner1 @ flatten inner2
          | _ -> [ i ]
        in
        group @ flatten rest
  in
  let flat = flatten is in
  let indexed = List.mapi (fun idx i -> (idx, i)) flat in
  let sorter (_, i1) (_, i2) = if starts_before i1.at i2.at then -1 else 1 in
  let sorted = List.sort sorter indexed in
  sorted

let get_inst_idx locs at =
  let finder (i, l) = is_left at l.at in
  let o = List.find_opt finder locs in
  match o with Some (i, _) -> Some i | None -> None

let get_nth_inst locs idx =
  match List.find_opt (fun (i_idx, i) -> i_idx == idx) locs with
  | Some (_, i) -> Some i
  | None -> None

(* Decoding *)

(* TODO: make Decode module reusable instead of duplicating code *)

type stream = { bytes : string; pos : int ref }

exception EOS

let stream bs = { bytes = bs; pos = ref 0 }
let len s = String.length s.bytes
let pos s = !(s.pos)
let check n s = if pos s + n > len s then raise EOS

let skip n s =
  if n < 0 then raise EOS else check n s;
  s.pos := !(s.pos) + n

let read s = Char.code s.bytes.[!(s.pos)]

let get s =
  check 1 s;
  let b = read s in
  skip 1 s;
  b

let position file pos = Source.{ file; line = -1; column = pos }

let region file left right =
  Source.{ left = position file left; right = position file right }

let decode_error pos msg =
  raise (Custom.Code (region "@metadata.code.branch_hint section" pos pos, msg))

let require b pos msg = if not b then decode_error pos msg
let decode_byte s = get s

let rec decode_uN n s =
  require (n > 0) (pos s) "integer representation too long";
  let b = decode_byte s in
  require (n >= 7 || b land 0x7f < 1 lsl n) (pos s - 1) "integer too large";
  let x = Int32.of_int (b land 0x7f) in
  if b land 0x80 = 0 then x
  else Int32.(logor x (shift_left (decode_uN (n - 7) s) 7))

let decode_u32 = decode_uN 32

let decode_vec f s =
  let n = decode_u32 s in
  let n = Int32.to_int n in
  let rec it i s = if i = 0 then [] else [ f s ] @ it (i - 1) s in
  it n s

let decode_hint locs foff s =
  let off = decode_u32 s in
  let one = decode_u32 s in
  require (one = 1l) (pos s)
    "@metadata.code.branch_hint section: missing reserved byte";
  let k = decode_byte s in
  let hint =
    match k with
    | 0x00 -> Unlikely
    | 0x01 -> Likely
    | _ ->
        decode_error (pos s)
          "@metadata.code.branch_hint section: invalid hint value"
  in
  let abs_off = Int32.to_int (Int32.add off foff) in
  let at = region "" abs_off abs_off in
  let idx =
    match get_inst_idx locs at with
    | Some i -> i
    | None ->
        decode_error (pos s)
          "@metadata.code.branch_hint section: invalid offset"
  in
  (hint, idx) @@ at

let decode_func_hints locs foff = decode_vec (decode_hint locs foff)

let decode_func m s =
  let fidx = decode_u32 s in
  let f = get_func m fidx in
  let foff = Int32.of_int f.at.left.column in
  let locs = flatten_instr_locs f.it.body in
  let hs = decode_func_hints locs foff s in
  (fidx, List.rev hs)

let decode_funcs m s =
  let fs = decode_vec (decode_func m) s in
  IdxMap.add_seq (List.to_seq fs) IdxMap.empty

let decode m _ custom =
  let s = stream custom.it.content in
  try { func_hints = decode_funcs m s } @@ custom.at
  with EOS -> decode_error (pos s) "unexpected end of name section"

(* Encoding *)

(* TODO: make Encode module reusable *)

let encode_byte buf b = Buffer.add_char buf (Char.chr b)

let rec encode_u32 buf i =
  let b = Int32.(to_int (logand i 0x7fl)) in
  if 0l <= i && i < 128l then encode_byte buf b
  else (
    encode_byte buf (b lor 0x80);
    encode_u32 buf (Int32.shift_right_logical i 7))

let encode_size buf n = encode_u32 buf (Int32.of_int n)

let encode_vec buf f v =
  encode_size buf (List.length v);
  let rec it v =
    match v with
    | [] -> ()
    | e :: es ->
        f buf e;
        it es
  in
  it v

let encode_hint locs foff buf h =
  let kind, idx = h.it in
  let i =
    match get_nth_inst locs idx with Some i -> i | None -> assert false
  in
  let off = i.at.left.column - foff in
  encode_size buf off;
  encode_u32 buf 1l;
  let b = match kind with Unlikely -> 0l | Likely -> 1l in
  encode_u32 buf b

let encode_func_hints buf locs foff = encode_vec buf (encode_hint locs foff)

let encode_func m buf t =
  let fidx, hs = t in
  encode_u32 buf fidx;
  let f = get_func m fidx in
  let foff = f.at.left.column in
  let locs = flatten_instr_locs f.it.body in
  encode_func_hints buf locs foff hs

let encode_funcs buf m fhs =
  encode_vec buf (encode_func m) (List.of_seq (IdxMap.to_seq fhs))

let encode m bs sec =
  let { func_hints } = sec.it in
  let m2 = Decode.decode "" bs in
  let buf = Buffer.create 200 in
  encode_funcs buf m2 func_hints;
  let content = Buffer.contents buf in
  {
    name = Utf8.decode "metadata.code.branch_hint";
    content;
    place = Before Code;
  }
  @@ sec.at

(* Parsing *)

open Ast

let parse_error at msg = raise (Custom.Syntax (at, msg))

let merge_func_hints =
  IdxMap.merge (fun key x y ->
      match (x, y) with
      | Some a, None -> Some a
      | None, Some b -> Some b
      | Some a, Some [ ({ at = _; it = _, idx } as b) ] ->
          let _, last_idx = (List.hd (List.rev a)).it in
          if last_idx >= idx then
            parse_error b.at
              "@metadata.code.branch_hint annotation: duplicate annotation"
          else Some (a @ [ b ])
      | Some _, Some _ -> assert false
      | None, None -> None)

let merge s1 s2 =
  { func_hints = merge_func_hints s1.it.func_hints s2.it.func_hints }
  @@ { left = s1.at.left; right = s2.at.right }

let find_func_idx m annot =
  let idx =
    Lib.List.index_where (fun f -> is_contained annot.at f.at) m.it.funcs
  in
  match idx with
  | Some i -> Int32.of_int (i + List.length m.it.imports)
  | None ->
      parse_error annot.at
        "@metadata.code.branch_hint annotation: not in a function"

let rec parse m _bs annots =
  let annots' = List.rev annots in
  let ms = List.map (parse_annot m) annots' in
  match ms with
  | [] -> []
  | m :: ms' -> [ List.fold_left merge (empty @@ m.at) ms ]

and parse_annot m annot =
  let { name = n; items } = annot.it in
  assert (n = name);
  let payload a =
    match a.it with
    | String s -> s
    | _ ->
        parse_error a.at
          "@metadata.code.branch_hint annotation: unexpected token"
  in
  let fold_payload bs a = bs ^ payload a in
  let p = List.fold_left fold_payload "" items in
  let at_last = (List.hd (List.rev items)).at in
  let fidx = find_func_idx m annot in
  let f = get_func m fidx in
  let locs = flatten_instr_locs f.it.body in
  let hint =
    match p with
    | "\x00" -> Unlikely
    | "\x01" -> Likely
    | _ ->
        parse_error annot.at
          "@metadata.code.branch_hint annotation: invalid hint value"
  in
  let at = Source.{ left = annot.at.left; right = at_last.right } in
  let hidx =
    match get_inst_idx locs at with
    | Some i -> i
    | None ->
        parse_error annot.at
          "@metadata.code.branch_hint annotation: invalid placement"
  in
  let e =
    { func_hints = IdxMap.add fidx [ (hint, hidx) @@ at ] IdxMap.empty }
  in
  e @@ at

(* Arranging *)

let hint_to_string = function Likely -> "\"\\01\"" | Unlikely -> "\"\\00\""

let collect_one f hat =
  let h, hidx = hat.it in
  ( Int32.to_int f,
    hidx,
    Sexpr.Node ("@metadata.code.branch_hint ", [ Sexpr.Atom (hint_to_string h) ])
  )

let collect_func (f, hs) = List.map (collect_one f) hs
let collect_funcs fhs = List.concat (List.map collect_func fhs)

let string_starts_with s1 s2 =
  let s2l = String.length s2 in
  let s1l = String.length s1 in
  let len = Stdlib.min s2l s1l in
  let s1sub = String.sub s1 0 len in
  String.equal s1sub s2

let rec get_instrs n1 n2 =
  match n2 with
  | [] -> (n1, [])
  | Sexpr.Atom s :: rest -> (n1 @ [ Sexpr.Atom s ], rest)
  | Sexpr.Node (h, els) :: rest ->
      if
        string_starts_with h "type "
        || String.equal h "local"
        || string_starts_with h "result"
      then get_instrs (n1 @ [ Sexpr.Node (h, els) ]) rest
      else (n1, n2)

let get_annot annots fidx idx h =
  match !annots with
  | [] -> []
  | (a_fidx, a_hidx, a_node) :: rest ->
      if a_fidx = fidx && a_hidx = idx then (
        annots := rest;
        [ a_node ])
      else []

let rec apply_instrs annots fidx curi is =
  match is with
  | [] -> []
  | i :: rest ->
      let idx = !curi in
      curi := idx + 1;
      let newn =
        match i with
        | Sexpr.Node (h, ns) ->
            let annot = get_annot annots fidx idx h in
            if string_starts_with h "block" || string_starts_with h "loop" then
              let pre, inner = get_instrs [] ns in
              annot
              @ [ Sexpr.Node (h, pre @ apply_instrs annots fidx curi inner) ]
            else if string_starts_with h "if" then
              match ns with
              | [ Sexpr.Node (hif, nif); Sexpr.Node (helse, nelse) ] ->
                  let newif = apply_instrs annots fidx curi nif in
                  let newelse = apply_instrs annots fidx curi nelse in
                  annot
                  @ [
                      Sexpr.Node
                        ( h,
                          [
                            Sexpr.Node (hif, newif); Sexpr.Node (helse, newelse);
                          ] );
                    ]
              | [
               Sexpr.Node ("result", res);
               Sexpr.Node (hif, nif);
               Sexpr.Node (helse, nelse);
              ] ->
                  let newif = apply_instrs annots fidx curi nif in
                  let newelse = apply_instrs annots fidx curi nelse in
                  annot
                  @ [
                      Sexpr.Node
                        ( h,
                          [
                            Sexpr.Node ("result", res);
                            Sexpr.Node (hif, newif);
                            Sexpr.Node (helse, newelse);
                          ] );
                    ]
              | _ -> assert false
            else annot @ [ Sexpr.Node (h, ns) ]
        | Sexpr.Atom s -> [ Sexpr.Atom s ]
      in
      newn @ apply_instrs annots fidx curi rest

let apply_func nodes annots fidx =
  let curi = ref 0 in
  let pre, instrs = get_instrs [] nodes in
  let new_instrs = apply_instrs annots fidx curi instrs in
  pre @ new_instrs

let apply_secs annots curf node =
  match node with
  | Sexpr.Atom a -> Sexpr.Atom a
  | Sexpr.Node (head, rest) ->
      if string_starts_with head "func" then (
        let ret = apply_func rest annots !curf in
        curf := !curf + 1;
        Sexpr.Node (head, ret))
      else Sexpr.Node (head, rest)

let apply mnode annots curf =
  match mnode with
  | Sexpr.Atom a -> Sexpr.Atom a
  | Sexpr.Node (h, secs) ->
      Sexpr.Node (h, List.map (apply_secs annots curf) secs)

let arrange m mnode fmt =
  let annots =
    ref (collect_funcs (List.of_seq (IdxMap.to_seq fmt.it.func_hints)))
  in
  let curf = ref 0 in
  let ret = apply mnode annots curf in
  ret

(* Checking *)

let check_error at msg = raise (Custom.Invalid (at, msg))

let check_one locs prev_hidx h =
  let kind, idx = h.it in
  match get_nth_inst locs idx with
  | None -> assert false
  | Some i -> (
      match i.it with
      | If _ | BrIf _ ->
          if !prev_hidx >= idx then
            check_error h.at
              "@metadata.code.branch_hint annotation: invalid order"
          else (
            prev_hidx := idx;
            ())
      | _ ->
          check_error h.at
            "@metadata.code.branch_hint annotation: invalid target")

let check_fun m fidx hs =
  let f = get_func m fidx in
  let locs = flatten_instr_locs f.it.body in
  let prev_hidx = ref 0 in
  List.iter (check_one locs prev_hidx) hs

let check (m : module_) (fmt : format) =
  IdxMap.iter (check_fun m) fmt.it.func_hints;
  ()
