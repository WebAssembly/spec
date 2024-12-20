#!/usr/bin/env python3

import argparse
import sys
import os
import glob
import subprocess
import shutil
import multiprocessing as mp

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
INTERPRETER_DIR = os.path.join(SCRIPT_DIR, '..', 'interpreter')
WASM_EXEC = os.path.join(INTERPRETER_DIR, 'wasm')

WAST_TESTS_DIR = os.path.join(SCRIPT_DIR, 'core')
WAST_TEST_SUBDIRS = [os.path.basename(d) for d in
                     filter(os.path.isdir,
                            glob.glob(os.path.join(WAST_TESTS_DIR, '*')))]
HARNESS_DIR = os.path.join(SCRIPT_DIR, 'harness')

HARNESS_FILES = ['testharness.js', 'testharnessreport.js', 'testharness.css']
WPT_URL_PREFIX = '/resources'

# Helpers.
def run(*cmd):
    return subprocess.run(cmd,
                          stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT,
                          universal_newlines=True)
def call(*cmd):
    return subprocess.call(cmd,
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT,
                           universal_newlines=True)

# Preconditions.
def ensure_remove_dir(path):
    if os.path.exists(path):
        shutil.rmtree(path)

def ensure_empty_dir(path):
    ensure_remove_dir(path)
    os.mkdir(path)

def compile_wasm_interpreter():
    print("Recompiling the wasm interpreter...")
    result = call('make', '-C', INTERPRETER_DIR, 'clean', 'default')
    if result != 0:
        print("Couldn't recompile wasm spec interpreter")
        sys.exit(1)
    print("Done!")

def ensure_wasm_executable(path_to_wasm):
    """
    Ensure we have built the wasm spec interpreter.
    """
    result = call(path_to_wasm, '-v', '-e', '')
    if result != 0:
        print('Unable to run the wasm executable')
        sys.exit(1)

# JS harness.
def convert_one_wast_file(inputs):
    wast_file, js_file = inputs
    print('Compiling {} to JS...'.format(wast_file))
    return run(WASM_EXEC, wast_file, '-j', '-o', js_file)

def convert_wast_to_js(out_js_dir):
    """Compile all the wast files to JS and store the results in the JS dir."""

    inputs = []

    for wast_file in glob.glob(os.path.join(WAST_TESTS_DIR, '**/*.wast'),
                               recursive = True):
        # Don't try to compile tests that are supposed to fail.
        if '.fail.' in wast_file:
            continue

        js_subdir = os.path.basename(os.path.dirname(wast_file))
        if js_subdir == 'core':
            js_subdir = ''
        js_filename = os.path.basename(wast_file) + '.js'
        js_file = os.path.join(out_js_dir, js_subdir, js_filename)
        inputs.append((wast_file, js_file))

    pool = mp.Pool(processes=8)
    for result in pool.imap_unordered(convert_one_wast_file, inputs):
        if result.returncode != 0:
            print('Error when compiling to JS:')
            print(result.args)
            if result.stdout:
                # stderr is piped to stdout via `run`, so we only need to
                # worry about stdout
                print(result.stdout)
    return [js_file for (wast_file, js_file) in inputs]

def copy_harness_files(out_js_dir, include_harness):
    harness_dir = os.path.join(out_js_dir, 'harness')
    ensure_empty_dir(harness_dir)

    print('Copying JS test harness to the JS out dir...')
    for js_file in glob.glob(os.path.join(HARNESS_DIR, '*')):
        if os.path.basename(js_file) in HARNESS_FILES and not include_harness:
            continue
        shutil.copy(js_file, harness_dir)

def build_js(out_js_dir):
    print('Building JS...')
    convert_wast_to_js(out_js_dir)
    copy_harness_files(out_js_dir, False)
    print('Done building JS.')

# HTML harness.
HTML_HEADER = """<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>WebAssembly Web Platform Test</title>
    </head>
    <body>

        <script src="{WPT_PREFIX}/testharness.js"></script>
        <script src="{WPT_PREFIX}/testharnessreport.js"></script>
        <script src="{PREFIX}/{JS_HARNESS}"></script>

        <div id=log></div>
"""

HTML_BOTTOM = """
    </body>
</html>
"""

def wrap_single_test(js_file):
    test_func_name = os.path.basename(js_file).replace('.', '_').replace('-', '_')

    content = "(function {}() {{\n".format(test_func_name)
    with open(js_file, 'r') as f:
        content += f.read()
    content += "reinitializeRegistry();\n})();\n"

    with open(js_file, 'w') as f:
        f.write(content)

def build_html_js(out_dir):
    ensure_empty_dir(out_dir)
    for d in WAST_TEST_SUBDIRS:
        ensure_empty_dir(os.path.join(out_dir, d))
    copy_harness_files(out_dir, True)

    tests = convert_wast_to_js(out_dir)
    for js_file in tests:
        wrap_single_test(js_file)
    return tests

def build_html_from_js(tests, html_dir, use_sync):
    for js_file in tests:
        subdir = os.path.basename(os.path.dirname(js_file))
        js_prefix = '../js'
        if subdir == 'js':
            subdir = ''
            js_prefix = './js'
        js_filename = os.path.join(js_prefix, subdir, os.path.basename(js_file))
        html_filename = os.path.basename(js_file) + '.html'
        html_file = os.path.join(html_dir, subdir, html_filename)
        js_harness = "sync_index.js" if use_sync else "async_index.js"
        harness_dir = os.path.join(js_prefix, 'harness')

        with open(html_file, 'w+') as f:
            content = HTML_HEADER.replace('{PREFIX}', harness_dir) \
                                 .replace('{WPT_PREFIX}', '/resources') \
                                 .replace('{JS_HARNESS}', js_harness)
            content += '        <script src="' + js_filename + '"></script>'
            content += HTML_BOTTOM
            f.write(content)

def build_html(html_dir, use_sync):
    print("Building HTML tests...")

    js_html_dir = os.path.join(html_dir, 'js')

    tests = build_html_js(js_html_dir)

    print('Building WPT tests from JS tests...')
    build_html_from_js(tests, html_dir, use_sync)

    print("Done building HTML tests.")


# Front page harness.
def build_front_page(out_dir, js_dir, use_sync):
    print('Building front page containing all the HTML tests...')

    js_out_dir = os.path.join(out_dir, 'js')

    tests = build_html_js(js_out_dir)

    front_page = os.path.join(out_dir, 'index.html')
    js_harness = "sync_index.js" if use_sync else "async_index.js"
    with open(front_page, 'w+') as f:
        content = HTML_HEADER.replace('{PREFIX}', './js/harness') \
                             .replace('{WPT_PREFIX}', './js/harness')\
                             .replace('{JS_HARNESS}', js_harness)
        for js_file in tests:
            filename = os.path.basename(js_file)
            content += "        <script src=./js/{SCRIPT}></script>\n".replace('{SCRIPT}', filename)
        content += HTML_BOTTOM
        f.write(content)

    print('Done building front page!')

# Main program.
def process_args():
    parser = argparse.ArgumentParser(description="Helper tool to build the\
            multi-stage cross-browser test suite for WebAssembly.")

    parser.add_argument('--js',
                        dest="js_dir",
                        help="Relative path to the output directory for the pure JS tests.",
                        type=str)

    parser.add_argument('--html',
                        dest="html_dir",
                        help="Relative path to the output directory for the Web Platform tests.",
                        type=str)

    parser.add_argument('--front',
                        dest="front_dir",
                        help="Relative path to the output directory for the front page.",
                        type=str)

    parser.add_argument('--dont-recompile',
                        action="store_const",
                        dest="compile",
                        help="Don't recompile the wasm spec interpreter (by default, it is)",
                        const=False,
                        default=True)

    parser.add_argument('--use-sync',
                        action="store_const",
                        dest="use_sync",
                        help="Let the tests use the synchronous JS API (by default, it does not)",
                        const=True,
                        default=False)

    return parser.parse_args(), parser

if __name__ == '__main__':
    args, parser = process_args()

    js_dir = args.js_dir
    html_dir = args.html_dir
    front_dir = args.front_dir

    if front_dir is None and js_dir is None and html_dir is None:
        print('At least one mode must be selected.\n')
        parser.print_help()
        sys.exit(1)

    if args.compile:
        compile_wasm_interpreter()

    ensure_wasm_executable(WASM_EXEC)

    if js_dir is not None:
        ensure_empty_dir(js_dir)
        for d in WAST_TEST_SUBDIRS:
            ensure_empty_dir(os.path.join(js_dir, d))
        build_js(js_dir)

    if html_dir is not None:
        ensure_empty_dir(html_dir)
        for d in WAST_TEST_SUBDIRS:
            ensure_empty_dir(os.path.join(html_dir, d))
        build_html(html_dir, args.use_sync)

    if front_dir is not None:
        ensure_empty_dir(front_dir)
        build_front_page(front_dir, js_dir, args.use_sync)

    print('Done!')
