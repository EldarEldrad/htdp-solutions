;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_244) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
(define (f1 x) (x 10))
(define (f2 x) (x f2))
(define (f3 x y) (x 'a y 'b))
; they are all legal because functions are values and arguments of the given functions can be functions as well