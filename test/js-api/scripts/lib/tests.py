"""Test discovery, META parsing and shared helpers for the JS API scripts."""

import json
import re
from functools import cache
from pathlib import Path
from urllib.parse import quote

SCRIPTS = Path(__file__).resolve().parent.parent
TEST_DIR = SCRIPTS.parent
EXPECTATIONS = SCRIPTS / "expectations.json"
PINS = SCRIPTS / "browser-versions.json"
PREFIX = "/wasm/jsapi/"
HARNESS = "/resources/testharness.js"
BROWSERS = ("chrome", "firefox", "safari")
BROWSER_GLOBALS = ("window", "dedicatedworker")
VERSION = re.compile(r"\d+(?:\.\d+)*")


def version_key(version):
    return tuple(map(int, version.split(".")))


@cache
def test_metadata(path):
    globals_ = set(BROWSER_GLOBALS)
    helpers = []
    timeout = "normal"
    with path.open(encoding="utf-8-sig") as source:
        for line in source:
            line = line.strip()
            if line and not line.startswith("//"):
                break
            if not line.startswith("// META:"):
                continue
            match = re.fullmatch(r"// META:\s*(\w+)=(.+)", line)
            if not match:
                raise ValueError(f"{path.name}: invalid metadata: {line}")
            key, value = match.groups()
            if key == "global":
                globals_ = {name.strip() for name in value.split(",")}
                # Accept globals used by WPT even when this runner cannot launch them.
                unknown = globals_ - {*BROWSER_GLOBALS, "jsshell", "shadowrealm"}
                if unknown:
                    raise ValueError(
                        f"{path.name}: unsupported globals: {', '.join(sorted(unknown))}"
                    )
            elif key == "script":
                helpers.append(value)
            elif key == "timeout" and value == "long":
                timeout = value
            else:
                raise ValueError(f"{path.name}: unsupported metadata: {line}")
    return globals_, helpers, timeout


def supported_globals(path):
    globals_, _, _ = test_metadata(path)
    return [context for context in BROWSER_GLOBALS if context in globals_]


def discover_tests():
    sources = {
        path.relative_to(TEST_DIR).as_posix(): path
        for path in TEST_DIR.rglob("*.js")
        if not path.is_relative_to(SCRIPTS)
    }
    scripts = {PREFIX + quote(name): path for name, path in sources.items()}
    scripts[HARNESS] = TEST_DIR.parent / "harness" / "testharness.js"
    tests = {name: path for name, path in sources.items() if name.endswith(".any.js")}
    return scripts, tests


def unique_json_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"Duplicate key: {key}")
        result[key] = value
    return result


def read_json(path):
    return json.loads(
        path.read_text(encoding="utf-8"), object_pairs_hook=unique_json_keys
    )


def write_json(path, data):
    path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
