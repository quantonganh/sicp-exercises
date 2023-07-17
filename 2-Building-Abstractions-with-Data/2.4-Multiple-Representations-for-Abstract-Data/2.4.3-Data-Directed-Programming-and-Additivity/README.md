To implement this plan, assume that we have two procedures, put and get, for manipulating the operation-and-type table:

• (put ⟨op ⟩ ⟨type ⟩ ⟨item ⟩) installs the ⟨item ⟩ in the table, indexed by the ⟨op ⟩ and the ⟨type ⟩.

• (get ⟨op ⟩ ⟨type ⟩) looks up the ⟨op ⟩, ⟨type ⟩ entry in the table and returns the item found there. If no item is found, get returns false.

```scheme
(define dispatch-table '())

(define (put op type item)
    (set! dispatch-table (cons (list (list op type) item) dispatch-table)))

(define (get op type)
    (let ((entry (assoc (list op type) dispatch-table)))
        (if entry
            (cadr entry)
            #f)))

(put 'deriv '+ deriv-sum)
(put 'deriv '* deriv-product)
(put 'deriv '** deriv-exponentiation)
```

```sh
$ racket --repl
Welcome to Racket v8.9 [cs].
> (require "2.73-deriv-data-directed-style.rkt")
> (get 'deriv '+)
#<procedure:deriv-sum>
> (get 'deriv '*)
#<procedure:deriv-product>
> (get 'deriv '**)
#<procedure:deriv-exponentiation>
>
```