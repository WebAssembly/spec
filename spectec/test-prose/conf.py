import os
import sys
pwd = os.path.abspath('.')
sys.path.insert(0, pwd)

name = 'WebAssembly Formal Specification'
project = 'prose'
title = 'Wasm Formal Specification'
extensions = [
  'sphinx.ext.mathjax',
  'mathdef'
]
master_doc = 'prose'

# Macros
rst_prolog = """
.. include:: /""" + os.path.abspath('.') + """/macros.def
"""

