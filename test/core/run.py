#!/usr/bin/env python3

from __future__ import print_function
import argparse
import os
import os.path
import unittest
import subprocess
import glob
import sys


ownDir = os.path.dirname(os.path.abspath(sys.argv[0]))
inputDir = ownDir
interpDir = os.path.join(os.path.dirname(os.path.dirname(ownDir)), 'interpreter')
outputDir = os.path.join(inputDir, "_output")

parser = argparse.ArgumentParser()
parser.add_argument("--wasm", metavar="<wasm-command>", default=os.path.join(interpDir, "wasm"))
parser.add_argument("--js", metavar="<js-command>")
parser.add_argument("--generate-js-only", action='store_true')
parser.add_argument("--failfast", action='store_true')
parser.add_argument("--out", metavar="<out-dir>", default=outputDir)
parser.add_argument("file", nargs='*')
arguments = parser.parse_args()
sys.argv = sys.argv[:1]

main_test_files = glob.glob(os.path.join(inputDir, "*.wast"))
# SIMD test files are in a subdirectory.
simd_test_files = glob.glob(os.path.join(inputDir, "simd", "*.wast"))

wasmCommand = arguments.wasm
jsCommand = arguments.js
generateJsOnly = arguments.generate_js_only
outputDir = arguments.out
inputFiles = arguments.file if arguments.file else main_test_files + simd_test_files

if not os.path.exists(wasmCommand):
  sys.stderr.write("""\
Error: The executable '%s' does not exist.
Provide the correct path with the '--wasm' flag.

""" % (wasmCommand))
  parser.print_help()
  sys.exit(1)


class RunTests(unittest.TestCase):
  def _runCommand(self, command, logPath, expectedExitCode = 0):
    with open(logPath, 'w+') as out:
      exitCode = subprocess.call(command, shell=True, stdout=out, stderr=subprocess.STDOUT)
      self.assertEqual(expectedExitCode, exitCode, "failed with exit code %i (expected %i) for %s" % (exitCode, expectedExitCode, command))

  def _auxFile(self, path):
    if os.path.exists(path):
      os.remove(path)
    return path

  def _compareFile(self, expectFile, actualFile):
    if os.path.exists(expectFile):
      with open(expectFile) as expect:
        with open(actualFile) as actual:
          expectText = expect.read()
          actualText = actual.read()
          self.assertEqual(expectText, actualText)

  def _runTestFile(self, inputPath):
    dir, inputFile = os.path.split(inputPath)
    outputPath = os.path.join(outputDir, inputFile)

    # Generate JS first, then return early if we are only generating JS.
    jsPath = self._auxFile(outputPath.replace(".wast", ".js"))
    logPath = self._auxFile(jsPath + ".log")
    self._runCommand(('%s -d "%s" -o "%s"') % (wasmCommand, inputPath, jsPath), logPath)

    if generateJsOnly:
      return

    # Run original file
    expectedExitCode = 1 if ".fail." in inputFile else 0
    logPath = self._auxFile(outputPath + ".log")
    self._runCommand(('%s "%s"') % (wasmCommand, inputPath), logPath, expectedExitCode)

    if expectedExitCode != 0:
      return

    # Convert to binary and run again
    wasmPath = self._auxFile(outputPath + ".bin.wast")
    logPath = self._auxFile(wasmPath + ".log")
    self._runCommand(('%s -d "%s" -o "%s"') % (wasmCommand, inputPath, wasmPath), logPath)
    self._runCommand(('%s "%s"') % (wasmCommand, wasmPath), logPath)

    # Convert back to text and run again
    wastPath = self._auxFile(wasmPath + ".wast")
    logPath = self._auxFile(wastPath + ".log")
    self._runCommand(('%s -d "%s" -o "%s"') % (wasmCommand, wasmPath, wastPath), logPath)
    self._runCommand(('%s "%s"') % (wasmCommand, wastPath), logPath)

    # Convert back to binary once more and compare
    wasm2Path = self._auxFile(wastPath + ".bin.wast")
    logPath = self._auxFile(wasm2Path + ".log")
    self._runCommand(('%s -d "%s" -o "%s"') % (wasmCommand, wastPath, wasm2Path), logPath)
    self._compareFile(wasmPath, wasm2Path)

    # Convert back to text once more and compare
    wast2Path = self._auxFile(wasm2Path + ".wast")
    logPath = self._auxFile(wast2Path + ".log")
    self._runCommand(('%s -d "%s" -o "%s"') % (wasmCommand, wasm2Path, wast2Path), logPath)
    self._compareFile(wastPath, wast2Path)

    if jsCommand != None:
      self._runCommand(('%s "%s"') % (jsCommand, jsPath), logPath)


if __name__ == "__main__":
  if not os.path.exists(outputDir):
    os.makedirs(outputDir, exist_ok=True)
  for fileName in inputFiles:
    testName = 'test ' + os.path.basename(fileName)
    setattr(RunTests, testName, lambda self, file=fileName: self._runTestFile(file))
  unittest.main(failfast=arguments.failfast)
