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
	(put 'equ? '(scheme-number scheme-number)
		=)
	'done)

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))

(define (square x)
	(* x x))

(define (install-rectangular-package)
	;; internal procedures
	(define (real-part z) (car z))
	(define (imag-part z) (cdr z))
	(define (make-from-real-imag x y) (cons x y))
	(define (magnitude z)
    	(sqrt (+ (square (real-part z))
        		 (square (imag-part z)))))
	(define (angle z)
		(atan (imag-part z) (real-part z)))
	(define (make-from-mag-ang r a)
		(cons (* r (cos a)) (* r (sin a))))

	;; interface to the rest of the system
	(define (tag x) (attach-tag 'rectangular x))
	(put 'real-part '(rectangular) real-part)
	(put 'imag-part '(rectangular) imag-part)
	(put 'magnitude '(rectangular) magnitude)
	(put 'angle '(rectangular) angle)
	(put 'make-from-real-imag 'rectangular
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'rectangular
		(lambda (r a) (tag (make-from-mag-ang r a))))
	'done)

(trace-define (install-complex-package)
	(trace-define (make-from-real-imag x y)
		((get 'make-from-real-imag 'rectangular) x y))
	(trace-define (tag z) (attach-tag 'complex z))
	(put 'real-part '(complex) real-part)
	(put 'imag-part '(complex) imag-part)
	(define (equ? x y)
		(and (= (real-part x) (real-part y))
			 (= (imag-part x) (imag-part y))))
	(put 'make-from-real-imag 'complex
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'equ? '(complex complex)
		equ?)
	'done)

(install-scheme-number-package)
(install-rectangular-package)
(install-complex-package)

(define (make-scheme-number n)
	((get 'make 'scheme-number) n))

(define (add x y) (apply-generic 'add x y))

(define (equ? x y) (apply-generic 'equ? x y))

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags)))
			(if proc
				(apply proc (map contents args))
				(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(trace-define (make-complex-from-real-imag x y)
	((get 'make-from-real-imag 'complex) x y))

(equ? 3 4)
(equ? (make-complex-from-real-imag 3 4) (make-complex-from-real-imag 3 4))
