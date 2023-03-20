;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_309) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [List-of N] -> [List-of [List-of String]]
; determines the number of Strings per item in a list of list of strings
(check-expect (words-on-line '()) '())
(check-expect (words-on-line '(())) '(0))
(check-expect (words-on-line '(() () ())) '(0 0 0))
(check-expect (words-on-line '(("a" "bb" "ccc") ("dddd") ("ee" "ff" "" "34"))) '(3 1 4))
(define (words-on-line lls)
  (match lls
    ['() '()]
    [(cons lst rst)
     (cons (length lst)
           (words-on-line (rest lls)))]))