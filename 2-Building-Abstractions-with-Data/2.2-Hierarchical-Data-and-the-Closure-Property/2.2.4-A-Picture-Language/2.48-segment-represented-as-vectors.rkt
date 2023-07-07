#lang racket

(include "vector.rkt")

(define (make-segment v1 v2)
	(cons v1 v2))

(define (start-segment s)
	(car s))

(define (end-segment s)
	(cdr s))

(define v1 (make-vect 5 3))
(print-vect v1)

(define v2 (make-vect -2 3))
(print-vect v2)

(define s (make-segment v1 v2))
(start-segment s)
(end-segment s)