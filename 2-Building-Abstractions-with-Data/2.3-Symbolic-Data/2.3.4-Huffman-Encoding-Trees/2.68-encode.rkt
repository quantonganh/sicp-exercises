#lang racket

(include "huffman.rkt")

(require racket/trace)
(require rackunit)

(provide encode)
(trace-define (encode message tree)
	(if (null? message)
		'()
		(append (encode-symbol (car message) tree)
				(encode (cdr message) tree))))

(trace-define (encode-symbol symbol tree)
	(if (leaf? tree)
		(if (eq? symbol (symbol-leaf tree))
			'()
			(error "symbol not found: " symbol))
		(let ((left (left-branch tree)))
			(if (member symbol (symbols left))
				(cons 0 (encode-symbol symbol left))
				(cons 1 (encode-symbol symbol (right-branch tree)))))))

(check-exn exn:fail? (thunk (encode '(Z) sample-tree)))
(check-equal? (encode plaintext-message sample-tree) sample-message)
