;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_502) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [NEList-of 1String] -> [NEList-of 1String]
; creates a palindrome from s0
(check-expect
  (mirror (explode "abc")) (explode "abcba"))
(check-expect
  (mirror '("c")) '("c"))
(define (mirror s0)
  (local ((define (mirror/a lst cur)
            (cond
              [(empty? (rest lst)) cur]
              [else (mirror/a (rest lst) (cons (first lst) cur))])))
    (append s0 (mirror/a s0 '()))))