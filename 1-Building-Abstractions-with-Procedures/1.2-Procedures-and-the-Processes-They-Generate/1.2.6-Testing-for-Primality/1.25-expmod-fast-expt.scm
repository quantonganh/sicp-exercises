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

(trace expmod)
(expmod 2 100000000000 100000000000)
