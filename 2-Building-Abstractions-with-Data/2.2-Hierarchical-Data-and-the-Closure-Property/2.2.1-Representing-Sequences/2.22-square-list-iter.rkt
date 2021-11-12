#lang racket/base
(require racket/trace)

(define (square x) (* x x))

(define (square-list-1 items)
    (define (iter things answer)
        (trace iter)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons (square (car things))
                        answer))))
    (iter items null))

(define (square-list-2 items)
    (define (iter things answer)
        (trace iter)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer
                        (square (car things))))))
    (iter items null))

(define (square-list-3 items)
    (define (iter things answer)
        (trace iter)
        (if (null? things)
            answer
            (iter (cdr things)
                  (append answer (list (square (car things)))))))
    (iter items null))

(square-list-1 (list 1 2 3 4))
(square-list-2 (list 1 2 3 4))
(square-list-3 (list 1 2 3 4))
