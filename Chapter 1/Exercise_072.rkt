;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_072) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area number])
; A Phone is a structure:
;   (make-phone Number String)
; interpratation (make-phone area number) represents phone
; area is the number of phone area
; number is the string containing of switch, "-" and number

(define-struct phone# [area switch num])
; A Phone# is a structure:
;   (make-phone@ Number Number Number)
; interpratation (make-phone# area switch num) represents phone
; area is the phone area code, which number contains three digits
; switch is the code of the phone switch of the neighborhood containing three digits
; num is the phone number with respect of neighborhood containing four digits