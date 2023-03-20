;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_394) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; produces a single sorted list of numbers that contains all the numbers on both inputs lists.
; A number occurs in the output as many times as it occurs on the two input lists together
(check-expect (merge '() '()) '())
(check-expect (merge '(1 2 3) '()) '(1 2 3))
(check-expect (merge '() '(2 3 4)) '(2 3 4))
(check-expect (merge '(1 2 3) '(2 3 4)) '(1 2 2 3 3 4))
(check-expect (merge '(1 3 6 9) '(2 5 6 8)) '(1 2 3 5 6 6 8 9))
(define (merge l1 l2)
  (cond
    [(empty? l1) l2]
    [(empty? l2) l1]
    [(<= (first l1) (first l2)) (cons (first l1) (merge (rest l1) l2))]
    [else (cons (first l2) (merge l1 (rest l2)))]))