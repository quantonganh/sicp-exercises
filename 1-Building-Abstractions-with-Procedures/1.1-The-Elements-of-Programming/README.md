# 1.1.5 The Substitution Model for Procedure Application

- Normal-order evaluation:
	- Evaluate the leftmost functions first
	- Evaluate every functions before evaluating any arguments

```scheme
(sum-of-squares (+ 5 1) (* 5 2))
(+    (square (+ 5 1)).       (square (* 5 2))   )
(+    (* (+ 5 1) (+ 5 1))     (* (* 5 2) (* 5 2)))
(+    (* 6 6))                (* 10 10))
(+       36                      100)
					136
```

- Applicative-order evaluation:
	- arguments are evaluated before the function is applied
	- recursive functions may not terminated

```scheme
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136
```

