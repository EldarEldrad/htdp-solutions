;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_459) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define EPS 0.01)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square-1 x) (* 3 (sqr x)))

(define R 170)

; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
(check-within (integrate-rectangles constant 12 22) 200 EPS)
(check-within (integrate-rectangles linear 0 10) 100 EPS)
(check-within (integrate-rectangles square-1 0 10)
              (- (expt 10 3) (expt 0 3)) EPS)
(define (integrate-rectangles f a b)
  (local ((define w (/ (- b a) R))
          (define (integrate-rectangles/internal current)
            (cond
              [(>= current b) 0]
              [else (+ (* w (f (+ current (/ w 2))))
                       (integrate-rectangles/internal (+ current w)))])))
    (integrate-rectangles/internal a)))