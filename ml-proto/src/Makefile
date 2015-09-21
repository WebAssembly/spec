#
# This Makfile assumes we can use ocamlfind to locate libraries. This
# is the case in a typical OCaml environment that uses Opam. Use 
#
#	make check
#
# to see that relevant libraries can be found.	
#

NAME =		wasm
Makefile =	Makefile

OCB_FLAGS +=	-use-ocamlfind
OCB_FLAGS +=	# -cflags -w 
OCB_FLAGS += 	# -cflags +a-4-41-42-44-45
OCB_FLAGS += 	-I host -I given -I spec
OCB =		ocamlbuild $(OCB_FLAGS)

all:		$(NAME) unopt

$(NAME):	main.native
		mv $< $@

unopt:		main.byte
		mv $< $@

main.native:	$(MAKEFILE) check
		$(OCB) $@

main.byte:	$(MAKEFILE) check
		$(OCB) $@

clean:
		$(OCB) -clean

check:
		# check that we can find all relevant libraries
		ocamlfind query str num bigarray

zip: 
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		all clean check zip
