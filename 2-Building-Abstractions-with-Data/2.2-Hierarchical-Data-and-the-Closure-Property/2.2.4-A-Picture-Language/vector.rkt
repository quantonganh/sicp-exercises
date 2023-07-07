(define (make-vect x y)
	(cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))

(define (print-vect v)
    (display "(")
    (display (xcor-vect v))
    (display ",")
    (display (ycor-vect v))
    (display ")")
    (newline))

(define (origin-frame frame)
	(car frame))

(define (edge1-frame frame)
	(car (cdr frame)))

(define (edge2-frame frame)
	(caddr frame))
