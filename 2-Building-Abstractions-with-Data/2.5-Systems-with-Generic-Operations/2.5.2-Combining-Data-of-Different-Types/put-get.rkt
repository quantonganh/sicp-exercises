#lang racket

(require racket/trace)

(define *op-table* (make-hash))

(define (put op type proc)
	(hash-set! *op-table* (list op type) proc))

(trace-define (get op type)
	(hash-ref *op-table* (list op type) '()))

