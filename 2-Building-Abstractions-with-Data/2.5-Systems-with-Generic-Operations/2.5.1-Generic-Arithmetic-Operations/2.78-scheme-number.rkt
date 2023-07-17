#lang racket

(require racket/trace)

(define dispatch-table '())

(trace-define (put op type item)
	(set! dispatch-table (cons (list (list op type) item) dispatch-table)))
	
(provide get)
(trace-define (get op type)
	(let ((entry (assoc (list op type) dispatch-table)))
		(if entry
			(cadr entry)
			#f)))

(define (attach-tag type-tag contents)
	(if (number? contents)
		contents
		(cons type-tag contents)))

(define (type-tag datum)
	(cond
		((number? datum) 'scheme-number)
		((pair? datum) (car datum))
		(else
			(error "bad tagged datum" datum))))

(define (contents datum)
	(cond
		((number? datum) datum)
		((pair? datum) (cdr datum))
		(else
			(error "bad tagged datum" datum))))

(trace-define (install-scheme-number-package)
	(trace-define (tag x)
		(attach-tag 'scheme-number x))
	(put 'make 'scheme-number
		(lambda (x) (tag x)))
	(put 'add '(scheme-number scheme-number)
		(lambda (x y) (tag (+ x y))))
	'done)

(install-scheme-number-package)

(define (make-scheme-number n)
	((get 'make 'scheme-number) n))

(define (add x y) (apply-generic 'add x y))

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags)))
			(if proc
				(apply proc (map contents args))
				(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(add 3 5)
