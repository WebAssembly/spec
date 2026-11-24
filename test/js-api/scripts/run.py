#!/usr/bin/env python3
"""Run the Wasm JS API tests in a browser using Selenium."""

import argparse
import json
from collections import Counter
from contextlib import nullcontext
from dataclasses import dataclass
from html import escape
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Thread
from urllib.parse import quote, urljoin, urlsplit

from lib.expectations import WHOLE_CASE, evaluate_result, validate_expectations
from lib.tests import (
    BROWSER_GLOBALS,
    BROWSERS,
    HARNESS,
    EXPECTATIONS,
    PREFIX,
    VERSION,
    discover_tests,
    read_json,
    test_metadata,
    write_json,
)

# Match the timeout values in testharness.js.
HARNESS_TIMEOUT_SECONDS = {"normal": 10, "long": 60}
WEBDRIVER_GRACE_SECONDS = 5
OUTCOMES = ("PASS", "FAIL", "XFAIL", "XPASS", "SKIP")

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


def generate_test_pages(scripts, tests, selected, contexts):
    unknown = selected - tests.keys()
    if unknown:
        raise ValueError(f"Unknown tests: {', '.join(sorted(unknown))}")
    pages = {}
    cases = []
    for name in sorted(selected or tests):
        url = PREFIX + quote(name)
        stem = url.removesuffix(".js")
        globals_, helpers, timeout_mode = test_metadata(tests[name])
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


def create_driver(browser, browser_version):
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
    if browser_version and browser != "safari":
        options.browser_version = browser_version

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


def run_browser(browser, browser_version, base_url, cases, rules):
    results = []
    counts = Counter()
    selected = [
        (case, rules.get((case.name, case.context), {})) for case in cases
    ]
    has_runnable_cases = any(
        case_rules.get(WHOLE_CASE, (None, None))[0] != "skip" for _, case_rules in selected
    )
    with (
        create_driver(browser, browser_version)
        if has_runnable_cases
        else nullcontext() as driver
    ):
        version = (
            (driver.capabilities.get("browserVersion") or "unknown") if driver else None
        )
        if (
            driver
            and browser_version
            and version != browser_version
            and not (
                "." not in browser_version and version.startswith(browser_version + ".")
            )
        ):
            raise SystemExit(f"Expected {browser} {browser_version}, started {version}")
        print(
            f"{browser}: {len(cases)} selected cases"
            + (f" (version {version})" if version else ""),
            flush=True,
        )
        for case, case_rules in selected:
            expect, reason = case_rules.get(WHOLE_CASE, (None, None))
            if expect == "skip":
                result = {"status": "SKIP", "message": reason, "subtests": []}
                outcome, diagnostics = "SKIP", [reason]
            else:
                result = read_result(
                    driver, base_url + case.page_path, case.timeout_seconds
                )
                outcome, diagnostics = evaluate_result(result, case_rules)
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

    print(", ".join(f"{counts[outcome]} {outcome}" for outcome in OUTCOMES), flush=True)
    report = {"browser": browser, "version": version, "results": results}
    return report, int(counts["FAIL"] > 0 or counts["XPASS"] > 0)


def write_summary(path, report):
    counts = Counter(case["outcome"] for case in report["results"])
    title = " ".join(filter(None, ("Wasm JS API in", report["browser"], report["version"])))
    with path.open("a", encoding="utf-8") as summary:
        summary.write(f"### {title}\n\n")
        summary.write("| Pass | Fail | Expected failure | Unexpected pass | Skip |\n")
        summary.write("| ---: | ---: | ---: | ---: | ---: |\n")
        summary.write("| " + " | ".join(str(counts[outcome]) for outcome in OUTCOMES) + " |\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--browser",
        choices=BROWSERS,
        default="firefox",
        help="Browser to run (default: firefox)",
    )
    parser.add_argument(
        "--browser-version", help="Require a browser version or major version"
    )
    parser.add_argument(
        "--context",
        choices=BROWSER_GLOBALS,
        action="append",
        help="Browser global to run, repeatable (default: both)",
    )
    parser.add_argument("--json", type=Path, help="Write a JSON report to this file")
    parser.add_argument(
        "--summary", type=Path, help="Append a Markdown results table to this file"
    )
    parser.add_argument(
        "--expectations",
        type=Path,
        default=EXPECTATIONS,
        help="Expectations file (default: test/js-api/scripts/expectations.json)",
    )
    parser.add_argument(
        "--serve", action="store_true", help="Serve test pages for manual use"
    )
    parser.add_argument(
        "tests", nargs="*", help="Test paths relative to test/js-api (default: all)"
    )
    args = parser.parse_args()
    if args.browser_version and not VERSION.fullmatch(args.browser_version):
        parser.error("--browser-version must be a version number")
    scripts, tests = discover_tests()

    if not args.serve:
        try:
            # Validate all expectations even when the run selects only a few cases.
            rules = validate_expectations(read_json(args.expectations), tests, args.browser)
        except (OSError, ValueError) as error:
            parser.error(f"{args.expectations}: {error}")

    contexts = tuple(
        context
        for context in BROWSER_GLOBALS
        if not args.context or context in args.context
    )
    try:
        pages, cases = generate_test_pages(
            scripts, tests, set(args.tests), contexts
        )
    except ValueError as error:
        parser.error(str(error))
    if not cases:
        parser.error("No browser cases matched the selection")
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
            report, status = run_browser(
                args.browser, args.browser_version, base_url, cases, rules
            )
        finally:
            server.shutdown()
            thread.join()
    if args.json:
        write_json(args.json, report)
    if args.summary:
        write_summary(args.summary, report)
    return status


if __name__ == "__main__":
    raise SystemExit(main())
