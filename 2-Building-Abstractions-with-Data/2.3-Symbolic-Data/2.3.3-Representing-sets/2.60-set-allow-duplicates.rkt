#lang racket

(require racket/trace)
(require rackunit)

(define (element-of-set? x set)
	(member x set))

(trace-define (adjoin-set x set)
	(cons x set))

(trace-define (intersection-set set1 set2)
	(cond ((or (null? set1) (null? set2)) '())
		  ((element-of-set? (car set1) set2)
		   (cons (car set1) (intersection-set (cdr set1) set2)))
		  (else (intersection-set (cdr set1) set2))))

(trace-define (union-set set1 set2)
	(append set1 set2))

(check-equal? (adjoin-set 2 '(1 2 3 2)) '(2 1 2 3 2))
(check-equal? (adjoin-set 4 '(1 2 3 2)) '(4 1 2 3 2))
(check-equal? (intersection-set '(1 3 2) '(2 1 4)) '(1 2))
(check-equal? (union-set '(1 3 2) '(2 5 3 4)) '(1 3 2 2 5 3 4))
