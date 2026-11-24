#!/usr/bin/env python3
"""Browser version selection and update proposals for the JS API CI workflow."""

import argparse
import json
import sys
import time
from pathlib import Path
from urllib.request import urlopen

from lib.expectations import apply_report
from lib.tests import (
    BROWSERS,
    EXPECTATIONS,
    PINS,
    VERSION,
    discover_tests,
    read_json,
    version_key,
    write_json,
)

LATEST_RELEASE_URLS = {
    "chrome": "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE",
    "firefox": "https://product-details.mozilla.org/1.0/firefox_versions.json",
}


def fetch(url, attempts=3):
    for attempt in range(1, attempts + 1):
        try:
            with urlopen(url, timeout=30) as response:
                return response.read().decode("utf-8")
        except OSError:
            if attempt == attempts:
                raise
            time.sleep(5 * attempt)


def latest_release(browser):
    body = fetch(LATEST_RELEASE_URLS[browser])
    if browser == "firefox":
        return json.loads(body)["LATEST_FIREFOX_VERSION"]
    return body.strip()


def select_version(browser, override, refresh):
    """Return the version to require, or an empty string to accept any."""
    pin = read_json(PINS)[browser]
    if override:
        version = override
    elif browser == "safari":
        # The hosted runner supplies Safari. Normal CI checks only its major version.
        version = "installed" if refresh else pin.split(".")[0]
    elif refresh:
        latest = latest_release(browser)
        if not VERSION.fullmatch(latest):
            raise ValueError(f"Could not resolve a stable {browser} version: {latest}")
        # A release feed can lag behind the version already tested.
        version = max(pin, latest, key=version_key)
    else:
        version = pin

    if browser == "safari" and version == "installed":
        return ""
    if not VERSION.fullmatch(version):
        raise ValueError(f"Invalid {browser} version: {version}")
    return version


def propose(reports):
    """Update pins and expectations from CI reports. Returns the rejected browsers."""
    pins = read_json(PINS)
    expectations = read_json(EXPECTATIONS)
    _, tests = discover_tests()
    rejected = []
    for browser in BROWSERS:
        pin = pins[browser]
        try:
            report = read_json(reports / f"wasm-js-api-{browser}" / "wasm-js-api.json")
            version = report.get("version")
            if report.get("browser") != browser or not (
                isinstance(version, str) and VERSION.fullmatch(version)
            ):
                raise ValueError("report has no valid browser version")
            if version == pin:
                continue
            if version_key(version) < version_key(pin):
                raise ValueError(f"{version} is older than the tested pin {pin}")
            expectations = apply_report(expectations, report, tests, require_complete=True)
        except (OSError, ValueError, KeyError, TypeError, AttributeError) as error:
            print(f"::error::{browser}: {error}", file=sys.stderr)
            rejected.append(browser)
            continue
        pins[browser] = version
        print(f"- {browser} {pin} → {version}")
    write_json(PINS, pins)
    write_json(EXPECTATIONS, expectations)
    return rejected


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)

    select = commands.add_parser(
        "select-version", help="Print the browser version a CI run should require"
    )
    select.add_argument("browser", choices=BROWSERS)
    select.add_argument("--override", help="Candidate version to test instead")
    select.add_argument(
        "--refresh", action="store_true", help="Test the latest stable release"
    )

    update = commands.add_parser(
        "propose", help="Update pins and expectations from downloaded CI reports"
    )
    update.add_argument("reports", type=Path, help="Directory of report artifacts")

    args = parser.parse_args()
    if args.command == "select-version":
        try:
            print(select_version(args.browser, args.override, args.refresh))
        except (OSError, ValueError, KeyError) as error:
            parser.error(str(error))
        return 0
    return 1 if propose(args.reports) else 0


if __name__ == "__main__":
    sys.exit(main())
