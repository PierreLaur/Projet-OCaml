open Tools
open Graph

let rec find_path g ids idp = 
  let select_arc l =
    

  match (out_arcs g ids) with
    | [] -> None
    | (x,n)::rest -> if n>0 then find_path g x
    else 
    
    (* - faire une liste (pile) pour noter les noeuds visités & éviter ls boucles
       - rappeler out_arcs à partir de différents ndes*)