;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_073) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Posn Number -> Posn
; produces Posn like p, but with n in the x field
(check-expect (posn-up-x (make-posn 3 4) 3) (make-posn 3 4))
(check-expect (posn-up-x (make-posn 3 4) 0) (make-posn 0 4))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))