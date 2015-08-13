#!/usr/bin/env python

import os.path
import unittest
import subprocess
import glob

class RunTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName, interpreterPath):
    print("\n// %s" % shortName)
    exitCode = subprocess.call([interpreterPath, fileName])
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

def generate_test_cases(cls, interpreterPath, files):
  for fileName in files:
    absFileName = os.path.abspath(fileName)
    attrName = fileName
    testCase = lambda self : self._runTestFile(attrName, absFileName, interpreterPath)
    setattr(cls, attrName, testCase)

def rebuild_interpreter():
  interpreterPath = os.path.abspath("src/main.native")

  print("// building main.native")
  exitCode = subprocess.call(["ocamlbuild", "-libs", "bigarray", "main.native"], cwd=os.path.abspath("src"))
  if (exitCode != 0):
    raise Exception("ocamlbuild failed with exit code %i" % exitCode)

  return interpreterPath

if __name__ == "__main__":  
  interpreterPath = rebuild_interpreter()
  generate_test_cases(RunTests, interpreterPath, glob.glob("test/*.wasm"))
  unittest.main()