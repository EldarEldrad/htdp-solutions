;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_154) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> String
; string of all colors of dolls, separated by a coma and a space
(check-expect (colors "red") "red")
(check-expect
  (colors
   (make-layer "yellow" "red"))
  "yellow, red")
(check-expect
  (colors
   (make-layer "yellow" (make-layer "green" "red")))
  "yellow, green, red")
(define (colors rd)
  (cond
    [(string? rd) rd]
    [else (string-append (layer-color rd) ", " (colors (layer-doll rd)))]))