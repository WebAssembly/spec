open Prose
open Printf
open Util.Source

(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type env = 
  { prose: prose;
    syn: string list Map.t ref;
    dec: Set.t ref;
  }

let all_keywords env =
  let syn = !(env.syn) in
  let syn = Map.fold
    (fun _parent children acc -> 
      List.fold_left (fun acc child -> Set.add child acc) acc children)
    syn Set.empty
  in
  let dec = !(env.dec) in
  let dec = Set.fold
    (fun keyword acc -> Set.add keyword acc)
    dec Set.empty
  in
  Set.union syn dec

let find_keyword env s = Set.find_opt s (all_keywords env)

let extract_ids_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem elem -> Some elem.it

let extract_typcases_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let extract_typfields_keywords = function
  | El.Ast.Nl -> None
  | El.Ast.Elem (atom, _, _) -> (match atom with
    | El.Ast.Atom id -> Some id
    | _ -> None)

let rec extract_typ_keywords typ =
  match typ with
  | El.Ast.AtomT atom -> (match atom with
    | El.Ast.Atom id -> [ id ]
    | _ -> [])
  | El.Ast.IterT (typ_inner, _) -> extract_typ_keywords typ_inner.it
  | El.Ast.StrT typfields -> List.filter_map extract_typfields_keywords typfields
  | El.Ast.CaseT (_, ids, typcases, _) ->
      let ids = List.filter_map extract_ids_keywords ids in
      let typcases = List.filter_map extract_typcases_keywords typcases in
      ids @ typcases
  | El.Ast.SeqT tl -> List.concat_map (fun t -> extract_typ_keywords t.it) tl
  | _ -> []

let extract_syn_keywords def =
  match def.it with
  | El.Ast.SynD (id, subid, typ, _) -> 
      let parent = if subid.it = "" then id.it else id.it ^ "-" ^ subid.it in
      let children = extract_typ_keywords typ.it in
      Some (parent, children)
  | _ -> None

let extract_dec_keywords def =
  match def.it with
  | El.Ast.DecD (id, _, _, _) -> [ id.it ]
  | _ -> []

let env _config el il al : env = 
  let prose = Gen.gen_prose il al in
  let syn = 
    List.fold_left 
      (fun acc def -> match extract_syn_keywords def with
        | Some (parent, children) -> Map.add parent ([ parent ] @ children) acc
        | _ -> acc)
      Map.empty el 
  in
  let dec = List.concat_map extract_dec_keywords el in
  let dec = List.fold_left (fun s acc -> Set.add acc s) Set.empty dec in
  (* Set.iter print_endline keywords; *)
  let env = { prose; syn = ref syn; dec = ref dec; } in
  env

(* Macro Generation *)

let macro_template = {|
.. MATH MACROS


.. Generic Stuff
.. -------------

.. Type-setting of names
.. X - (multi-letter) variables / non-terminals
.. F - functions
.. K - keywords / terminals
.. B - binary grammar non-terminals
.. T - textual grammar non-terminals

.. |X| mathdef:: \mathit
.. |F| mathdef:: \mathrm
.. |K| mathdef:: \mathsf
.. |B| mathdef:: \mathtt
.. |T| mathdef:: \mathtt

|}

(* TODO a hack to remove . s in name, i.e., LOCAL.GET to LOCALGET,
   such that it is macro-compatible *)
let macroify s = 
  let del acc c =
    if c = '.' || c = '_' then acc
    else acc ^ (String.make 1 c) 
  in
  String.fold_left del "" s

let render_macro_keyword s = 
  let s = if String.uppercase_ascii s = s then String.lowercase_ascii s else s in
  let escape acc c =
    if c = '.' then acc ^ "{.}"
    else if c = '_' then acc ^ "\\_"
    else acc ^ (String.make 1 c)
  in
  String.fold_left escape "" s

let render_macro_def ref s =
  (* TODO hardcoded to avoid duplicate macros *)
  if s = "_F" then ""
  else if s = "LABEL_" then ".. |label| mathdef:: {\\X{label}}"
  else
    let xref = sprintf "\\xref{%s}{%s}" "" ref in
    let typ = if s = (String.uppercase_ascii s) then "K" else "X" in
    sprintf ".. |%s| mathdef:: {\\%s{%s}}\n.. (%s)"
      (macroify s) typ (render_macro_keyword s) xref

let render_macro_syn syn seen =
  Map.fold
    (fun parent children acc ->
      let ssyn, seen = acc in
      let schildren, seen = List.fold_left
        (fun acc keyword ->
          let schildren, seen = acc in
          let (skeyword, seen) = 
            if Set.mem keyword seen then (".. (duplicate) " ^ keyword, seen)
            else (render_macro_def ("syntax-" ^ parent) keyword, Set.add keyword seen)
          in
          (schildren ^ skeyword ^ "\n", seen))
        ("", seen) children
      in
      let ssyn = ssyn
        ^ ".. " ^ (String.uppercase_ascii parent) ^ "\n"
        ^ ".. " ^ (String.make (String.length parent) '-') ^ "\n"
        ^ schildren
        ^ "\n"
      in
      (ssyn, seen)
    )
    syn ("", seen)

let render_macro_dec dec seen =
  Set.fold
    (fun keyword acc -> 
      let sdec, seen = acc in
      let skeyword, seen =
        if Set.mem keyword seen then (".. (duplicate) " ^ keyword, seen)
        else (render_macro_def ("exec-" ^ keyword) keyword, Set.add keyword seen)
      in
      (sdec ^ skeyword ^ "\n", seen))
    dec ("", seen)

let render_macro env =
  let (ssyn, seen) = render_macro_syn !(env.syn) Set.empty in
  let (sdec, _seen) = render_macro_dec !(env.dec) seen in
  macro_template
  ^ ".. Syntax\n.. ------\n\n"
  ^ ssyn
  ^ ".. Functions\n.. ---------\n\n"
  ^ sdec

(* Helpers *)

let indent = "   "

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

let math = ":math:"

let render_math s = math ^ sprintf "`%s`" s

let render_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let render_order index depth =
  index := !index + 1;

  let num_idx = string_of_int !index in
  let alp_idx = Char.escaped (Char.chr (96 + !index)) in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> failwith "unreachable"

let render_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      let limit = 16 in
      let is_long = List.length t > limit in
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "...") else "")
      ^ right

(* Operators *)

let render_prose_cmpop = function
  | Eq -> "equal to"
  | Ne -> "different with"
  | Lt -> "less than"
  | Gt -> "greater than"
  | Le -> "less than or equal to"
  | Ge -> "greater than or equal to"

let render_al_cmpop = function
  | Al.Ast.Eq -> "is"
  | Al.Ast.Ne -> "is not"
  | Al.Ast.Gt -> "is greater than"
  | Al.Ast.Ge -> "is greater than or equal to"
  | Al.Ast.Lt -> "is less than"
  | Al.Ast.Le -> "is less than or equal to"

let render_al_logop = function
  | Al.Ast.And -> "and"
  | Al.Ast.Or -> "or"
  | Al.Ast.Impl -> "=>"
  | Al.Ast.Equiv -> "<=>"

let render_al_mathop = function
  | Al.Ast.Add -> "+"
  | Al.Ast.Sub -> "-"
  | Al.Ast.Mul -> "\\cdot"
  | Al.Ast.Div -> "/"
  | Al.Ast.Exp -> "^"

(* Names and Iters *)

(* assume Names and Iters are always embedded in math blocks *)

let rec render_name env = function
  | Al.Ast.N s when s = "inverse_of_bytes_" -> s 
  | Al.Ast.N s -> (match find_keyword env s with
    | Some _ -> sprintf "\\%s" (macroify s) 
    | _ -> (match String.index_opt s '_' with 
      | Some idx ->
          let base = String.sub s 0 idx in
          let subscript = String.sub s (idx + 1) ((String.length s) - idx - 1) in
          base ^ "_{" ^ subscript ^ "}"
      | _ -> s))
  | Al.Ast.SubN (n, s) -> sprintf "%s_%s" (render_name env n) s

let rec render_iter env in_math = function
  | Al.Ast.Opt -> "^?"
  | Al.Ast.List -> "^\\ast"
  | Al.Ast.List1 -> "^{+}"
  | Al.Ast.ListN name -> "^{" ^ render_name env name ^ "}"
  | Al.Ast.IndexedListN (name, expr) ->
    "^(" ^ render_name env name ^ "<" ^ render_expr env in_math expr ^ ")"

and render_iters env in_math iters = List.map (render_iter env in_math) iters |> List.fold_left (^) ""

(* Expressions and Paths *)

and render_expr env in_math = function
  | Al.Ast.NumE i ->
      let si = Int64.to_string i in
      if in_math then si else render_math si
  | Al.Ast.StringE s -> s
  | Al.Ast.MinusE e ->
      let se = render_expr env in_math e in
      let s = sprintf "-%s" se in
      if in_math then s else render_math s
  | Al.Ast.BinopE (op, e1, e2) ->
      let sop = render_al_mathop op in
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "{%s} %s {%s}" se1 sop se2 in
      if in_math then s else render_math s
  | Al.Ast.PairE (e1, e2) ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.AppE (n, es) ->
      let sn = render_name env n in
      let ses = render_list (render_expr env true) "" ", " "" es in
      let s = sprintf "%s(%s)" sn ses in
      if in_math then s else render_math s
  | Al.Ast.MapE (n, es, iters) ->
      let sn = render_name env n in
      let ses = render_list (render_expr env true) "" ", " "" es in
      let siters = render_iters env in_math iters in
      let s = sprintf "(%s(%s))%s" sn ses siters in
      if in_math then s else render_math s
  (* TODO a better way to flatten single-element list? *)
  | Al.Ast.ConcatE (Al.Ast.ListE e1, Al.Ast.ListE e2) when List.length e1 = 1 && List.length e2 = 1 ->
      let se1 = render_expr env true (List.hd e1) in
      let se2 = render_expr env true (List.hd e2) in
      let s = sprintf "%s~%s" se1 se2 in 
      if in_math then s else render_math s
  | Al.Ast.ConcatE (Al.Ast.ListE e1, e2) when List.length e1 = 1 ->
      let se1 = render_expr env true (List.hd e1) in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.ConcatE (e1, Al.Ast.ListE e2) when List.length e2 = 1 ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true (List.hd e2) in
      let s = sprintf "%s~%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.ConcatE (e1, e2) ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.LengthE e ->
      let se = render_expr env true e in
      if in_math then "|" ^ se ^ "|" else "the length of " ^ render_math se
  | Al.Ast.ArityE e -> sprintf "the arity of %s" (render_expr env in_math e)
  | Al.Ast.GetCurLabelE -> "the current label"
  | Al.Ast.GetCurFrameE -> "the current frame"
  | Al.Ast.GetCurContextE -> "the current context"
  | Al.Ast.FrameE (e1, e2) ->
      sprintf "the activation of %s with arity %s" (render_expr env in_math e2)
        (render_expr env in_math e1)
  | Al.Ast.ListE el -> 
      let sel = 
        if List.length el > 0 then
          render_list (render_expr env true) "" "~" "" el
        else
          "\\epsilon"
      in
      if in_math then sel else render_math sel
  | Al.Ast.ListFillE (e1, e2) -> 
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s^%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.AccessE (e, p) ->
      let se = render_expr env true e in
      let sp = render_path env p in
      let s = sprintf "%s%s" se sp in
      if in_math then s else render_math s
  | Al.Ast.ExtendE (e1, ps, e2, dir) ->
      let se1 = render_expr env in_math e1 in
      let sps = render_paths env in_math ps in
      let se2 = render_expr env in_math e2 in
      (match dir with
      | Al.Ast.Front -> sprintf "%s with %s prepended by %s" se1 sps se2
      | Al.Ast.Back -> sprintf "%s with %s appended by %s" se1 sps se2)
  | Al.Ast.ReplaceE (e1, ps, e2) ->
      sprintf "%s with %s replaced by %s" 
        (render_expr env in_math e1) 
        (render_paths env in_math ps)
        (render_expr env in_math e2)
  | Al.Ast.RecordE r ->
      let keys = Al.Record.Record.keys r in
      let sfields =
        List.map
          (fun k ->
            let v = Al.Record.Record.find k r in
            render_name env (N k) ^ "~" ^ render_expr env true v)
          keys
      in
      let sr = render_list Fun.id "\\{ " ", " " \\}" sfields in
      if in_math then sr else render_math sr
  | Al.Ast.ContE e -> sprintf "the continuation of %s" (render_expr env in_math e)
  | Al.Ast.LabelE (e1, e2) ->
      sprintf "the label whose arity is %s and whose continuation is %s" (render_expr env in_math e1) (render_expr env in_math e2)
  | Al.Ast.NameE n ->
      let sn = render_name env n in
      if in_math then sn else render_math sn
  | Al.Ast.IterE (Al.Ast.NameE n, iter) ->
      let sn = render_name env n in
      let siter = render_iter env in_math iter in
      let s = sprintf "{%s}%s" sn siter in
      if in_math then s else render_math s
  | Al.Ast.IterE (e, iter) -> 
      let se = render_expr env in_math e in
      (* TODO need a better way to e should be enclosed in parentheses *)
      let se = if String.contains se '~' then "(" ^ se ^ ")" else se in
      let siter = render_iter env in_math iter in
      "{" ^ se ^ "}" ^ siter
  | Al.Ast.ArrowE (e1, e2) ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s \\to %s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.ConstructE (s, []) ->
      let s = render_name env (N s) in
      if in_math then s else render_math s
  (* TODO a hard-coded hint for CONST *)
  | Al.Ast.ConstructE (s, [ e1; e2 ]) when s = "CONST" ->
      let s = render_name env (N s) in
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s.%s~%s" se1 s se2 in
      if in_math then s else render_math s
  | Al.Ast.ConstructE (s, es) ->
      let s = render_name env (N s) in
      let ses = render_list (render_expr env true) "" "~" "" es in
      let s = sprintf "%s~%s" s ses in
      if in_math then s else render_math s
  | Al.Ast.OptE (Some e) -> 
      let se = render_expr env true e in
      let s = sprintf "{%s}^?" se in 
      if in_math then s else render_math s
  | Al.Ast.OptE None -> 
      let s = "\\epsilon" in
      if in_math then s else render_math s
  | Al.Ast.YetE s -> sprintf "YetE (%s)" s

(* assume Paths are always embedded in math blocks *)

and render_path env = function
  | Al.Ast.IndexP e -> sprintf "[%s]" (render_expr env true e)
  | Al.Ast.SliceP (e1, e2) ->
      sprintf "[%s : %s]" (render_expr env true e1) (render_expr env true e2)
  | Al.Ast.DotP s -> sprintf ".%s" (render_name env (N s))

and render_paths env in_math paths = 
  let spaths = List.map (render_path env) paths |> List.fold_left (^) "" in
  if in_math then spaths else render_math spaths

(* Conditions *)

(* assume Conditions are never embedded in math blocks *)

and render_cond env = function
  | Al.Ast.NotC (Al.Ast.IsCaseOfC (e, c)) ->
      sprintf "%s is not of the case %s" 
        (render_expr env false e) 
        (render_math (render_name env (N c)))
  | Al.Ast.NotC (Al.Ast.IsDefinedC e) ->
      sprintf "%s is not defined" (render_expr env false e)
  | Al.Ast.NotC (Al.Ast.ValidC e) ->
      sprintf "%s is not valid" (render_expr env false e)
  | Al.Ast.NotC c -> sprintf "not %s" (render_cond env c)
  | Al.Ast.BinopC (op, c1, c2) ->
      sprintf "%s %s %s" (render_cond env c1) (render_al_logop op) (render_cond env c2)
  | Al.Ast.CompareC (op, e1, e2) ->
      sprintf "%s %s %s" (render_expr env false e1) (render_al_cmpop op) (render_expr env false e2)
  | Al.Ast.ContextKindC (s, e) -> sprintf "%s is %s" (render_expr env false e) s
  | Al.Ast.IsDefinedC e -> sprintf "%s is defined" (render_expr env false e)
  | Al.Ast.IsCaseOfC (e, c) -> sprintf "%s is of the case %s" (render_expr env false e) c
  | Al.Ast.ValidC e -> sprintf "%s is valid" (render_expr env false e)
  | Al.Ast.TopLabelC -> "a label is now on the top of the stack"
  | Al.Ast.TopFrameC -> "a frame is now on the top of the stack"
  | Al.Ast.TopValueC (Some e) -> sprintf "a value of value type %s is on the top of the stack" (render_expr env false e)
  | Al.Ast.TopValueC None -> "a value is on the top of the stack"
  | Al.Ast.TopValuesC e -> sprintf "there are at least %s values on the top of the stack" (render_expr env false e)
  | Al.Ast.YetC s -> sprintf "YetC (%s)" s

(* Instructions *)

let rec render_prose_instr env depth = function
  | LetI (e1, e2) ->
      sprintf "* Let %s be %s."
        (render_expr env false e1)
        (render_expr env false e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "* %s must be %s %s."
        (String.capitalize_ascii (render_expr env false e1))
        (render_prose_cmpop cmpop)
        (render_expr env false e2)
  | MustValidI (e1, e2, e3) ->
      sprintf "* Under the context %s, %s must be valid%s."
        (render_expr env false e1)
        (render_expr env false e2)
        (render_opt " with type " (render_expr env false) "" e3)
  | MustMatchI (e1, e2) ->
      sprintf "* %s must match %s."
        (String.capitalize_ascii (render_expr env false e1))
        (render_expr env false e2)
  | IsValidI e ->
      sprintf "* The instruction is valid%s."
        (render_opt " with type " (render_expr env false) "" e)
  | IfI (c, is) ->
      sprintf "* If %s,%s"
        (render_cond env c)
        (render_prose_instrs env (depth + 1) is)
  | ForallI (e1, e2, is) ->
      sprintf "* For all %s in %s,%s"
        (render_expr env false e1)
        (render_expr env false e2)
        (render_prose_instrs env (depth + 1) is)
  | EquivI (c1, c2) ->
      sprintf "* %s and %s are equivalent."
        (String.capitalize_ascii (render_cond env c1))
        (render_cond env c2)
  | YetI s ->
      sprintf "* YetI: %s." s

and render_prose_instrs env depth instrs =
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_prose_instr env depth i)
    "" instrs

let rec render_al_instr env algoname index depth = function
  | Al.Ast.IfI (c, il, []) ->
      sprintf "%s If %s, then:%s" (render_order index depth) (render_cond env c)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, []) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s"
        if_index
        (render_cond env c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond env inner_c)
        (render_al_instrs env algoname (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, inner_il2) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s\n%s Else:%s"
        if_index
        (render_cond env c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond env inner_c)
        (render_al_instrs env algoname (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs env algoname (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
      let if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else:%s" if_index (render_cond env c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
      sprintf "%s Otherwise:%s" (render_order index depth)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.WhileI (c, il) ->
      sprintf "%s While %s, do:%s" (render_order index depth) (render_cond env c)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
      let either_index = render_order index depth in
      let or_index = render_order index depth in
      sprintf "%s Either:%s\n\n%s Or:%s" either_index
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.ForI (e, il) ->
      sprintf "%s For i in range |%s|:%s" (render_order index depth)
        (render_expr env false e)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.ForeachI (e1, e2, il) ->
      sprintf "%s Foreach %s in %s:%s" (render_order index depth)
        (render_expr env false e1)
        (render_expr env false e2)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.AssertI c -> 
      (* TODO this is hardcoded for instructions without typing rules *)
      if 
        algoname = "label" || algoname = "call_addr" || algoname = "frame" 
        || algoname = "min" || algoname = "allocglobals" || algoname = "allocelems" || algoname = "allocmodule" 
      then
        sprintf "%s Assert: Due to validation, %s." (render_order index depth) (render_cond env c)
      else
        sprintf "%s Assert: Due to :ref:`validation <valid-%s>`, %s." (render_order index depth) (algoname) (render_cond env c)
  | Al.Ast.PushI e ->
      sprintf "%s Push %s to the stack." (render_order index depth)
        (render_expr env false e)
  (* TODO hardcoded for PopI on label or frame by raw string *)
  | Al.Ast.PopI (Al.Ast.NameE (Al.Ast.N s)) when s = "the label" || s = "the frame" ->
      sprintf "%s Pop %s from the stack." (render_order index depth) s
  | Al.Ast.PopI e ->
      sprintf "%s Pop %s from the stack." (render_order index depth)
        (render_expr env false e)
  | Al.Ast.PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (render_order index depth)
        (render_expr env false e)
  | Al.Ast.LetI (n, e) ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr env false n)
        (render_expr env false e)
  | Al.Ast.CallI (e, n, es, its) ->
      sprintf "%s Let %s be the result of computing %s." (render_order index depth)
        (render_expr env false e)
        (render_expr env false (Al.Ast.MapE(n, es, its)))
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
      sprintf "%s Return%s." (render_order index depth)
        (render_opt " " (render_expr env false) "" e_opt)
  | Al.Ast.EnterI (e1, e2) ->
      sprintf "%s Enter %s with label %s." (render_order index depth)
        (render_expr env false e1) (render_expr env false e2)
  | Al.Ast.ExecuteI e ->
      sprintf "%s Execute %s." (render_order index depth) (render_expr env false e)
  | Al.Ast.ExecuteSeqI e ->
      sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env false e)
  | Al.Ast.JumpI e ->
      sprintf "%s Jump to %s." (render_order index depth) (render_expr env false e)
  | Al.Ast.PerformI (n, es) ->
      sprintf "%s Perform %s." (render_order index depth) (render_expr env false (Al.Ast.AppE (n, es)))
  | Al.Ast.ExitNormalI _ | Al.Ast.ExitAbruptI _ -> render_order index depth ^ " Exit current context."
  | Al.Ast.ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s with %s." (render_order index depth)
        (render_expr env false (Al.Ast.AccessE (e1, p))) (render_expr env false e2)
  | Al.Ast.AppendI (e1, e2) ->
      sprintf "%s Append %s to the %s." (render_order index depth)
        (render_expr env false e2) (render_expr env false e1)
  | Al.Ast.AppendListI (e1, e2) ->
      sprintf "%s Append the sequence %s to the %s." (render_order index depth)
        (render_expr env false e2) (render_expr env false e1)
  | Al.Ast.YetI s -> sprintf "%s YetI: %s." (render_order index depth) s

and render_al_instrs env algoname depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_al_instr env algoname index depth i)
    "" instrs

(* Prose *)

let render_title env uppercase name params =
  (* TODO a workaround, for algorithms named label or name
     that are defined as LABEL_ or FRAME_ in the dsl *) 
  let name = 
    if name = "label" then "label_" 
    else if name = "frame" then "frame_" 
    else if name = "default" then "default_"
    else name 
  in
  let name = if uppercase then String.uppercase_ascii name else name in
  render_expr env false (Al.Ast.ConstructE (name, params))

let render_pred env name params instrs =
  let prefix = "validation_of_" in
  assert (String.starts_with ~prefix:prefix name);
  let name =
    String.sub name (String.length prefix) ((String.length name) - (String.length prefix))
  in
  let title = render_title env true name params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_prose_instrs env 0 instrs

let render_algo env name params instrs =
  let prefix = "execution_of_" in
  let (name, uppercase) =
    if String.starts_with ~prefix:prefix name then
      (String.sub name (String.length prefix) ((String.length name) - (String.length prefix)), true)
    else
      (name, false)
  in
  let title = render_title env uppercase name (List.map (fun p -> let (e, _) = p in e) params) in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_al_instrs env name 0 instrs

let render_def env = function
  | Pred (name, params, instrs) ->
    "\n" ^ render_pred env name params instrs ^ "\n\n"
  | Algo (Al.Ast.Algo (name, params, instrs)) ->
    "\n" ^ render_algo env name params instrs ^ "\n\n"

let render_prose env prose = List.map (render_def env) prose |> String.concat ""
