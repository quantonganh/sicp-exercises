#lang racket/base
(require racket/trace)

(define (expmod base exp m)
    (cond ((= exp 0) 1)
        ((even? exp)
            (remainder
                (square (expmod base (/ exp 2) m))
                m))
        (else
            (remainder
                (* base (expmod base (- exp 1) m))
                m))))

(define (square x)
    (* x x))

(trace expmod)
(expmod 2 100000000000 100000000000)
