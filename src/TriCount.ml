open Graph
open Gfile
open Tools
open FordFulkerson

let create_graph laliste = 
  let moyenne =
    let rec aux liste =
      match liste with 
      | [] -> 0 
      | (nom,montant)::rest -> (montant/(List.length liste)) + (moyenne rest)
    in
    aux laliste
  in

  let rec itere liste graphe num=
    match (liste) with
    | [] -> empty_graph
    | (nom,montant)::rest -> if ((moyenne-montant)>0) then 
        (* pour chaque personne, on crée :
           - une node numérotée num
           - une node auxiliaire (source/puits) numérotée num+1
           - un arc depuis/vers num représentant l'écart avec la moyenne *)
        itere rest (new_arc    (new_node     (new_node graphe num)    (num+1))     (num+1) num (moyenne-montant) ) (num+2) 
      else itere rest (new_arc    (new_node     (new_node graphe num)    (num+1))     num (num+1) (montant-moyenne) ) (num+2) 

  in


  let arcs_internes graphe = 
    (*val n_fold: 'a graph -> ('b -> id -> 'b) -> 'b -> 'b) *)
    (*val new_arc: 'a graph -> id -> id -> 'a -> 'a graph *)
    let rec aux2 gr (new_arc id) =
      aux2 gr 

    in
    n_fold graphe aux2 graphe 
  in


