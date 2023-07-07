#lang racket

(define (make-frame origin edge1 edge2)
	(list origin edge1 edge2))

; (define (make-frame-c origin edge1 edge2)
; 	(cons origin (cons edge1 edge2)))

(define (make-vect x y)
	(cons x y))

(define origin-vect (make-vect 0 0))

(define edge1-vect (make-vect 5 3))

(define edge2-vect (make-vect -2 3))

(define f (make-frame origin-vect edge1-vect edge2-vect))

(origin-frame f)
(edge1-frame f)
(edge2-frame f)
