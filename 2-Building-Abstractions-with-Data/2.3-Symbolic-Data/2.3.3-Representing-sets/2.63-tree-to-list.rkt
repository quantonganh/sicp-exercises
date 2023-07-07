#lang racket

(require racket/trace)
(require rackunit)

(include "tree.rkt")

(trace-define (tree->list-1 tree)
	(if (null? tree)
		'()
		(append (tree->list-1 (left-branch tree))
			(cons (entry tree)
				  (tree->list-1 (right-branch tree))))))

(trace-define (tree->list-2 tree)
	(trace-define (copy-to-list tree result-list)
		(if (null? tree)
			result-list
			(copy-to-list (left-branch tree)
						  (cons (entry tree)
								(copy-to-list (right-branch tree) result-list)))))
	(copy-to-list tree '()))

(define my-tree
	(make-tree 3
			   (make-tree 1 '() '())
			   (make-tree 5 '() '())))

(define your-tree
	(make-tree 4
			   (make-tree 2 '() '())
			   (make-tree 6 '() '())))

(check-equal? (tree->list-1 my-tree) '(1 3 5))
(check-equal? (tree->list-2 my-tree) '(1 3 5))
(check-equal? (tree->list-2 your-tree) '(2 4 6))
