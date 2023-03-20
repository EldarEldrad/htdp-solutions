;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_155) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> String
; string of all colors of dolls, separated by a coma and a space
(check-expect (inner "red") "red")
(check-expect
  (inner
   (make-layer "yellow" "red"))
  "red")
(check-expect
  (inner
   (make-layer "yellow" (make-layer "green" "red")))
  "red")
(define (inner rd)
  (cond
    [(string? rd) rd]
    [else (inner (layer-doll rd))]))

(inner (make-layer "green" "red"))
; -> (cond
;      [(string? (make-layer "green" "red")) (make-layer "green" "red")]
;      [else (inner (layer-doll (make-layer "green" "red")))])
; -> (cond
;      [#false (make-layer "green" "red")]
;      [else (inner (layer-doll (make-layer "green" "red")))])
; -> (cond
;      [else (inner (layer-doll (make-layer "green" "red")))])
; -> (inner (layer-doll (make-layer "green" "red")))
; -> (inner "red")
; -> (cond
;      [(string? "red") "red"]
;      [else (inner (layer-doll "red"))])
; -> (cond
;      [(#true "red"]
;      [else (inner (layer-doll "red"))])
; -> "red"