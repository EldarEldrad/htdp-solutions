;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_453) (read-case-sensitive #t) (teachpacks ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t quasiquote repeating-decimal #f #t none #f ((lib "abstraction.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Line is a [List-of 1String].

; A Token is one of:
; - 1String
; - String,that consist of lower-case letters

; Line -> [List-of Token]
; turns the line into a list of tokens by dropping all white-space 1Strings
(check-expect (tokenize
                (list "a" "b" "c" " "
                      "d" "e" " "
                      "f" "g" " " "1" " " "T"))
              (list "abc" "de" "fg" "1" "t"))
(check-expect (tokenize '()) '())
(check-expect (tokenize (list " ")) '(""))
(check-expect (tokenize (list " " " ")) '("" ""))
(check-expect (tokenize (explode "What is happening, people?"))
              (list "what" "is" "happening," "people?"))
(define (tokenize aline)
  (cond
    [(empty? aline) '()]
    [else
     (cons (first-token aline)
           (tokenize (remove-first-token aline)))]))
 
; Line -> Token
; retrieves the first token of given line
(define (first-token aline)
  (cond
    [(empty? aline) ""]
    [(string-whitespace? (first aline)) ""]
    [else (string-append (string-downcase (first aline)) (first-token (rest aline)))]))
 
; Line -> Line
; drops the first token of the given line
(define (remove-first-token aline)
  (cond
    [(empty? aline) '()]
    [(string-whitespace? (first aline))
     (rest aline)]
    [else (remove-first-token (rest aline))]))