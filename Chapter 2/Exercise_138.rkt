;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_138) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(define loa1 '())
(define loa2 (cons 5 '()))
(define loa3 (cons 12 (cons 5 '())))

; List-of-amounts -> Number
; computes the sum of the amounts
(check-expect (sum loa1) 0)
(check-expect (sum loa2) 5)
(check-expect (sum loa3) 17)
(define (sum loa)
  (cond
    [(empty? loa) 0]
    [(cons? loa) (+ (first loa)
                    (sum (rest loa)))]))