#lang racket/base
(require racket/trace)

(define (compose f g)
    (trace g)
    (trace f)
    (lambda (x) (f (g x))))

(define (identity x) x)

(define (square x) (* x x))

(define (repeated f n)
    (cond ((= n 0) identity)
        ((even? n)
            (compose (repeated f (/ n 2)) (repeated f (/ n 2))))
        (else
            (compose f (repeated f (- n 1))))))

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

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))

    (define (try guess step)
        (display step) (display ": ") (display guess) (newline)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next (+ step 1)))))
    
    (try first-guess 1))

(define (average a b)
    (/ (+ a b) 2))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (nth-root x n)
    (fixed-point ((repeated average-damp (floor (log n 2))) (lambda(y) (/ x (fast-expt y (- n 1)))))
                 1.0))

(nth-root 63 5)
