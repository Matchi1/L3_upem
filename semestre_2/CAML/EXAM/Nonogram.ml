open List;;
(**********************************************************************)
(***************************** Exercise 1 *****************************)
(**********************************************************************)

(* 1.1. *)
(* val interval : int -> int -> int list = <fun> *)
let interval a b =
    if a > b 
    then [] 
    else 
        if a = b
        then [a]
        else
            let len = b - a + 1
            in List.init len (fun value -> value + a);;

interval 0 8;;
interval 2 5;;
interval 3 3;;
interval (-5) 2;;
interval 9 3;;

(* 1.2. *)
(* val interval_f : int -> int -> (int -> 'a) -> 'a list = <fun> *)
let interval_f a b f =
    let l = interval a b
    in rev (fold_left (fun acc value -> (f value) :: acc) [] l);;

interval_f 2 8 (fun x -> 2 * x);;
interval_f (-3) 3 (fun x -> -x);;
interval_f 1 5 (fun _ -> 9);;

(* 1.3. *)
(* val is_positive_list : int list -> bool = <fun> *)
let is_positive_list l =
    let value_positive acc value =
        if acc == true
        then if value > 0 then true else false
        else false
    in fold_left value_positive true l;;

is_positive_list [3; 1; 1; 2];;
is_positive_list [3; 1; 1; 0; 2];;
is_positive_list [3; (-1); 1; 1; 2];;
  

(* 1.4. *)
(* val is_sum_leq_list : int list -> int -> bool = <fun> *)
let is_sum_leq_list l k =
    let sum = fold_left (fun a b -> a + b) 0 l
    in if sum <= k then true else false;;

is_sum_leq_list [0; 1; 2] 25;;
is_sum_leq_list [0; 1; 2] 3;;
is_sum_leq_list [0; 1; 2] 2;;
is_sum_leq_list [] 0;;
is_sum_leq_list [] (-1);;

(* 1.5. *)
(* val are_equivalent_lists : 'a list -> 'b list -> ('a -> 'b -> bool)
        -> bool = <fun> *)
let are_equivalent_lists l1 l2 f =
    if length l1 <> length l2
    then false
    else for_all2 f l1 l2;;

are_equivalent_lists [1; 2; 3] [1; 2; 3] (=);;
are_equivalent_lists [0; 0; 1; 0] [0; 1; 9; 1] (<=);;
are_equivalent_lists [['a']; ['b'; 'b']] [[1]; [2; 3]]
(fun x y -> (List.length x) = (List.length y));;
are_equivalent_lists [0; 0; 1] [1; 0; 0; 0] (fun x y -> x + y >= 0);;
  

(* 1.6 *)
(* val cartesian_product_lists : 'a list -> 'b list -> ('a * 'b) list
        = <fun> *)

let cartesian_product_lists l1 l2 =
    let rec aux l1 l2 acc =
        if l1 = [] then acc
        else 
            let l = (fold_left (fun a b -> (hd l1, b) :: a) [] l2)
            in aux (tl l1) l2 (acc @ l)
    in aux l1 l2 [];;

cartesian_product_lists [1; 2] [3; 4; 5];;
cartesian_product_lists [1; 2; 3] [4; 5];;
cartesian_product_lists [1; 2] [];;
cartesian_product_lists [] [];;


(**********************************************************************)
(***************************** Exercise 2 *****************************)
(**********************************************************************)

(* Given type. *)
type state = Empty | Black

(* Given type. *)
type square = int * int

(* Given type. *)
type grid = {
    nb_rows : int;
    nb_columns : int;
    states : square -> state
}

(* Given function. *)
let state_to_string c =
    match c with
        |Empty -> "-"
        |Black -> "O"

(* Given function. *)
let grid_to_string grid =
    let index_rows = interval 1 grid.nb_rows
    and index_columns = interval 1 grid.nb_columns in
    List.fold_left
        (fun res i ->
            let line = List.fold_left
                (fun res j ->
                    res ^ (state_to_string (grid.states (i, j))) ^ "|")
                "|"
                index_columns
            in
            res ^ line ^ "\n")
        ""
        index_rows

(* 2.1. *)
(* val empty_grid : int -> int -> grid = <fun> *)

let empty_grid x y =
    {nb_rows = x; nb_columns = y; states = (fun square -> Empty)};;

empty_grid 5 3;;
print_string (grid_to_string (empty_grid 5 3));;

(* 2.2 *)
(* val fill_square : grid -> square -> grid = <fun> *)

let fill_square g s = {
        nb_rows = g.nb_rows;
        nb_columns = g.nb_columns;
        states = (fun square -> if square = s then Black else (g.states square))
    };;

let g = empty_grid 5 3;;
let g = fill_square g (1, 1);;
print_string (grid_to_string g);;
let g = fill_square g (5, 3);;
print_string (grid_to_string g);;

(* 2.3. *)
(* val fill_squares : grid -> square list -> grid = <fun> *)
let fill_squares g l =
    fold_left (fun acc value -> fill_square acc value) g l;;

print_string (grid_to_string (fill_squares (empty_grid 4 3) []));;
print_string (grid_to_string (fill_squares (empty_grid 4 3) [(1, 2); (1, 3); (4, 3)]));;
        

(* 2.4. *)
(* val row : grid -> int -> state list = <fun> *)

(* 2.5. *)
(* val column : grid -> int -> state list = <fun> *)

(**********************************************************************)
(***************************** Exercise 3 *****************************)
(**********************************************************************)

(* Given type. *)
type profile = int list

(* 3.1. *)
(* val profile : state list -> profile = <fun> *)

(* 3.2. *)
(* val are_profiles_compatible : profile -> profile -> bool = <fun> *)

(**********************************************************************)
(***************************** Exercise 4 *****************************)
(**********************************************************************)

(* Given type. *)
type spec = {
    rows : profile list;
    columns : profile list
}

(* 4.1. *)
(* val dimensions_spec : spec -> int * int = <fun> *)

(* 4.2. *)
(* val is_solution : spec -> grid -> bool = <fun> *)

(**********************************************************************)
(***************************** Exercise 5 *****************************)
(**********************************************************************)

(* 5.1. *)
(* val next_square : grid -> square -> square = <fun> *)

(* 5.2. *)
(* val is_square : grid -> square -> bool = <fun> *)

(* 5.3. *)
(* val solve_brute_force : spec -> bool * grid = <fun> *)

