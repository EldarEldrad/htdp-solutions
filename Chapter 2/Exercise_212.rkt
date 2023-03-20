;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_212) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words is one of:
; - '()
; - (cons Word List-of-words)
; interpretation a List of Words

(define word-example-1 '())
(define word-example-2 (list "I"))
(define word-example-3 (list "c" "a" "t"))
(define word-example-4 (list "r" "a" "t"))

(define low-example-1 '())
(define low-example-2 (list word-example-1))
(define low-example-3 (list word-example-3))
(define low-example-4 (list word-example-2 word-example-3 word-example-4))

; Word -> List-of-words
; finds all rearrangements of word
(check-expect (arrangements (list "d" "e")) (list (list "d" "e") (list "e" "d")))
(define (arrangements word)
  (list word))