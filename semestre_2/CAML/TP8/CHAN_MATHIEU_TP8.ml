open List;;
(**********************************************************************)
(***************************** Exercice 1 *****************************)
(**********************************************************************)

(* 1.1. *)
(* val interval : int -> int -> int list = <fun> *)
let interval a b = 
    if a > b then []
    else
        let len = b - a + 1
        in List.init len (fun value -> value + a);;

(* 1.2. *)
(* val string_of_list : 'a list -> ('a -> string) -> string = <fun> *)
let string_of_list l f =
    fold_left (fun a b -> a ^ (f b)) "" l;;

(* 1.3. *)
(* val compose_iter : ('a -> 'a) -> 'a -> int -> 'a list = <fun> *)
let compose_iter f init len =
    let rec apply f value iter =
        if iter = 0 then value
        else f (apply f value (iter - 1))
    in
        List.rev (fold_left (fun a b -> (apply f b (List.length a)) :: a) [] (List.init len (fun a -> init)));;

(* 1.4. *)
(* val is_prefix_lists : 'a list -> 'a list -> bool = <fun> *)
let is_prefix_lists l1 l2 =
    let rec is_prefix l1 l2 =
        match l1, l2 with
        | [], [] -> true
        | [], _  -> true
        | _, []  -> false
        | _ -> 
                if (hd l1) <> (hd l2) then false
                else is_prefix (tl l1) (tl l2)
    in is_prefix l1 l2;;

(* 1.5. *)
(* val is_factor_lists : 'a list -> 'a list -> bool = <fun> *)
let rec is_factor_lists l1 l2 =
    let rec is_factor l1 l2 status =
        match l1, l2 with
        | [], [] -> true
        | [], _  -> true
        | _, []  -> false
        | _ -> 
                match status with
                | false -> 
                        if (hd l1) <> (hd l2) then is_factor l1 (tl l2) false
                        else is_factor l1 l2 true
                | _ -> 
                        if (hd l1) <> (hd l2) then false
                        else is_factor (tl l1) (tl l2) true
    in is_factor l1 l2 false;;


(* 1.6. *)
(* val is_subword_lists : 'a list -> 'a list -> bool = <fun> *)
let is_subword_lists l1 l2 =
    let rec aux l1 l2 =
        match l1, l2 with
        | [], [] -> true
        | [], _  -> true
        | _, []  -> false
        | _ -> 
                if (hd l1) <> (hd l2) then aux l1 (tl l2)
                else aux (tl l1) (tl l2)
    in aux l1 l2;;


(* 1.7. *)
(* val is_duplicate_free : 'a list -> bool = <fun> *)
let rec is_duplicate_free l =
    let rec exist l value =
        match l with
        | [] -> false
        | _ -> 
                fold_left (fun a b -> a || b = value) false l
    in
    match l with
    | [] -> true
    | _ -> 
            if exist (tl l) (hd l) then false
            else is_duplicate_free (tl l);;

(**********************************************************************)
(***************************** Exercice 2 *****************************)
(**********************************************************************)

type 'a automaton = {
    ribbon : int -> 'a;
    evol : 'a * 'a * 'a -> 'a;
    void : 'a
}

(* 2.1. *)
(* val create : ('a * 'a * 'a -> 'a) -> 'a -> 'a automaton = <fun> *)
let create f_tuple init =
    {ribbon = (fun a -> init); evol = f_tuple; void = init};;

(* 2.2. *)
(* val get_value : 'a automaton -> int -> 'a = <fun> *)
let get_value auto index =
    auto.ribbon index;;

(* 2.3. *)
(* val set_value : 'a automaton -> int -> 'a -> 'a automaton = <fun> *)
    
let set_value auto index value =
    {ribbon = (fun i -> if i = index then value else (auto.ribbon i)); evol = auto.evol; void = auto.void};;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut2 = set_value aut1 16 4;;
get_value aut2 15;;
get_value aut2 16;;
get_value aut1 16;;

(**********************************************************************)
(***************************** Exercice 3 *****************************)
(**********************************************************************)

type bunch = int * int

(* 3.1. *)
(* val get_bunch_values : 'a automaton -> bunch -> 'a list = <fun> *)
let get_bunch_values auto b =
    let portion = interval (fst b) (snd b)
    in 
        let rec aux auto portion acc =
            match portion with
            | [] -> rev acc
            | _ -> aux auto (tl portion) ((auto.ribbon (hd portion)) :: acc)
        in aux auto portion [];;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
get_bunch_values aut1 (-2, 6);;

(* 3.2. *)
(* val to_string : 'a automaton -> bunch -> ('a -> string) -> string
    = <fun> *)
let to_string auto b f_to_string =
    string_of_list (get_bunch_values auto b) f_to_string;;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
to_string aut1 (-2, 6) string_of_int;;
to_string aut1 (-2, 6) (fun x -> if x = 0 then "." else "*");;

(* 3.3. *)
(* val has_factor : 'a automaton -> bunch -> 'a list -> bool = <fun> *)

let has_factor auto b l =
    is_factor_lists l (get_bunch_values auto b);;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
let aut1 = set_value aut1 5 9;;
has_factor aut1 (1, 8) [4; 0; 9; 0];;
has_factor aut1 (1, 5) [4; 0; 9; 0];;


(* 3.4. *)
(* val has_subword : 'a automaton -> bunch -> 'a list -> bool = <fun> *)

let has_subword auto b l =
    is_subword_lists l (get_bunch_values auto b);;
let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
let aut1 = set_value aut1 5 9;;
has_subword aut1 (1, 8) [4; 9];;
has_subword aut1 (7, 8) [4; 9];;

(**********************************************************************)
(***************************** Exercice 4 *****************************)
(**********************************************************************)

(* 4.1. *)
(* val shift : 'a automaton -> int -> 'a automaton = <fun> *)
let rec shift auto k =
    {ribbon = (fun i -> auto.ribbon (i + k)); evol = auto.evol; void = auto.void};;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
to_string aut1 (-2, 6) string_of_int;;
let aut2 = shift aut1 3;;
to_string aut2 (-2, 6) string_of_int;;
let aut3 = shift aut1 (-4);;
to_string aut3 (-2, 6) string_of_int;;
to_string aut3 (-2, 12) string_of_int;;

(* 4.2. *)
(* val mirror : 'a automaton -> 'a automaton = <fun> *)

let rec mirror auto =
    {ribbon = (fun i -> auto.ribbon (-i)); evol = auto.evol; void = auto.void};;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
to_string aut1 (-8, 8) string_of_int;;
let aut2 = mirror aut1;;
to_string aut2 (-8, 8) string_of_int;;

(* 4.3. *)
(* val map : 'a automaton -> ('a -> 'a) -> 'a automaton = <fun> *)

let map auto f =
    {ribbon = (fun i -> f (auto.ribbon i)); evol = auto.evol; void = auto.void};;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 (-1) 2;;
to_string aut1 (-8, 8) string_of_int;;
let aut2 = map aut1 (fun x -> x + 1);;
to_string aut2 (-8, 8) string_of_int;;

(* 4.4. *)
(* val evolution : 'a automaton -> 'a automaton = <fun> *)

let evolution auto =
    {ribbon = (fun i -> auto.evol ((auto.ribbon (i - 1)), (auto.ribbon i), (auto.ribbon (i + 1)))); evol = auto.evol; void = auto.void};;

let aut1 = create (fun (a, b, c) -> a + b + c) 0;;
let aut1 = set_value aut1 3 4;;
let aut1 = set_value aut1 2 1;;
let aut1 = set_value aut1 (-1) 2;;
to_string aut1 (-8, 8) string_of_int;;
let aut2 = evolution aut1;;
to_string aut2 (-8, 8) string_of_int;;

(* 4.5. *)
(* val evolutions : 'a automaton -> int -> 'a automaton list = <fun> *)

let evolutions auto n =
    compose_iter (fun a -> evolution a) auto n;;

let aut = create (fun (a, b, c) -> a + b) 0;;
let aut = set_value aut 0 1;;
let lst = evolutions aut 4;;

(* 4.6. *)
(* val evolutions_bunch : 'a automaton -> bunch -> int -> 'a list list
    = <fun> *)

let evolutions_bunch auto b n =
    let rec aux auto b n acc =
        if n = 0 then rev acc
        else 
            let evolve =  evolution auto
            in aux evolve b (n - 1) ((get_bunch_values(evolve) b) :: acc) 
    in aux auto b n [get_bunch_values auto b];;

let aut = create (fun (a, b, c) -> a + b) 0;;
let aut = set_value aut 0 1;;
evolutions_bunch aut (-1, 5) 4;;

(* 4.7. *)
(* val is_resurgent : 'a automaton -> bunch -> int -> bool *)

let is_resurgent auto b n =
    not (is_duplicate_free (evolutions_bunch auto b n));;

let aut = create (fun (a, b, c) -> a + b) 0;;
let aut = set_value aut 0 1;;
is_resurgent aut (-1, -1) 4;;
is_resurgent aut (-1, 0) 4;;
is_resurgent aut (-1, 1) 4;;

(**********************************************************************)
(***************************** Exercice 5 *****************************)
(**********************************************************************)

(* 5.1. *)
(* val sierpinski : int automaton
    = {ribbon = <fun>; evol = <fun>; void = 0} *)

let sierpinski = {ribbon = (fun i -> 0); evol = (fun (a, b, c) -> (a + b + c) mod 2); void = 0};;
let aut = set_value sierpinski 0 1;;

print_string (String.concat "\n"
    (List.map
        (fun a -> to_string a (-8, 8) string_of_int)
        (evolutions aut 8)));;

(* 5.2. *)
(* Type wb. *)
(* val chaos : wb automaton
    = {ribbon = <fun>; evol = <fun>; void = White} *)

type wb = White | Black;;

let func (a, b, c) =
    match a, b, c with
    | Black, White, White -> Black
    | Black, _, _ -> White
    | White, White, White -> White
    | White, _, _ -> Black;;


let chaos = {ribbon = (fun i -> White); evol = func; void = White};;

let aut = set_value chaos 0 Black;;
print_string (String.concat "\n"
    (List.map
        (fun a -> to_string a (-8, 8)
        (fun x -> if x = Black then "*" else "."))
        (evolutions aut 8)));;

(**********************************************************************)
(***************************** Exercice 6 *****************************)
(**********************************************************************)

(* 6.1. *)
let aut = set_value sierpinski 0 1;;

let memo f =
    let m = ref [] in
    fun x ->
        try
            List.assoc x !m
        with
            Not_found ->
                let y = f x in
                m := (x, y) :: !m;
                y

(* 6.2. *)

let evolution auto =
    {ribbon = memo (fun i -> auto.evol ((auto.ribbon (i - 1)), (auto.ribbon i), (auto.ribbon (i + 1)))); evol = auto.evol; void = auto.void};;

let evolutions auto n =
    compose_iter (fun a -> (memo evolution) a) auto n;;

evolutions aut 16;;
print_string (String.concat "\n"
    (List.map
        (fun a -> to_string a (-8, 8) string_of_int)
        (evolutions aut 16)));;
