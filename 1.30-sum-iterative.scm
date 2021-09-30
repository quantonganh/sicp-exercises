#lang racket/base
(require racket/trace)

(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (+ result (term a)))))
    (trace iter)
    (iter a 0))

(define (inc n) (+ n 1))

(define (sum-cubes a b)
    (sum cube a inc b))

(define (cube x) (* x x x))

(sum-cubes 1 10)

(define (identify x) x)

(define (sum-integers a b)
    (sum identify a inc b))

(sum-integers 1 10)
