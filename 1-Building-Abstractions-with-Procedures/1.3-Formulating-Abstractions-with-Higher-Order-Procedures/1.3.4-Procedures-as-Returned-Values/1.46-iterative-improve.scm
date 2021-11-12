#lang racket/base
(require racket/trace)

(define (iterative-improve good-enough? improve)
    (define (iter guess)
        (if (good-enough? guess)
            guess
            (iter (improve guess))))
    (lambda (guess) (iter guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (abs x)
    (cond ((< x 0) (- x))
        (else x)))

(define (sqrt x)
    (define (improve guess)
        (average guess (/ x guess)))

    (define (good-enough? guess)
        (display guess) (newline)
        (< (abs (/ (- guess (improve guess)) guess)) 1d-10))

    ((iterative-improve good-enough? improve) 1.0))

(sqrt 1000)
