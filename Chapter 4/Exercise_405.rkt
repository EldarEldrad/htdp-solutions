;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_405) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions

(define labels '("Name" "Present"))

; Row [List-of Label] -> Row
; retains those cells whose corresponding element
; in names is also in labels
(check-expect (row-filter '() '()) '())
(check-expect (row-filter '("Alice" 35 #true) '("Name" "Age" "Present")) '("Alice" #true))
(define (row-filter row names)
  (cond
    [(empty? row) '()]
    [(member? (first names) labels)
     (cons (first row)
           (row-filter (rest row) (rest names)))]
    [else (row-filter (rest row) (rest names))]))