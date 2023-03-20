;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_34) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String -> 1String
; extracts the first character from non-empty str
; given: "hello", expected: "h"
; given: "_123", expected: "_"
; given: ",", expected: ","
(define (string-first str)
  (substring str 0 1))

(string-first "hello") ;"h"
(string-first "_123") ;"_"
(string-first ",") ;","