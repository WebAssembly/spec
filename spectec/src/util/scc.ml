(* Implementation based on:
 *  Robert Tarjan
 *  "Depth-first search and linear graph algorithms"
 *  SIAM Journal on Computing, 1(2), 1972
 *)

(* Graph Representation *)

type vert = int array
type graph = vert array

module Set = Set.Make(Int)


(* SCC *)

type vert_info =
  { mutable index : int;
    mutable low : int;
    mutable onstack : bool;
  }

let sccs (graph : graph) : Set.t list =
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
    if v.low = v.index then sccs := scc x Set.empty :: !sccs

  and scc x ys =
    decr stack_top;
    let y = stack.(!stack_top) in
    info.(y).onstack <- false;
    let ys' = Set.add y ys in
    if x = y then ys' else scc x ys'

  and visit v vert =
    let succs = vert in
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
