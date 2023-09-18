#lang racket

(require racket/trace
		 "../tag.rkt"
		 "../put-get-coercion.rkt"
		 (file "../2.5.1-Generic-Arithmetic-Operations/2.77-apply-generic-magnitude.rkt"))

(define (scheme-number->complex n)
	(make-complex-from-real-imag (contents n) 0))

(put-coercion 'scheme-number
			  'complex
			  scheme-number->complex)

(provide apply-generic)
(trace-define (apply-generic op . args)
	(define (coerce-to-type arg target-type)
		(let ((source-type (car arg)))
			(if (eq? source-type target-type)
				(contents arg)
				(let ((source->target (get-coercion source-type target-type)))
					(source->target arg)
					#f))))

	(define (apply-op op . args)
		(apply op args))

	(define (try-coerce args arg-types)
		(cond ((null? args) '())
			  ((null? arg-types) (error "Not enough arg"))
			  ((coerce-to-type (car args) (car arg-types))
			  => (lambda (coerced-arg)
					(cons coerced-arg (try-coerce (cdr args) (cdr arg-types)))))
			  (else (error "Coercion not possible"))))

	(let ((arg-types (map type-tag args))
		  (coerced-args (try-coerce args (map type-tag args))))
		(apply-op op . coerced-args)))

(trace-define (add x y z) (apply-generic 'add x y z))

(define z1 (make-complex-from-real-imag 3 4))
(define z2 (make-complex-from-real-imag 5 6))

(add 2 z1 z2)

sicp 2.82 apply generic multiple args
