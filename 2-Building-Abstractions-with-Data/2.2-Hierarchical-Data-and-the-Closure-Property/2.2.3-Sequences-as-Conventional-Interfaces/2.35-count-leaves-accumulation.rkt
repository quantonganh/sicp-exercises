#lang racket/base
(require racket/trace)
(require racket/include)
(include "2/accumulate.rkt")

(define (fringe t)
    (cond ((null? t) null)
        ((not (pair? t))
            (list t))
        (else
            (append (fringe (car t))
                    (fringe (cdr t))))))

(define (count-leaves t)
    (accumulate +
                0
                (map (lambda (x) 1) (fringe t))))

(define t (cons (list 1 2) (list 3 4)))
(fringe t)
(count-leaves t)
