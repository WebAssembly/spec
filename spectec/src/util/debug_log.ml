(* List of actively logged functions' labels *)
let active : string list ref = ref ["il.match";"il.reduce_exp";"il.reduce_prems"]

let fmt = Printf.sprintf
let loc = Source.string_of_region

let log_exn _exn =
  if !active <> [] then
    Printf.eprintf "\n%s\n%!" (Printexc.get_backtrace ())

let indent = ref 0
let indentation () = String.make (!indent*2) ' '

let log_at' (type a) label at (arg_f : unit -> string) (res_f : a -> string option) (f : unit -> a) : a =
  if not (label = "" || List.exists (fun s -> String.starts_with ~prefix: s label) !active) then f () else
  let ats = if at = Source.no_region then "" else " " ^ Source.string_of_region at in
  let arg = arg_f () in
  Printf.eprintf "%s[%s%s] %s\n%!" (indentation ()) label ats arg;
  incr indent;
  match f () with
  | exception exn ->
    decr indent;
    let bt = Printexc.get_raw_backtrace () in
    Printf.eprintf "%s[%s%s] %s => raise %s\n%!"
      (indentation ()) label ats arg (Printexc.to_string exn);
    Printexc.raise_with_backtrace exn bt
  | x ->
    decr indent;
    res_f x |> Option.iter (fun res ->
      Printf.eprintf "%s[%s%s] %s => %s\n%!" (indentation ()) label ats arg res);
    x

let log_at label at arg_f res_f = log_at' label at arg_f (fun x -> Some (res_f x))
let log_in_at label at arg_f = log_at' label at arg_f (Fun.const None) Fun.id
let log_in label = log_in_at label Source.no_region
let log label = log_at label Source.no_region
let log_if_at label at b arg_f res_f f = if b then log_at label at arg_f res_f f else f ()
let log_if label = log_if_at label Source.no_region

module MySet = Set.Make(String)
module MyMap = Map.Make(String)

let quote x = "`" ^ x ^ "`"
let pair f s g (x, y) = f x ^ s ^ g y
let opt f = function None -> "-" | Some x -> f x
let result f g = function Ok x -> f x | Error y -> g y
let seq f xs = String.concat " " (List.map f xs)
let list f xs = String.concat ", " (List.map f xs)
let set s = seq Fun.id (MySet.elements s)
let domain m = seq fst (MyMap.bindings m)
let mapping f m = seq (fun (x, y) -> x ^ "=" ^ f y) (MyMap.bindings m)

let qline _ = "--------------------"
let hline _ = "----------------------------------------"
let line  _ = "--------------------------------------------------------------------------------"
let dline _ = "================================================================================"
