#!/usr/bin/env python3
"""Run the Wasm JS API tests in a browser using Selenium."""

import argparse
import json
import re
from collections import Counter
from contextlib import nullcontext
from dataclasses import dataclass
from functools import cache
from html import escape
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Thread
from urllib.parse import quote, urljoin, urlsplit

SUITE = Path(__file__).resolve().parent
MANIFEST = SUITE / "expectations.json"
PREFIX = "/wasm/jsapi/"
HARNESS = "/resources/testharness.js"
BROWSERS = ("chrome", "firefox", "safari")
BROWSER_GLOBALS = ("window", "dedicatedworker")
# Match the timeout values in testharness.js.
HARNESS_TIMEOUT_SECONDS = {"normal": 10, "long": 60}
WEBDRIVER_GRACE_SECONDS = 5
# Manifest rules without a subtest name apply to the whole browser case.
WHOLE_CASE = None

REPORTER = """\
setup({output: false});
globalThis.wasmTestResult = new Promise(resolve => {
  let finished = false;
  function report(result) {
    if (finished) return;
    finished = true;
    document.getElementById("results").textContent = JSON.stringify(result, null, 2);
    resolve(result);
  }

  add_completion_callback((tests, harness) => {
    const harnessStatuses = ["OK", "ERROR", "TIMEOUT", "PRECONDITION_FAILED"];
    const subtestStatuses = ["PASS", "FAIL", "TIMEOUT", "NOTRUN", "PRECONDITION_FAILED"];
    report({
      status: harnessStatuses[harness.status] ?? `UNKNOWN (${harness.status})`,
      message: harness.message,
      subtests: tests.map(test => ({
        name: test.name,
        status: subtestStatuses[test.status] ?? `UNKNOWN (${test.status})`,
        message: test.message,
      })),
    });
  });

  // A missing classic script can leave the harness with only partial results.
  addEventListener("error", event => {
    if (event.target instanceof HTMLScriptElement) {
      report({status: "ERROR", message: `Could not load ${event.target.src}`, subtests: []});
    }
  }, true);
});
"""


@dataclass(frozen=True)
class BrowserCase:
    name: str
    context: str
    page_path: str
    timeout_seconds: int


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


def discover_suite():
    sources = {path.relative_to(SUITE).as_posix(): path for path in SUITE.rglob("*.js")}
    scripts = {PREFIX + quote(name): path for name, path in sources.items()}
    scripts[HARNESS] = SUITE.parent / "harness" / "testharness.js"
    tests = {name: path for name, path in sources.items() if name.endswith(".any.js")}
    return scripts, tests


def generate_test_pages(scripts, tests, selected, contexts, metadata_for):
    unknown = selected - tests.keys()
    if unknown:
        raise ValueError(f"Unknown tests: {', '.join(sorted(unknown))}")
    pages = {}
    cases = []
    for name in sorted(selected or tests):
        url = PREFIX + quote(name)
        stem = url.removesuffix(".js")
        globals_, helpers, timeout_mode = metadata_for(tests[name])
        sources = [urljoin(url, helper) for helper in helpers]
        for source in sources:
            if source not in scripts:
                raise ValueError(f"{name}: missing helper script {source}")
        sources.append(url)
        for context in contexts:
            if context not in globals_:
                continue
            if context == "window":
                page = stem + ".html"
                body = "\n".join(
                    f'<script src="{escape(source)}"></script>' for source in sources
                )
            else:
                page = stem + ".worker.html"
                worker = stem + ".worker.js"
                imports = ", ".join(map(json.dumps, [HARNESS, *sources]))
                # The worker signals completion explicitly. Its parent reports the results.
                pages[worker] = (
                    "text/javascript",
                    f"importScripts({imports});\ndone();",
                )
                body = f"<script>fetch_tests_from_worker(new Worker({json.dumps(worker)}));</script>"
            pages[page] = (
                "text/html",
                f"""<!doctype html>
<meta charset="utf-8">
<meta name="timeout" content="{timeout_mode}">
<title>{escape(name)} ({context})</title>
<pre id="results">Running {escape(name)} ({context})…</pre>
<script src="{HARNESS}"></script>
<script>{REPORTER}</script>
{body}
""",
            )
            cases.append(
                BrowserCase(
                    name=name,
                    context=context,
                    page_path=page,
                    timeout_seconds=HARNESS_TIMEOUT_SECONDS[timeout_mode],
                )
            )
    links = "\n".join(
        f'<li><a href="{escape(case.page_path)}">{escape(case.name)} ({case.context})</a></li>'
        for case in cases
    )
    pages["/"] = (
        "text/html",
        f"""<!doctype html>
<meta charset="utf-8">
<title>Wasm JS API tests</title>
<ul>{links}</ul>
""",
    )
    return pages, cases


def make_server(scripts, pages):
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            path = urlsplit(self.path).path
            if path in pages:
                content_type, content = pages[path]
                content = content.encode("utf-8")
            elif path in scripts:
                content_type, content = "text/javascript", scripts[path].read_bytes()
            else:
                self.send_error(404)
                return
            self.send_response(200)
            self.send_header("Content-Type", content_type + "; charset=utf-8")
            self.send_header("Content-Length", str(len(content)))
            # Cross-origin isolation makes SharedArrayBuffer available to the tests.
            self.send_header("Cross-Origin-Opener-Policy", "same-origin")
            self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
            self.end_headers()
            self.wfile.write(content)

        def log_message(self, format, *args):
            pass

    return ThreadingHTTPServer(("127.0.0.1", 0), Handler)


def unique_json_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"Duplicate key: {key}")
        result[key] = value
    return result


def load_expectations(path, tests, browser, metadata_for):
    by_test = json.loads(
        path.read_text(encoding="utf-8"), object_pairs_hook=unique_json_keys
    )
    if not isinstance(by_test, dict):
        raise ValueError("Expected an object keyed by test path")

    rules = {}
    required = {"browser", "expect", "reason"}
    allowed = required | {"context", "subtest"}
    for name, entries in by_test.items():
        if name not in tests:
            raise ValueError(f"Unknown test: {name}")
        if not isinstance(entries, list):
            raise ValueError(f"{name}: expected a list of rules")
        globals_, _, _ = metadata_for(tests[name])
        supported = [context for context in BROWSER_GLOBALS if context in globals_]
        for index, entry in enumerate(entries, 1):
            label = f"{name} rule {index}"
            if (
                not isinstance(entry, dict)
                or not required <= entry.keys() <= allowed
                or not all(
                    isinstance(value, str) and value.strip() for value in entry.values()
                )
            ):
                raise ValueError(
                    f"{label}: provide browser, expect, reason and optional context or subtest"
                )
            product, expect = entry["browser"], entry["expect"]
            subtest = entry.get("subtest", WHOLE_CASE)
            if product not in BROWSERS or expect not in ("fail", "skip"):
                raise ValueError(f"{label}: invalid browser or expectation")
            if expect == "skip" and subtest is not WHOLE_CASE:
                raise ValueError(f"{label}: skip applies to a whole test case")
            requested_context = entry.get("context")
            contexts = [
                context
                for context in supported
                if requested_context is None or context == requested_context
            ]
            if not contexts:
                raise ValueError(f"{label}: no supported browser context")
            for context in contexts:
                case_rules = rules.setdefault((product, name, context), {})
                if (
                    subtest in case_rules
                    or WHOLE_CASE in case_rules
                    or (subtest is WHOLE_CASE and case_rules)
                ):
                    raise ValueError(
                        f"{label}: overlapping rules for {product} [{context}]"
                    )
                case_rules[subtest] = (expect, entry["reason"])

    return {
        (name, context): case_rules
        for (product, name, context), case_rules in rules.items()
        if product == browser
    }


def create_driver(browser):
    try:
        from selenium import webdriver
        from selenium.common.exceptions import WebDriverException
    except ModuleNotFoundError as error:
        if error.name != "selenium":
            raise
        raise SystemExit(
            "Install Selenium with python -m pip install selenium"
        ) from error

    driver_class, options_class, headless = {
        "chrome": (webdriver.Chrome, webdriver.ChromeOptions, "--headless"),
        "firefox": (webdriver.Firefox, webdriver.FirefoxOptions, "-headless"),
        "safari": (webdriver.Safari, webdriver.SafariOptions, None),
    }[browser]
    options = options_class()
    if headless:
        options.add_argument(headless)

    try:
        return driver_class(options=options)
    except WebDriverException as error:
        raise SystemExit(f"Could not start {browser}: {error.msg}") from error


def read_result(driver, url, timeout_seconds):
    from selenium.common.exceptions import WebDriverException

    try:
        # Give the harness time to report its own timeout through WebDriver.
        webdriver_timeout = timeout_seconds + WEBDRIVER_GRACE_SECONDS
        driver.set_page_load_timeout(webdriver_timeout)
        driver.set_script_timeout(webdriver_timeout)
        driver.get(url)
        result = driver.execute_async_script("""\
const done = arguments[0];
Promise.resolve(window.wasmTestResult ?? null).then(done);
""")
        if result is None:
            raise ValueError("Test page did not initialize the harness")
        if result["status"] == "OK" and not result["subtests"]:
            raise ValueError("No subtests ran")
        return result
    except (WebDriverException, ValueError) as error:
        message = error.msg if isinstance(error, WebDriverException) else str(error)
        return {"status": "ERROR", "message": message, "subtests": []}


def evaluate_result(result, rules):
    """Apply failure expectations after the harness has completed successfully."""
    subtests = result["subtests"]
    failures = [test for test in subtests if test["status"] != "PASS"]
    diagnostics = [
        f"{test['status']} {test['name']}: {test['message']}" for test in failures
    ]
    if result["status"] != "OK":
        return "FAIL", [f"{result['status']}: {result['message']}", *diagnostics]
    # Only a subtest with status FAIL can satisfy a failure expectation.
    if WHOLE_CASE in rules:
        _, reason = rules[WHOLE_CASE]
        if not failures:
            return "XPASS", [f"Expected a failure: {reason}"]
        if all(test["status"] == "FAIL" for test in failures):
            return "XFAIL", [reason, *diagnostics]
        return "FAIL", diagnostics

    by_name = {test["name"]: test for test in subtests}
    missing = rules.keys() - by_name.keys()
    unexpected = [
        test
        for test in failures
        if test["name"] not in rules or test["status"] != "FAIL"
    ]
    expected_failures_that_passed = [
        name for name in rules if name in by_name and by_name[name]["status"] == "PASS"
    ]
    diagnostics += [f"Expected subtest missing: {name}" for name in sorted(missing)]
    diagnostics += [
        f"XPASS {name}: {rules[name][1]}" for name in expected_failures_that_passed
    ]
    # Missing expected subtests and unexpected failures take precedence over XPASS.
    if missing or unexpected:
        return "FAIL", diagnostics
    if expected_failures_that_passed:
        return "XPASS", diagnostics
    if rules:
        return "XFAIL", [
            f"{name}: {reason}" for name, (_, reason) in rules.items()
        ] + diagnostics
    return "PASS", []


def run_browser(browser, base_url, cases, expectations, json_path):
    results = []
    counts = Counter()
    selected = [
        (case, expectations.get((case.name, case.context), {})) for case in cases
    ]
    has_runnable_cases = any(
        rules.get(WHOLE_CASE, (None, None))[0] != "skip" for _, rules in selected
    )
    with create_driver(browser) if has_runnable_cases else nullcontext() as driver:
        version = (
            driver.capabilities.get("browserVersion", "unknown") if driver else None
        )
        print(
            f"{browser}: {len(cases)} selected cases"
            + (f" (version {version})" if version else ""),
            flush=True,
        )
        for case, rules in selected:
            expect, reason = rules.get(WHOLE_CASE, (None, None))
            if expect == "skip":
                result = {"status": "SKIP", "message": reason, "subtests": []}
                outcome, diagnostics = "SKIP", [reason]
            else:
                result = read_result(
                    driver, base_url + case.page_path, case.timeout_seconds
                )
                outcome, diagnostics = evaluate_result(result, rules)
            counts[outcome] += 1
            print(
                f"{outcome} {case.name} [{case.context}] ({len(result['subtests'])} subtests)",
                flush=True,
            )
            for diagnostic in diagnostics:
                print(f"  {diagnostic}", flush=True)
            results.append(
                {
                    "test": case.name,
                    "context": case.context,
                    **result,
                    "outcome": outcome,
                    "diagnostics": diagnostics,
                }
            )

    if json_path:
        report = {"browser": browser, "version": version, "results": results}
        json_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(
        ", ".join(
            f"{counts[status]} {status}"
            for status in ("PASS", "FAIL", "XFAIL", "XPASS", "SKIP")
        ),
        flush=True,
    )
    return int(counts["FAIL"] > 0 or counts["XPASS"] > 0)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--browser", choices=BROWSERS, default="firefox")
    parser.add_argument(
        "--context",
        choices=BROWSER_GLOBALS,
        action="append",
        help="Browser global to run, repeatable (default: both)",
    )
    parser.add_argument("--json", type=Path, help="Write a JSON report to this file")
    parser.add_argument(
        "--manifest",
        type=Path,
        default=MANIFEST,
        help="Expectations file for Selenium runs (default: test/js-api/expectations.json)",
    )
    parser.add_argument(
        "--serve", action="store_true", help="Serve test pages for manual use"
    )
    parser.add_argument(
        "tests", nargs="*", help="Test paths relative to test/js-api (default: all)"
    )
    args = parser.parse_args()

    contexts = tuple(
        context
        for context in BROWSER_GLOBALS
        if not args.context or context in args.context
    )
    scripts, tests = discover_suite()
    metadata_for = cache(test_metadata)
    try:
        pages, cases = generate_test_pages(
            scripts, tests, set(args.tests), contexts, metadata_for
        )
    except ValueError as error:
        parser.error(str(error))
    if not cases:
        parser.error("No browser cases matched the selection")
    if not args.serve:
        try:
            # Validate the full manifest even when the run selects only a few cases.
            expectations = load_expectations(
                args.manifest, tests, args.browser, metadata_for
            )
        except (OSError, ValueError) as error:
            parser.error(f"{args.manifest}: {error}")

    with make_server(scripts, pages) as server:
        base_url = f"http://127.0.0.1:{server.server_port}"
        if args.serve:
            print(base_url, flush=True)
            try:
                server.serve_forever()
            except KeyboardInterrupt:
                return 0
        thread = Thread(target=server.serve_forever, daemon=True)
        thread.start()
        try:
            return run_browser(args.browser, base_url, cases, expectations, args.json)
        finally:
            server.shutdown()
            thread.join()


if __name__ == "__main__":
    raise SystemExit(main())
