;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_353) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct add [left right])
(define-struct mul [left right])

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; An BSL-expr is one of:
; - Number
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; BSL-var-expr -> Boolean
; determines whether a BSL-var-expr is also a BSL-expr
(check-expect (numeric? 2) #true)
(check-expect (numeric? 'x) #false)
(check-expect (numeric? (make-add 'x 3)) #false)
(check-expect (numeric? (make-add (make-mul 'x 'x) (make-mul 'y 'y))) #false)
(check-expect (numeric? (make-add 1 1)) #true)
(check-expect (numeric? (make-mul 3 10)) #true)
(check-expect (numeric? (make-add (make-mul 1 1) 10)) #true)
(define (numeric? ex)
  (match ex
    [(? number?) #true]
    [(? symbol?) #false]
    [(add x y)
     (and (numeric? x)
          (numeric? y))]
    [(mul x y)
     (and (numeric? x)
          (numeric? y))]))