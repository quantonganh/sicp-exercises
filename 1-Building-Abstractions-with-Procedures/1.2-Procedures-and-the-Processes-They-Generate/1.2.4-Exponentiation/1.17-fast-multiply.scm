#lang racket/base
(require racket/trace)

(define (multiply a b)
    (if (= b 0)
        0
        (+ a (multiply a (- b 1)))))

(trace multiply)
(multiply 3 8)

(define (fast-multiply a b)
    (fast-multiply-iter a b))

(define (fast-multiply-iter a b)
    (cond ((= b 0)
            0)
        ((even? b)
            (double (fast-multiply-iter a (halve b))))
        (else
            (+ a (fast-multiply-iter a (- b 1))))))

(define (double x)
    (+ x x))

(define (halve x)
    (/ x 2))

(trace fast-multiply-iter)
(fast-multiply 3 8)
