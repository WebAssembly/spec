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


let string_name_of_atom atom =
  match atom.it with
  | Atom id -> id
  | Infinity -> "infinity"
  | Bot -> "bot"
  | Top -> "top"
  | Dot -> "dot"
  | Dot2 -> "dotdot"
  | Dot3 -> "dotdotdot"
  | Semicolon -> "semicolon"
  | Backslash -> "backslash"
  | In -> "in"
  | Arrow -> "arrow"
  | Arrow2 -> "darrow"
  | ArrowSub -> "arrowsub"
  | Arrow2Sub -> "darrowsub"
  | Colon -> "colon"
  | Sub -> "sub"
  | Sup -> "sup"
  | Assign -> "assign"
  | Equal -> "eq"
  | Equiv -> "equiv"
  | Approx -> "approx"
  | SqArrow -> "sqarrow"
  | SqArrowStar -> "sqarrowstar"
  | Prec -> "prec"
  | Succ -> "succ"
  | Tilesturn -> "dashv"
  | Turnstile -> "vdash"
  | Quest -> "quest"
  | Plus -> "plus"
  | Star -> "ast"
  | Comma -> "comma"
  | Comp -> "comp"
  | Bar -> "bar"
  | BigComp -> "bigcomp"
  | BigAnd -> "bigand"
  | BigOr -> "bigor"
  | LParen -> "lparen"
  | LBrack -> "lbrack"
  | LBrace -> "lbrace"
  | RParen -> "rparen"
  | RBrack -> "rbrack"
  | RBrace -> "rbrace"

let string_name_of_mixop mixop =
  String.concat "" (List.map string_name_of_atom mixop)
