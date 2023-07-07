
```
  3
 /  \
1    5

  4
 /  \
2    6
```

x1 = (entry set1)
x2 = (entry set2)

if (x1 = x2)
	(make-tree x1 (union-set (left-branch set1) set2) ((union-set (right-branch set1) set2))

if (x1 < x2)
	