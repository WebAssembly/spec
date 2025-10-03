type void = |

module Fun =
struct
  let id x = x
  let flip f x y = f y x
  let curry f x y = f (x, y)
  let uncurry f (x, y) = f x y

  let rec repeat n f x =
    if n = 0 then x else repeat (n - 1) f (f x)
end

module Char =
struct
  let is_digit_ascii c = '0' <= c && c <= '9'
  let is_uppercase_ascii c = 'A' <= c && c <= 'Z'
  let is_lowercase_ascii c = 'a' <= c && c <= 'z'
  let is_letter_ascii c = is_uppercase_ascii c || is_lowercase_ascii c
  let is_alphanum_ascii c = is_digit_ascii c || is_letter_ascii c
end

module String =
struct
  let implode cs =
    let buf = Buffer.create 80 in
    List.iter (Buffer.add_char buf) cs;
    Buffer.contents buf

  let explode s =
    let cs = ref [] in
    for i = String.length s - 1 downto 0 do cs := s.[i] :: !cs done;
    !cs

  let split s c =
    let len = String.length s in
    let rec loop i =
      if i > len then [] else
      let j = try String.index_from s i c with Not_found -> len in
      String.sub s i (j - i) :: loop (j + 1)
    in loop 0

  let breakup s n =
    let rec loop i =
      let len = min n (String.length s - i) in
      if len = 0 then [] else String.sub s i len :: loop (i + len)
    in loop 0

  let rec find_from_opt f s i =
    if i = String.length s then
      None
    else if f s.[i] then
      Some i
    else
      find_from_opt f s (i + 1)
end

module List =
struct
  let rec make n x = make' n x []
  and make' n x xs =
    if n = 0 then xs else make' (n - 1) x (x::xs)

  let rec take n xs =
    match n, xs with
    | 0, _ -> []
    | n, x::xs' when n > 0 -> x :: take (n - 1) xs'
    | _ -> failwith "take"

  let rec drop n xs =
    match n, xs with
    | 0, _ -> xs
    | n, _::xs' when n > 0 -> drop (n - 1) xs'
    | _ -> failwith "drop"

  let rec split n xs = split' n [] xs
  and split' n xs ys =
    match n, ys with
    | 0, _ -> List.rev xs, ys
    | n, y::ys' when n > 0 -> split' (n - 1) (y::xs) ys'
    | _ -> failwith "split"

  let rec lead = function
    | x::[] -> []
    | x::xs -> x :: lead xs
    | [] -> failwith "last"

  let rec last = function
    | x::[] -> x
    | _::xs -> last xs
    | [] -> failwith "last"

  let rec split_last = function
    | x::[] -> [], x
    | x::xs -> let ys, y = split_last xs in x::ys, y
    | [] -> failwith "split_last"

  let rec index_where p xs = index_where' p xs 0
  and index_where' p xs i =
    match xs with
    | [] -> None
    | x::xs' when p x -> Some i
    | x::xs' -> index_where' p xs' (i+1)

  let index_of x = index_where ((=) x)

  let rec map3 f xs ys zs =
    match xs, ys, zs with
    | [], [], [] -> []
    | x::xs', y::ys', z::zs' -> f x y z :: map3 f xs' ys' zs'
    | _ -> raise (Invalid_argument "Lib.List.map3")

  let rec map_pairwise f = function
    | [] -> []
    | x1::x2::xs -> f x1 x2 :: map_pairwise f xs
    | _ -> failwith "pairwise"
end

module List32 =
struct
  let rec init n f = init' n f []
  and init' n f xs =
    if n = 0l then xs else init' (Int32.sub n 1l) f (f (Int32.sub n 1l) :: xs)

  let rec make n x = make' n x []
  and make' n x xs =
    if n = 0l then xs else make' (Int32.sub n 1l) x (x::xs)

  let rec length xs = length' xs 0l
  and length' xs n =
    match xs with
    | [] -> n
    | _::xs' when n < Int32.max_int -> length' xs' (Int32.add n 1l)
    | _ -> failwith "length"

  let rec nth xs n =
    match n, xs with
    | 0l, x::_ -> x
    | n, _::xs' when n > 0l -> nth xs' (Int32.sub n 1l)
    | _ -> failwith "nth"

  let rec replace xs n y =
    match n, xs with
    | 0l, _::xs' -> y::xs'
    | n, x::xs' when n > 0l -> x :: replace xs' (Int32.sub n 1l) y
    | _ -> failwith "replace"

  let rec take n xs =
    match n, xs with
    | 0l, _ -> []
    | n, x::xs' when n > 0l -> x :: take (Int32.sub n 1l) xs'
    | _ -> failwith "take"

  let rec drop n xs =
    match n, xs with
    | 0l, _ -> xs
    | n, _::xs' when n > 0l -> drop (Int32.sub n 1l) xs'
    | _ -> failwith "drop"

  let rec iteri f xs = iteri' f 0l xs
  and iteri' f i = function
    | [] -> ()
    | x::xs -> f i x; iteri' f (Int32.add i 1l) xs

  let rec mapi f xs = mapi' f 0l xs
  and mapi' f i = function
    | [] -> []
    | x::xs -> f i x :: mapi' f (Int32.add i 1l) xs

  let rec index_where p xs = index_where' p xs 0l
  and index_where' p xs i =
    match xs with
    | [] -> None
    | x::xs' when p x -> Some i
    | x::xs' -> index_where' p xs' (Int32.add i 1l)

  let index_of x = index_where ((=) x)
end

module List64 =
struct
  let rec init n f = init' n f []
  and init' n f xs =
    if n = 0L then xs else init' (Int64.sub n 1L) f (f (Int64.sub n 1L) :: xs)

  let rec make n x = make' n x []
  and make' n x xs =
    if n = 0L then xs else make' (Int64.sub n 1L) x (x::xs)

  let rec length xs = length' xs 0L
  and length' xs n =
    match xs with
    | [] -> n
    | _::xs' when n < Int64.max_int -> length' xs' (Int64.add n 1L)
    | _ -> failwith "length"

  let rec nth xs n =
    match n, xs with
    | 0L, x::_ -> x
    | n, _::xs' when n > 0L -> nth xs' (Int64.sub n 1L)
    | _ -> failwith "nth"

  let rec take n xs =
    match n, xs with
    | 0L, _ -> []
    | n, x::xs' when n > 0L -> x :: take (Int64.sub n 1L) xs'
    | _ -> failwith "take"

  let rec drop n xs =
    match n, xs with
    | 0L, _ -> xs
    | n, _::xs' when n > 0L -> drop (Int64.sub n 1L) xs'
    | _ -> failwith "drop"

  let rec mapi f xs = mapi' f 0L xs
  and mapi' f i = function
    | [] -> []
    | x::xs -> f i x :: mapi' f (Int64.add i 1L) xs
end

module Array64 =
struct
  let make n x =
    if n < 0L || n > Int64.of_int max_int then
      invalid_arg "Array64.make";
    Array.make (Int64.to_int n) x

  let length a = Int64.of_int (Array.length a)

  let index_of_int64 i =
    if i < 0L || i > Int64.of_int max_int then -1 else
    Int64.to_int i

  let get a i = Array.get a (index_of_int64 i)
  let set a i x = Array.set a (index_of_int64 i) x
  let blit a1 i1 a2 i2 n =
    Array.blit a1 (index_of_int64 i1) a2 (index_of_int64 i2) (index_of_int64 n)
end

module Bigarray =
struct
  open Bigarray

  module Array1_64 =
  struct
    let create kind layout n =
      if n < 0L || n > Int64.of_int max_int then
        invalid_arg "Bigarray.Array1_64.create";
      Array1.create kind layout (Int64.to_int n)

    let dim a = Int64.of_int (Array1.dim a)

    let index_of_int64 i =
      if i < 0L || i > Int64.of_int max_int then -1 else
      Int64.to_int i

    let get a i = Array1.get a (index_of_int64 i)
    let set a i x = Array1.set a (index_of_int64 i) x
    let sub a i n = Array1.sub a (index_of_int64 i) (index_of_int64 n)
  end
end

module Option =
struct
  let get o x =
    match o with
    | Some y -> y
    | None -> x

  let force o =
    match o with
    | Some y -> y
    | None -> invalid_arg "Option.force"

  let map f = function
    | Some x -> Some (f x)
    | None -> None

  let app f = function
    | Some x -> f x
    | None -> ()
end

module Promise =
struct
  type 'a t = 'a option ref

  exception Promise

  let make () = ref None
  let fulfill p x = if !p = None then p := Some x else raise Promise
  let value_opt p = !p
  let value p = match !p with Some x -> x | None -> raise Promise
end

module Int =
struct
  let log2 n =
    if n <= 0 then failwith "log2";
    let rec loop acc n = if n = 1 then acc else loop (acc + 1) (n lsr 1) in
    loop 0 n

  let is_power_of_two n =
    if n < 0 then failwith "is_power_of_two";
    n <> 0 && n land (n - 1) = 0
end

module Int32 =
struct
  let log2 n =
    if n <= 0l then failwith "log2";
    let rec loop acc n =
      if n = 1l then acc else loop (Int32.add acc 1l) (Int32.shift_right_logical n 1) in
    loop 0l n

  let is_power_of_two n =
    if n < 0l then failwith "is_power_of_two";
    n <> 0l && Int32.(logand n (sub n 1l)) = 0l
end

module Int64 =
struct
  let log2_unsigned n =
    let rec loop acc n =
      if n = 1L then acc else loop (Int64.add acc 1L) (Int64.shift_right_logical n 1) in
    loop 0L n

  let log2 n =
    if n <= 0L then failwith "log2" else log2_unsigned n

  let is_power_of_two_unsigned n =
    n <> 0L && Int64.(logand n (sub n 1L)) = 0L

  let is_power_of_two n =
    if n < 0L then failwith "is_power_of_two" else is_power_of_two_unsigned n
end
