;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_111) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define ERROR-TEXT "checked-make-vec: Arguments should be positive numbers")

; Any Any -> Vec
; checked version of make-vec
(check-expect (checked-make-vec 1 5) (make-vec 1 5))
(check-error (checked-make-vec 1 0) ERROR-TEXT)
(check-error (checked-make-vec -5 -3) ERROR-TEXT)
(check-error (checked-make-vec #false 45) ERROR-TEXT)
(define (checked-make-vec x y)
  (if (and (number? x) (number? y) (positive? x) (positive? y))
      (make-vec x y)
      (error ERROR-TEXT)))