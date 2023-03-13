(* Implementation based on:
 *  Robert Tarjan
 *  "Depth-first search and linear graph algorithms"
 *  SIAM Journal on Computing, 1(2), 1972
 *)


module LabelMap = Map.Make(String)
module IntSet = Set.Make(Int)


(* Graph Representation *)

type 'a vert =
  { mutable id : int;
    label : string;
    succs : int array;  (* id of successor, or negative when within own SCC *)
    content : 'a;
  }

type 'a graph = 'a vert array

let dummy_vert x =
  { id = -1;
    label = "";
    succs = [||];
    content = x;
  }


(* Debugging Aid *)

let assert_valid_vert maxid maxvert vert =
  assert (vert.id < maxid);
  Array.iter (fun id ->
    if id >= 0 then assert (id < maxid)
    else assert (-id-1 < maxvert)
  ) vert.succs;
  true

let assert_valid_graph maxid verts =
  Array.for_all (fun vert ->
    assert_valid_vert maxid (Array.length verts) vert
  ) verts


let print_graph graph =
  Array.iteri (fun v vert ->
    Printf.printf " %d = %s(" v vert.label;
    Array.iteri (fun j id ->
      if j > 0 then Printf.printf ", ";
      if id < 0
      then Printf.printf "%d" (-id-1)
      else Printf.printf "#%d" id;
    ) vert.succs;
    Printf.printf ")\n%!"
  ) graph


(* SCC *)

type vert_info =
  { mutable index : int;
    mutable low : int;
    mutable onstack : bool;
  }

let sccs (graph : 'a graph) : IntSet.t list =
  let len = Array.length graph in
  if len = 0 then [] else

  let info = Array.init len (fun _ -> {index = -1; low = -1; onstack = false}) in
  let stack = Array.make len (-1) in
  let stack_top = ref 0 in
  let index = ref 0 in
  let sccs = ref [] in

  let rec connect x =
    stack.(!stack_top) <- x;
    incr stack_top;
    let v = info.(x) in
    v.onstack <- true;
    v.index <- !index;
    v.low <- !index;
    incr index;
    visit v graph.(x);
    if v.low = v.index then sccs := scc x IntSet.empty :: !sccs

  and scc x ys =
    decr stack_top;
    let y = stack.(!stack_top) in
    info.(y).onstack <- false;
    let ys' = IntSet.add y ys in
    if x = y then ys' else scc x ys'

  and visit v vert =
    let succs = vert.succs in
    for i = 0 to Array.length succs - 1 do
      let x = succs.(i) in
      let w = info.(x) in
      if w.index = -1 then begin
        connect x;
        v.low <- min v.low w.low
      end else if w.onstack then
        v.low <- min v.low w.index
    done
  in

  for x = 0 to len - 1 do
    if info.(x).index = -1 then connect x
  done;
  List.rev !sccs
