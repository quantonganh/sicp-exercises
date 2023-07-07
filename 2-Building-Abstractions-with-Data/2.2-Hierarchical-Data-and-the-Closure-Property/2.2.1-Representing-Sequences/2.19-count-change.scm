#lang racket/base
(require racket/include)
(include "2/list.rkt")

(define us-coins (list 1 5 10 25 50))

(define uk-coins (list 1 2 5 10 20 50 100))

(define (first-denomination items) (car items))

(define (except-first-denomination items) (cdr items))

(define (no-more? items)
    (= (length items) 0))

(define (cc amount coin-values)
    (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
            (+ (cc amount
                   (except-first-denomination
                    coin-values))
               (cc (- amount
                      (first-denomination coin-values))
                   coin-values)))))

(cc 100 us-coins)
(cc 100 uk-coins)
