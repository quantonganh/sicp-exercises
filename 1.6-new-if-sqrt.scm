#lang sicp

(define n 0)

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
        (else else-clause)))

(define (improve guess x)
    (display (average guess (/ x guess)))
    (display "\n")
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

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
