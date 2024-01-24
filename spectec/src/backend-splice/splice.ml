open Util
open Source
open El.Ast
open Backend_prose.Prose
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

type syntax = {sdef : El.Ast.def; sfragments : (string * El.Ast.def * use) list}
type grammar = {gdef : El.Ast.def; gfragments : (string * El.Ast.def * use) list}
type relation = {rdef : El.Ast.def; rules : (string * El.Ast.def * use) list}
type definition = {fdef : El.Ast.def; clauses : El.Ast.def list; use : use}
type rule_prose = {rdef : Backend_prose.Prose.def; use : use}
type func_prose = {fdef : Backend_prose.Prose.def; use : use}
type pred_prose = {pdef : Backend_prose.Prose.def; use : use}

type env =
  { config : Config.config;
    render_latex : Backend_latex.Render.env;
    render_prose : Backend_prose.Render.env;
    mutable syn : syntax Map.t;
    mutable gram : grammar Map.t;
    mutable rel : relation Map.t;
    mutable def : definition Map.t;
    mutable rprose : rule_prose Map.t;
    mutable fprose : func_prose Map.t;
    mutable pprose : pred_prose Map.t;
  }

let env_el_def env def =
  match def.it with
  | SynD (id1, id2, _, _, _) ->
    if not (Map.mem id1.it env.syn) then
      env.syn <- Map.add id1.it {sdef = def; sfragments = []} env.syn;
    let syntax = Map.find id1.it env.syn in
    let sfragments = syntax.sfragments @ [(id2.it, def, ref 0)] in
    env.syn <- Map.add id1.it {syntax with sfragments} env.syn
  | GramD (id1, id2, _, _, _, _) ->
    if not (Map.mem id1.it env.gram) then
      env.gram <- Map.add id1.it {gdef = def; gfragments = []} env.gram;
    let grammar = Map.find id1.it env.gram in
    let gfragments = grammar.gfragments @ [(id2.it, def, ref 0)] in
    env.gram <- Map.add id1.it {grammar with gfragments} env.gram
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

let env_prose_def env prose =
  match prose with
  | Pred ((id, _), _, _) -> env.pprose <- Map.add id {pdef = prose; use = ref 0} env.pprose
  | Algo algo -> (match algo with
    | Al.Ast.RuleA ((id, _), _, _) -> env.rprose <- Map.add id {rdef = prose; use = ref 0} env.rprose
    | Al.Ast.FuncA (id, _, _) -> env.fprose <- Map.add id {fdef = prose; use = ref 0} env.fprose)

let env config pdsts odsts el prose : env =
  let render_latex = Backend_latex.Render.env config.latex el in
  let render_prose = Backend_prose.Render.env config.prose pdsts odsts render_latex el prose in
  let env =
    { config;
      render_latex;
      render_prose;
      syn = Map.empty;
      gram = Map.empty;
      rel = Map.empty;
      def = Map.empty;
      rprose = Map.empty;
      fprose = Map.empty;
      pprose = Map.empty
    }
  in
  List.iter (env_el_def env) el;
  List.iter (env_prose_def env) prose;
  env


let warn_use use space id1 id2 =
  if !use <> 1 then
    let id = if id2 = "" then id1 else id1 ^ "/" ^ id2 in
    let msg = if !use = 0 then "never spliced" else "spliced more than once" in
    prerr_endline ("warning: " ^ space ^ " `" ^ id ^ "` was " ^ msg)

let warn env =
  Map.iter (fun id1 {sfragments; _} ->
    List.iter (fun (id2, _, use) -> warn_use use "syntax" id1 id2) sfragments
  ) env.syn;
  Map.iter (fun id1 {gfragments; _} ->
    List.iter (fun (id2, _, use) -> warn_use use "grammar" id1 id2) gfragments
  ) env.gram;
  Map.iter (fun id1 {rules; _} ->
  	List.iter (fun (id2, _, use) -> warn_use use "rule" id1 id2) rules
  ) env.rel;
  Map.iter (fun id1 ({use; _}: definition) -> warn_use use "definition" id1 "") env.def;
  Map.iter (fun id1 ({use; _}: rule_prose) -> warn_use use "execution prose" id1 "") env.rprose;
  Map.iter (fun id1 ({use; _}: func_prose) -> warn_use use "function prose" id1 "") env.fprose;
  Map.iter (fun id1 ({use; _}: pred_prose) -> warn_use use "validation prose" id1 "") env.pprose


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
  | Some syntax -> find_entries "syntax" src id1 id2 syntax.sfragments

let find_grammar env src id1 id2 =
  match Map.find_opt id1 env.gram with
  | None -> error src ("unknown grammar identifier `" ^ id1 ^ "`")
  | Some grammar -> find_entries "grammar" src id1 id2 grammar.gfragments

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

let find_rule_prose env src id = match Map.find_opt id env.rprose with
  | None -> error src ("unknown execution prose identifier `" ^ id ^ "`")
  | Some rprose -> incr rprose.use; rprose.rdef

let find_func_prose env src id = match Map.find_opt id env.fprose with
  | None -> error src ("unknown function prose identifier `" ^ id ^ "`")
  | Some fprose -> incr fprose.use; fprose.fdef

let find_pred_prose env src id = match Map.find_opt id env.pprose with
  | None -> error src ("unknown validation prose identifier `" ^ id ^ "`")
  | Some pprose -> incr pprose.use; pprose.pdef

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
  | 'A'..'Z' | 'a'..'z' | '0'..'9' | '_' | '\'' | '`' | '-' | '*' | '.' ->
    (adv src; parse_id' src)
  | _ -> ()

let parse_id src space : string =
  let j = src.i in
  parse_id' src;
  if j = src.i then
    error {src with i = j} ("expected " ^ space ^ " identifier or `}`");
  str src j

let parse_id_id env src space1 space2 find : El.Ast.def list =
  let j = src.i in
  let id1 = parse_id src space1 in
  let id2 =
    if space2 <> "" && try_string src "/" then parse_id src space2 else ""
  in find env {src with i = j} id1 id2

let rec parse_id_id_list env src space1 space2 find : El.Ast.def list =
  parse_space src;
  if try_string src "}" then [] else
  let defs1 = parse_id_id env src space1 space2 find in
  let defs2 = parse_id_id_list env src space1 space2 find in
  defs1 @ defs2

let rec parse_group_list env src space1 space2 find : El.Ast.def list list =
  parse_space src;
  if try_string src "}" then [] else
  let groups =
    if try_string src "{" then
      [parse_id_id_list env src space1 space2 find]
    else
      List.map (fun def -> [def]) (parse_id_id env src space1 space2 find)
  in
  groups @ parse_group_list env src space1 space2 find

type mode = Decorated | Undecorated | Ignored

let try_def_anchor env src r sort space1 space2 find mode : bool =
  let b = try_string src sort in
  if b then
  ( parse_space src;
    if not (try_string src ":") then
      error src "colon `:` expected";
    let groups = parse_group_list env src space1 space2 find in
    let defs = List.tl (List.concat_map ((@) [SepD $ no_region]) groups) in
    if mode <> Ignored then
    ( let env' = env.render_latex
        |> Backend_latex.Render.with_syntax_decoration (mode = Decorated)
        |> Backend_latex.Render.with_rule_decoration (mode = Decorated)
      in r := Backend_latex.Render.render_defs env' defs
    )
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
    r := Backend_latex.Render.render_exp env.render_latex exp
  );
  b

let try_prose_anchor env src r sort find : bool =
  let b = try_string src sort in
  if b then (
    parse_space src;
    if not (try_string src ":") then
      error src "colon `:` expected";
    parse_space src;
    let id = parse_id src "prose name" in
    if not (try_string src "}") then
      error src "closing bracket `}` expected";
    let prose = find env src id in
    r := Backend_prose.Render.render_def env.render_prose prose
  );
  b

(* Splicing *)

let splice_anchor env src anchor buf =
  parse_space src;
  let r = ref "" in
  ignore (
    try_exp_anchor env src r ||
    try_def_anchor env src r "syntax-ignore" "syntax" "fragment" find_syntax Ignored ||
    try_def_anchor env src r "grammar-ignore" "grammar" "fragment" find_grammar Ignored ||
    try_def_anchor env src r "relation-ignore" "relation" "" find_relation Ignored ||
    try_def_anchor env src r "rule-ignore" "relation" "rule" find_rule Ignored ||
    try_def_anchor env src r "definition-ignore" "definition" "" find_func Ignored ||
    try_def_anchor env src r "syntax+" "syntax" "fragment" find_syntax Decorated ||
    try_def_anchor env src r "syntax" "syntax" "fragment" find_syntax Undecorated ||
    try_def_anchor env src r "grammar" "grammar" "fragment" find_grammar Undecorated ||
    try_def_anchor env src r "relation" "relation" "" find_relation Undecorated ||
    try_def_anchor env src r "rule+" "relation" "rule" find_rule Decorated ||
    try_def_anchor env src r "rule" "relation" "rule" find_rule Undecorated ||
    try_def_anchor env src r "definition" "definition" "" find_func Undecorated ||
    try_prose_anchor env src r "prose-pred" find_pred_prose ||
    try_prose_anchor env src r "prose-algo" find_rule_prose ||
    try_prose_anchor env src r "prose-func" find_func_prose ||
    error src "unknown definition sort";
  );
  if !r <> "" then
  ( let s =
      if anchor.indent = "" then !r else
      Str.(global_replace (regexp "\n") ("\n" ^ anchor.indent) !r)
    in
    Buffer.add_string buf anchor.prefix;
    Buffer.add_string buf s;
    Buffer.add_string buf anchor.suffix;
  )

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

let splice_file env file_in file_out =
  let ic = In_channel.open_text file_in in
  let s =
    Fun.protect (fun () -> In_channel.input_all ic)
      ~finally:(fun () -> In_channel.close ic)
  in
  let s' = splice_string env file_in s in
  if file_out = "" then print_endline s' else
    let oc = Out_channel.open_text file_out in
    Fun.protect (fun () -> Out_channel.output_string oc s')
      ~finally:(fun () -> Out_channel.close oc)
