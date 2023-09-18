#lang racket

(require racket/hash)
(require racket/trace)

(define *op-table* (make-hash))

(provide put)
(define (put op type proc)
	(hash-set! *op-table* (list op type) proc))

(provide get)
(trace-define (get op type)
	(hash-ref *op-table* (list op type) #f))

(define *coercion-table* (make-hash))

(provide put-coercion)
(trace-define (put-coercion from-type to-type proc)
	(hash-set! *coercion-table* (list from-type to-type) proc))

(provide get-coercion)
(trace-define (get-coercion from-type to-type)
	(hash-ref *coercion-table* (list from-type to-type) #f))
