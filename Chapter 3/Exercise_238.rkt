;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise_238) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f () #f)))
; Nelon -> Number
; determines the smallest
; number on l
(check-expect (inf (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              1)
(check-expect (inf (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              1)
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (min (first l) (inf (rest l)))]))

	
; Nelon -> Number
; determines the largest
; number on l
(check-expect (sup (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              25)
(check-expect (sup (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              25)
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (max (first l) (sup (rest l)))]))

; Nelon -> Number
; produces one number from list according to giving operation
(define (select op l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (op (first l) (select op (rest l)))]))

; Nelon -> Number
; determines the smallest
; number on l
(check-expect (inf-1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              1)
(check-expect (inf-1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              1)
(define (inf-1 l)
  (select min l))

	
; Nelon -> Number
; determines the largest
; number on l
(check-expect (sup-1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              25)
(check-expect (sup-1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              25)
(define (sup-1 l)
  (select max l))