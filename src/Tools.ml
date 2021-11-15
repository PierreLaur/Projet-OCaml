open Graph

let clone_nodes (gr:'a graph) = 
  n_fold gr new_node empty_graph
;;

let gmap gr f =
  let aux acu id1 id2 n =
    new_arc acu id1 id2 (f n)
  in  
  e_fold gr aux (clone_nodes gr)
;;

let add_arc g id1 id2 n = assert false

(*
  let rec find_arc y id2 n = match y with
    | [] -> new_arc gr id1 id2 n
    | (dest,value) :: rest -> 
      if dest=id2 then new_arc gr id1 id2 (value+n)
      else find_arc rest id2 n
  in
  let rec find_node gr id1 = match gr with
    | [] -> raise Graph_error "node not found"
    | (x,y) :: rest -> 
      if x=id1 then find_arc y id2 n
      else find_node rest id1
  in
  find_node g id1 ;;


*)