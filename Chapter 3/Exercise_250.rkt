;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_250) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (tabulate sin n))
	
; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
 (tabulate sqrt n))

; [Number -> Number] Number -> [List-of Number]
; tabilates given function f between n and 0 (incl.) in a list
(define (tabulate f n)
  (cond
    [(= n 0) (list (f 0))]
    [else (cons (f n)
                (tabulate f (sub1 n)))]))

; Number -> [List-of Number]
; tabulates sqr between n 
; and 0 (incl.) in a list
(define (tab-sqr n)
 (tabulate sqr n))

; Number -> [List-of Number]
; tabulates tan between n 
; and 0 (incl.) in a list
(define (tab-tan n)
 (tabulate tan n))