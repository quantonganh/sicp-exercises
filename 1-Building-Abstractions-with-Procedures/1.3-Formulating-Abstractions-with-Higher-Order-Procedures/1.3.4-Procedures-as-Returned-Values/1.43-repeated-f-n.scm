#lang racket/base
(require racket/trace)

(define (compose f g)
    (trace g)
    (trace f)
    (lambda (x) (f (g x))))

(define (identity x) x)

(define (repeated f n)
    (cond ((= n 0) identity)
        ((even? n)
            (compose (repeated f (/ n 2)) (repeated f (/ n 2))))
        (else
            (compose f (repeated f (- n 1))))))

(define (square x)
    (* x x))

((repeated square 10) 2)
