#lang racket/base
(require racket/trace)

(define (fast-multiply a b)
    (fast-multiply-iter a b 0))

(define (fast-multiply-iter a b product)
    (cond ((= b 0)
            product)
        ((even? b)
            (fast-multiply-iter (double a) (halve b) product))
        (else
            (fast-multiply-iter a (- b 1) (+ a product)))))

(define (double x)
    (+ x x))

(define (halve x)
    (/ x 2))

(trace fast-multiply-iter)
(fast-multiply 3 8)
