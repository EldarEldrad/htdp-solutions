;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_256) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X] [X -> Number] [NEList-of X] -> X 
; finds the (first) item in lx that maximizes f
; if (argmax f (list x-1 ... x-n)) == x-i, 
; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
; (define (argmax f lx) ...)

(argmax abs '(-4 -3 -2 -1 0 1 2 3))
; -> -4
(argmax abs '(-2 -1 0 1 2 3))
; -> 3
(argmax sqr '(-2 -1 0 1 2 3 4))
; -> 4

; [X] [X -> Number] [NEList-of X] -> X 
; finds the (first) item in lx that minimizes f
; if (argmin f (list x-1 ... x-n)) == x-i, 
; then (<= (f x-i) (f x-1)), (<= (f x-i) (f x-2)), ...
; (define (argmin f lx) ...)

(argmin abs '(-4 -3 -2 -1 0 1 2 3))
; -> 0
(argmin abs '(-2 -1 0 1 2 3))
; -> 0
(argmin sqr '(-2 -1 0 1 2 3 4))
; -> 0