EXE = $(PWD)/../spectec/spectec


# Main targets

.PHONY: all ci

all: check-all spec test
ci: check-all spec-clean spec test-clean test


# Checking

check: check-3.0

check-1.0: $(EXE)
	$(EXE) wasm-1.0/*
	@echo Wasm 1.0 spec checked OK.
	@echo =========================

check-2.0: $(EXE)
	$(EXE) wasm-2.0/*
	@echo Wasm 2.0 spec checked OK.
	@echo =========================

check-3.0: $(EXE)
	$(EXE) wasm-3.0/*
	@echo Wasm 3.0 spec checked OK.
	@echo =========================

check-all: check-1.0 check-2.0 check-3.0
	@echo All Wasm specs checked OK.


# Build

spec:
	(cd ../document/core && make main)
	@echo Wasm 3.0 specs all built OK.
	@echo ============================

spec-pdf:
	(cd ../document/core && make pdf)
	@echo Wasm 3.0 PDF spec built OK.
	@echo ===========================

spec-html:
	(cd ../document/core && make html)
	@echo Wasm 3.0 HTML spec built OK.
	@echo ============================

spec-clean:
	(cd ../document/core && make clean)


# Full test

test:
	@((cd ../spectec/src && make test) || @echo Backend tests failed. Perhaps run `make testpromote` to update test output.)
	@echo Wasm 3.0 backend tests ran OK.
	@echo ==============================

test-clean:
	@(cd ../spectec/src && make clean)

testpromote:
	@(cd ../spectec/src && make testpromote)


# Executable

$(EXE): spectec

spectec:
	@(cd ../spectec && make exe)
