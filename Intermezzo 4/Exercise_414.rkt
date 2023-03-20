;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_414) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define N #i1/185)
(define tolerance 0.0001)

; Number -> Number
; adds up to n copies of number N
(check-expect (add 0) 0)
(check-within (add 1) N 0.0001)
(check-within (add 2) (+ N N) 0.0001)
(check-within (add 185) 1 0.0001)
(define (add n)
  (cond
    [(= n 0) 0]
    [else (+ N (add (- n 1)))]))

; Number -> Number
; counts how often N can be subtracted from the argument until it is 0
(check-expect (sub 0) 0)
(check-expect (sub 1/185) 0)
(check-expect (sub #i1/185) 1)
(check-expect (sub 2/185) 2)
(check-expect (sub 1) 185)
(check-expect (sub #i1.0) 185)
(define (sub n)
  (cond
    [(< n N) 0]
    [else (+ 1 (sub (- n N)))]))