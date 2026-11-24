#!/usr/bin/env python3
"""Generate proposed Wasm JS API expectations from a browser JSON report."""

import argparse
import json
from functools import cache
from pathlib import Path

from run import (
    BROWSER_GLOBALS,
    BROWSERS,
    MANIFEST,
    WHOLE_CASE,
    discover_suite,
    evaluate_result,
    read_json,
    test_metadata,
    validate_expectations,
)


def update_expectations(manifest, rules, report, tests, metadata_for):
    """Refresh failure rules for the browser cases covered by a result report."""
    browser, version = report["browser"], report.get("version")
    updated = rules.copy()
    seen = set()
    changed = set()
    for case in report["results"]:
        name, context = case["test"], case["context"]
        key = (name, context)
        if (
            name not in tests
            or context not in BROWSER_GLOBALS
            or context not in metadata_for(tests[name])[0]
            or key in seen
        ):
            raise ValueError(f"Unknown or duplicate browser case: {name} [{context}]")
        seen.add(key)
        subtests = case["subtests"]
        previous = rules.get(key, {})
        # A skip or an incomplete run gives no reliable evidence about this case.
        if (
            case["status"] != "OK"
            or not subtests
            or any(test["status"] not in ("PASS", "FAIL") for test in subtests)
            or previous.get(WHOLE_CASE, (None, None))[0] == "skip"
        ):
            continue
        failures = {
            test["name"]: test.get("message")
            for test in subtests
            if test["status"] == "FAIL"
        }
        whole_case = previous.get(WHOLE_CASE)
        if whole_case and failures:
            current = previous
        else:
            current = {}
            for subtest, message in failures.items():
                if subtest in previous:
                    current[subtest] = previous[subtest]
                else:
                    reason = f"Observed in {browser.capitalize()}"
                    if version:
                        reason += f" {version}"
                    if message:
                        reason += f": {' '.join(message.split())}"
                    current[subtest] = ("fail", reason)
        if current != previous:
            updated[key] = current
            changed.add(name)

    result = manifest.copy()
    for name in sorted(changed):
        supported = [
            context
            for context in BROWSER_GLOBALS
            if context in metadata_for(tests[name])[0]
        ]
        rule_contexts = {}
        for context in supported:
            for subtest, (expect, reason) in updated.get((name, context), {}).items():
                rule_contexts.setdefault((subtest, expect, reason), []).append(context)

        entries = [
            entry for entry in manifest.get(name, []) if entry["browser"] != browser
        ]
        for (subtest, expect, reason), contexts in rule_contexts.items():
            # A rule with no context applies to every supported browser global.
            for context in (None,) if contexts == supported else contexts:
                entry = {"browser": browser}
                if context is not None:
                    entry["context"] = context
                if subtest is not WHOLE_CASE:
                    entry["subtest"] = subtest
                entries.append({**entry, "expect": expect, "reason": reason})
        if entries:
            result[name] = entries
        else:
            result.pop(name)
    return dict(sorted(result.items())) if changed else result


def check_complete_report(report, rules, tests, metadata_for):
    expected_cases = {
        (name, context)
        for name, path in tests.items()
        for context in BROWSER_GLOBALS
        if context in metadata_for(path)[0]
    }
    reported_cases = {(case["test"], case["context"]) for case in report["results"]}
    missing = expected_cases - reported_cases
    if missing:
        examples = ", ".join(
            f"{name} [{context}]" for name, context in sorted(missing)[:3]
        )
        raise ValueError(
            f"Report is missing {len(missing)} browser cases, including {examples}"
        )

    for case in report["results"]:
        name, context = case["test"], case["context"]
        case_rules = rules.get((name, context), {})
        if (
            case_rules.get(WHOLE_CASE, (None, None))[0] == "skip"
            and case["status"] == "SKIP"
        ):
            continue
        outcome, _ = evaluate_result(case, case_rules)
        if not case["subtests"] or outcome not in ("PASS", "XFAIL"):
            raise ValueError(
                f"Cannot update from an incomplete or unresolved case: {name} [{context}]"
            )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "report", type=Path, help="Browser JSON report from run.py or CI"
    )
    parser.add_argument(
        "--manifest",
        type=Path,
        default=MANIFEST,
        help="Base expectations file (default: test/js-api/scripts/expectations.json)",
    )
    parser.add_argument(
        "--require-complete",
        action="store_true",
        help="Reject reports with missing or unresolved cases (used by CI)",
    )
    args = parser.parse_args()
    try:
        report = read_json(args.report)
        browser = report["browser"]
        if browser not in BROWSERS or not isinstance(report["results"], list):
            raise ValueError("Expected a browser report with a results list")
    except (OSError, ValueError, KeyError, TypeError) as error:
        parser.error(f"{args.report}: {error}")

    _, tests = discover_suite()
    metadata_for = cache(test_metadata)
    try:
        manifest = read_json(args.manifest)
        rules = validate_expectations(manifest, tests, browser, metadata_for)
    except (OSError, ValueError) as error:
        parser.error(f"{args.manifest}: {error}")

    try:
        updated = update_expectations(manifest, rules, report, tests, metadata_for)
        updated_rules = validate_expectations(updated, tests, browser, metadata_for)
        if args.require_complete:
            check_complete_report(report, updated_rules, tests, metadata_for)
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as error:
        parser.error(f"{args.report}: {error}")
    print(json.dumps(updated, indent=2))


if __name__ == "__main__":
    main()
