#! /usr/bin/env python
# -*- coding: latin-1 -*-

import os
import sys


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))


def Main():
  data = open(sys.argv[1]).read()
  data = data.replace('<h5>', '<h5 class="no-toc">')
  sys.stdout.write(data)


Main()
