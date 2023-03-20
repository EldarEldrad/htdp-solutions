;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_430) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
; produces a sorted version of alon, sort by given operation
; assume the numbers are all distinct
(check-expect (quick-sort '(11 9 2 18 12 14 4 1) <) '(1 2 4 9 11 12 14 18))
(check-expect (quick-sort '(11 9 2 18 4 12 14 4 12 1) <) '(1 2 4 4 9 11 12 12 14 18))
(check-expect (quick-sort '(11) <) '(11))
(check-expect (quick-sort '(11 9 2 18 12 14 4 1) >) '(18 14 12 11 9 4 2 1))
(check-expect (quick-sort '(11 9 2 18 4 12 14 4 12 1) >) '(18 14 12 12 11 9 4 4 2 1))
(check-expect (quick-sort '(11) >) '(11))
(define (quick-sort alon cmp)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort (filter (lambda (x) (cmp x pivot)) (rest alon)) cmp)
                    (list pivot)
                    (quick-sort (filter (lambda (x) (not (cmp x pivot))) (rest alon)) cmp)))]))