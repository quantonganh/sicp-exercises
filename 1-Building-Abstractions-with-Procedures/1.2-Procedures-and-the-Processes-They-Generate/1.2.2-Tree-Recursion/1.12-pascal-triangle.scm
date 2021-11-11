#lang sicp

(define (pascal row col)
    (cond ((or (= col 1) (= col row)) 1)
        (else (+ (pascal (- row 1) (- col 1))
                (pascal (- row 1) col)))))

(define (print-pascal-row n)
    (define (column-iter j)
        (display (pascal n j)) (display "  ")
        (if (= j n)
            (newline)
            (column-iter (+ j 1))))
    (column-iter 1))

(define (print-pascal n)
    (define (print-pascal-iter i)
        (print-pascal-row i)
        (if (= i n)
            (values)
            (print-pascal-iter (+ i 1))))
    (print-pascal-iter 1))

(print-pascal 10)
