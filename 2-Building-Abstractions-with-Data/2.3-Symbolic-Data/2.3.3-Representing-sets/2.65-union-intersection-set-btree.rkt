#lang racket

(require racket/trace)

(include "tree.rkt")

(define (tree->list-2 tree)
	(trace-define (copy-to-list tree result-list)
		(if (null? tree)
			result-list
			(copy-to-list (left-branch tree)
						  (cons (entry tree)
								(copy-to-list (right-branch tree) result-list)))))
	(copy-to-list tree '()))


(define (list->tree elements)
	(car (partial-tree elements (length elements))))

(define (partial-tree elts n)
	(if (= n 0)
		(cons '() elts)
		(let ((left-size (quotient (- n 1) 2)))
			(let ((left-result
				   (partial-tree elts left-size)))
				(let ((left-tree (car left-result))
					  (non-left-elts (cdr left-result))
					  (right-size (- n (+ left-size 1))))
					(let ((this-entry (car non-left-elts))
						  (right-result (partial-tree (cdr non-left-elts) right-size)))
						(let ((right-tree (car right-result))
							  (remaining-elts (cdr right-result)))
							(cons (make-tree this-entry left-tree right-tree)
								   remaining-elts))))))))

(define (union-ordered-set set1 set2)
	(if (null? set1)
		set2
		(if (null? set2)
			set1
			(let ((x1 (car set1)) (x2 (car set2)))
				(cond ((= x1 x2)
				   (union-ordered-set (cdr set1) set2))
				  ((< x1 x2)
				   (cons x1 (union-ordered-set (cdr set1) set2)))
				  ((< x2 x1)
				   (cons x2 (union-ordered-set set1 (cdr set2)))))))))

(define (union-set set1 set2)
	(list->tree (union-ordered-set (tree->list-2 set1) (tree->list-2 set2))))

(define (element-of-set? x set)
	(cond ((null? set) #f)
		  ((= x (entry set)) #t)
		  ((< x (entry set))
		   (element-of-set? x (left-branch set)))
		  ((> x (entry set))
		   (element-of-set? x (right-branch set)))))

(define (intersection-set set1 set2)
	(let ((list1 (tree->list-2 set1))
		  (list2 (tree->list-2 set2)))
		(list->tree (filter (lambda (x) (element-of-set? x set2)) list1))))
		
(union-set (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 3 (make-tree 2 '() '()) (make-tree 6 '() '())))
(intersection-set (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 3 (make-tree 1 '() '()) (make-tree 6 '() '())))
