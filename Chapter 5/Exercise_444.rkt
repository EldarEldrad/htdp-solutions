;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_444) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number Number -> Number
; determines greatest common divisor of two numbers structurally
(check-expect (gcd-structural 6 25) 1)
(check-expect (gcd-structural 18 24) 6)
(check-expect (gcd-structural 101135853 45014640) 177)
(define (gcd-structural S L)
  (largest-common (divisors S S) (divisors S L)))
 
; N[>= 1] N[>= 1] -> [List-of N]
; computes the divisors of l smaller or equal to k to restrict upper border of evaluation
(check-expect (divisors 6 6) '(6 3 2 1))
(check-expect (divisors 2 6) '(2 1))
(check-expect (divisors 6 25) '(5 1))
(check-expect (divisors 6 24) '(6 4 3 2 1))
(check-expect (divisors 5 24) '(4 3 2 1))
(define (divisors k l)
  (cond
    [(or (<= l 1) (<= k 1)) '(1)]
    [(= (remainder l k) 0)
     (cons k (divisors (- k 1) l))]
    [else (divisors (- k 1) l)]))
 
; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l
(check-error (largest-common '() '()))
(check-error (largest-common '(5 3 1) '()))
(check-error (largest-common '() '(4 2 1)))
(check-expect (largest-common '(5 3 1) '(4 2 1)) 1)
(check-expect (largest-common '(6 3 1) '(12 6 4 2 1)) 6)
(define (largest-common k l)
  (cond
    [(or (empty? k) (empty? l)) (error "empty list")]
    [(= (first k) (first l))
     (first k)]
    [(> (first k) (first l))
     (largest-common (rest k) l)]
    [else (largest-common k (rest l))]))