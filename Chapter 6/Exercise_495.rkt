;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_495) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
; sums all numbers in given list
(check-expect (sum.v1 '()) 0)
(check-expect (sum.v1 '(2)) 2)
(check-expect (sum.v1 '(5 76 0 -1)) 80)
(check-expect (sum.v1 '(1 2 3 4 5 6 7 8 9 10)) 55)
(define (sum.v1 alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum.v1 (rest alon)))]))

; [List-of Number] -> Number
; sums all numbers in given list
(check-expect (sum.v2 '()) 0)
(check-expect (sum.v2 '(2)) 2)
(check-expect (sum.v2 '(5 76 0 -1)) 80)
(check-expect (sum.v2 '(1 2 3 4 5 6 7 8 9 10)) 55)
(define (sum.v2 alon0)
  (local (; [List-of Number] Number -> Number
          ; computes the sum of the numbers on alon
          ; accumulator a is the sum of the numbers 
          ; that alon lacks from alon0
          (define (sum/a alon a)
            (cond
              [(empty? alon) a]
              [else (sum/a (rest alon)
                           (+ (first alon) a))])))
    (sum/a alon0 0)))

; (sum/a '(10 4) 0)
; -> (cond
;      [(empty? '(10 4)) 0]
;      [else (sum/a (rest '(10 4))
;                   (+ (first '(10 4)) 0))])
; -> (cond
;      [#false 0]
;      [else (sum/a (rest '(10 4))
;                   (+ (first '(10 4)) 0))])
; -> (cond
;      [else (sum/a (rest '(10 4))
;                   (+ (first '(10 4)) 0))])
; -> (sum/a (rest '(10 4))
;           (+ (first '(10 4)) 0))
; -> (sum/a '(4)
;           (+ (first '(10 4)) 0))
; -> (sum/a '(4)
;           (+ 10 0))
; -> (sum/a '(4) 10)
; -> (cond
;      [(empty? '(4)) 10]
;      [else (sum/a (rest '(4))
;                   (+ (first '(4)) 10))])
; -> (cond
;      [#false 10]
;      [else (sum/a (rest '(4))
;                   (+ (first '(4)) 10))])
; -> (cond
;      [else (sum/a (rest '(4))
;                   (+ (first '(4)) 10))])
; -> (sum/a (rest '(4))
;           (+ (first '(4)) 10))
; -> (sum/a '()
;           (+ (first '(4)) 10))
; -> (sum/a '()
;           (+ 4 10))
; -> (sum/a '() 14)
; -> (cond
;      [(empty? '()) 14]
;      [else (sum/a (rest '())
;                   (+ (first '()) 14))])
; -> (cond
;      [#true 14]
;      [else (sum/a (rest '())
;                   (+ (first '()) 14))])
; -> 14