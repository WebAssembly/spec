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

## Step by step guide to building the spec

Make sure this repository was cloned with `--recursive`:

```
git clone --recursive https://github.com/WebAssembly/spec
```

If you have already cloned but without `--recursive`, you can delete and re-clone, or `cd` into `spec` and run:

```
git submodule update --init --recursive
```

The rest of these instructions assume you are in the root of this repository:

```
cd spec
```

You will need `python3.7`, and `pip`. `pip` should come with Python, if not follow [these installation instructions for `pip`](https://pip.pypa.io/en/stable/installing/), or check your system package manager for `pip3`.

> Important: you will need the version of pip that works with `python3.7`.


Use something like [`pipenv`](https://pipenv.pypa.io/) to keep your system installation of Python clean.

```
pip install pipenv
pipenv --python 3.7
pipenv shell
```

Install Python dependencies:

```
pip install Sphinx==2.4.4
```

You can now build the [multi-page html document](https://webassembly.github.io/spec/core/):

```
cd document/core
make html
```

To build the [single-page W3C version](https://webassembly.github.io/spec/core/bikeshed/), there are more dependencies to install:

```
# cd back to root of git directory
git clone https://github.com/tabatkins/bikeshed.git
pip install --editable bikeshed
bikeshed update
```

You will also need `npm` and `yarn` for all the LaTeX goodness. `npm` might already be available on your system, you can also use something like [`nvm`](https://github.com/nvm-sh/nvm) to prevent messing with system packages:

```
npm install -g yarn
cd document/core
make bikeshed
```
