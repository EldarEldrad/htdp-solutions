;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_387) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Pair is (list Symbol Number)

; [List-of Symbol] [List-of Number] -> [List-of Pair]
; consumes a list of symbols and a list of numbers
; and produces all possible ordered pairs of symbols and numbers
(check-expect (cross '() '()) '())
(check-expect (cross '(a b c) '()) '())
(check-expect (cross '() '(1 2)) '())
(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(check-expect (cross '(x) '(5)) '((x 5)))
(define (cross los lon)
  (local ((define (add-pairs-with-symbol s rst)
            (append (map (lambda (n) (list s n)) lon) rst)))
    (foldr add-pairs-with-symbol '() los)))