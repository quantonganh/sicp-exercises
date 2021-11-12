(define (for-each proc items)
    (if (null? items)
        (newline)
        (begin
            (proc (car items))
            (for-each proc (cdr items)))))
