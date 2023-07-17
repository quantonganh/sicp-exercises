## 2.77

```scheme
$ racket 2.77-apply-generic-magnitude.rkt
>(put 'real-part '(rectangular) #<procedure:real-part>)
<#<void>
>(put 'imag-part '(rectangular) #<procedure:imag-part>)
<#<void>
>(put 'magnitude '(rectangular) #<procedure:magnitude>)
<#<void>
>(put 'angle '(rectangular) #<procedure:angle>)
<#<void>
>(put
  'make-from-real-imag
  'rectangular
  #<procedure:...neric-magnitude.rkt:65:16>)
<#<void>
>(put
  'make-from-mag-ang
  'rectangular
  #<procedure:...neric-magnitude.rkt:67:16>)
<#<void>
'done
>(put 'real-part '(polar) #<procedure:real-part>)
<#<void>
>(put 'imag-part '(polar) #<procedure:imag-part>)
<#<void>
>(put 'magnitude '(polar) #<procedure:magnitude>)
<#<void>
>(put 'angle '(polar) #<procedure:angle>)
<#<void>
>(put 'make-from-real-imag 'polar #<procedure:...neric-magnitude.rkt:88:16>)
<#<void>
>(put 'make-from-mag-ang 'polar #<procedure:...neric-magnitude.rkt:90:16>)
<#<void>
'done
>(put 'make-from-real-imag 'complex #<procedure:...neric-magnitude.rkt:98:16>)
<#<void>
>(put 'make-from-real-imag 'complex #<procedure:...neric-magnitude.rkt:100:16>)
<#<void>
'done
>(attach-tag 'rectangular '(3 . 4))
<'(rectangular 3 . 4)
>(tag '(rectangular 3 . 4))
>(attach-tag 'complex '(rectangular 3 . 4))
<'(complex rectangular 3 . 4)
No method for these types: APPLY-GENERIC '(magnitude (complex))
```

As you can see from the above output, we only did this:

```scheme
>(put 'magnitude '(rectangular) #<procedure:magnitude>)
>(put 'magnitude '(polar) #<procedure:magnitude>)
```

That's the reason why we got this error:

```
No method for these types: APPLY-GENERIC '(magnitude (complex))
```

After adding this into `install-complex-package`, everything will be ok:

```scheme
>(put 'magnitude '(complex) #<procedure:magnitude>)
<#<void>
'done
>(attach-tag 'rectangular '(3 . 4))
<'(rectangular 3 . 4)
>(tag '(rectangular 3 . 4))
>(attach-tag 'complex '(rectangular 3 . 4))
<'(complex rectangular 3 . 4)
5
```
