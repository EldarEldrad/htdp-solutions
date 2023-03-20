;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_285) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
  (map (lambda (us) (/ us rate)) lous))

; [List-of Number] -> [List-of Number]
; converts a list of Fahrenheit measurements to a list of Celsius measurements
(check-expect (convertFC '()) '())
(check-expect (convertFC '(32)) '(0))
(check-expect (convertFC '(50 68)) '(10 20))
(check-expect (convertFC '(104 -4 32 14 23))
              '(40 -20 0 -10 -5))
(define (convertFC fs)
  (map (lambda (f) (* (- f 32) (/ 5 9))) fs))

; [List-of Posn] -> [List-of [List-of Number]]
; translates a list of Posns into a list of lists of pairs of numbers
(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 1 2))) '((1 2)))
(check-expect (translate (list (make-posn 1 2) (make-posn 3 4))) '((1 2) (3 4)))
(check-expect (translate
               (list (make-posn -5 0) (make-posn 34 10) (make-posn 0 0) (make-posn 6.6 (- (/ 7 6)))))
              `((-5 0) (34 10) (0 0) (6.6 ,(- (/ 7 6)))))
(define (translate ps)
  (map (lambda (p) (list (posn-x p) (posn-y p))) ps))