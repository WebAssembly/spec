open Util.Source

type info = {mutable def : string; mutable case : string}

let info def = {def; case = ""}

type atom = (atom', info) note_phrase
and atom' =
  | Atom of string               (* atomid *)
  | Infinity                     (* infinity *)
  | Bot                          (* `_|_` *)
  | Top                          (* `^|^` *)
  | Dot                          (* `.` *)
  | Dot2                         (* `..` *)
  | Dot3                         (* `...` *)
  | Semicolon                    (* `;` *)
  | Slash                        (* ``/` *)
  | Backslash                    (* ``\` *)
  | Not                          (* ``~` *)
  | And                          (* ``/\` *)
  | Or                           (* ``\/` *)
  | Mem                          (* `<-` *)
  | NotMem                       (* `</-` *)
  | Arrow                        (* `->` *)
  | Arrow2                       (* ``=>` *)
  | ArrowSub                     (* `->_` *)
  | Arrow2Sub                    (* ``=>_` *)
  | Colon                        (* `:` *)
  | ColonSub                     (* `:_` *)
  | Sub                          (* `<:` *)
  | Sup                          (* `:>` *)
  | Assign                       (* `:=` *)
  | Equal                        (* ``=` *)
  | EqualSub                     (* ``=_` *)
  | NotEqual                     (* ``=/=` *)
  | Less                         (* ``<` *)
  | Greater                      (* ``>` *)
  | LessEqual                    (* ``<=` *)
  | GreaterEqual                 (* ``>=` *)
  | Equiv                        (* `==` *)
  | EquivSub                     (* `==_` *)
  | Approx                       (* `~~` *)
  | ApproxSub                    (* `~~_` *)
  | SqArrow                      (* `~>` *)
  | SqArrowSub                   (* `~>_` *)
  | SqArrowStar                  (* `~>*` *)
  | SqArrowStarSub               (* `~>*_` *)
  | Prec                         (* `<<` *)
  | Succ                         (* `>>` *)
  | Turnstile                    (* `|-` *)
  | TurnstileSub                 (* `|-_` *)
  | Tilesturn                    (* `-|` *)
  | TilesturnSub                 (* `-|_` *)
  | Quest                        (* ``^?` *)
  | Star                         (* ``^*` *)
  | Iter                         (* ``^+` *)
  | Plus                         (* ``+` *)
  | Minus                        (* ``-` *)
  | PlusMinus                    (* ``+-` *)
  | MinusPlus                    (* ``-+` *)
  | Times                        (* ``*` *)
  | Comma                        (* ``,` *)
  | Cat                          (* ``++` *)
  | Bar                          (* ``|` *)
  | BigAnd                       (* `(/\)` *)
  | BigOr                        (* `(\/)` *)
  | BigAdd                       (* `(+)` *)
  | BigMul                       (* `( * )` *)
  | BigCat                       (* `(++)` *)
  | LParen | RParen              (* ``(` `)` *)
  | LBrack | RBrack              (* ``[` `]` *)
  | LBrace | RBrace              (* ``{` `}` *)


let eq atom1 atom2 =
  atom1.it = atom2.it

let compare atom1 atom2 =
  compare atom1.it atom2.it

let is_sub atom =
  match atom.it with
  | Atom id -> id <> "" && id.[String.length id - 1] = '_'
  | ArrowSub | Arrow2Sub | ColonSub | EqualSub | EquivSub | ApproxSub
  | SqArrowSub | SqArrowStarSub | TurnstileSub | TilesturnSub -> true
  | _ -> false

let sub atom1 atom2 = 
  match atom1.it, atom2.it with
  | Atom id1, Atom id2 -> id1 = id2 ^ "_"
  | ArrowSub, Arrow
  | Arrow2Sub, Arrow2
  | ColonSub, Colon
  | EqualSub, Equal
  | EquivSub, Equiv
  | ApproxSub, Approx
  | SqArrowSub, SqArrow
  | SqArrowStarSub, SqArrowStar
  | TurnstileSub, Turnstile
  | TilesturnSub, Tilesturn -> true
  | _, _ -> false


let to_string atom =
  match atom.it with
  | Atom "_" -> "_"
  | Atom id -> id
  | Infinity -> "infinity"
  | Bot -> "_|_"
  | Top -> "^|^"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "..."
  | Semicolon -> ";"
  | Slash -> "/"
  | Backslash -> "\\"
  | Mem -> "<-"
  | NotMem -> "</-"
  | Arrow -> "->"
  | Arrow2 -> "=>"
  | ArrowSub -> "->_"
  | Arrow2Sub -> "=>_"
  | Colon -> ":"
  | ColonSub -> ":_"
  | Sub -> "<:"
  | Sup -> ":>"
  | Assign -> ":="
  | Equal -> "="
  | EqualSub -> "=_"
  | NotEqual -> "=/="
  | Less -> "<"
  | Greater -> ">"
  | LessEqual -> "<="
  | GreaterEqual -> ">="
  | Equiv -> "=="
  | EquivSub -> "==_"
  | Approx -> "~~"
  | ApproxSub -> "~~_"
  | SqArrow -> "~>"
  | SqArrowSub -> "~>_"
  | SqArrowStar -> "~>*"
  | SqArrowStarSub -> "~>*_"
  | Prec -> "<<"
  | Succ -> ">>"
  | Tilesturn -> "-|"
  | TilesturnSub -> "-|_"
  | Turnstile -> "|-"
  | TurnstileSub -> "|-_"
  | Quest -> "^?"
  | Star -> "^*"
  | Iter -> "^+"
  | Plus -> "+"
  | Minus -> "-"
  | PlusMinus -> "+-"
  | MinusPlus -> "-+"
  | Times -> "*"
  | Not -> "~"
  | And -> "/\\"
  | Or -> "\\/"
  | Comma -> ","
  | Cat -> "++"
  | Bar -> "|"
  | BigAnd -> "(/\\)"
  | BigOr -> "(\\/)"
  | BigAdd -> "(+)"
  | BigMul -> "(*)"
  | BigCat -> "(++)"
  | LParen -> "("
  | LBrack -> "["
  | LBrace -> "{"
  | RParen -> ")"
  | RBrack -> "]"
  | RBrace -> "}"


(* The following mostly correspond to Latex names except where noted;
 * where noted, a respective macro is expected to be defined *)

let name atom =
  match atom.it with
  | Atom s -> s
  | Infinity -> "infty"
  | Bot -> "bot"
  | Top -> "top"
  | Dot -> "dot"                  (* Latex: . *)
  | Dot2 -> "dotdot"              (* Latex: .. *)
  | Dot3 -> "dots"                (* Latex: \ldots *)
  | Semicolon -> "semicolon"      (* Latex: ; *)
  | Slash -> "slash"              (* Latex: / *)
  | Backslash -> "setminus"
  | Mem -> "in"
  | NotMem -> "notin"
  | Arrow -> "arrow"              (* Latex: \rightarrow *)
  | Arrow2 -> "darrow"            (* Latex: \Rightarrow *)
  | ArrowSub -> "arrow_"          (* Latex: \rightarrow with subscript *)
  | Arrow2Sub -> "darrow_"        (* Latex: \Rightarrow with subscript *)
  | Colon -> "colon"              (* Latex: : *)
  | ColonSub -> "colon_"          (* Latex: : with subscript *)
  | Sub -> "sub"                  (* Latex: \leq or <: *)
  | Sup -> "sup"                  (* Latex: \geq or :> *)
  | Assign -> "assign"            (* Latex: := *)
  | Equal -> "eq"
  | EqualSub -> "eq_"             (* Latex: \eq with subscript *)
  | NotEqual -> "neq"
  | Less -> "lt"                  (* Latex: < *)
  | Greater -> "gt"               (* Latex: > *)
  | LessEqual -> "leq"            (* Latex: \leq *)
  | GreaterEqual -> "geq"         (* Latex: \geq *)
  | Equiv -> "equiv"
  | EquivSub -> "equiv_"
  | Approx -> "approx"
  | ApproxSub -> "approx_"
  | SqArrow -> "sqarrow"          (* Latex: \hookrightarrow *)
  | SqArrowSub -> "sqarrow_"      (* Latex: \hookrightarrow with subscript *)
  | SqArrowStar -> "sqarrowstar"  (* Latex: \hookrightarrow^\ast *)
  | SqArrowStarSub -> "sqarrowstar_" (* Latex: \hookrightarrow^\ast with subscript *)
  | Prec -> "prec"
  | Succ -> "succ"
  | Tilesturn -> "dashv"
  | TilesturnSub -> "dashv_"      (* Latex: \dashv with subscript *)
  | Turnstile -> "vdash"
  | TurnstileSub -> "vdash_"      (* Latex: \vdash with subscript *)
  | Quest -> "quest"              (* Latex: ^? *)
  | Star -> "ast"                 (* Latex: ^\ast *)
  | Iter -> "iter"                (* Latex: ^+ *)
  | Plus -> "plus"                (* Latex: + *)
  | Minus -> "minus"              (* Latex: - *)
  | PlusMinus -> "plusminus"      (* Latex: \pm *)
  | MinusPlus -> "minusplus"      (* Latex: \mp *)
  | Times -> "times"
  | Not -> "not"                  (* Latex: neg *)
  | And -> "and"                  (* Latex: land *)
  | Or -> "or"                    (* Latex: lor *)
  | Comma -> "comma"              (* Latex: , *)
  | Cat -> "cat"                  (* Latex: \oplus *)
  | Bar -> "bar"                  (* Latex: | *)
  | BigAnd -> "bigand"            (* Latex: \bigwedge *)
  | BigOr -> "bigor"              (* Latex: \bigvee *)
  | BigAdd -> "bigadd"            (* Latex: \Sigma *)
  | BigMul -> "bigmul"            (* Latex: \Pi *)
  | BigCat -> "bigcat"            (* Latex: \bigoplus *)
  | LParen -> "lparen"            (* Latex: brackets... *)
  | LBrack -> "lbrack"
  | LBrace -> "lbrace"
  | RParen -> "rparen"
  | RBrack -> "rbrack"
  | RBrace -> "rbrace"
