# General Options

extensions = ['sphinx.ext.mathjax']

source_suffix = ['.rst']
master_doc = 'NanoWasm'

name = 'NanoWasm'
project = 'NanoWasm'
title = 'NanoWasm Specification'
author = 'The SpecTec Team'
language = 'en'

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']


# Options for HTML output

html_theme = 'alabaster'
html_sidebars = {'**': []}

# https://www.sphinx-doc.org/en/master/usage/extensions/math.html#confval-mathjax3_config
# https://docs.mathjax.org/en/latest/web/configuration.html#configuration
# https://docs.mathjax.org/en/latest/options/input/tex.html#tex-maxbuffer
mathjax3_config = {
    'tex': {
      'maxBuffer': 30*1024,
      'macros': {
        'multicolumn': ['', 2]   # Bummer, MathJax can't handle multicolumn, ignore it
      }
    }
}


# Options for LaTeX output

latex_elements = {
   'papersize': 'a4paper',
   # Don't type-set cross references with emphasis.
   'preamble': '\\renewcommand\\sphinxcrossref[1]{#1}\n',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
  ( master_doc,
    name + '.tex',
    title,
    author,
    'manual'
  ),
]
