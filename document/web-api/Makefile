W3C_STATUS    = ED
BUILDDIR      = _build
STATICDIR     = _static
DOWNLOADDIR   = _download
NAME          = WebAssembly
DECISION_URL  = https://github.com/WebAssembly/meetings/blob/main/main/2024/WG-06-12.md
TAR           = tar
DEADLINE      = $(shell date -d "+30 days" +%Y-%m-%d 2>/dev/null || date -v +30d +%Y-%m-%d)
ECHIDNA_DRYRUN = true

.PHONY: all
all:
	mkdir -p $(BUILDDIR)/html
	bikeshed spec --md-status=$(W3C_STATUS) --md-deadline=$(DEADLINE) index.bs $(BUILDDIR)/html/index.html
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

.PHONY: WD-tar
# macOS tar has no “--transform” option (only GNU tar does), so on macOS,
# do “brew install tar” & run “make” like this: “TAR=gtar make -e WD-tar”
WD-tar: all
	$(TAR) -C $(BUILDDIR)/html --transform="s/index.html/Overview.html/" -cf $(BUILDDIR)/WD.tar index.html
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
		-F "decision=$(DECISION_URL)" \
		-F "dry-run=$(ECHIDNA_DRYRUN)" | tee $(BUILDDIR)/WD-echidna-id.txt
	python3 ../util/check-echidna-status.py $(BUILDDIR)
	@echo
	@echo "Published $(W3C_STATUS). Check its status at https://labs.w3.org/echidna/api/status?id=`cat $(BUILDDIR)/WD-echidna-id.txt`"

.PHONY: WD-echidna-CI
WD-echidna-CI: WD-tar
	@if [ -z $(W3C_ECHIDNA_TOKEN_WEBAPI) ] || \
			[ -z $(DECISION_URL) ] ; then \
		echo "Must provide W3C_ECHIDNA_TOKEN_WEBAPI and DECISION_URL environment variables"; \
		exit 1; \
	fi
	curl 'https://labs.w3.org/echidna/api/request' \
		-F "tar=@$(BUILDDIR)/WD.tar" \
		-F "token=$(W3C_ECHIDNA_TOKEN_WEBAPI)" \
		-F "decision=$(DECISION_URL)" \
		-F "dry-run=$(ECHIDNA_DRYRUN)" | tee $(BUILDDIR)/WD-echidna-id.txt
	python3 ../util/check-echidna-status.py $(BUILDDIR)
	@echo
	@echo "Published $(W3C_STATUS). Check its status at https://labs.w3.org/echidna/api/status?id=`cat $(BUILDDIR)/WD-echidna-id.txt`"
