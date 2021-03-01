open List;;
exception Empty_list;;

let three_or_more l =
    let rec three_or_more_aux l n =
        if n > 0 && l = []
        then false
        else 
            if n = 0 then true
            else three_or_more_aux (tl l) (n - 1)
    in three_or_more_aux l 3;;

three_or_more [], three_or_more [1; 1; 1; 1; 1];;

let size l =
    let rec size_aux l n =
        if l = []
        then n
        else size_aux (tl l) (n + 1)
    in size_aux l 0;;

size [], size [3; 1; 4; 5; 2];;

let last l =
    if l = []
    then raise Empty_list
    else
        hd (rev l);;

last [1], last [3; 1; 4; 5; 2];;

let is_increasing l =
    let rec is_increasing_aux l n =
        if l = []
        then true
        else
            if hd l < n
            then false
            else
                is_increasing_aux (tl l) (hd l)
    in is_increasing_aux l 0;;
is_increasing [], is_increasing [3; 1; 4; 5; 2], is_increasing [1; 3; 5; 5; 7];;

let even_odd l =
    let rec even_odd_aux l index =
        if l = [] then true
        else
            if index mod 2 <> hd l mod 2
            then false
            else even_odd_aux (tl l) (index + 1)
    in even_odd_aux l 1;;
even_odd [], even_odd [1; 4; 3; 6; 9; 2], even_odd [2; 3; 3];;

let rec find e l =
    if l = []
    then false
    else
        if hd l = e
        then true
        else find e (tl l);;
find 3 [], find 3 [1; 2; 3], find 3 [2; 4; 6];;

let rec member e l =
    if l = []
    then []
    else 
        if hd l = e
        then l
        else member e (tl l);;
member 3 [], member 3 [1; 2; 3; 4; 3; 5], member 3 [2; 4; 6];;

let member_last e l =
    let rec member_last_aux e l result =
        if l = [] then l
        else
            if hd l <> e
            then 
                member_last_aux e (tl l) (hd l :: result)
            else
                e :: result
    in member_last_aux e (rev l) [];;
member_last 3 [1; 2; 3; 4; 3; 5], member_last 3 [2; 4; 6];;

let nb_occ e l =
    let rec nb_occ_aux e l n =
        if l = [] then n
        else 
            if hd l = e
            then nb_occ_aux e (tl l) (n + 1)
            else nb_occ_aux e (tl l) n
    in nb_occ_aux e l 0;;
nb_occ 3 [], nb_occ 3 [1; 2; 3; 4; 3; 5], nb_occ 3 [2; 4; 6];;

let rec nth n l =
    if n = 1
    then hd l 
    else nth (n - 1) (tl l);;
nth 3 [1; 2; 3; 4; 3; 5], nth 3 [2; 4; 6];;

let max_list l =
    if l = []
    then raise Empty_list
    else 
        let rec max_list_aux l max =
            if l = []
            then max
            else if max < hd l
            then max_list_aux (tl l) (hd l) 
            else max_list_aux (tl l) max
        in max_list_aux l 0;;
max_list [1; 2; 3; 0; 3; 0], max_list [2; 4; 6];;

let average l =
    if l = []
    then 0.
    else
        let rec average_aux l sum n =
            if l = []
            then sum /. float(n)
            else average_aux (tl l) (sum +. hd l) (n + 1)
        in average_aux l 0. 0;;
average [5.; 8.5; 11.5; 15.];;
