#lang racket

(require racket/trace)
(require rackunit)

(define (element-of-set? x set)
	(cond ((null? set) #f)
		  ((equal? x (car set)) #t)
		  (else (element-of-set? x (cdr set)))))

(trace-define (adjoin-set x set)
	(if (element-of-set? x set)
		set
		(cons x set)))

(trace-define (intersection-set set1 set2)
	(cond ((or (null? set1) (null? set2)) '())
		  ((element-of-set? (car set1) set2)
		   (cons (car set1) (intersection-set (cdr set1) set2)))
		  (else (intersection-set (cdr set1) set2))))

(trace-define (union-set set1 set2)
	(cond ((null? set1) set2)
		  ((null? set2) set1)
		  ((element-of-set? (car set1) set2)
		   (union-set (cdr set1) set2))
		  (else (cons (car set1) (union-set (cdr set1) set2)))))

(check-equal? (adjoin-set 2 '(1 3 2)) '(1 3 2))
(check-equal? (adjoin-set 4 '(1 3 2)) '(4 1 3 2))
(check-equal? (intersection-set '(1 3 2) '(2 1 4)) '(1 2))
(check-equal? (union-set '(1 3 2) '(2 5 3 4)) '(1 2 5 3 4))
