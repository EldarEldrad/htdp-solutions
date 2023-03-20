;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_460) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPS 0.01)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square-1 x) (* 3 (sqr x)))

(define THRESHOLD 0.02)

; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds
; termination size reduces to threshold for each positive a and b
(check-within (integrate-dc constant 12 22) 200 EPS)
(check-within (integrate-dc linear 0 10) 100 EPS)
(check-within (integrate-dc square-1 0 10)
              (- (expt 10 3) (expt 0 3)) EPS)
(define (integrate-dc f a b)
  (local ((define size (- b a))
          (define mid (/ (+ b a) 2)))
    (cond
      [(<= size THRESHOLD) (* 1/2 size (+ (f a) (f b)))]
      [else (+ (integrate-dc f a mid)
               (integrate-dc f mid b))])))