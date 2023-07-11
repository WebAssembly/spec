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

INEXEC = exec-in
OUTEXEC = exec

INVALID = valid-in
OUTVALID = valid

INPROSE = prose-in
OUTPROSE = prose
SPHINXDIR = _sphinx

.PHONY: html pdf

$(OUTEXEC).rst: $(INEXEC).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

$(OUTVALID).rst: $(INVALID).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

$(OUTPROSE).rst: $(OUTEXEC).rst $(OUTVALID).rst
	cat $(word 2,$<) >> $@
	echo >> $@
	cat $(word 2,$^) >> $@

sphinx-splice: html pdf

html: $(OUTPROSE).rst conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $^ $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(OUTPROSE).html >$(OUTPROSE).html.tmp
	mv -f $(OUTPROSE).html.tmp $(SPHINXDIR)/_build/$(OUTPROSE).html

pdf: $(OUTPROSE).rst conf.py macros.def mathdef.py
	mkdir -p $(SPHINXDIR)/_build
	cp $^ $(SPHINXDIR)
	sphinx-build -W -b latex $(SPHINXDIR) $(SPHINXDIR)/_build
	(cd $(SPHINXDIR)/_build; pdflatex $(OUTPROSE).tex)
	cp $(SPHINXDIR)/_build/prose.pdf .

# Cleanup

.PHONY: clean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)
	rm -f $(OUTPROSE).rst
	rm -f *.pdf
