#lang sicp

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

(display "without average damping:") (newline)
(fixed-point (lambda(x) (/ (log 1000) (log x))) 2)
(newline)
(display "with average damping:") (newline)
(fixed-point (lambda(x) (average x (/ (log 1000) (log x)))) 2)
