#lang racket

(include "algebraic-expressions.rkt")
(require racket/trace)

(provide deriv)
(define (deriv exp var)
	(cond ((number? exp) 0)
		  ((variable? exp) (if (same-variable? exp var) 1 0))
		  (else ((get 'deriv (operator exp))
				 exp var))))

(provide operator)
(define (operator exp) (car exp))

(provide operands)
(define (operands exp) (cdr exp))

(define (deriv-sum exp var)
	(make-sum (deriv (addend exp) var)
			  (deriv (augend exp) var)))

(define (deriv-product exp var)
	(make-sum
		(make-product (multiplier exp)
					  (deriv (multiplicand exp) var))
		(make-product (deriv (multiplier exp) var)
					  (multiplicand exp))))

(define (deriv-exponentiation exp var)
	(make-product
		(make-product (exponent exp)
					  (make-exponentiation (base exp) (- (exponent exp) 1)))
		(deriv (base exp) var)))

(define dispatch-table '())

(define (put op type item)
	(set! dispatch-table (cons (list (list op type) item) dispatch-table)))
	
(provide get)
(define (get op type)
	(let ((entry (assoc (list op type) dispatch-table)))
		(if entry
			(cadr entry)
			#f)))

(put 'deriv '+ deriv-sum)
(put 'deriv '* deriv-product)
(put 'deriv '** deriv-exponentiation)

; (deriv '(** a 5) 'x)
