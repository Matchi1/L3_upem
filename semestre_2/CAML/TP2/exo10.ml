(* EXERCICE 10 *)
let rec exp x n =
    if n = 1 then x
    else
        x * exp x (n - 1);;

let rec exp_aux x n result =
    if n = 0 then result
    else
        exp_aux x (n - 1)(x * result);;

let exp' x n =
    exp_aux x n 1;;

let rec fast_exp x n =
    if n = 1 
    then 
        x
    else
        if n mod 2 = 0
        then
            let var = fast_exp x (n / 2)
            in var * var
        else
            let var = fast_exp x ((n - 1) / 2)
            in var * var * x;;

exp;;
exp';;
fast_exp;;

exp 2 10;;
exp' 2 10;;
fast_exp 2 10;;
