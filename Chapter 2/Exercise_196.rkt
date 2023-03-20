;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise_196) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; A Letter-Count is a structure
(define-struct letter-count [letter count])
;   (make-letter-count Letter Number)
; interpretation shows how often each letter is used as the first one of a word in the given dictionary

; Dictionary -> List-of-Letter-Counts
; counts how often each letter is used as the first one of a word in the given dictionary
(check-expect (count-by-letter '())
              (list (make-letter-count "a" 0)
                    (make-letter-count "b" 0)
                    (make-letter-count "c" 0)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 0)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 0)))
(check-expect (count-by-letter (list "apple" "basket" "Bob" "tree"))
              (list (make-letter-count "a" 1)
                    (make-letter-count "b" 2)
                    (make-letter-count "c" 0)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 1)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 0)))
(define (count-by-letter d)
  (count-by-letter-internal LETTERS d))

; List-of-Letters Dictionary -> List-of-Letter-Counts
; counts how often each letter is used as the first one of a word in the given dictionary
(check-expect (count-by-letter-internal '() '()) '())
(check-expect (count-by-letter-internal (list "a") '()) (list (make-letter-count "a" 0)))
(check-expect (count-by-letter-internal (list "a" "b") '()) (list (make-letter-count "a" 0) (make-letter-count "b" 0)))
(check-expect (count-by-letter-internal '() (list "apple")) '())
(check-expect (count-by-letter-internal (list "a" "b") (list "apple" "basket" "Bob"))
              (list (make-letter-count "a" 1) (make-letter-count "b" 2)))
(check-expect (count-by-letter-internal (list "a" "b" "c") (list "apple" "basket" "Bob" "tree"))
              (list (make-letter-count "a" 1) (make-letter-count "b" 2) (make-letter-count "c" 0)))
(define (count-by-letter-internal letters d)
  (cond
    [(empty? letters) '()]
    [else (cons (make-letter-count (first letters) (starts-with# (first letters) d))
                (count-by-letter-internal (rest letters) d))]))

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