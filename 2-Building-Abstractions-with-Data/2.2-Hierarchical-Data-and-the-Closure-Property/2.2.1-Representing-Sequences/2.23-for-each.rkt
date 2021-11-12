#lang racket/base
(require racket/trace)

(define (for-each proc items)
    (if (null? items)
        (newline)
        (begin
            (proc (car items))
            (for-each proc (cdr items))
        )
    )
)

; (trace for-each)
(for-each (lambda (x)
            (newline)
            (display x))
          (list 1 2 3))

