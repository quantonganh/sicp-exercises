#lang racket/base
(require racket/trace)

(define (expmod base exp m)
    (remainder (fast-expt base exp) m))

(define (fast-expt b n)
    (fast-expt-iter b n 1))

(define (fast-expt-iter b counter product)
    (cond ((= counter 0)
            product)
        ((even? counter)
            (fast-expt-iter (square b)
                            (/ counter 2)
                            product))
        (else
            (fast-expt-iter b
                            (- counter 1)
                            (* b product)))))

(define (square x)
    (* x x))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(trace expmod)
(fast-prime? 199 99)
