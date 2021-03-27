open List;;

type tree =
    | Leaf of int
    | Node of char * tree list;;

let example_tree =
    Node ('a',
    [Node ('b', [Leaf 1; Leaf 2; Leaf 3]);
        Node ('c', [Node ('d', [Leaf 4; Leaf 5]); Node ('e', [Leaf 6])]);
        Leaf 7;
        Node ('f', [Node ('g', [Leaf 8]); Leaf 9])]);;

let rec tree_count_nodes_aux l acc =
    if l = [] then acc
    else
        match (hd l) with
        | Node (_, sub_l) -> tree_count_nodes_aux (tl l) (tree_count_nodes_aux sub_l (acc + 1))
        | _ -> tree_count_nodes_aux (tl l) acc;;

let tree_count_nodes tree =
    match tree with
    | Node (_, l) -> tree_count_nodes_aux l 1
    | _ -> 0;;

tree_count_nodes example_tree;;

let rec tree_list_leaves_aux l acc =
    if l = [] then acc
    else
        match (hd l) with
        | Leaf x -> tree_list_leaves_aux (tl l) (x :: acc)
        | Node (_, sub_l) -> tree_list_leaves_aux (tl l) (tree_list_leaves_aux sub_l acc);;

let tree_list_leaves tree =
    match tree with
    | Node (_, l) -> List.rev (tree_list_leaves_aux l [])
    | Leaf x -> [x];;

tree_list_leaves example_tree;;
