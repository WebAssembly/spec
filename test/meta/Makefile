SHARED_MEM=false

# SpiderMonkey shell
#JSSHELL=~/mozilla-central/js/src/build-debug/dist/bin/js -e 'const WITH_SHARED_MEMORY=$(SHARED_MEM);' -f common.js

# Node.js
JSSHELL=./noderun.sh $(SHARED_MEM)

TARGETDIR=../core

.PHONY: all

all: $(TARGETDIR)/memory_copy.wast \
	$(TARGETDIR)/memory_init.wast \
	$(TARGETDIR)/memory_fill.wast \
	$(TARGETDIR)/table_copy.wast \
	$(TARGETDIR)/table_init.wast

$(TARGETDIR)/memory_copy.wast: generate_memory_copy.js common.js Makefile
	$(JSSHELL) $< > $@

$(TARGETDIR)/memory_init.wast: generate_memory_init.js common.js Makefile
	$(JSSHELL) $< > $@

$(TARGETDIR)/memory_fill.wast: generate_memory_fill.js common.js Makefile
	$(JSSHELL) $< > $@

$(TARGETDIR)/table_copy.wast: generate_table_copy.js common.js Makefile
	$(JSSHELL) $< > $@

$(TARGETDIR)/table_init.wast: generate_table_init.js common.js Makefile
	$(JSSHELL) $< > $@
