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

INNAME = prose-in
OUTNAME = prose
SPHINXDIR = _sphinx

.PHONY: html pdf

$(OUTNAME).rst: $(INNAME).rst $(SPECFILES) $(EXE)
	$(EXE) $(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $@ -p $<

sphinx-splice: html pdf

html: $(OUTNAME).rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(OUTNAME).rst conf.py $(SPHINXDIR)
	sphinx-build -W -b html $(SPHINXDIR) $(SPHINXDIR)/_build
	sed "s/textsc{/mathrm{/g" $(SPHINXDIR)/_build/$(OUTNAME).html >$(OUTNAME).html.tmp
	mv -f $(OUTNAME).html.tmp $(SPHINXDIR)/_build/$(OUTNAME).html

pdf: $(OUTNAME).rst conf.py
	mkdir -p $(SPHINXDIR)/_build
	cp $(OUTNAME).rst conf.py $(SPHINXDIR)
	sphinx-build -W -b latex $(SPHINXDIR) $(SPHINXDIR)/_build
	(cd $(SPHINXDIR)/_build; pdflatex $(OUTNAME).tex)

# Cleanup

.PHONY: clean

clean:
	dune clean
	rm -f *.aux *.log
	rm -rf $(SPHINXDIR)
	rm -f $(OUTNAME).rst
	rm -f *.pdf
