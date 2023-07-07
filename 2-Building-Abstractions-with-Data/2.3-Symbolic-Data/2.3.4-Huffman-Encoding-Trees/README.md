## 2.67 Decode

```
 { A B D C} 8
   /      \ 
  /        \
A 4    { B D C } 4
        /       \
       /         \
      B 2     { D C } 2
              /     \
             /        \ 
           D 1         C 1
```

0 1 1 0 0 1 0 1 0 1 1 1 0

- 0: left -> A
- 110: right -> right -> left -> D
- 0: left -> A
- 10: B
- 10: B
- 111: C
- 0: A

A D A B B C A

```
$ racket 2.67-decode-message.rkt
>(decode-1
  '(0 1 1 0 0 1 0 1 0 1 1 1 0)
  '((leaf A 4)
    ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
    (A B D C)
    8))
> (decode-1
   '(1 1 0 0 1 0 1 0 1 1 1 0)
   '((leaf A 4)
     ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
     (A B D C)
     8))
> (decode-1
   '(1 0 0 1 0 1 0 1 1 1 0)
   '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> (decode-1 '(0 0 1 0 1 0 1 1 1 0) '((leaf D 1) (leaf C 1) (D C) 2))
> >(decode-1
    '(0 1 0 1 0 1 1 1 0)
    '((leaf A 4)
      ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
      (A B D C)
      8))
> > (decode-1
     '(1 0 1 0 1 1 1 0)
     '((leaf A 4)
       ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
       (A B D C)
       8))
> > (decode-1
     '(0 1 0 1 1 1 0)
     '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > >(decode-1
      '(1 0 1 1 1 0)
      '((leaf A 4)
        ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
        (A B D C)
        8))
> > >(decode-1
      '(0 1 1 1 0)
      '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > > (decode-1
       '(1 1 1 0)
       '((leaf A 4)
         ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
         (A B D C)
         8))
> > > (decode-1
       '(1 1 0)
       '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > > (decode-1 '(1 0) '((leaf D 1) (leaf C 1) (D C) 2))
> > > >(decode-1
        '(0)
        '((leaf A 4)
          ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
          (A B D C)
          8))
> > > > (decode-1
         '()
         '((leaf A 4)
           ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
           (A B D C)
           8))
< < < < '()
< < < <'(A)
< < < '(C A)
< < <'(B C A)
< < '(B B C A)
< <'(A B B C A)
< '(D A B B C A)
<'(A D A B B C A)
'(A D A B B C A)
```

## 2.68 Encode

> Given a Huffman tree, we can find the encoding of any symbol by starting at the root and moving down until we reach the leaf that holds the symbol. Each time we move down a left branch we add a 0 to the code, and each time we move down a right branch we add a 1. (We decide which branch to follow by testing to see which branch either is the leaf node for the symbol or contains the symbol in its set.)

```
$ racket 2.68-encode-message.rkt
>(encode
  '(Z)
  '((leaf A 4)
    ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
    (A B D C)
    8))
> (encode-symbol
   'Z
   '((leaf A 4)
     ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
     (A B D C)
     8))
> >(encode-symbol 'Z '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > (encode-symbol 'Z '((leaf D 1) (leaf C 1) (D C) 2))
> > >(encode-symbol 'Z '(leaf C 1))
>(encode
  '(A D A B B C A)
  '((leaf A 4)
    ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
    (A B D C)
    8))
> (encode-symbol
   'A
   '((leaf A 4)
     ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
     (A B D C)
     8))
> >(encode-symbol 'A '(leaf A 4))
< <'()
< '(0)
> (encode
   '(D A B B C A)
   '((leaf A 4)
     ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
     (A B D C)
     8))
> >(encode-symbol
    'D
    '((leaf A 4)
      ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
      (A B D C)
      8))
> > (encode-symbol 'D '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > >(encode-symbol 'D '((leaf D 1) (leaf C 1) (D C) 2))
> > > (encode-symbol 'D '(leaf D 1))
< < < '()
< < <'(0)
< < '(1 0)
< <'(1 1 0)
> >(encode
    '(A B B C A)
    '((leaf A 4)
      ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
      (A B D C)
      8))
> > (encode-symbol
     'A
     '((leaf A 4)
       ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
       (A B D C)
       8))
> > >(encode-symbol 'A '(leaf A 4))
< < <'()
< < '(0)
> > (encode
     '(B B C A)
     '((leaf A 4)
       ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
       (A B D C)
       8))
> > >(encode-symbol
      'B
      '((leaf A 4)
        ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
        (A B D C)
        8))
> > > (encode-symbol
       'B
       '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > > >(encode-symbol 'B '(leaf B 2))
< < < <'()
< < < '(0)
< < <'(1 0)
> > >(encode
      '(B C A)
      '((leaf A 4)
        ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
        (A B D C)
        8))
> > > (encode-symbol
       'B
       '((leaf A 4)
         ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
         (A B D C)
         8))
> > > >(encode-symbol
        'B
        '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > > > (encode-symbol 'B '(leaf B 2))
< < < < '()
< < < <'(0)
< < < '(1 0)
> > > (encode
       '(C A)
       '((leaf A 4)
         ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
         (A B D C)
         8))
> > > >(encode-symbol
        'C
        '((leaf A 4)
          ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
          (A B D C)
          8))
> > > > (encode-symbol
         'C
         '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
> > > > >(encode-symbol 'C '((leaf D 1) (leaf C 1) (D C) 2))
> > > > > (encode-symbol 'C '(leaf C 1))
< < < < < '()
< < < < <'(1)
< < < < '(1 1)
< < < <'(1 1 1)
> > > >(encode
        '(A)
        '((leaf A 4)
          ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
          (A B D C)
          8))
> > > > (encode-symbol
         'A
         '((leaf A 4)
           ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
           (A B D C)
           8))
> > > > >(encode-symbol 'A '(leaf A 4))
< < < < <'()
< < < < '(0)
> > > > (encode
         '()
         '((leaf A 4)
           ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
           (A B D C)
           8))
< < < < '()
< < < <'(0)
< < < '(1 1 1 0)
< < <'(1 0 1 1 1 0)
< < '(1 0 1 0 1 1 1 0)
< <'(0 1 0 1 0 1 1 1 0)
< '(1 1 0 0 1 0 1 0 1 1 1 0)
<'(0 1 1 0 0 1 0 1 0 1 1 1 0)
```

## 2.69

> The following procedure takes as its argument a list of symbol-frequency pairs (where no symbol appears in more than one pair) and generates a Huffman encoding tree according to the Huffman algorithm.

```
(define (generate-huffman-tree pairs)
	(successive-merge (make-leaf-set pairs)))
```

> `make-leaf-set` is the procedure given above that trans- forms the list of pairs into an ordered set of leaves. `successive-merge` is the procedure you must write, using `make-code-tree` to successively merge the smallest-weight elements of the set until there is only one element left, which is the desired Huffman tree.

```
$ racket 2.69-generate-huffman-tree.rkt
>(make-code-tree '(leaf D 1) '(leaf C 1))
<'((leaf D 1) (leaf C 1) (D C) 2)
>(make-code-tree '(leaf B 2) '((leaf D 1) (leaf C 1) (D C) 2))
<'((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
>(make-code-tree
  '(leaf A 4)
  '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
<'((leaf A 4)
   ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
   (A B D C)
   8)
>(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
> (make-leaf-set '((A 4) (B 2) (C 1) (D 1)))
> >(make-leaf-set '((B 2) (C 1) (D 1)))
> > (make-leaf-set '((C 1) (D 1)))
> > >(make-leaf-set '((D 1)))
> > > (make-leaf-set '())
< < < '()
< < <'((leaf D 1))
< < '((leaf D 1) (leaf C 1))
< <'((leaf D 1) (leaf C 1) (leaf B 2))
< '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4))
>(successive-merge '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4)))
> (make-code-tree '(leaf D 1) '(leaf C 1))
< '((leaf D 1) (leaf C 1) (D C) 2)
>(successive-merge '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (leaf A 4)))
> (make-code-tree '(leaf B 2) '((leaf D 1) (leaf C 1) (D C) 2))
< '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
>(successive-merge
  '((leaf A 4) ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)))
> (make-code-tree
   '(leaf A 4)
   '((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4))
< '((leaf A 4)
    ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
    (A B D C)
    8)
>(successive-merge
  '(((leaf A 4)
     ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
     (A B D C)
     8)))
<'(((leaf A 4)
    ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
    (A B D C)
    8))
```

## 2.70

```
$ racket 2.70-encode-lyrics.rkt
2.70-encode-lyrics.rkt:5:1: generate-huffman-tree: unbound identifier
  in: generate-huffman-tree
  location...:
   2.70-encode-lyrics.rkt:5:1
```
Since 2.69 is a module (`#lang`), to call `generate-huffman-tree` function, we must use `require`, instead of `include`, and make sure that it's exported by using `provide`:

```
(provide generate-huffman-tree)
(trace-define (generate-huffman-tree pairs)
        (successive-merge (make-leaf-set pairs)))
```

```

```

