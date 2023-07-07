#lang racket

(include "huffman.rkt")
(require "2.68-encode.rkt")
(require "2.69-generate-huffman-tree.rkt")

(define lyrics '(GET A JOB
				 SHA NA NA NA NA NA NA NA NA
				 GET A JOB
				 SHA NA NA NA NA NA NA NA NA
				 WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
				 SHA BOOM))

(define lyrics-tree (generate-huffman-tree '((A 2) (BOOM 1) (GET 2) (JOB 2) (SHA 3) (NA 16) (WAH 1) (YIP 9))))
(encode lyrics lyrics-tree)
