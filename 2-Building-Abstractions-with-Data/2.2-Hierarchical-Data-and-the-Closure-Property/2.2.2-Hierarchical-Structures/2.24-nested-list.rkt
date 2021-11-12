#lang racket/base
(require racket/trace)

(define x (list 1 (list 2 (list 3 4))))

(display x)
