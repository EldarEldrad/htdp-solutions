;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_504) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Digit is one of:
; - 0, 1, 2, 3, 4, 5, 6, 7, 8 or 9

; [List-of Digit] -> Number
; consumes a list of digits and produces the corresponding number
(check-expect (to10 '()) 0)
(check-expect (to10 '(5)) 5)
(check-expect (to10 '(1 0 2)) 102)
(define (to10 lod)
  (local ((define (to10/a lst cur)
            (cond
              [(empty? lst) cur]
              [else (to10/a (rest lst)
                            (+ (first lst) (* 10 cur)))])))
    (to10/a lod 0)))