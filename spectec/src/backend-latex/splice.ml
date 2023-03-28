open Util
open Source
open El.Ast
open Config


(* Errors *)

let rec pos' file s i j (line, column) : Source.pos =
  if j = i then
    Source.{file; line; column}
  else
    pos' file s i (j + 1) (if s.[j] = '\n' then line + 1, 1 else line, column + 1)

let pos file s i = pos' file s i 0 (1, 1)

let error file s i msg =
  let pos = pos file s i in
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
  | VarD _ | SepD ->
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


let find_nosub space file s i id1 id2 =
  if id2 <> "" then
    error file s i ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`")

let find_entries space file s i id1 id2 entries =
  let re = Str.(regexp (global_replace (regexp "\\*\\|\\?") (".\\0") id2)) in
  let defs = List.filter (fun (id, _, _) -> Str.string_match re id 0) entries in
  if defs = [] then
    error file s i ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`");
  List.map (fun (_, def, use) -> incr use; def) defs

let find_syntax env file s (i, id1, id2) =
  match Map.find_opt id1 env.syn with
  | None -> error file s i ("unknown syntax identifier `" ^ id1 ^ "`")
  | Some syntax -> find_entries "syntax" file s i id1 id2 syntax.fragments

let find_relation env file s (i, id1, id2) =
  find_nosub "relation" file s i id1 id2;
  match Map.find_opt id1 env.rel with
  | None -> error file s i ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> [relation.rdef]

let find_rule env file s (i, id1, id2) =
  match Map.find_opt id1 env.rel with
  | None -> error file s i ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> find_entries "rule" file s i id1 id2 relation.rules

let find_func env file s (i, id1, id2) =
  find_nosub "definition" file s i id1 id2;
  match Map.find_opt id1 env.def with
  | None -> error file s i ("unknown definition identifier `" ^ id1 ^ "`")
  | Some definition -> incr definition.use; definition.clauses


(* Splicing *)

let len = String.length

let rec skip_space s i =
  if !i < len s && (s.[!i] = ' ' || s.[!i] = '\t' || s.[!i] = '\n') then
    (incr i; skip_space s i)

let rec try_string' s i s' j : bool =
  j = len s' || s.[i] = s'.[j] && try_string' s (i + 1) s' (j + 1)

let try_string s i s' : bool =
  len s >= !i + len s' && try_string' s !i s' 0 && (i := !i + len s'; true)

let try_anchor_start s i anchor : bool =
  try_string s i (anchor ^ "{")

let rec match_anchor_end file s j i depth =
  if !i = len s then
    error file s j "unclosed anchor"
  else if s.[!i] = '{' then
    (incr i; match_anchor_end file s j i (depth + 1))
  else if s.[!i] <> '}' then
    (incr i; match_anchor_end file s j i depth)
  else if depth > 0 then
    (incr i; match_anchor_end file s j i (depth - 1))

let rec match_id' s i =
  if !i < len s then
  match s.[!i] with
  | 'A'..'Z' | 'a'..'z' | '0'..'9' | '_' | '\'' | '`' | '-' | '*' ->
    (incr i; match_id' s i)
  | _ -> ()

let match_id file s i space : string =
  let j = !i in
  match_id' s i;
  if j = !i then
    error file s j ("expected " ^ space ^ " identifier or `}`");
  String.sub s j (!i - j)

let match_id_id file s i space1 space2 : int * string * string =
  let j = !i in
  let id1 = match_id file s i space1 in
  let id2 =
    if space2 <> "" && try_string s i "/" then match_id file s i space2 else ""
  in
  j, id1, id2

let rec match_id_id_list file s i space1 space2 : (int * string * string) list =
  skip_space s i;
  if try_string s i "}" then [] else
  let idid = match_id_id file s i space1 space2 in
  let idids = match_id_id_list file s i space1 space2 in
  idid::idids

let try_def_anchor env file s i r sort space1 space2 find deco : bool =
  let b = try_string s i sort in
  if b then (
    skip_space s i;
    if not (try_string s i ":") then
      error file s !i "colon `:` expected";
    let idids = match_id_id_list file s i space1 space2 in
    let defs = List.concat_map (find env file s) idids in
    let env' = env.render
      |> Render.with_syntax_decoration deco
      |> Render.with_rule_decoration deco
    in r := Render.render_defs env' defs
  );
  b

let try_exp_anchor env file s i r : bool =
  let b = try_string s i ":" in
  if b then (
  	let j = !i in
    match_anchor_end file s (j - 4) i 0;
    let src = String.sub s j (!i - j) in
    incr i;
    let exp =
      try Frontend.Parse.parse_exp src with Source.Error (at, msg) ->
        (* Translate relative positions *)
        let pos = pos file s j in
        let shift {file; line; column} =
          { file; line = line + pos.line;
            column = if line = 1 then column + pos.column else column} in
        let at' = {left = shift at.left; right = shift at.right} in
        raise (Source.Error (at', msg))
    in
    r := Render.render_exp env.render exp
  );
  b

let splice_anchor env file s i anchor buf =
  skip_space s i;
  Buffer.add_string buf anchor.prefix;
  let r = ref "" in
  ignore (
    try_exp_anchor env file s i r ||
    try_def_anchor env file s i r "syntax+" "syntax" "fragment" find_syntax true ||
    try_def_anchor env file s i r "syntax" "syntax" "fragment" find_syntax false ||
    try_def_anchor env file s i r "relation" "relation" "" find_relation false ||
    try_def_anchor env file s i r "rule+" "relation" "rule" find_rule true ||
    try_def_anchor env file s i r "rule" "relation" "rule" find_rule false ||
    try_def_anchor env file s i r "definition" "definition" "" find_func false ||
    error file s !i "unknown definition sort";
  );
  let s =
    if anchor.indent = "" then !r else
    Str.(global_replace (regexp "\n") ("\n" ^ anchor.indent) !r)
  in
  Buffer.add_string buf s;
  Buffer.add_string buf anchor.suffix

let rec try_anchors env file s i buf = function
  | [] -> false
  | anchor::anchors ->
    if try_anchor_start s i anchor.token then
      (splice_anchor env file s i anchor buf; true)
    else
      try_anchors env file s i buf anchors

let rec splice env file s i buf =
  if !i < len s then (
  	if not (try_anchors env file s i buf env.config.anchors) then
      (Buffer.add_char buf s.[!i]; incr i);
    splice env file s i buf
  )


(* Entry points *)

let splice_string env file s : string =
  let buf = Buffer.create (String.length s) in
  splice env file s (ref 0) buf;
  Buffer.contents buf

let splice_file ?(dry = false) env file =
  let ic = In_channel.open_text file in
  let s =
    Fun.protect (fun () -> In_channel.input_all ic)
      ~finally:(fun () -> In_channel.close ic)
  in
  let s' = splice_string env file s in
  if not dry then
    let oc = Out_channel.open_text file in
    Fun.protect (fun () -> Out_channel.output_string oc s')
      ~finally:(fun () -> Out_channel.close oc)
