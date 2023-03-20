;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_364) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An Xexpr.v2 is (cons Symbol Body)

; An Body is one of:
; - '()
; - (cons Xexpr.v2 Body)
; - (cons [List-of Attribute] Body)

; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; <transition from="seen-e" to="seen-f" />
(define xexpr1 '(transition ((from "seen-e") (to "seen-f"))))
; cannot be represented by Xexpr.v0 or Xexpr.v1

; <ul><li><word /><word /></li><li><word /></li></ul>
(define xexpr2 '(ul (li (word) (word)) (li (word))))
; canot be represented by Xexpr.v0, but can be represented with Xexpr.v1