#lang racket/base
(require racket/trace)

(define (deep-reverse items)
    (iter items null))

(define (iter remaining result)
    (trace iter)
    (cond ((null? remaining) result)
        ((pair? (car remaining))
            (iter (cdr remaining) (cons (deep-reverse (car remaining)) result)))
        (else
            (iter (cdr remaining) (cons (car remaining) result)))))

(trace deep-reverse)
(deep-reverse (list (list 1 2) (list 3 4)))
