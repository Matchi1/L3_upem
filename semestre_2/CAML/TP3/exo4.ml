open List;;
open Random;;
exception Empty_list;;
let f_split l =
    if l = []
    then raise Empty_list
    else
        let rec f_split_aux l1 l2 index =
            if index = 0
            then rev (rev l1), rev l2
            else f_split_aux (tl l1) (cons (hd l1) l2) (index - 1)
        in f_split_aux l [] ((length l) / 2);;

let f_merge l1 l2 =
    let rec f_merge_aux l1 l2 result =
        if l1 = [] && l2 = []
        then rev result
        else if l1 = []
        then f_merge_aux l1 (tl l2) ((hd l2)::result)
        else if l2 = []
        then f_merge_aux (tl l1) l2 ((hd l1)::result)
        else if (hd l1) < (hd l2)
        then f_merge_aux (tl l1) l2 ((hd l1)::result)
        else f_merge_aux l1 (tl l2) ((hd l2)::result)
    in f_merge_aux l1 l2 [];;


let rec fusion_sort l =
    if length l < 2 
    then l
    else
        let l1, l2 = f_split l
        in let l1, l2 = (fusion_sort l1), (fusion_sort l2)
        in f_merge l1 l2;;

let l = random_list 20 100;;

let l1, l2 = f_split l;;

let l1, l2 = (List.sort compare l1), (List.sort compare l2);;

f_merge l1 l2;;

fusion_sort l;;

let q_split l =
    let rec q_split_aux l pivot l1 l2 l3 =
        if l = []
        then (rev l1), (rev l2), (rev l3)
        else if (hd l) < pivot
        then q_split_aux (tl l) pivot ((hd l)::l1) l2 l3
        else if (hd l) = pivot
        then q_split_aux (tl l) pivot l1 ((hd l)::l2) l3
        else q_split_aux (tl l) pivot l1 l2 ((hd l)::l3)
    in q_split_aux (tl l) (hd l) [] [hd l] [];;

let rec quick_sort l =
    if length l < 2
    then l
    else
        let l1, l2, l3 = q_split l
        in let l1, l3 = (quick_sort l1), (quick_sort l3)
        in q_merge l1 l2 l3;;

let l1, l2, l3 = q_split l;;

let l1, l2, l3 = (List.sort compare l1), l2, (List.sort compare l3);;

let q_merge l1 l2 l3 =
    let l = append l1 l2
    in append l l3;;

q_merge l1 l2 l3;;

quick_sort l;;
