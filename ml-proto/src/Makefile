#
# (c) 2015 Andreas Rossberg
#

NAME = wasm
INCLUDES = -I host -I given -I spec
MODULES = \
  host/flags given/lib given/source given/float32 given/float64 spec/error \
  spec/types spec/values spec/memory spec/ast \
  spec/check spec/arithmetic spec/eval \
  host/print host/builtins host/script \
  host/lexer host/parser \
  host/main
NOMLI = host/flags spec/types spec/values spec/ast host/main
PARSERS = host/parser
LEXERS = host/lexer
LIBRARIES = bigarray nums str
SAMPLES = 
TEXTS = 

MLS = $(MODULES:%=%.ml)
MLIS = $(filter-out $(NOMLI:%=%.mli), $(MODULES:%=%.mli))
MLYS = $(PARSERS:%=%.mly)
MLLS = $(LEXERS:%=%.mll)
CMOS = $(MODULES:%=%.cmo)
CMXS = $(MODULES:%=%.cmx)
CMAS = $(LIBRARIES:%=%.cma)
CMXAS = $(LIBRARIES:%=%.cmxa)
TXTS = $(TEXTS:%=%.txt)

OCAMLCOPTS =   # -w +a-4-41-42-44-45

$(NAME): $(CMXS) Makefile
	ocamlopt $(CMXAS) $(CMXS) $(OCAMLCOPTS) -o $@

unopt: $(CMOS) Makefile
	ocamlc $(CMAS) $(CMOS) $(OCAMLCOPTS) -g -o $(NAME)

$(filter-out $(NOMLI:%=%.cmo), $(CMOS)): %.cmo: %.cmi
$(filter-out $(NOMLI:%=%.cmx), $(CMXS)): %.cmx: %.cmi

Makefile.depend: $(MLS) $(MLIS) Makefile
	ocamldep $(INCLUDES) $^ >$@

-include Makefile.depend

zip: $(MLS) $(MLIS) $(MLYS) $(MLLS) Makefile $(IMLS) $(TXTS)
	mkdir tmp tmp/$(NAME)
	cp $^ tmp/$(NAME)
	rm -f $(NAME).zip
	(cd tmp; zip -r ../$(NAME).zip $(NAME))
	rm -r tmp

clean:
	rm -f given/*.cmi given/*.cmo given/*.cmx given/*.o
	rm -f spec/*.cmi spec/*.cmo spec/*.cmx spec/*.o
	rm -f host/*.cmi host/*.cmo host/*.cmx host/*.o host/*.output
	rm -f *.depend *.native *.byte $(NAME) $(NAME).opt $(NAME).zip
	rm -rf _build
	rm -f *~

distclean: clean
	rm -f $(PARSERS:%=%.mli) $(PARSERS:%=%.ml) $(LEXERS:%=%.ml)

%.cmi: %.mli
	ocamlc -c $(INCLUDES) $(OCAMLCOPTS) $<

%.cmo: %.ml
	ocamlc -c $(INCLUDES) $(OCAMLCOPTS) -g $<

%.cmx: %.ml
	ocamlopt -c $(INCLUDES) $(OCAMLCOPTS) $<

%.ml: %.mly
	ocamlyacc -v $<

%.mli: %.mly
	ocamlyacc -v $<

%.ml: %.mll
	ocamllex $<

.PRECIOUS: %.ml %.mli
