open List;;
open Random;;

let list_copy l =
    let rec list_copy_aux l copy =
        if l = []
        then List.rev copy
        else list_copy_aux (tl l) (hd l :: copy)
    in list_copy_aux l [];;

list_copy [1; 2; 3];;

let random_list n max =
    let rec random_list_aux l n max =
        if n = 0
        then List.rev l
        else random_list_aux ((Random.int max) :: l) (n - 1) max
    in random_list_aux [] n max;;

let l = random_list 10 2;;

let reverse l =
    let rec reverse_aux l mirror =
        if l = []
        then mirror
        else reverse_aux (tl l) (hd l :: mirror)
    in reverse_aux l [];;

reverse l;;

let flatten_list l =
    let rec flatten_list_aux l flat =
        if l = []
        then flat
        else flatten_list_aux (tl l) (List.append flat (hd l))
    in flatten_list_aux l [];;

flatten_list [[1; 2]; []; [3; 4; 5]; [6]];;

let fibo n =
    let rec fibo_aux n l =
        if n = 0
        then List.rev l
        else fibo_aux (n - 1) ((hd l + nth l 1) :: l)
    in fibo_aux (n - 1) [1; 0];;

fibo 10;;

let rec is_in l number =
    if l = []
    then false
    else 
        if number = (hd l)
        then true
        else is_in (tl l) number;;

let without_duplicates l =
    let rec without_duplicates_aux l result =
        if l = []
        then rev result
        else
            if is_in (result) (hd l)
            then without_duplicates_aux (tl l) result
            else without_duplicates_aux (tl l) (hd l :: result)
    in without_duplicates_aux (tl l) [hd l];;

without_duplicates [0; 0;1; 2; 3; 3; 3; 3; 4; 5; 5; 6; 8; 8];;

let change l value =
    let rec change_aux l result flag value =
        if l = [] && flag = false 
        then (value, 1)::result
        else if l = [] && flag = true
        then result
        else if fst(hd l) = value
        then change_aux (tl l) ((value, snd(hd l) + 1)::result) true value
        else change_aux (tl l) ((hd l)::result) flag value
    in change_aux l [] false value;;
    

let frequences l =
    let rec frequences_aux l result =
        if l = []
        then rev result
        else frequences_aux (tl l) (change result (hd l))
    in frequences_aux l [];;

let l = random_list 10000 5;;
frequences l;;
