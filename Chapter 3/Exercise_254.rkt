;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_254) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; sort-n, which consumes a list of numbers and a function that consumes two numbers (from the list)
; and produces a Boolean
; sort-n produces a sorted list of numbers.
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]

; sort-s, which consumes a list of strings and a function that consumes two strings (from the list)
; and produces a Boolean
; sort-s produces a sorted list of strings.
; [List-of String] [String String -> Boolean] -> [List-of String]

; [X] [List-of X] [X X -> Boolean] -> [List-of X]

; ->
; [List-of IR] [IR IR -> Boolean] -> [List-of IR]