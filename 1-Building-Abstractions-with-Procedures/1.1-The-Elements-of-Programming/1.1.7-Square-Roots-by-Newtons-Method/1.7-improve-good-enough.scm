#lang sicp

(define n 0)

(define (sqrt-iter guess x)
    (let ((next-guess (improve guess x)))
    (if (good-enough? guess next-guess)
        guess
        (sqrt-iter next-guess x))))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess next-guess)
    (display guess)
    (display "\n")
    (< (abs (/ (- guess next-guess) guess)) 1d-10))

(define (abs x)
    (cond ((< x 0) (- x))
        (else x)))

(define (square x)
    (* x x))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(display "x: ")
(define x (read))
(display "sqrt(x): ")
(sqrt x)
