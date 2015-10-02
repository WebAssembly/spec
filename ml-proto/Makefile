# vim: sw=8 ts=8 noet:
#
# This Makefile uses ocamlbuild but does not rely on ocamlfind
# or the Opam package manager.
#

NAME =		wasm
NAME_OPT =      $(NAME)
NAME_UNOPT =    $(NAME).unopt
Makefile =	Makefile

OCB_FLAGS +=	# -use-ocamlfind
OCB_FLAGS +=	# -cflags -w 
OCB_FLAGS += 	# -cflags +a-4-41-42-44-45
OCB_FLAGS += 	-libs str,bigarray
OCB_FLAGS += 	-I host -I given -I spec
OCB =		ocamlbuild $(OCB_FLAGS)

opt:		$(NAME_OPT)
unopt:		$(NAME_UNOPT)
all:		opt unopt test

$(NAME_OPT):	main.native
		mv $< $@

$(NAME_UNOPT):	main.d.byte
		mv $< $@

main.native:	$(MAKEFILE)
		$(OCB) $@

main.d.byte:	$(MAKEFILE)
		$(OCB) $@

test:
		./runtests.py

clean:
		$(OCB) -clean

check:
		# check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query str bigarray

zip: 
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		all opt unopt clean test check zip
