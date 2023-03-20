;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_308) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area switch four])

; Phone -> Phone
; substitutes the area code 713 with 281 in a list of phone records
(check-expect (replace (make-phone 435 231 3321)) (make-phone 435 231 3321))
(check-expect (replace (make-phone 713 231 3321)) (make-phone 281 231 3321))
(define (replace ph)
  (match ph
    [(phone 713 x y) (make-phone 281 x y)]
    [x x]))