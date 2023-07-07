#lang racket

(require racket/trace)

(trace-define (equal? a b)
	(cond
		((and (null? a) (null? b)) #t)
		((or (null? a) (null? b)) #f)
		((and (symbol? a) (symbol? b))
			(eq? a b))
		((and (pair? a) (pair? b))
		 (and (equal? (car a) (car b))
			  (equal? (cdr a) (cdr b))))
		(else #f)))

(equal? '() '())
(equal? 'a '())
(equal? 'a 'a)
(equal? 'a 'b)
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
