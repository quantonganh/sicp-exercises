#lang sicp

(define (cube-root-iter guess x)
    (let ((next-guess (improve guess x)))
        (if (good-enough? guess next-guess)
            guess
            (cube-root-iter next-guess x))))

(define (improve guess x)
    (/ (+ (/ x (square guess)) (double guess)) 3))

(define (good-enough? guess next-guess)
    (display guess)
    (display "\n")
    (< (abs (/ (- guess next-guess) guess)) 1d-10))

(define (abs x)
    (cond ((< x 0) (- x))
        (else x)))

(define (square x)
    (* x x))

(define (double x)
    (* 2 x))

(define (cube-root x)
    (cube-root-iter 1.0 x))

(display "x: ")
(define x (read))
(display "cube-root(x): ")
(cube-root x)
