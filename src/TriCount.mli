open Graph
open Gfile
open Tools
open FordFulkerson

(* crée un  graphe à partir d'une liste donnée contenant les personnes et le montant qu'elles ont payé *)
val create_graph : (string *int) list -> int graph

(* exécute l'algoritme tricount*)
val triCount :(string*int) list -> unit

(* lit le fichier donnée en entrée et crée la liste de personnes *)
val read_list : path -> (string*int) list