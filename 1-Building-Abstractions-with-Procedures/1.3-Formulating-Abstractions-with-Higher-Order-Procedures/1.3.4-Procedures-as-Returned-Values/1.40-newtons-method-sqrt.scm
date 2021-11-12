#lang racket/base
(require racket/trace)

(define dx 0.00001)

(define (deriv g)
    (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (cube x) (* x x x))

((deriv cube) 5)

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

(define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (square x)
    (* x x))

(define (sqrt x)
    (newtons-method
        (lambda (y) (- (square y) x)) 1.0))

(sqrt 1000)
