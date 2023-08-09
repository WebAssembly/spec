// This program generates .wast code that contains all the spec tests for
// table.copy.  See `Makefile`.

print_origin("generate_table_copy.js");

// This module "a" exports 5 functions ...

function emit_a() {
    print(
`
(module
  (func (export "ef0") (result i32) (i32.const 0))
  (func (export "ef1") (result i32) (i32.const 1))
  (func (export "ef2") (result i32) (i32.const 2))
  (func (export "ef3") (result i32) (i32.const 3))
  (func (export "ef4") (result i32) (i32.const 4))
)
(register "a")`);
}

// ... and this one imports those 5 functions.  It adds 5 of its own, creates a
// 30 element table using both active and passive initialisers, with a mixture
// of the imported and local functions.  |test| is exported.  It uses the
// supplied |insn| to modify the table somehow.  |check| will then indirect-call
// the table entry number specified as a parameter.  That will either return a
// value 0 to 9 indicating the function called, or will throw an exception if
// the table entry is empty.

function emit_b(insn, t0, t1) {
    print(
`
(module
  (type (func (result i32)))  ;; type #0
  (import "a" "ef0" (func (result i32)))    ;; index 0
  (import "a" "ef1" (func (result i32)))
  (import "a" "ef2" (func (result i32)))
  (import "a" "ef3" (func (result i32)))
  (import "a" "ef4" (func (result i32)))    ;; index 4
  (table $t0 30 30 funcref)
  (table $t1 30 30 funcref)
  (elem (table $t${t0}) (i32.const 2) func 3 1 4 1)
  (elem funcref
    (ref.func 2) (ref.func 7) (ref.func 1) (ref.func 8))
  (elem (table $t${t0}) (i32.const 12) func 7 5 2 3 6)
  (elem funcref
    (ref.func 5) (ref.func 9) (ref.func 2) (ref.func 7) (ref.func 6))
  (elem (table $t${t1}) (i32.const 3) func 1 3 1 4)
  (elem (table $t${t1}) (i32.const 11) func 6 3 2 5 7)
  (func (result i32) (i32.const 5))  ;; index 5
  (func (result i32) (i32.const 6))
  (func (result i32) (i32.const 7))
  (func (result i32) (i32.const 8))
  (func (result i32) (i32.const 9))  ;; index 9
  (func (export "test")
    ${insn})
  (func (export "check_t0") (param i32) (result i32)
    (call_indirect $t${t0} (type 0) (local.get 0)))
  (func (export "check_t1") (param i32) (result i32)
    (call_indirect $t${t1} (type 0) (local.get 0)))
)
`);
}

// This is the test driver.  It constructs the abovementioned module, using the
// given |instruction| to modify the table, and then probes the table by making
// indirect calls, one for each element of |expected_result_vector|.  The
// results are compared to those in the vector.
//
// "dest_table" may be t0 or t1.

function tab_test(args, t0, t1, dest_table, expected_t0, expected_t1) {
    if (typeof args != "string")
        emit_b("(nop)", t0, t1);
    else
        emit_b(`(table.copy $t${dest_table} $t${t0} ${args})`, t0, t1);
    print(`(invoke "test")`);
    for (let i = 0; i < expected_t0.length; i++) {
        let expected = expected_t0[i];
        if (expected === undefined) {
            print(`(assert_trap (invoke "check_t0" (i32.const ${i})) "uninitialized element")`);
        } else {
            print(`(assert_return (invoke "check_t0" (i32.const ${i})) (i32.const ${expected}))`);
        }
    }
    for (let i = 0; i < expected_t1.length; i++) {
        let expected = expected_t1[i];
        if (expected === undefined) {
            print(`(assert_trap (invoke "check_t1" (i32.const ${i})) "uninitialized element")`);
        } else {
            print(`(assert_return (invoke "check_t1" (i32.const ${i})) (i32.const ${expected}))`);
        }
    }
}

emit_a();

// Using 'e' for empty (undefined) spaces in the table, to make it easier
// to count through the vector entries when debugging.
let e = undefined;

for ( let table of [0,1] ) {
    let other_table = (table + 1) % 2;

    // Tests for copying in a single table.

    // This just gives the initial state of the table, with its active
    // initialisers applied
    tab_test(false, table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy non-null over non-null
    tab_test("(i32.const 13) (i32.const 2) (i32.const 3)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,3,1, 4,6,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy non-null over null
    tab_test("(i32.const 25) (i32.const 15) (i32.const 2)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, 3,6,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy null over non-null
    tab_test("(i32.const 13) (i32.const 25) (i32.const 3)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,e,e, e,6,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy null over null
    tab_test("(i32.const 20) (i32.const 22) (i32.const 4)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy null and non-null entries, non overlapping
    tab_test("(i32.const 25) (i32.const 1) (i32.const 3)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,3,1,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy null and non-null entries, overlapping, backwards
    tab_test("(i32.const 10) (i32.const 12) (i32.const 7)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, 7,5,2,3,6, e,e,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Copy null and non-null entries, overlapping, forwards
    tab_test("(i32.const 12) (i32.const 10) (i32.const 7)", table, other_table, table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,e,e,7, 5,2,3,6,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,6,3,2,5, 7,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Tests for copying from one table to the other.  Here, overlap and copy
    // direction don't matter.

    tab_test("(i32.const 10) (i32.const 0) (i32.const 20)", table, other_table, other_table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e],
             [e,e,e,1,3, 1,4,e,e,e, e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e]);
}

// Out-of-bounds checks.

function do_test(insn1, insn2, errText)
{
    print(`
(module
  (table $t0 30 30 funcref)
  (table $t1 30 30 funcref)
  (elem (table $t0) (i32.const 2) func 3 1 4 1)
  (elem funcref
    (ref.func 2) (ref.func 7) (ref.func 1) (ref.func 8))
  (elem (table $t0) (i32.const 12) func 7 5 2 3 6)
  (elem funcref
    (ref.func 5) (ref.func 9) (ref.func 2) (ref.func 7) (ref.func 6))
  (func (result i32) (i32.const 0))
  (func (result i32) (i32.const 1))
  (func (result i32) (i32.const 2))
  (func (result i32) (i32.const 3))
  (func (result i32) (i32.const 4))
  (func (result i32) (i32.const 5))
  (func (result i32) (i32.const 6))
  (func (result i32) (i32.const 7))
  (func (result i32) (i32.const 8))
  (func (result i32) (i32.const 9))
  (func (export "test")
    ${insn1}
    ${insn2}))
`);

    if (errText !== undefined) {
        print(`(assert_trap (invoke "test") "${errText}")`);
    } else {
        print(`(invoke "test")`);
    }
}

function tab_test2(insn1, insn2, errKind, errText) {
    do_test(insn1, insn2, errKind, errText);
}

function tab_test_nofail(insn1, insn2) {
    do_test(insn1, insn2, undefined, undefined);
}

for ( let dest of ["$t0","$t1"] ) {
    // Here we test the boundary-failure cases.  The table's valid indices are 0..29
    // inclusive.

    // copy: dst range invalid
    tab_test2(`(table.copy ${dest} $t0 (i32.const 28) (i32.const 1) (i32.const 3))`,
              "",
              "out of bounds table access");

    // copy: dst wraparound end of 32 bit offset space
    tab_test2(`(table.copy ${dest} $t0 (i32.const 0xFFFFFFFE) (i32.const 1) (i32.const 2))`,
              "",
              "out of bounds table access");

    // copy: src range invalid
    tab_test2(`(table.copy ${dest} $t0 (i32.const 15) (i32.const 25) (i32.const 6))`,
              "",
              "out of bounds table access");

    // copy: src wraparound end of 32 bit offset space
    tab_test2(`(table.copy ${dest} $t0 (i32.const 15) (i32.const 0xFFFFFFFE) (i32.const 2))`,
              "",
              "out of bounds table access");

    // copy: zero length with both offsets in-bounds is OK
    tab_test_nofail(
        `(table.copy ${dest} $t0 (i32.const 15) (i32.const 25) (i32.const 0))`,
        "");

    // copy: zero length with dst offset out of bounds at the end of the table is allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 30) (i32.const 15) (i32.const 0))`,
              "",
              undefined);

    // copy: zero length with dst offset out of bounds past the end of the table is not allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 31) (i32.const 15) (i32.const 0))`,
              "",
              "out of bounds table access");

    // copy: zero length with src offset out of bounds at the end of the table is allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 15) (i32.const 30) (i32.const 0))`,
              "",
              undefined);

    // copy: zero length with src offset out of bounds past the end of the table is not allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 15) (i32.const 31) (i32.const 0))`,
              "",
              "out of bounds table access");

    // copy: zero length with both dst and src offset out of bounds at the end of the table is allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 30) (i32.const 30) (i32.const 0))`,
              "",
              undefined);

    // copy: zero length with both dst and src offset out of bounds past the end of the table is not allowed
    tab_test2(`(table.copy ${dest} $t0 (i32.const 31) (i32.const 31) (i32.const 0))`,
              "",
              "out of bounds table access");
}

// table.copy: out of bounds of the table for the source or target, but should
// perform the operation up to the appropriate bound.  Major cases:
//
// - non-overlapping regions
// - overlapping regions with src > dest
// - overlapping regions with src == dest
// - overlapping regions with src < dest
// - arithmetic overflow on src addresses
// - arithmetic overflow on target addresses
//
// for each of those,
//
// - src address oob
// - target address oob
// - both oob

const tbl_copy_len = 16;

function tbl_copy(min, max, srcOffs, targetOffs, len) {
    let copyDown = srcOffs < targetOffs;
    let tblLength = min;

    let targetAvail = tblLength - targetOffs;
    let srcAvail = tblLength - srcOffs;
    let targetLim = targetOffs + Math.min(len, targetAvail, srcAvail);
    let srcLim = srcOffs + Math.min(len, targetAvail, srcAvail);

    print(
        `
(module
  (type (func (result i32)))
  (table ${min} ${max} funcref)
  (elem (i32.const ${srcOffs})
        ${(function () {
             var s = "";
             for (let i=srcOffs, j=0; i < srcLim; i++, j++)
               s += " $f" + j;
             return s;
         })()})
  (func $f0 (export "f0") (result i32) (i32.const 0))
  (func $f1 (export "f1") (result i32) (i32.const 1))
  (func $f2 (export "f2") (result i32) (i32.const 2))
  (func $f3 (export "f3") (result i32) (i32.const 3))
  (func $f4 (export "f4") (result i32) (i32.const 4))
  (func $f5 (export "f5") (result i32) (i32.const 5))
  (func $f6 (export "f6") (result i32) (i32.const 6))
  (func $f7 (export "f7") (result i32) (i32.const 7))
  (func $f8 (export "f8") (result i32) (i32.const 8))
  (func $f9 (export "f9") (result i32) (i32.const 9))
  (func $f10 (export "f10") (result i32) (i32.const 10))
  (func $f11 (export "f11") (result i32) (i32.const 11))
  (func $f12 (export "f12") (result i32) (i32.const 12))
  (func $f13 (export "f13") (result i32) (i32.const 13))
  (func $f14 (export "f14") (result i32) (i32.const 14))
  (func $f15 (export "f15") (result i32) (i32.const 15))
  (func (export "test") (param $n i32) (result i32)
    (call_indirect (type 0) (local.get $n)))
  (func (export "run") (param $targetOffs i32) (param $srcOffs i32) (param $len i32)
    (table.copy (local.get $targetOffs) (local.get $srcOffs) (local.get $len))))
`);

    let immediateOOB = copyDown && (srcOffs + len > tblLength || targetOffs + len > tblLength);

    print(`(assert_trap (invoke "run" (i32.const ${targetOffs}) (i32.const ${srcOffs}) (i32.const ${len}))
             "out of bounds table access")`);

    var s = 0;
    var i = 0;
    for (i=0; i < tblLength; i++ ) {
        if (i >= srcOffs && i < srcLim) {
            print(`(assert_return (invoke "test" (i32.const ${i})) (i32.const ${s++}))`);
            continue;
        }
        print(`(assert_trap (invoke "test" (i32.const ${i})) "uninitialized element")`);
    }
}

// OOB target address, nonoverlapping
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, 0, Math.floor(1.5*tbl_copy_len), tbl_copy_len);
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, 0, Math.floor(1.5*tbl_copy_len)-1, tbl_copy_len-1);

// OOB source address, nonoverlapping
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, Math.floor(1.5*tbl_copy_len), 0, tbl_copy_len);
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, Math.floor(1.5*tbl_copy_len)-1, 0, tbl_copy_len-1);

// OOB target address, overlapping, src < target
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, tbl_copy_len-5, Math.floor(1.5*tbl_copy_len), tbl_copy_len);

// OOB source address, overlapping, target < src
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, Math.floor(1.5*tbl_copy_len), tbl_copy_len-5, tbl_copy_len);

// OOB both, overlapping, including src == target
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, tbl_copy_len+5, Math.floor(1.5*tbl_copy_len), tbl_copy_len);
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, Math.floor(1.5*tbl_copy_len), tbl_copy_len+5, tbl_copy_len);
tbl_copy(tbl_copy_len*2, tbl_copy_len*4, tbl_copy_len+5, tbl_copy_len+5, tbl_copy_len);

// Arithmetic overflow on source address.
tbl_copy(tbl_copy_len*8, tbl_copy_len*8, tbl_copy_len*7, 0, 0xFFFFFFE0);

// Arithmetic overflow on target adddress is an overlapping case.
tbl_copy(tbl_copy_len*8, tbl_copy_len*8, 0, tbl_copy_len*7, 0xFFFFFFE0);
