;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_146) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

; NEList-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average ne-l)
  (/ (sum ne-l) (how-many ne-l)))
 
; NEList-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))
 
; NEList-of-temperatures -> Number 
; counts the temperatures on the given list
(check-expect (how-many (cons 0 '())) 1)
(check-expect (how-many (cons 5 '())) 1)
(check-expect (how-many (cons 2 (cons 1 '()))) 2)
(check-expect (how-many (cons 3 (cons 2 (cons 1 '())))) 3)
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ 1 (how-many (rest ne-l)))]))