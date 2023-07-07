#lang racket

(require racket/trace)
(require rackunit)

(include "huffman.rkt")

(provide generate-huffman-tree)
(trace-define (generate-huffman-tree pairs)
	(successive-merge (make-leaf-set pairs)))

(trace-define (successive-merge leaves)
	(if (null? (cdr leaves))
		(car leaves)
		(successive-merge (adjoin-set (make-code-tree (car leaves) (cadr leaves)) (cddr leaves)))))

(trace-define (make-leaf-set pairs)
	(if (null? pairs)
		'()
		(let ((pair (car pairs)))
			(adjoin-set (make-leaf (car pair)
								   (cadr pair))
						(make-leaf-set (cdr pairs))))))

(define (adjoin-set x set)
	(cond ((null? set) (list x))
		  ((< (weight x) (weight (car set))) (cons x set))
		  (else (cons (car set)
					  (adjoin-set x (cdr set))))))

(check-equal? (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))) '(((leaf A 4) ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4) (A B D C) 8)))
