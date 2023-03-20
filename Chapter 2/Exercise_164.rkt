;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_164) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define CURRENT-RATE 0.88)

; List-of-numbers -> List-of-numbers
; computes the list of USD amounts to a list of EUR amounts
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (cons 28 '())) (cons (usd-to-eur 28) '()))
(check-expect (convert-euro (cons 4 (cons 2 '()))) (cons (usd-to-eur 4) (cons (usd-to-eur 2) '())))
(define (convert-euro amounts)
  (cond
    [(empty? amounts) '()]
    [else (cons (usd-to-eur (first amounts)) (convert-euro (rest amounts)))]))

; Number -> Number 
; converts USD to EUR
(check-expect (usd-to-eur 0) 0)
(check-expect (usd-to-eur 32) (* 32 CURRENT-RATE))
(check-expect (usd-to-eur 212) (* 212 CURRENT-RATE))
(define (usd-to-eur u)
  (* u CURRENT-RATE))

; List-of-numbers Number -> List-of-numbers
; computes the list of USD amounts to a list of EUR amounts according to given exchange rate
(check-expect (convert-euro* '() 0.5) '())
(check-expect (convert-euro* (cons 28 '()) 0.5) (cons (* 28 0.5) '()))
(check-expect (convert-euro* (cons 28 '()) 0.7) (cons (* 28 0.7) '()))
(check-expect (convert-euro* (cons 4 (cons 2 '())) 1.3) (cons (* 4 1.3) (cons (* 2 1.3) '())))
(check-expect (convert-euro* (cons 4 (cons 2 '())) 2) (cons (* 4 2) (cons (* 2 2) '())))
(define (convert-euro* amounts r)
  (cond
    [(empty? amounts) '()]
    [else (cons (* (first amounts) r) (convert-euro* (rest amounts) r))]))