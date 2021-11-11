#lang racket/base
(require racket/trace)

(trace-define (count-change amount)
    (cc amount 1))

(trace-define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)))

(define args (current-command-line-arguments))
(count-change (string->number(vector-ref args 0)))
