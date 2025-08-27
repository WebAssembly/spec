SHARED_MEM=false

# SpiderMonkey shell
#JSSHELL=~/mozilla-central/js/src/build-debug/dist/bin/js -e "const WITH_SHARED_MEMORY=$(SHARED_MEM); const INDEX_TYPE='$(INDEX_TYPE)';" -f common.js

# Node.js
JSSHELL=./noderun.sh $(SHARED_MEM)

TARGETDIR=../core/bulk-memory
TARGETDIR64=../core/memory64

WAST_FILES = memory_copy memory_init memory_fill table_copy table_init
TARGETS32 = $(patsubst %,$(TARGETDIR)/%.wast,$(WAST_FILES))
TARGETS64 = $(patsubst %,$(TARGETDIR64)/%64.wast,$(WAST_FILES))

.PHONY: all

all: $(TARGETS32) $(TARGETS64)

$(TARGETDIR)/%.wast: generate_%.js common.js Makefile
	$(JSSHELL) i32 $< > $@

$(TARGETDIR64)/%64.wast: generate_%.js common.js Makefile
	$(JSSHELL) i64 $< > $@
