# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))

# Main targets

.PHONY: all

all: html pdf

# Sphinx splicing

MACRO = macros.def

EXECDIR = exec

EXECINDEX = exec/index

EXECINSTRIN = exec/instructions-in
EXECINSTROUT = exec/instructions

EXECRUNTIMEIN = exec/runtime-in
EXECRUNTIMEOUT = exec/runtime

EXECAUXIN = exec/auxiliary-in
EXECAUXOUT = exec/auxiliary

VALIDDIR = valid

VALIDINDEX = valid/index

VALIDINSTRIN = valid/instructions-in
VALIDINSTROUT = valid/instructions

OUTPROSE = prose

SPHINXDIR = _sphinx

.PHONY: html pdf

doc: $(EXECINDEX).rst $(EXECINSTRIN).rst $(EXECRUNTIMEIN).rst $(EXECAUXIN).rst $(VALIDINDEX).rst $(VALIDINSTRIN).rst
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $(EXECINSTROUT).rst $(EXECRUNTIMEOUT).rst $(EXECAUXOUT).rst $(VALIDINSTROUT).rst -p $(word 2,$^) $(word 3,$^) $(word 4,$^) $(word 6,$^) 

sphinx-splice: html pdf

html: $(OUTPROSE).rst doc conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $< conf.py macros.def mathdef.py $(SPHINXDIR)
	rsync -av --exclude='*-in.rst' $(EXECDIR) $(SPHINXDIR)
	rsync -av --exclude='*-in.rst' $(VALIDDIR) $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(OUTPROSE).html >$(OUTPROSE).html.tmp
	mv -f $(OUTPROSE).html.tmp $(SPHINXDIR)/_build/$(OUTPROSE).html

pdf: $(OUTPROSE).rst doc conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $< conf.py macros.def mathdef.py $(SPHINXDIR)
	rsync -av --exclude='*-in.rst' $(EXECDIR) $(SPHINXDIR)
	rsync -av --exclude='*-in.rst' $(VALIDDIR) $(SPHINXDIR)
	sphinx-build -W -b latex $(SPHINXDIR) $(SPHINXDIR)/_build
	(cd $(SPHINXDIR)/_build; pdflatex $(OUTPROSE).tex)
	cp $(SPHINXDIR)/_build/prose.pdf .

# Cleanup

.PHONY: clean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)
	rm -f $(EXECINSTROUT).rst
	rm -f $(EXECRUNTIMEOUT).rst
	rm -f $(EXECAUXOUT).rst
	rm -f $(VALIDINSTROUT).rst
	rm -f $(MACRO)
	rm -f *.pdf
