// This program generates .wast code that contains all the spec tests for
// memory.copy.  See `Makefile`.

print_origin("generate_memory_copy.js");

for ( const memtype of ['i32', 'i64'] ) {

  const decltype = memtype == 'i64' ? ' i64' : '';

  // In-bounds tests.

  function mem_test(instruction, expected_result_vector) {
      print(
`
(module
  (memory (export "memory0")${decltype} 1 1)
  (data (${memtype}.const 2) "\\03\\01\\04\\01")
  (data (${memtype}.const 12) "\\07\\05\\02\\03\\06")
  (func (export "test")
    ${instruction})
  (func (export "load8_u") (param ${memtype}) (result i32)
    (i32.load8_u (local.get 0))))

(invoke "test")
`);
      for (let i = 0; i < expected_result_vector.length; i++) {
          print(`(assert_return (invoke "load8_u" (${memtype}.const ${i})) (i32.const ${expected_result_vector[i]}))`);
      }
  }

  const e = 0;

  // This just gives the initial state of the memory, with its active
  // initialisers applied.
  mem_test("(nop)",
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

  // Copy non-zero over non-zero
  mem_test(`(memory.copy (${memtype}.const 13) (${memtype}.const 2) (${memtype}.const 3))`,
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,3,1, 4,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

  // Copy non-zero over zero
  mem_test(`(memory.copy (${memtype}.const 25) (${memtype}.const 15) (${memtype}.const 2))`,
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, 3,6,e,e,e]);

  // Copy zero over non-zero
  mem_test(`(memory.copy (${memtype}.const 13) (${memtype}.const 25) (${memtype}.const 3))`,
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,e,e, e,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

  // Copy zero over zero
  mem_test(`(memory.copy (${memtype}.const 20) (${memtype}.const 22) (${memtype}.const 4))`,
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,e,e,e,e]);

  // Copy zero and non-zero entries, non overlapping
  mem_test(`(memory.copy (${memtype}.const 25) (${memtype}.const 1) (${memtype}.const 3))`,
           [e,e,3,1,4, 1,e,e,e,e, e,e,7,5,2, 3,6,e,e,e, e,e,e,e,e, e,3,1,e,e]);

  // Copy zero and non-zero entries, overlapping, backwards
  mem_test(`(memory.copy (${memtype}.const 10) (${memtype}.const 12) (${memtype}.const 7))`,
           [e,e,3,1,4, 1,e,e,e,e, 7,5,2,3,6, e,e,e,e,e, e,e,e,e,e, e,e,e,e,e]);

  // Copy zero and non-zero entries, overlapping, forwards
  mem_test(`(memory.copy (${memtype}.const 12) (${memtype}.const 10) (${memtype}.const 7))`,
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
      (memory.copy (${memtype}.const 10) (${memtype}.const 20) (${memtype}.const 30))))
  "unknown memory 0")
`);

  // Invalid argument types.  TODO: We can add anyref, funcref, etc here.
  {
      const tys = ['i32', 'f32', 'i64', 'f64'];
      for (let ty1 of tys) {
      for (let ty2 of tys) {
      for (let ty3 of tys) {
          if (ty1 == memtype && ty2 == memtype && ty3 == memtype)
              continue;  // this is the only valid case
          print(
`(assert_invalid
  (module
    (memory${decltype} 1 1)
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
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.fill (${memtype}.const 10) (i32.const 0x55) (${memtype}.const 10))
    (memory.copy (${memtype}.const 9) (${memtype}.const 10) (${memtype}.const 5)))
  ${checkRangeCode(memtype)})
(invoke "test")
`);
  checkRange(memtype, 0,    0+9,     0x00);
  checkRange(memtype, 9,    9+11,    0x55);
  checkRange(memtype, 9+11, 0x10000, 0x00);

  // Both ranges valid.  Copy 5 bytes forwards by 1 (overlapping).
  // result = 0x00--(10) 0x55--(11) 0x00--(pagesize-19)
  print(
`
(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.fill (${memtype}.const 10) (i32.const 0x55) (${memtype}.const 10))
    (memory.copy (${memtype}.const 16) (${memtype}.const 15) (${memtype}.const 5)))
  ${checkRangeCode(memtype)})
(invoke "test")
`);
  checkRange(memtype, 0,     0+10,    0x00);
  checkRange(memtype, 10,    10+11,   0x55);
  checkRange(memtype, 10+11, 0x10000, 0x00);

  // Destination range invalid
  print(
`
(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0xFF00) (${memtype}.const 0x8000) (${memtype}.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Destination wraparound the end of 32-bit offset space
print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0xFFFFFF00) (${memtype}.const 0x4000) (${memtype}.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Source range invalid
print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x8000) (${memtype}.const 0xFF00) (${memtype}.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Source wraparound the end of 32-bit offset space
print(
`(module
 (memory${decltype} 1 1)
 (func (export "test")
   (memory.copy (${memtype}.const 0x4000) (${memtype}.const 0xFFFFFF00) (${memtype}.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Zero len with both offsets in-bounds is a no-op
print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.fill (${memtype}.const 0x0000) (i32.const 0x55) (${memtype}.const 0x8000))
    (memory.fill (${memtype}.const 0x8000) (i32.const 0xAA) (${memtype}.const 0x8000))
    (memory.copy (${memtype}.const 0x9000) (${memtype}.const 0x7000) (${memtype}.const 0)))
  ${checkRangeCode(memtype)})
(invoke "test")
`);
  checkRange(memtype, 0x00000, 0x08000, 0x55);
  checkRange(memtype, 0x08000, 0x10000, 0xAA);

  // Zero len with dest offset out-of-bounds at the end of memory is allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x10000) (${memtype}.const 0x7000) (${memtype}.const 0))))
(invoke "test")
`);

  // Zero len with dest offset out-of-bounds past the end of memory is not allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x20000) (${memtype}.const 0x7000) (${memtype}.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Zero len with src offset out-of-bounds at the end of memory is allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x9000) (${memtype}.const 0x10000) (${memtype}.const 0))))
(invoke "test")
`);

  // Zero len with src offset out-of-bounds past the end of memory is not allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x9000) (${memtype}.const 0x20000) (${memtype}.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // Zero len with both dest and src offsets out-of-bounds at the end of memory is allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x10000) (${memtype}.const 0x10000) (${memtype}.const 0))))
(invoke "test")
`);

  // Zero len with both dest and src offsets out-of-bounds past the end of memory is not allowed
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.copy (${memtype}.const 0x20000) (${memtype}.const 0x20000) (${memtype}.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
`);

  // 100 random fills followed by 100 random copies, in a single-page buffer,
  // followed by verification of the (now heavily mashed-around) buffer.
  print(
`(module
  (memory${decltype} 1 1)
  (func (export "test")
    (memory.fill (${memtype}.const 17767) (i32.const 1) (${memtype}.const 1344))
    (memory.fill (${memtype}.const 39017) (i32.const 2) (${memtype}.const 1055))
    (memory.fill (${memtype}.const 56401) (i32.const 3) (${memtype}.const 988))
    (memory.fill (${memtype}.const 37962) (i32.const 4) (${memtype}.const 322))
    (memory.fill (${memtype}.const 7977) (i32.const 5) (${memtype}.const 1994))
    (memory.fill (${memtype}.const 22714) (i32.const 6) (${memtype}.const 3036))
    (memory.fill (${memtype}.const 16882) (i32.const 7) (${memtype}.const 2372))
    (memory.fill (${memtype}.const 43491) (i32.const 8) (${memtype}.const 835))
    (memory.fill (${memtype}.const 124) (i32.const 9) (${memtype}.const 1393))
    (memory.fill (${memtype}.const 2132) (i32.const 10) (${memtype}.const 2758))
    (memory.fill (${memtype}.const 8987) (i32.const 11) (${memtype}.const 3098))
    (memory.fill (${memtype}.const 52711) (i32.const 12) (${memtype}.const 741))
    (memory.fill (${memtype}.const 3958) (i32.const 13) (${memtype}.const 2823))
    (memory.fill (${memtype}.const 49715) (i32.const 14) (${memtype}.const 1280))
    (memory.fill (${memtype}.const 50377) (i32.const 15) (${memtype}.const 1466))
    (memory.fill (${memtype}.const 20493) (i32.const 16) (${memtype}.const 3158))
    (memory.fill (${memtype}.const 47665) (i32.const 17) (${memtype}.const 544))
    (memory.fill (${memtype}.const 12451) (i32.const 18) (${memtype}.const 2669))
    (memory.fill (${memtype}.const 24869) (i32.const 19) (${memtype}.const 2651))
    (memory.fill (${memtype}.const 45317) (i32.const 20) (${memtype}.const 1570))
    (memory.fill (${memtype}.const 43096) (i32.const 21) (${memtype}.const 1691))
    (memory.fill (${memtype}.const 33886) (i32.const 22) (${memtype}.const 646))
    (memory.fill (${memtype}.const 48555) (i32.const 23) (${memtype}.const 1858))
    (memory.fill (${memtype}.const 53453) (i32.const 24) (${memtype}.const 2657))
    (memory.fill (${memtype}.const 30363) (i32.const 25) (${memtype}.const 981))
    (memory.fill (${memtype}.const 9300) (i32.const 26) (${memtype}.const 1807))
    (memory.fill (${memtype}.const 50190) (i32.const 27) (${memtype}.const 487))
    (memory.fill (${memtype}.const 62753) (i32.const 28) (${memtype}.const 530))
    (memory.fill (${memtype}.const 36316) (i32.const 29) (${memtype}.const 943))
    (memory.fill (${memtype}.const 6768) (i32.const 30) (${memtype}.const 381))
    (memory.fill (${memtype}.const 51262) (i32.const 31) (${memtype}.const 3089))
    (memory.fill (${memtype}.const 49729) (i32.const 32) (${memtype}.const 658))
    (memory.fill (${memtype}.const 44540) (i32.const 33) (${memtype}.const 1702))
    (memory.fill (${memtype}.const 33342) (i32.const 34) (${memtype}.const 1092))
    (memory.fill (${memtype}.const 50814) (i32.const 35) (${memtype}.const 1410))
    (memory.fill (${memtype}.const 47594) (i32.const 36) (${memtype}.const 2204))
    (memory.fill (${memtype}.const 54123) (i32.const 37) (${memtype}.const 2394))
    (memory.fill (${memtype}.const 55183) (i32.const 38) (${memtype}.const 250))
    (memory.fill (${memtype}.const 22620) (i32.const 39) (${memtype}.const 2097))
    (memory.fill (${memtype}.const 17132) (i32.const 40) (${memtype}.const 3264))
    (memory.fill (${memtype}.const 54331) (i32.const 41) (${memtype}.const 3299))
    (memory.fill (${memtype}.const 39474) (i32.const 42) (${memtype}.const 2796))
    (memory.fill (${memtype}.const 36156) (i32.const 43) (${memtype}.const 2070))
    (memory.fill (${memtype}.const 35308) (i32.const 44) (${memtype}.const 2763))
    (memory.fill (${memtype}.const 32731) (i32.const 45) (${memtype}.const 312))
    (memory.fill (${memtype}.const 63746) (i32.const 46) (${memtype}.const 192))
    (memory.fill (${memtype}.const 30974) (i32.const 47) (${memtype}.const 596))
    (memory.fill (${memtype}.const 16635) (i32.const 48) (${memtype}.const 501))
    (memory.fill (${memtype}.const 57002) (i32.const 49) (${memtype}.const 686))
    (memory.fill (${memtype}.const 34299) (i32.const 50) (${memtype}.const 385))
    (memory.fill (${memtype}.const 60881) (i32.const 51) (${memtype}.const 903))
    (memory.fill (${memtype}.const 61445) (i32.const 52) (${memtype}.const 2390))
    (memory.fill (${memtype}.const 46972) (i32.const 53) (${memtype}.const 1441))
    (memory.fill (${memtype}.const 25973) (i32.const 54) (${memtype}.const 3162))
    (memory.fill (${memtype}.const 5566) (i32.const 55) (${memtype}.const 2135))
    (memory.fill (${memtype}.const 35977) (i32.const 56) (${memtype}.const 519))
    (memory.fill (${memtype}.const 44892) (i32.const 57) (${memtype}.const 3280))
    (memory.fill (${memtype}.const 46760) (i32.const 58) (${memtype}.const 1678))
    (memory.fill (${memtype}.const 46607) (i32.const 59) (${memtype}.const 3168))
    (memory.fill (${memtype}.const 22449) (i32.const 60) (${memtype}.const 1441))
    (memory.fill (${memtype}.const 58609) (i32.const 61) (${memtype}.const 663))
    (memory.fill (${memtype}.const 32261) (i32.const 62) (${memtype}.const 1671))
    (memory.fill (${memtype}.const 3063) (i32.const 63) (${memtype}.const 721))
    (memory.fill (${memtype}.const 34025) (i32.const 64) (${memtype}.const 84))
    (memory.fill (${memtype}.const 33338) (i32.const 65) (${memtype}.const 2029))
    (memory.fill (${memtype}.const 36810) (i32.const 66) (${memtype}.const 29))
    (memory.fill (${memtype}.const 19147) (i32.const 67) (${memtype}.const 3034))
    (memory.fill (${memtype}.const 12616) (i32.const 68) (${memtype}.const 1043))
    (memory.fill (${memtype}.const 18276) (i32.const 69) (${memtype}.const 3324))
    (memory.fill (${memtype}.const 4639) (i32.const 70) (${memtype}.const 1091))
    (memory.fill (${memtype}.const 16158) (i32.const 71) (${memtype}.const 1997))
    (memory.fill (${memtype}.const 18204) (i32.const 72) (${memtype}.const 2259))
    (memory.fill (${memtype}.const 50532) (i32.const 73) (${memtype}.const 3189))
    (memory.fill (${memtype}.const 11028) (i32.const 74) (${memtype}.const 1968))
    (memory.fill (${memtype}.const 15962) (i32.const 75) (${memtype}.const 1455))
    (memory.fill (${memtype}.const 45406) (i32.const 76) (${memtype}.const 1177))
    (memory.fill (${memtype}.const 54137) (i32.const 77) (${memtype}.const 1568))
    (memory.fill (${memtype}.const 33083) (i32.const 78) (${memtype}.const 1642))
    (memory.fill (${memtype}.const 61028) (i32.const 79) (${memtype}.const 3284))
    (memory.fill (${memtype}.const 51729) (i32.const 80) (${memtype}.const 223))
    (memory.fill (${memtype}.const 4361) (i32.const 81) (${memtype}.const 2171))
    (memory.fill (${memtype}.const 57514) (i32.const 82) (${memtype}.const 1322))
    (memory.fill (${memtype}.const 55724) (i32.const 83) (${memtype}.const 2648))
    (memory.fill (${memtype}.const 24091) (i32.const 84) (${memtype}.const 1045))
    (memory.fill (${memtype}.const 43183) (i32.const 85) (${memtype}.const 3097))
    (memory.fill (${memtype}.const 32307) (i32.const 86) (${memtype}.const 2796))
    (memory.fill (${memtype}.const 3811) (i32.const 87) (${memtype}.const 2010))
    (memory.fill (${memtype}.const 54856) (i32.const 88) (${memtype}.const 0))
    (memory.fill (${memtype}.const 49941) (i32.const 89) (${memtype}.const 2069))
    (memory.fill (${memtype}.const 20411) (i32.const 90) (${memtype}.const 2896))
    (memory.fill (${memtype}.const 33826) (i32.const 91) (${memtype}.const 192))
    (memory.fill (${memtype}.const 9402) (i32.const 92) (${memtype}.const 2195))
    (memory.fill (${memtype}.const 12413) (i32.const 93) (${memtype}.const 24))
    (memory.fill (${memtype}.const 14091) (i32.const 94) (${memtype}.const 577))
    (memory.fill (${memtype}.const 44058) (i32.const 95) (${memtype}.const 2089))
    (memory.fill (${memtype}.const 36735) (i32.const 96) (${memtype}.const 3436))
    (memory.fill (${memtype}.const 23288) (i32.const 97) (${memtype}.const 2765))
    (memory.fill (${memtype}.const 6392) (i32.const 98) (${memtype}.const 830))
    (memory.fill (${memtype}.const 33307) (i32.const 99) (${memtype}.const 1938))
    (memory.fill (${memtype}.const 21941) (i32.const 100) (${memtype}.const 2750))
    (memory.copy (${memtype}.const 59214) (${memtype}.const 54248) (${memtype}.const 2098))
    (memory.copy (${memtype}.const 63026) (${memtype}.const 39224) (${memtype}.const 230))
    (memory.copy (${memtype}.const 51833) (${memtype}.const 23629) (${memtype}.const 2300))
    (memory.copy (${memtype}.const 6708) (${memtype}.const 23996) (${memtype}.const 639))
    (memory.copy (${memtype}.const 6990) (${memtype}.const 33399) (${memtype}.const 1097))
    (memory.copy (${memtype}.const 19403) (${memtype}.const 10348) (${memtype}.const 3197))
    (memory.copy (${memtype}.const 27308) (${memtype}.const 54406) (${memtype}.const 100))
    (memory.copy (${memtype}.const 27221) (${memtype}.const 43682) (${memtype}.const 1717))
    (memory.copy (${memtype}.const 60528) (${memtype}.const 8629) (${memtype}.const 119))
    (memory.copy (${memtype}.const 5947) (${memtype}.const 2308) (${memtype}.const 658))
    (memory.copy (${memtype}.const 4787) (${memtype}.const 51631) (${memtype}.const 2269))
    (memory.copy (${memtype}.const 12617) (${memtype}.const 19197) (${memtype}.const 833))
    (memory.copy (${memtype}.const 11854) (${memtype}.const 46505) (${memtype}.const 3300))
    (memory.copy (${memtype}.const 11376) (${memtype}.const 45012) (${memtype}.const 2281))
    (memory.copy (${memtype}.const 34186) (${memtype}.const 6697) (${memtype}.const 2572))
    (memory.copy (${memtype}.const 4936) (${memtype}.const 1690) (${memtype}.const 1328))
    (memory.copy (${memtype}.const 63164) (${memtype}.const 7637) (${memtype}.const 1670))
    (memory.copy (${memtype}.const 44568) (${memtype}.const 18344) (${memtype}.const 33))
    (memory.copy (${memtype}.const 43918) (${memtype}.const 22348) (${memtype}.const 1427))
    (memory.copy (${memtype}.const 46637) (${memtype}.const 49819) (${memtype}.const 1434))
    (memory.copy (${memtype}.const 63684) (${memtype}.const 8755) (${memtype}.const 834))
    (memory.copy (${memtype}.const 33485) (${memtype}.const 20131) (${memtype}.const 3317))
    (memory.copy (${memtype}.const 40575) (${memtype}.const 54317) (${memtype}.const 3201))
    (memory.copy (${memtype}.const 25812) (${memtype}.const 59254) (${memtype}.const 2452))
    (memory.copy (${memtype}.const 19678) (${memtype}.const 56882) (${memtype}.const 346))
    (memory.copy (${memtype}.const 15852) (${memtype}.const 35914) (${memtype}.const 2430))
    (memory.copy (${memtype}.const 11824) (${memtype}.const 35574) (${memtype}.const 300))
    (memory.copy (${memtype}.const 59427) (${memtype}.const 13957) (${memtype}.const 3153))
    (memory.copy (${memtype}.const 34299) (${memtype}.const 60594) (${memtype}.const 1281))
    (memory.copy (${memtype}.const 8964) (${memtype}.const 12276) (${memtype}.const 943))
    (memory.copy (${memtype}.const 2827) (${memtype}.const 10425) (${memtype}.const 1887))
    (memory.copy (${memtype}.const 43194) (${memtype}.const 43910) (${memtype}.const 738))
    (memory.copy (${memtype}.const 63038) (${memtype}.const 18949) (${memtype}.const 122))
    (memory.copy (${memtype}.const 24044) (${memtype}.const 44761) (${memtype}.const 1755))
    (memory.copy (${memtype}.const 22608) (${memtype}.const 14755) (${memtype}.const 702))
    (memory.copy (${memtype}.const 11284) (${memtype}.const 26579) (${memtype}.const 1830))
    (memory.copy (${memtype}.const 23092) (${memtype}.const 20471) (${memtype}.const 1064))
    (memory.copy (${memtype}.const 57248) (${memtype}.const 54770) (${memtype}.const 2631))
    (memory.copy (${memtype}.const 25492) (${memtype}.const 1025) (${memtype}.const 3113))
    (memory.copy (${memtype}.const 49588) (${memtype}.const 44220) (${memtype}.const 975))
    (memory.copy (${memtype}.const 28280) (${memtype}.const 41722) (${memtype}.const 2336))
    (memory.copy (${memtype}.const 61289) (${memtype}.const 230) (${memtype}.const 2872))
    (memory.copy (${memtype}.const 22480) (${memtype}.const 52506) (${memtype}.const 2197))
    (memory.copy (${memtype}.const 40553) (${memtype}.const 9578) (${memtype}.const 1958))
    (memory.copy (${memtype}.const 29004) (${memtype}.const 20862) (${memtype}.const 2186))
    (memory.copy (${memtype}.const 53029) (${memtype}.const 43955) (${memtype}.const 1037))
    (memory.copy (${memtype}.const 25476) (${memtype}.const 35667) (${memtype}.const 1650))
    (memory.copy (${memtype}.const 58516) (${memtype}.const 45819) (${memtype}.const 1986))
    (memory.copy (${memtype}.const 38297) (${memtype}.const 5776) (${memtype}.const 1955))
    (memory.copy (${memtype}.const 28503) (${memtype}.const 55364) (${memtype}.const 2368))
    (memory.copy (${memtype}.const 62619) (${memtype}.const 18108) (${memtype}.const 1356))
    (memory.copy (${memtype}.const 50149) (${memtype}.const 13861) (${memtype}.const 382))
    (memory.copy (${memtype}.const 16904) (${memtype}.const 36341) (${memtype}.const 1900))
    (memory.copy (${memtype}.const 48098) (${memtype}.const 11358) (${memtype}.const 2807))
    (memory.copy (${memtype}.const 28512) (${memtype}.const 40362) (${memtype}.const 323))
    (memory.copy (${memtype}.const 35506) (${memtype}.const 27856) (${memtype}.const 1670))
    (memory.copy (${memtype}.const 62970) (${memtype}.const 53332) (${memtype}.const 1341))
    (memory.copy (${memtype}.const 14133) (${memtype}.const 46312) (${memtype}.const 644))
    (memory.copy (${memtype}.const 29030) (${memtype}.const 19074) (${memtype}.const 496))
    (memory.copy (${memtype}.const 44952) (${memtype}.const 47577) (${memtype}.const 2784))
    (memory.copy (${memtype}.const 39559) (${memtype}.const 44661) (${memtype}.const 1350))
    (memory.copy (${memtype}.const 10352) (${memtype}.const 29274) (${memtype}.const 1475))
    (memory.copy (${memtype}.const 46911) (${memtype}.const 46178) (${memtype}.const 1467))
    (memory.copy (${memtype}.const 4905) (${memtype}.const 28740) (${memtype}.const 1895))
    (memory.copy (${memtype}.const 38012) (${memtype}.const 57253) (${memtype}.const 1751))
    (memory.copy (${memtype}.const 26446) (${memtype}.const 27223) (${memtype}.const 1127))
    (memory.copy (${memtype}.const 58835) (${memtype}.const 24657) (${memtype}.const 1063))
    (memory.copy (${memtype}.const 61356) (${memtype}.const 38790) (${memtype}.const 766))
    (memory.copy (${memtype}.const 44160) (${memtype}.const 2284) (${memtype}.const 1520))
    (memory.copy (${memtype}.const 32740) (${memtype}.const 47237) (${memtype}.const 3014))
    (memory.copy (${memtype}.const 11148) (${memtype}.const 21260) (${memtype}.const 1011))
    (memory.copy (${memtype}.const 7665) (${memtype}.const 31612) (${memtype}.const 3034))
    (memory.copy (${memtype}.const 18044) (${memtype}.const 12987) (${memtype}.const 3320))
    (memory.copy (${memtype}.const 57306) (${memtype}.const 55905) (${memtype}.const 308))
    (memory.copy (${memtype}.const 24675) (${memtype}.const 16815) (${memtype}.const 1155))
    (memory.copy (${memtype}.const 19900) (${memtype}.const 10115) (${memtype}.const 722))
    (memory.copy (${memtype}.const 2921) (${memtype}.const 5935) (${memtype}.const 2370))
    (memory.copy (${memtype}.const 32255) (${memtype}.const 50095) (${memtype}.const 2926))
    (memory.copy (${memtype}.const 15126) (${memtype}.const 17299) (${memtype}.const 2607))
    (memory.copy (${memtype}.const 45575) (${memtype}.const 28447) (${memtype}.const 2045))
    (memory.copy (${memtype}.const 55149) (${memtype}.const 36113) (${memtype}.const 2596))
    (memory.copy (${memtype}.const 28461) (${memtype}.const 54157) (${memtype}.const 1168))
    (memory.copy (${memtype}.const 47951) (${memtype}.const 53385) (${memtype}.const 3137))
    (memory.copy (${memtype}.const 30646) (${memtype}.const 45155) (${memtype}.const 2649))
    (memory.copy (${memtype}.const 5057) (${memtype}.const 4295) (${memtype}.const 52))
    (memory.copy (${memtype}.const 6692) (${memtype}.const 24195) (${memtype}.const 441))
    (memory.copy (${memtype}.const 32984) (${memtype}.const 27117) (${memtype}.const 3445))
    (memory.copy (${memtype}.const 32530) (${memtype}.const 59372) (${memtype}.const 2785))
    (memory.copy (${memtype}.const 34361) (${memtype}.const 8962) (${memtype}.const 2406))
    (memory.copy (${memtype}.const 17893) (${memtype}.const 54538) (${memtype}.const 3381))
    (memory.copy (${memtype}.const 22685) (${memtype}.const 44151) (${memtype}.const 136))
    (memory.copy (${memtype}.const 59089) (${memtype}.const 7077) (${memtype}.const 1045))
    (memory.copy (${memtype}.const 42945) (${memtype}.const 55028) (${memtype}.const 2389))
    (memory.copy (${memtype}.const 44693) (${memtype}.const 20138) (${memtype}.const 877))
    (memory.copy (${memtype}.const 36810) (${memtype}.const 25196) (${memtype}.const 3447))
    (memory.copy (${memtype}.const 45742) (${memtype}.const 31888) (${memtype}.const 854))
    (memory.copy (${memtype}.const 24236) (${memtype}.const 31866) (${memtype}.const 1377))
    (memory.copy (${memtype}.const 33778) (${memtype}.const 692) (${memtype}.const 1594))
    (memory.copy (${memtype}.const 60618) (${memtype}.const 18585) (${memtype}.const 2987))
    (memory.copy (${memtype}.const 50370) (${memtype}.const 41271) (${memtype}.const 1406))
  )
  ${checkRangeCode(memtype)})
(invoke "test")
`);
  checkRange(memtype, 0, 124, 0);
  checkRange(memtype, 124, 1517, 9);
  checkRange(memtype, 1517, 2132, 0);
  checkRange(memtype, 2132, 2827, 10);
  checkRange(memtype, 2827, 2921, 92);
  checkRange(memtype, 2921, 3538, 83);
  checkRange(memtype, 3538, 3786, 77);
  checkRange(memtype, 3786, 4042, 97);
  checkRange(memtype, 4042, 4651, 99);
  checkRange(memtype, 4651, 5057, 0);
  checkRange(memtype, 5057, 5109, 99);
  checkRange(memtype, 5109, 5291, 0);
  checkRange(memtype, 5291, 5524, 72);
  checkRange(memtype, 5524, 5691, 92);
  checkRange(memtype, 5691, 6552, 83);
  checkRange(memtype, 6552, 7133, 77);
  checkRange(memtype, 7133, 7665, 99);
  checkRange(memtype, 7665, 8314, 0);
  checkRange(memtype, 8314, 8360, 62);
  checkRange(memtype, 8360, 8793, 86);
  checkRange(memtype, 8793, 8979, 83);
  checkRange(memtype, 8979, 9373, 79);
  checkRange(memtype, 9373, 9518, 95);
  checkRange(memtype, 9518, 9934, 59);
  checkRange(memtype, 9934, 10087, 77);
  checkRange(memtype, 10087, 10206, 5);
  checkRange(memtype, 10206, 10230, 77);
  checkRange(memtype, 10230, 10249, 41);
  checkRange(memtype, 10249, 11148, 83);
  checkRange(memtype, 11148, 11356, 74);
  checkRange(memtype, 11356, 11380, 93);
  checkRange(memtype, 11380, 11939, 74);
  checkRange(memtype, 11939, 12159, 68);
  checkRange(memtype, 12159, 12575, 83);
  checkRange(memtype, 12575, 12969, 79);
  checkRange(memtype, 12969, 13114, 95);
  checkRange(memtype, 13114, 14133, 59);
  checkRange(memtype, 14133, 14404, 76);
  checkRange(memtype, 14404, 14428, 57);
  checkRange(memtype, 14428, 14458, 59);
  checkRange(memtype, 14458, 14580, 32);
  checkRange(memtype, 14580, 14777, 89);
  checkRange(memtype, 14777, 15124, 59);
  checkRange(memtype, 15124, 15126, 36);
  checkRange(memtype, 15126, 15192, 100);
  checkRange(memtype, 15192, 15871, 96);
  checkRange(memtype, 15871, 15998, 95);
  checkRange(memtype, 15998, 17017, 59);
  checkRange(memtype, 17017, 17288, 76);
  checkRange(memtype, 17288, 17312, 57);
  checkRange(memtype, 17312, 17342, 59);
  checkRange(memtype, 17342, 17464, 32);
  checkRange(memtype, 17464, 17661, 89);
  checkRange(memtype, 17661, 17727, 59);
  checkRange(memtype, 17727, 17733, 5);
  checkRange(memtype, 17733, 17893, 96);
  checkRange(memtype, 17893, 18553, 77);
  checkRange(memtype, 18553, 18744, 42);
  checkRange(memtype, 18744, 18801, 76);
  checkRange(memtype, 18801, 18825, 57);
  checkRange(memtype, 18825, 18876, 59);
  checkRange(memtype, 18876, 18885, 77);
  checkRange(memtype, 18885, 18904, 41);
  checkRange(memtype, 18904, 19567, 83);
  checkRange(memtype, 19567, 20403, 96);
  checkRange(memtype, 20403, 21274, 77);
  checkRange(memtype, 21274, 21364, 100);
  checkRange(memtype, 21364, 21468, 74);
  checkRange(memtype, 21468, 21492, 93);
  checkRange(memtype, 21492, 22051, 74);
  checkRange(memtype, 22051, 22480, 68);
  checkRange(memtype, 22480, 22685, 100);
  checkRange(memtype, 22685, 22694, 68);
  checkRange(memtype, 22694, 22821, 10);
  checkRange(memtype, 22821, 22869, 100);
  checkRange(memtype, 22869, 24107, 97);
  checkRange(memtype, 24107, 24111, 37);
  checkRange(memtype, 24111, 24236, 77);
  checkRange(memtype, 24236, 24348, 72);
  checkRange(memtype, 24348, 24515, 92);
  checkRange(memtype, 24515, 24900, 83);
  checkRange(memtype, 24900, 25136, 95);
  checkRange(memtype, 25136, 25182, 85);
  checkRange(memtype, 25182, 25426, 68);
  checkRange(memtype, 25426, 25613, 89);
  checkRange(memtype, 25613, 25830, 96);
  checkRange(memtype, 25830, 26446, 100);
  checkRange(memtype, 26446, 26517, 10);
  checkRange(memtype, 26517, 27468, 92);
  checkRange(memtype, 27468, 27503, 95);
  checkRange(memtype, 27503, 27573, 77);
  checkRange(memtype, 27573, 28245, 92);
  checkRange(memtype, 28245, 28280, 95);
  checkRange(memtype, 28280, 29502, 77);
  checkRange(memtype, 29502, 29629, 42);
  checkRange(memtype, 29629, 30387, 83);
  checkRange(memtype, 30387, 30646, 77);
  checkRange(memtype, 30646, 31066, 92);
  checkRange(memtype, 31066, 31131, 77);
  checkRange(memtype, 31131, 31322, 42);
  checkRange(memtype, 31322, 31379, 76);
  checkRange(memtype, 31379, 31403, 57);
  checkRange(memtype, 31403, 31454, 59);
  checkRange(memtype, 31454, 31463, 77);
  checkRange(memtype, 31463, 31482, 41);
  checkRange(memtype, 31482, 31649, 83);
  checkRange(memtype, 31649, 31978, 72);
  checkRange(memtype, 31978, 32145, 92);
  checkRange(memtype, 32145, 32530, 83);
  checkRange(memtype, 32530, 32766, 95);
  checkRange(memtype, 32766, 32812, 85);
  checkRange(memtype, 32812, 33056, 68);
  checkRange(memtype, 33056, 33660, 89);
  checkRange(memtype, 33660, 33752, 59);
  checkRange(memtype, 33752, 33775, 36);
  checkRange(memtype, 33775, 33778, 32);
  checkRange(memtype, 33778, 34603, 9);
  checkRange(memtype, 34603, 35218, 0);
  checkRange(memtype, 35218, 35372, 10);
  checkRange(memtype, 35372, 35486, 77);
  checkRange(memtype, 35486, 35605, 5);
  checkRange(memtype, 35605, 35629, 77);
  checkRange(memtype, 35629, 35648, 41);
  checkRange(memtype, 35648, 36547, 83);
  checkRange(memtype, 36547, 36755, 74);
  checkRange(memtype, 36755, 36767, 93);
  checkRange(memtype, 36767, 36810, 83);
  checkRange(memtype, 36810, 36839, 100);
  checkRange(memtype, 36839, 37444, 96);
  checkRange(memtype, 37444, 38060, 100);
  checkRange(memtype, 38060, 38131, 10);
  checkRange(memtype, 38131, 39082, 92);
  checkRange(memtype, 39082, 39117, 95);
  checkRange(memtype, 39117, 39187, 77);
  checkRange(memtype, 39187, 39859, 92);
  checkRange(memtype, 39859, 39894, 95);
  checkRange(memtype, 39894, 40257, 77);
  checkRange(memtype, 40257, 40344, 89);
  checkRange(memtype, 40344, 40371, 59);
  checkRange(memtype, 40371, 40804, 77);
  checkRange(memtype, 40804, 40909, 5);
  checkRange(memtype, 40909, 42259, 92);
  checkRange(memtype, 42259, 42511, 77);
  checkRange(memtype, 42511, 42945, 83);
  checkRange(memtype, 42945, 43115, 77);
  checkRange(memtype, 43115, 43306, 42);
  checkRange(memtype, 43306, 43363, 76);
  checkRange(memtype, 43363, 43387, 57);
  checkRange(memtype, 43387, 43438, 59);
  checkRange(memtype, 43438, 43447, 77);
  checkRange(memtype, 43447, 43466, 41);
  checkRange(memtype, 43466, 44129, 83);
  checkRange(memtype, 44129, 44958, 96);
  checkRange(memtype, 44958, 45570, 77);
  checkRange(memtype, 45570, 45575, 92);
  checkRange(memtype, 45575, 45640, 77);
  checkRange(memtype, 45640, 45742, 42);
  checkRange(memtype, 45742, 45832, 72);
  checkRange(memtype, 45832, 45999, 92);
  checkRange(memtype, 45999, 46384, 83);
  checkRange(memtype, 46384, 46596, 95);
  checkRange(memtype, 46596, 46654, 92);
  checkRange(memtype, 46654, 47515, 83);
  checkRange(memtype, 47515, 47620, 77);
  checkRange(memtype, 47620, 47817, 79);
  checkRange(memtype, 47817, 47951, 95);
  checkRange(memtype, 47951, 48632, 100);
  checkRange(memtype, 48632, 48699, 97);
  checkRange(memtype, 48699, 48703, 37);
  checkRange(memtype, 48703, 49764, 77);
  checkRange(memtype, 49764, 49955, 42);
  checkRange(memtype, 49955, 50012, 76);
  checkRange(memtype, 50012, 50036, 57);
  checkRange(memtype, 50036, 50087, 59);
  checkRange(memtype, 50087, 50096, 77);
  checkRange(memtype, 50096, 50115, 41);
  checkRange(memtype, 50115, 50370, 83);
  checkRange(memtype, 50370, 51358, 92);
  checkRange(memtype, 51358, 51610, 77);
  checkRange(memtype, 51610, 51776, 83);
  checkRange(memtype, 51776, 51833, 89);
  checkRange(memtype, 51833, 52895, 100);
  checkRange(memtype, 52895, 53029, 97);
  checkRange(memtype, 53029, 53244, 68);
  checkRange(memtype, 53244, 54066, 100);
  checkRange(memtype, 54066, 54133, 97);
  checkRange(memtype, 54133, 54137, 37);
  checkRange(memtype, 54137, 55198, 77);
  checkRange(memtype, 55198, 55389, 42);
  checkRange(memtype, 55389, 55446, 76);
  checkRange(memtype, 55446, 55470, 57);
  checkRange(memtype, 55470, 55521, 59);
  checkRange(memtype, 55521, 55530, 77);
  checkRange(memtype, 55530, 55549, 41);
  checkRange(memtype, 55549, 56212, 83);
  checkRange(memtype, 56212, 57048, 96);
  checkRange(memtype, 57048, 58183, 77);
  checkRange(memtype, 58183, 58202, 41);
  checkRange(memtype, 58202, 58516, 83);
  checkRange(memtype, 58516, 58835, 95);
  checkRange(memtype, 58835, 58855, 77);
  checkRange(memtype, 58855, 59089, 95);
  checkRange(memtype, 59089, 59145, 77);
  checkRange(memtype, 59145, 59677, 99);
  checkRange(memtype, 59677, 60134, 0);
  checkRange(memtype, 60134, 60502, 89);
  checkRange(memtype, 60502, 60594, 59);
  checkRange(memtype, 60594, 60617, 36);
  checkRange(memtype, 60617, 60618, 32);
  checkRange(memtype, 60618, 60777, 42);
  checkRange(memtype, 60777, 60834, 76);
  checkRange(memtype, 60834, 60858, 57);
  checkRange(memtype, 60858, 60909, 59);
  checkRange(memtype, 60909, 60918, 77);
  checkRange(memtype, 60918, 60937, 41);
  checkRange(memtype, 60937, 61600, 83);
  checkRange(memtype, 61600, 62436, 96);
  checkRange(memtype, 62436, 63307, 77);
  checkRange(memtype, 63307, 63397, 100);
  checkRange(memtype, 63397, 63501, 74);
  checkRange(memtype, 63501, 63525, 93);
  checkRange(memtype, 63525, 63605, 74);
  checkRange(memtype, 63605, 63704, 100);
  checkRange(memtype, 63704, 63771, 97);
  checkRange(memtype, 63771, 63775, 37);
  checkRange(memtype, 63775, 64311, 77);
  checkRange(memtype, 64311, 64331, 26);
  checkRange(memtype, 64331, 64518, 92);
  checkRange(memtype, 64518, 64827, 11);
  checkRange(memtype, 64827, 64834, 26);
  checkRange(memtype, 64834, 65536, 0);
}
