#lang racket/base
(require racket/trace)

(define (compose f g)
    (trace g)
    (trace f)
    (lambda (x) (f (g x))))

(define (square x)
    (* x x))

(define (inc x)
    (+ x 1))

((compose square inc) 6)
