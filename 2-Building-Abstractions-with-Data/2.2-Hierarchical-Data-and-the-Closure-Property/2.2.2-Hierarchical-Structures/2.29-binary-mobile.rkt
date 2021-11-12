#lang racket/base
(require racket/trace)

(define (make-mobile left right)
    (list left right))

(define (make-branch length structure)
    (list length structure))

;(define (left-branch m)
;    )
;
;(define (right-branch m)
;    )
;
;(define (branch-length b)
;    )
;
;(define (branch-structure b)
;    )
;
(define lb (make-branch 2 3))

(define rb (make-branch 3 4))

(define m (make-mobile lb rb))
