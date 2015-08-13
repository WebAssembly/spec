#!/usr/bin/env python

import os.path
import unittest
import subprocess
import glob

class RunTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName):
    absRunner   = os.path.abspath("src/main.native")
    print("\n// %s" % shortName)
    exitCode = subprocess.call([absRunner, fileName])
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

def generate_test_cases(cls, files):
  for fileName in files:
    absFileName = os.path.abspath(fileName)
    attrName = fileName
    testCase = lambda self : self._runTestFile(attrName, absFileName)
    setattr(cls, attrName, testCase)

if __name__ == "__main__":
  generate_test_cases(RunTests, glob.glob("test/*.wasm"))
  unittest.main()