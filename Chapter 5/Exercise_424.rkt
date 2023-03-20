;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_424) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(list 11 9 2 18 12 14 4 1)

; {'(9 2 4 1) 11 '(18 12 14)}
; {{'(2 4 1) 9 '()} 11 {'(12 14) 18 '()}}
; {{{'(1) 2 '(4)} 9 '()} 11 {'(12 14) 18 '()}}
; {{{{'() 1 '()} 2 {'() 4 '()}} 9 '()} 11 {{'() 12 {'() 14 '()}} 18 '()}}
; '(1 2 4 9 11 12 14 18)