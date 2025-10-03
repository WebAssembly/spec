open Source
open Ast
open Types

module Unknown = Error.Make ()
exception Unknown = Unknown.Error  (* indicates unknown import name *)

module Registry = Map.Make(struct type t = Ast.name let compare = compare end)
let registry = ref Registry.empty

let register name lookup = registry := Registry.add name lookup !registry

let lookup (ImportT (module_name, item_name, xt)) at : Instance.extern =
  try Registry.find module_name !registry item_name xt with Not_found ->
    Unknown.error at
      ("unknown import \"" ^ Types.string_of_name module_name ^
        "\".\"" ^ Types.string_of_name item_name ^ "\"")

let link m =
  let ModuleT (its, _) = moduletype_of m in
  List.map2 lookup its (List.map Source.at m.it.imports)
