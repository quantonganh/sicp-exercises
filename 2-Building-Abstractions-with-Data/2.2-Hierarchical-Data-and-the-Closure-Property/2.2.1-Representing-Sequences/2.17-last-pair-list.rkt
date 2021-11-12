#lang racket/base
(require racket/include)
(include "2/list.rkt")

(define (last-pair items)
    (list-ref items (- (length items) 1)))

(last-pair (list 1 2 3 4))
