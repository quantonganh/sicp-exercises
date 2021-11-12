#lang racket/base
(require racket/trace)
(require racket/include)
(include "1/prime.rkt")
(include "2/accumulate.rkt")
(include "2/enumerate.rkt")

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

(define (unique-pairs n)
    (flatmap
        (lambda (i)
            (map (lambda (j) (list i j))
                 (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

; (unique-pairs 4)

(define (prime-sum-pairs n)
    (map make-pair-sum (filter prime-sum? (unique-pairs n))))

(prime-sum-pairs 6)
