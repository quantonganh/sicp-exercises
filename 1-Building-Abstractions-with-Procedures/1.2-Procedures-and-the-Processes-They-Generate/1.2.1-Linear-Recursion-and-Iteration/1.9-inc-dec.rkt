#lang racket/base
(require racket/trace)

(trace-define (inc x)
    (+ x 1))

(trace-define (dec x)
    (- x 1))

(trace-define (add-1 a b)
    (if (= a 0)
        b
        (inc (add-1 (dec a) b))))

(add-1 4 5)

(trace-define (add-2 a b)
    (if (= a 0)
        b
        (add-2 (dec a) (inc b))))

(add-2 4 5)
