open Util
open Source
open El.Ast
open Config


(* Errors *)

type source = {file : string; s : string; mutable i : int}

let eos src = src.i = String.length src.s
let get src = src.s.[src.i]
let str src j = String.sub src.s j (src.i - j)
let advn src i = src.i <- src.i + i
let adv src = advn src 1
let left src = String.length src.s - src.i

let rec pos' src j (line, column) : Source.pos =
  if j = src.i then
    Source.{file = src.file; line; column}
  else
    pos' src (j + 1)
      (if src.s.[j] = '\n' then line + 1, 1 else line, column + 1)

let pos src = pos' src 0 (1, 1)

let error src msg =
  let pos = pos src in
  Source.error {left = pos; right = pos} "splice replacement" msg


(* Environment *)

module Map = Map.Make(String)

type use = int ref

type syntax = {sdef : def; fragments : (string * def * use) list}
type relation = {rdef : def; rules : (string * def * use) list}
type definition = {fdef : def; clauses : def list; use : use}

type env =
  { config : config;
    render : Render.env;
    mutable syn : syntax Map.t;
    mutable rel : relation Map.t;
    mutable def : definition Map.t;
  }


let env_def env def =
  match def.it with
  | SynD (id1, id2, _, _) ->
    if not (Map.mem id1.it env.syn) then
      env.syn <- Map.add id1.it {sdef = def; fragments = []} env.syn;
    let syntax = Map.find id1.it env.syn in
    let fragments = syntax.fragments @ [(id2.it, def, ref 0)] in
    env.syn <- Map.add id1.it {syntax with fragments} env.syn
  | RelD (id, _, _) ->
    env.rel <- Map.add id.it {rdef = def; rules = []} env.rel
  | RuleD (id1, id2, _, _) ->
    let relation = Map.find id1.it env.rel in
    let rules = relation.rules @ [(id2.it, def, ref 0)] in
    env.rel <- Map.add id1.it {relation with rules} env.rel
  | DecD (id, _, _, _) ->
    env.def <- Map.add id.it {fdef = def; clauses = []; use = ref 0} env.def
  | DefD (id, _, _, _) ->
    let definition = Map.find id.it env.def in
    let clauses = definition.clauses @ [def] in
    env.def <- Map.add id.it {definition with clauses} env.def
  | VarD _ | SepD | HintD _ ->
    ()

let env config script : env =
  let env =
    { config;
      render = Render.env config script;
      syn = Map.empty;
      rel = Map.empty;
      def = Map.empty
    }
  in
  List.iter (env_def env) script;
  env


let warn_use use space id1 id2 =
  if !use <> 1 then
    let id = if id2 = "" then id1 else id1 ^ "/" ^ id2 in
    let msg = if !use = 0 then "never spliced" else "spliced more than once" in
    prerr_endline ("warning: " ^ space ^ " `" ^ id ^ "` was " ^ msg)

let warn env =
  Map.iter (fun id1 {fragments; _} ->
  	List.iter (fun (id2, _, use) -> warn_use use "syntax" id1 id2) fragments
  ) env.syn;
  Map.iter (fun id1 {rules; _} ->
  	List.iter (fun (id2, _, use) -> warn_use use "rule" id1 id2) rules
  ) env.rel;
  Map.iter (fun id1 {use; _} -> warn_use use "definition" id1 "") env.def


let find_nosub space src id1 id2 =
  if id2 <> "" then
    error src ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`")

let match_full re s =
  Str.string_match re s 0 && Str.match_end () = String.length s

let find_entries space src id1 id2 entries =
  let re = Str.(regexp (global_replace (regexp "\\*\\|\\?") (".\\0") id2)) in
  let defs = List.filter (fun (id, _, _) -> match_full re id) entries in
  if defs = [] then
    error src ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`");
  List.map (fun (_, def, use) -> incr use; def) defs

let find_syntax env src id1 id2 =
  match Map.find_opt id1 env.syn with
  | None -> error src ("unknown syntax identifier `" ^ id1 ^ "`")
  | Some syntax -> find_entries "syntax" src id1 id2 syntax.fragments

let find_relation env src id1 id2 =
  find_nosub "relation" src id1 id2;
  match Map.find_opt id1 env.rel with
  | None -> error src ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> [relation.rdef]

let find_rule env src id1 id2 =
  match Map.find_opt id1 env.rel with
  | None -> error src ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> find_entries "rule" src id1 id2 relation.rules

let find_func env src id1 id2 =
  find_nosub "definition" src id1 id2;
  match Map.find_opt id1 env.def with
  | None -> error src ("unknown definition identifier `" ^ id1 ^ "`")
  | Some definition ->
    if definition.clauses = [] then
      error src ("definition `" ^ id1 ^ "` has no clauses");
    incr definition.use; definition.clauses


(* Parsing *)

let len = String.length

let rec parse_space src =
  if not (eos src) && (get src = ' ' || get src = '\t' || get src = '\n') then
    (adv src; parse_space src)

let rec try_string' s i s' j : bool =
  j = len s' || s.[i] = s'.[j] && try_string' s (i + 1) s' (j + 1)

let try_string src s : bool =
  left src >= len s && try_string' src.s src.i s 0 && (advn src (len s); true)

let try_anchor_start src anchor : bool =
  try_string src (anchor ^ "{")

let rec parse_anchor_end src j depth =
  if eos src then
    error {src with i = j} "unclosed anchor"
  else if get src = '{' then
    (adv src; parse_anchor_end src j (depth + 1))
  else if get src <> '}' then
    (adv src; parse_anchor_end src j depth)
  else if depth > 0 then
    (adv src; parse_anchor_end src j (depth - 1))

let rec parse_id' src =
  if not (eos src) then
  match get src with
  | 'A'..'Z' | 'a'..'z' | '0'..'9' | '_' | '\'' | '`' | '-' | '*' ->
    (adv src; parse_id' src)
  | _ -> ()

let parse_id src space : string =
  let j = src.i in
  parse_id' src;
  if j = src.i then
    error {src with i = j} ("expected " ^ space ^ " identifier or `}`");
  str src j

let parse_id_id env src space1 space2 find : def list =
  let j = src.i in
  let id1 = parse_id src space1 in
  let id2 =
    if space2 <> "" && try_string src "/" then parse_id src space2 else ""
  in find env {src with i = j} id1 id2

let rec parse_id_id_list env src space1 space2 find : def list =
  parse_space src;
  if try_string src "}" then [] else
  let defs1 = parse_id_id env src space1 space2 find in
  let defs2 = parse_id_id_list env src space1 space2 find in
  defs1 @ defs2

let rec parse_group_list env src space1 space2 find : def list list =
  parse_space src;
  if try_string src "}" then [] else
  let groups =
    if try_string src "{" then
      [parse_id_id_list env src space1 space2 find]
    else
      List.map (fun def -> [def]) (parse_id_id env src space1 space2 find)
  in
  groups @ parse_group_list env src space1 space2 find

let try_def_anchor env src r sort space1 space2 find deco : bool =
  let b = try_string src sort in
  if b then (
    parse_space src;
    if not (try_string src ":") then
      error src "colon `:` expected";
    let groups = parse_group_list env src space1 space2 find in
    let defs = List.tl (List.concat_map ((@) [SepD $ no_region]) groups) in
    let env' = env.render
      |> Render.with_syntax_decoration deco
      |> Render.with_rule_decoration deco
    in r := Render.render_defs env' defs
  );
  b

let try_exp_anchor env src r : bool =
  let b = try_string src ":" in
  if b then (
  	let j = src.i in
    parse_anchor_end src (j - 4) 0;
    let s = str src j in
    adv src;
    let exp =
      try Frontend.Parse.parse_exp s with Source.Error (at, msg) ->
        (* Translate relative positions *)
        let pos = pos {src with i = j} in
        let shift {line; column; _} =
          { file = src.file; line = line + pos.line - 1;
            column = if false(*line = 1*) then column + pos.column - 1 else column} in
        let at' = {left = shift at.left; right = shift at.right} in
        raise (Source.Error (at', msg))
    in
    r := Render.render_exp env.render exp
  );
  b


(* Splicing *)

let splice_anchor env src anchor buf =
  parse_space src;
  Buffer.add_string buf anchor.prefix;
  let r = ref "" in
  ignore (
    try_exp_anchor env src r ||
    try_def_anchor env src r "syntax+" "syntax" "fragment" find_syntax true ||
    try_def_anchor env src r "syntax" "syntax" "fragment" find_syntax false ||
    try_def_anchor env src r "relation" "relation" "" find_relation false ||
    try_def_anchor env src r "rule+" "relation" "rule" find_rule true ||
    try_def_anchor env src r "rule" "relation" "rule" find_rule false ||
    try_def_anchor env src r "definition" "definition" "" find_func false ||
    error src "unknown definition sort";
  );
  let s =
    if anchor.indent = "" then !r else
    Str.(global_replace (regexp "\n") ("\n" ^ anchor.indent) !r)
  in
  Buffer.add_string buf s;
  Buffer.add_string buf anchor.suffix

let rec try_anchors env src buf = function
  | [] -> false
  | anchor::anchors ->
    if try_anchor_start src anchor.token then
      (splice_anchor env src anchor buf; true)
    else
      try_anchors env src buf anchors

let rec splice_all env src buf =
  if not (eos src) then (
  	if not (try_anchors env src buf env.config.anchors) then
      (Buffer.add_char buf (get src); adv src);
    splice_all env src buf
  )


(* Entry points *)

let splice_string env file s : string =
  let buf = Buffer.create (String.length s) in
  splice_all env {file; s; i = 0} buf;
  Buffer.contents buf

let splice_file ?(dry = false) env file_in file_out =
  let ic = In_channel.open_text file_in in
  let s =
    Fun.protect (fun () -> In_channel.input_all ic)
      ~finally:(fun () -> In_channel.close ic)
  in
  let s' = splice_string env file_in s in
  if not dry then
    let oc = Out_channel.open_text file_out in
    Fun.protect (fun () -> Out_channel.output_string oc s')
      ~finally:(fun () -> Out_channel.close oc)
