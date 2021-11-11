#lang sicp

(define (fib n)
    (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
    (cond ((= count 0) b)
        ((even? count)
            (fib-iter a
                      b
                      (* (- count 2) 1) 
                      (+ (* (- (/ count 2) 2) q) (* (- (/ count 2) 1) (+ p q)))
                      (/ count 2)))
        (else
            (fib-iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p
                      q
                      (- count 1)))))

(define (double x)
    (* x x))

; (display "n: ")
; (define n (read))
; (display "fib(") (display n) (display "): ")
(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
