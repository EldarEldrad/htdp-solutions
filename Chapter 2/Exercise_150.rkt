;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_150) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 0) pi 0.001)
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 1000) (+ 1000 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(= n 0) pi]
    [else (add1 (add-to-pi (sub1 n)))]))