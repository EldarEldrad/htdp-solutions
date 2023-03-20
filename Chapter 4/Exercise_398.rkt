;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_398) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> Number
; function consumes two equally long lists: a linear combination and a list of variable values.
; It produces the value of the combination for these values.
(check-expect (value '() '()) 0)
(check-expect (value '(2) '(3)) 6)
(check-expect (value '(3 5) '(-1 7)) 32)
(check-expect (value '(5 17 3) '(10 1 2)) 73)
(define (value loc lov)
  (cond
    [(empty? loc) 0]
    [else (+ (* (first loc) (first lov))
             (value (rest loc) (rest lov)))]))