#lang racket

(require racket/trace
		 racket/file
		 "../tag.rkt")

(require "../put-get-coercion.rkt")
(require "apply-generic.rkt")
(require (file "../2.5.1-Generic-Arithmetic-Operations/2.77-apply-generic-magnitude.rkt"))

(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(define (scheme-number->complex n)
	(make-complex-from-real-imag (contents n) 0))

(put-coercion 'scheme-number
			  'scheme-number
			  scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
(put-coercion 'scheme-number
			  'complex
			  scheme-number->complex)

(define (install-complex-package)
	(define (make-from-real-imag x y)
		((get 'make-from-real-imag 'rectangular) x y))
	(define (tag z) (attach-tag 'complex z))
	(put 'make-from-real-imag 'complex
		(lambda (x y) (tag (make-from-real-imag x y))))
	'done)

(define (install-scheme-number-package)
	(define (tag x)
		(attach-tag 'scheme-number x))
	(put 'make 'scheme-number
		(lambda (x) (tag x)))
	(put 'add '(scheme-number scheme-number)
		(lambda (x y) (tag (+ x y))))
	(put 'exp '(scheme-number scheme-number)
		(lambda (x y) (tag (expt x y))))
	'done)

(install-complex-package)
(install-scheme-number-package)

(trace-define (exp x y) (apply-generic 'exp x y))

(define z1 (make-complex-from-real-imag 3 4))
(define z2 (make-complex-from-real-imag 5 6))

(exp z1 2)
