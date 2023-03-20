;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_393) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son.R Son.R -> Son.R
; unions two sets
(check-expect (union '() '()) '())
(check-expect (union '(1 2 3) '()) '(1 2 3))
(check-expect (union '() '(4 5)) '(4 5))
(check-expect (union '(1 2 3) '(4 5)) '(1 2 3 4 5))
(check-expect (union '(1 2 3) '(2 3 4)) '(1 2 3 4))
(check-expect (union '(1 2 3 5) '(2 3 4)) '(1 5 2 3 4))
(define (union s1 s2)
  (cond
    [(empty? s1) s2]
    [(empty? s2) s1]
    [(member? (first s1) s2) (union (rest s1) s2)]
    [else (cons (first s1) (union (rest s1) s2))]))

; Son.R Son.R -> Son.R
; intersexts two sets
(check-expect (intersect '() '()) '())
(check-expect (intersect '(1 2 3) '()) '())
(check-expect (intersect '() '(4 5)) '())
(check-expect (intersect '(1 2 3) '(4 5)) '())
(check-expect (intersect '(1 2 3) '(2 3 4)) '(2 3))
(check-expect (intersect '(1 2 3 5) '(2 3 4)) '(2 3))
(define (intersect s1 s2)
  (cond
    [(or (empty? s1) (empty? s2)) '()]
    [(member? (first s1) s2) (cons (first s1) (intersect (rest s1) s2))]
    [else (intersect (rest s1) s2)]))