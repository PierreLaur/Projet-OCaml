open Tools
open Graph



(* On donne un graphe + les id des nodes source & puits -> la fonction renvoie un chemin & la valeur de flot minimale sur ce chemin *)
val find_path : 'a graph -> id -> id -> (('a out_arcs list) * int)



