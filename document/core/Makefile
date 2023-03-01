# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = a4
BUILDDIR      = _build
STATICDIR     = _static
DOWNLOADDIR   = _download
NAME          = WebAssembly

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

.PHONY: usage
usage:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  pdf        to make standalone PDF file"
	@echo "  bikeshed   to make a bikeshed wrapped single large HTML file"
	@echo "  diff       to make a diff of the bikeshed HTML file with the latest TR"
	@echo "  WD-tar     generate tar file for updating the Working Draft"
	@echo "  WD-echidna publish the Working Draft tar file via Echidna"
	@echo "  all        to make all 3"
	@echo "  publish    to make all and push to gh-pages"
	@echo "  help       to see more options"

.PHONY: help
help:
	@echo "Usage: \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  pdf        to make standalone PDF file"
	@echo "  bikeshed   to make a bikeshed wrapped single large HTML file"
	@echo "  all        to make all 3"
	@echo "  publish    to make all and push to gh-pages"
	@echo "  dirhtml    to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  applehelp  to make an Apple Help Book"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  epub3      to make an epub3"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "  latexpdfja to make LaTeX files and run them through platex/dvipdfmx"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to make PO message catalogs"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  xml        to make Docutils-native XML files"
	@echo "  pseudoxml  to make pseudoxml-XML files for display purposes"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"
	@echo "  coverage   to run coverage check of the documentation (if enabled)"
	@echo "  dummy      to check syntax errors of document sources"

.PHONY: deploy
deploy:
	(cd ..; make dir-core deploy-core)

.PHONY: publish
publish: clean all deploy

.PHONY: publish-main
publish-main: clean main bikeshed-keep deploy

.PHONY: all
all:	pdf html bikeshed

.PHONY: main
main:	pdf html

# Dirty hack to avoid rebuilding the Bikeshed version for every push.
.PHONY: bikeshed-keep
bikeshed-keep:
	test -e $(BUILDDIR)/html/bikeshed || \
	  wget -r -nH --cut-dirs=2 -P $(BUILDDIR)/html --no-check-certificate \
	    https://webassembly.github.io/spec/core/bikeshed || \
	  echo Downloaded Bikeshed.


GENERATED = appendix/index-instructions.rst
.INTERMEDIATE: $(GENERATED)

%.rst: %.py
	(cd `dirname $@`; ./`basename $^`)

.PHONY: pdf
pdf:	$(GENERATED) latexpdf
	mkdir -p $(BUILDDIR)/html/$(DOWNLOADDIR)
	ln -f $(BUILDDIR)/latex/$(NAME).pdf $(BUILDDIR)/html/$(DOWNLOADDIR)/$(NAME).pdf


.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	rm -rf $(STATICDIR)

.PHONY: html
html: $(GENERATED)
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	for file in `ls $(BUILDDIR)/html/*.html`; \
	do \
	  sed s:BASEDIR:.:g <$$file >$$file.out; \
	  mv -f $$file.out $$file; \
	done
	for file in `ls $(BUILDDIR)/html/*/*.html`; \
	do \
	  sed s:BASEDIR:..:g <$$file >$$file.out; \
	  mv -f $$file.out $$file; \
	done
	@echo
	@echo "Build finished. The HTML pages are in `pwd`/$(BUILDDIR)/html/."

.PHONY: dirhtml
dirhtml: $(GENERATED)
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

.PHONY: singlehtml
singlehtml: $(GENERATED)
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml."

.PHONY: bikeshed
bikeshed: $(GENERATED)
	$(SPHINXBUILD) -b singlehtml -c util/bikeshed \
		$(ALLSPHINXOPTS) $(BUILDDIR)/bikeshed_singlehtml
	python util/bikeshed_fixup.py $(BUILDDIR)/bikeshed_singlehtml/index.html \
		>$(BUILDDIR)/bikeshed_singlehtml/index_fixed.html
	mkdir -p $(BUILDDIR)/bikeshed_mathjax/
	bikeshed spec index.bs $(BUILDDIR)/bikeshed_mathjax/index.html
	mkdir -p $(BUILDDIR)/html/bikeshed/
	(cd util/katex/ && yarn && yarn build && npm install --only=prod)
	python util/mathjax2katex.py $(BUILDDIR)/bikeshed_mathjax/index.html \
		>$(BUILDDIR)/html/bikeshed/index.html
	mkdir -p $(BUILDDIR)/html/bikeshed/katex/dist/
	cp -r util/katex/dist/* $(BUILDDIR)/html/bikeshed/katex/dist/
	patch -p0 $(BUILDDIR)/html/bikeshed/katex/dist/katex.css \
		< util/katex_fix.patch
	cp $(BUILDDIR)/bikeshed_singlehtml/_static/pygments.css \
		$(BUILDDIR)/html/bikeshed/
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/html/bikeshed/."

.PHONY: WD-tar
WD-tar: bikeshed
	@echo "Building tar file..."
	tar cvf \
		$(BUILDDIR)/WD.tar \
		--transform='s|$(BUILDDIR)/html/bikeshed/||' \
		--transform='s|index.html|Overview.html|' \
		$(BUILDDIR)/html/bikeshed/index.html \
		$(BUILDDIR)/html/bikeshed/pygments.css \
		$(BUILDDIR)/html/bikeshed/katex/dist/katex.css \
		$(BUILDDIR)/html/bikeshed/katex/dist/fonts
	@echo "Built $(BUILDDIR)/WD.tar."

.PHONY: WD-echidna
WD-echidna: WD-tar
	@if [ -z $(W3C_USERNAME) ] || \
	    [ -z $(W3C_PASSWORD) ] || \
			[ -z $(DECISION_URL) ] ; then \
		echo "Must provide W3C_USERNAME, W3C_PASSWORD, and DECISION_URL environment variables"; \
		exit 1; \
	fi
	curl 'https://labs.w3.org/echidna/api/request' \
		--user '$(W3C_USERNAME):$(W3C_PASSWORD)' \
		-F "tar=@$(BUILDDIR)/WD.tar" \
		-F "decision=$(DECISION_URL)" | tee $(BUILDDIR)/WD-echidna-id.txt
	@echo
	@echo "Published working draft. Check its status at https://labs.w3.org/echidna/api/status?id=`cat $(BUILDDIR)/WD-echidna-id.txt`"

.PHONY: diff
diff: bikeshed
	@echo "Downloading the old single-file html spec..."
	curl `grep "^TR" index.bs | cut -d' ' -f2` -o $(BUILDDIR)/html/bikeshed/old.html
	@echo "Done."
	@echo "Diffing new against old (go get a coffee)..."
	perl ../util/htmldiff.pl $(BUILDDIR)/html/bikeshed/old.html $(BUILDDIR)/html/bikeshed/index.html $(BUILDDIR)/html/bikeshed/diff.html
	@echo "Done. The diff is at $(BUILDDIR)/html/bikeshed/diff.html"

.PHONY: pickle
pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

.PHONY: json
json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

.PHONY: htmlhelp
htmlhelp:
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

.PHONY: qthelp
qthelp:
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/WebAssembly.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/WebAssembly.qhc"

.PHONY: applehelp
applehelp:
	$(SPHINXBUILD) -b applehelp $(ALLSPHINXOPTS) $(BUILDDIR)/applehelp
	@echo
	@echo "Build finished. The help book is in $(BUILDDIR)/applehelp."
	@echo "N.B. You won't be able to view it unless you put it in" \
	      "~/Library/Documentation/Help or install it in your application" \
	      "bundle."

.PHONY: devhelp
devhelp:
	$(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/WebAssembly"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/WebAssembly"
	@echo "# devhelp"

.PHONY: epub
epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."

.PHONY: epub3
epub3:
	$(SPHINXBUILD) -b epub3 $(ALLSPHINXOPTS) $(BUILDDIR)/epub3
	@echo
	@echo "Build finished. The epub3 file is in $(BUILDDIR)/epub3."

.PHONY: latex
latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

.PHONY: latexpdf
latexpdf:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through pdflatex..."
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS=" </dev/null" all-pdf >$(BUILDDIR)/latex/LOG 2>&1 || cat $(BUILDDIR)/latex/LOG
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

.PHONY: latexpdfja
latexpdfja:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through platex and dvipdfmx..."
	$(MAKE) -C $(BUILDDIR)/latex all-pdf-ja
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

.PHONY: text
text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

.PHONY: man
man:
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man."

.PHONY: texinfo
texinfo:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

.PHONY: info
info:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo."

.PHONY: gettext
gettext:
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) $(BUILDDIR)/locale
	@echo
	@echo "Build finished. The message catalogs are in $(BUILDDIR)/locale."

.PHONY: changes
changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

.PHONY: linkcheck
linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

.PHONY: doctest
doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

.PHONY: coverage
coverage:
	$(SPHINXBUILD) -b coverage $(ALLSPHINXOPTS) $(BUILDDIR)/coverage
	@echo "Testing of coverage in the sources finished, look at the " \
	      "results in $(BUILDDIR)/coverage/python.txt."

.PHONY: xml
xml:
	$(SPHINXBUILD) -b xml $(ALLSPHINXOPTS) $(BUILDDIR)/xml
	@echo
	@echo "Build finished. The XML files are in $(BUILDDIR)/xml."

.PHONY: pseudoxml
pseudoxml:
	$(SPHINXBUILD) -b pseudoxml $(ALLSPHINXOPTS) $(BUILDDIR)/pseudoxml
	@echo
	@echo "Build finished. The pseudo-XML files are in $(BUILDDIR)/pseudoxml."

.PHONY: dummy
dummy:
	$(SPHINXBUILD) -b dummy $(ALLSPHINXOPTS) $(BUILDDIR)/dummy
	@echo
	@echo "Build finished. Dummy builder generates no files."
