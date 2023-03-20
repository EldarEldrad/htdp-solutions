;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_195) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "words.dat")
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Letter Dictionary -> Number
; counts how many words in the given Dictionary start with the given Letter
(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "apple" "basket" "Bob" "tree")) 1)
(check-expect (starts-with# "b" (list "apple" "basket" "Bob" "tree")) 2)
(check-expect (starts-with# "c" (list "apple" "basket" "Bob" "tree")) 0)
(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [else (+ (starts-with# l (rest d))
             (if (string-ci=? (string-ith (first d) 0) l)
                 1
                 0))]))

(starts-with# "e" AS-LIST) ; 1953
(starts-with# "z" AS-LIST) ; 61