;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_454) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Matrix is [List-of [List-of Number]]

; Number [List-of Number] -> Matrix
; consumes a number n and a list of n2 numbers.
; It produces an N x N matrix
(check-expect
  (create-matrix 2 (list 1 2 3 4))
  (list (list 1 2)
        (list 3 4)))
(check-expect
  (create-matrix 0 '())
  '())
(check-expect
  (create-matrix 1 (list 5))
  (list (list 5)))
(check-expect
  (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
  (list (list 1 2 3)
        (list 4 5 6)
        (list 7 8 9)))
(define (create-matrix n lon)
  (cond
    [(empty? lon) '()]
    [else (cons (first-row n lon)
                (create-matrix n (remove-first-row n lon)))]))

; Number [List-of Number] -> [List-of Number]
; creates row for matrix with N length from given list of numbers
(define (first-row n lon)
  (cond
    [(= n 0) '()]
    [else (cons (first lon)
                (first-row (- n 1) (rest lon)))]))

; Number [List-of Number] -> [List-of Number]
; removes first N elements from given list of numbers
(define (remove-first-row n lon)
  (cond
    [(or (= n 0) (empty? lon)) lon]
    [else
     (remove-first-row (- n 1) (rest lon))]))