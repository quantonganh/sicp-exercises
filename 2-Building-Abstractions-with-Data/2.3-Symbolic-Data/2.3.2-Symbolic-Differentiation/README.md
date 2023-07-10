## 2.56

```
d(u + v ) / dx = du / dx + dv / dx
```

```scheme
((sum? exp) (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var)))
```

```
d(uv) / dx = u * dv / dx + v * du / dx
```

```scheme
     ((product? exp)
         (make-sum

           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))

           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
```

```
d(u^n) / dx = n * u^(n-1) * du / dx
```

```scheme
$ racket --repl
Welcome to Racket v8.9 [cs].
> (include "2.56-make-exponentiation.rkt")
> (deriv '(** x 0) 'x)
>(deriv '(** x 0) 'x)
> (make-exponentiation 'x -1)
< '(** x -1)
> (deriv 'x 'x)
< 1
<0
0

> (deriv '(** x 1) 'x)
>(deriv '(** x 1) 'x)
> (make-exponentiation 'x 0)
< 1
> (deriv 'x 'x)
< 1
<1
1

> (deriv '(** x 5) 'x)
>(deriv '(** x 5) 'x)
> (make-exponentiation 'x 4)
< '(** x 4)
> (deriv 'x 'x)
< 1
<'(* 5 (** x 4))
'(* 5 (** x 4))

```