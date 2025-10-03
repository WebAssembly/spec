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
	(cd ..; make publish-js-api)

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

.PHONY: WD-tar
WD-tar:
	bikeshed echidna --just-tar index.bs $(BUILDDIR)/html/index.html
	mv test.tar $(BUILDDIR)/WD.tar
	@echo "Built $(BUILDDIR)/WD.tar."

.PHONY: WD-echidna
WD-echidna:
	@if [ -z $(W3C_USERNAME) ] || \
	    [ -z $(W3C_PASSWORD) ] || \
			[ -z $(DECISION_URL) ] ; then \
		echo "Must provide W3C_USERNAME, W3C_PASSWORD, and DECISION_URL environment variables"; \
		exit 1; \
	fi
	bikeshed echidna index.bs --u $(W3C_USERNAME) --p $(W3C_PASSWORD) --d $(DECISION_URL)
