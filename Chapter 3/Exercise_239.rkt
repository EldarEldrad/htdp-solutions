;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_239) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; A [List X Y] is a list: 
;   (cons X (cons Y '()))

; [List Number Number] is pair of Numbers
(define list1 (list 4 5))

; [List Number 1String] is pair of Number and 1String
(define list2 (list 45 "r"))

; [List String Boolean] is pair of String and Boolean
(define list3 (list "Welcome" #true))
