;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_241) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; An NEList-of-temperatures is [NEList-of Number]

; An NEList-of-booleans is [NEList-of Boolean]

; A [NEList-of X] is one of:
; - (cons X '())
; - (cons X [NEList-of X])
; interpretation non-empty lists of X