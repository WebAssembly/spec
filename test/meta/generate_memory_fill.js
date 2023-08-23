// This program generates .wast code that contains all the spec tests for
// memory.fill.  See `Makefile`.

print_origin("generate_memory_fill.js");

let PREAMBLE =
  `(memory 1 1)
  ${checkRangeCode()}`;

// Range valid
print(
`
(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0xFF00) (i32.const 0x55) (i32.const 256))))
(invoke "test")
`);
checkRange(0x00000, 0x0FF00, 0x00)
checkRange(0x0FF00, 0x10000, 0x55)

// Range invalid
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0xFF00) (i32.const 0x55) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Wraparound the end of 32-bit offset space
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0xFFFFFF00) (i32.const 0x55) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Zero len with offset in-bounds is a no-op
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0x12) (i32.const 0x55) (i32.const 0))))
(invoke "test")
`);
checkRange(0x00000, 0x10000, 0x00);

// Zero len with offset out-of-bounds at the end of memory is allowed
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0x10000) (i32.const 0x55) (i32.const 0))))
(invoke "test")
`);

// Zero len with offset out-of-bounds past the end of memory is not allowed
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0x20000) (i32.const 0x55) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Very large range
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.fill (i32.const 0x1) (i32.const 0xAA) (i32.const 0xFFFE))))
(invoke "test")
`);
checkRange(0x00000, 0x00001, 0x00);
checkRange(0x00001, 0x0FFFF, 0xAA);
checkRange(0x0FFFF, 0x10000, 0x00);

// Sequencing
print(
`
(module
  ${PREAMBLE}
  (func (export "test")
     (memory.fill (i32.const 0x12) (i32.const 0x55) (i32.const 10))
     (memory.fill (i32.const 0x15) (i32.const 0xAA) (i32.const 4))))
(invoke "test")
`);
checkRange(0x0,     0x12+0,  0x00);
checkRange(0x12+0,  0x12+3,  0x55);
checkRange(0x12+3,  0x12+7,  0xAA);
checkRange(0x12+7,  0x12+10, 0x55);
checkRange(0x12+10, 0x10000, 0x00);

// Sundry compilation failures.

// Module doesn't have a memory.
print(
`(assert_invalid
  (module
    (func (export "testfn")
      (memory.fill (i32.const 10) (i32.const 20) (i32.const 30))))
  "unknown memory 0")
`);

// Invalid argument types.  TODO: We can add anyref, funcref, etc here.
{
    const tys = ['i32', 'f32', 'i64', 'f64'];
    for (let ty1 of tys) {
    for (let ty2 of tys) {
    for (let ty3 of tys) {
        if (ty1 == 'i32' && ty2 == 'i32' && ty3 == 'i32')
            continue;  // this is the only valid case
        print(
`(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (${ty1}.const 10) (${ty2}.const 20) (${ty3}.const 30))))
  "type mismatch")
`);
    }}}
}

// memory.fill: out of bounds, and should not perform a partial fill.
//
// Arithmetic overflow of memory offset + len should not affect the behavior, we
// should still fill up to the limit.

function mem_fill(min, max, shared, backup, write=backup*2) {
    print(
`(module
  (memory ${min} ${max} ${shared})
  ${checkRangeCode()}
  (func (export "run") (param $offs i32) (param $val i32) (param $len i32)
    (memory.fill (local.get $offs) (local.get $val) (local.get $len))))
`);
    // A fill past the end should throw *and* not have performed a partial fill
    let offs = min*PAGESIZE - backup;
    let val = 37;
    print(
`(assert_trap (invoke "run" (i32.const ${offs}) (i32.const ${val}) (i32.const ${write}))
              "out of bounds memory access")
`);
    checkRange(0, min, 0);
}

mem_fill(1, 1, "", 256);
mem_fill(1, 1, "", 257);
mem_fill(1, 1, "", 257, 0xFFFFFFFF); // offs + len overflows 32-bit

if (WITH_SHARED_MEMORY) {
    mem_fill(2, 4, "shared", 256);
    mem_fill(2, 4, "shared", 257);
    mem_fill(2, 4, "shared", 257, 0xFFFFFFFF); // offs + len overflows 32-bit
}
