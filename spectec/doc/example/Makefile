NAME = NanoWasm
SPECTECDIR = ../..
SPECTEC = $(SPECTECDIR)/watsup
SPHINX = sphinx-build
BUILDDIR = _build


# Menu

all:
	@echo "Targets available:"
	@echo "make rst      (run SpecTec)"
	@echo "make html     (run SpecTec + Sphinx)"
	@echo "make latex    (run SpecTec + Sphinx)"
	@echo "make pdf      (run SpecTec + Sphinx + Latex)"
	@echo "make out      (run everything and update output directory)"
	@echo "make spectec  (build updir SpecTec)"


# Building SpecTec itself

spectec:
	(cd $(SPECTECDIR); make exe >/dev/null)


# Running SpecTec

RSTFILE = $(NAME).rst

rst: $(RSTFILE)

$(RSTFILE).rst: $(NAME).rst.in $(NAME).watsup
	$(SPECTEC) $(NAME).watsup --splice-sphinx -p $< -o $@


# Running Sphinx

HTMLFILE = $(BUILDDIR)/html/$(NAME).html
TEXFILE = $(BUILDDIR)/latex/$(NAME).tex

html: $(HTMLFILE)

$(HTMLFILE): $(RSTFILE) conf.py
	$(SPHINX) -b html -d $(BUILDDIR)/doctrees . $(BUILDDIR)/html

latex: $(TEXFILE)

$(TEXFILE): $(RESTFILE) conf.py
	$(SPHINX) -b latex -d $(BUILDDIR)/doctrees . $(BUILDDIR)/latex


# Running Latex

PDFFILE = $(BUILDDIR)/latex/$(NAME).pdf

pdf: $(PDFFILE)

$(PDFFILE): $(TEXFILE)
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS=" </dev/null" all-pdf


# Copying to output directory

out: $(PDFFILE) $(HTMLFILE)
	cp -rf $^ output


# Clean-up

clean:
	rm $(NAME).rst
	rm -rf $(BUILDDIR)
