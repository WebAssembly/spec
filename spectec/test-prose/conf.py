import os
import sys
pwd = os.path.abspath('.')
sys.path.insert(0, pwd)

name = 'WebAssembly Specification'
project = 'WebAssembly'
title = 'WebAssembly Specification'
extensions = [
  'sphinx.ext.mathjax',
  'util.mathdef'
]
master_doc = 'index'

# Macros
rst_prolog = """
.. include:: /""" + pwd + """/util/macros.def
"""

