#lang racket

(include "vector.rkt")

(define (add-vect v1 v2)
	(cons (+ (xcor-vect v1) (xcor-vect v2)) (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
	(cons (- (xcor-vect v1) (xcor-vect v2)) (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s p)
	(cons (* s (car p)) (* s (cdr p))))

(define v1 (make-vect 5 3))
(display "v1: ") (print-vect v1)
(define v2 (make-vect -2 3))
(display "v2: ") (print-vect v2)

(display "v1 + v2: ")
(add-vect v1 v2)

(display "v1 - v2: ")
(sub-vect v1 v2)

(display "2 * v1: ")
(scale-vect 2 v1)
