#
# (c) 2015 Andreas Rossberg
#

NAME = wasm
MODULES = \
  flags lib source error \
  types values memory syntax \
  check arithmetic eval print script \
  lexer parser \
  main
NOMLI = flags types syntax sexpr main
PARSERS = parser
LEXERS = lexer
LIBRARIES = bigarray
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
	ocamldep $^ >$@

-include Makefile.depend

zip: $(MLS) $(MLIS) $(MLYS) $(MLLS) Makefile $(IMLS) $(TXTS)
	mkdir tmp tmp/$(NAME)
	cp $^ tmp/$(NAME)
	rm -f $(NAME).zip
	(cd tmp; zip -r ../$(NAME).zip $(NAME))
	rm -r tmp

clean:
	rm -f *.cmi *.cmo *.cmx *.o *.output *.depend
	rm -f *.native *.byte $(NAME) $(NAME).opt $(NAME).zip
	rm -rf _build
	rm -f *~

distclean: clean
	rm -f $(PARSERS:%=%.mli) $(PARSERS:%=%.ml) $(LEXERS:%=%.ml)

%.cmi: %.mli
	ocamlc -c $(OCAMLCOPTS) $<

%.cmo: %.ml
	ocamlc -c $(OCAMLCOPTS) -g $<

%.cmx: %.ml
	ocamlopt -c $(OCAMLCOPTS) $<

%.ml: %.mly
	ocamlyacc -v $<

%.mli: %.mly
	ocamlyacc -v $<

%.ml: %.mll
	ocamllex $<

.PRECIOUS: %.ml %.mli
