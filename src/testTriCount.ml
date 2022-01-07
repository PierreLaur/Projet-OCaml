open Gfile
open Tools
open FordFulkerson
open TriCount

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf "\nUsage: %s infile outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) outfile(2) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(2)
  in


  (* Open file *)
  let liste = read_list infile in

  let graph = triCount liste in
  let graph = gmap graph string_of_int in


  let () = write_file outfile graph in
  let () = export (outfile^".chama") graph in
  ()


