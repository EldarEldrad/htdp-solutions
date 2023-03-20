;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_395) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; X [List-of X] N -> [List-of X]
; produces the first n items from l or all of l if it is too short
(check-expect (take '() 0) '())
(check-expect (take '(1 2 3) 0) '())
(check-expect (take '() 2) '())
(check-expect (take '(a b c) 2) '(a b))
(check-expect (take '("a" "b" #true 5) 5) '("a" "b" #true 5))
(check-expect (take '("a" "b" #true 5) 1) '("a"))
(define (take l n)
  (cond
    [(or (empty? l) (= n 0)) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

; X [List-of X] N -> [List-of X]
; result is l with the first n items removed or just ’() if l is too short
(check-expect (drop '() 0) '())
(check-expect (drop '(1 2 3) 0) '(1 2 3))
(check-expect (drop '() 2) '())
(check-expect (drop '(a b c) 2) '(c))
(check-expect (drop '("a" "b" #true 5) 5) '())
(check-expect (drop '("a" "b" #true 5) 1) '("b" #true 5))
(define (drop l n)
  (cond
    [(empty? l) '()]
    [(= n 0) l]
    [else (drop (rest l) (sub1 n))]))