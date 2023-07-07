#lang racket/base
(require racket/trace)

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(trace gcd)
(gcd 206 40)
