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
  | In                           (* `<-` *)
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
  | Comp                         (* ``++` *)
  | Bar                          (* ``|` *)
  | BigComp                      (* `(++)` *)
  | BigAnd                       (* `(/\)` *)
  | BigOr                        (* `(\/)` *)
  | LParen | RParen              (* ``(` `)` *)
  | LBrack | RBrack              (* ``[` `]` *)
  | LBrace | RBrace              (* ``{` `}` *)

type mixop = atom list list


let sub atom1 atom2 =
  match atom1.it, atom2.it with
  | ArrowSub, Arrow
  | Arrow2Sub, Arrow2 -> true
  | _, _ -> false


let string_of_atom atom =
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
  | In -> "in"
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
  | Comp -> "++"
  | Bar -> "|"
  | BigComp -> "(++)"
  | BigAnd -> "(/\\)"
  | BigOr -> "(\\/)"
  | LParen -> "("
  | LBrack -> "["
  | LBrace -> "{"
  | RParen -> ")"
  | RBrack -> "]"
  | RBrace -> "}"

let string_of_mixop = function
  | [{it = Atom a; _}]::tail when List.for_all ((=) []) tail -> a
  | mixop ->
    let s =
      String.concat "%" (List.map (
        fun atoms -> String.concat "" (List.map string_of_atom atoms)) mixop
      )
    in
    "`" ^ s ^ "`"


(* The following mostly correspond to Latex names except where noted;
 * where noted, a respective macro is expected to be defined *)

let name_of_atom atom =
  match atom.it with
  | Atom s -> s
  | Infinity -> "infty"
  | Bot -> "bot"
  | Top -> "top"
  | Dot -> "dot"                  (* Latex: . *)
  | Dot2 -> "dotdot"              (* Latex: .. *)
  | Dot3 -> "dots"
  | Semicolon -> "semicolon"      (* Latex: ; *)
  | Backslash -> "setminus"
  | In -> "in"
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
  | Comp -> "comp"                (* Latex: \oplus *)
  | Bar -> "bar"                  (* Latex: | *)
  | BigComp -> "bigcomp"          (* Latex: \bigoplus *)
  | BigAnd -> "bigand"
  | BigOr -> "bigor"
  | LParen -> "lparen"            (* Latex: brackets... *)
  | LBrack -> "lbrack"
  | LBrace -> "lbrace"
  | RParen -> "rparen"
  | RBrack -> "rbrack"
  | RBrace -> "rbrace"

let name_of_mixop mixop =
  String.concat "" (List.map name_of_atom mixop)
