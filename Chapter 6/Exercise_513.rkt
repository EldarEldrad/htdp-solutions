;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_513) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – a Lambda
; – an App

(define-struct lmbda [para body])
; A Lambda is a structure:
;  (make-lmbda Symbol Lam)
; interpretation represents a λ expression

(define-struct app [fun arg])
; An App is a structure:
;   (make-app Lam Lam)
; interpretation represents an application of function to argument

(define ex1 (make-lmbda 'x 'x))
(define ex2 (make-lmbda 'x 'y))
(define ex3 (make-lmbda 'y (make-lmbda 'x 'y)))