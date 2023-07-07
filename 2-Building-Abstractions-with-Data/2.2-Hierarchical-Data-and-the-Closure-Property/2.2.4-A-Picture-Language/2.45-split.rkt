#lang racket

(require sicp-pict)

(display "Please run this in DrRacket as terminal may not have capability to display images directly") (newline)

(define (split op1 op2)
	(define (split-painter painter n)
		(if (= n 0)
			painter
			(let ((smaller (split-painter painter (- n 1))))
			(op1 painter (op2 smaller smaller)))))
	(split-painter einstein 1))


(define right-split (split beside below))
(define up-split (split below beside))

(paint right-split)
(paint up-split)