// This program generates .wast code that contains all the spec tests for
// memory.copy.  See `Makefile`.

print_origin("generate_memory_copy.js");

// In-bounds tests.

function mem_test(instruction, expected_result_vector) {
    print(
`
(module
  (memory (export "memory0") 1 1)
  (data (i32.const 2) "\\03\\01\\04\\01")
  (data (i32.const 12) "\\07\\05\\02\\03\\06")
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

// Copy non-zero over non-zero
mem_test("(memory.copy (i32.const 13) (i32.const 2) (i32.const 3))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,3,1, 4,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Copy non-zero over zero
mem_test("(memory.copy (i32.const 25) (i32.const 15) (i32.const 2))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, 3,6,e,e,e]);

// Copy zero over non-zero
mem_test("(memory.copy (i32.const 13) (i32.const 25) (i32.const 3))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,e,e, e,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Copy zero over zero
mem_test("(memory.copy (i32.const 20) (i32.const 22) (i32.const 4))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Copy zero and non-zero entries, non overlapping
mem_test("(memory.copy (i32.const 25) (i32.const 1) (i32.const 3))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,3,1,e,e]);

// Copy zero and non-zero entries, overlapping, backwards
mem_test("(memory.copy (i32.const 10) (i32.const 12) (i32.const 7))",
         [e,e,3,1,4, 1,e,e,e,e, 7,5,2,3,6, e,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

// Copy zero and non-zero entries, overlapping, forwards
mem_test("(memory.copy (i32.const 12) (i32.const 10) (i32.const 7))",
         [e,e,3,1,4, 1,e,e,e,e, e,e,e,e,7, 5,2,3,6,e, e,e,e,e,e, e,e,e,e,e]);

// Out-of-bounds tests.
//
// The operation is out of bounds of the memory for the source or target, but
// must perform the operation up to the appropriate bound.  Major cases:
//
// - non-overlapping regions
// - overlapping regions with src >= dest
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

function initializers(count, startingAt) {
    let s = "";
    for ( let i=0, j=startingAt; i < count; i++, j++ )
        s += "\\" + (i + 256).toString(16).substring(1);
    return s;
}

function mem_copy(min, max, shared, srcOffs, targetOffs, len) {
    let copyDown = srcOffs < targetOffs;
    let memLength = min * PAGESIZE;
    let targetAvail = memLength - targetOffs;
    let srcAvail = memLength - srcOffs;
    let targetLim = targetOffs + Math.min(len, targetAvail, srcAvail);
    let srcLim = srcOffs + Math.min(len, targetAvail, srcAvail);

    print(
`
(module
  (memory (export "mem") ${min} ${max} ${shared})
  (data (i32.const ${srcOffs}) "${initializers(srcLim - srcOffs, 0)}")
  (func (export "run") (param $targetOffs i32) (param $srcOffs i32) (param $len i32)
    (memory.copy (local.get $targetOffs) (local.get $srcOffs) (local.get $len)))
  (func (export "load8_u") (param i32) (result i32)
    (i32.load8_u (local.get 0))))

(assert_trap (invoke "run" (i32.const ${targetOffs}) (i32.const ${srcOffs}) (i32.const ${len}))
             "out of bounds memory access")
`);

    let immediateOOB = copyDown && (srcOffs + len > memLength || targetOffs + len > memLength);

    var s = 0;
    var i = 0;
    let k = 0;
    for (i=0; i < memLength; i++ ) {
        if (i >= srcOffs && i < srcLim) {
            print(`(assert_return (invoke "load8_u" (i32.const ${i})) (i32.const ${(s++) & 0xFF}))`);
            continue;
        }
        // Only spot-check for zero, or we'll be here all night.
        if (++k == 199) {
            print(`(assert_return (invoke "load8_u" (i32.const ${i})) (i32.const 0))`);
            k = 0;
        }
    }
}

// OOB target address, nonoverlapping
mem_copy(1, 1, "", 0, PAGESIZE-20, 40);
mem_copy(1, 1, "", 0, PAGESIZE-21, 39);
if (WITH_SHARED_MEMORY) {
    mem_copy(2, 4, "shared", 0, 2*PAGESIZE-20, 40);
    mem_copy(2, 4, "shared", 0, 2*PAGESIZE-21, 39);
}

// OOB source address, nonoverlapping
mem_copy(1, 1, "", PAGESIZE-20, 0, 40);
mem_copy(1, 1, "", PAGESIZE-21, 0, 39);
if (WITH_SHARED_MEMORY) {
    mem_copy(2, 4, "shared", 2*PAGESIZE-20, 0, 40);
    mem_copy(2, 4, "shared", 2*PAGESIZE-21, 0, 39);
}

// OOB target address, overlapping, src < target
mem_copy(1, 1, "", PAGESIZE-50, PAGESIZE-20, 40);

// OOB source address, overlapping, target < src
mem_copy(1, 1, "", PAGESIZE-20, PAGESIZE-50, 40);

// OOB both, overlapping, including target == src
mem_copy(1, 1, "", PAGESIZE-30, PAGESIZE-20, 40);
mem_copy(1, 1, "", PAGESIZE-20, PAGESIZE-30, 40);
mem_copy(1, 1, "", PAGESIZE-20, PAGESIZE-20, 40);

// Arithmetic overflow on source address.
mem_copy(1, "", "", PAGESIZE-20, 0, 0xFFFFF000);

// Arithmetic overflow on target adddress is an overlapping case.
mem_copy(1, 1, "", PAGESIZE-0x1000, PAGESIZE-20, 0xFFFFFF00);

// Sundry compilation failures.

// Module doesn't have a memory.
print(
`
(assert_invalid
  (module
    (func (export "testfn")
      (memory.copy (i32.const 10) (i32.const 20) (i32.const 30))))
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
      (memory.copy (${ty1}.const 10) (${ty2}.const 20) (${ty3}.const 30))))
  "type mismatch")
`);
    }}}
}

// Both ranges valid.  Copy 5 bytes backwards by 1 (overlapping).
// result = 0x00--(09) 0x55--(11) 0x00--(pagesize-20)
print(
`
(module
  (memory 1 1)
  (func (export "test")
    (memory.fill (i32.const 10) (i32.const 0x55) (i32.const 10))
    (memory.copy (i32.const 9) (i32.const 10) (i32.const 5)))
  ${checkRangeCode()})
(invoke "test")
`);
checkRange(0,    0+9,     0x00);
checkRange(9,    9+11,    0x55);
checkRange(9+11, 0x10000, 0x00);

// Both ranges valid.  Copy 5 bytes forwards by 1 (overlapping).
// result = 0x00--(10) 0x55--(11) 0x00--(pagesize-19)
print(
`
(module
  (memory 1 1)
  (func (export "test")
    (memory.fill (i32.const 10) (i32.const 0x55) (i32.const 10))
    (memory.copy (i32.const 16) (i32.const 15) (i32.const 5)))
  ${checkRangeCode()})
(invoke "test")
`);
checkRange(0,     0+10,    0x00);
checkRange(10,    10+11,   0x55);
checkRange(10+11, 0x10000, 0x00);

// Destination range invalid
print(
`
(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0xFF00) (i32.const 0x8000) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Destination wraparound the end of 32-bit offset space
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0xFFFFFF00) (i32.const 0x4000) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Source range invalid
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x8000) (i32.const 0xFF00) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Source wraparound the end of 32-bit offset space
print(
`(module
 (memory 1 1)
 (func (export "test")
   (memory.copy (i32.const 0x4000) (i32.const 0xFFFFFF00) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Zero len with both offsets in-bounds is a no-op
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.fill (i32.const 0x0000) (i32.const 0x55) (i32.const 0x8000))
    (memory.fill (i32.const 0x8000) (i32.const 0xAA) (i32.const 0x8000))
    (memory.copy (i32.const 0x9000) (i32.const 0x7000) (i32.const 0)))
  ${checkRangeCode()})
(invoke "test")
`);
checkRange(0x00000, 0x08000, 0x55);
checkRange(0x08000, 0x10000, 0xAA);

// Zero len with dest offset out-of-bounds at the end of memory is allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x10000) (i32.const 0x7000) (i32.const 0))))
(invoke "test")
`);

// Zero len with dest offset out-of-bounds past the end of memory is not allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x20000) (i32.const 0x7000) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Zero len with src offset out-of-bounds at the end of memory is allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x9000) (i32.const 0x10000) (i32.const 0))))
(invoke "test")
`);

// Zero len with src offset out-of-bounds past the end of memory is not allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x9000) (i32.const 0x20000) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// Zero len with both dest and src offsets out-of-bounds at the end of memory is allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x10000) (i32.const 0x10000) (i32.const 0))))
(invoke "test")
`);

// Zero len with both dest and src offsets out-of-bounds past the end of memory is not allowed
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.copy (i32.const 0x20000) (i32.const 0x20000) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

// 100 random fills followed by 100 random copies, in a single-page buffer,
// followed by verification of the (now heavily mashed-around) buffer.
print(
`(module
  (memory 1 1)
  (func (export "test")
    (memory.fill (i32.const 17767) (i32.const 1) (i32.const 1344))
    (memory.fill (i32.const 39017) (i32.const 2) (i32.const 1055))
    (memory.fill (i32.const 56401) (i32.const 3) (i32.const 988))
    (memory.fill (i32.const 37962) (i32.const 4) (i32.const 322))
    (memory.fill (i32.const 7977) (i32.const 5) (i32.const 1994))
    (memory.fill (i32.const 22714) (i32.const 6) (i32.const 3036))
    (memory.fill (i32.const 16882) (i32.const 7) (i32.const 2372))
    (memory.fill (i32.const 43491) (i32.const 8) (i32.const 835))
    (memory.fill (i32.const 124) (i32.const 9) (i32.const 1393))
    (memory.fill (i32.const 2132) (i32.const 10) (i32.const 2758))
    (memory.fill (i32.const 8987) (i32.const 11) (i32.const 3098))
    (memory.fill (i32.const 52711) (i32.const 12) (i32.const 741))
    (memory.fill (i32.const 3958) (i32.const 13) (i32.const 2823))
    (memory.fill (i32.const 49715) (i32.const 14) (i32.const 1280))
    (memory.fill (i32.const 50377) (i32.const 15) (i32.const 1466))
    (memory.fill (i32.const 20493) (i32.const 16) (i32.const 3158))
    (memory.fill (i32.const 47665) (i32.const 17) (i32.const 544))
    (memory.fill (i32.const 12451) (i32.const 18) (i32.const 2669))
    (memory.fill (i32.const 24869) (i32.const 19) (i32.const 2651))
    (memory.fill (i32.const 45317) (i32.const 20) (i32.const 1570))
    (memory.fill (i32.const 43096) (i32.const 21) (i32.const 1691))
    (memory.fill (i32.const 33886) (i32.const 22) (i32.const 646))
    (memory.fill (i32.const 48555) (i32.const 23) (i32.const 1858))
    (memory.fill (i32.const 53453) (i32.const 24) (i32.const 2657))
    (memory.fill (i32.const 30363) (i32.const 25) (i32.const 981))
    (memory.fill (i32.const 9300) (i32.const 26) (i32.const 1807))
    (memory.fill (i32.const 50190) (i32.const 27) (i32.const 487))
    (memory.fill (i32.const 62753) (i32.const 28) (i32.const 530))
    (memory.fill (i32.const 36316) (i32.const 29) (i32.const 943))
    (memory.fill (i32.const 6768) (i32.const 30) (i32.const 381))
    (memory.fill (i32.const 51262) (i32.const 31) (i32.const 3089))
    (memory.fill (i32.const 49729) (i32.const 32) (i32.const 658))
    (memory.fill (i32.const 44540) (i32.const 33) (i32.const 1702))
    (memory.fill (i32.const 33342) (i32.const 34) (i32.const 1092))
    (memory.fill (i32.const 50814) (i32.const 35) (i32.const 1410))
    (memory.fill (i32.const 47594) (i32.const 36) (i32.const 2204))
    (memory.fill (i32.const 54123) (i32.const 37) (i32.const 2394))
    (memory.fill (i32.const 55183) (i32.const 38) (i32.const 250))
    (memory.fill (i32.const 22620) (i32.const 39) (i32.const 2097))
    (memory.fill (i32.const 17132) (i32.const 40) (i32.const 3264))
    (memory.fill (i32.const 54331) (i32.const 41) (i32.const 3299))
    (memory.fill (i32.const 39474) (i32.const 42) (i32.const 2796))
    (memory.fill (i32.const 36156) (i32.const 43) (i32.const 2070))
    (memory.fill (i32.const 35308) (i32.const 44) (i32.const 2763))
    (memory.fill (i32.const 32731) (i32.const 45) (i32.const 312))
    (memory.fill (i32.const 63746) (i32.const 46) (i32.const 192))
    (memory.fill (i32.const 30974) (i32.const 47) (i32.const 596))
    (memory.fill (i32.const 16635) (i32.const 48) (i32.const 501))
    (memory.fill (i32.const 57002) (i32.const 49) (i32.const 686))
    (memory.fill (i32.const 34299) (i32.const 50) (i32.const 385))
    (memory.fill (i32.const 60881) (i32.const 51) (i32.const 903))
    (memory.fill (i32.const 61445) (i32.const 52) (i32.const 2390))
    (memory.fill (i32.const 46972) (i32.const 53) (i32.const 1441))
    (memory.fill (i32.const 25973) (i32.const 54) (i32.const 3162))
    (memory.fill (i32.const 5566) (i32.const 55) (i32.const 2135))
    (memory.fill (i32.const 35977) (i32.const 56) (i32.const 519))
    (memory.fill (i32.const 44892) (i32.const 57) (i32.const 3280))
    (memory.fill (i32.const 46760) (i32.const 58) (i32.const 1678))
    (memory.fill (i32.const 46607) (i32.const 59) (i32.const 3168))
    (memory.fill (i32.const 22449) (i32.const 60) (i32.const 1441))
    (memory.fill (i32.const 58609) (i32.const 61) (i32.const 663))
    (memory.fill (i32.const 32261) (i32.const 62) (i32.const 1671))
    (memory.fill (i32.const 3063) (i32.const 63) (i32.const 721))
    (memory.fill (i32.const 34025) (i32.const 64) (i32.const 84))
    (memory.fill (i32.const 33338) (i32.const 65) (i32.const 2029))
    (memory.fill (i32.const 36810) (i32.const 66) (i32.const 29))
    (memory.fill (i32.const 19147) (i32.const 67) (i32.const 3034))
    (memory.fill (i32.const 12616) (i32.const 68) (i32.const 1043))
    (memory.fill (i32.const 18276) (i32.const 69) (i32.const 3324))
    (memory.fill (i32.const 4639) (i32.const 70) (i32.const 1091))
    (memory.fill (i32.const 16158) (i32.const 71) (i32.const 1997))
    (memory.fill (i32.const 18204) (i32.const 72) (i32.const 2259))
    (memory.fill (i32.const 50532) (i32.const 73) (i32.const 3189))
    (memory.fill (i32.const 11028) (i32.const 74) (i32.const 1968))
    (memory.fill (i32.const 15962) (i32.const 75) (i32.const 1455))
    (memory.fill (i32.const 45406) (i32.const 76) (i32.const 1177))
    (memory.fill (i32.const 54137) (i32.const 77) (i32.const 1568))
    (memory.fill (i32.const 33083) (i32.const 78) (i32.const 1642))
    (memory.fill (i32.const 61028) (i32.const 79) (i32.const 3284))
    (memory.fill (i32.const 51729) (i32.const 80) (i32.const 223))
    (memory.fill (i32.const 4361) (i32.const 81) (i32.const 2171))
    (memory.fill (i32.const 57514) (i32.const 82) (i32.const 1322))
    (memory.fill (i32.const 55724) (i32.const 83) (i32.const 2648))
    (memory.fill (i32.const 24091) (i32.const 84) (i32.const 1045))
    (memory.fill (i32.const 43183) (i32.const 85) (i32.const 3097))
    (memory.fill (i32.const 32307) (i32.const 86) (i32.const 2796))
    (memory.fill (i32.const 3811) (i32.const 87) (i32.const 2010))
    (memory.fill (i32.const 54856) (i32.const 88) (i32.const 0))
    (memory.fill (i32.const 49941) (i32.const 89) (i32.const 2069))
    (memory.fill (i32.const 20411) (i32.const 90) (i32.const 2896))
    (memory.fill (i32.const 33826) (i32.const 91) (i32.const 192))
    (memory.fill (i32.const 9402) (i32.const 92) (i32.const 2195))
    (memory.fill (i32.const 12413) (i32.const 93) (i32.const 24))
    (memory.fill (i32.const 14091) (i32.const 94) (i32.const 577))
    (memory.fill (i32.const 44058) (i32.const 95) (i32.const 2089))
    (memory.fill (i32.const 36735) (i32.const 96) (i32.const 3436))
    (memory.fill (i32.const 23288) (i32.const 97) (i32.const 2765))
    (memory.fill (i32.const 6392) (i32.const 98) (i32.const 830))
    (memory.fill (i32.const 33307) (i32.const 99) (i32.const 1938))
    (memory.fill (i32.const 21941) (i32.const 100) (i32.const 2750))
    (memory.copy (i32.const 59214) (i32.const 54248) (i32.const 2098))
    (memory.copy (i32.const 63026) (i32.const 39224) (i32.const 230))
    (memory.copy (i32.const 51833) (i32.const 23629) (i32.const 2300))
    (memory.copy (i32.const 6708) (i32.const 23996) (i32.const 639))
    (memory.copy (i32.const 6990) (i32.const 33399) (i32.const 1097))
    (memory.copy (i32.const 19403) (i32.const 10348) (i32.const 3197))
    (memory.copy (i32.const 27308) (i32.const 54406) (i32.const 100))
    (memory.copy (i32.const 27221) (i32.const 43682) (i32.const 1717))
    (memory.copy (i32.const 60528) (i32.const 8629) (i32.const 119))
    (memory.copy (i32.const 5947) (i32.const 2308) (i32.const 658))
    (memory.copy (i32.const 4787) (i32.const 51631) (i32.const 2269))
    (memory.copy (i32.const 12617) (i32.const 19197) (i32.const 833))
    (memory.copy (i32.const 11854) (i32.const 46505) (i32.const 3300))
    (memory.copy (i32.const 11376) (i32.const 45012) (i32.const 2281))
    (memory.copy (i32.const 34186) (i32.const 6697) (i32.const 2572))
    (memory.copy (i32.const 4936) (i32.const 1690) (i32.const 1328))
    (memory.copy (i32.const 63164) (i32.const 7637) (i32.const 1670))
    (memory.copy (i32.const 44568) (i32.const 18344) (i32.const 33))
    (memory.copy (i32.const 43918) (i32.const 22348) (i32.const 1427))
    (memory.copy (i32.const 46637) (i32.const 49819) (i32.const 1434))
    (memory.copy (i32.const 63684) (i32.const 8755) (i32.const 834))
    (memory.copy (i32.const 33485) (i32.const 20131) (i32.const 3317))
    (memory.copy (i32.const 40575) (i32.const 54317) (i32.const 3201))
    (memory.copy (i32.const 25812) (i32.const 59254) (i32.const 2452))
    (memory.copy (i32.const 19678) (i32.const 56882) (i32.const 346))
    (memory.copy (i32.const 15852) (i32.const 35914) (i32.const 2430))
    (memory.copy (i32.const 11824) (i32.const 35574) (i32.const 300))
    (memory.copy (i32.const 59427) (i32.const 13957) (i32.const 3153))
    (memory.copy (i32.const 34299) (i32.const 60594) (i32.const 1281))
    (memory.copy (i32.const 8964) (i32.const 12276) (i32.const 943))
    (memory.copy (i32.const 2827) (i32.const 10425) (i32.const 1887))
    (memory.copy (i32.const 43194) (i32.const 43910) (i32.const 738))
    (memory.copy (i32.const 63038) (i32.const 18949) (i32.const 122))
    (memory.copy (i32.const 24044) (i32.const 44761) (i32.const 1755))
    (memory.copy (i32.const 22608) (i32.const 14755) (i32.const 702))
    (memory.copy (i32.const 11284) (i32.const 26579) (i32.const 1830))
    (memory.copy (i32.const 23092) (i32.const 20471) (i32.const 1064))
    (memory.copy (i32.const 57248) (i32.const 54770) (i32.const 2631))
    (memory.copy (i32.const 25492) (i32.const 1025) (i32.const 3113))
    (memory.copy (i32.const 49588) (i32.const 44220) (i32.const 975))
    (memory.copy (i32.const 28280) (i32.const 41722) (i32.const 2336))
    (memory.copy (i32.const 61289) (i32.const 230) (i32.const 2872))
    (memory.copy (i32.const 22480) (i32.const 52506) (i32.const 2197))
    (memory.copy (i32.const 40553) (i32.const 9578) (i32.const 1958))
    (memory.copy (i32.const 29004) (i32.const 20862) (i32.const 2186))
    (memory.copy (i32.const 53029) (i32.const 43955) (i32.const 1037))
    (memory.copy (i32.const 25476) (i32.const 35667) (i32.const 1650))
    (memory.copy (i32.const 58516) (i32.const 45819) (i32.const 1986))
    (memory.copy (i32.const 38297) (i32.const 5776) (i32.const 1955))
    (memory.copy (i32.const 28503) (i32.const 55364) (i32.const 2368))
    (memory.copy (i32.const 62619) (i32.const 18108) (i32.const 1356))
    (memory.copy (i32.const 50149) (i32.const 13861) (i32.const 382))
    (memory.copy (i32.const 16904) (i32.const 36341) (i32.const 1900))
    (memory.copy (i32.const 48098) (i32.const 11358) (i32.const 2807))
    (memory.copy (i32.const 28512) (i32.const 40362) (i32.const 323))
    (memory.copy (i32.const 35506) (i32.const 27856) (i32.const 1670))
    (memory.copy (i32.const 62970) (i32.const 53332) (i32.const 1341))
    (memory.copy (i32.const 14133) (i32.const 46312) (i32.const 644))
    (memory.copy (i32.const 29030) (i32.const 19074) (i32.const 496))
    (memory.copy (i32.const 44952) (i32.const 47577) (i32.const 2784))
    (memory.copy (i32.const 39559) (i32.const 44661) (i32.const 1350))
    (memory.copy (i32.const 10352) (i32.const 29274) (i32.const 1475))
    (memory.copy (i32.const 46911) (i32.const 46178) (i32.const 1467))
    (memory.copy (i32.const 4905) (i32.const 28740) (i32.const 1895))
    (memory.copy (i32.const 38012) (i32.const 57253) (i32.const 1751))
    (memory.copy (i32.const 26446) (i32.const 27223) (i32.const 1127))
    (memory.copy (i32.const 58835) (i32.const 24657) (i32.const 1063))
    (memory.copy (i32.const 61356) (i32.const 38790) (i32.const 766))
    (memory.copy (i32.const 44160) (i32.const 2284) (i32.const 1520))
    (memory.copy (i32.const 32740) (i32.const 47237) (i32.const 3014))
    (memory.copy (i32.const 11148) (i32.const 21260) (i32.const 1011))
    (memory.copy (i32.const 7665) (i32.const 31612) (i32.const 3034))
    (memory.copy (i32.const 18044) (i32.const 12987) (i32.const 3320))
    (memory.copy (i32.const 57306) (i32.const 55905) (i32.const 308))
    (memory.copy (i32.const 24675) (i32.const 16815) (i32.const 1155))
    (memory.copy (i32.const 19900) (i32.const 10115) (i32.const 722))
    (memory.copy (i32.const 2921) (i32.const 5935) (i32.const 2370))
    (memory.copy (i32.const 32255) (i32.const 50095) (i32.const 2926))
    (memory.copy (i32.const 15126) (i32.const 17299) (i32.const 2607))
    (memory.copy (i32.const 45575) (i32.const 28447) (i32.const 2045))
    (memory.copy (i32.const 55149) (i32.const 36113) (i32.const 2596))
    (memory.copy (i32.const 28461) (i32.const 54157) (i32.const 1168))
    (memory.copy (i32.const 47951) (i32.const 53385) (i32.const 3137))
    (memory.copy (i32.const 30646) (i32.const 45155) (i32.const 2649))
    (memory.copy (i32.const 5057) (i32.const 4295) (i32.const 52))
    (memory.copy (i32.const 6692) (i32.const 24195) (i32.const 441))
    (memory.copy (i32.const 32984) (i32.const 27117) (i32.const 3445))
    (memory.copy (i32.const 32530) (i32.const 59372) (i32.const 2785))
    (memory.copy (i32.const 34361) (i32.const 8962) (i32.const 2406))
    (memory.copy (i32.const 17893) (i32.const 54538) (i32.const 3381))
    (memory.copy (i32.const 22685) (i32.const 44151) (i32.const 136))
    (memory.copy (i32.const 59089) (i32.const 7077) (i32.const 1045))
    (memory.copy (i32.const 42945) (i32.const 55028) (i32.const 2389))
    (memory.copy (i32.const 44693) (i32.const 20138) (i32.const 877))
    (memory.copy (i32.const 36810) (i32.const 25196) (i32.const 3447))
    (memory.copy (i32.const 45742) (i32.const 31888) (i32.const 854))
    (memory.copy (i32.const 24236) (i32.const 31866) (i32.const 1377))
    (memory.copy (i32.const 33778) (i32.const 692) (i32.const 1594))
    (memory.copy (i32.const 60618) (i32.const 18585) (i32.const 2987))
    (memory.copy (i32.const 50370) (i32.const 41271) (i32.const 1406))
  )
  ${checkRangeCode()})
(invoke "test")
`);
checkRange(0, 124, 0);
checkRange(124, 1517, 9);
checkRange(1517, 2132, 0);
checkRange(2132, 2827, 10);
checkRange(2827, 2921, 92);
checkRange(2921, 3538, 83);
checkRange(3538, 3786, 77);
checkRange(3786, 4042, 97);
checkRange(4042, 4651, 99);
checkRange(4651, 5057, 0);
checkRange(5057, 5109, 99);
checkRange(5109, 5291, 0);
checkRange(5291, 5524, 72);
checkRange(5524, 5691, 92);
checkRange(5691, 6552, 83);
checkRange(6552, 7133, 77);
checkRange(7133, 7665, 99);
checkRange(7665, 8314, 0);
checkRange(8314, 8360, 62);
checkRange(8360, 8793, 86);
checkRange(8793, 8979, 83);
checkRange(8979, 9373, 79);
checkRange(9373, 9518, 95);
checkRange(9518, 9934, 59);
checkRange(9934, 10087, 77);
checkRange(10087, 10206, 5);
checkRange(10206, 10230, 77);
checkRange(10230, 10249, 41);
checkRange(10249, 11148, 83);
checkRange(11148, 11356, 74);
checkRange(11356, 11380, 93);
checkRange(11380, 11939, 74);
checkRange(11939, 12159, 68);
checkRange(12159, 12575, 83);
checkRange(12575, 12969, 79);
checkRange(12969, 13114, 95);
checkRange(13114, 14133, 59);
checkRange(14133, 14404, 76);
checkRange(14404, 14428, 57);
checkRange(14428, 14458, 59);
checkRange(14458, 14580, 32);
checkRange(14580, 14777, 89);
checkRange(14777, 15124, 59);
checkRange(15124, 15126, 36);
checkRange(15126, 15192, 100);
checkRange(15192, 15871, 96);
checkRange(15871, 15998, 95);
checkRange(15998, 17017, 59);
checkRange(17017, 17288, 76);
checkRange(17288, 17312, 57);
checkRange(17312, 17342, 59);
checkRange(17342, 17464, 32);
checkRange(17464, 17661, 89);
checkRange(17661, 17727, 59);
checkRange(17727, 17733, 5);
checkRange(17733, 17893, 96);
checkRange(17893, 18553, 77);
checkRange(18553, 18744, 42);
checkRange(18744, 18801, 76);
checkRange(18801, 18825, 57);
checkRange(18825, 18876, 59);
checkRange(18876, 18885, 77);
checkRange(18885, 18904, 41);
checkRange(18904, 19567, 83);
checkRange(19567, 20403, 96);
checkRange(20403, 21274, 77);
checkRange(21274, 21364, 100);
checkRange(21364, 21468, 74);
checkRange(21468, 21492, 93);
checkRange(21492, 22051, 74);
checkRange(22051, 22480, 68);
checkRange(22480, 22685, 100);
checkRange(22685, 22694, 68);
checkRange(22694, 22821, 10);
checkRange(22821, 22869, 100);
checkRange(22869, 24107, 97);
checkRange(24107, 24111, 37);
checkRange(24111, 24236, 77);
checkRange(24236, 24348, 72);
checkRange(24348, 24515, 92);
checkRange(24515, 24900, 83);
checkRange(24900, 25136, 95);
checkRange(25136, 25182, 85);
checkRange(25182, 25426, 68);
checkRange(25426, 25613, 89);
checkRange(25613, 25830, 96);
checkRange(25830, 26446, 100);
checkRange(26446, 26517, 10);
checkRange(26517, 27468, 92);
checkRange(27468, 27503, 95);
checkRange(27503, 27573, 77);
checkRange(27573, 28245, 92);
checkRange(28245, 28280, 95);
checkRange(28280, 29502, 77);
checkRange(29502, 29629, 42);
checkRange(29629, 30387, 83);
checkRange(30387, 30646, 77);
checkRange(30646, 31066, 92);
checkRange(31066, 31131, 77);
checkRange(31131, 31322, 42);
checkRange(31322, 31379, 76);
checkRange(31379, 31403, 57);
checkRange(31403, 31454, 59);
checkRange(31454, 31463, 77);
checkRange(31463, 31482, 41);
checkRange(31482, 31649, 83);
checkRange(31649, 31978, 72);
checkRange(31978, 32145, 92);
checkRange(32145, 32530, 83);
checkRange(32530, 32766, 95);
checkRange(32766, 32812, 85);
checkRange(32812, 33056, 68);
checkRange(33056, 33660, 89);
checkRange(33660, 33752, 59);
checkRange(33752, 33775, 36);
checkRange(33775, 33778, 32);
checkRange(33778, 34603, 9);
checkRange(34603, 35218, 0);
checkRange(35218, 35372, 10);
checkRange(35372, 35486, 77);
checkRange(35486, 35605, 5);
checkRange(35605, 35629, 77);
checkRange(35629, 35648, 41);
checkRange(35648, 36547, 83);
checkRange(36547, 36755, 74);
checkRange(36755, 36767, 93);
checkRange(36767, 36810, 83);
checkRange(36810, 36839, 100);
checkRange(36839, 37444, 96);
checkRange(37444, 38060, 100);
checkRange(38060, 38131, 10);
checkRange(38131, 39082, 92);
checkRange(39082, 39117, 95);
checkRange(39117, 39187, 77);
checkRange(39187, 39859, 92);
checkRange(39859, 39894, 95);
checkRange(39894, 40257, 77);
checkRange(40257, 40344, 89);
checkRange(40344, 40371, 59);
checkRange(40371, 40804, 77);
checkRange(40804, 40909, 5);
checkRange(40909, 42259, 92);
checkRange(42259, 42511, 77);
checkRange(42511, 42945, 83);
checkRange(42945, 43115, 77);
checkRange(43115, 43306, 42);
checkRange(43306, 43363, 76);
checkRange(43363, 43387, 57);
checkRange(43387, 43438, 59);
checkRange(43438, 43447, 77);
checkRange(43447, 43466, 41);
checkRange(43466, 44129, 83);
checkRange(44129, 44958, 96);
checkRange(44958, 45570, 77);
checkRange(45570, 45575, 92);
checkRange(45575, 45640, 77);
checkRange(45640, 45742, 42);
checkRange(45742, 45832, 72);
checkRange(45832, 45999, 92);
checkRange(45999, 46384, 83);
checkRange(46384, 46596, 95);
checkRange(46596, 46654, 92);
checkRange(46654, 47515, 83);
checkRange(47515, 47620, 77);
checkRange(47620, 47817, 79);
checkRange(47817, 47951, 95);
checkRange(47951, 48632, 100);
checkRange(48632, 48699, 97);
checkRange(48699, 48703, 37);
checkRange(48703, 49764, 77);
checkRange(49764, 49955, 42);
checkRange(49955, 50012, 76);
checkRange(50012, 50036, 57);
checkRange(50036, 50087, 59);
checkRange(50087, 50096, 77);
checkRange(50096, 50115, 41);
checkRange(50115, 50370, 83);
checkRange(50370, 51358, 92);
checkRange(51358, 51610, 77);
checkRange(51610, 51776, 83);
checkRange(51776, 51833, 89);
checkRange(51833, 52895, 100);
checkRange(52895, 53029, 97);
checkRange(53029, 53244, 68);
checkRange(53244, 54066, 100);
checkRange(54066, 54133, 97);
checkRange(54133, 54137, 37);
checkRange(54137, 55198, 77);
checkRange(55198, 55389, 42);
checkRange(55389, 55446, 76);
checkRange(55446, 55470, 57);
checkRange(55470, 55521, 59);
checkRange(55521, 55530, 77);
checkRange(55530, 55549, 41);
checkRange(55549, 56212, 83);
checkRange(56212, 57048, 96);
checkRange(57048, 58183, 77);
checkRange(58183, 58202, 41);
checkRange(58202, 58516, 83);
checkRange(58516, 58835, 95);
checkRange(58835, 58855, 77);
checkRange(58855, 59089, 95);
checkRange(59089, 59145, 77);
checkRange(59145, 59677, 99);
checkRange(59677, 60134, 0);
checkRange(60134, 60502, 89);
checkRange(60502, 60594, 59);
checkRange(60594, 60617, 36);
checkRange(60617, 60618, 32);
checkRange(60618, 60777, 42);
checkRange(60777, 60834, 76);
checkRange(60834, 60858, 57);
checkRange(60858, 60909, 59);
checkRange(60909, 60918, 77);
checkRange(60918, 60937, 41);
checkRange(60937, 61600, 83);
checkRange(61600, 62436, 96);
checkRange(62436, 63307, 77);
checkRange(63307, 63397, 100);
checkRange(63397, 63501, 74);
checkRange(63501, 63525, 93);
checkRange(63525, 63605, 74);
checkRange(63605, 63704, 100);
checkRange(63704, 63771, 97);
checkRange(63771, 63775, 37);
checkRange(63775, 64311, 77);
checkRange(64311, 64331, 26);
checkRange(64331, 64518, 92);
checkRange(64518, 64827, 11);
checkRange(64827, 64834, 26);
checkRange(64834, 65536, 0);
