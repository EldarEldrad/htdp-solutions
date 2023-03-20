;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_465) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An SOE is a non-empty Matrix.
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define M-2
  (list (list 2 2  3 10)
        (list 3 9 21)
        (list 1 2)))

(define M-3
  (list (list 2 2  3 10)
        (list 3 9 21)
        (list -3 -8 -19)))

; Equation Equation -> Equation
; consumes two Equations of equal length.
; It “subtracts” a multiple of the second equation from the first, item by item,
; so that the resulting Equation has a 0 in the first position.
; Since the leading coefficient is known to be 0,
; subtract returns the rest of the list that results from the subtractions.
(check-expect (subtract '(2 5 12 31) '(2 2 3 10)) '(3 9 21))
(check-expect (subtract '(4 1 -2 1) '(2 2 3 10)) '(-3 -8 -19))
(check-expect (subtract '(-3 -8 -19) '(3 9 21)) '(1 2))
(define (subtract eq1 eq2)
  (local ((define coeff (/ (first eq1) (first eq2))))
    (map (lambda (e1 e2) (- e1 (* coeff e2))) (rest eq1) (rest eq2))))