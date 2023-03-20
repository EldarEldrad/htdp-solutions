;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_299) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A NumberSet is a function:
;   [Number -> Boolean]
; interpretation
; represent different sets of numbers

(define odd-numbers-set odd?)
(define even-numbers-set even?)
(define divide-10-numbers-set (lambda (x) (zero? (modulo x 10))))

; Number NumberSet -> NumberSet
; adds an element to a set
(check-expect [(add-element 5 even?) 4] #true)
(check-expect [(add-element 5 even?) 5] #true)
(check-expect [(add-element 5 even?) 7] #false)
(define (add-element n s)
  (lambda (x) (or (equal? x n)
                  (s x))))

; NumberSet NumberSet -> NumberSet
; combines the elements of two sets
(check-expect [(union divide-10-numbers-set odd?) 8] #false)
(check-expect [(union divide-10-numbers-set odd?) 9] #true)
(check-expect [(union divide-10-numbers-set odd?) 10] #true)
(define (union s1 s2)
  (lambda (x) (or (s1 x)
                  (s2 x))))

; NumberSet NumberSet -> NumberSet
; collects all elements common to two sets
(check-expect [(intersect divide-10-numbers-set even?) 8] #false)
(check-expect [(intersect divide-10-numbers-set even?) 9] #false)
(check-expect [(intersect divide-10-numbers-set even?) 10] #true)
(define (intersect s1 s2)
  (lambda (x) (and (s1 x)
                   (s2 x))))