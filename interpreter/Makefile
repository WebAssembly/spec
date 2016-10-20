# vim: sw=8 ts=8 noet:
#
# This Makefile uses ocamlbuild but does not rely on ocamlfind
# or the Opam package manager.
#

NAME =		wasm
NAME_OPT =      $(NAME).opt
NAME_UNOPT =    $(NAME)
DIRS =		aux spec text host host/import
LIBS =		str bigarray

OCB_FLAGS += 	-cflags '-w +a-4-27-42-44-45 -warn-error +a'
OCB_FLAGS += 	$(DIRS:%=-I %)
OCB_FLAGS += 	$(LIBS:%=-libs %)
OCB =		ocamlbuild $(OCB_FLAGS)

.PHONY:		opt unopt all land
unopt:		$(NAME_UNOPT)
opt:		$(NAME_OPT)
all:		opt unopt test
land:		all winmake.bat

$(NAME_OPT):	main.native
		mv $< $@

$(NAME_UNOPT):	main.d.byte
		mv $< $@

.PHONY:		main.native
main.native:
		$(OCB) -quiet $@

.PHONY:		main.d.byte
main.d.byte:
		$(OCB) -quiet $@

.PHONY:		test
test:		$(NAME)
		./runtests.py

winmake.bat:	clean
		echo rem Auto-generated from Makefile! >$@
		echo set NAME=$(NAME) >>$@
		echo if \'%1\' neq \'\' set NAME=%1 >>$@
		$(OCB) main.d.byte \
		| grep -v ocamldep \
		| grep -v mkdir \
		| sed s:`which ocaml`:ocaml:g \
		| sed s:host/main.d.byte:%NAME%: \
		>>$@

.PHONY:		zip
zip: 		winmake.bat
		git archive --format=zip --prefix=$(NAME)/ \
			-o $(NAME).zip HEAD

.PHONY:		clean
clean:
		$(OCB) -clean

.PHONY:		check
check:
		# check that we can find all relevant libraries
		# when using ocamlfind
		ocamlfind query $(LIBS)
