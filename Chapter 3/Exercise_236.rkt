;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_236) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; Number Lon -> Lon
; adds n to each item on l
(check-expect (add-n 1 '()) '())
(check-expect (add-n 5 '(4)) '(9))
(check-expect (add-n 5 '(0 1 2 3 4 5)) '(5 6 7 8 9 10))
(check-expect (add-n 1 '(4)) '(5))
(check-expect (add-n 1 '(0 1 2 3 4 5)) '(1 2 3 4 5 6))
(check-expect (add-n 0 '(4)) '(4))
(check-expect (add-n 0 '(0 1 2 3 4 5)) '(0 1 2 3 4 5))
(define (add-n n l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) n)
       (add-n n (rest l)))]))

; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '()) '())
(check-expect (add1* '(4)) '(5))
(check-expect (add1* '(0 1 2 3 4 5)) '(1 2 3 4 5 6))
(define (add1* l)
  (add-n 1 l))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '()) '())
(check-expect (plus5 '(4)) '(9))
(check-expect (plus5 '(0 1 2 3 4 5)) '(5 6 7 8 9 10))
(define (plus5 l)
  (add-n 5 l))