;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_457) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number Number -> Number
; computes how many months it takes to double a given amount of money
; when a savings account pays interest at a fixed rate on a monthly basis
(check-expect (double-amount 560 0.1) 694)
(check-expect (double-amount 5 0.5) 139)
(check-expect (double-amount 100 0.5) 139)
(check-expect (double-amount 100 1) 70)
(check-expect (double-amount 1000 1) 70)
(check-expect (double-amount 1000 5) 15)
(check-expect (double-amount 500 10) 8)
(check-expect (double-amount 500 100) 1)
(check-expect (double-amount 10000 45) 2)
(check-expect (double-amount 10000 40) 3)
(define (double-amount amount rate)
  (local ((define (double-amount/internal current)
            (cond
              [(<= (* 2 amount) current) 0]
              [else (+ 1
                       (double-amount/internal (* current
                                                  (+ 1 (* 0.01 rate)))))])))
    (double-amount/internal amount)))