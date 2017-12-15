# WebAssembly Specifications

This directory contains the source code for the WebAssembly spec documents, as served from the [webassembly.github.io/spec](https://webassembly.github.io/spec) pages.
It uses [Sphinx](http://www.sphinx-doc.org/) and [Bikeshed](https://github.com/tabatkins/bikeshed).

To install Sphinx:
```
pip install sphinx
```

To install Bikeshed, see the instructions [here](https://tabatkins.github.io/bikeshed/#installing).


To build everything locally (result appears in `_build/`):
```
make all
```

To build everything and update [webassembly.github.io/spec](https://webassembly.github.io/spec) with it:
```
make publish
```
Please make sure to only use that once a change has approval.
