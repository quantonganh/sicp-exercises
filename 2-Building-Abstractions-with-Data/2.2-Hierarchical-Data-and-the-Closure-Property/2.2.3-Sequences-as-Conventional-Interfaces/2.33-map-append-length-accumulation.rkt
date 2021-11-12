#lang racket/base
(require racket/include)
(include "2/accumulate.rkt")


(define (map p sequence)
    (accumulate (lambda (x y)
                    (cons (p x) y))
                null
                sequence))

(define (square x)
    (* x x))

(map square (list 1 2 3 4 5))

(define (acc-append seq1 seq2)
    (accumulate cons seq2 seq1))

(acc-append (list 1 2) (list 3 4))

(define (length sequence)
    (accumulate (lambda (x y)
                    (+ 1 y))
                0
                sequence))

(length (list 1 2 (list 3 4 5)))
