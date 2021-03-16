open List;;
open Random;;

let sqr x = x * x;;
let my_list = [3; 12; 3; 40; 6; 4; 6; 0];;

let f_sum f a b =
    f a + f b;;

f_sum sqr 2 3;;
f_sum (fun x -> x + 1) 2 3;;

let new_f_sum f = 
    let curry1 a = 
        let curry b = f a + f b 
        in curry
    in curry1;;

new_f_sum sqr 2 3;;
new_f_sum (fun x -> x + 1) 2 3;;

new_f_sum sqr 2;;
(new_f_sum sqr 2) 3;;

let f1 a b = a + b;;
let f2 f = f 1 + 0;;
let f3 f = (fun a -> f (a + 1) + 0);;
let f4 f = f (fun a -> a + 1) + 1;; (* impossible *)
let f5 f = f (fun a -> a + 1) + 1;;

let l = map sqr my_list;;

let l = map (fun x -> 2 * x) my_list;;

let make_list make n =
    let rec make_list_aux n make acc =
        if n <= 0 then rev acc
        else make_list_aux (n - 1) make (make ():: acc)
    in make_list_aux n make [];;

let f () = 0;;
make_list f 8;;
make_list Random.bool 64;;
make_list (fun () -> Random.int 100) 16;;
