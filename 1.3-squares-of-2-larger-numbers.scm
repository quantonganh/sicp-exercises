#lang sicp

(define (square x)
  (* x x))

(define (max a b)
  (cond ((> a b) a)
        (else b)))

(define (max3 a b c)
  (max (max a b) (max b c)))

(define (2ndLargest a b c)
  (cond (> a b) (max b c)
        (else (max a c))))
  
(define (sumSquaresOf2LargerNumbers a b c)
  (+ (square (max3 a b c)) (square (2ndLargest a b c))))

(display "number 1: ")
(define num1 (read))
(display "number 2: ")
(define num2 (read))
(display "number 3: ")
(define num3 (read))

(display "The sum of the squares of 2 larger numbers is: ")
(display (sumSquaresOf2LargerNumbers num1 num2 num3))
