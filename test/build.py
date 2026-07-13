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

# Preconditions.
def ensure_remove_dir(path):
    """Remove `path` if it exists."""
    if os.path.exists(path):
        shutil.rmtree(path)

def ensure_empty_dir(path):
    """Create an empty directory at `path`, removing any existing one."""
    ensure_remove_dir(path)
    os.mkdir(path)

def compile_wasm_interpreter():
    """Compile the wasm interpreter; exit the process if this fails."""
    print("Recompiling the wasm interpreter...")
    result = run('make', '-C', INTERPRETER_DIR, 'clean', 'default')
    if result.returncode != 0:
        print("Couldn't recompile wasm spec interpreter. Output follows:")
        print(result.stdout)
        sys.exit(1)
    print("Done!")

def ensure_wasm_executable():
    """
    Ensure we have built the wasm spec interpreter; exit the process if it doesn't exist.
    """
    result = run(WASM_EXEC, '-v', '-e', '')
    if result.returncode != 0:
        print("Unable to run the wasm executable. Output follows:")
        print(result.stdout)
        sys.exit(1)

# JS harness.
def convert_one_wast_file(inputs):
    """Translate a `.wast` to JS using the wasm spec interpreter."""
    wast_file, js_file = inputs
    print('Compiling {} to JS...'.format(wast_file))
    return run(WASM_EXEC, wast_file, '-j', '-o', js_file)

def convert_wast_to_js(out_js_dir):
    """
    Compile the wast files in `WAST_TESTS_DIR` to JS and store the results in `out_js_dir`,
    which is cleared first.

    This excludes the tests with `.fail.` in the file name.

    The compilation happens in parallel, using 8 processes.
    """

    ensure_empty_dir(out_js_dir)
    for d in WAST_TEST_SUBDIRS:
        ensure_empty_dir(os.path.join(out_js_dir, d))

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
    """
    Copy harness files into `out_js_dir/harness`.

    This always includes the {sync,async}_index.js files,
    and the testharness files if `include_harness` is true.
    """
    harness_dir = os.path.join(out_js_dir, 'harness')
    ensure_empty_dir(harness_dir)

    print('Copying JS test harness to the JS out dir...')
    for js_file in glob.glob(os.path.join(HARNESS_DIR, '*')):
        if os.path.basename(js_file) in HARNESS_FILES and not include_harness:
            continue
        shutil.copy(js_file, harness_dir)

def build_js(out_js_dir):
    """Entry point for building all the JS tests."""
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
    """Replace the file at `js_file` with one that wraps the code in an IIFE that also calls
    `reinitializeRegistry()` after the test."""
    test_func_name = os.path.basename(js_file).replace('.', '_').replace('-', '_')

    content = "(function {}() {{\n".format(test_func_name)
    with open(js_file, 'r') as f:
        content += f.read()
    content += "reinitializeRegistry();\n})();\n"

    with open(js_file, 'w') as f:
        f.write(content)

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
    """
    Entry point for building the HTML versions of the tests.

    We assume the tests will be run using a global copy of `testharness.js`, served from
    `/resources` as happens in web-platform-tests.
    """
    print("Building HTML tests...")

    js_html_dir = os.path.join(html_dir, 'js')

    tests = convert_wast_to_js(js_html_dir)
    copy_harness_files(js_html_dir, False)

    print('Building WPT tests from JS tests...')
    build_html_from_js(tests, html_dir, use_sync)

    print("Done building HTML tests.")


def build_any_js(output_dir, use_sync):
    """
    Entry point for building the `.any.js` versions of the tests.
    """
    print("Building `.any.js` tests...")

    tests = convert_wast_to_js(output_dir)

    index_path = "sync_index.js" if use_sync else "async_index.js"
    for js_file in tests:
        harness_path = os.path.relpath(os.path.join(output_dir, "harness"), os.path.dirname(js_file))
        with open(js_file, "r") as f:
            content = f.read()

        with open(js_file.replace(".js", ".any.js"), "w") as f:
            f.write(f"""\
// META: script={harness_path}/{index_path}
// META: global=window
""")
            f.write(content)

        os.remove(js_file)

    copy_harness_files(output_dir, False)

    print("Done building `.any.js` tests.")


# Front page harness.
def build_front_page(out_dir, use_sync):
    """Entry point for building a single HTML file including all of the tests."""
    print('Building front page containing all the HTML tests...')

    js_out_dir = os.path.join(out_dir, 'js')

    tests = convert_wast_to_js(js_out_dir)
    for js_file in tests:
        wrap_single_test(js_file)
    copy_harness_files(js_out_dir, True)

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

    parser.add_argument('--any-js',
                        dest="any_js_dir",
                        help="Relative path to the output directory for the `.any.js` Web Platform tests.",
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
    any_js_dir = args.any_js_dir
    front_dir = args.front_dir

    if all(d is None for d in [js_dir, html_dir, any_js_dir, front_dir]):
        print('At least one mode must be selected.\n')
        parser.print_help()
        sys.exit(1)

    if args.compile:
        compile_wasm_interpreter()

    ensure_wasm_executable()

    if js_dir is not None:
        build_js(js_dir)

    if html_dir is not None:
        ensure_empty_dir(html_dir)
        for d in WAST_TEST_SUBDIRS:
            ensure_empty_dir(os.path.join(html_dir, d))
        build_html(html_dir, args.use_sync)

    if any_js_dir is not None:
        build_any_js(any_js_dir, args.use_sync)

    if front_dir is not None:
        ensure_empty_dir(front_dir)
        build_front_page(front_dir, args.use_sync)

    print('Done!')
