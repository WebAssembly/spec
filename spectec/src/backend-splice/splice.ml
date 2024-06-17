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

let col src =
  let j = ref src.i in
  while !j > 0 && src.s.[!j - 1] <> '\n' do decr j done;
  src.i - !j

let pos src =
  let line = ref 1 in
  let col = ref 1 in
  for j = 0 to src.i - 1 do
    if src.s.[j] = '\n' then (incr line; col := 1) else incr col
  done;
  Source.{file = src.file; line = !line; column = !col}

let region src = let pos = pos src in {left = pos; right = pos}

let error src msg = Error.error (region src) "splicing" msg

let try_with_error src i f x =
  try f x with Error.Error (at, msg) ->
    (* Translate relative positions *)
    let pos = pos {src with i} in
    let shift {line; column; _} =
      { file = src.file; line = line + pos.line - 1;
        column = if line = 1 then column + pos.column - 1 else column} in
    let at' = {left = shift at.left; right = shift at.right} in
Printexc.print_backtrace stdout;
    raise (Error.Error (at', msg))


(* Environment *)

module Map = Map.Make(String)

type use = int ref

type syntax = {sdef : El.Ast.def; sfragments : (string * El.Ast.def * use) list}
type grammar = {gdef : El.Ast.def; gfragments : (string * El.Ast.def * use) list}
type relation = {rdef : El.Ast.def; rules : (string * El.Ast.def * use) list}
type definition = {fdef : El.Ast.def; clauses : El.Ast.def list; use : use}
type relation_prose = {ralgos : (string * Backend_prose.Prose.def * use) list}
type definition_prose = {falgo : Backend_prose.Prose.def; use : use}

type env =
  { elab : Frontend.Elab.env;
    config : Config.t;
    latex : Backend_latex.Render.env;
    prose : Backend_prose.Render.env;
    mutable syn : syntax Map.t;
    mutable gram : grammar Map.t;
    mutable rel : relation Map.t;
    mutable def : definition Map.t;
    mutable rel_prose : relation_prose Map.t;
    mutable def_prose : definition_prose Map.t;
  }

let env_def env def =
  match def.it with
  | TypD (id1, id2, _, _, _) ->
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
  | FamD _ | VarD _ | SepD | HintD _ ->
    ()

let valid_id = "valid"
let exec_id = "exec"

let normalize_id id =
  let id' =
    if id = "" || id.[String.length id - 1] <> '_' then id else
    String.sub id 0 (String.length id - 1)
  in String.lowercase_ascii id'

let env_prose env prose =
  match prose with
  | Pred ((id, typ), _, _) ->
    let id = El.Atom.to_string (id $$ (no_region, ref typ)) in
    let relation = Map.find valid_id env.rel_prose in
    let ralgos = (normalize_id id, prose, ref 0) :: relation.ralgos in
    env.rel_prose <- Map.add valid_id {ralgos} env.rel_prose
  | Algo (Al.Ast.RuleA ((id, typ), _, _)) ->
    let id = El.Atom.to_string (id $$ (no_region, ref typ)) in
    let relation = Map.find exec_id env.rel_prose in
    let ralgos = (normalize_id id, prose, ref 0) :: relation.ralgos in
    env.rel_prose <- Map.add exec_id {ralgos} env.rel_prose
  | Algo (Al.Ast.FuncA (id, _, _)) ->
    env.def_prose <- Map.add id {falgo = prose; use = ref 0} env.def_prose

let env (config : config) pdsts odsts elab el pr : env =
  let latex = Backend_latex.Render.env config.latex el in
  let prose = Backend_prose.Render.env pdsts odsts latex el pr in
  let env =
    { elab; config; latex; prose;
      syn = Map.empty;
      gram = Map.empty;
      rel = Map.empty;
      def = Map.empty;
      rel_prose = Map.(add valid_id {ralgos = []} (add exec_id {ralgos = []} empty));
      def_prose = Map.empty;
    }
  in
  List.iter (env_def env) el;
  List.iter (env_prose env) pr;
  env


let warn_use use space id1 id2 =
  if !use <> 1 then
    let id = if id2 = "" then id1 else id1 ^ "/" ^ id2 in
    let msg = if !use = 0 then "never spliced" else "spliced more than once" in
    prerr_endline ("warning: " ^ space ^ " `" ^ id ^ "` was " ^ msg)

let warn_math env =
  Map.iter (fun id1 {sfragments; _} ->
    List.iter (fun (id2, _, use) -> warn_use use "syntax" id1 id2) sfragments
  ) env.syn;
  Map.iter (fun id1 {gfragments; _} ->
    List.iter (fun (id2, _, use) -> warn_use use "grammar" id1 id2) gfragments
  ) env.gram;
  Map.iter (fun id1 {rules; _} ->
  	List.iter (fun (id2, _, use) -> warn_use use "rule" id1 id2) rules
  ) env.rel;
  Map.iter (fun id1 ({use; _} : definition) ->
    warn_use use "definition" id1 ""
  ) env.def

let warn_prose env =
  Map.iter (fun id1 {ralgos} ->
    List.iter (fun (id2, _, use) -> warn_use use "rule prose" id1 id2) ralgos
  ) env.rel_prose;
  Map.iter (fun id1 ({use; _} : definition_prose) ->
    warn_use use "definition prose" id1 ""
  ) env.def_prose


let find_nosub space src id1 id2 =
  if id2 <> "" then
    error src ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`")

let match_full re s =
  Str.string_match re s 0 && Str.match_end () = String.length s

let find_entries space src id1 id2 entries =
  let id2' = if id2 = "" then "*" else id2 in
  let re = Str.(regexp (global_replace (regexp "\\*\\|\\?") (".\\0") id2')) in
  let defs = List.filter (fun (id, _, _) -> match_full re id) entries in
  if defs = [] then
    error src ("unknown " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2' ^ "`");
  List.map (fun (_, def, use) -> incr use; def) defs

let find_entry space src id1 id2 entries =
  match find_entries space src id1 id2 entries with
  | [def] -> def
  | defs ->
    Printf.eprintf "warning: %s `%s/%s` has multiple definitions\n%!" space id1 id2;
    List.hd defs
(* TODO: this should be an error
    error src ("duplicate " ^ space ^ " identifier `" ^ id1 ^ "/" ^ id2 ^ "`")
*)

let find_syntax env src id1 id2 =
  match Map.find_opt id1 env.syn with
  | None -> error src ("unknown syntax identifier `" ^ id1 ^ "`")
  | Some syntax ->
    let defs = find_entries "syntax" src id1 id2 syntax.sfragments in
    if id2 = "" then [defs] else List.map (fun def -> [def]) defs

let find_grammar env src id1 id2 =
  match Map.find_opt id1 env.gram with
  | None -> error src ("unknown grammar identifier `" ^ id1 ^ "`")
  | Some grammar ->
    let defs = find_entries "grammar" src id1 id2 grammar.gfragments in
    if id2 = "" then [defs] else List.map (fun def -> [def]) defs

let find_relation env src id1 id2 =
  find_nosub "relation" src id1 id2;
  match Map.find_opt id1 env.rel with
  | None -> error src ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> [[relation.rdef]]

let find_rule env src id1 id2 =
  match Map.find_opt id1 env.rel with
  | None -> error src ("unknown relation identifier `" ^ id1 ^ "`")
  | Some relation -> [find_entries "rule" src id1 id2 relation.rules]

let find_def env src id1 id2 =
  find_nosub "definition" src id1 id2;
  match Map.find_opt id1 env.def with
  | None -> error src ("unknown definition identifier `" ^ id1 ^ "`")
  | Some definition ->
    if definition.clauses = [] then
      error src ("definition `" ^ id1 ^ "` has no clauses");
    incr definition.use; [definition.clauses]

let find_rule_prose env src id1 id2 =
  match Map.find_opt id1 env.rel_prose with
  | None -> error src ("unknown prose relation identifier `" ^ id1 ^ "`")
  | Some relation -> find_entry "prose rule" src id1 id2 relation.ralgos

let find_def_prose env src id1 id2 =
  find_nosub "definition" src id1 id2;
  match Map.find_opt id1 env.def_prose with
  | None -> error src ("unknown prose definition identifier `" ^ id1 ^ "`")
  | Some definition -> incr definition.use; definition.falgo


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

let rec parse_to_colon src =
  if eos src then
    error src "colon `:` expected"
  else if get src <> ':' then
    (adv src; parse_to_colon src)

let rec parse_to_anchor_end i0 depth src =
  if eos src then
    error {src with i = i0} "unclosed anchor"
  else if get src = '{' then
    (adv src; parse_to_anchor_end i0 (depth + 1) src)
  else if get src <> '}' then
    (adv src; parse_to_anchor_end i0 depth src)
  else if depth > 0 then
    (adv src; parse_to_anchor_end i0 (depth - 1) src)

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

let parse_id_id env src space1 space2 find =
  let j = src.i in
  let id1 = parse_id src space1 in
  let id2 =
    if space2 <> "" && try_string src "/" then parse_id src space2 else ""
  in find env {src with i = j} id1 id2

let rec parse_id_id_list env src space1 space2 find : El.Ast.def list list =
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
      [List.concat (parse_id_id_list env src space1 space2 find)]
    else
      parse_id_id env src space1 space2 find
  in
  groups @ parse_group_list env src space1 space2 find

let try_def_anchor env src r sort space1 space2 find : bool =
  let b = try_string src (sort ^ ":") in
  if b then
  ( let groups = parse_group_list env src space1 space2 find in
    let defs = List.tl (List.concat_map ((@) [SepD $ no_region]) groups) in
    if not (String.ends_with ~suffix:"-ignore" sort) then
      let decorated = String.ends_with ~suffix:"+" sort in
      let unmacrofied = String.ends_with ~suffix:"-" sort in
      let env' = env.latex
        |> Backend_latex.Render.without_macros unmacrofied
        |> Backend_latex.Render.with_syntax_decoration decorated
        |> Backend_latex.Render.with_rule_decoration decorated
      in
      r := Backend_latex.Render.render_defs env' defs
  );
  b

let try_relid src : id option =
  let i = src.i in
  parse_space src;
  let id = try parse_id src "relation" with Error.Error _ -> " " in
  if id.[0] <> Char.lowercase_ascii id.[0] then
    let pos = pos {src with i} in
    let left = {file = src.file; line = pos.line; column = pos.column} in
    let right = {left with column = left.column + String.length id} in
    Some (id $ {left; right})
  else
    (advn src (i - src.i); None)

let run_parser find_end parser src =
  let i = src.i in
  find_end src;
  let s = str src i in
  adv src;
  try_with_error src i parser s

let parse_typ src : typ =
  run_parser parse_to_colon Frontend.Parse.parse_typ src

let parse_exp src i0 : exp =
  run_parser (parse_to_anchor_end i0 0) Frontend.Parse.parse_exp src

let parse_sym src i0 : sym =
  run_parser (parse_to_anchor_end i0 0) Frontend.Parse.parse_sym src

let elab_exp src i elaborator env exp typ =
  try_with_error src i (elaborator env.elab exp) typ

let render_exp src i renderer env exp =
  try_with_error src i (renderer env) exp

let render_sym = render_exp

let try_exp_anchor env src r : bool =
  let i0 = src.i in
  if try_string src "-:" then (
    let exp = parse_exp src (i0 - 2) in
    let env' = Backend_latex.Render.without_macros true env.latex in
    r := render_exp src (i0 - 2) Backend_latex.Render.render_exp env' exp;
    true
  )
  else if try_string src ":" then (
    let exp = parse_exp src (i0 - 2) in
    r := render_exp src (i0 - 2) Backend_latex.Render.render_exp env.latex exp;
    true
  )
  else
    match try_relid src with
    | Some id when try_string src ":" ->
      let i = src.i in
      let exp = parse_exp src (i0 - 2) in
      let _ = elab_exp src i Frontend.Elab.elab_rel env exp id in
      r := render_exp src i Backend_latex.Render.render_exp env.latex exp;
      true
    | Some _ -> advn src (i0 - src.i); false
    | None ->
      match parse_typ src with
      | typ ->
        let i = src.i in
        let exp = parse_exp src (i0 - 2) in
        let _ = elab_exp src i Frontend.Elab.elab_exp env exp typ in
        r := render_exp src i Backend_latex.Render.render_exp env.latex exp;
        true
      | exception Error.Error _ -> advn src (i0 - src.i); false

let try_sym_anchor env src r sort : bool =
  let i0 = src.i in
  let b = try_string src (sort ^ ":") in
  if b then (
    let sym = parse_sym src (i0 - 2) in
    r := render_sym src (i0 - 2) Backend_latex.Render.render_sym env.latex sym;
  );
  b

let try_prose_anchor env src r sort space1 space2 find : bool =
  let b = try_string src (sort ^ ":") in
  if b then (
    parse_space src;
    let algo = parse_id_id env src space1 space2 find in
    parse_space src;
    if not (try_string src "}") then
      error src "closing bracket `}` expected";
    if not (String.ends_with ~suffix:"-ignore" sort) then
      r := Backend_prose.Render.render_def env.prose algo
  );
  b


(* Splicing *)

let splice_anchor env src splice_pos anchor buf =
  let open Backend_latex in
  let config = {(Render.config env.latex) with Config.display = anchor.newline} in
  let env' = {env with latex = Render.env_with_config env.latex config} in
  parse_space src;
  let r = ref "" in
  let prose = ref true in
  ignore (
    try_prose_anchor env' src r "rule-prose" "prose relation" "rule" find_rule_prose ||
    try_prose_anchor env' src r "definition-prose" "prose definition" "" find_def_prose ||
    try_prose_anchor env' src r "rule-prose-ignore" "prose relation" "rule" find_rule_prose ||
    try_prose_anchor env' src r "definition-prose-ignore" "prose definition" "" find_def_prose ||
    (prose := false; false) ||
    try_def_anchor env' src r "syntax" "syntax" "fragment" find_syntax ||
    try_def_anchor env' src r "syntax+" "syntax" "fragment" find_syntax ||
    try_def_anchor env' src r "syntax-" "syntax" "fragment" find_syntax ||
    try_def_anchor env' src r "grammar" "grammar" "fragment" find_grammar ||
    try_def_anchor env' src r "grammar-" "grammar" "fragment" find_grammar ||
    try_def_anchor env' src r "relation" "relation" "" find_relation ||
    try_def_anchor env' src r "relation-" "relation" "" find_relation ||
    try_def_anchor env' src r "rule" "relation" "rule" find_rule ||
    try_def_anchor env' src r "rule+" "relation" "rule" find_rule ||
    try_def_anchor env' src r "rule-" "relation" "rule" find_rule ||
    try_def_anchor env' src r "definition" "definition" "" find_def ||
    try_def_anchor env' src r "definition-" "definition" "" find_def ||
    try_def_anchor env' src r "syntax-ignore" "syntax" "fragment" find_syntax ||
    try_def_anchor env' src r "grammar-ignore" "grammar" "fragment" find_grammar ||
    try_def_anchor env' src r "relation-ignore" "relation" "" find_relation ||
    try_def_anchor env' src r "rule-ignore" "relation" "rule" find_rule ||
    try_def_anchor env' src r "definition-ignore" "definition" "" find_def ||
    try_sym_anchor env' src r "grammar-case" ||
    try_exp_anchor env' src r ||
    error src "unknown anchor sort";
  );
  if !r <> "" then
  ( let s = if !prose then !r else anchor.prefix ^ !r ^ anchor.suffix in
    let indent = if !prose then "" else anchor.indent in
    let nl =
      if not anchor.newline then " " else
      "\n" ^ String.make (col {src with i = splice_pos}) ' ' ^ indent
    in
    let s' = if nl = "\n" then s else Str.(global_replace (regexp "\n") nl s) in
    Buffer.add_string buf s'
  )

let rec try_anchors env src buf = function
  | [] -> false
  | anchor::anchors ->
    let i = src.i in
    if try_anchor_start src anchor.token then
      (splice_anchor env src i anchor buf; true)
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

let splice_file ?(dry = false) env infile outfile =
  let ic = In_channel.open_text infile in
  let s =
    Fun.protect (fun () -> In_channel.input_all ic)
      ~finally:(fun () -> In_channel.close ic)
  in
  let s' = splice_string env infile s in
  if not dry then
    if outfile = "" then print_endline s' else
      let oc = Out_channel.open_text outfile in
      Fun.protect (fun () -> Out_channel.output_string oc s')
        ~finally:(fun () -> Out_channel.close oc)
