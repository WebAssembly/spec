;; (c) 2015 Andreas Rossberg

(module
  ;; Swap
  (func (param i32 i32) (result i32 i32)
    (return (getparam 1) (getparam 0))
  )

  ;; Test
  (func (param i32) (result i32 i32)
    (local i32 i32)
    (setlocal 0 (const.i32 1))
    (setlocal 1 (const.i32 2))
    (switch (getparam 0)
      ;; Destructure
      (case 1
        (destruct 0 1 (call 0 (getlocal 0) (getlocal 1)))
        (return (getlocal 0) (getlocal 1))
      )
      ;; Return directly
      (case 2
        (return (call 0 (getlocal 0) (getlocal 1)))
      )
      ;; Pass on to other call
      (case 3
        (return (call 0 (call 0 (getlocal 0) (getlocal 1))))
      )
      ;; Break
      (case 4
        (destruct 0 1 (label (call 0 (break 0 (getlocal 0) (getlocal 1)))))
        (return (getlocal 0) (getlocal 1))
      )
      ;; Pass on to break
      (case 5
        (return (label (call 0 (break 0 (call 0 (getlocal 0) (getlocal 1))))))
      )
      ;; Dummy default
      (return (getlocal 0) (getlocal 1))
    )
  )

  (export 1)
)

(invoke 0 (const.i32 1))  ;; (2 1) : (Int32 Int32)
(invoke 0 (const.i32 2))  ;; (2 1) : (Int32 Int32)
(invoke 0 (const.i32 3))  ;; (1 2) : (Int32 Int32)
(invoke 0 (const.i32 4))  ;; (1 2) : (Int32 Int32)
(invoke 0 (const.i32 5))  ;; (2 1) : (Int32 Int32)
