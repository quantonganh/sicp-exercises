#lang racket/base
(require racket/trace)

(define (square-list-cons items)
    (if (null? items)
        null
        (cons (* (car items) (car items))
              (square-list-cons (cdr items)))))

(trace square-list-cons)
(square-list-cons (list 1 2 3 4))

(define (square x) (* x x))

(define (square-list-map items)
    (map square items))

(trace square-list-map)
(square-list-map (list 1 2 3 4))
