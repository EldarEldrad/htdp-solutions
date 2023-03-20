;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_211) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.dat")
 
; A Dictionary is a List-of-strings.
(define DICTIONARY (read-lines LOCATION))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list (first DICTIONARY))) (list (first DICTIONARY)))
(check-expect (in-dictionary DICTIONARY) DICTIONARY)
(check-expect (in-dictionary (list "word" "nonexistentword" "sentence")) (list "word" "sentence"))
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(member? (first los) DICTIONARY)
     (cons (first los) (in-dictionary (rest los)))]
    [else (in-dictionary (rest los))]))