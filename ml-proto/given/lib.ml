module Fun =
struct
  let rec repeat n f x =
    if n = 0 then () else (f x; repeat (n - 1) f x)
end

module List =
struct
  let rec make n x =
    if n = 0 then [] else x :: make (n - 1) x

  let rec table n f = table' 0 n f
  and table' i n f =
    if i = n then [] else f i :: table' (i + 1) n f

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

  let length32 xs = Int32.of_int (List.length xs)
  let rec nth32 xs n =
    match n, xs with
    | 0l, x::xs -> x
    | n, x::xs' when n > 0l -> nth32 xs' (Int32.sub n 1l)
    | _ -> failwith "nth32"

  let rec last = function
    | x::[] -> x
    | _::xs -> last xs
    | [] -> failwith "last"

  let rec split_last = function
    | x::[] -> [], x
    | x::xs -> let ys, y = split_last xs in x::ys, y
    | [] -> failwith "split_last"

  let rec index_of x xs = index_of' x xs 0
  and index_of' x xs i =
    match xs with
    | [] -> None
    | y::xs' when x = y -> Some i
    | y::xs' -> index_of' x xs' (i+1)
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

module String =
struct
  let breakup s n =
    let rec loop i =
      let len = min n (String.length s - i) in
      if len = 0 then [] else String.sub s i len :: loop (i + len)
    in loop 0
end
