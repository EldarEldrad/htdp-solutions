;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_455) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPS 0.001)

; [Number -> Number] Number -> Number
; maps function f and a number r1 to the slope of f at r1
(check-expect (slope (lambda (x) 5) 3) 0)
(check-expect (slope (lambda (x) x) 3) 1)
(check-expect (slope (lambda (x) (* 3 x)) 3) 3)
(check-expect (slope (lambda (x) (* x x)) 0) 0)
(check-expect (slope (lambda (x) (* x x)) 1) 2)
(check-expect (slope (lambda (x) (* x x)) 2) 4)
(check-expect (slope (lambda (x) (* x x)) 5) 10)
(check-within (slope (lambda (x) (sin x)) pi) #i-1.0 EPS)
(define (slope f r1)
  (/ (- (f (+ r1 EPS))
        (f (- r1 EPS)))
     (* 2 EPS)))