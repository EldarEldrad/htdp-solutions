;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_37) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String -> String
; produces a string like Str with the first character removed
; given: "hello", expected: "ello"
; given: "_123", expected: "123"
; given: ",", expected: ""
(define (string-rest str)
  (substring str 1))

(string-rest "hello") ;"ello"
(string-rest "_123") ;"123"
(string-rest ",") ;""