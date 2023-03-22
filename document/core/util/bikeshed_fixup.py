#! /usr/bin/env python3
# -*- coding: latin-1 -*-

import os
import sys


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))


def Main():
  data = open(sys.argv[1]).read()

  # Make bikeshed happy
  # Apparently it can't handle empty line before DOCTYPE comment
  data = data.replace('\n<!DOCTYPE', '<!DOCTYPE')
  # Ensure newline before <pre>
  data = data.replace('<pre>', '\n<pre>')

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
      'Profiles',
      'Implementation Limitations',
      'Validation Algorithm',
      'Custom Sections',
      'Soundness',
      'Changes',
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
        <li class="nav-item nav-item-0"><a href="#">WebAssembly 1.1</a> &#187;</li>
        <li class="nav-item nav-item-this"><a href="">WebAssembly 1.1</a></li> 
      </ul>
    </div>  """, '')

  # Use bikeshed biblio references for unicode and IEEE754
  data = data.replace(
      """<a class="reference external" href="https://www.unicode.org/versions/latest/">Unicode</a>""",
      "[[!UNICODE]]"
  )

  data = data.replace(
      """<a class="reference external" href="https://ieeexplore.ieee.org/document/8766229">IEEE 754-2019</a>""",
      "[[!IEEE-754-2019]]"
  )

  sys.stdout.write(data)

Main()
