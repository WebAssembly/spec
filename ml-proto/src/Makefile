# vim: sw=8 ts=8 noet:
#
# This Makefile uses ocamlbuild but does not rely on ocamlfind
# or the Opam package manager.
#

NAME =		wasm
Makefile =	Makefile

OCB_FLAGS +=	# -use-ocamlfind
OCB_FLAGS +=	# -cflags -w 
OCB_FLAGS += 	# -cflags +a-4-41-42-44-45
OCB_FLAGS += 	-libs nums,str,bigarray
OCB_FLAGS += 	-I host -I given -I spec
OCB =		ocamlbuild $(OCB_FLAGS)

all:		$(NAME) unopt

$(NAME):	main.native
		mv $< $@

unopt:		main.byte
		mv $< $@

main.native:	$(MAKEFILE)
		$(OCB) $@

main.byte:	$(MAKEFILE)
		$(OCB) $@

clean:
		$(OCB) -clean

check:
		# check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query str num bigarray

zip: 
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		all clean check zip
