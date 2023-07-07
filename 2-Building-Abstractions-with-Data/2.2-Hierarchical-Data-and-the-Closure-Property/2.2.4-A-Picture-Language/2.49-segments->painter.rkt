#lang racket

(require sicp-pict)

(define outline
	(segments->painter
		(list
			(segment (vect 0.0 0.0) (vect 0.0 1.0))
			(segment (vect 0.0 0.0) (vect 1.0 0.0))
			(segment (vect 0.0 1.0) (vect 1.0 1.0))
			(segment (vect 1.0 0.0) (vect 1.0 1.0)))))

(define x-painter
	(segments->painter
		(list
			(segment (vect 0.0 0.0) (vect 1.0 1.0))
			(segment (vect 0.0 1.0) (vect 1.0 0.0)))))

(define diamond
	(segments->painter
		(list
			(segment (vect 0.5 0) (vect 1.0 0.5))
			(segment (vect 1.0 0.5) (vect 0.5 1.0))
			(segment (vect 0.5 1.0) (vect 0.0 0.5))
			(segment (vect 0.0 0.5) (vect 0.5 0.0)))))

(paint outline)
(paint x-painter)
(paint diamond)
