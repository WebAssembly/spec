#!/usr/bin/env python3

import glob
import os
import shutil
import subprocess

LOCAL_FILES = [
    "LICENSE.md",
    "README.md",

    # Currently doesn't pass the stability checker in wpt.
    "limits.any.js",
]


def copy_from_local(local_dir, out):
    for local_file in LOCAL_FILES:
        shutil.copy(os.path.join(local_dir, local_file), out)


def copy_from_upstream(upstream, out):
    upstream = os.path.abspath(upstream)
    paths = glob.glob(os.path.join(upstream, "**", "*.js"), recursive=True)
    for path in paths:
        relpath = os.path.relpath(path, upstream)

        # Tests for proposals that have not merged here yet.
        if ".tentative" in relpath:
            continue

        # Requires `fetch()` and various wpt infrastructure.
        if os.path.basename(relpath) == "idlharness.any.js":
            continue

        dest = os.path.join(out, relpath)
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        shutil.copy(path, dest)


def main(upstream):
    local_dir = os.path.join("test", "js-api")
    scratch = os.path.join("test", "js-api-temp")
    os.mkdir(scratch)
    copy_from_local(local_dir, scratch)
    copy_from_upstream(os.path.join(upstream, "wasm", "jsapi"), scratch)
    shutil.rmtree(local_dir)
    os.rename(scratch, local_dir)
    subprocess.check_call(["git", "add", local_dir])


if __name__ == "__main__":
    import sys
    main(*sys.argv[1:])
