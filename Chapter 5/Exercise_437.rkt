;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_437) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (special P solve combine-solutions)
  (cond
    [(empty? P) (solve P)]
    [else
     (combine-solutions
       P
       (special (rest P) solve combine-solutions))]))

(check-expect (compute-length '()) 0)
(check-expect (compute-length '(4 2)) 2)
(check-expect (compute-length '(1 2 3 "r" #true)) 5)
(define (compute-length P) (special P solve-1 combine-solutions-1))
(check-expect (negate '()) '())
(check-expect (negate '(1 2 3)) '(-1 -2 -3))
(check-expect (negate '(-10 0 4.5 10)) '(10 0 -4.5 -10))
(define (negate P) (special P solve-2 combine-solutions-2))
(check-expect (uppercase-list '()) '())
(check-expect (uppercase-list '("abc")) '("ABC"))
(check-expect (uppercase-list '("5" "f" "Cat" "USSR")) '("5" "F" "CAT" "USSR"))
(define (uppercase-list P) (special P solve-3 combine-solutions-3))

(define (solve-1 P) 0)
(define (solve-2 P) '())
(define (solve-3 P) '())
(define (combine-solutions-1 P rst)
  (+ 1 rst))
(define (combine-solutions-2 P rst)
  (cons (- (first P)) rst))
(define (combine-solutions-3 P rst)
  (cons (string-upcase (first P)) rst))