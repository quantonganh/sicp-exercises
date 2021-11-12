#lang racket/base
(require racket/trace)
(require racket/include)
(include "2/accumulate.rkt")

(define fold-right accumulate)

(define (reverse sequence)
    (fold-right (lambda (x y) ()))) null sequence))

(reverse (list 1 2 3 4))
