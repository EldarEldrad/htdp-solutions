;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_255) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; map-n, which consumes a list of numbers and a function from numbers to numbers
; to produce a list of numbers.
; [List-of Number] [Number -> Number] -> [List-of Number]

; map-s, which consumes a list of strings and a function from strings to strings
; and produces a list of strings.
; [List-of String] [String -> String] -> [List-of String]

; [X] [List-of X] [X -> X] -> [List-of X]

; [X] [List-of X] [X -> X] -> [List-of X]
(define (map1 k g)
  (cond
    [(empty? k) '()]
    [else
     (cons
       (g (first k))
       (map1 (rest k) g))]))