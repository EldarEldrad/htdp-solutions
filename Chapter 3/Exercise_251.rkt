;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(check-expect (sum '()) 0)
(check-expect (sum '(1)) 1)
(check-expect (sum '(1 2)) 3)
(check-expect (sum '(-5 6 -2 1)) 0)
(check-expect (sum '(1 2 3 4 5 6 7 8 9)) 45)
(check-expect (sum '(0 0 0 0 0)) 0)
(define (sum l)
  (fold1 + 0 l))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(check-expect (product '()) 1)
(check-expect (product '(1)) 1)
(check-expect (product '(1 2)) 2)
(check-expect (product '(-5 6 -2 1)) 60)
(check-expect (product '(1 2 3 4 5 6)) 720)
(check-expect (product '(542 -56 0 124 -56)) 0)
(define (product l)
  (fold1 * 1 l))

; [Number Number -> Number] Number [List-of Number] -> Number
; folds given list into single number using given function and initial value
(define (fold1 f n l)
  (cond
    [(empty? l) n]
    [else (f (first l)
             (fold1 f n (rest l)))]))