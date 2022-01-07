open Graph
open Gfile
open Tools
open FordFulkerson

let create_graph listePersonnes = 
  (* len = nombre de personnes *)
  let len = List.length listePersonnes  in
  (* moyenne des montants payés*)
  let moyenne =
    let rec aux liste =
      match liste with 
      | [] -> 0. 
      | (nom,montant)::reste -> ((float_of_int montant) /. (float_of_int len)) +. (aux reste)
    in
    int_of_float (aux listePersonnes)
  in

  let rec createNodesAndAux liste graphe num  =
    match (liste) with
    | [] -> graphe
    | (nom,montant)::reste -> 
      (* pour chaque personne, on crée :
         - une node numérotée num *)
      let nodeNum = new_node graphe num
      (* - une node auxiliaire (source/puits) numérotée num+1 *)
      in let nodeAux = new_node nodeNum (num+1)
      (* - un arc depuis/vers num représentant l'écart avec la moyenne *)
      in let arcAux = 
           if ((moyenne-montant)>0) then 
             new_arc nodeAux (num+1) num (moyenne-montant)
           else
             new_arc nodeAux num (num+1) (montant-moyenne)
      in createNodesAndAux reste arcAux (num+2)

  in


  let createInternalArcs graphe = 

    (* pour un node idFrom dans un graphe donné, createArcsFrom crée des arcs vers les autres nodes*)
    (* on exclut les id impairs (nodes auxiliaires) *)
    let createArcsFrom gr idFrom =

      let createOutArc gr2 idTo =
        if ((idTo mod 2==0) && (idTo != idFrom)) then
          new_arc gr2 idFrom idTo Int.max_int
        else gr2
      in

      if (idFrom mod 2==0) then
        (* on crée un arc sortant depuis idFrom vers tous les nodes *)
        n_fold gr createOutArc gr
      else gr
    in


    (* on applique createArcsFrom sur tous les nodes *)
    n_fold graphe createArcsFrom graphe 
  in


  let createdGraph = createNodesAndAux listePersonnes empty_graph 0
  in
  let createdGraph = createInternalArcs createdGraph
  in createdGraph

let triCount listePersonnes =
  Printf.printf "\n==================================\n" ;
  let graph = create_graph listePersonnes in

  (* applique le max-flow algorithm depuis toutes les nodes auxiliaires sources vers toutes les nodes auxiliaires puits *)
  let runOnNodes = 

    let runFrom idFrom =
      let runTo idTo =
        (* on vérifie que les nodes sont auxiliaires (id impairs), que la node "idFrom" est source et qu'idFrom et idTo sont différentes *)
        let isSource id = (find_arc graph id (id-1))!=None in
        if ((idTo mod 2==1) && (idTo != idFrom) && (isSource idFrom)) then
          let result = run graph idFrom idTo in

          (* on trouve les noms des personnes correspondant aux ids concernés *)
          let (person1, _) = List.nth listePersonnes ((idFrom-1)/2) in
          let (person2, _) = List.nth listePersonnes ((idTo-1)/2) in
          (* le résultat est le flux maximal partant de la source : la valeur sur l'arc qui en part *)
          match (find_arc result idFrom (idFrom-1)) with
          | Some x -> Printf.printf "%s doit payer %d à %s\n" person1 x person2 ;
          | None -> ()
      in

      if (idFrom mod 2==1) then
        n_iter graph runTo
    in

    n_iter graph runFrom
  in
  runOnNodes ;
  Printf.printf "==================================\n\n"

let read_list path =
  let read_tuple line liste =
    try Scanf.sscanf line "%s %d" (fun name amount -> (name, amount)::liste)
    with e ->
      Printf.printf "Cannot read tuple in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
      failwith "from_file"
  in

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop liste =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let liste2 =
        (* Ignore empty lines *)
        if line = "" then liste

        else read_tuple line liste
      in      
      loop liste2

    with End_of_file -> liste (* Done *)
  in

  let final_liste = loop [] in

  close_in infile ;
  final_liste

