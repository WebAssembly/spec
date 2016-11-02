#!/usr/bin/env python

import os
import os.path
import unittest
import subprocess
import glob
import sys

# Set to run tests through JS as well
jsCommand = ""

inputDir = "test/"
expectDir = inputDir + "expected-output/"
outputDir = inputDir + "output/"

def auxFile(path):
    try:
      os.remove(path)
    except OSError:
      pass
    return path

class RunTests(unittest.TestCase):
  def _runCommand(self, command, logPath = None, expectedExitCode = 0):
    out = None if logPath is None else file(logPath, 'w+')

    try:
      exitCode = subprocess.call(command, shell=True, stdout=out, stderr=subprocess.STDOUT)
      self.assertEqual(expectedExitCode, exitCode, "failed with exit code %i (expected %i) for %s" % (exitCode, expectedExitCode, command))
    finally:
      if logPath is not None:
        out.close()

  def _compareFile(self, expectedFile, actualFile):
    try:
      with open(expectedFile) as expected:
        with open(actualFile) as actual:
          expectedText = expected.read()
          actualText = actual.read()
          self.assertEqual(expectedText, actualText)
    except IOError:
      pass

  def _runTestFile(self, shortName, inputPath, interpreterPath):
    outputPath = inputPath.replace(inputDir, outputDir)
    expectPath = inputPath.replace(inputDir, expectDir)

    # Run original file
    expectedExitCode = 1 if ".fail." in inputPath else 0
    logPath = auxFile(outputPath + ".log")
    self._runCommand(("%s '%s'") % (interpreterPath, inputPath), logPath, expectedExitCode)
    self._compareFile(expectPath + ".log", logPath)

    if expectedExitCode != 0:
      return

    # Convert to binary and validate again
    wasmPath = auxFile(outputPath + ".bin.wast")
    logPath = auxFile(wasmPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (interpreterPath, inputPath, wasmPath))
    self._runCommand(("%s -d '%s'") % (interpreterPath, wasmPath), logPath)

    # Convert back to text and validate again
    wastPath = auxFile(wasmPath + ".wast")
    logPath = auxFile(wastPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (interpreterPath, wasmPath, wastPath))
    self._runCommand(("%s -d '%s' ") % (interpreterPath, wastPath), logPath)

    # Convert back to binary once more and compare
    wasm2Path = auxFile(wastPath + ".bin.wast")
    logPath = auxFile(wasm2Path + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (interpreterPath, wastPath, wasm2Path))
    self._runCommand(("%s -d '%s'") % (interpreterPath, wasm2Path), logPath)
    # TODO: The binary should stay the same, but OCaml's float-string conversions are inaccurate.
    # Once we upgrade to OCaml 4.03, use sprintf "%s" for printing floats.
    # self._compareFile(wasmPath, wasm2Path)

    # Convert to JavaScript
    jsPath = auxFile(outputPath.replace(".wast", ".js"))
    logPath = auxFile(jsPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (interpreterPath, inputPath, jsPath))
    if jsCommand != "":
      self._runCommand(("%s '%s'") % (jsCommand, jsPath))

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
  unittest.main()
