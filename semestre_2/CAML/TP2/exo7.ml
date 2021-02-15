(* EXERCICE 7 *)
let rec fact_aux n result =
    if n <= 1 then result
    else
        fact_aux (n - 1)(n * result);;

let fact' n =
    fact_aux n 1;;

fact, fact';;
fact 0 = fact' 0, fact 1 = fact' 1, fact 2 = fact' 2, fact 10 = fact' 10;;
