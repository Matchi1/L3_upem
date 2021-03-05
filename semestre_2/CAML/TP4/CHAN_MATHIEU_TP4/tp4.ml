open List;;

(* EXERCICE 1 *)

type bintree =
    Empty
    | Node of int * bintree * bintree;;

let b1 = Node (7, Empty, Empty);;
let b2 = Node (8, Empty, Empty);;
let b3 = Node (9, Empty, Empty);;
let b4 = Node (4, Empty, Empty);;
let b5 = Node (5, b1, b2);;
let b6 = Node (2, b4, b5);;
let b7 = Node (6, b3, Empty);;
let b8 = Node (3, Empty, b7);;
let example_tree = Node (1, b6, b8);;

(* EXERCICE 2 *)

let rec bintree_count_nodes tree =
    match tree with
    | Empty -> 0
    | Node (_, left, right) -> 1 + bintree_count_nodes left + bintree_count_nodes right;;

bintree_count_nodes;;

bintree_count_nodes example_tree;;

let rec bintree_count_leaves tree =
    match tree with
    | Empty -> 0
    | Node (_,  Empty, Empty) -> 1
    | Node (_, left, right) -> bintree_count_leaves left + bintree_count_leaves right;;

bintree_count_leaves;;

bintree_count_leaves example_tree;;

let rec bintree_count_internal_nodes tree =
    match tree with
    | Empty -> 0
    | Node (_, Empty, Empty) -> 0
    | Node (_, left, right) -> 1 + bintree_count_internal_nodes left + bintree_count_internal_nodes right;;

bintree_count_internal_nodes;;

bintree_count_internal_nodes example_tree;;

let rec bintree_count_right tree =
    match tree with
    | Empty -> 0
    | Node (_, left, Empty) -> bintree_count_right left
    | Node (_, left, right) -> 1 + bintree_count_right right + bintree_count_right left;;

bintree_count_right example_tree;;

let rec bintree_count_left tree =
    match tree with
    | Empty -> 0
    | Node (_, Empty, right) -> bintree_count_left right
    | Node (_, left, right) -> 1 + bintree_count_left left + bintree_count_left right;;

bintree_count_left example_tree;;

(* EXERCICE 3 *)

let bintree_height tree =
    match tree with
    | Empty -> -1
    | _ -> 
        let rec bintree_height_aux tree height =
            match tree with
            | Empty -> height
            | Node (_, left, right) -> max (bintree_height_aux left (1 + height)) (bintree_height_aux right (1 + height))
        in bintree_height_aux tree 0;;

bintree_height;;

bintree_height example_tree;;

let rec bintree_is_mirror tree1 tree2 =
    match tree1, tree2 with
    | Empty, Empty -> true
    | Empty, _ -> false
    | _, Empty -> false
    | Node (_, left1, right1), Node (_, left2, right2) ->  bintree_is_mirror left1 right2 && bintree_is_mirror right1 left2;;

bintree_is_mirror Empty Empty;;
bintree_is_mirror (Node(1, Empty, Empty)) (Node(2, Empty, Empty));;
bintree_is_mirror (Node(1, Empty, Node(3, Empty, Empty))) (Node(2, Node(4, Empty, Empty), Empty));;

let bintree_is_symmetric tree =
    match tree with
    | Empty -> true
    | Node (_, left, right) -> bintree_is_mirror left right;;

bintree_is_symmetric;;

bintree_is_symmetric Empty;;

bintree_is_symmetric (Node(1, Empty, Empty));;

bintree_is_symmetric (Node(1, Node(2, Empty, Empty), Node(2, Empty, Empty)));;

bintree_is_symmetric (Node(1, Node(2, Empty, Empty), Node(3, Empty, Empty)));;

bintree_is_symmetric (Node(1, Node(2, Empty, Empty), Empty));;

(* EXERCICE 4 *)

let rec bintree_collect_nodes tree =
    match tree with
    | Empty -> []
    | Node (value, left, right) -> append (append [value] (bintree_collect_nodes left)) (bintree_collect_nodes right);;

bintree_collect_nodes;;

bintree_collect_nodes example_tree;;

let rec bintree_collect_leaves tree =
    match tree with
    | Empty -> []
    | Node (value, Empty, Empty) -> [value]
    | Node (value, left, right) -> append (bintree_collect_leaves left) (bintree_collect_leaves right);;

bintree_collect_leaves;;

bintree_collect_leaves example_tree;;
    
let rec bintree_collect_internal_nodes tree =
    match tree with
    | Empty -> []
    | Node (_, Empty, Empty) -> []
    | Node (value, left, right) -> append (append [value] (bintree_collect_internal_nodes left)) (bintree_collect_internal_nodes right);;

bintree_collect_internal_nodes;;

bintree_collect_internal_nodes example_tree;;

let rec bintree_collect_level tree depth=
    match tree, depth with
    | Empty, _ -> []
    | Node (value, _, _), 1 -> [value]
    | Node (value, left, right), _ -> append (bintree_collect_level left (depth - 1)) (bintree_collect_level right (depth - 1));;

bintree_collect_level;;

bintree_collect_level example_tree 1;;
bintree_collect_level example_tree 2;;
bintree_collect_level example_tree 3;;
bintree_collect_level example_tree 4;;
bintree_collect_level example_tree 5;;

let bintree_collect_canopy tree =
    if tree = Empty
    then []
    else
        let rec bintree_collect_canopy_aux tree direction =
            match tree with
            | Empty -> []
            | Node (_, Empty, Empty) -> [direction]
            | Node (_, left, right) -> append (bintree_collect_canopy_aux left 0) (bintree_collect_canopy_aux right 1)
        in bintree_collect_canopy_aux tree 0;;

bintree_collect_canopy example_tree;;

let rec bintree_pre tree =
    match tree with
    | Empty -> []
    | Node (value, left, right) -> append (append [value] (bintree_pre left)) (bintree_pre right);;

bintree_pre;;

bintree_pre example_tree;;

let rec bintree_post tree =
    match tree with
    | Empty -> []
    | Node (value, left, right) -> append (append (bintree_post left) (bintree_post right)) [value];;

bintree_post;;

bintree_post example_tree;;

let rec bintree_in tree =
    match tree with
    | Empty -> []
    | Node (value, left, right) -> append (append (bintree_in left) [value]) (bintree_in right);;

bintree_in;;
bintree_in example_tree;;

(* EXERCICE 6 *)

let rec bintree_insert tree value =
    match tree with
    | Empty -> Node (value, Empty, Empty)
    | Node (v, left, right) -> 
            if v < value 
            then Node (v, left, bintree_insert right value) 
            else Node (v, bintree_insert left value, right);;

bintree_insert;;

bintree_insert Empty 1;;

bintree_insert (bintree_insert Empty 1) 2;;

bintree_insert (bintree_insert (bintree_insert Empty 1) 2) 3;;

bintree_insert (bintree_insert (bintree_insert Empty 1) 2) 0;;

let rec bintree_search tree value =
    match tree with
    | Empty -> false
    | Node (v, left, right) -> 
            if v = value then true
            else if v < value 
            then bintree_search right value
            else bintree_search left value;;

bintree_search;;

(* EXERCICE 7*)

let rec bintree_double tree =
    match tree with
    | Empty -> Empty
    | Node (v, left, right) -> Node (2*v, bintree_double left, bintree_double right);;

bintree_double;;

bintree_double example_tree;;

let rec bintree_apply tree fct =
    match tree with
    | Empty -> Empty
    | Node (v, left, right) -> Node (fct v, bintree_apply left fct, bintree_apply right fct);;

bintree_apply;;

bintree_apply example_tree (function x -> x + 1);;

let rec bintree_double tree =
    bintree_apply tree (function x -> 2*x);;

bintree_double;;

bintree_double example_tree;;

let rec bintree_rotate tree =
    match tree with
    | Empty -> Empty
    | Node (v, left, right) -> Node (v, bintree_rotate right, bintree_rotate left);;

bintree_rotate;;

bintree_rotate example_tree;;

let rec bintree_sum_subtree tree =
    let rec sum_subtree tree =
        match tree with 
        | Empty -> 0
        | Node (v, left, right) -> v + sum_subtree left + sum_subtree right
    in
        match tree with
        | Empty -> Empty
        | Node (v, left, right) -> Node (v + sum_subtree left + sum_subtree right, bintree_sum_subtree left, bintree_sum_subtree right);;

bintree_sum_subtree;;

bintree_sum_subtree example_tree;;
        
