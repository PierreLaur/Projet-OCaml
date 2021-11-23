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

let add_arc g id1 id2 n = 
  if ((node_exists g id1)&&(node_exists g id2))=false
  then raise (Graph_error "Node not found")
  else
    match find_arc g id1 id2 with
    | None -> new_arc g id1 id2 n
    | Some value -> new_arc g id1 id2 (n+value)
;;
