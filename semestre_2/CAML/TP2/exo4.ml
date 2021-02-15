(* EXERCICE 4 *)
let rec ackermann m n =
    if m = 0 then n + 1
    else
        if m >= 1 && n = 0
        then 
            ackermann (m - 1) 1
        else
            ackermann (m - 1)(ackermann m (n - 1));;

ackermann;;
ackermann 0 1, ackermann 1 1, ackermann 2 1, ackermann 3 1;;
ackermann 0 2, ackermann 1 2, ackermann 2 2, ackermann 3 2;;
