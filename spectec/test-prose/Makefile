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

HEADER = header

EXECINDEX = exec/index

EXECINSTRIN = exec/instructions-in
EXECINSTROUT = exec/instructions

EXECRUNTIMEIN = exec/runtime-in
EXECRUNTIMEOUT = exec/runtime

EXECAUXIN = exec/auxiliary-in
EXECAUXOUT = exec/auxiliary

VALIDINDEX = valid/index

VALIDINSTRIN = valid/instructions-in
VALIDINSTROUT = valid/instructions

OUTPROSE = prose

SPHINXDIR = _sphinx

.PHONY: html pdf

$(EXECINSTROUT).rst: $(EXECINSTRIN).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

$(EXECRUNTIMEOUT).rst: $(EXECRUNTIMEIN).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

$(EXECAUXOUT).rst: $(EXECAUXIN).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

execs: $(EXECINDEX).rst $(EXECINSTROUT).rst $(EXECRUNTIMEOUT).rst $(EXECAUXOUT).rst

$(VALIDINSTROUT).rst: $(VALIDINSTRIN).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

valids: $(VALIDINDEX).rst $(VALIDINSTROUT).rst

sphinx-splice: html pdf

html: $(OUTPROSE).rst $(OUTVALID).rst $(OUTEXEC).rst conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $^ $(SPHINXDIR)
	cp $(word 2,$^) $(SPHINXDIR) 
	cp $(word 3,$^) $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(OUTPROSE).html >$(OUTPROSE).html.tmp
	mv -f $(OUTPROSE).html.tmp $(SPHINXDIR)/_build/$(OUTPROSE).html

pdf: $(OUTPROSE).rst execs valids conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $< conf.py macros.def mathdef.py $(SPHINXDIR)
	mkdir $(SPHINXDIR)/exec
	cp $(EXECINDEX).rst $(EXECINSTROUT).rst $(EXECRUNTIMEOUT).rst $(EXECAUXOUT).rst $(SPHINXDIR)/exec
	mkdir $(SPHINXDIR)/valid
	cp $(VALIDINDEX).rst $(VALIDINSTROUT).rst $(SPHINXDIR)/valid 
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

	rm -f *.pdf
