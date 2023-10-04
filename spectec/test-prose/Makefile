# Configuration

NAME = watsup
EXE = $(PWD)/../$(NAME)
EXT = $(NAME)

OWNDIR = $(PWD)
SPECDIR = ../spec
SPECFILES = $(shell ls $(SPECDIR)/*.$(EXT))

SPHINXBUILD = sphinx-build
SPHINXDIR = _sphinx
BUILDDIR = _sphinx/_build

# Main targets

.PHONY: all

all: pdf html

# Sphinx splicing

CONF = doc/conf.py

INDEX = doc/index.rst

MATHDEF = doc/util/mathdef.py

INPUTFILES = $(wildcard $(SPHINXDIR)/*/*-in.rst)

SPLICEINPUT = $(strip $(patsubst $(SPHINXDIR)/%,%,$(subst " ", " ", $(INPUTFILES))))

SPLICEOUTPUT = $(strip $(subst -in.rst,.rst,$(SPLICEINPUT)))

UTIL = util

MACRO = macros.def

.PHONY: document

document: doc $(CONF) $(MATHDEF) $(INDEX)

.PHONY: setup

setup: document
	cp -r doc $(SPHINXDIR)
	mkdir -p $(BUILDDIR)

.PHONY: splice

splice: setup 
	cd $(SPHINXDIR) && $(EXE) ../$(SPECDIR)/*.$(EXT) --sideconditions --animate --splice-sphinx -o $(SPLICEOUTPUT) -p $(SPLICEINPUT)&& mv $(MACRO) $(UTIL)
	rm -f $(INPUTFILES)
	cd ..

.PHONY: html

html: splice
	$(SPHINXBUILD) -b html -d $(SPHINXDIR)/doctrees $(SPHINXDIR) $(BUILDDIR)/html
	@echo "html finished; the HTML pages are in $(BUILDDIR)/html."

.PHONY: pdf

pdf: latexpdf 
	cp $(BUILDDIR)/latex/*.pdf .
	@echo "pdf finished; the PDF files are in the current directory."

.PHONY: latexpdf

latexpdf: splice
	$(SPHINXBUILD) -b latex -d $(SPHINXDIR)/doctrees $(SPHINXDIR) $(BUILDDIR)/latex
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS=" </dev/null" all-pdf >$(BUILDDIR)/latex/LOG 2>&1 || cat $(BUILDDIR)/latex/LOG
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

# Cleanup

.PHONY: clean

clean:
	dune clean
	rm -rf $(SPHINXDIR)
	rm -f *.pdf
