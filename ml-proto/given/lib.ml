(*
 * (c) 2014 Andreas Rossberg
 *)

module List =
struct
  let rec take n xs =
    match n, xs with
    | 0, _ -> []
    | n, x::xs' when n > 0 -> x :: take (n - 1) xs'
    | _ -> failwith "drop"

  let rec drop n xs =
    match n, xs with
    | 0, _ -> xs
    | n, _::xs' when n > 0 -> drop (n - 1) xs'
    | _ -> failwith "drop"

  let rec last = function
    | x::[] -> x
    | _::xs -> last xs
    | [] -> failwith "last"

  let rec split_last = function
    | x::[] -> [], x
    | x::xs -> let ys, y = split_last xs in x::ys, y
    | [] -> failwith "split_last"
end

module Option =
struct
  let get o x =
    match o with
    | Some y -> y
    | None -> x

  let map f = function
    | Some x -> Some (f x)
    | None -> None

  let app f = function
    | Some x -> f x
    | None -> ()
end

module Int =
struct
  let is_power_of_two x =
    if x < 0 then failwith "is_power_of_two";
    x <> 0 && (x land (x - 1)) = 0
end

module Int64 =
struct
  let is_power_of_two x =
    if x < 0L then failwith "is_power_of_two";
    x <> 0L && (Int64.logand x (Int64.sub x 1L)) = 0L
end
