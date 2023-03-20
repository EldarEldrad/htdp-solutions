;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_505) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N [>=1] -> Boolean
; determines whether n is a prime number
(check-expect (is-prime? 1) #true)
(check-expect (is-prime? 2) #true)
(check-expect (is-prime? 3) #true)
(check-expect (is-prime? 4) #false)
(check-expect (is-prime? 100) #false)
(check-expect (is-prime? 101) #true)
(define (is-prime? n)
  (local ((define (is-prime?/a k)
            (cond
              [(<= k 1) #true]
              [(= 0 (modulo n k)) #false]
              [else (is-prime?/a (sub1 k))])))
    (is-prime?/a (- n 1))))
