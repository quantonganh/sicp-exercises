#lang racket/base
(require racket/trace)

(define dx 0.00001)

(define (smooth f)
    (lambda (x)
        (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (average a b c)
    (/ (+ a b c) 3))

(define (square x)
    (* x x))

((smooth square) 2)
