#!/usr/bin/env python

import os
import os.path
import unittest
import subprocess
import glob
import sys

def tempFile(path):
    try:
      os.remove(path)
    except OSError:
      pass
    return path

class RunTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName, interpreterPath):
    logPath = tempFile(fileName.replace("test/", "test/output/").replace(".wast", ".wast.log"))
    commandStr = ("%s %s > %s") % (interpreterPath, fileName, logPath)
    exitCode = subprocess.call(commandStr, shell=True)
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

    try:
      expected = open(fileName.replace("test/", "test/expected-output/").replace(".wast", ".wast.log"))
    except IOError:
      # print("// WARNING: No expected output found for %s" % fileName)
      return

    output = open(logPath)

    with expected:
      with output:
        expectedText = expected.read()
        actualText = output.read()
        self.assertEqual(expectedText, actualText)

class TranscodeTests(unittest.TestCase):
  def _runTestFile(self, shortName, fileName, interpreterPath):
    logPath = tempFile(fileName.replace("test/", "test/output/").replace(".wast", ".wast.log"))
    wasmPath = tempFile(fileName.replace("test/", "test/output/").replace(".wast", ".wast.wasm"))
    try:
      os.remove(wasmPath)
    except OSError:
      pass

    commandStr = ("%s -d %s -o %s") % (interpreterPath, fileName, wasmPath)
    exitCode = subprocess.call(commandStr, shell=True)
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

    commandStr = ("%s %s > %s") % (interpreterPath, wasmPath, logPath)
    exitCode = subprocess.call(commandStr, shell=True)
    self.assertEqual(0, exitCode, "test runner failed with exit code %i" % exitCode)

    # TODO: once s-expr output works, re-encode and compare

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

  testFiles = glob.glob("test/*.wast")
  generate_test_cases(RunTests, interpreterPath, testFiles)
  generate_test_cases(TranscodeTests, interpreterPath, testFiles)
  unittest.main()
