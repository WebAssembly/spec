;; Test the data section

;; Syntax

(module
  (memory 0)
  (data (i32.const 0))
  (data (i32.const 0) "" "" "")
)

(module
  (memory 1)
  (data (i32.const 0))
  (data (i32.const 0) "a" "" "bcd")
  (data (offset (i32.const 0)))
  (data (offset (i32.const 0)) "" "a" "bc" "")
)

;; Basic use

(module
  (memory 2)
  (data (i32.const 0) "a")
)

(module
  (memory 2)
  (data (i32.const 0x1_ffff) "a")
)

;; Invalid bounds for data

(assert_unlinkable
  (module
    (memory 2)
    (data (i32.const 0x2_0000) "a")
  )
  "data segment does not fit"
)

(assert_unlinkable
  (module
    (memory 2 3)
    (data (i32.const 0x2_0000) "a")
  )
  "data segment does not fit"
)

(assert_unlinkable
  (module
    (memory 2)
    (data (i32.const -1) "a")
  )
  "data segment does not fit"
)

(assert_unlinkable
  (module
    (memory 2)
    (data (i32.const -100) "a")
  )
  "data segment does not fit"
)

;; Tests with an imported memory

(module
  (import "spectest" "memory" (memory 1))
  (data (i32.const 0) "a")
)

(module
  (import "spectest" "memory" (memory 1))
  (data (i32.const 0xffff) "a")
)

;; Invalid bounds for data

(assert_unlinkable
  (module
    (import "spectest" "memory" (memory 1))
    (data (i32.const 0x1_0000) "a")
  )
  "data segment does not fit"
)

(assert_unlinkable
  (module
    (import "spectest" "memory" (memory 1))
    (data (i32.const -1) "a")
  )
  "data segment does not fit"
)

(assert_unlinkable
  (module
    (import "spectest" "memory" (memory 1))
    (data (i32.const -100) "a")
  )
  "data segment does not fit"
)

;; Data without memory

(assert_invalid
  (module
    (data (i32.const 0) "")
  )
  "unknown memory 0"
)
