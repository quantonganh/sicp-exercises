#lang racket/base
(require racket/trace)
(require racket/include)
(include "2/accumulate.rkt")

(define fold-right accumulate)

(trace-define (fold-left op initial sequence)
    (trace-define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))
