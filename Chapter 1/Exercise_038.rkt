;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_38) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String -> String
; produces a string like Str with the last character removed
; given: "hello", expected: "hell"
; given: "_123", expected: "_12"
; given: ",", expected: ""
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(string-remove-last "hello") ;"hell"
(string-remove-last "_123") ;"_12"
(string-remove-last ",") ;""