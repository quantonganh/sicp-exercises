#lang racket

(require racket/trace)
(require "../put-get-coercion.rkt")

(trace-define (attach-tag type-tag contents)
	(cons type-tag contents))

(define (type-tag datum)
	(if (pair? datum)
		(car datum)
		(error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
	(if (pair? datum)
		(cdr datum)
		(error "Bad tagged datum: CONTENTS" datum)))

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags)))
			(if proc
				(apply proc (map contents args))
				(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

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
	(put 'make-from-real-imag 'complex
		(lambda (x y) (tag (make-from-real-imag x y))))
	; (put 'real-part '(complex) real-part)
	; (put 'imag-part '(complex) imag-part)
	(put 'magnitude '(complex) magnitude)
	; (put 'angle '(complex) angle)
	'done)

(install-rectangular-package)
(install-complex-package)

(provide make-complex-from-real-imag)
(trace-define (make-complex-from-real-imag x y)
	((get 'make-from-real-imag 'complex) x y))

(magnitude (make-complex-from-real-imag 3 4))
