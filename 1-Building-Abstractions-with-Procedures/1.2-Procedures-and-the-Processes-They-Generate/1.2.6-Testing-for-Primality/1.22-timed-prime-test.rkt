#lang racket/base

(define (prime? n)
    (= (smallest-divisor n) n))

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

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-time (- (current-milliseconds) start-time))))

(define (report-time elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (search-for-primes start end)
    (if (even? start)
        (search-for-primes (+ start 1) end)
        (cond ((< start end)
            (timed-prime-test start)
            (search-for-primes (+ start 2) end)))))

(define (even? n)
    (= (remainder n 2) 0))

(search-for-primes 90000 99999)
