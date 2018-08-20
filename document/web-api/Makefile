BUILDDIR      = _build
STATICDIR     = _static
DOWNLOADDIR   = _download
NAME          = WebAssembly

.PHONY: all
all:
	mkdir -p $(BUILDDIR)/html
	bikeshed spec index.bs $(BUILDDIR)/html/index.html
	@echo "Build finished. The HTML pages are in `pwd`/$(BUILDDIR)/html."

.PHONY: publish
publish:
	(cd ..; make publish-web-api)

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
	rm -rf $(STATICDIR)

.PHONY: diff
diff: all
	@echo "Downloading the old single-file html spec..."
	curl `grep "^TR" index.bs | cut -d' ' -f2` -o $(BUILDDIR)/html/old.html
	@echo "Done."
	@echo "Diffing new against old..."
	perl ../util/htmldiff.pl $(BUILDDIR)/html/old.html $(BUILDDIR)/html/index.html $(BUILDDIR)/html/diff.html
	@echo "Done. The diff is at $(BUILDDIR)/html/diff.html"
