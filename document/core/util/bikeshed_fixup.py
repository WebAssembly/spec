#! /usr/bin/env python
# -*- coding: latin-1 -*-

import os
import sys


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))


def Main():
  data = open(sys.argv[1]).read()

  # Don't add more than 3 levels to TOC.
  data = data.replace('<h5>', '<h5 class="no-toc">')

  # TODO(bradnelson/tabatkins): Fix when bikeshed can do letters.
  # Don't number the Appendix.
  data = data.replace(
      '<h2>Appendix</h2>',
      '<h2 class="no-num">A Appendix</h2>')
  number = 1
  for section in [
      'Embedding',
      'Implementation Limitations',
      'Validation Algorithm',
      'Custom Sections',
      'Soundness',
      'Index of Types',
      'Index of Instructions',
      'Index of Semantic Rules']:
    data = data.replace(
        '<h3>' + section + '</h3>',
        '<h3>A.' + str(number) + ' ' + section + '</h3>')
    number += 1


  # Drop spurious navigation.
  data = data.replace(
"""
    <div class="related" role="navigation" aria-label="related navigation">
      <h3>Navigation</h3>
      <ul>
        <li class="nav-item nav-item-0"><a href="index.html#document-index">WebAssembly 1.0</a> &#187;</li> 
      </ul>
    </div>""", '')

  sys.stdout.write(data)


Main()
