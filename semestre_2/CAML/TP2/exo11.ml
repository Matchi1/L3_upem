(* EXERCICE 11 *)

let rec sum1_aux n m =
    if n > m then 0
    else
        n + sum1_aux (n + 1) m;;

let rec sum1 n m =
    if n > m then 0
    else
        sum1 (n + 1) (m) + sum1_aux n m;;

let rec sum2_aux2 j k =
    if k >= j then 0.
    else
        float(k) /. float(j) +. sum2_aux2 j (k + 1);;

let rec sum2_aux n j =
    if j > n then 0.
    else
        sum2_aux n (j + 1) +. sum2_aux2 j 0;;

let rec sum2 n =
    sum2_aux n 0;;

sum1, sum2;;
sum1 1 3, sum1 0 10, sum1 5 10, sum1 5 3;;
sum2 0, sum2 3, sum2 5, sum2 10;;

