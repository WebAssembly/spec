"""Validate, evaluate and update the rules in expectations.json."""

from .tests import BROWSERS, supported_globals

# Rules without a subtest name apply to the whole browser case.
WHOLE_CASE = None


def validate_expectations(expectations, tests, browser):
    """Validate all expectations and return one browser's rules by case."""
    if not isinstance(expectations, dict):
        raise ValueError("Expected an object keyed by test path")

    rules = {}
    required = {"browser", "expect", "reason"}
    allowed = required | {"context", "subtest"}
    for name, entries in expectations.items():
        if name not in tests:
            raise ValueError(f"Unknown test: {name}")
        if not isinstance(entries, list):
            raise ValueError(f"{name}: expected a list of rules")
        supported = supported_globals(tests[name])
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


def update_expectations(expectations, rules, report, tests):
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
            or context not in supported_globals(tests[name])
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

    result = expectations.copy()
    for name in sorted(changed):
        supported = supported_globals(tests[name])
        rule_contexts = {}
        for context in supported:
            for subtest, (expect, reason) in updated.get((name, context), {}).items():
                rule_contexts.setdefault((subtest, expect, reason), []).append(context)

        entries = [
            entry for entry in expectations.get(name, []) if entry["browser"] != browser
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


def check_complete_report(report, rules, tests):
    expected_cases = {
        (name, context)
        for name, path in tests.items()
        for context in supported_globals(path)
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


def apply_report(expectations, report, tests, require_complete=False):
    """Return the expectations updated with a browser report's results."""
    browser = report["browser"]
    if browser not in BROWSERS or not isinstance(report["results"], list):
        raise ValueError("Expected a browser report with a results list")
    rules = validate_expectations(expectations, tests, browser)
    updated = update_expectations(expectations, rules, report, tests)
    updated_rules = validate_expectations(updated, tests, browser)
    if require_complete:
        check_complete_report(report, updated_rules, tests)
    return updated
