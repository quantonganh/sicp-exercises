#lang racket/base
(require racket/trace)

(define (reverse items)
    (iter items null))

(define (iter remaining result)
    (trace iter)
    (if (null? remaining)
        result
        (iter (cdr remaining) (cons (car remaining) result))))

(trace reverse)
(reverse (list (list 1 2) (list 3 4)))
