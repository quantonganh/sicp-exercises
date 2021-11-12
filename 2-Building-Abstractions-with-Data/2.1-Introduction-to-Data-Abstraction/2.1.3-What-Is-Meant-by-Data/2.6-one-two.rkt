#lang racket/base
(require racket/trace)
(require racket/include)
(include "provide.rkt")

(define zero (lambda (f)
                (lambda (x) x)))

(define (add-1 n)
    (lambda (f)
        (trace f)
        (lambda (x) (f ((n f) x)))))

(define one (add-1 zero))

(one square)
