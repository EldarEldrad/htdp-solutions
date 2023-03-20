;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise_172) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings
 
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define ln0 '())
(define ln1 (cons line0 (cons line1 '())))
 
; LN -> String
; converts a list of lines into a string
; The strings should be separated by blank spaces (" ")
; The lines should be separated with a newline ("\n")
(check-expect (collapse ln0) "")
(check-expect (collapse ln1) "hello world\n")
(define (collapse ln)
  (cond
    [(empty? ln) ""]
    [(empty? (rest ln)) (line-collapse (first ln))]
    [else (string-append (line-collapse (first ln))
                         "\n"
                         (collapse (rest ln)))]))

; List-of-string -> String
; converts a list of string into a string
; The string should be separated by blank spaces (" ")
(check-expect (line-collapse line0) "hello world")
(check-expect (line-collapse line1) "")
(define (line-collapse los)
  (cond
   [(empty? los) ""]
   [(empty? (rest los)) (first los)]
   [else (string-append (first los)
                        " "
                        (line-collapse (rest los)))]))

(write-file "ttt.dat"
            (collapse (read-words/line "ttt.txt")))