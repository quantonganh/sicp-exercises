#lang racket/base
(require racket/trace)

(define (fringe x)
    (cond ((null? x) null)
        ((pair? (car x))
            (append (fringe (car x)) (fringe (cdr x))))
        (else
            (cons (car x) (fringe (cdr x))))))

(trace fringe)
(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))
