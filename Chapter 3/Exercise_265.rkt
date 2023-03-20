;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_265) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
((local ((define (f x) (+ (* 4 (sqr x)) 3))) f)
 1)
; -> (define (f_0 x) (+ (* 4 (sqr x)) 3))
;    (f_0 1)
; -> (define (f_0 x) (+ (* 4 (sqr x)) 3))
;    (+ (* 4 (sqr 1)) 3)
; -> (define (f_0 x) (+ (* 4 (sqr x)) 3))
;    (+ (* 4 1) 3)
; -> (define (f_0 x) (+ (* 4 (sqr x)) 3))
;    (+ 4 3)
; -> (define (f_0 x) (+ (* 4 (sqr x)) 3))
;    7