#lang sicp

(define (f n)
    (cond ((< n 3) n)
    (else (+ (f (- n 1))
            (* 2 (f (- n 2)))
            (* 3 (f (- n 3)))))))

(display "x: ")
(define x (read))
(display "f(x): ")
(f x)
