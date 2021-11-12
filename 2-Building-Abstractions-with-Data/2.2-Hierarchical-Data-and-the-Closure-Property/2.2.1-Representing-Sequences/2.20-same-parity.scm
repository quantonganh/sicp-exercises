#lang racket/base
(require racket/trace)
(require racket/include)
(include "2/list.rkt")

(define (find-even-odd items)
    (define (iter items even odd)
        (trace iter)
        (cond ((null? items)
                (cons even odd))
            ((even? (car items))
                (iter (cdr items) (append even (list (car items))) odd))
            (else
                (iter (cdr items) even (append odd (list (car items)))))))
    (iter items null null))

(define (same-parity first . l)
    (cond ((even? first)
        (append (list first) (car (find-even-odd l))))
    (else
        (append (list first) (cdr (find-even-odd l))))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
