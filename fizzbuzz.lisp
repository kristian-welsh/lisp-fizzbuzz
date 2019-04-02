;gnu clisp 2.49

; program

(defun fizzbuzz (in)
    (setq return "")
    (if (eq (mod in 3) 0)
        (setq return (concatenate 'string return "fizz")))
    (if (eq (mod in 5) 0)
        (setq return (concatenate 'string return "buzz")))
    (if (or (string= return "") (eq in 0))
        in
        return)
)

; test harness

(setq testout "")
(setq failures "")

(defun fail-message (e a)
    (concatenate 'string "Expected " e ", but got " a ".  |  ")
)

(defun test (expected actual)
    (let ((e (write-to-string expected)) (a (write-to-string actual)))
        (if (string= e a)
            (setq testout (concatenate 'string testout "."))
            (progn
                (setq testout (concatenate 'string testout "F"))
                (setq failures (concatenate 'string failures (fail-message e a)))
            )
        )
    )
)

(defun test-fizzbuzz (expected input)
    (test expected (fizzbuzz input))
)

; tests

(test-fizzbuzz 1 1)
(test-fizzbuzz 2 2)
(test-fizzbuzz "fizz" 3)
(test-fizzbuzz "buzz" 5)
(test-fizzbuzz "fizz" 6)
(test-fizzbuzz 7 7)
(test-fizzbuzz "fizz" 9)
(test-fizzbuzz "buzz" 10)
(test-fizzbuzz "fizzbuzz" 15)

(test-fizzbuzz 0 0)
(test-fizzbuzz "fizz" (* 3 1234))
(test-fizzbuzz "buzz" (* 5 1234))
(test-fizzbuzz "fizzbuzz" (* 3 5 1234))
(test-fizzbuzz (- (* 3 5 1234) 1) (- (* 3 5 1234) 1))

; print test results

(print testout)
(if (not (string= failures ""))
    (print failures))