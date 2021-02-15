(* EXERCICE 6 *)
let rec is_even n =
    if n = 0 then true
    else
        is_odd (n - 1)
    and is_odd n =
        if n != 0 && is_even (n - 1) then true else false;;
is_even;;
is_odd;;
is_even 0, is_even 1, is_even 2, is_even 3, is_even 4, is_even 5;;
is_odd 0, is_odd 1, is_odd 2, is_odd 3, is_odd 4, is_odd 5;;
