#!/usr/bin/env python

import os
import os.path
import unittest
import subprocess
import glob
import sys

class RunTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName, interpreterPath):
    print("\n// %s" % shortName)
    sys.stdout.flush()
    logPath = fileName.replace("test/", "test/output/").replace(".wasm", ".wasm.log")
    commandStr = ("%s %s | tee %s") % (interpreterPath, fileName, logPath)
    print("// %s" % commandStr)
    sys.stdout.flush()
    exitCode = subprocess.call(commandStr, shell=True)
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

def generate_test_case(rec):
  return lambda self : self._runTestFile(*rec)


def generate_test_cases(cls, interpreterPath, files):
  for fileName in files:
    attrName = fileName
    rec = (attrName, fileName, interpreterPath)
    testCase = generate_test_case(rec)
    setattr(cls, attrName, testCase)

def rebuild_interpreter():
  interpreterPath = os.path.abspath("src/main.native")

  print("// building main.native")
  sys.stdout.flush()
  exitCode = subprocess.call(["ocamlbuild", "-libs", "bigarray", "main.native"], cwd=os.path.abspath("src"))
  if (exitCode != 0):
    raise Exception("ocamlbuild failed with exit code %i" % exitCode)

  return interpreterPath

if __name__ == "__main__":
  try:
    os.makedirs("test/output/")
  except OSError:
    pass

  interpreterPath = rebuild_interpreter()
  testFiles = glob.glob("test/*.wasm")
  generate_test_cases(RunTests, interpreterPath, testFiles)
  unittest.main()