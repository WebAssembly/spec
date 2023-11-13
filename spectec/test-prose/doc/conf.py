import os
import sys
pwd = os.path.abspath('.')
sys.path.insert(0, pwd)

name = 'WebAssembly'
project = 'WebAssembly'
title = 'WebAssembly'
extensions = [
  'sphinx.ext.mathjax',
  'util.mathdef'
]
master_doc = 'index'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
   # The paper size ('a4paper' or 'letterpaper').
  'papersize': 'a4paper',

   # The font size ('10pt', '11pt' or '12pt').
  'pointsize': '10pt',

   # Additional stuff for the LaTeX preamble.
   # Don't type-set cross references with emphasis.
   'preamble': '\\renewcommand\\sphinxcrossref[1]{#1}\n',

   # Latex figure (float) alignment
  'figure_align': 'htbp',

   # Fancy chapters [Bjarne, Sonny, Lenny, Glenn, Conny, Rejne]
   'fncychap': '\\usepackage[Sonny]{fncychap}',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
  ( master_doc,
    name + '.tex',
    title,
    'Anonymous Authors',
    'manual'
  ),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
#
#latex_logo = logo

# For "manual" documents [part, chapter, or section].
#
latex_toplevel_sectioning = 'chapter'

# If true, show page references after internal links.
#
latex_show_pagerefs = False

# How to show URL addresses after external links [no, footnote, inline].
#
latex_show_urls = 'footnote'

# Documents to append as an appendix to all manuals.
#
# latex_appendices = []

# It false, will not define \strong, \code, \titleref, \crossref ... but only
# \sphinxstrong, ..., \sphinxtitleref, ... To help avoid clash with user added
# packages.
#
# latex_keep_old_macro_names = True

# If false, no module index is generated.
#
latex_domain_indices = False

# Macros
rst_prolog = """
.. include:: /""" + pwd + """/util/macros.def
"""
