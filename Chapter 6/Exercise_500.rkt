;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_500) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Any] -> Number
; determines the number of items on a list
(check-expect (how-many '()) 0)
(check-expect (how-many '(5)) 1)
(check-expect (how-many '(1 2 3)) 3)
(check-expect (how-many '(-4 #false 5/2 a "hello")) 5)
(define (how-many loa)
  (local ((define (how-many/a lst cur)
            (cond
              [(empty? lst) cur]
              [else (how-many/a (rest lst) (add1 cur))])))
    (how-many/a loa 0)))