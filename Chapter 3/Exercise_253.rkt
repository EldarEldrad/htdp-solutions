;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_253) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [Number -> Boolean]
(even? 5)

; [Boolean String -> Boolean]
(equal? #true "abc")

; [Number Number Number -> Number]
(+ 3 4 5)

; [Number -> [List-of Number]]
(list 4)

; [[List-of Number] -> Boolean]
(list? (list 1 2 3 4))