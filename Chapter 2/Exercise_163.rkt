;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_163) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-numbers -> List-of-numbers
; computes the list of measurements in Fahrenheit to a list of Celsius measurements
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 28 '())) (cons (f2c 28) '()))
(check-expect (convertFC (cons 4 (cons 2 '()))) (cons (f2c 4) (cons (f2c 2) '())))
(define (convertFC fs)
  (cond
    [(empty? fs) '()]
    [else (cons (f2c (first fs)) (convertFC (rest fs)))]))

; Number -> Number 
; converts Fahrenheit temperatures to Celsius
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)
(define (f2c f)
  (* 5/9 (- f 32)))