// This program generates .wast code that contains all the spec tests for
// memory.init and data.drop.  See `Makefile`.

print_origin("generate_memory_init.js");

// In-bounds tests.

function mem_test(instruction, expected_result_vector) {
    print(
`
(module
  (memory (export "memory0") 1 1)
  (data (i32.const 2) "\\03\\01\\04\\01")
  (data "\\02\\07\\01\\08")
  (data (i32.const 12) "\\07\\05\\02\\03\\06")
  (data "\\05\\09\\02\\07\\06")
  (func (export "test")
    ${instruction})
  (func (export "load8_u") (param i32) (result i32)
    (i32.load8_u (local.get 0))))

(invoke "test")
`);
    for (let i = 0; i < expected_result_vector.length; i++) {
        print(`(assert_return (invoke "load8_u" (i32.const ${i})) (i32.const ${expected_result_vector[i]}))`);
    }
}

const e = 0;

// This just gives the initial state of the memory, with its active
// initialisers applied.
mem_test("(nop)",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Passive init that overwrites all-zero entries
mem_test("(memory.init 1 (i32.const 7) (i32.const 0) (i32.const 4))",
         [e,e,3,1,4, 1,e,2,7,1, 8,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Passive init that overwrites existing active-init-created entries
mem_test("(memory.init 3 (i32.const 15) (i32.const 1) (i32.const 3))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 9,2,7,e,e, e,e,e,e,e, e,e,e,e,e]);

// Perform active and passive initialisation and then multiple copies
mem_test(`(memory.init 1 (i32.const 7) (i32.const 0) (i32.const 4))
    (data.drop 1)
    (memory.init 3 (i32.const 15) (i32.const 1) (i32.const 3))
    (data.drop 3)
    (memory.copy (i32.const 20) (i32.const 15) (i32.const 5))
    (memory.copy (i32.const 21) (i32.const 29) (i32.const 1))
    (memory.copy (i32.const 24) (i32.const 10) (i32.const 1))
    (memory.copy (i32.const 13) (i32.const 11) (i32.const 4))
    (memory.copy (i32.const 19) (i32.const 20) (i32.const 5))`,
         [e,e,3,1,4, 1,e,2,7,1, 8,e,7,e,7, 5,2,7,e,9, e,7,e,8,8, e,e,e,e,e]);

// Miscellaneous

let PREAMBLE =
    `(memory 1)
    (data "\\37")`;

// drop with no memory
print(
`(assert_invalid
   (module
     (func (export "test")
       (data.drop 0)))
   "unknown memory 0")
`);

// drop with data seg ix out of range
print(
`(assert_invalid
  (module
    ${PREAMBLE}
    (func (export "test")
      (data.drop 4)))
  "unknown data segment")
`);

// drop, then drop
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (data.drop 0)
    (data.drop 0)))
(invoke "test")
`);

// drop, then init
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (data.drop 0)
    (memory.init 0 (i32.const 1234) (i32.const 1) (i32.const 1))))
(assert_trap (invoke "test") "out of bounds")
`);

// init with data seg ix indicating an active segment
print(
`(module
   (memory 1)
   (data (i32.const 0) "\\37")
   (func (export "test")
     (memory.init 0 (i32.const 1234) (i32.const 1) (i32.const 1))))
(assert_trap (invoke "test") "out of bounds")
`);

// init with no memory
print(
`(assert_invalid
  (module
    (func (export "test")
      (memory.init 1 (i32.const 1234) (i32.const 1) (i32.const 1))))
  "unknown memory 0")
`);

// init with data seg ix out of range
print(
`(assert_invalid
  (module
    ${PREAMBLE}
    (func (export "test")
      (memory.init 1 (i32.const 1234) (i32.const 1) (i32.const 1))))
  "unknown data segment 1")
`);

// init, using a data seg ix more than once is OK
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 1) (i32.const 0) (i32.const 1))
    (memory.init 0 (i32.const 1) (i32.const 0) (i32.const 1))))
(invoke "test")
`);

// init: seg ix is valid passive, but length to copy > len of seg
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 1234) (i32.const 0) (i32.const 5))))
(assert_trap (invoke "test") "out of bounds")
`);

// init: seg ix is valid passive, but implies copying beyond end of seg
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 1234) (i32.const 2) (i32.const 3))))
(assert_trap (invoke "test") "out of bounds")
`);

// init: seg ix is valid passive, but implies copying beyond end of dst
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 0xFFFE) (i32.const 1) (i32.const 3))))
(assert_trap (invoke "test") "out of bounds")
`);

// init: seg ix is valid passive, src offset past the end, zero len is invalid
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 1234) (i32.const 4) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds")
`);

// init: seg ix is valid passive, zero len, src offset at the end
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 1234) (i32.const 1) (i32.const 0))))
(invoke "test")
`);

// init: seg ix is valid passive, dst offset past the end, zero len is invalid
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 0x10001) (i32.const 0) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds")
`);

// init: seg ix is valid passive, zero len, but dst offset at the end
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 0x10000) (i32.const 0) (i32.const 0))))
(invoke "test")
`);

// init: seg ix is valid passive, zero len, dst and src offsets at the end
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 0x10000) (i32.const 1) (i32.const 0))))
(invoke "test")
`);

// init: seg ix is valid passive, src and dst offset past the end, zero len is
// invalid
print(
`(module
  ${PREAMBLE}
  (func (export "test")
    (memory.init 0 (i32.const 0x10001) (i32.const 4) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds")
`);

// invalid argument types.  TODO: can add anyfunc etc here.
{
    const tys  = ['i32', 'f32', 'i64', 'f64'];

    for (let ty1 of tys) {
    for (let ty2 of tys) {
    for (let ty3 of tys) {
        if (ty1 == 'i32' && ty2 == 'i32' && ty3 == 'i32')
            continue;  // this is the only valid case
        print(
`(assert_invalid
  (module
    ${PREAMBLE}
    (func (export "test")
      (memory.init 0 (${ty1}.const 1) (${ty2}.const 1) (${ty3}.const 1))))
  "type mismatch")
`);
    }}}
}

// memory.init: out of bounds of the memory or the segment, but should perform
// the operation up to the appropriate bound.
//
// Arithmetic overflow of memoffset + len or of bufferoffset + len should not
// affect the behavior.

// Note, the length of the data segment is 16.
const mem_init_len = 16;

function mem_init(min, max, shared, backup, write) {
    print(
`(module
  (memory ${min} ${max} ${shared})
  (data "\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42\\42")
   ${checkRangeCode()}
  (func (export "run") (param $offs i32) (param $len i32)
    (memory.init 0 (local.get $offs) (i32.const 0) (local.get $len))))
`);
    // A fill writing past the end of the memory should throw *and* have filled
    // all the way up to the end.
    //
    // A fill reading past the end of the segment should throw *and* have filled
    // memory with as much data as was available.
    let offs = min*PAGESIZE - backup;
    print(
`(assert_trap (invoke "run" (i32.const ${offs}) (i32.const ${write}))
              "out of bounds")
`);
    checkRange(0, min, 0);
}

// We exceed the bounds of the memory but not of the data segment
mem_init(1, 1, "", Math.floor(mem_init_len/2), mem_init_len);
mem_init(1, 1, "", Math.floor(mem_init_len/2)+1, mem_init_len);
if (WITH_SHARED_MEMORY) {
    mem_init(2, 4, "shared", Math.floor(mem_init_len/2), mem_init_len);
    mem_init(2, 4, "shared", Math.floor(mem_init_len/2)+1, mem_init_len);
}

// We exceed the bounds of the data segment but not the memory
mem_init(1, 1, "", mem_init_len*4, mem_init_len*2-2);
mem_init(1, 1, "", mem_init_len*4-1, mem_init_len*2-1);
if (WITH_SHARED_MEMORY) {
    mem_init(2, 4, "shared", mem_init_len*4, mem_init_len*2-2);
    mem_init(2, 4, "shared", mem_init_len*4-1, mem_init_len*2-1);
}

// We arithmetically overflow the memory limit but not the segment limit
mem_init(1, "", "", Math.floor(mem_init_len/2), 0xFFFFFF00);

// We arithmetically overflow the segment limit but not the memory limit
mem_init(1, "", "", PAGESIZE, 0xFFFFFFFC);

// Test that the data segment index is properly encoded as an unsigned (not
// signed) LEB.
print(
`
(module
  (memory 1)
  ;; 65 data segments. 64 is the smallest positive number that is encoded
  ;; differently as a signed LEB.
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "") (data "") (data "") (data "") (data "") (data "") (data "") (data "")
  (data "")
  (func (memory.init 64 (i32.const 0) (i32.const 0) (i32.const 0))))
`)
