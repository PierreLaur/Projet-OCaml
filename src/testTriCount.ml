open Gfile
open Tools
open FordFulkerson
open TriCount

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 2 then
    begin
      Printf.printf "\nUsage: %s infile \n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) *)

  let infile = Sys.argv.(1)
  in


  (* Open file *)
  let liste = read_list infile in

  triCount liste ;


