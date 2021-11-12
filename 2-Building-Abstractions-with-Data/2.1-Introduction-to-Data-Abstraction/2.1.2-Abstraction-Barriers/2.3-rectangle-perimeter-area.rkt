#lang racket/base
(require racket/include)
(include "provide.rkt")

(define (make-rectangle s1 s2)
    (cons s1 s2))

(define (make-rectangle-p p1 p2 p3)
    (cons (make-segment p1 p2) (make-segment p2 p3)))

(define (long-edge r) (car r))

(define (short-edge r) (cdr r))

(define (length s)
    (sqrt (+ (square (- (x-point (start-segment s))
                        (x-point (end-segment s))))
             (square (- (y-point (start-segment s))
                        (y-point (end-segment s)))))))

(define (perimeter r)
    (* (+ (length (long-edge r)) (length (short-edge r))) 2))

(define (area r)
    (* (length (long-edge r)) (length (short-edge r))))

(define p1 (make-point 1 1))
(print-point p1)
(define p2 (make-point 1 3))
(print-point p2)
(define p3 (make-point 3 3))
(print-point p3)

(define s1 (make-segment p1 p2))
(define s2 (make-segment p2 p3))
(define r (make-rectangle s1 s2))
(perimeter r)
(area r)

(define r2 (make-rectangle-p p1 p2 p3))
(perimeter r2)
(area r2)
