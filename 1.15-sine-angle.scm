#lang sicp

(define (cube x) (* x x x))

(define (p x)
    (- (* 3 x) (* 4 (cube x))))

(define (sine angle step)
    (display step) (display ": ") (display angle) (newline)
    (if (<= (abs angle) 0.1)
        angle
        (p (sine (/ angle 3.0) (+ step 1)))))

(define (sine-count-step angle step)
    (if (> (abs angle) 0.1)
        (sine-count-step (/ angle 3.0) (+ step 1))
        step))

(sine 12000000 1)
