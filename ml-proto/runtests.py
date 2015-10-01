#!/usr/bin/env python

import os
import os.path
import unittest
import subprocess
import glob
import sys

class RunTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName, interpreterPath):
    logPath = fileName.replace("test/", "test/output/").replace(".wase", ".wase.log")
    try:
      os.remove(logPath)
    except OSError:
      pass

    commandStr = ("%s %s > %s") % (interpreterPath, fileName, logPath)
    exitCode = subprocess.call(commandStr, shell=True)
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

    try:
      expected = open(fileName.replace("test/", "test/expected-output/").replace(".wase", ".wase.log"))
    except IOError:
      # print("// WARNING: No expected output found for %s" % fileName)
      return

    output = open(logPath)

    with expected:
      with output:
        expectedText = expected.read()
        actualText = output.read()
        self.assertEqual(expectedText, actualText)

def generate_test_case(rec):
  return lambda self : self._runTestFile(*rec)


def generate_test_cases(cls, interpreterPath, files):
  for fileName in files:
    attrName = fileName
    rec = (attrName, fileName, interpreterPath)
    testCase = generate_test_case(rec)
    setattr(cls, attrName, testCase)

def find_interpreter(path):
  if not os.path.exists(path):
    raise Exception("Interpreter has not been built. Looked for %s" % path)

def rebuild_interpreter(path):
  print("// building %s" % path)
  sys.stdout.flush()
  exitCode = subprocess.call(["make"])
  if (exitCode != 0):
    raise Exception("make failed with exit code %i" % exitCode)
  if not os.path.exists(path):
    raise Exception("Interpreter has not been built. Looked for %s" % path)

if __name__ == "__main__":
  interpreterPath = os.path.abspath("./wasm")

  try:
    os.makedirs("test/output/")
  except OSError:
    pass

  shouldBuildInterpreter = ("--build" in sys.argv)
  if shouldBuildInterpreter:
    sys.argv.remove("--build")
    rebuild_interpreter(interpreterPath)
  else:
    find_interpreter(interpreterPath)

  testFiles = glob.glob("test/*.wase")
  generate_test_cases(RunTests, interpreterPath, testFiles)
  unittest.main()
