(* Handler for @custom annotations *)

open Custom
open Annot
open Source

type format' = Custom.custom'
type format = Custom.custom

let name = Utf8.decode "custom"

let place fmt = fmt.it.place


(* Decoding & encoding *)

let decode_content m custom =
  let Custom.{name; content; place} = custom.it in
  match Custom.handler name with
  | Some (module Handler) ->
    let module S =
      struct
        module Handler = Handler
        let it = Handler.decode m "" custom
      end
    in Some (module S : Custom.Section)
  | None ->
    if !Flags.custom_reject then
      raise (Custom.Code (custom.at,
        "unknown custom section \"" ^ Utf8.encode name ^ "\""))
    else
      None

let decode m _bs custom =
  ignore (decode_content m custom);
  custom

let encode _m _bs custom = custom


(* Parsing *)

let parse_error at msg = raise (Custom.Syntax (at, msg))

let rec parse m _bs annots = List.map (parse_annot m) annots

and parse_annot m annot =
  let {name = n; items} = annot.it in
  assert (n = name);
  let cname, items' = parse_name annot.at items in
  let place, items'' = parse_place_opt items' in
  let content, items''' = parse_content items'' in
  parse_end items''';
  let Ast.{types; tags; globals; tables; memories; funcs; start;
    elems; datas; imports; exports} = m.it in
  let outside x =
    if annot.at.left >= x.at.left && annot.at.right <= x.at.right then
      parse_error annot.at "misplaced @custom annotation"
  in
  List.iter outside types;
  List.iter outside tags;
  List.iter outside globals;
  List.iter outside tables;
  List.iter outside memories;
  List.iter outside funcs;
  List.iter outside (Option.to_list start);
  List.iter outside elems;
  List.iter outside datas;
  List.iter outside imports;
  List.iter outside exports;
  let custom = {name = cname; content; place} @@ annot.at in
  ignore (decode_content m custom);
  custom

and parse_name at = function
  | {it = String s; at} :: items ->
    (try Utf8.decode s, items with Utf8.Utf8 ->
      parse_error at "@custom annotation: malformed UTF-8 encoding"
    )
  | _ ->
    parse_error at "@custom annotation: missing section name"

and parse_place_opt = function
  | {it = Parens items'; at} :: items ->
    let dir, items'' = parse_direction at items' in
    let sec, items''' = parse_section at items'' in
    parse_end items''';
    dir sec, items
  | items ->
    After last, items

and parse_direction at = function
  | {it = Atom "before"; _} :: items -> (fun sec -> Before sec), items
  | {it = Atom "after"; _} :: items -> (fun sec -> After sec), items
  | _ ->
    parse_error at "@custom annotation: malformed placement"

and parse_section at = function
  | {it = Atom "type"; _} :: items -> Type, items
  | {it = Atom "tag"; _} :: items -> Tag, items
  | {it = Atom "import"; _} :: items -> Import, items
  | {it = Atom "func"; _} :: items -> Func, items
  | {it = Atom "table"; _} :: items -> Table, items
  | {it = Atom "memory"; _} :: items -> Memory, items
  | {it = Atom "global"; _} :: items -> Global, items
  | {it = Atom "export"; _} :: items -> Export, items
  | {it = Atom "start"; _} :: items -> Start, items
  | {it = Atom "elem"; _} :: items -> Elem, items
  | {it = Atom "code"; _} :: items -> Code, items
  | {it = Atom "data"; _} :: items -> Data, items
  | {it = Atom "datacount"; _} :: items -> DataCount, items
  | {it = Atom "first"; _} :: items -> first, items
  | {it = Atom "last"; _} :: items -> last, items
  | _ ->
    parse_error at "@custom annotation: malformed section kind"

and parse_content = function
  | {it = String bs; _} :: items ->
    let bs', items' = parse_content items in
    bs ^ bs', items'
  | items -> "", items

and parse_end = function
  | [] -> ()
  | item :: _ ->
    parse_error item.at "@custom annotation: unexpected token"


(* Printing *)

open Sexpr

let rec arrange _m mnode custom =
  let {name; content; place} = custom.it in
  let node = Node ("@custom " ^ Arrange.name name,
    arrange_place place :: Arrange.break_bytes content
  ) in
  match mnode with
  | Sexpr.Atom _ -> assert false
  | Node (name, secs) -> Node (name, secs @ [node])

and arrange_place = function
  | Before sec -> Node ("before", [Atom (arrange_sec sec)])
  | After sec -> Node ("after", [Atom (arrange_sec sec)])

and arrange_sec = function
  | Custom -> assert false
  | Type -> "type"
  | Tag -> "tag"
  | Import -> "import"
  | Func -> "func"
  | Table -> "table"
  | Memory -> "memory"
  | Global -> "global"
  | Export -> "export"
  | Start -> "start"
  | Elem -> "elem"
  | Code -> "code"
  | Data -> "data"
  | DataCount -> "datacount"


(* Checking *)

let check m custom =
  let {place; _} = custom.it in
  assert (compare_place place (After Custom) > 0);
  match decode_content m custom with
  | None -> ()
  | Some (module S : Custom.Section) ->
    S.Handler.check m S.it
