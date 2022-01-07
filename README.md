Ocaml project on Ford-Fulkerson & a TriCount application based on the algorithm.

To test Ford-Fulkerson, add your graph in "graphs" folder. Specify its name, a source & a sink in the makefile. 
Then use `make ford` to run the algorithm and see the result graph.

To use TriCount, add a list of persons along with what they paid in the lists folder. Specify the file name in the makefile.
The list should look like this :
> John 20  
> Mark 30  
> Bill 50  
Then use `make tricount` to see how much each person has to pay to the others.

