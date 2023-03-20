;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_58) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Price falls into one of three intervals: 
; — 0 through LOW-PRICE exclusively
; — LOW-PRICE through HIGH-PRICE exclusively
; — HIGH-PRICE and above.
; interpretation the price of an item

(define LOW-PRICE 1000)
(define HIGH-PRICE 10000)

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax (/ LOW-PRICE 2)) 0)
(check-expect (sales-tax LOW-PRICE) (* 0.05 LOW-PRICE))
(check-expect (sales-tax (/ (+ LOW-PRICE HIGH-PRICE) 2)) (* 0.05 (/ (+ LOW-PRICE HIGH-PRICE) 2)))
(check-expect (sales-tax HIGH-PRICE) (* 0.08 HIGH-PRICE))
(check-expect (sales-tax (* 2 HIGH-PRICE)) (* 0.08 (* 2 HIGH-PRICE)))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p LOW-PRICE)) 0]
    [(and (<= LOW-PRICE p) (< p HIGH-PRICE)) (* 0.05 p)]
    [(>= p HIGH-PRICE) (* 0.08 p)]))