;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_105) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define WIDTH 100)
(define HEIGHT 100)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define POINT (circle 2 "solid" "black"))

; Coordinate -> Image
; renders the sketch of given Coordinate on empty canvas
(check-expect (sketch 5) (place-image POINT 5 0 BACKGROUND))
(check-expect (sketch 50) (place-image POINT 50 0 BACKGROUND))
(check-expect (sketch -5) (place-image POINT 0 5 BACKGROUND))
(check-expect (sketch -50) (place-image POINT 0 50 BACKGROUND))
(check-expect (sketch (make-posn 5 5)) (place-image POINT 5 5 BACKGROUND))
(check-expect (sketch (make-posn 30 75)) (place-image POINT 30 75 BACKGROUND))
(define (sketch c)
  (cond
    [(posn? c) (place-image POINT (posn-x c) (posn-y c) BACKGROUND)]
    [(> c 0) (place-image POINT c 0 BACKGROUND)]
    [else (place-image POINT 0 (abs c) BACKGROUND)]))

(sketch 5)
(sketch 50)
(sketch -5)
(sketch -50)
(sketch (make-posn 5 5))
(sketch (make-posn 30 75))