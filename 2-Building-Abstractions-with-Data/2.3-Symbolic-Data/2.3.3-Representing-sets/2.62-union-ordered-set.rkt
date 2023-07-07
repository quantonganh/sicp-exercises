#lang racket

(require racket/trace)
(require rackunit)

(include "set.rkt")

(define (element-of-set? x set)
	(cond 
		  ((not (ordered? set)) (error "set is not ordered"))
		  ((null? set) #f)
		  ((= x (car set)) #t)
		  ((< x (car set)) #f)
		  (else (element-of-set? x (cdr set)))))

(trace-define (union-set set1 set2)
	(if (or (not (ordered? set1)) (not (ordered? set2)))
		(error "set is not ordered")
	(if (null? set1)
		set2
		(if (null? set2)
			set1
			(let ((x1 (car set1)) (x2 (car set2)))
				(cond ((= x1 x2)
				   (union-set (cdr set1) set2))
				  ((< x1 x2)
				   (cons x1 (union-set (cdr set1) set2)))
				  ((< x2 x1)
				   (cons x2 (union-set set1 (cdr set2))))))))))

(check-exn exn:fail? (thunk (union-set '(1 3) '(1 3 2))))
(check-equal? (union-set '(1 3 4) '(1 3 4)) '(1 3 4))
(check-equal? (union-set '(1 3 6) '(2 4 6)) '(1 2 3 4 6))
