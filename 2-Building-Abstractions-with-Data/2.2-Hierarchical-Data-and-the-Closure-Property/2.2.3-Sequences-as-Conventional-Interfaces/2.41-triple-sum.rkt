#lang racket/base
(require racket/trace)
(require racket/include)
(include "2/accumulate.rkt")
(include "2/enumerate.rkt")

(define (make-triple triple)
    (list (car triple) (cadr triple) (car (cddr triple))))

(define (equal-given-sum? triple s)
    (= s (+ (car triple) (cadr triple) (car (cddr triple)))))

(define (unique-triples n)
    (flatmap
        (lambda (i)
            (flatmap
                (lambda (j)
                    (map (lambda (k) (list i j k))
                         (enumerate-interval 1 (- j 1))))
                (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

; (unique-triples 5)

(define (triple-sum n s)
    (map make-triple (filter (lambda (triple)
                                (equal-given-sum? triple s))
                             (unique-triples n))))

(trace triple-sum)
(triple-sum 4 8)
