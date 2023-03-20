;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_120) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; (x)
; -> (variable)
; -> not def-expr

; (+ 1 (not x))
; -> (primitive value (primitive variable))
; -> (primitive expr (primitive expr))
; -> (primitive expr expr)
; -> expr
; -> def-expr

; (+ 1 2 3)
; -> (primitive value value value)
; -> (primitive expr expr expr)
; -> expr
; -> def-expr