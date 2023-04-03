open Il.Ast

let render_type_name (id : id) = String.capitalize_ascii id.it

let make_id = String.map (function
  | '.' -> '_'
  | c -> c
  )

let render_con_name id : atom -> string = function
  | Atom s ->
    (* Lets disambiguate always, to start with 
    if String.starts_with ~prefix:"_" s
    then render_type_name id ^ s
    else String.capitalize_ascii s
    *)
    if String.starts_with ~prefix:"_" s
    then render_type_name id ^ make_id s
    else render_type_name id ^ "_" ^ make_id s
  | a -> "{- render_con_name: TODO -} " ^ Il.Print.string_of_atom a 


let rec render_typ (ty : typ) = match ty.it with
  | VarT id -> render_type_name id
  | BoolT -> "Bool"
  | NatT -> "Natural"
  | TextT -> "String"
  | TupT tys -> render_tuple tys
  | IterT (ty, _) -> "[" ^ render_typ ty ^ "]"

and render_tuple tys = "(" ^ String.concat ", " (List.map render_typ tys) ^ ")"


let _unsupported_def d =
  "{- " ^
  Il.Print.string_of_def d ^
  "\n-}"

let rec prepend first rest = function
  | [] -> ""
  | (x::xs) -> first ^ x ^ prepend rest rest xs


let render_variant_inj id1 id2 =
  render_type_name id1 ^ "_of_" ^ render_type_name id2

let render_variant_inj_case id1 id2 =
  render_variant_inj id1 id2 ^ " " ^ render_type_name id2

let render_variant_case id (case : typcase) = match case with
  | (a, {it = TupT [];_}, _hints) -> render_con_name id a
  | (a, ty, _hints) -> render_con_name id a ^ " " ^ render_typ ty


let rec render_def (d : def) =
  "{- " (*  ^ Util.Source.string_of_region d.at ^ "\n"*)  ^
  Il.Print.string_of_def d ^
  "\n-}\n" ^
  match d.it with
  | SynD (id, deftyp, _hints) ->
    begin match deftyp.it with
    | AliasT ty ->
      "type " ^ render_type_name id ^ " = " ^ render_typ ty
    | NotationT (_op, ty) ->
      "type " ^ render_type_name id ^ " = " ^ render_typ ty
    | VariantT (ids, cases) ->
      "data " ^ render_type_name id ^ prepend "\n = " "\n | " (
        List.map (render_variant_inj_case id) ids @
        List.map (render_variant_case id) cases
      )
    | StructT fields ->
      "type " ^ render_type_name id ^ " = " ^ render_tuple (
        List.map (fun (_a, ty, _hints) -> ty) fields
      )
    end
  | RecD defs ->
    String.concat "\n" (List.map render_def defs)
  | _ -> ""

let render_script (el : script) =
  String.concat "\n" (List.map render_def el)

let gen_string (el : script) =
  "module Test where\n" ^
  "import Prelude (Bool, String)\n" ^
  "import Numeric.Natural (Natural)\n" ^
  render_script el


let gen_file file el =
  let haskell_code = gen_string el in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc haskell_code)
    ~finally:(fun () -> Out_channel.close oc)
