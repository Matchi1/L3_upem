open List;;
(* point type definition *)
type point = float * float;;

(* Question 1 *)
(* float -> float -> point *)
(* make_point *)
let make_point (x:float) (y:float) = (x, y) ;;
make_point 1.5 2.;;

(* Question 2 *)
(* point -> float *)
(* point_x *)
let point_x (x, y) = x;;

(* point -> float *)
(* point_y *)
let point_y (x, y) = y;;

let p = make_point 1. 2.;;
point_x p;;
point_y p;;

(* Question 3 *)
(* point -> point -> bool *)
(* point_domination *)
let point_domination (x1, y1) (x2, y2) = x1 >= x2 && y1 >= y2;;

let p1 = make_point 0. 0. and p2 = make_point 0. 1. and p3 = make_point 1. 1.;;
point_domination p1 p1, point_domination p1 p2, point_domination p1 p3;;
point_domination p2 p1, point_domination p2 p2, point_domination p2 p3;;
point_domination p3 p1, point_domination p3 p2, point_domination p3 p3;;

(* -------------------------------------------------------------------------- *)

(* rectangle type definition *)
type rectangle = point * point;;

(* Question 4 *)
(* point -> point -> rectangle *)
(* make_rectangle *)

let make_rectangle (p1:point) (p2:point) = (p1, p2);;
let p1 = make_point 0. 0. and p2 = make_point 1. 2.;;
make_rectangle p1 p2;;

(* Question 5 *)
(* rectangle -> point *)
(* rectangle_lower_left *)

let rectangle_lower_left (p1, p2) = p1;;

(* rectangle -> point *)
(* rectangle_upper_right *)

let rectangle_upper_right (p1, p2) = p2;;
let r = make_rectangle (make_point 0. 0.) (make_point 1. 2.);;
rectangle_lower_left r;;
rectangle_upper_right r;;

(* Question 6 *)
(* rectangle -> float *)
(* rectangle_width *)

let rectangle_width (p1, p2) = (point_x p2) -. (point_x p1);;

(* rectangle -> float *)
(* rectangle_height *)

let rectangle_height (p1, p2) = (point_y p2) -. (point_y p1);;

let r = make_rectangle (make_point 0. 0.) (make_point 1. 2.);;
rectangle_width r;;
rectangle_height r;;

(* Question 7 *)
(* rectangle -> point -> bool *)
(* rectangle_contains_point *)

let rectangle_contains_point (p1, p2) p = 
    (point_domination p p1) && (point_domination p2 p);;

let r = make_rectangle (make_point 0. 0.) (make_point 1. 1.);;
let p1 = make_point 0. 0.
and p2 = make_point 0.5 0.5
and p3 = make_point 0.5 1.5;;
rectangle_contains_point r p1;;
rectangle_contains_point r p2;;
rectangle_contains_point r p3;;

(* Question 8 *)
(* rectangle -> point list -> point list *)
(* rectangle_contains_points *)

let rectangle_contains_points rect l =
    rev (fold_left (fun a b -> if rectangle_contains_point rect b then b :: a else a) [] l);;

let r = make_rectangle (make_point 0. 0.) (make_point 1. 1.);;
let p1= make_point 0. 0.
and p2 = make_point 0.5 0.5
and p3 = make_point 0.5 1.5;;
rectangle_contains_points r [p1; p2; p3];;

(* -------------------------------------------------------------------------- *)

(* quadtree type definition *)
type quadtree = | Leaf of point list * rectangle
                | Node of quadtree * quadtree * quadtree * quadtree * rectangle;;

(* Question 9 *)
(* rectangle -> rectangle * rectangle * rectangle * rectangle  *)
(* rectangle_split_four *)

let rectangle_split_four rect =
    match rect with
    | ((x1, y1), (x2, y2)) ->
            let x_center = (x1 +. x2) /. 2.
            and y_center = (y1 +. y2) /. 2.
            in
                ((x1, y1), (x_center, y_center)),
                ((x1, y_center), (x_center, y2)),
                ((x_center, y1), (x2, y_center)),
                ((x_center, y_center), (x2, y2));;

let r = make_rectangle (make_point 0. 0.) (make_point 1. 2.);;
rectangle_split_four r;;

(* Question 10 *)
(* ’a list -> ’a *)
(* smallest *)

let smallest l =
    fold_left min (hd l) l;;

(* ’a list -> ’a *)
(* largest *)

let largest l =
    fold_left max (hd l) l;;

let l = [2; 4; 6; 1; 8; 4; 3; 1];;
smallest l;;
largest l;;

(* Question 11 *)
(* point list -> rectangle *)
(* enclosing_rectangle *)

let enclosing_rectangle l =
    let l_x = fold_left (fun a b -> (point_x b) :: a) [] l
    and l_y = fold_left (fun a b -> (point_y b) :: a) [] l
    in ((smallest l_x, smallest l_y), (largest l_x, largest l_y));;
let p1 = make_point 0. 0. and p2 = make_point 0.5 0.5 and p3 = make_point 0.5 1.5;;
enclosing_rectangle [p1; p2; p3];;

(* Question 12 *)
(* point list -> int -> quadtree *)
(* quadtree_make *)

let quadtree_make l_point n =
    let rec aux l_point n rect =
        if (length l_point) <= n 
        then Leaf (l_point, rect)
        else 
            let (r1, r2, r3, r4) = rectangle_split_four rect
            in
                let (l1, l2, l3, l4) = 
                    (
                        rectangle_contains_points r1 l_point,
                        rectangle_contains_points r2 l_point,
                        rectangle_contains_points r3 l_point,
                        rectangle_contains_points r4 l_point
                    )
                in Node (aux l1 n r1, aux l2 n r2, aux l3 n r3, aux l4 n r4, rect)
    in aux l_point n (enclosing_rectangle l_point);;
let p1 = make_point 0. 0.
and p2 = make_point 0.5 0.5
and p3 = make_point 0.5 1.5;;
quadtree_make [p1; p2; p3] 1;;

(* Question 13 *)
(* quadtree -> int  *)
(* quadtree_count *)

let rec quadtree_count tree =
    match tree with
    | Leaf (l , _) -> length l
    | Node (t1, t2, t3, t4, _) -> 
            quadtree_count t1 + quadtree_count t2 + quadtree_count t3 + quadtree_count t4;;

quadtree_count (quadtree_make [p1; p2; p3] 1);;

(* Question 14 *)
(* quadtree -> int list *)
(* quadtree_signature *)

let rec quadtree_signature tree =
    match tree with
    | Leaf (l, _) -> [length l]
    | Node (t1, t2, t3, t4, _) -> 
            quadtree_signature t1 @ quadtree_signature t2 @ quadtree_signature t3 @ quadtree_signature t4;;

 quadtree_signature (quadtree_make [p1; p2; p3] 1);;

(* -------------------------------------------------------------------------- *)


(* Question 15 *)
(* quadtree -> point list  *)
(* quadtree_all_points *)

let rec quadtree_all_points tree =
    match tree with
    | Leaf (l, _) -> l
    | Node (t1, t2, t3, t4, _) -> 
            quadtree_all_points t1 @ quadtree_all_points t2 @ quadtree_all_points t3 @ quadtree_all_points t4;;

quadtree_all_points (quadtree_make [p1; p2; p3] 1);;

(* rectangle -> rectangle -> bool *)
let rectangle_contains_rectangle r1 r2 =
    rectangle_contains_point r1 (rectangle_lower_left r2) &&
    rectangle_contains_point r1 (rectangle_upper_right r2);;

(* rectangle -> rectangle -> bool *)
let rectangle_disjoint (p1,p2) (p3,p4) =
    point_domination p3 p2 || point_domination p1 p4;;

(* rectangle -> rectangle -> rectangle *)
let rectangle_intersection ((p1,p2),(p3,p4))=
    let ll_x_max = largest [point_x p1; point_x p3] in
    let ll_y_max = largest [point_y p1; point_y p3] in
    let ur_x_min = smallest [point_x p2; point_x p4] in
    let ur_y_min = smallest [point_y p2; point_y p4] in
    let ll = make_point ll_x_max ll_y_max in
    let ur = make_point ur_x_min ur_y_min in
        make_rectangle ll ur;;

(* Question 16 *)
(* rectangle -> quadtree -> point list  *)
(* rectangle_query *)

let rec rectangle_query rect tree =
    match tree with
    | Leaf (l, r) -> 
            if rectangle_disjoint rect r then []
            else
                if rectangle_contains_rectangle rect r then l
                else let inter = (rectangle_intersection (rect,r))
                in rectangle_contains_points inter l
    | Node (t1, t2, t3, t4, r) ->
            if rectangle_disjoint rect r then []
            else (rectangle_query rect t1) @ (rectangle_query rect t2) @ (rectangle_query rect t3) @ (rectangle_query rect t4);;


(* -------------------------------------------------------------------------- *)

(* Question 17 *)
(* quadtree -> int -> point -> quadtree *)
(* quadtree_insert *)
let quadtree_make l_point n =
    let rec aux l_point n rect =
        if (length l_point) <= n 
        then Leaf (l_point, rect)
        else 
            let (r1, r2, r3, r4) = rectangle_split_four rect
            in
                let (l1, l2, l3, l4) = 
                    (
                        rectangle_contains_points r1 l_point,
                        rectangle_contains_points r2 l_point,
                        rectangle_contains_points r3 l_point,
                        rectangle_contains_points r4 l_point
                    )
                in Node (aux l1 n r1, aux l2 n r2, aux l3 n r3, aux l4 n r4, rect)
    in aux l_point n (enclosing_rectangle l_point);;

let rec quadtree_insert tree n p =
    match tree with
    | Leaf (l, r) -> 
            let rec aux l_point n rect =
                let new_l = p :: l
                in if (length new_l) <= n
                then Leaf (new_l, r)
                else 
                    let (r1, r2, r3, r4) = rectangle_split_four r
                    in
                        let (l1, l2, l3, l4) = 
                            (
                                rectangle_contains_points r1 l,
                                rectangle_contains_points r2 l,
                                rectangle_contains_points r3 l,
                                rectangle_contains_points r4 l
                            )
                        in Node (aux l1 n r1, aux l2 n r2, aux l3 n r3, aux l4 n r4, rect)
            in aux l n r
    | Node (t1, t2, t3, t4, r) ->
            let (r1, r2, r3, r4) = rectangle_split_four r
            in if rectangle_contains_point r1 p then Node (quadtree_insert t1 n p, t2, t3, t4, r)
            else if rectangle_contains_point r2 p then Node (t1, quadtree_insert t2 n p, t3, t4, r)
            else if rectangle_contains_point r3 p then Node (t1, t2, quadtree_insert t3 n p, t4, r)
            else Node (t1, t2, t3, quadtree_insert t4 n p, r);;

(* Question 18 *)
(* quadtree -> point -> quadtree *)
(* quadtree_delete *)

let rec quadtree_delete tree p =
    match tree with
    | Leaf (l, r) ->
            Leaf (fold_left (fun a b -> if p = b then a else b :: a) [] l, r)
    | Node (t1, t2, t3, t4, r) -> 
            let (r1, r2, r3, r4) = rectangle_split_four r
            in if rectangle_contains_point r1 p then Node (quadtree_delete t1 p, t2, t3, t4, r)
            else if rectangle_contains_point r2 p then Node (t1, quadtree_delete t2 p, t3, t4, r)
            else if rectangle_contains_point r3 p then Node (t1, t2, quadtree_delete t3 p, t4, r)
            else Node (t1, t2, t3, quadtree_delete t4 p, r);;
