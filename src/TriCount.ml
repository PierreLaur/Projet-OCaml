open Graph
open Gfile
open Tools
open FordFulkerson

let create_graph listePersonnes = 
  
  let moyenne =
    let rec aux liste =
      match liste with 
      | [] -> 0 
      | (nom,montant)::reste -> (montant/(List.length liste)) + (moyenne reste)
    in
    aux listePersonnes
  in

  let rec createNodesAndAux liste graphe num=
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
    (* val n_fold: 'a graph -> ('b -> id -> 'b) -> 'b -> 'b *)
    (* val new_arc: 'a graph -> id -> id -> 'a -> 'a graph *)

    (* pour un node idFrom dans un graphe donné, createArcsFrom crée des arcs vers les autres nodes*)
    (* on exclut les id impairs (nodes auxiliaires) *)
    let createArcsFrom gr idFrom =

      let createOutArc gr2 idTo =
        if (idTo mod 2==0) then
          new_arc gr2 idFrom idTo 0
      in
      
      if (idFrom mod 2==0) then
        (* on crée un arc sortant depuis idFrom vers tous les nodes *)
        n_fold gr createOutArc gr
    in


    (* on applique createArcsFrom sur tous les nodes *)
    n_fold graphe createArcsFrom graphe 
  in


  let createdGraph = createNodesAndAux listePersonnes empty_graph 0
  in
  let createdGraph = createInternalArcs createdGraph
in createdGraph


