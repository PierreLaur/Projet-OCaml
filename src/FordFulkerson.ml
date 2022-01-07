open Tools
open Graph

(* find_path trouve un chemin dans g entre ids et idp et le retourne à l'envers dans une liste*)

let find_path g ids idp =
  let rec aux g ids idp stack =  
    let out = out_arcs g ids in
    let rec select_arc arclist =
      match arclist with
      | [] -> []
      | (x,n)::rest -> 
        if (List.exists (fun y-> y=x) stack) || (n=0) then 
          select_arc rest
        else match aux g x idp (ids::stack) with
          | [] -> select_arc rest
          | s -> s

    in
    if ids=idp then
      idp::stack
    else select_arc out
  in 
  aux g ids idp [] ;;
;;

let rec min_capacity g l m = match l with
  | [] -> m
  | x :: rest -> 
    match rest with
    | [] -> m
    | y :: rest2 -> 
      match find_arc g x y with
      | None -> raise (Graph_error "Pas d'arc trouvé (min_capacity)")
      | Some z -> min_capacity g rest (min m z)
;;

let rec adjust_graph g l value = match l with
  | [] -> g
  | x :: rest -> 
    match rest with
    | [] -> g
    | y :: rest2 -> adjust_graph (add_arc g x y value) rest value
;;

let run g ids idp =
  let flux_init = clone_nodes g in
  (* g est le graphe d'écart, flux le graphe de flux *)

  let rec aux ecart flux = 
    match List.rev (find_path ecart ids idp) with
    | [] -> flux
    | chemin -> 
      let m = (min_capacity ecart chemin max_int) in 
      aux (adjust_graph ecart chemin (-m)) (adjust_graph flux chemin m)

  in
  aux g flux_init
;;
