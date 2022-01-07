
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

ford: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 0 5 outfile	
	@echo "\n==== RESULT ==== (content of outfile) \n"
	dot -Tsvg outfile.result > result.svg
	xdg-open result.svg

clean:
	-rm -rf _build/
	-rm ftest.native

tricount:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild testTriCount.native
	./testTriCount.native lists/testTriCount
