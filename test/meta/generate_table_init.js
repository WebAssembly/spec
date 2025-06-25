// This program generates .wast code that contains all the spec tests for
// table.init and elem.drop.  See `Makefile`.

print_origin("generate_table_init.js");

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

function emit_b(insn, table) {
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
  (elem (table $t${table}) (i32.const 2) func 3 1 4 1)
  (elem funcref
    (ref.func 2) (ref.func 7) (ref.func 1) (ref.func 8))
  (elem (table $t${table}) (i32.const 12) func 7 5 2 3 6)
  (elem funcref
    (ref.func 5) (ref.func 9) (ref.func 2) (ref.func 7) (ref.func 6))
  (func (result i32) (i32.const 5))  ;; index 5
  (func (result i32) (i32.const 6))
  (func (result i32) (i32.const 7))
  (func (result i32) (i32.const 8))
  (func (result i32) (i32.const 9))  ;; index 9
  (func (export "test")
    ${insn})
  (func (export "check") (param i32) (result i32)
    (call_indirect $t${table} (type 0) (local.get 0)))
)
`);
}

// This is the test driver.  It constructs the abovementioned module, using the
// given |instruction| to modify the table, and then probes the table by making
// indirect calls, one for each element of |expected_result_vector|.  The
// results are compared to those in the vector.

function tab_test(instruction, table, expected_result_vector) {
    emit_b(instruction, table);
    print(`(invoke "test")`);
    for (let i = 0; i < expected_result_vector.length; i++) {
        let expected = expected_result_vector[i];
        if (expected === undefined) {
            print(`(assert_trap (invoke "check" (i32.const ${i})) "uninitialized element")`);
        } else {
            print(`(assert_return (invoke "check" (i32.const ${i})) (i32.const ${expected}))`);
        }
    }
}

emit_a();

// Using 'e' for empty (undefined) spaces in the table, to make it easier
// to count through the vector entries when debugging.
let e = undefined;

for ( let table of [0, 1] ) {
    // Passive init that overwrites all-null entries
    tab_test(`(table.init $t${table} 1 (i32.const 7) (i32.const 0) (i32.const 4))`,
             table,
             [e,e,3,1,4, 1,e,2,7,1, 8,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Passive init that overwrites existing active-init-created entries
    tab_test(`(table.init $t${table} 3 (i32.const 15) (i32.const 1) (i32.const 3))`,
             table,
             [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 9,2,7,e,e, e,e,e,e,e, e,e,e,e,e]);

    // Perform active and passive initialisation and then multiple copies
    tab_test(
        `(table.init $t${table} 1 (i32.const 7) (i32.const 0) (i32.const 4))
         (elem.drop 1)
         (table.init $t${table} 3 (i32.const 15) (i32.const 1) (i32.const 3))
         (elem.drop 3)
         (table.copy $t${table} ${table} (i32.const 20) (i32.const 15) (i32.const 5))
         (table.copy $t${table} ${table} (i32.const 21) (i32.const 29) (i32.const 1))
         (table.copy $t${table} ${table} (i32.const 24) (i32.const 10) (i32.const 1))
         (table.copy $t${table} ${table} (i32.const 13) (i32.const 11) (i32.const 4))
         (table.copy $t${table} ${table} (i32.const 19) (i32.const 20) (i32.const 5))`,
        table,
        [e,e,3,1,4, 1,e,2,7,1, 8,e,7,e,7, 5,2,7,e,9, e,7,e,8,8, e,e,e,e,e]);
}

// elem.drop requires a table, minimally
print(
`(assert_invalid
  (module
    (func (export "test")
      (elem.drop 0)))
  "unknown elem segment 0")
`);

// table.init requires a table, minimally
print(
`(assert_invalid
  (module
    (func (export "test")
      (table.init 0 (i32.const 12) (i32.const 1) (i32.const 1))))
  "unknown table 0")
`);

// elem.drop with elem seg ix out of range
print(
`(assert_invalid
  (module
    (elem funcref (ref.func 0))
    (func (result i32) (i32.const 0))
    (func (export "test")
      (elem.drop 4)))
  "unknown elem segment 4")
`);

// init with elem seg ix out of range
print(
`(assert_invalid
  (module
    (elem funcref (ref.func 0))
    (func (result i32) (i32.const 0))
    (func (export "test")
      (table.init 4 (i32.const 12) (i32.const 1) (i32.const 1))))
  "unknown table 0")
`);

let tab0_len = 30;
let tab1_len = 28;

function do_test(insn1, insn2, table, errText)
{
    print(`
(script
(module
  (table $t0 ${tab0_len} ${tab0_len} funcref)
  (table $t1 ${tab1_len} ${tab1_len} funcref)
  (elem (table $t${table}) (i32.const 2) func 3 1 4 1)
  (elem funcref
    (ref.func 2) (ref.func 7) (ref.func 1) (ref.func 8))
  (elem (table $t${table}) (i32.const 12) func 7 5 2 3 6)
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
    ${insn2}))`);

    if (errText !== undefined) {
        print(`(assert_trap (invoke "test") "${errText}")`);
    } else {
        print(`(invoke "test")`);
    }
    print(')');
}

function tab_test1(insn1, table, errText) {
    do_test(insn1, "", table, errText);
}

function tab_test2(insn1, insn2, errText) {
    do_test(insn1, insn2, 0, errText);
}

// drop with elem seg ix indicating an active segment
tab_test1("(elem.drop 2)", 0,
          undefined);

// init with elem seg ix indicating an active segment
tab_test1("(table.init 2 (i32.const 12) (i32.const 1) (i32.const 1))", 0,
          "out of bounds table access");

// init, using an elem seg ix more than once is OK
tab_test2(
    "(table.init 1 (i32.const 12) (i32.const 1) (i32.const 1))",
    "(table.init 1 (i32.const 21) (i32.const 1) (i32.const 1))",
    undefined);

// drop, then drop
tab_test2("(elem.drop 1)",
          "(elem.drop 1)",
          undefined);

// drop, then init
tab_test2("(elem.drop 1)",
          "(table.init 1 (i32.const 12) (i32.const 1) (i32.const 1))",
          "out of bounds table access");

// init: seg ix is valid passive, but length to copy > len of seg
tab_test1("(table.init 1 (i32.const 12) (i32.const 0) (i32.const 5))", 0,
          "out of bounds table access");

// init: seg ix is valid passive, but implies copying beyond end of seg
tab_test1("(table.init 1 (i32.const 12) (i32.const 2) (i32.const 3))", 0,
          "out of bounds table access");

// Tables are of different length with t1 shorter than t0, to test that we're not
// using t0's limit for t1's bound

for ( let [table, oobval] of [[0,30],[1,28]] ) {
    // init: seg ix is valid passive, but implies copying beyond end of dst
    tab_test1(`(table.init $t${table} 1 (i32.const ${oobval-2}) (i32.const 1) (i32.const 3))`,
              table,
              "out of bounds table access");

    // init: seg ix is valid passive, zero len, and src offset out of bounds at the
    // end of the table - this is allowed
    tab_test1(`(table.init $t${table} 1 (i32.const 12) (i32.const 4) (i32.const 0))`,
              table,
              undefined);

    // init: seg ix is valid passive, zero len, and src offset out of bounds past the
    // end of the table - this is not allowed
    tab_test1(`(table.init $t${table} 1 (i32.const 12) (i32.const 5) (i32.const 0))`,
              table,
              "out of bounds table access");

    // init: seg ix is valid passive, zero len, and dst offset out of bounds at the
    // end of the table - this is allowed
    tab_test1(`(table.init $t${table} 1 (i32.const ${oobval}) (i32.const 2) (i32.const 0))`,
              table,
              undefined);

    // init: seg ix is valid passive, zero len, and dst offset out of bounds past the
    // end of the table - this is not allowed
    tab_test1(`(table.init $t${table} 1 (i32.const ${oobval+1}) (i32.const 2) (i32.const 0))`,
              table,
              "out of bounds table access");

    // init: seg ix is valid passive, zero len, and dst and src offsets out of bounds
    // at the end of the table - this is allowed
    tab_test1(`(table.init $t${table} 1 (i32.const ${oobval}) (i32.const 4) (i32.const 0))`,
              table,
              undefined);

    // init: seg ix is valid passive, zero len, and src/dst offset out of bounds past the
    // end of the table - this is not allowed
    tab_test1(`(table.init $t${table} 1 (i32.const ${oobval+1}) (i32.const 5) (i32.const 0))`,
              table,
              "out of bounds table access");
}

// invalid argument types
{
    const tys  = ['i32', 'f32', 'i64', 'f64'];

    for (let ty1 of tys) {
    for (let ty2 of tys) {
    for (let ty3 of tys) {
        if (ty1 == 'i32' && ty2 == 'i32' && ty3 == 'i32')
            continue;  // this is the only valid case
        print(
`
(assert_invalid
  (module
    (table 10 funcref)
    (elem funcref (ref.func $f0) (ref.func $f0) (ref.func $f0))
    (func $f0)
    (func (export "test")
      (table.init 0 (${ty1}.const 1) (${ty2}.const 1) (${ty3}.const 1))))
  "type mismatch")`);
    }}}
}

// table.init: out of bounds of the table or the element segment, but should
// perform the operation up to the appropriate bound.
//
// Arithmetic overflow of tableoffset + len or of segmentoffset + len should not
// affect the behavior.

// Note, the length of the element segment is 16.
const tbl_init_len = 16;

function tbl_init(min, max, backup, write, segoffs=0) {
    print(
        `
(script
(module
  (type (func (result i32)))
  (table ${min} ${max} funcref)
  (elem funcref
    (ref.func $f0) (ref.func $f1) (ref.func $f2) (ref.func $f3)
    (ref.func $f4) (ref.func $f5) (ref.func $f6) (ref.func $f7)
    (ref.func $f8) (ref.func $f9) (ref.func $f10) (ref.func $f11)
    (ref.func $f12) (ref.func $f13) (ref.func $f14) (ref.func $f15))
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
  (func (export "run") (param $offs i32) (param $len i32)
    (table.init 0 (local.get $offs) (i32.const ${segoffs}) (local.get $len))))`);

    // A fill writing past the end of the table should throw *and* have filled
    // all the way up to the end.
    //
    // A fill reading past the end of the segment should throw *and* have filled
    // table with as much data as was available.
    let offs = min - backup;
    print(`(assert_trap (invoke "run" (i32.const ${offs}) (i32.const ${write})) "out of bounds table access")`);
    for (let i=0; i < min; i++) {
        print(`(assert_trap (invoke "test" (i32.const ${i})) "uninitialized element")`);
    }
    print(')');
}

// We exceed the bounds of the table but not of the element segment
tbl_init(tbl_init_len*2, tbl_init_len*4, Math.floor(tbl_init_len/2), tbl_init_len);
tbl_init(tbl_init_len*2, tbl_init_len*4, Math.floor(tbl_init_len/2)-1, tbl_init_len);

// We exceed the bounds of the element segment but not the table
tbl_init(tbl_init_len*10, tbl_init_len*20, tbl_init_len*4, tbl_init_len*2);
tbl_init(tbl_init_len*10, tbl_init_len*20, tbl_init_len*4-1, tbl_init_len*2-1);

// We arithmetically overflow the table limit but not the segment limit
tbl_init(tbl_init_len*4, tbl_init_len*4, tbl_init_len, 0xFFFFFFF0);

// We arithmetically overflow the segment limit but not the table limit
tbl_init(tbl_init_len, tbl_init_len, tbl_init_len, 0xFFFFFFFC, Math.floor(tbl_init_len/2));

// Test that the elem segment index is properly encoded as an unsigned (not
// signed) LEB.
print(
`
(module
  (table 1 funcref)
  ;; 65 elem segments. 64 is the smallest positive number that is encoded
  ;; differently as a signed LEB.
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref) (elem funcref) (elem funcref) (elem funcref)
  (elem funcref)
  (func (table.init 64 (i32.const 0) (i32.const 0) (i32.const 0))))`)
