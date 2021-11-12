#lang racket/base
(require racket/trace)

(trace-define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1)
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (cons (list 1 2) (list 3 4)))
(display x) (newline)
(length x)
(count-leaves x)
(list x x)
(length (list x x))
(count-leaves (list x x))
