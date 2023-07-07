#lang racket

(include "tree.rkt")

(define (lookup given-key set-of-records)
	(cond ((null? set-of-records) #f)
		((equal? given-key (entry set-of-records))
		 (entry set-of-records))
		((< given-key (entry set-of-records))
		 (lookup given-key (left-branch set-of-records)))
		((> given-key (entry set-of-records))
		 (lookup given-key (right-branch set-of-records)))))

(define my-tree
	(make-tree 3
			   (make-tree 1 '() '())
			   (make-tree 5 '() '())))

(lookup 4 my-tree)
