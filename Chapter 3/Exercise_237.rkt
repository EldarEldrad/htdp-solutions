;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_237) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; Number Number -> Boolean
; is the area of a square with side x larger than c
(check-expect (squared>? 3 10) #false)
(check-expect (squared>? 4 10) #true)
(check-expect (squared>? 5 10) #true)
(define (squared>? x c)
  (> (* x x) c))

; (squared>? 3 10)
; -> (> (* 3 3) 10)
; -> (> 9 10)
; -> #false