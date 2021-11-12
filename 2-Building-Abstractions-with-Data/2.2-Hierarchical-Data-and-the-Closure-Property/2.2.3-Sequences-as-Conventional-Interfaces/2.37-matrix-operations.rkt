#lang racket/base
(require racket/include)
(include "2/accumulate.rkt")

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(dot-product (list 1 2 3 4) (list 5 6 7 8))

(define (matrix-*-vector m v)
    (map (lambda (x) (* x v)) m))

(define m (list (list 1 2 3 4) (list 5 6 7 8)))
(define v (list 1 2 3 4))
(matrix-*-vector m v)
