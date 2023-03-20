;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_35) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String -> 1String
; extracts the last character from non-empty str
; given: "hello", expected: "o"
; given: "_123", expected: "3"
; given: ",", expected: ","
(define (string-last str)
  (substring str (- (string-length str) 1)))

(string-last "hello") ;"o"
(string-last "_123") ;"3"
(string-last ",") ;","