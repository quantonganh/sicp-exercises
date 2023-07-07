#lang racket

(require racket/trace)
(require rackunit)

(include "set.rkt")

(define (element-of-set? x set)
	(cond ((null? set) #f)
		  ((= x (car set)) #t)
		  ((< x (car set)) #f)
		  (else (element-of-set? x (cdr set)))))

(trace-define (adjoin-set x set)
	(cond
		  ((not (ordered? set)) (error "set is not ordered"))
	      ((null? set) (list x))
		  ((element-of-set? x set) set)
	      ((< x (car set))
		   (cons x set))
		  ((> x (car set))
		   (cons (car set) (adjoin-set x (cdr set))))))

(check-exn exn:fail? (thunk (adjoin-set 3 '(1 4 3))))
(check-equal? (adjoin-set 3 '(1 3 4)) '(1 3 4))
(check-equal? (adjoin-set 0 '(1 3 4)) '(0 1 3 4))
(check-equal? (adjoin-set 2 '(1 3 4)) '(1 2 3 4))
(check-equal? (adjoin-set 5 '(1 3 4)) '(1 3 4 5))
