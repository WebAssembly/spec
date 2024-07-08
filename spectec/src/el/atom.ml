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
  | Backslash                    (* `\` *)
  | Mem                          (* `<-` *)
  | Arrow                        (* `->` *)
  | Arrow2                       (* ``=>` *)
  | ArrowSub                     (* `->_` *)
  | Arrow2Sub                    (* ``=>_` *)
  | Colon                        (* `:` *)
  | Sub                          (* `<:` *)
  | Sup                          (* `:>` *)
  | Assign                       (* `:=` *)
  | Equal                        (* ``=` *)
  | Equiv                        (* `==` *)
  | Approx                       (* `~~` *)
  | SqArrow                      (* `~>` *)
  | SqArrowStar                  (* `~>*` *)
  | Prec                         (* `<<` *)
  | Succ                         (* `>>` *)
  | Turnstile                    (* `|-` *)
  | Tilesturn                    (* `-|` *)
  | Quest                        (* ``?` *)
  | Plus                         (* ``+` *)
  | Star                         (* ``*` *)
  | Comma                        (* ``,` *)
  | Cat                          (* ``++` *)
  | Bar                          (* ``|` *)
  | LParen | RParen              (* ``(` `)` *)
  | LBrack | RBrack              (* ``[` `]` *)
  | LBrace | RBrace              (* ``{` `}` *)


let eq atom1 atom2 =
  atom1.it = atom2.it

let compare atom1 atom2 =
  compare atom1.it atom2.it

let sub atom1 atom2 =
  match atom1.it, atom2.it with
  | ArrowSub, Arrow
  | Arrow2Sub, Arrow2 -> true
  | _, _ -> false


let to_string atom =
  match atom.it with
  | Atom id -> id
  | Infinity -> "infinity"
  | Bot -> "_|_"
  | Top -> "^|^"
  | Dot -> "."
  | Dot2 -> ".."
  | Dot3 -> "..."
  | Semicolon -> ";"
  | Backslash -> "\\"
  | Mem -> "<-"
  | Arrow -> "->"
  | Arrow2 -> "=>"
  | ArrowSub -> "->_"
  | Arrow2Sub -> "=>_"
  | Colon -> ":"
  | Sub -> "<:"
  | Sup -> ":>"
  | Assign -> ":="
  | Equal -> "="
  | Equiv -> "=="
  | Approx -> "~~"
  | SqArrow -> "~>"
  | SqArrowStar -> "~>*"
  | Prec -> "<<"
  | Succ -> ">>"
  | Tilesturn -> "-|"
  | Turnstile -> "|-"
  | Quest -> "?"
  | Plus -> "+"
  | Star -> "*"
  | Comma -> ","
  | Cat -> "++"
  | Bar -> "|"
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
  | Backslash -> "setminus"
  | Mem -> "in"
  | Arrow -> "arrow"              (* Latex: \rightarrow *)
  | Arrow2 -> "darrow"            (* Latex: \Rightarrow *)
  | ArrowSub -> "arrowsub"        (* Latex: \rightarrow with subscript *)
  | Arrow2Sub -> "darrowsub"      (* Latex: \Rightarrow with subscript *)
  | Colon -> "colon"              (* Latex: : *)
  | Sub -> "sub"                  (* Latex: \leq or <: *)
  | Sup -> "sup"                  (* Latex: \geq or :> *)
  | Assign -> "assign"            (* Latex: := *)
  | Equal -> "eq"
  | Equiv -> "equiv"
  | Approx -> "approx"
  | SqArrow -> "sqarrow"          (* Latex: \hookrightarrow *)
  | SqArrowStar -> "sqarrowstar"  (* Latex: \hookrightarrow^\ast *)
  | Prec -> "prec"
  | Succ -> "succ"
  | Tilesturn -> "dashv"
  | Turnstile -> "vdash"
  | Quest -> "quest"              (* Latex: ? *)
  | Plus -> "plus"                (* Latex: + *)
  | Star -> "ast"
  | Comma -> "comma"              (* Latex: , *)
  | Cat -> "cat"                  (* Latex: \oplus *)
  | Bar -> "bar"                  (* Latex: | *)
  | LParen -> "lparen"            (* Latex: brackets... *)
  | LBrack -> "lbrack"
  | LBrace -> "lbrace"
  | RParen -> "rparen"
  | RBrack -> "rbrack"
  | RBrace -> "rbrace"
