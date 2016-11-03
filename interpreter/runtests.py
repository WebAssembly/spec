#!/usr/bin/env python

from __future__ import print_function
import os
import os.path
import unittest
import subprocess
import glob
import sys


inputDir = "test"
expectDir = "expected-output"
outputDir = "output"


def usage():
  print("Usage: runtests.py [--wasm <wasm-path>] [--js <js-path>] [file ...]", file=sys.stderr)
  exit(1)

def param(args, name, default):
  if name not in args:
	return default
  pos = args.index(name)
  args.pop(pos)
  if pos == len(args):
    usage()
  return args.pop(pos)

wasmCommand = os.path.abspath(param(sys.argv, '--wasm', "./wasm"))
jsCommand = param(sys.argv, '--js', None)
jsCommand = os.path.abspath(jsCommand) if jsCommand != None else None


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

  def _runTestFile(self, inputPath):
    dir, file = os.path.split(inputPath)
    outputPath = os.path.join(dir, os.path.join(outputDir, file))
    expectPath = os.path.join(dir, os.path.join(expectDir, file))

    # Run original file
    expectedExitCode = 1 if ".fail." in file else 0
    logPath = auxFile(outputPath + ".log")
    self._runCommand(("%s '%s'") % (wasmCommand, inputPath), logPath, expectedExitCode)
    self._compareFile(expectPath + ".log", logPath)

    if expectedExitCode != 0:
      return

    # Convert to binary and validate again
    wasmPath = auxFile(outputPath + ".bin.wast")
    logPath = auxFile(wasmPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (wasmCommand, inputPath, wasmPath))
    self._runCommand(("%s -d '%s'") % (wasmCommand, wasmPath), logPath)

    # Convert back to text and validate again
    wastPath = auxFile(wasmPath + ".wast")
    logPath = auxFile(wastPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (wasmCommand, wasmPath, wastPath))
    self._runCommand(("%s -d '%s' ") % (wasmCommand, wastPath), logPath)

    # Convert back to binary once more and compare
    wasm2Path = auxFile(wastPath + ".bin.wast")
    logPath = auxFile(wasm2Path + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (wasmCommand, wastPath, wasm2Path))
    self._runCommand(("%s -d '%s'") % (wasmCommand, wasm2Path), logPath)
    # TODO: The binary should stay the same, but OCaml's float-string conversions are inaccurate.
    # Once we upgrade to OCaml 4.03, use sprintf "%s" for printing floats.
    # self._compareFile(wasmPath, wasm2Path)

    # Convert to JavaScript
    jsPath = auxFile(outputPath.replace(".wast", ".js"))
    logPath = auxFile(jsPath + ".log")
    self._runCommand(("%s -d '%s' -o '%s'") % (wasmCommand, inputPath, jsPath))
    if jsCommand != None:
      self._runCommand(("%s '%s'") % (jsCommand, jsPath))


if __name__ == "__main__":
  if not os.path.exists(wasmCommand):
    print("Wasm interpreter not found: %s" % wasmCommand, file=sys.stderr)
    exit(1)
  if jsCommand != None and not os.path.exists(jsCommand):
    print("JS interpreter not found: %s" % jsCommand, file=sys.stderr)
    exit(1)

  try:
    os.makedirs(outputDir)
  except OSError:
    pass

  inputFiles = glob.glob(os.path.join(inputDir, '*.wast')) if len(sys.argv) <= 1 else sys.argv[1:]
  sys.argv = sys.argv[:1]

  for fileName in inputFiles:
    setattr(RunTests, fileName, lambda self, file=fileName: self._runTestFile(file))
  unittest.main()
