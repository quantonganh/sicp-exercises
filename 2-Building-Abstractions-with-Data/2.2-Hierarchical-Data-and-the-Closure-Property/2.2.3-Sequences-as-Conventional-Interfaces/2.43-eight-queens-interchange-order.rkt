#lang racket/base
(require racket/trace)
(require racket/include)
(include "1/abs.rkt")
(include "2/accumulate.rkt")
(include "2/enumerate.rkt")
(include "2/for-each.rkt")
(include "2/list.rkt")

(trace-define (queen board-size)
    (trace-define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (new-row)
                        (map (lambda (rest-of-queens)
                                (adjoin-position new-row k rest-of-queens))
                             (queen-cols (- k 1))))
                    (enumerate-interval 1 board-size)))))
    (queen-cols board-size))

(define empty-board '())

(define (adjoin-position row col rest-of-queens)
    (cons (list row col) rest-of-queens))

(define (safe? k positions)
    (if (= (length positions) 1)
        #t
        (if (attack? (k-queen positions) (first-queen positions))
            #f
            (safe? k (remove (first-queen positions) positions)))))

(define (k-queen positions)
    (car positions))

(define (first-queen positions)
    (cadr positions))

(define (attack? q1 q2)
    (or (= (row q1) (row q2))
        (= (abs (- (row q1) (row q2)))
           (abs (- (col q1) (col q2))))))

(define (row position)
    (car position))

(define (col position)
    (cadr position))

(define (remove item sequence)
    (filter (lambda (x) (not (equal? x item)))
            sequence))

(define args (current-command-line-arguments))
(queen (string->number(vector-ref args 0)))
