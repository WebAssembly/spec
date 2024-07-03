(module
  (type $t (func))
  (@custom "my-section1" "contents-bytes1")
  (@custom "my-section2" "more-contents-bytes0")
  (@custom "my-section1" "contents-bytes2")
  (@custom "my-section2" (before global) "more-contents-bytes1")
  (@custom "my-section2" (after func) "more-contents-bytes2")
  (@custom "my-section2" (after func) "more-contents-bytes3")
  (@custom "my-section2" (before global) "more-contents-bytes4")
  (func)
  (@custom "my-section2" "more-contents-bytes5")

  (global $g i32 (i32.const 0))
  (@custom "my-section3")
  (@custom "my-section4" "" "1" "" "2" "3" "")
  (@custom "")
)

(module quote "(@custom \"bla\")")
(module quote "(module (@custom \"bla\"))")


;; Malformed name

(assert_malformed_custom
  (module quote "(@custom)")
  "@custom annotation: missing section name"
)

(assert_malformed_custom
  (module quote "(@custom 4)")
  "@custom annotation: missing section name"
)

(assert_malformed_custom
  (module quote "(@custom bla)")
  "@custom annotation: missing section name"
)

(assert_malformed_custom
  (module quote "(@custom \"\\df\")")
  "@custom annotation: malformed UTF-8 encoding"
)


;; Malformed placement

(assert_malformed_custom
  (module quote "(@custom \"bla\" here)")
  "@custom annotation: unexpected token"
)

(assert_malformed_custom
  (module quote "(@custom \"bla\" after)")
  "@custom annotation: unexpected token"
)

(assert_malformed_custom
  (module quote "(@custom \"bla\" (after))")
  "@custom annotation: malformed section kind"
)

(assert_malformed_custom
  (module quote "(@custom \"bla\" (type))")
  "@custom annotation: malformed placement"
)

(assert_malformed_custom
  (module quote "(@custom \"bla\" (aft type))")
  "@custom annotation: malformed placement"
)

(assert_malformed_custom
  (module quote "(@custom \"bla\" (before types))")
  "@custom annotation: malformed section kind"
)


;; Misplaced

(assert_malformed_custom
  (module quote "(type (@custom \"bla\") $t (func))")
  "misplaced @custom annotation"
)

(assert_malformed_custom
  (module quote "(func (@custom \"bla\"))")
  "misplaced @custom annotation"
)

(assert_malformed_custom
  (module quote "(func (block (@custom \"bla\")))")
  "misplaced @custom annotation"
)

(assert_malformed_custom
  (module quote "(func (nop (@custom \"bla\")))")
  "misplaced @custom annotation"
)
