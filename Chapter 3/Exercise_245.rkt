;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_245) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; Number -> Number
; test functions
(define (f1 x) 5)
(define (f2 x) (- x 2))
(define (f3 x)(/ x 3))

; Func-of-Number Func-of-Number -> Boolean
(check-expect (function=at-1.2-3-and-5.775? f1 f2) #false)
(check-expect (function=at-1.2-3-and-5.775? f1 f3) #false)
(check-expect (function=at-1.2-3-and-5.775? f1 f3) #false)
(check-expect (function=at-1.2-3-and-5.775? f1 f1) #true)
(check-expect (function=at-1.2-3-and-5.775? f2 f2) #true)
(check-expect (function=at-1.2-3-and-5.775? f3 f3) #true)
(define (function=at-1.2-3-and-5.775? f1 f2)
  (and (= (f1 1.2) (f2 1.2))
       (= (f1 3) (f2 3))
       (= (f1 -5.775) (f2 -5.775))))