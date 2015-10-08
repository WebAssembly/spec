# vim: sw=8 ts=8 noet:
#
# This Makefile uses ocamlbuild but does not rely on ocamlfind
# or the Opam package manager.
#

NAME =		wasm
NAME_OPT =      $(NAME).opt
NAME_UNOPT =    $(NAME)
DIRS =		given host spec
LIBS =		str bigarray

OCB_FLAGS +=	# -use-ocamlfind
OCB_FLAGS +=	# -cflags -w 
OCB_FLAGS += 	# -cflags +a-4-41-42-44-45
OCB_FLAGS += 	$(DIRS:%=-I %)
OCB_FLAGS += 	$(LIBS:%=-libs %)
OCB =		ocamlbuild $(OCB_FLAGS)

.PHONY:		all opt unopt
unopt:		$(NAME_UNOPT)
opt:		$(NAME_OPT)
all:		opt unopt test

$(NAME_OPT):	main.native
		mv $< $@

$(NAME_UNOPT):	main.d.byte
		mv $< $@

.PHONY:		main.native
main.native:
		$(OCB) $@

.PHONY:		main.d.byte
main.d.byte:
		$(OCB) $@

.PHONY:		test
test:
		./runtests.py

.PHONY:		zip
zip: 
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		clean
clean:
		$(OCB) -clean

.PHONY:		check
check:
		# check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query str bigarray
