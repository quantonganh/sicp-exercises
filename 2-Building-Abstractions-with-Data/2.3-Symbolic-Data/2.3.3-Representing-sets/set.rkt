(define (ordered? set)
	(cond
		((null? set) #t)
		((null? (cdr set)) #t)
		((<= (car set) (cadr set))
		 (ordered? (cdr set)))
		(else #f)))
