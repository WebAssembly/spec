#!/usr/bin/env python3
"""Generate proposed Wasm JS API expectations from a browser JSON report."""

import argparse
import json
from pathlib import Path

from lib.expectations import apply_report
from lib.tests import EXPECTATIONS, discover_tests, read_json, write_json


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "report", type=Path, help="Browser JSON report from run.py or CI"
    )
    parser.add_argument(
        "--expectations",
        type=Path,
        default=EXPECTATIONS,
        help="Expectations file to update (default: test/js-api/scripts/expectations.json)",
    )
    parser.add_argument(
        "--in-place",
        action="store_true",
        help="Write the result back to the expectations file instead of stdout",
    )
    args = parser.parse_args()
    _, tests = discover_tests()
    try:
        updated = apply_report(
            read_json(args.expectations), read_json(args.report), tests
        )
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as error:
        parser.error(str(error))
    if args.in_place:
        write_json(args.expectations, updated)
    else:
        print(json.dumps(updated, indent=2))


if __name__ == "__main__":
    main()
