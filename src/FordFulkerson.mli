open Tools
open Graph



(* On donne un graphe + les id des nodes source & puits -> la fonction renvoie un chemin & la valeur de flot minimale sur ce chemin *)
val find_path : int graph -> id -> id -> id list

(* cette fonction trouve la capacité minimale d'un chemin donné *)
val min_capacity : int graph -> id list -> int -> int

(* cette fonction ajoute une valeur à tous les arcs d'une liste donnée dans un graphe*)
val adjust_graph : int graph -> id list -> int -> int graph


(* l'algorithme *)
val run : int graph -> id -> id -> int graph



(* étapes :
   - cloner le graphe donné
      -> on obtient un graphe complet (graphe d'écart)
      -> et un graphe sans arcs avec les mêmes nodes (graphe de flux)
   - itérations :
   - choisir un chemin entre source et puits
        -> si pas de chemin on retourne le graphe de flux (terminé)
        -> sinon
   - on trouve la capacité min sur ce chemin
   - on la soustrait sur tout le chemin dans le graphe d'écart
   - on l'ajoute sur tout le chemin dans le graphe de flux
   - on réitère

*)