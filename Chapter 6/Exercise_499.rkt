;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_499) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
; computes the product of a list of numbers
(check-expect (product '()) 1)
(check-expect (product '(5)) 5)
(check-expect (product '(1 2 3)) 6)
(check-expect (product '(-4 5.3 5/2 0 -7)) 0)
(define (product lon)
  (local ((define (product/a lst cur)
            (cond
              [(empty? lst) cur]
              [else (product/a (rest lst) (* cur (first lst)))])))
    (product/a lon 1)))