;gnu clisp 2.49

(defun concat (string1 string2)
    (concatenate 'string string1 string2)
)

; program


(defun fizzbuzz (in)
    (setq result "")
    (if (divisible-by in 3)
        (setq result (concat result "fizz")))
    (if (divisible-by in 5)
        (setq result (concat result "buzz")))
    (if (is-empty result)
        (setq result in))
    (write-to-string result)
)

(defun divisible-by (arg divisor)
    (and
        (eq (mod arg divisor) 0)
        (not (eq arg 0)))
)

(defun is-empty (string)
    (string= string "")
)

; test harness

(setq testout "")
(setq failures "")

(defun test-fizzbuzz (expected input)
    (test (write-to-string expected) (fizzbuzz input))
)

(defun test (expected actual)
    (if (string= expected actual)
        (add-success)
        (add-failure expected actual))
)

(defun add-success ()
    (setq testout (concat testout "."))
)

(defun add-failure (expected actual)
    (setq testout (concat testout "F"))
    (setq failures (concat failures (fail-message expected actual) ))
)

(defun fail-message (e a)
    (concatenate 'string "Expected " e ", but got " a ".~%")
)

(defun print-results ()
    (format t (concat testout "~%"))
    (format t failures)
)


; tests

(defun run-tests ()
    ; standard
    (test-fizzbuzz 1 1)
    (test-fizzbuzz 2 2)
    (test-fizzbuzz "fizz" 3)
    (test-fizzbuzz "buzz" 5)
    (test-fizzbuzz "fizz" 6)
    (test-fizzbuzz 7 7)
    (test-fizzbuzz "fizz" 9)
    (test-fizzbuzz "buzz" 10)
    (test-fizzbuzz "fizzbuzz" 15)
    (test-fizzbuzz "fizzbuzz" 45)
    
    ; edge cases & complicated proofs
    (test-fizzbuzz 0 0)
    (test-fizzbuzz "fizz" -3)
    (test-fizzbuzz "fizzbuzz" (large-with-factors))
    (test-fizzbuzz (large-no-factors) (large-no-factors))

    (print-results)
)

(defun large-with-factors ()
    (* 3 5 9999)
)

(defun large-no-factors ()
    (- (large-with-factors) 1)
)

(run-tests)
