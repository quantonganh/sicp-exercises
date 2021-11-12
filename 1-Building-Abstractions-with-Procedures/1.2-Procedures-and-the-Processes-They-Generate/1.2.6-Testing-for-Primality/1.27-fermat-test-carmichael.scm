#lang racket/base
(require racket/trace)

(define (expmod base exp m)
    (cond ((= exp 0) 1)
        ((even? exp)
            (remainder
                (square (expmod base (/ exp 2) m))
                m))
        (else
            (remainder
                (* base (expmod base (- exp 1) m))
                m))))

(define (square x)
    (* x x))

(define (fermat-test n)
    (define (fermat-test-iter a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(trace expmod)
(fermat-test 561)
; (fast-prime? 561 561)
