;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_305) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define rate 1.06)

; [List-of Number] -> [List-of Number]
; converts a list of US$ amounts into a list of € amounts
; based on an exchange rate of US$1.06 per € (on April 13, 2017)
(check-expect (convert-euro '()) '())
(check-expect (convert-euro '(5)) (list (/ 5 rate)))
(check-expect (convert-euro '(54 32)) (list (/ 54 rate) (/ 32 rate)))
(check-expect (convert-euro '(1 2 3 4 5 6))
              (list (/ 1 rate) (/ 2 rate) (/ 3 rate) (/ 4 rate) (/ 5 rate) (/ 6 rate)))
(define (convert-euro lous)
  (for/list ([l lous])
    (/ l rate)))