# Configuration

NAME =		watsup
EXT =		spasm
UNOPT = 	$(NAME).debug
OPT =   	$(NAME)

DIRS =		util syntax front main
LIBS =		
FLAGS = 	-lexflags -ml -cflags '-w +a-4-27-42-44-45-70 -warn-error +a-3'
OCBA =		ocamlbuild $(FLAGS) $(DIRS:%=-I %)
OCB =		$(OCBA) $(LIBS:%=-libs %)

SPECDIR =	../spec
SPECFILES =	syntax aux typing runtime reduction


# Main targets

.PHONY:		default opt unopt all dunebuild

default:	opt
debug:		unopt
opt:		$(OPT)
unopt:		$(UNOPT)
all:		unopt opt

dune:
	dune build


# Building executable

empty =
space =		$(empty) $(empty)
comma =		,

.INTERMEDIATE:	_tags
_tags:
		echo >$@ "true: bin_annot"
		echo >>$@ "true: debug"
		echo >>$@ "<{$(subst $(space),$(comma),$(DIRS))}/*.cmx>: for-pack($(PACK))"

$(UNOPT):	main.byte
		mv $< $@

$(OPT):		main.native
		mv $< $@

.PHONY:		main.byte main.native
main.byte:	_tags
		$(OCB) -quiet $@

main.native:	_tags
		$(OCB) -quiet $@


# Test

.PHONY:		test
test:		all
		./$(NAME) $(SPECFILES:%=$(SPECDIR)/%.$(EXT))


# Cleanup

.PHONY:		clean

clean:
		rm -rf _tags
		$(OCB) -clean
