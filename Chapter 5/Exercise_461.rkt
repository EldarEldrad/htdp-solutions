;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_461) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPS 0.01)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square-1 x) (* 3 (sqr x)))

(define THRESHOLD 0.001)

; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds
; termination size reduces to threshold for each positive a and b
(check-within (integrate-adaptive constant 12 22) 200 EPS)
(check-within (integrate-adaptive linear 0 10) 100 EPS)
(check-within (integrate-adaptive square-1 0 10)
              (- (expt 10 3) (expt 0 3)) EPS)
(define (integrate-adaptive f a b)
  (local ((define size (- b a))
          (define mid (/ (+ b a) 2))
          (define area-full (* 1/2 size (+ (f a) (f b))))
          (define area-left (* 1/4 size (+ (f a) (f mid))))
          (define area-right (* 1/4 size (+ (f mid) (f b)))))
    (cond
      [(<= (abs (- area-full area-left area-right)) (* THRESHOLD size)) area-full]
      [else (+ (integrate-adaptive f a mid)
               (integrate-adaptive f mid b))])))