#lang sicp

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
        ((devides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
    (* x x))

(define (devides? a b)
    (= (remainder b a) 0))

(display "n: ")
(define n (read))
(display "smallest-divisor(n): ")
(smallest-divisor n)
