open Ast
open Source

module Set = Free.Set
module Map = Scc.LabelMap

let sccs_of_syntaxes (script : script) : id list list =
  let syndefs =
    List.filter_map (fun def ->
      match def.it with
      | SynD (id, deftyp, _) -> Some (id, deftyp)
      | _ -> None
    ) script |> Array.of_list
  in
  let map = ref Map.empty in
  for i = 0 to Array.length syndefs - 1 do
    let id, _ = syndefs.(i) in
    map := Map.add id.it i !map
  done;
  let graph =
    Array.mapi (fun i (id, deftyp) ->
      let free = Array.of_seq (Set.to_seq (Free.free_deftyp deftyp)) in
      Scc.{
        id = i;
        label = id.it;
        content = deftyp;
        succs = Array.map (fun id -> Map.find id !map) free;
      }
    ) syndefs
  in
  let sccs = Scc.sccs graph in
  List.map (fun set ->
    List.map (fun i -> fst syndefs.(i)) (Scc.IntSet.elements set)
  ) sccs


let sccs_of_relations (script : script) : id list list =
  let reldefs =
    List.filter_map (fun def ->
      match def.it with
      | RelD (id, _, _) -> Some id
      | _ -> None
    ) script |> Array.of_list
  in
  let map = ref Map.empty in
  for i = 0 to Array.length reldefs - 1 do
    map := Map.add reldefs.(i).it i !map
  done;
  let rules = Array.map (Fun.const []) reldefs in
  List.iter (fun def ->
    match def.it with
    | RuleD (id, _, _, _) ->
      let i = Map.find id.it !map in
      rules.(i) <- def :: rules.(i)
    | _ -> ()
  ) script;
  let graph =
    Array.mapi (fun i id ->
      let frees = List.fold_left Set.union Set.empty
        (List.map Free.free_relid_def rules.(i)) in
      let free = Array.of_seq (Set.to_seq frees) in
      Scc.{
        id = i;
        label = id.it;
        content = ();
        succs = Array.map (fun id -> Map.find id !map) free;
      }
    ) reldefs
  in
  let sccs = Scc.sccs graph in
  List.map (fun set ->
    List.map (fun i -> reldefs.(i)) (Scc.IntSet.elements set)
  ) sccs
