;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_210) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list '())) (list ""))
(check-expect (words->strings (list (list "a"))) (list "a"))
(check-expect (words->strings (list (list "a" "n"))) (list "an"))
(check-expect (words->strings (list (list "a" "n") '())) (list "an" ""))
(check-expect (words->strings (list (list "a" "n") (list "a" "p" "p" "l" "e"))) (list "an" "apple"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low))
                (words->strings (rest low)))]))
 
; Word -> String
; converts w to a string
(check-expect (word->string '()) "")
(check-expect (word->string (list "a")) "a")
(check-expect (word->string (list "w" "o" "r" "d")) "word")
(check-expect (word->string (list "B" "i" "g")) "Big")
(define (word->string w) (implode w))