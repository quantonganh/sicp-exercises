#lang sicp

(define (f n)
    (cond ((< n 3) n)
        (else (cond ((= n 3) 4)
            (else (f-iter 2 1 0 n))))))

(define (f-iter a b c count)
    (if (= count 0)
        c
        (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1))))

(display "x: ")
(define x (read))
(display "f(x): ")
(f x)
