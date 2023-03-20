;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_240) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; An LStr is [Layer-of String]
	
; An LNum is [Layer-of Number]

; A [Layer-of X] is one of:
; - X
; - (make-layer X)

(define-struct layer [stuff])

(define lstr1 "abc")
(define lstr2 (make-layer "abc"))
(define lnum1 6)
(define lnum2 (make-layer 6))