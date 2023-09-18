## 2.81

### a

infinite loop:

```scheme
>(apply-generic 'exp '(complex rectangular 3 . 4) '(complex rectangular 5 . 6))
> (get 'exp '(complex complex))
< #f
> (get-coercion 'complex 'complex)
< #<procedure:complex->complex>
> (get-coercion 'complex 'complex)
< #<procedure:complex->complex>
>(apply-generic 'exp '(complex rectangular 3 . 4) '(complex rectangular 5 . 6))
> (get 'exp '(complex complex))
< #f
> (get-coercion 'complex 'complex)
< #<procedure:complex->complex>
> (get-coercion 'complex 'complex)
< #<procedure:complex->complex>
user break
```

## 2.82

```
(apply-generic op (t1->t1 a1) (t2->t1 a2) (t3->t1 a3))
(apply-generic op (t1->t2 a1) a2 (t3->t2 a3))
(apply-generic op (t1->t3 a1) (t2->t3 a2) a3))
```

